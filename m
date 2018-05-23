Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932832AbeEWLyy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:54:54 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:40341 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932485AbeEWLyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:54:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DXAAAKVgVb/49dJa1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYMVL4FfMoNtiASMY4F5gQ+TN4F4C4RsGYIOITQYAQIBAQE?=
 =?us-ascii?q?BAQECbCiFKAEBAQMBIxFFEAIBCBoCJgICAjAVEAIEDg2FEwiqN4IciEOBfIE?=
 =?us-ascii?q?Jhy2BVD+EHIRfgxSCVAKYWgkCiD6GEY0JkFgCERMBgSQBHDiBUnAVgn+CHxc?=
 =?us-ascii?q?RjgaMBIEtgRgBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,432,1520899200";
   d="scan'208";a="118215193"
From: "Jon Rosen (jrosen)" <jrosen@cisco.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
        David Windsor <dwindsor@gmail.com>,
        "Rosen, Rami" <rami.rosen@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Mike Maloney" <maloney@google.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
Thread-Topic: [PATCH v2] packet: track ring entry use using a shadow ring to
 prevent RX ring overrun
Thread-Index: AQHT72oCSQesQH+wcU+iC1K5zWLMg6Q5fnUAgAAIkQCAAJ/kcIADDMuw
Date: Wed, 23 May 2018 11:54:50 +0000
Message-ID: <9cbf19b5765746b88af6dadc71b99d78@XCH-RTP-016.cisco.com>
References: <1526731655-10087-1-git-send-email-jrosen@cisco.com>
 <CAF=yD-+kjceErK=CApiu1oY9uTjVWG2qeX=NkGVYufVVC_L2PA@mail.gmail.com>
 <CAF=yD-KvTyTibhqpKP79Obfk8KRVDLMyb6THNwNgrJzs47bAtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.117.112.181]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4NBt04N026029

> > For the ring, there is no requirement to allocate exactly the amount
> > specified by the user request. Safer than relying on shared memory
> > and simpler than the extra allocation in this patch would be to allocate
> > extra shadow memory at the end of the ring (and not mmap that).
> >
> > That still leaves an extra cold cacheline vs using tp_padding.
> 
> Given my lack of experience and knowledge in writing kernel code
> it was easier for me to allocate the shadow ring as a separate
> structure.  Of course it's not about me and my skills so if it's
> more appropriate to allocate at the tail of the existing ring
> then certainly I can look at doing that.

The memory for the ring is not one contiguous block, it's an array of
blocks of pages (or 'order' sized blocks of pages). I don't think
increasing the size of each of the blocks to provided storage would be
such a good idea as it will risk spilling over into the next order and
wasting lots of memory. I suspect it's also more complex than a single
shadow ring to do both the allocation and the access.

It could be tacked onto the end of the pg_vec[] used to store the
pointers to the blocks. The challenge with that is that a pg_vec[] is
created for each of RX and TX rings so either it would have to
allocate unnecessary storage for TX or the caller will have to say if
extra space should be allocated or not.  E.g.:

static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, int scratch, void **scratch_p)

I'm not sure avoiding the extra allocation and moving it to the
pg_vec[] for the RX ring is going to get the simplification you were
hoping for.  Is there another way of storing the shadow ring which
I should consider?
