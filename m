Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2497420879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfAVPMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:12:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:58376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728744AbfAVPMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:12:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC82AB04E;
        Tue, 22 Jan 2019 15:12:03 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     thomas@winischhofer.net
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/4] tty: sisusb_con, convert addr macros to functions
Date:   Tue, 22 Jan 2019 16:11:59 +0100
Message-Id: <20190122151202.18152-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert SISUSB_VADDR and SISUSB_HADDR to inline functions. Now, there
are no more hidden accesses to local variables (vc_data and
sisusb_usb_data).

sisusb_haddr returns unsigned long from now on, not u16 *, as ulong is
what every caller expects -- we can remove some casts.

Call sites were aligned to be readable too.

Use sisusb_haddr on 4 more places in sisusbcon_blank and
sisusbcon_scroll. It was open coded there with [x, y] being [0, 0].

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/usb/misc/sisusbvga/sisusb_con.c | 78 ++++++++++++-------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index c4f017e1d17a..28faf566b8fb 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -356,15 +356,22 @@ sisusbcon_invert_region(struct vc_data *vc, u16 *p, int count)
 	}
 }
 
-#define SISUSB_VADDR(x,y) \
-	((u16 *)c->vc_origin + \
-	(y) * sisusb->sisusb_num_columns + \
-	(x))
+static inline void *sisusb_vaddr(const struct sisusb_usb_data *sisusb,
+		const struct vc_data *c, unsigned int x, unsigned int y)
+{
+	return (u16 *)c->vc_origin + y * sisusb->sisusb_num_columns + x;
+}
+
+static inline unsigned long sisusb_haddr(const struct sisusb_usb_data *sisusb,
+	      const struct vc_data *c, unsigned int x, unsigned int y)
+{
+	unsigned long offset = c->vc_origin - sisusb->scrbuf;
+
+	/* 2 bytes per each character */
+	offset += 2 * (y * sisusb->sisusb_num_columns + x);
 
-#define SISUSB_HADDR(x,y) \
-	((u16 *)(sisusb->vrambase + (c->vc_origin - sisusb->scrbuf)) + \
-	(y) * sisusb->sisusb_num_columns + \
-	(x))
+	return sisusb->vrambase + offset;
+}
 
 /* Interface routine */
 static void
@@ -382,9 +389,8 @@ sisusbcon_putc(struct vc_data *c, int ch, int y, int x)
 		return;
 	}
 
-
-	sisusb_copy_memory(sisusb, (char *)SISUSB_VADDR(x, y),
-				(long)SISUSB_HADDR(x, y), 2);
+	sisusb_copy_memory(sisusb, sisusb_vaddr(sisusb, c, x, y),
+				sisusb_haddr(sisusb, c, x, y), 2);
 
 	mutex_unlock(&sisusb->lock);
 }
@@ -408,7 +414,7 @@ sisusbcon_putcs(struct vc_data *c, const unsigned short *s,
 	 * because the vt does this AFTER calling us.
 	 */
 
-	dest = SISUSB_VADDR(x, y);
+	dest = sisusb_vaddr(sisusb, c, x, y);
 
 	for (i = count; i > 0; i--)
 		sisusbcon_writew(sisusbcon_readw(s++), dest++);
@@ -418,8 +424,8 @@ sisusbcon_putcs(struct vc_data *c, const unsigned short *s,
 		return;
 	}
 
-	sisusb_copy_memory(sisusb, (char *)SISUSB_VADDR(x, y),
-				(long)SISUSB_HADDR(x, y), count * 2);
+	sisusb_copy_memory(sisusb, sisusb_vaddr(sisusb, c, x, y),
+			sisusb_haddr(sisusb, c, x, y), count * 2);
 
 	mutex_unlock(&sisusb->lock);
 }
@@ -446,7 +452,7 @@ sisusbcon_clear(struct vc_data *c, int y, int x, int height, int width)
 	 * this AFTER calling us.
 	 */
 
-	dest = SISUSB_VADDR(x, y);
+	dest = sisusb_vaddr(sisusb, c, x, y);
 
 	cols = sisusb->sisusb_num_columns;
 
@@ -472,8 +478,8 @@ sisusbcon_clear(struct vc_data *c, int y, int x, int height, int width)
 	length = ((height * cols) - x - (cols - width - x)) * 2;
 
 
-	sisusb_copy_memory(sisusb, (unsigned char *)SISUSB_VADDR(x, y),
-				(long)SISUSB_HADDR(x, y), length);
+	sisusb_copy_memory(sisusb, sisusb_vaddr(sisusb, c, x, y),
+			sisusb_haddr(sisusb, c, x, y), length);
 
 	mutex_unlock(&sisusb->lock);
 }
