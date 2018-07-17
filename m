Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96997ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500A4208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwatTb3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500A4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbeGQCj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:39:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44487 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbeGQCj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:39:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so8265757pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9R0fZXHvA6dRO6rGipkhbtrhhMhUZV5bWtE9katZt4A=;
        b=TwatTb3v+uF/cq/U/y9n/ZFu3CzLrOK5NgsFTLxTikH24vc3phVbjoBAIiFkUR7gDF
         JHNo6oUdvwa7rQUJrom4cJSh97Monnk8w4zBMPsOJdH9adHg5qLtrX8ByqwohDxeQ0ze
         lYD4iOTL+AzcAE7QJOClZoSKxwkwjx5ZmaP+Kv92pGi5nwslAQQhTj6FjiQiZAdbnYYn
         E9xEJ44moJEaIHbPGs53Uz7vHvuOynT7dccxFTqnex/82p9aE6S1b4WlxjN7nHqcT5nI
         VIpaosGx532eXOlG1/e6TNM6R6smub5r7J0/QDaIPmqSbqIizseDVLoUl0BPyHCy8c1k
         TPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9R0fZXHvA6dRO6rGipkhbtrhhMhUZV5bWtE9katZt4A=;
        b=hNgfNRtskRsZPn4O/leudzSmCUrSdjCf2yaTZ/unwf4koIbaC5m77UA9B3VNB8XNDj
         AolTG8CLXETK6sYutvWFH+OzObVHZNY2mYuu3JXmDJvF1Q1aKEkYQseaZw022zPJAoyQ
         lq6SpK4I0h9pOwG83152sp4/eJnKC1nUgdW1NBZAGIEyCPvDrZ4vSFjVef6MPsLlvyXw
         ybO4KYPEvJUwUmkyvTENVm8uIs4JbLQ63O9FlOYBIf+wy3nuEUbvhN4ynwkVkyuaqIxg
         4fdkL56uL8KT/17ijcsSFaBG7Ig2qbXKYYtuuV3cw4lCuHhmwhme/J49EcEgb1JEOFUQ
         aTkQ==
X-Gm-Message-State: AOUpUlEAz+jOwjCPMaSWxz5VLGfY5Ib6m06HV2XMytztllA+cL9zhcV7
        kWAwqqc7XSynmXOdDML7cc85Lnrc
X-Google-Smtp-Source: AAOMgpeJ3RYsvBBwTQZ2oPCIsdEf767wy2GjncqmhFQVBm7oV+BqIbecoKuWqFfbUDuDTV6ubRrUYg==
X-Received: by 2002:a63:4b1f:: with SMTP id y31-v6mr17905803pga.14.1531793386970;
        Mon, 16 Jul 2018 19:09:46 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:46 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 03/32] staging: gasket: fix typo in gasket_core.h comments
Date:   Mon, 16 Jul 2018 19:08:57 -0700
Message-Id: <20180717020926.176408-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Grammar fixup in gasket_core.h comments describing struct
gasket_interrupt_desc.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index e51acadc0fc4f..94a5537bff2c2 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -56,7 +56,7 @@ enum gasket_interrupt_type {
 
 /* Used to describe a Gasket interrupt. Contains an interrupt index, a register,
  * and packing data for that interrupt. The register and packing data
- * fields is relevant only for PCI_MSIX interrupt type and can be
+ * fields are relevant only for PCI_MSIX interrupt type and can be
  * set to 0 for everything else.
  */
 struct gasket_interrupt_desc {
-- 
2.18.0.203.gfac676dfb9-goog

