Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D683CC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8173521479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxSnyXkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8173521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbeJICGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbeJICGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F3F4204FD;
        Mon,  8 Oct 2018 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024788;
        bh=AoKzuReZS1M6+ZAEUZ1vrAsiFvG+DASXwF7uqwGvjFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxSnyXkMk+J6Vaw15IkdIJd003eWw2C5EjoeyWjE0MrcjtMioTjDISjIVQn3qOVyU
         b97S3/FBgpzIJRcN4U+LuszD4q22CleW+/t9wsMdieJtEtoN45rL8Lv8/RjbP1prYA
         GCgZc0+8oXe+v2zkUnc6O1MGHSgS7V0zEtB6Epc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 154/168] cpufreq: qcom-kryo: Fix section annotations
Date:   Mon,  8 Oct 2018 20:32:14 +0200
Message-Id: <20181008175625.898147349@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

commit d51aea13dd6753186a2bea7619029c460bdf0c4c upstream.

There is currently a warning when building the Kryo cpufreq driver into
the kernel image:

WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
the function qcom_cpufreq_kryo_probe() to the function
.init.text:qcom_cpufreq_kryo_get_msm_id()
The function qcom_cpufreq_kryo_probe() references
the function __init qcom_cpufreq_kryo_get_msm_id().
This is often because qcom_cpufreq_kryo_probe lacks a __init
annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.

Remove the '__init' annotation from qcom_cpufreq_kryo_get_msm_id
so that there is no more mismatch warning.

Additionally, Nick noticed that the remove function was marked as
'__init' when it should really be marked as '__exit'.

Fixes: 46e2856b8e18 (cpufreq: Add Kryo CPU scaling driver)
Fixes: 5ad7346b4ae2 (cpufreq: kryo: Add module remove and exit)
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 4.18+ <stable@vger.kernel.org> # 4.18+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/qcom-cpufreq-kryo.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -44,7 +44,7 @@ enum _msm8996_version {
 
 struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
 
-static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
+static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 {
 	size_t len;
 	u32 *msm_id;
@@ -221,7 +221,7 @@ static int __init qcom_cpufreq_kryo_init
 }
 module_init(qcom_cpufreq_kryo_init);
 
-static void __init qcom_cpufreq_kryo_exit(void)
+static void __exit qcom_cpufreq_kryo_exit(void)
 {
 	platform_device_unregister(kryo_cpufreq_pdev);
 	platform_driver_unregister(&qcom_cpufreq_kryo_driver);