@@ -520,9 +526,8 @@ sisusbcon_switch(struct vc_data *c)
 	sisusbcon_memcpyw((u16 *)c->vc_origin, (u16 *)c->vc_screenbuf,
 								length);
 
-	sisusb_copy_memory(sisusb, (unsigned char *)c->vc_origin,
-				(long)SISUSB_HADDR(0, 0),
-				length);
+	sisusb_copy_memory(sisusb, (char *)c->vc_origin,
+			sisusb_haddr(sisusb, c, 0, 0), length);
 
 	mutex_unlock(&sisusb->lock);
 
@@ -628,10 +633,8 @@ sisusbcon_blank(struct vc_data *c, int blank, int mode_switch)
 		sisusbcon_memsetw((u16 *)c->vc_origin,
 				c->vc_video_erase_char,
 				c->vc_screenbuf_size);
-		sisusb_copy_memory(sisusb,
-				(unsigned char *)c->vc_origin,
-				(u32)(sisusb->vrambase +
-					(c->vc_origin - sisusb->scrbuf)),
+		sisusb_copy_memory(sisusb, (char *)c->vc_origin,
+				sisusb_haddr(sisusb, c, 0, 0),
 				c->vc_screenbuf_size);
 		sisusb->con_blanked = 1;
 		ret = 1;
@@ -796,24 +799,24 @@ sisusbcon_scroll_area(struct vc_data *c, struct sisusb_usb_data *sisusb,
 	switch (dir) {
 
 		case SM_UP:
-			sisusbcon_memmovew(SISUSB_VADDR(0, t),
-					   SISUSB_VADDR(0, t + lines),
+			sisusbcon_memmovew(sisusb_vaddr(sisusb, c, 0, t),
+					   sisusb_vaddr(sisusb, c, 0, t + lines),
 					   (b - t - lines) * cols * 2);
-			sisusbcon_memsetw(SISUSB_VADDR(0, b - lines), eattr,
-					  lines * cols * 2);
+			sisusbcon_memsetw(sisusb_vaddr(sisusb, c, 0, b - lines),
+					eattr, lines * cols * 2);
 			break;
 
 		case SM_DOWN:
-			sisusbcon_memmovew(SISUSB_VADDR(0, t + lines),
-					   SISUSB_VADDR(0, t),
+			sisusbcon_memmovew(sisusb_vaddr(sisusb, c, 0, t + lines),
+					   sisusb_vaddr(sisusb, c, 0, t),
 					   (b - t - lines) * cols * 2);
-			sisusbcon_memsetw(SISUSB_VADDR(0, t), eattr,
+			sisusbcon_memsetw(sisusb_vaddr(sisusb, c, 0, t), eattr,
 					  lines * cols * 2);
 			break;
 	}
 
-	sisusb_copy_memory(sisusb, (char *)SISUSB_VADDR(0, t),
-				(long)SISUSB_HADDR(0, t), length);
+	sisusb_copy_memory(sisusb, sisusb_vaddr(sisusb, c, 0, t),
+			sisusb_haddr(sisusb, c, 0, t), length);
 
 	mutex_unlock(&sisusb->lock);
 
@@ -830,7 +833,6 @@ sisusbcon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 	int copyall = 0;
 	unsigned long oldorigin;
 	unsigned int delta = lines * c->vc_size_row;
-	u32 originoffset;
 
 	/* Returning != 0 means we have done the scrolling successfully.
 	 * Returning 0 makes vt do the scrolling on its own.
@@ -913,23 +915,21 @@ sisusbcon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 		break;
 	}
 
-	originoffset = (u32)(c->vc_origin - sisusb->scrbuf);
-
 	if (copyall)
 		sisusb_copy_memory(sisusb,
 			(char *)c->vc_origin,
-			(u32)(sisusb->vrambase + originoffset),
+			sisusb_haddr(sisusb, c, 0, 0),
 			c->vc_screenbuf_size);
 	else if (dir == SM_UP)
 		sisusb_copy_memory(sisusb,
 			(char *)c->vc_origin + c->vc_screenbuf_size - delta,
-			(u32)sisusb->vrambase + originoffset +
+			sisusb_haddr(sisusb, c, 0, 0) +
 					c->vc_screenbuf_size - delta,
 			delta);
 	else
 		sisusb_copy_memory(sisusb,
 			(char *)c->vc_origin,
-			(u32)(sisusb->vrambase + originoffset),
+			sisusb_haddr(sisusb, c, 0, 0),
 			delta);
 
 	c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
-- 
2.20.1

