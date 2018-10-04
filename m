Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6ACC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A6B2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UsgFeTC6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oXSU5dQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A6B2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeJDWOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:14:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56522 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJDWOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:14:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1C3C860D78; Thu,  4 Oct 2018 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538666433;
        bh=9u0xT07ld+lLcCLWyAte72i16dsJNMbUZTZQZzOxcTA=;
        h=From:To:Cc:Subject:Date:From;
        b=UsgFeTC6NRYYz5BOK4j+M8h1beskr5Nmgj04MmJlRH+duihxuc8Z4+kxZxb8dVWGr
         0l/KxWXVrOECcTIC4CYdVCKc99k6jAUrJLk4FCdzt23/cQJiKGkvIArWXzRP5v/89A
         oKLIWgfTpjR4914qY451DdblO49BBfrHEy5hIsNg=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D769E60D2D;
        Thu,  4 Oct 2018 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538666432;
        bh=9u0xT07ld+lLcCLWyAte72i16dsJNMbUZTZQZzOxcTA=;
        h=From:To:Cc:Subject:Date:From;
        b=oXSU5dQcrYmkeASDfhyj+Pw90s0f74NBsO2tSBO7ehp3+GfBwzC9f+WXNfHlY72Dd
         C1m4CTnmlAGbZ2EbQyBbxcQD55yfztExBsGewGb56vQ5sxSSLjABVn07NvRgvHDN0L
         ThoIMu4VifvWfNE5dr+FCKGCY0csJ6rYFrhIyNHA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D769E60D2D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        jeremy.linton@arm.com
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v4 0/2] PPTT handle Handle architecturally unknown cache types
Date:   Thu,  4 Oct 2018 09:20:04 -0600
Message-Id: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
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

[v4]
-Collected all current tags and ammended to individual patches
-Removed PPTT_CHECKED_ATTRIBUTES

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

