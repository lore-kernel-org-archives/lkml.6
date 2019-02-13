Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8051C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51A8206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s1XmvoAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436823AbfBMVcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:32:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44622 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436778AbfBMVcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so4421825qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7lJaSOHNBHQZSETMFK/nyiszapRsFtwkzZBpnv7tGA=;
        b=s1XmvoAFbRCLC+JYLNPmrgNi+JssmEFKTHIZcbM99ZzHvaXiWEfPcFsaMjA+RPq43B
         yczPxj7RcP711w57TAUQz4xYaaSoh0jVfFOx6j2h1wb4wNsihK7IHdINuM4acN3EumDB
         xIj6RHmwbyX+CFsVaTCtf0PC03jDYm/FDu7TgzxZgcUaUr3QU9/UcllBOO+cDWOB7VOP
         62n+djXEWgqrMCOz8Grqx0dZmARAqSalkajlxcHnsSHtoZugHfU/WH9gSkJ0qxHixc9l
         0T6lAt8LTTdgMcPw+qKCJ6Za9zyampaPTnUb/ld8J4oChpEd9cDInVVeD5I4/8FNAnDm
         VTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7lJaSOHNBHQZSETMFK/nyiszapRsFtwkzZBpnv7tGA=;
        b=Dpi/c7X/FwV/j/BFEMUp8Du4C1FZ2Ja0tRc7DKQsLy+v6O26vSO/AqqXgjRU0B51ZD
         jcXxZSf6lELpinq3EXnEvKKRH1yFRGWwPH8Ddvs3lzcCf4Ie7jtYJczTFutK+MXHqoWB
         g246Q/8dYxn1ELlGnx+2F2L5d+O72IT8qQp/UU7VT+/FzlOlPdv2F0yIvyZG+lCDUuCT
         vynhZ1Os1oSNB4TcYR1YncdH8RJYXKsx0+DoBUrKVv4TLMRKP+7VoL+k8LvliJ/jDv97
         VahHtfgTnPGOAj980y0HNnfYcpIV3pyUtLwq1AN8WeTU3Du5W2yjnGOYYd61YSY03evy
         4TrQ==
X-Gm-Message-State: AHQUAuYOlLpANRit7pp28u3x9FJTvyZYXSjJG3m0+rEaRz+yAYbZlV3d
        W8Bd5E4+TkegRU4tPMWqVBfu6w==
X-Google-Smtp-Source: AHgI3IbTTm0DogF/FptlR1dRTwoq3QbYdqPasZVufAbowtGviiZuiARLC3IPIYbYMT42lDIZy/nX6g==
X-Received: by 2002:a0c:d90b:: with SMTP id p11mr245177qvj.140.1550093560912;
        Wed, 13 Feb 2019 13:32:40 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:40 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 11/17] ARM: make lookup_processor_type() non-__init
Date:   Wed, 13 Feb 2019 16:32:17 -0500
Message-Id: <20190213213223.916-12-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 899a42f836678a595f7d2bc36a5a0c2b03d08cbc upstream.

Move lookup_processor_type() out of the __init section so it is callable
from (eg) the secondary startup code during hotplug.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/kernel/head-common.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 6e0375e7db05..997b02302c31 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -145,6 +145,9 @@ __mmap_switched_data:
 #endif
 	.size	__mmap_switched_data, . - __mmap_switched_data
 
+	__FINIT
+	.text
+
 /*
  * This provides a C-API version of __lookup_processor_type
  */
@@ -156,9 +159,6 @@ ENTRY(lookup_processor_type)
 	ldmfd	sp!, {r4 - r6, r9, pc}
 ENDPROC(lookup_processor_type)
 
-	__FINIT
-	.text
-
 /*
  * Read processor ID register (CP#15, CR0), and look up in the linker-built
  * supported processor list.  Note that we can't use the absolute addresses
-- 
2.17.1

