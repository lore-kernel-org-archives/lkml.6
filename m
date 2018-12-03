Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AB6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A0A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A0A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbeLCGWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:22:02 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:8288 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbeLCGWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:22:02 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id EEC02247E69156DC34F0;
        Mon,  3 Dec 2018 14:21:55 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB36LnJ0033684;
        Mon, 3 Dec 2018 14:21:49 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120314215533-14385734 ;
          Mon, 3 Dec 2018 14:21:55 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Bernie Thompson <bernie@plugable.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] udlfb: fix potential NULL pointer dereference in dlfb_usb_probe
Date:   Mon, 3 Dec 2018 14:21:25 +0800
Message-Id: <20181203062125.34880-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-03 14:21:55,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-03 14:21:49
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB36LnJ0033684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a possible null pointer dereference in
dlfb=5Fusb=5Fprobe, detected by the semantic patch deref=5Fnull.cocci,
with the following warning:

drivers/video/fbdev/udlfb.c:1704:11-15: ERROR: dlfb is NULL but dereference=
d.

The following code has potential null pointer references:
1597         /* usb initialization */
1598         dlfb =3D kzalloc(sizeof(*dlfb), GFP=5FKERNEL);
1599         if (!dlfb) {
...
1601             goto error;
1602         }
...
1703 error:
1704         if (dlfb->info) {
1705                 dlfb=5Fops=5Fdestroy(dlfb->info);
1706         } else if (dlfb) {
1707                 usb=5Fput=5Fdev(dlfb->udev);
1708                 kfree(dlfb);
1709         }

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Bernie Thompson <bernie@plugable.com>
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC: linux-fbdev@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: linux-kernel@vger.kernel.org
---
 drivers/video/fbdev/udlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 070026a7e55a..df37cfaa2362 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1701,7 +1701,7 @@ static int dlfb=5Fusb=5Fprobe(struct usb=5Finterface =
*intf,
 	return 0;
=20
 error:
-	if (dlfb->info) {
+	if (dlfb && dlfb->info) {
 		dlfb=5Fops=5Fdestroy(dlfb->info);
 	} else if (dlfb) {
 		usb=5Fput=5Fdev(dlfb->udev);
--=20
2.19.1

