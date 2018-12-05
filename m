Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014B3C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBB820850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039459;
	bh=jmvs6f7uu3FTy8eKMZUqGY/gXcq0Yuq13APloEIOzQM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IhbIV2CZthzcJRDn0YnXQacIAagMc82wXfJGY6ASPp8UlgKczahrSJ4PPRbIBQqLw
	 HKARGuvOqDQGZxkn0D/KOravkI3swxfOOJN5vyidOCZWqhigSKcq6FEajNiJnB5Ey/
	 hceYQOFaEnVQaDrdZkmVX3lPic45BZWBIH9b+B8M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBB820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbeLETu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:50:58 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41021 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbeLETuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:50:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so19816688otk.8;
        Wed, 05 Dec 2018 11:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpEtuMyejLbcg/OvDvyl/00uB/0Gj9YbrzwIg6g5G5g=;
        b=MU+Np392YzPLZI/76QyQRbH/S/scbJRk3f/W6Lbti95nLu6JLYdeVwn2MgUFpcyzBH
         7ZxiWgvSXZflIzVYPXUrfYOZo+tiBu3psV0nlJRKstPBEY5yZnq6HAsD6tnPVLT8o6Qg
         5yY3TNWWAI2tstvhpw0aRydB8FNPmPLA9jc86+LcOsWgsh2OGHxDaWuudgGIAPc+hq65
         HJWRPSfKdE1pJeOs3zA78Zj/cewrEk4OacMAvgIs93NV3GzDuEr6rIK1PhzQQQ8yONKj
         KOsDjvs7CJ/EAQer9AfSHVZo4NM0QPv/G0TJW90nNqFxO5+wNAe8VL97r/Rpm2P9hJw1
         s1uA==
X-Gm-Message-State: AA+aEWYgkjW1hfk7xpdlRf12FGo9Zovz0DDj2A/HgrVDDO3x4Y7wd2ce
        UjP4Y2mYzralb439Oa8OPgyFLrk=
X-Google-Smtp-Source: AFSGD/VSzIA76ww06qRt3Tulv82iKTqqNg2qWMOtxisb44q8IZnzwjXcQdP/Jg+Ha1QSlmq1IS10Tw==
X-Received: by 2002:a9d:17ca:: with SMTP id j68mr15245129otj.268.1544039454388;
        Wed, 05 Dec 2018 11:50:54 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:50:53 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] char/rtc: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:19 -0600
Message-Id: <20181205195050.4759-3-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

The open coded iterating thru the child node names is converted to use
for_each_child_of_node() instead.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index 4948c8bda6b1..62b7c721c732 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -866,8 +866,8 @@ static int __init rtc_init(void)
 #ifdef CONFIG_SPARC32
 	for_each_node_by_name(ebus_dp, "ebus") {
 		struct device_node *dp;
-		for (dp = ebus_dp; dp; dp = dp->sibling) {
-			if (!strcmp(dp->name, "rtc")) {
+		for_each_child_of_node(ebus_dp, dp) {
+			if (of_node_name_eq(dp, "rtc")) {
 				op = of_find_device_by_node(dp);
 				if (op) {
 					rtc_port = op->resource[0].start;
-- 
2.19.1

