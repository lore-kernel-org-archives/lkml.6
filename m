Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B439C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19E320877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CGunVYc5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CGunVYc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19E320877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJDWOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:14:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeJDWOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:14:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B140760C4E; Thu,  4 Oct 2018 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538666435;
        bh=IYkDeCLEo0iUaXGkDm/0nbl9OXzzTgkiyu7XZ+M+gRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGunVYc5idX8ls3GscD//jr1e56Ta+GgS/uTbhnLzyrKUillQSQPHtQ2ae9j9LI9I
         zEDuX0ImbkGLnmaoC/+G5vXG7OlIDvBwZrod6T1xh22zUt35lnk0tmH7dV0B0+ndk0
         kaKreUBdaPe2hJGWQDqloGULQuzgTmj61lMcqq0s=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68D7860D2D;
        Thu,  4 Oct 2018 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538666435;
        bh=IYkDeCLEo0iUaXGkDm/0nbl9OXzzTgkiyu7XZ+M+gRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGunVYc5idX8ls3GscD//jr1e56Ta+GgS/uTbhnLzyrKUillQSQPHtQ2ae9j9LI9I
         zEDuX0ImbkGLnmaoC/+G5vXG7OlIDvBwZrod6T1xh22zUt35lnk0tmH7dV0B0+ndk0
         kaKreUBdaPe2hJGWQDqloGULQuzgTmj61lMcqq0s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68D7860D2D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        jeremy.linton@arm.com
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v4 1/2] drivers: base: cacheinfo: Do not populate sysfs for unknown cache types
Date:   Thu,  4 Oct 2018 09:20:05 -0600
Message-Id: <1538666406-7504-2-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
References: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a cache has an unknown type because neither the hardware nor the
firmware told us, an entry in the sysfs tree will be made, but the type
file will not be present.  lscpu depends on the type file being present
for every entry, and will error out without printing system information
if lscpu cannot open the type file.

Presenting information about a cache without indicating its type is not
useful, therefore if we hit a cache with an unknown type, stop populating
sysfs so that userspace has the maximum amount of useful information.

This addresses the following lscpu error, which prevents any output.
lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
file or directory

Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 5d5b598..cf78fa6 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -615,6 +615,8 @@ static int cache_add_dev(unsigned int cpu)
 		this_leaf = this_cpu_ci->info_list + i;
 		if (this_leaf->disable_sysfs)
 			continue;
+		if (this_leaf->type == CACHE_TYPE_NOCACHE)
+			break;
 		cache_groups = cache_get_attribute_groups(this_leaf);
 		ci_dev = cpu_device_create(parent, this_leaf, cache_groups,
 					   "index%1u", i);
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

