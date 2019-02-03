Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD02AC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAD52082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfBCO1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:27:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55562 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730131AbfBCOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:48 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdb-0006MC-1b; Sun, 03 Feb 2019 14:20:47 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9q-0007Nb-BP; Sun, 03 Feb 2019 14:50:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Young Xiao" <YangX92@hotmail.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.746785476@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 261/305] staging: rtl8712: Fix possible buffer overrun
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Young Xiao <YangX92@hotmail.com>

commit 300cd664865bed5d50ae0a42fb4e3a6f415e8a10 upstream.

In commit 8b7a13c3f404 ("staging: r8712u: Fix possible buffer
overrun") we fix a potential off by one by making the limit smaller.
The better fix is to make the buffer larger.  This makes it match up
with the similar code in other drivers.

Fixes: 8b7a13c3f404 ("staging: r8712u: Fix possible buffer overrun")
Signed-off-by: Young Xiao <YangX92@hotmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/rtl8712/mlme_linux.c   | 2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -153,7 +153,7 @@ void r8712_report_sec_ie(struct _adapter
 		p = buff;
 		p += sprintf(p, "ASSOCINFO(ReqIEs=");
 		len = sec_ie[1] + 2;
-		len =  (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX - 1;
+		len =  (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
 		for (i = 0; i < len; i++)
 			p += sprintf(p, "%02x", sec_ie[i]);
 		p += sprintf(p, ")");
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1373,7 +1373,7 @@ sint r8712_restruct_sec_ie(struct _adapt
 		     u8 *out_ie, uint in_len)
 {
 	u8 authmode = 0, securitytype, match;
-	u8 sec_ie[255], uncst_oui[4], bkup_ie[255];
+	u8 sec_ie[IW_CUSTOM_MAX], uncst_oui[4], bkup_ie[255];
 	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
 	uint ielength, cnt, remove_cnt;
 	int iEntry;

