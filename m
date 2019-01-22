Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465D3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B60B20855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfAVPMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:12:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:58408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729037AbfAVPMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:12:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5242B050;
        Tue, 22 Jan 2019 15:12:05 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     thomas@winischhofer.net
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/4] sisusb: remove useless macros and compact the code
Date:   Tue, 22 Jan 2019 16:12:02 +0100
Message-Id: <20190122151202.18152-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151202.18152-1-jslaby@suse.cz>
References: <20190122151202.18152-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove macros which are only wrappers around standard operations. When
we expand them into code, we see that sisusbcon_memsetw can simply use
memset16 and sisusbcon_putcs can just call memcpy. So make the code
compact.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/usb/misc/sisusbvga/sisusb_con.c | 48 ++++++++-----------------
 1 file changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 8e6d1b02e7c2..cd0155310fea 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -70,11 +70,6 @@
 #include "sisusb.h"
 #include "sisusb_init.h"
 
-#define sisusbcon_writew(val, addr)	(*(addr) = (val))
-#define sisusbcon_readw(addr)		(*(addr))
-#define sisusbcon_memmovew(d, s, c)	memmove(d, s, c)
-#define sisusbcon_memcpyw(d, s, c)	memcpy(d, s, c)
-
 /* vc_data -> sisusb conversion table */
 static struct sisusb_usb_data *mysisusbs[MAX_NR_CONSOLES];
 
@@ -84,9 +79,7 @@ static const struct consw sisusb_con;
 static inline void
 sisusbcon_memsetw(u16 *s, u16 c, unsigned int count)
 {
-	count /= 2;
-	while (count--)
-		sisusbcon_writew(c, s++);
+	memset16(s, c, count / 2);
 }
 
 static inline void
@@ -344,13 +337,11 @@ sisusbcon_invert_region(struct vc_data *vc, u16 *p, int count)
 	 */
 
 	while (count--) {
-		u16 a = sisusbcon_readw(p);
-
-		a = ((a) & 0x88ff)        |
-		    (((a) & 0x7000) >> 4) |
-		    (((a) & 0x0700) << 4);
+		u16 a = *p;
 
-		sisusbcon_writew(a, p++);
+		*p++ = ((a) & 0x88ff)        |
+		       (((a) & 0x7000) >> 4) |
+		       (((a) & 0x0700) << 4);
 	}
 }
 
@@ -399,8 +390,6 @@ sisusbcon_putcs(struct vc_data *c, const unsigned short *s,
 		         int count, int y, int x)
 {
 	struct sisusb_usb_data *sisusb;
-	u16 *dest;
-	int i;
 
 	sisusb = sisusb_get_sisusb_lock_and_check(c->vc_num);
 	if (!sisusb)
@@ -412,10 +401,7 @@ sisusbcon_putcs(struct vc_data *c, const unsigned short *s,
 	 * because the vt does this AFTER calling us.
 	 */
 
-	dest = sisusb_vaddr(sisusb, c, x, y);
-
-	for (i = count; i > 0; i--)
-		sisusbcon_writew(sisusbcon_readw(s++), dest++);
+	memcpy(sisusb_vaddr(sisusb, c, x, y), s, count * 2);
 
 	if (sisusb_is_inactive(c, sisusb)) {
 		mutex_unlock(&sisusb->lock);
@@ -521,8 +507,7 @@ sisusbcon_switch(struct vc_data *c)
 			(int)(sisusb->scrbuf + sisusb->scrbuf_size - c->vc_origin));
 
 	/* Restore the screen contents */
-	sisusbcon_memcpyw((u16 *)c->vc_origin, (u16 *)c->vc_screenbuf,
-								length);
+	memcpy((u16 *)c->vc_origin, (u16 *)c->vc_screenbuf, length);
 
 	sisusb_copy_memory(sisusb, (char *)c->vc_origin,
 			sisusb_haddr(sisusb, c, 0, 0), length);
@@ -559,8 +544,7 @@ sisusbcon_save_screen(struct vc_data *c)
 			(int)(sisusb->scrbuf + sisusb->scrbuf_size - c->vc_origin));
 
 	/* Save the screen contents to vc's private buffer */
-	sisusbcon_memcpyw((u16 *)c->vc_screenbuf, (u16 *)c->vc_origin,
-								length);
+	memcpy((u16 *)c->vc_screenbuf, (u16 *)c->vc_origin, length);
 
 	mutex_unlock(&sisusb->lock);
 }
@@ -797,7 +781,7 @@ sisusbcon_scroll_area(struct vc_data *c, struct sisusb_usb_data *sisusb,
 	switch (dir) {
 
 		case SM_UP:
-			sisusbcon_memmovew(sisusb_vaddr(sisusb, c, 0, t),
+			memmove(sisusb_vaddr(sisusb, c, 0, t),
 					   sisusb_vaddr(sisusb, c, 0, t + lines),
 					   (b - t - lines) * cols * 2);
 			sisusbcon_memsetw(sisusb_vaddr(sisusb, c, 0, b - lines),
@@ -805,7 +789,7 @@ sisusbcon_scroll_area(struct vc_data *c, struct sisusb_usb_data *sisusb,
 			break;
 
 		case SM_DOWN:
-			sisusbcon_memmovew(sisusb_vaddr(sisusb, c, 0, t + lines),
+			memmove(sisusb_vaddr(sisusb, c, 0, t + lines),
 					   sisusb_vaddr(sisusb, c, 0, t),
 					   (b - t - lines) * cols * 2);
 			sisusbcon_memsetw(sisusb_vaddr(sisusb, c, 0, t), eattr,
@@ -874,7 +858,7 @@ sisusbcon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 
 		if (c->vc_scr_end + delta >=
 				sisusb->scrbuf + sisusb->scrbuf_size) {
-			sisusbcon_memcpyw((u16 *)sisusb->scrbuf,
+			memcpy((u16 *)sisusb->scrbuf,
 					  (u16 *)(oldorigin + delta),
 					  c->vc_screenbuf_size - delta);
 			c->vc_origin = sisusb->scrbuf;
@@ -892,12 +876,10 @@ sisusbcon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 	case SM_DOWN:
 
 		if (oldorigin - delta < sisusb->scrbuf) {
-			sisusbcon_memmovew((u16 *)(sisusb->scrbuf +
-							sisusb->scrbuf_size -
-							c->vc_screenbuf_size +
-							delta),
-					   (u16 *)oldorigin,
-					   c->vc_screenbuf_size - delta);
+			memmove((void *)sisusb->scrbuf + sisusb->scrbuf_size -
+					c->vc_screenbuf_size + delta,
+					(u16 *)oldorigin,
+					c->vc_screenbuf_size - delta);
 			c->vc_origin = sisusb->scrbuf +
 					sisusb->scrbuf_size -
 					c->vc_screenbuf_size;
-- 
2.20.1

