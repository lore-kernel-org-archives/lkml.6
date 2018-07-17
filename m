Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0176ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B6A208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqQhstAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B6A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbeGQCjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:39:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37144 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbeGQCjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:39:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id a26-v6so5135588pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/AyrjK6mJxCWqaxrnTdbRZSjaqsy2SsJvBEmFFJsMdA=;
        b=jqQhstAT1kOzwENsRAUamLdK0ZA+ZFWyuTpdQUg1FgpWoQw5CoauvzBMIuzLRKJFmr
         lNkxE2qCtgQjf0dH+htNDCIqTVSHWdcWof8S/vVnH5W1YP0C2FRw17ZTB/Nawjetub/9
         WzI2wIM77VQ2JwqZMw+CGygqqcz98fyyWLrRFCSGnCRoRsMniqoU1ppBkOZX/kcVzbKt
         0zOrTPbv8IZfYA/9pk+E0Q2IMiRsg0sWo6UvLRvpNYPWKvAVtQm+zU2JnXoLIAO5ygAB
         iFKGMDU5MehYNwhFR7YVLhdmns/LSLc9a8HeykLLgi7L2d9Gjvvq+Zaey1eAnhfyEjQ1
         cjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/AyrjK6mJxCWqaxrnTdbRZSjaqsy2SsJvBEmFFJsMdA=;
        b=NcyI5RNPpOw9871T8I+jnJWZ6qpnl+xIuL7U4I+HhXewpRBSwxak881KLKw+BuZoRl
         OJn/ackeeChD8Z/nBTzGcWhjTthCiyVa1zz+ORBRWHOttIywQLjTgu+80D1p0OMIFstS
         jjiV/06sX1nv+xa1oqA7TFQUtJGIVIvDAB/oztdiiD5rcPGE8ngVJklu1JqhFzSO18zk
         c5U5L9kuUoXy46UG/5A9KNix0+wyOobmTUDetFdY4wU5dOdeW0sb41ZMXAEKr+RK5qe7
         wsEfatQIoWDz6ffPi6V4wpvLcXudAD2OpQMgnIALjvub9zZyssVACTgrW8rqsA7LYG+m
         Zosg==
X-Gm-Message-State: AOUpUlE28CP4uuiTSPx5bVQt2WIcMdpjnCCNW3u3P3akdbCzoiCl7Q3R
        dmwFFhO/JxmISB/pTivkWg0=
X-Google-Smtp-Source: AAOMgpftDbKcoSp6ygFezVxyStP6SElZVIqT5/RPURuW3x2u/acXCc+l+cMcro5yCwF6Z8+RXsucOQ==
X-Received: by 2002:a63:7a0a:: with SMTP id v10-v6mr17414246pgc.444.1531793383280;
        Mon, 16 Jul 2018 19:09:43 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:42 -0700 (PDT)
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
Subject: [PATCH 01/32] staging: gasket: remove X86 Kconfig restriction
Date:   Mon, 16 Jul 2018 19:08:55 -0700
Message-Id: <20180717020926.176408-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The gasket and apex drivers are to be used on other architectures
besides X86.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/Kconfig b/drivers/staging/gasket/Kconfig
index c836389c1402d..ef40c4c75e0f2 100644
--- a/drivers/staging/gasket/Kconfig
+++ b/drivers/staging/gasket/Kconfig
@@ -2,7 +2,7 @@ menu "Gasket devices"
 
 config STAGING_GASKET_FRAMEWORK
 	tristate "Gasket framework"
-	depends on PCI && X86_64
+	depends on PCI
 	help
 	  This framework supports Gasket-compatible devices, such as Apex.
 	  It is required for any of the following module(s).
-- 
2.18.0.203.gfac676dfb9-goog

