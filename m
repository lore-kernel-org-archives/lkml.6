Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E178DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848DB206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFJsqFtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848DB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeIET0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:26:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39701 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIET0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:26:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so8002897wrf.6;
        Wed, 05 Sep 2018 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QxoNn9wD0S6oQzwXs2dfLxcInm23LNF/KOSiykYC4ms=;
        b=RFJsqFtvKKBY9pP92EYN9l+XWcjqS0w+F9j3GVKyy3soVYitXz0w/PDCZVyue2SC2I
         CrwacIYn7oItk8uTMSA8VNjFwLcVzVx4hcFasbYoZYS2iSNtWRg/qh2Dmx0B7K2iCA8v
         GFk2ZcbA0L1jxSyO8kuiD9EUw2L1348GLLS6GDRcn67Ofd/xz0J4TGlwuKeBgJq9FxOb
         FfF97AM+jiiozfbxJgpTDIhql+ZTxa4DXzOJKI7CpJSM2q8MSN5Kd0bLWab7NgSCaZYB
         v8+cas1eFSl/gl7z97KuwMfUP7cJppqhAUySsVbqZqxiIb69/KuvjK9+ngBNOfw9fe6r
         B9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QxoNn9wD0S6oQzwXs2dfLxcInm23LNF/KOSiykYC4ms=;
        b=RzHhGExTbs2ifBTqqseFiTMZ/bJ5wvCUQUcd7CZYE3pmR2rQVCw5VG0I7ggF/5L7lf
         qiYNQ8d25actGoA+Lhv9D3aHZ7dFS/CQCOSbq2D8r13jjbNyKP+DGWeJ3IKnZUE5OSyN
         2X/yST7723xB/ncnU+5czcAJa69F51rvX2sNwGGuWQ60mpIwyh5S3BpWZgN0IlpWS9Zz
         1asGaQJT6NO0CdZt8w00L9fKGKmRMclnj/aqVHdeqhQLS4bBkH3sjlbfg5wkegVyhmIv
         syf6mcu4T7PcVo+L/TbxJc2qkT/NIkboYwgKQeMSpAPR8QylYiHAHWEHummnIZdqvzJj
         IgAw==
X-Gm-Message-State: APzg51Ccl4CDM1OuTwEiPL1X1kU9so3aq9BG0nwT/6o1iFv7YI42SqbC
        578BmgYjzB8CMYV4QXut+fM=
X-Google-Smtp-Source: ANB0VdYnSSPKuNkzCM1XL5Ht8J2TCY7ZwXBqi7pCX4/TllFwrV2LgDZ9/usdCAG0pU5f+2B1QDR8OA==
X-Received: by 2002:adf:e6c2:: with SMTP id y2-v6mr26562565wrm.35.1536159363700;
        Wed, 05 Sep 2018 07:56:03 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id 88-v6sm1607255wrf.95.2018.09.05.07.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 07:56:03 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, hal@halemmerich.com,
        arthur.petrosyan@synopsys.com,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: disable power_down on Amlogic devices
Date:   Wed,  5 Sep 2018 18:55:13 +0400
Message-Id: <1536159314-35831-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB devices work when connected to Amlogic GXBB hardware before power
on, but not when connected after boot (hotplugged). With this patch
hotplugging works again. This change was copied from the Rockchip
patch here: (https://marc.info/?l=linux-usb&m=153205711616460&w=2)

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index bf7052e..93561a2 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -110,6 +110,7 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg *hsotg)
 	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
 	p->ahbcfg = GAHBCFG_HBSTLEN_INCR8 <<
 		GAHBCFG_HBSTLEN_SHIFT;
+	p->power_down = false;
 }
 
 static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
-- 
2.7.4

