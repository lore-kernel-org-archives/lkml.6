Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5E6C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D4520842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfBYR2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:28:20 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.56]:47806 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728400AbfBYR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:28:20 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 0E2FBD76F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:28:19 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id yK38g7SFF2qH7yK39gd6wI; Mon, 25 Feb 2019 11:28:19 -0600
X-Authority-Reason: nr=8
Received: from [189.250.127.169] (port=58560 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gyK35-002h2m-VV; Mon, 25 Feb 2019 11:28:16 -0600
Date:   Mon, 25 Feb 2019 11:28:14 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] tty: n_gsm: Mark expected switch fall-throughs
Message-ID: <20190225172814.GA18432@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.169
X-Source-L: No
X-Exim-ID: 1gyK35-002h2m-VV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.169]:58560
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/tty/n_gsm.c: In function ‘gsm_dlci_data’:
drivers/tty/n_gsm.c:1582:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (tty) {
      ^
drivers/tty/n_gsm.c:1587:2: note: here
  case 1:
  ^~~~
drivers/tty/n_gsm.c: In function ‘gsm1_receive’:
  CC [M]  drivers/scsi/snic/snic_disc.o
  CC [M]  drivers/net/wireless/realtek/rtlwifi/pci.o
  CC      drivers/usb/early/xhci-dbc.o
drivers/tty/n_gsm.c:1981:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
   gsm->fcs = INIT_FCS;
            ^
drivers/tty/n_gsm.c:1983:2: note: here
  case GSM_ADDRESS: /* Address continuation */
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/tty/n_gsm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d9662848a297..c4e16b31f9ab 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1565,14 +1565,11 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 		pr_debug("%d bytes for tty\n", len);
 	switch (dlci->adaption)  {
 	/* Unsupported types */
-	/* Packetised interruptible data */
-	case 4:
+	case 4:		/* Packetised interruptible data */
 		break;
-	/* Packetised uininterruptible voice/data */
-	case 3:
+	case 3:		/* Packetised uininterruptible voice/data */
 		break;
-	/* Asynchronous serial with line state in each frame */
-	case 2:
+	case 2:		/* Asynchronous serial with line state in each frame */
 		while (gsm_read_ea(&modem, *data++) == 0) {
 			len--;
 			if (len == 0)
@@ -1583,8 +1580,8 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 			gsm_process_modem(tty, dlci, modem, clen);
 			tty_kref_put(tty);
 		}
-	/* Line state will go via DLCI 0 controls only */
-	case 1:
+		/* Fall through */
+	case 1:		/* Line state will go via DLCI 0 controls only */
 	default:
 		tty_insert_flip_string(port, data, len);
 		tty_flip_buffer_push(port);
@@ -1979,7 +1976,7 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 		gsm->address = 0;
 		gsm->state = GSM_ADDRESS;
 		gsm->fcs = INIT_FCS;
-		/* Drop through */
+		/* Fall through */
 	case GSM_ADDRESS:	/* Address continuation */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
-- 
2.20.1

