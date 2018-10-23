Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9FEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6762075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6762075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeJWXwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbeJWXwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:52:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09DD9307C941;
        Tue, 23 Oct 2018 15:28:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBC90604CC;
        Tue, 23 Oct 2018 15:28:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w9NFSTIq021328;
        Tue, 23 Oct 2018 11:28:29 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w9NFSS7J021324;
        Tue, 23 Oct 2018 11:28:28 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 23 Oct 2018 11:28:28 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
cc:     Dave Mielke <Dave@mielke.cc>, Adam Borowski <kilobyte@angband.pl>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] vt: fix broken display when running aptitude
Message-ID: <alpine.LRH.2.02.1810231126100.20699@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 23 Oct 2018 15:28:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you run aptitude on framebuffer console, the display is corrupted. The 
corruption is caused by the commit d8ae7242. The patch adds "offset" to 
"start" when calling scr_memsetw, but it forgets to do the same addition 
on a subsequent call to do_update_region.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: d8ae72427187 ("vt: preserve unicode values corresponding to screen characters")
Cc: stable@vger.kernel.org	# 4.19

---
 drivers/tty/vt/vt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/tty/vt/vt.c
===================================================================
--- linux-2.6.orig/drivers/tty/vt/vt.c	2018-10-23 16:15:08.000000000 +0200
+++ linux-2.6/drivers/tty/vt/vt.c	2018-10-23 16:29:20.000000000 +0200
@@ -1551,7 +1551,7 @@ static void csi_K(struct vc_data *vc, in
 	scr_memsetw(start + offset, vc->vc_video_erase_char, 2 * count);
 	vc->vc_need_wrap = 0;
 	if (con_should_update(vc))
-		do_update_region(vc, (unsigned long) start, count);
+		do_update_region(vc, (unsigned long)(start + offset), count);
 }
 
 static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar positions */
