Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DB6C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FC12098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrO2SoTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FC12098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbeJKXKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06A5120652;
        Thu, 11 Oct 2018 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272560;
        bh=zhSCPTYZWeIWsEGQmVJnrd7RACpXMKdLicsXTn75ZiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrO2SoTHfjoQAZo7o66uSOyrbg0Qrf/N9xa4uAF2A03buNsQmfDEUfhmusOkeGBkV
         NBWVgkD71EGAkwG8sn8OU+1E60fOKCC5Hcfjqw4cxYXRS5oiJTNnSi3n+cznIjUGy3
         OU1WQsDUFtBgtMdYGJS/SS8xWaUW+K09lN68P9pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 07/27] PM / core: Clear the direct_complete flag on errors
Date:   Thu, 11 Oct 2018 17:34:54 +0200
Message-Id: <20181011152534.375860321@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
References: <20181011152534.014964888@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 69e445ab8b66a9f30519842ef18be555d3ee9b51 upstream.

If __device_suspend() runs asynchronously (in which case the device
passed to it is in dpm_suspended_list at that point) and it returns
early on an error or pending wakeup, and the power.direct_complete
flag has been set for the device already, the subsequent
device_resume() will be confused by that and it will call
pm_runtime_enable() incorrectly, as runtime PM has not been
disabled for the device by __device_suspend().

To avoid that, clear power.direct_complete if __device_suspend()
is not going to disable runtime PM for the device before returning.

Fixes: aae4518b3124 (PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily)
Reported-by: Al Cooper <alcooperx@gmail.com>
Tested-by: Al Cooper <alcooperx@gmail.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/power/main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1355,8 +1355,10 @@ static int __device_suspend(struct devic
 
 	dpm_wait_for_children(dev, async);
 
-	if (async_error)
+	if (async_error) {
+		dev->power.direct_complete = false;
 		goto Complete;
+	}
 
 	/*
 	 * If a device configured to wake up the system from sleep states
@@ -1368,6 +1370,7 @@ static int __device_suspend(struct devic
 		pm_wakeup_event(dev, 0);
 
 	if (pm_wakeup_pending()) {
+		dev->power.direct_complete = false;
 		async_error = -EBUSY;
 		goto Complete;
 	}


