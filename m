Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 067A0C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06BE208C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba6gEqR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06BE208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934031AbeFLQxk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934280AbeFLQxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94365208B8;
        Tue, 12 Jun 2018 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822415;
        bh=ak5JVHuRg1Yd74ro8+IzA8FRIW6Jpei50AgNtsSzVHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ba6gEqR4M9uhoJCgCRDSGiU8wxXQZhmHyvDvLf0bLT6NQKAke3Ns4JUmSRa9jwvTj
         rIKbgdwXUpRuwst5KR64zkoilTO9ocwa4TowcBlPSsznepoeNAeQsuOKj7dxkNzZbG
         y/PAyd/XGaca2mDAFg0d2G4nZOuCwPyLrkD6u7kQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 08/24] brcmfmac: Fix check for ISO3166 code
Date:   Tue, 12 Jun 2018 18:51:52 +0200
Message-Id: <20180612164816.963565286@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

commit 9b9322db5c5a1917a66c71fe47c3848a9a31227e upstream.

The commit "regulatory: add NUL to request alpha2" increases the length of
alpha2 to 3. This causes a regression on brcmfmac, because
brcmf_cfg80211_reg_notifier() expect valid ISO3166 codes in the complete
array. So fix this accordingly.

Fixes: 657308f73e67 ("regulatory: add NUL to request alpha2")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 4.4: adjust filename]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c
@@ -6167,7 +6167,7 @@ static void brcmf_cfg80211_reg_notifier(
 		  req->alpha2[0], req->alpha2[1]);
 
 	/* ignore non-ISO3166 country codes */
-	for (i = 0; i < sizeof(req->alpha2); i++)
+	for (i = 0; i < 2; i++)
 		if (req->alpha2[i] < 'A' || req->alpha2[i] > 'Z') {
 			brcmf_err("not a ISO3166 code\n");
 			return;


