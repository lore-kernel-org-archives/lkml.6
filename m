Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE2C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0E02087B
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547977931;
	bh=4aWYzgsxH3YV9mtnItmg3G5GFItXEqZINtPgJ1iGgt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NkiOpWXu4pr6Jg4/yJjgBGxynHEu5ZefYghTTEy1L08VsJ3snLP/RxpccVHpluPp2
	 6tkKzkHsR0JhTP2jQ2mKCaMVV6i0sNn6hqmVG6d/yRJ3jnh9TAXBQUjWoXWWxIuAn0
	 FIV0bT7OhkEf3dulJ7SjbpnrjSWB1otPFQ0e4Oas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfATJwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 04:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfATJwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 04:52:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD552085B;
        Sun, 20 Jan 2019 09:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547977928;
        bh=4aWYzgsxH3YV9mtnItmg3G5GFItXEqZINtPgJ1iGgt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hk8UDNveEriV8XSqcRY1QKuvH07K3Dd/DwATAXZky7oGucw0oaPLBodjhUM4Cl5Oj
         CdVAAmeKGl5pAZMHkKv9V/+BJmTwkv7SMJW1cWAyQT/nWJODpqldg2xSYTm3cdGI44
         GDvEA+GUylTDXCk5IVDEHBay1rgtsJaoGJ7sQfeY=
Date:   Sun, 20 Jan 2019 10:52:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [BUG] tiocsti() NULL dereference if ld->ops->receive_buf==NULL
Message-ID: <20190120095205.GB28267@kroah.com>
References: <CAG48ez06mDExELyTYN7MZQ3FjGcLx9ASc5HnxW8NQbfTAPX=Qg@mail.gmail.com>
 <20190119091108.GF10836@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119091108.GF10836@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 10:11:08AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 18, 2019 at 08:09:07PM +0100, Jann Horn wrote:
> > Hi!
> > 
> > When a line discipline doesn't have a ->receive_buf handler, tiocsti()
> > attempts to call a NULL pointer. Both tty_n_tracesink and
> > spk_ttyio_ldisc_ops don't have such a handler.
> > 
> > To reproduce, build a kernel with CONFIG_SPEAKUP=y and
> > CONFIG_SPEAKUP_SYNTH_SOFT=y, set speakup.synth=soft in the kernel
> > command line, and run the following code as root:
> 
> <snip>
> 
> Ugh, thanks for finding this.  I'll look at it later this afternoon...

It looks to be a simple change.  We can't really "fail" this ioctl if
there's nothing wrong with the structure of the call, so we can just
quietly "eat" the character, given that the line discipline doesn't care
about it.

So, any objections to the patch below?

thanks,

greg k-h

-----------------

Subject: [PATCH] tty: Handle problem if line discipline does not have receive_buf

Some tty line disciplines do not have a receive buf callback, so
properly check for that before calling it.  If they do not have this
callback, just eat the character quietly, as we can't fail this call.

Reported-by: Jann Horn <jannh@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 23c6fd238422..21ffcce16927 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2189,7 +2189,8 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
 		return -EIO;
-	ld->ops->receive_buf(tty, &ch, &mbz, 1);
+	if (ld->ops->receive_buf)
+		ld->ops->receive_buf(tty, &ch, &mbz, 1);
 	tty_ldisc_deref(ld);
 	return 0;
 }
-- 
2.20.1

