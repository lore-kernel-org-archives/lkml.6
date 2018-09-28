Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AA2C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9145215E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bCEaXxQD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bCEaXxQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9145215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeI1JTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 05:19:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeI1JTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 05:19:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4DE2F60818; Fri, 28 Sep 2018 02:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538103493;
        bh=nnqp1MxbJFS5x6CM8RUKq+t4jG7kMVyAe7N7S3OT/1U=;
        h=From:To:Cc:Subject:Date:From;
        b=bCEaXxQD8hOfnYLZQyOzV0gFbXSkjKxZZzobJrVMsObmNpSxW2HB7KmKhdfIJJamY
         Gz4nSVNCOj9DE8IQK8xq8w2rZuOqkUSAnEEbIIg3W9S9ASINoo4+4mOOBXNAjVMQPZ
         qtHMCA6uXCbg3GlAj6LABOu1qx05N5/5xn6R7MtI=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C00B600C1;
        Fri, 28 Sep 2018 02:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538103493;
        bh=nnqp1MxbJFS5x6CM8RUKq+t4jG7kMVyAe7N7S3OT/1U=;
        h=From:To:Cc:Subject:Date:From;
        b=bCEaXxQD8hOfnYLZQyOzV0gFbXSkjKxZZzobJrVMsObmNpSxW2HB7KmKhdfIJJamY
         Gz4nSVNCOj9DE8IQK8xq8w2rZuOqkUSAnEEbIIg3W9S9ASINoo4+4mOOBXNAjVMQPZ
         qtHMCA6uXCbg3GlAj6LABOu1qx05N5/5xn6R7MtI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C00B600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        jeremy.linton@arm.com
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v3 0/2] PPTT handle Handle architecturally unknown cache types
Date:   Thu, 27 Sep 2018 20:57:55 -0600
Message-Id: <1538103477-15513-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM Architecture Reference Manual allows for caches to be "invisible" and
thus not specified in the system registers under some scenarios such as if the
cache cannot be managed by set/way operations.

However, such caches may be specified in the ACPI PPTT table for workload
performance/scheduling optimizations.

Currently such caches can cause an error in lscpu -

lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
file or directory

and result in no output, providing a poor user experience.  lstopo is also
affected as such caches are not included in the output.

Address these issues by attempting to be a little more discerning about when
cache information is provided to userspace, and also utilize all sources for
cache information when possible.

[v3]
-removed valid flag in PPTT
-Added Jeremy Linton's reviewed-by

[v2]
-Updated cacheinfo per Sudeep's suggestion
-Integrated the PPTT fix into existing PPTT code per Sudeep's suggestion

Jeffrey Hugo (2):
  drivers: base: cacheinfo: Do not populate sysfs for unknown cache
    types
  ACPI/PPTT: Handle architecturally unknown cache types

 drivers/acpi/pptt.c      | 15 +++++++++++----
 drivers/base/cacheinfo.c |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

