Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeEWNiL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:38:11 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34476 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933156AbeEWNiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:38:05 -0400
X-Google-Smtp-Source: AB8JxZpPjfmZBvhl1pRArTiz6jaUv7ezgHF/FqJ64EzT88FmNiEv1uZ9adBB47IKELvNl4+I0j8uMFmWPftIge/pzaA=
MIME-Version: 1.0
In-Reply-To: <9cbf19b5765746b88af6dadc71b99d78@XCH-RTP-016.cisco.com>
References: <1526731655-10087-1-git-send-email-jrosen@cisco.com>
 <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
 <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com> <9cbf19b5765746b88af6dadc71b99d78@XCH-RTP-016.cisco.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 23 May 2018 09:37:23 -0400
Message-ID: <CAF=yD-LpGOTx_jrh10G59M4Y-vpdtx_q5SG1Hjc7452y9KUt4w@mail.gmail.com>
Subject: Re: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
To: "Jon Rosen (jrosen)" <jrosen@cisco.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Mike Maloney <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 7:54 AM, Jon Rosen (jrosen) <jrosen@cisco.com> wrote:
>> > For the ring, there is no requirement to allocate exactly the amount
>> > specified by the user request. Safer than relying on shared memory
>> > and simpler than the extra allocation in this patch would be to allocate
>> > extra shadow memory at the end of the ring (and not mmap that).
>> >
>> > That still leaves an extra cold cacheline vs using tp_padding.
>>
>> Given my lack of experience and knowledge in writing kernel code
>> it was easier for me to allocate the shadow ring as a separate
>> structure.  Of course it's not about me and my skills so if it's
>> more appropriate to allocate at the tail of the existing ring
>> then certainly I can look at doing that.
>
> The memory for the ring is not one contiguous block, it's an array of
> blocks of pages (or 'order' sized blocks of pages). I don't think
> increasing the size of each of the blocks to provided storage would be
> such a good idea as it will risk spilling over into the next order and
> wasting lots of memory. I suspect it's also more complex than a single
> shadow ring to do both the allocation and the access.
>
> It could be tacked onto the end of the pg_vec[] used to store the
> pointers to the blocks. The challenge with that is that a pg_vec[] is
> created for each of RX and TX rings so either it would have to
> allocate unnecessary storage for TX or the caller will have to say if
> extra space should be allocated or not.  E.g.:
>
> static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, int scratch, void **scratch_p)
>
> I'm not sure avoiding the extra allocation and moving it to the
> pg_vec[] for the RX ring is going to get the simplification you were
> hoping for.  Is there another way of storing the shadow ring which
> I should consider?

I did indeed mean attaching extra pages to pg_vec[]. It should be
simpler than a separate structure, but I may be wrong.

Either way, I still would prefer to avoid the shadow buffer completely.
It incurs complexity and cycle cost on all users because of only the
rare (non-existent?) consumer that overwrites the padding bytes.

Perhaps we can use padding yet avoid deadlock by writing a
timed value. The simplest would be jiffies >> N. Then only a
process that writes this exact value would be subject to drops and
then still only for a limited period.

Instead of depending on wall clock time, like jiffies, another option
would be to keep a percpu array of values. Each cpu has a zero
entry if it is not writing, nonzero if it is. If a writer encounters a
number in padding that is > num_cpus, then the state is garbage
from userspace. If <= num_cpus, it is adhered to only until that cpu
clears its entry, which is guaranteed to happen eventually.

Just a quick thought. This might not fly at all upon closer scrutiny.
