Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C7AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA502401A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqBFr5/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA502401A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753690AbeGEXq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:46:28 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34383 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeGEXqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:46:24 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so8623674qth.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 16:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CWVhLN26JnKXbskiUyNbT1bgBKJeu6m7K2pAX1uSgKA=;
        b=YqBFr5/3TZicLGvv20o/dr6mQkU8ojZocTznkVYdjMu3d+tm5tptD6R/nQ9ck4cqZ9
         MqS4cGyVvkCAeW/OZy7ZeCjueZa0yxsRiK6QwrTy2z1pz2LGB5J1ocFMw8StJp4ixZf2
         shd0WkbTlfiLHg300XR2++hSOKitJrHUJOt520ovh4P3U1mrZCu3dc52qhozM0JcvM23
         6AZNEYwwF6O0wkIVn3kPIju72/RAsic3GOZPtbOKzoyr7YHhquLylwwPSSZni64yZBx7
         b+gj38fvKbjowdD+xmUVELPibGhK+pYcm5aWda+K2PLIJ3f5eduoti2ZGII8c48l1iPl
         rl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CWVhLN26JnKXbskiUyNbT1bgBKJeu6m7K2pAX1uSgKA=;
        b=DHQuAoRdAxrg2mlqnm1/39xKCfG0+aU6e+hvgskaAC+NArtWFAnkp9hPl/GkZMBEV0
         uJWB13FwkqXM6rVfZhbP+UPDOYMTVANcEHYN3fGZCfAiT1cMXdVoRfmwJaCyYRz2qTp9
         9R9Hn7CvWboGjci/CcU4bazkGi2pcKwjct2zUtPrMLbI2FlS1ehK8LvGqAWmQM5EZFHz
         fOqBva6JqtshEgHHPP6xvUZvmKqa62MNgqZkCG6aC0xCknC1y9eose7S5ZfqIdnHZ26x
         RuUbGBmQ2RWomWzHSWMc3APwsthl71sEzYbFSD9IfKq96/kuJagcSbQ0wuBLBw1WKGCZ
         ZdWQ==
X-Gm-Message-State: APt69E2uszbjgKU75UemPFcBgD4owuNODT4FnU4u1oqwNp4nrUZHjsy1
        LG91N3c3vW50Llb9Ojcm9u0=
X-Google-Smtp-Source: AAOMgpeSR+rZd2ft8RWfBiGr2AjEB2Y2Y3uJJ+KR/FIjNCKOm1FGocNg7WluKP7Eso9lo3cXNqaXCA==
X-Received: by 2002:ac8:2931:: with SMTP id y46-v6mr7223482qty.207.1530834384213;
        Thu, 05 Jul 2018 16:46:24 -0700 (PDT)
Received: from localhost.localdomain (d-74-214-40-72.cpe.metrocast.net. [74.214.40.72])
        by smtp.googlemail.com with ESMTPSA id h195-v6sm4567887qke.58.2018.07.05.16.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 16:46:23 -0700 (PDT)
From:   Peter Vernia <peter.vernia@gmail.com>
Cc:     peter.vernia@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neil@brown.name>,
        =?UTF-8?q?Christian=20L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pinctrl: Replace unsigned with unsigned int
Date:   Thu,  5 Jul 2018 19:45:41 -0400
Message-Id: <1530834355-8833-1-git-send-email-peter.vernia@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaces instances of "unsigned" with "unsigned int" in pinctrl-mt7621.c

Signed-off-by: Peter Vernia <peter.vernia@gmail.com>
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index 0c3e498..201df08 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -54,7 +54,7 @@ static int rt2880_get_group_count(struct pinctrl_dev *pctrldev)
 }
 
 static const char *rt2880_get_group_name(struct pinctrl_dev *pctrldev,
-					 unsigned group)
+					 unsigned int group)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
@@ -65,9 +65,9 @@ static const char *rt2880_get_group_name(struct pinctrl_dev *pctrldev,
 }
 
 static int rt2880_get_group_pins(struct pinctrl_dev *pctrldev,
-				 unsigned group,
-				 const unsigned **pins,
-				 unsigned *num_pins)
+				 unsigned int group,
+				 const unsigned int **pins,
+				 unsigned int *num_pins)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
@@ -81,7 +81,8 @@ static int rt2880_get_group_pins(struct pinctrl_dev *pctrldev,
 }
 
 static void rt2880_pinctrl_dt_free_map(struct pinctrl_dev *pctrldev,
-				    struct pinctrl_map *map, unsigned num_maps)
+				    struct pinctrl_map *map,
+				    unsigned int num_maps)
 {
 	int i;
 
@@ -94,7 +95,7 @@ static void rt2880_pinctrl_dt_free_map(struct pinctrl_dev *pctrldev,
 
 static void rt2880_pinctrl_pin_dbg_show(struct pinctrl_dev *pctrldev,
 					struct seq_file *s,
-					unsigned offset)
+					unsigned int offset)
 {
 	seq_printf(s, "ralink pio");
 }
@@ -127,7 +128,7 @@ static void rt2880_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctrldev,
 static int rt2880_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrldev,
 				struct device_node *np_config,
 				struct pinctrl_map **map,
-				unsigned *num_maps)
+				unsigned int *num_maps)
 {
 	int max_maps = 0;
 	struct pinctrl_map *tmp;
@@ -173,7 +174,7 @@ static int rt2880_pmx_func_count(struct pinctrl_dev *pctrldev)
 }
 
 static const char *rt2880_pmx_func_name(struct pinctrl_dev *pctrldev,
-					 unsigned func)
+					 unsigned int func)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
@@ -181,9 +182,9 @@ static const char *rt2880_pmx_func_name(struct pinctrl_dev *pctrldev,
 }
 
 static int rt2880_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
-				unsigned func,
+				unsigned int func,
 				const char * const **groups,
-				unsigned * const num_groups)
+				unsigned int * const num_groups)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
@@ -198,8 +199,8 @@ static int rt2880_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
 }
 
 static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
-				unsigned func,
-				unsigned group)
+				unsigned int func,
+				unsigned int group)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
         u32 mode = 0;
@@ -243,7 +244,7 @@ static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
 
 static int rt2880_pmx_group_gpio_request_enable(struct pinctrl_dev *pctrldev,
 				struct pinctrl_gpio_range *range,
-				unsigned pin)
+				unsigned int pin)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
-- 
2.7.4

