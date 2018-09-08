Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39059C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C6320645
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i61+rhVT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QQyRMgKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C6320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeIIBOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:14:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeIIBOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:14:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F4926029D; Sat,  8 Sep 2018 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438475;
        bh=TaRl/MxrrLf6Qbwd4CMG77mIUVzj9WM9re940VH+6M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i61+rhVThsJFHChSL7IfWf7aOHlVWp/Kuq9ys2GzU00fwEndHotC6C6xDAxTfN03L
         +R23RfbbFz6e2/9HYy8ar1JRtHl5+omwQlKW1NpF77ZQSyfTDO/2O1vCK8DwJldOd5
         uPOC4XYYFtwaf8SSib5dq9RFudIblV9lFdqhnzXA=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06D366029D;
        Sat,  8 Sep 2018 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438473;
        bh=TaRl/MxrrLf6Qbwd4CMG77mIUVzj9WM9re940VH+6M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQyRMgKzC1WgR7XSo3k3vOOg4v6BBJtOICDH6nLGS9m8rVAN47J3rgRDnEEul6pqG
         zdXYQ9NNRcZHxUJnhqMpgLYgR0UUFJU7vUxFEYkSrG8B83x42CR/aVlyI23jurazT7
         5LbfPtEkLP3NKw9Tspu9QlA1Vmvf/6HIuUyRaEi4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06D366029D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 1/6] dt-bindings: ramoops: Add event-size property
Date:   Sun,  9 Sep 2018 01:57:02 +0530
Message-Id: <4ec22906649fb3f6ab9570d8d4bf214e61512664.1536430404.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional property called event-size to reserve
log buffer for trace events.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 .../devicetree/bindings/reserved-memory/ramoops.txt        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
index 0eba562fe5c6..4f835ef65635 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
@@ -14,8 +14,8 @@ Any remaining space will be used for a circular buffer of oops and panic
 records.  These records have a configurable size, with a size of 0 indicating
 that they should be disabled.
 
-At least one of "record-size", "console-size", "ftrace-size", or "pmsg-size"
-must be set non-zero, but are otherwise optional as listed below.
+At least one of "record-size", "console-size", "event-size", "ftrace-size", or
+"pmsg-size" must be set non-zero, but are otherwise optional as listed below.
 
 
 Required properties:
@@ -36,6 +36,9 @@ Optional properties:
 - console-size: size in bytes of log buffer reserved for kernel messages
   (defaults to 0: disabled)
 
+- event-size: size in bytes of log buffer reserved for trace events
+  (defaults to 0: disabled)
+
 - ftrace-size: size in bytes of log buffer reserved for function tracing and
   profiling (defaults to 0: disabled)
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

