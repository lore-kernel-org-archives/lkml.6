Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26B8C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C0D22414
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TXCNWwRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C0D22414
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeHJSNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:13:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45355 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJSNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:13:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so4696942pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCT/GwwzGvav606l3FZtyMu5qhBDgzLqJDAQv26V9/w=;
        b=TXCNWwRLsVTR585466zVpWIQdWZ2CWzLxtHalahHoxiCac9yuaIJ64iSrIN50N3mE6
         04dpUHGRkVIYZowiuA+Rcvd/oRSlHVKrGtlNfQAIlPOqqRvsrJktyvarP0b8YkDXWqgM
         uHN0vNIpOqM5s8LJB5/4j8kzTM/ihnoHdqB/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCT/GwwzGvav606l3FZtyMu5qhBDgzLqJDAQv26V9/w=;
        b=qDcvE856YD+IwWjPIixqIc+ARvCmQ03o+0CdgZSmd0kK8q/q62hhlPixJSGH1KKQ02
         D5kBlPXppOJTHawVcWU6FHMapIACOyWrn3bGsWwNmXvBU/Mw7T7c4Bx0aVS7M/B9j3K2
         dU4xYyqen0aem8jFITVMNM8PAKKRA3ng1jH5GBwI2CqqtAYJYNY5h+LJDE1iF/Vb5qmM
         E7TBXvrJLwdvLj6Q4QZSebIMmN89652nQQOlXI3MQLgw1Igh1wJKemCwzhMZjcNSO9/b
         bg0gIN+7hEv/nDCIzbxawxADbeq39NcxXPo21q1w2qJgUcfOTsVfMyZM3SybOlA7h93z
         KnOQ==
X-Gm-Message-State: AOUpUlFqbpufcNRhqQy/St6bbrRgZMdCPaoT0RJuPaWGJ44f0EXrCMfa
        V5r5tM27LrT3Zm8+R4AhWg5yGA==
X-Google-Smtp-Source: AA+uWPzkn5wA9n/qRExvM5l1y0Us0GzQkxnZQdrUTT7saT2dRzVtioAbFIAa3yz2e0i5JgwS2eee1A==
X-Received: by 2002:a62:d842:: with SMTP id e63-v6mr7704211pfg.88.1533915805587;
        Fri, 10 Aug 2018 08:43:25 -0700 (PDT)
Received: from zsm-linux.mtv.corp.google.com ([2620:15c:202:201:1b7c:8280:c835:b226])
        by smtp.googlemail.com with ESMTPSA id 2-v6sm22192424pfs.58.2018.08.10.08.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 08:43:24 -0700 (PDT)
From:   Zubin Mithra <zsm@chromium.org>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        keescook@chromium.org, zsm@chromium.org
Subject: [PATCH] perf/x86: Add __ro_after_init annotations
Date:   Fri, 10 Aug 2018 08:43:14 -0700
Message-Id: <20180810154314.96710-1-zsm@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_pmu_{format,events,attr,caps}_group is written to in
init_hw_perf_events and not modified after. This makes them suitable
candidates for annotating as __ro_after_init.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
---
 arch/x86/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5f4829f10129..88e5f67f5d4c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1584,7 +1584,7 @@ static void __init pmu_check_apic(void)
 
 }
 
-static struct attribute_group x86_pmu_format_group = {
+static struct attribute_group x86_pmu_format_group __ro_after_init = {
 	.name = "format",
 	.attrs = NULL,
 };
@@ -1715,7 +1715,7 @@ static struct attribute *events_attr[] = {
 	NULL,
 };
 
-static struct attribute_group x86_pmu_events_group = {
+static struct attribute_group x86_pmu_events_group __ro_after_init = {
 	.name = "events",
 	.attrs = events_attr,
 };
@@ -2230,7 +2230,7 @@ static struct attribute *x86_pmu_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group x86_pmu_attr_group = {
+static struct attribute_group x86_pmu_attr_group __ro_after_init = {
 	.attrs = x86_pmu_attrs,
 };
 
@@ -2248,7 +2248,7 @@ static struct attribute *x86_pmu_caps_attrs[] = {
 	NULL
 };
 
-static struct attribute_group x86_pmu_caps_group = {
+static struct attribute_group x86_pmu_caps_group __ro_after_init = {
 	.name = "caps",
 	.attrs = x86_pmu_caps_attrs,
 };
-- 
2.18.0.597.ga71716f1ad-goog

