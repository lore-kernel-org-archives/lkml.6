Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C287FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5902075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bhGuliJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5902075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbeKVL3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:29:39 -0500
Received: from m12-17.163.com ([220.181.12.17]:51034 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbeKVL3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=akRecIb2Nt5PB9XUGz
        rQgjz6hGCO9LX8e6BLtxJ2jlw=; b=bhGuliJv8kExCRX4PBSLgiscvp1pPxQs7o
        OL5SHEajcL4n2mbu3YcWHoYdpruCV/5RwAp7k3UIZi90lfc2CQf2alckVOgyjqVH
        mUCihU0vbyamTpUxhqAdjiaMaRKtOJE6CJfArOyn46Ya9+Y56haPTcLqyKArfFd0
        lNFe0Eueo=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp13 (Coremail) with SMTP id EcCowACXPnfO_fVbSPFVBA--.3905S3;
        Thu, 22 Nov 2018 08:52:34 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: intel-ish-hid: fixes incorrect error handling
Date:   Thu, 22 Nov 2018 08:52:33 +0800
Message-Id: <1542847953-127599-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowACXPnfO_fVbSPFVBA--.3905S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFy3WF15ur1kJrW7tr43Jrb_yoW3Wrg_Ca
        1jvrs7ZrZ7trsavw1jkrW3ZrW2kaySgryF93Wxtr13Aa4xAwn8Xa18Xr4rXw15WryYyF93
        XFWDXr1fAr13CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5-vtJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzxMHclaD0XVjPgAAsF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory chunk allocated by hid_allocate_device() should be released
by hid_destroy_device(), not kfree().

Fixes: 0b28cb4bcb1("HID: intel-ish-hid: ISH HID client driver")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index cd23903..e918d78 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -222,7 +222,7 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
 err_hid_device:
 	kfree(hid_data);
 err_hid_data:
-	kfree(hid);
+	hid_destroy_device(hid);
 	return rv;
 }
 
-- 
2.7.4


