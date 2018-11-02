Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61531C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170C82081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170C82081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeKCC3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeKCC3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B47CA3154841;
        Fri,  2 Nov 2018 17:21:12 +0000 (UTC)
Received: from redhat.com (ovpn-124-238.rdu2.redhat.com [10.10.124.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id 007DF5DA62;
        Fri,  2 Nov 2018 17:21:06 +0000 (UTC)
Date:   Fri, 2 Nov 2018 13:21:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mark.rutland@arm.com, Kees Cook <keescook@chromium.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com,
        jasowang@redhat.com
Subject: Re: [PULL] vhost: cleanups and fixes
Message-ID: <20181102131334-mutt-send-email-mst@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
 <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
 <20181102083018-mutt-send-email-mst@kernel.org>
 <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
 <20181102122937-mutt-send-email-mst@kernel.org>
 <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 02 Nov 2018 17:21:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:10:45AM -0700, Linus Torvalds wrote:
> On Fri, Nov 2, 2018 at 9:59 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Just for completeness I'd like to point out for vhost the copies are
> > done from the kernel thread.  So yes we can switch to copy_to/from_user
> > but for e.g. 32-bit userspace running on top of a 64 bit kernel it is
> > IIUC not sufficient - we must *also* do access_ok checks on control path
> > when addresses are passed to the kernel and when current points to the
> > correct task struct.
> 
> Don't you take over the VM with "use_mm()" when you do the copies?

Yes we do.

> So
> yes, it's a kernel thread, but it has a user VM, and though that
> should have the user limits.
> 
> No?
> 
>           Linus

Here's what I meant: we have

#define access_ok(type, addr, size)                                     \
({                                                                      \
        WARN_ON_IN_IRQ();                                               \
        likely(!__range_not_ok(addr, size, user_addr_max()));           \
})

and

#define user_addr_max() (current->thread.addr_limit.seg)

it seems that it depends on current not on the active mm.

get_user and friends are similar:

ENTRY(__get_user_1)
        mov PER_CPU_VAR(current_task), %_ASM_DX
        cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
        jae bad_get_user
        sbb %_ASM_DX, %_ASM_DX          /* array_index_mask_nospec() */
        and %_ASM_DX, %_ASM_AX
        ASM_STAC
1:      movzbl (%_ASM_AX),%edx
        xor %eax,%eax
        ASM_CLAC
        ret
ENDPROC(__get_user_1)
EXPORT_SYMBOL(__get_user_1)

-- 
MST
