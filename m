Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B267C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4B62192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 04:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfBQEWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 23:22:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55254 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfBQEWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 23:22:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gvDxx-0000Dt-7e; Sun, 17 Feb 2019 04:22:12 +0000
Date:   Sun, 17 Feb 2019 04:22:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arthur Gautier <baloo@gandi.net>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Message-ID: <20190217042201.GU2217@ZenIV.linux.org.uk>
References: <20190215235901.23541-1-baloo@gandi.net>
 <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
 <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
 <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net>
 <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190217034121.bs3q3sgevexmdt3d@khany>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 03:41:21AM +0000, Arthur Gautier wrote:
> On Sat, Feb 16, 2019 at 11:47:02PM +0000, Al Viro wrote:
> > On Sat, Feb 16, 2019 at 02:50:15PM -0800, Andy Lutomirski wrote:
> > 
> > > What is the actual problem?  We’re not actually demand-faulting this data, are we?  Are we just overrunning the buffer because the from_user helpers are too clever?  Can we fix it for real by having the fancy helpers do *aligned* loads so that they don’t overrun the buffer?  Heck, this might be faster, too.
> > 
> > Unaligned _stores_ are not any cheaper, and you'd get one hell of
> > extra arithmetics from trying to avoid both.  Check something
> > like e.g. memcpy() on alpha, where you really have to keep all
> > accesses aligned, both on load and on store side.
> > 
> > Can't we just pad the buffers a bit?  Making sure that name_buf
> > and symlink_buf are _not_ followed by unmapped pages shouldn't
> > be hard.  Both are allocated by kmalloc(), so...
> 
> We cannot change alignment rules here. The input buffer string we're
> reading is coming from an cpio formated file and the format is
> defined by cpio(5).
> Nothing much we can do there I'm afraid. Input buffer is defined to
> be 4-byte aligned.

Who says anything about changing the format of the file?  At least
one trivial way to handle that would be this:

diff --git a/init/initramfs.c b/init/initramfs.c
index 7cea802d00ef..edbddfb73106 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -265,8 +265,12 @@ static int __init do_header(void)
 		state = Collect;
 		return 0;
 	}
-	if (S_ISREG(mode) || !body_len)
-		read_into(name_buf, N_ALIGN(name_len), GotName);
+	if (S_ISREG(mode) || !body_len) {
+		collect = collected = name_buf;
+		remains = N_ALIGN(name_len);
+		next_state = GotName;
+		state = Collect;
+	}
 	return 0;
 }
 
Another would be to have the buffer passed to flush_buffer() (i.e.
the callback of decompress_fn) allocated with 4 bytes of padding
past the part where the unpacked piece of data is placed for the
callback to find.  As in,

diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
index 63b4b7eee138..ca3f7ecc9b35 100644
--- a/lib/decompress_inflate.c
+++ b/lib/decompress_inflate.c
@@ -48,7 +48,7 @@ STATIC int INIT __gunzip(unsigned char *buf, long len,
 	rc = -1;
 	if (flush) {
 		out_len = 0x8000; /* 32 K */
-		out_buf = malloc(out_len);
+		out_buf = malloc(out_len + 4);
 	} else {
 		if (!out_len)
 			out_len = ((size_t)~0) - (size_t)out_buf; /* no limit */

for gunzip/decompress and similar ones for bzip2, etc.  The contents
layout doesn't have anything to do with that...
