Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651CBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E94B208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xQp3hwQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E94B208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbeKTDCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731835AbeKTDCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F74D2147D;
        Mon, 19 Nov 2018 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645512;
        bh=fBVLDXEof9mA2gppONTfTj2zR84cbV/mNV9WJL5giGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQp3hwQD5FEpG2CqI7azm4mgBTvYm9hG+AViZuk28Yd54jMm0UgCr9ypHmIWrM44q
         dlb+bEXzXLgUG0uDOQ2wWmrWElBNPmBrnQRZMW7r0Dt4hnBVpNucQCMv/ckw+qv7eZ
         +U6XSAcCv0YyTCpQTHxcewc2JQJHJCVlzHKPX36Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.19 152/205] ARM: cpuidle: Dont register the driver when back-end init returns -ENXIO
Date:   Mon, 19 Nov 2018 17:27:39 +0100
Message-Id: <20181119162638.774142204@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 763f191af51f127cf8e69cd361f50bf6180768a5 upstream.

There's no point to register the cpuidle driver for the current CPU, when
the initialization of the arch specific back-end data fails by returning
-ENXIO.

Instead, let's re-order the sequence to its original flow, by first trying
to initialize the back-end part and then act accordingly on the returned
error code. Additionally, let's print the error message, no matter of what
error code that was returned.

Fixes: a0d46a3dfdc3 (ARM: cpuidle: Register per cpuidle device)
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: 4.19+ <stable@vger.kernel.org> # v4.19+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpuidle/cpuidle-arm.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -103,13 +103,6 @@ static int __init arm_idle_init_cpu(int
 		goto out_kfree_drv;
 	}
 
-	ret = cpuidle_register_driver(drv);
-	if (ret) {
-		if (ret != -EBUSY)
-			pr_err("Failed to register cpuidle driver\n");
-		goto out_kfree_drv;
-	}
-
 	/*
 	 * Call arch CPU operations in order to initialize
 	 * idle states suspend back-end specific data
@@ -117,15 +110,20 @@ static int __init arm_idle_init_cpu(int
 	ret = arm_cpuidle_init(cpu);
 
 	/*
-	 * Skip the cpuidle device initialization if the reported
+	 * Allow the initialization to continue for other CPUs, if the reported
 	 * failure is a HW misconfiguration/breakage (-ENXIO).
 	 */
-	if (ret == -ENXIO)
-		return 0;
-
 	if (ret) {
 		pr_err("CPU %d failed to init idle CPU ops\n", cpu);
-		goto out_unregister_drv;
+		ret = ret == -ENXIO ? 0 : ret;
+		goto out_kfree_drv;
+	}
+
+	ret = cpuidle_register_driver(drv);
+	if (ret) {
+		if (ret != -EBUSY)
+			pr_err("Failed to register cpuidle driver\n");
+		goto out_kfree_drv;
 	}
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);


