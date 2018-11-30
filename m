Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EB9C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5966D20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5966D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeLACZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:25:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40918 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeLACZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:25:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so5383096oth.7;
        Fri, 30 Nov 2018 07:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTP2suxoYw8hrf9sYDQLXECjswhPrSNo6Ll3v80kY3w=;
        b=erNZzN/GLC3Sz+MqKyXUxMFIqelR7p4Ixd8AzeL0UyYBlWMT/puSsbnTfBM+Le4h2Q
         TrEBbcpbB8CtbX5f/yJ0nzWb4njxkIEBZ2avay4PwlIyZf/0B11ofIMtRleVO8m+5gCc
         G7htTJEFcmxEk3jeOPp37wejIBSUe/VtNkw3YJEIyCR5j61a84uOEvXujYBwGWXdXurU
         SfF6HKBGkuGnG5Q0aTXvxgxocg1OZddlmkJ8dfztCQWgQBsxp0+O/bSz27PyiuSWgp9o
         +rfQk/zKqnPinvEshAgAXqS8fOs/P8Zpfp/awDefTOLcSDcz+6op0Za/SFQdrVHtXRsO
         KK0Q==
X-Gm-Message-State: AA+aEWYL1uY5HK49GULLHDvC6k58FZEo75TXQQQqRBlmv/GDHgN/oJ7H
        v0p7V5ly/jXwstH30eXwMXDDt9w=
X-Google-Smtp-Source: AFSGD/VGK4rs9ngiO9tblxTKARe72nEi0ZG0d+QkKMOB8y1ETDydjF3X5nULE2qO24BuDZ50dyXjIQ==
X-Received: by 2002:a9d:6e06:: with SMTP id e6mr3638505otr.194.1543590974628;
        Fri, 30 Nov 2018 07:16:14 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id r7sm2011537oia.28.2018.11.30.07.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 07:16:13 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 2/3] kbuild: disable dtc simple_bus_reg warnings by default
Date:   Fri, 30 Nov 2018 09:16:09 -0600
Message-Id: <20181130151610.30596-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130151610.30596-1-robh@kernel.org>
References: <20181130151610.30596-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The updated version of dtc has a bug fix for simple_bus_reg warnings
and lots of warnings are generated now. So disable this warning by
default.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8fe4468f9bda..46342f0198f6 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -252,6 +252,7 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-alias_paths \
 	-Wno-graph_child_address \
 	-Wno-graph_port \
+	-Wno-simple_bus_reg \
 	-Wno-unique_unit_address \
 	-Wno-pci_device_reg
 endif
-- 
2.19.1

