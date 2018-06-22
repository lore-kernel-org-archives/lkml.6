Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7822DC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABCE23ECD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTKr94d0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABCE23ECD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933354AbeFVINA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:13:00 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47009 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754252AbeFVIKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:10:05 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so3090413pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=C00iri9Dth9hE8CWwVUI5JRBbcabRyVj9MDYk2bFR2Y=;
        b=eTKr94d0v/SCt8CD6+8W01iJQeyvl7llVoz3NFsqJWPtFRw5T9x/kstQKC61REHO/A
         gljhOR1fx2QmQKXpieDUb5c60DUrMZq4LwgwUjocx50MQQ8wTO/I5p0C+lcADoe2gB38
         Hm1snOK3gHFWUdglb+IGbeHBSfBlubLa7XUbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=C00iri9Dth9hE8CWwVUI5JRBbcabRyVj9MDYk2bFR2Y=;
        b=PuAzrVcY8piGG5qnFscnQ2xpbWwKqZrQby8Zh/S70Vm5QxsyLpvdy5VPNQbYqOPu24
         p8RuWqSXiPx2Pxd1h0MDXmkI4YLCAVR9qV3jtrFdYZWc2/SfWFzTq9hOPuksKSR4YMuN
         LSzLLMjwhgRiSL+jbkh5TC7+5DCysVFuvhdO1vGQOOaB7gX50aF2mUuW/u2s3yh1sxdc
         zmyJfu4qAEE3RrEA3Kr6DSQS3Q2cCXGvVpdLcJbyK/RJpC/RXmMVicerhWzXP+UJKMt1
         XE2sQT836ElA4wpQjWqAHxh7eE0FrF1OHAeSIpEEhJnCxJ/g1zLq0+OT+Yc9HIPhVsZX
         O07w==
X-Gm-Message-State: APt69E3zJ3EUhgIuwYOjV2jg7mqxxBOcgXd9DtAtme9STM1hAP0rDSUu
        EEE8+j5NHL7vJ3LIMh+0ai3PeA==
X-Google-Smtp-Source: ADUXVKIkzZVQ0/OOdFsa7rzEmSqeCqH6cILQACvw3uZRAOeKPF36JcnC0X/JMKUMLKak8uH1OPb4Rw==
X-Received: by 2002:a17:902:4c:: with SMTP id 70-v6mr620943pla.178.1529655005235;
        Fri, 22 Jun 2018 01:10:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i65-v6sm22656131pfd.17.2018.06.22.01.10.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:10:04 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] hwspinlock: Fix one comment mistake
Date:   Fri, 22 Jun 2018 16:09:02 +0800
Message-Id: <215e82a652063b244e0892829a204b3da5a69056.1529654288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix one comment mistake with correct function names.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index ba27465..e16d648 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -767,7 +767,7 @@ struct hwspinlock *hwspin_lock_request_specific(unsigned int id)
  *
  * This function mark @hwlock as free again.
  * Should only be called with an @hwlock that was retrieved from
- * an earlier call to omap_hwspin_lock_request{_specific}.
+ * an earlier call to hwspin_lock_request{_specific}.
  *
  * Should be called from a process context (might sleep)
  *
-- 
1.7.9.5

