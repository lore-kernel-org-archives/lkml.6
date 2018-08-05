Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD5CC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CDD218D7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHU7NKOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30CDD218D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeHEVLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 17:11:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42284 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeHEVLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 17:11:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so10270591wrs.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yDpcNrzd3bIdRHtMLKWH12x556X3QclGSR/SBsoypRs=;
        b=HHU7NKOpTgdFHu0Ury4653awaKe7dXyw0FzEz0XkPOT9QLUkyj8WZwEmN1V61swtxl
         ozzcYt79c7ldQimr3CQdQhw3XPCy0eciL7QBfu5kUS38N+qjWofi4zKi2J02z0lwyk6f
         J1SP2sMSWXodLoJeZt8RFaJyaEvSpUjmJR/jQtu3iI4NK6ITStfocp/EoOzRUmaGLbjM
         RShS0iUCPESrptgZvkqoQ4FQhjUFdAv4TFkcg4I62ejeLrltfQ/Lp7In1SMxOjR4Ng6u
         iikb2SrUXBofXIuRvjAY5+tZKVrpodgrTAiivXw2LAQYg9yprdZzfWVHnRdZ4XICdvdQ
         8yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yDpcNrzd3bIdRHtMLKWH12x556X3QclGSR/SBsoypRs=;
        b=VTz43nZHCb48CzWebGg9Mw70YnW05EdEtpeG1WO5fZKZcN3Op/+ZXDqNYT26f2yw59
         YwKixk1n/jLFEQJ6Wte8s2JDOPMCOUdqnJ3KORBccEzfFmXMBYTPuFzi/sEs7wbmMFE5
         7RrSpdUwFC1HyimLUiEzCfYQHhP0QI+8NU08VgXrdTWmrgKwmX1HadOpyuQFp44Wc/b6
         HgafR6iCMcKI+tOd8Vrjn7F2dXbSKgVpUMM/kFvP5H27IH5dRiDfwH2BZpsJG3mOlOBp
         m2BM0YIS8w+xcXYIoDueyvlb8pKHOiKY/ehPTCf0tAxN7Po8r3+Y5gbYeib9gVdig3Zw
         V2TA==
X-Gm-Message-State: AOUpUlG9BmUTilO+PoFD/ZVxJavjr+aQi2q/H5ksPOLk5BEYVfqTK0jF
        wdd61eMMxhXyGD3hR6SOPIq/9X1s
X-Google-Smtp-Source: AAOMgpckSLnoO4bEdt/RZLeoP7Z5ouqyvcM9aAmc4RjgMBiWd3aeQ4YwnRlqxKs+3VRULwmzJ7RVgQ==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr7109537wro.263.1533495928601;
        Sun, 05 Aug 2018 12:05:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id g125-v6sm4500884wmf.16.2018.08.05.12.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 12:05:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/6] staging: rtl8188eu: use is_multicast_ether_addr in rtl8188eu_xmit.c
Date:   Sun,  5 Aug 2018 21:05:12 +0200
Message-Id: <20180805190516.2133-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180805190516.2133-1-straube.linux@gmail.com>
References: <20180805190516.2133-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST in
hal/rtl8188eu_xmit.c.

There is only one use, so remove the extra variable for the
result of IS_MCAST.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
index 14622eee56ca..82fc5075e0a6 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c
@@ -167,7 +167,6 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	struct tx_desc	*ptxdesc = (struct tx_desc *)pmem;
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	int	bmcst = IS_MCAST(pattrib->ra);
 
 	if (adapt->registrypriv.mp_mode == 0) {
 		if ((!bagg_pkt) && (urb_zero_packet_chk(adapt, sz) == 0)) {
@@ -186,7 +185,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 
 	ptxdesc->txdw0 |= cpu_to_le32(((offset) << OFFSET_SHT) & 0x00ff0000);/* 32 bytes for TX Desc */
 
-	if (bmcst)
+	if (is_multicast_ether_addr(pattrib->ra))
 		ptxdesc->txdw0 |= cpu_to_le32(BMC);
 
 	if (adapt->registrypriv.mp_mode == 0) {
-- 
2.18.0

