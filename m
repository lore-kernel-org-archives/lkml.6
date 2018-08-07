Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01518C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF81421884
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eVqhOeJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF81421884
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbeHGTRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:17:41 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39138 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbeHGTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:17:40 -0400
Received: by mail-qk0-f193.google.com with SMTP id b5-v6so11911314qkg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iSUmtSdX2wVtRqqXHlxSnFHlSI+vBvYeE/kOim7Q72s=;
        b=eVqhOeJ0PWxynTi9RhSAj+k7mV/ivnUpWvAM5abbq2JWWeQvo3H0dp80Pop/fwqqQx
         8S9QgYIeKL8U1DQAvJN5I4ClkxVTZGMszJ7qt+bVyQJmuSTquNjQzx/EyUuhE6Hj76rN
         Ve6HUlCDo5slj7ef63pJfWAcfJ79AzEvzuvk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iSUmtSdX2wVtRqqXHlxSnFHlSI+vBvYeE/kOim7Q72s=;
        b=XFzvWC7b+AEr7n18jM+JUWY/0maWYwRcJ3ms+PGVfsAlsz1l2kciGV8XXZxbpwQd/L
         M1DXs/E2wIWYXFFddDJOle1XO5WkcRELG2TE5J5oljP/aaP7ZdHhUwaBurAumqh0Vq4A
         168GFQ5TnGZESd7D00eqqJcxNVMGMkHBQ2sMI8Gz04wFmqjskLrAa2ITu0EXBlOO0kzD
         UiMpZph+WWwaoMTjxtHPXJArcrtkbyvwkkpQU2cjlhp/EzKffKJYFhHpqqo+NMaH1/SD
         UygekB/eaMX8wqPUY0RBoDavbkDagBSwX13QPqV+fsuH6yu0vIQX1J+TYxtV4jqqnzAp
         mN1w==
X-Gm-Message-State: AOUpUlECQUVuucWwxJrXbd/JeZOQAgBQsLNgbyLGQd4yMZw+QSF0Sjfs
        WZ3nJ7+DdKTTp2gjvi5CZau9Aw==
X-Google-Smtp-Source: AAOMgpf8oaBKvj1yVYGa86iji1YLPFdy0TWM7E7QA9M24M5BE16WwER67raHHFshesUOvo0XqvQX8Q==
X-Received: by 2002:a37:7c41:: with SMTP id x62-v6mr17687884qkc.52.1533661345374;
        Tue, 07 Aug 2018 10:02:25 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d12-v6sm867483qth.35.2018.08.07.10.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 10:02:24 -0700 (PDT)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH 1/3] dt-bindings: net: dsa: Add compatibility strings for Broadcom Omega
Date:   Tue,  7 Aug 2018 10:02:42 -0700
Message-Id: <1533661364-15381-2-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibility strings for the internal switch in the Broadcom
Omega SoC family (BCM5831X/BCM1140X) to B53.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 Documentation/devicetree/bindings/net/dsa/b53.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/b53.txt b/Documentation/devicetree/bindings/net/dsa/b53.txt
index 47a6a7f..1811e19 100644
--- a/Documentation/devicetree/bindings/net/dsa/b53.txt
+++ b/Documentation/devicetree/bindings/net/dsa/b53.txt
@@ -24,6 +24,14 @@ Required properties:
       "brcm,bcm53018-srab"
       "brcm,bcm53019-srab" and the mandatory "brcm,bcm5301x-srab" string
 
+  For the BCM5831X/BCM1140x SoCs with an integrated switch, must be one of:
+      "brcm,bcm11404-srab"
+      "brcm,bcm11407-srab"
+      "brcm,bcm11409-srab"
+      "brcm,bcm58310-srab"
+      "brcm,bcm58311-srab"
+      "brcm,bcm58313-srab" and the mandatory "brcm,omega-srab" string
+
   For the BCM585xx/586XX/88312 SoCs with an integrated switch, must be one of:
       "brcm,bcm58522-srab"
       "brcm,bcm58523-srab"
-- 
1.9.1

