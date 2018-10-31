Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34606C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDFF20847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2s3alyFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDFF20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbeKAIZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbeKAIKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D45642085A;
        Wed, 31 Oct 2018 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027426;
        bh=rcNyCzLiMrEaw+rG3mWDaQPW2Myb78LbLCDeCp7aewE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2s3alyFH28T3ctWXozRKnDqEX8vpUAI3grz5S5SX6HtfqH9ppyED1UfhOUtM7D3Mr
         ua6Rqlbnff9iYUbtYTM+PKwIEpFMa2l9x7RE2il4/G5r8+Mb0qGd4+BygMq9dq6Gi2
         7wCS3KNBfVuxTRaSdkXekFGHS8fBrcgATwRKvUHE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 42/73] UAPI: ndctl: Fix g++-unsupported initialisation in headers
Date:   Wed, 31 Oct 2018 19:09:17 -0400
Message-Id: <20181031230948.29203-42-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 9607871f37dc3e717639694b8d0dc738f2a68efc ]

The following code in the linux/ndctl header file:

	static inline const char *nvdimm_bus_cmd_name(unsigned cmd)
	{
		static const char * const names[] = {
			[ND_CMD_ARS_CAP] = "ars_cap",
			[ND_CMD_ARS_START] = "ars_start",
			[ND_CMD_ARS_STATUS] = "ars_status",
			[ND_CMD_CLEAR_ERROR] = "clear_error",
			[ND_CMD_CALL] = "cmd_call",
		};

		if (cmd < ARRAY_SIZE(names) && names[cmd])
			return names[cmd];
		return "unknown";
	}

is broken in a number of ways:

 (1) ARRAY_SIZE() is not generally defined.

 (2) g++ does not support "non-trivial" array initialisers fully yet.

 (3) Every file that calls this function will acquire a copy of names[].

The same goes for nvdimm_cmd_name().

Fix all three by converting to a switch statement where each case returns a
string.  That way if cmd is a constant, the compiler can trivially reduce it
and, if not, the compiler can use a shared lookup table if it thinks that is
more efficient.

A better way would be to remove these functions and their arrays from the
header entirely.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/ndctl.h | 48 +++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index 3f03567631cb..145f242c7c90 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -176,37 +176,31 @@ enum {
 
 static inline const char *nvdimm_bus_cmd_name(unsigned cmd)
 {
-	static const char * const names[] = {
-		[ND_CMD_ARS_CAP] = "ars_cap",
-		[ND_CMD_ARS_START] = "ars_start",
-		[ND_CMD_ARS_STATUS] = "ars_status",
-		[ND_CMD_CLEAR_ERROR] = "clear_error",
-		[ND_CMD_CALL] = "cmd_call",
-	};
-
-	if (cmd < ARRAY_SIZE(names) && names[cmd])
-		return names[cmd];
-	return "unknown";
+	switch (cmd) {
+	case ND_CMD_ARS_CAP:		return "ars_cap";
+	case ND_CMD_ARS_START:		return "ars_start";
+	case ND_CMD_ARS_STATUS:		return "ars_status";
+	case ND_CMD_CLEAR_ERROR:	return "clear_error";
+	case ND_CMD_CALL:		return "cmd_call";
+	default:			return "unknown";
+	}
 }
 
 static inline const char *nvdimm_cmd_name(unsigned cmd)
 {
-	static const char * const names[] = {
-		[ND_CMD_SMART] = "smart",
-		[ND_CMD_SMART_THRESHOLD] = "smart_thresh",
-		[ND_CMD_DIMM_FLAGS] = "flags",
-		[ND_CMD_GET_CONFIG_SIZE] = "get_size",
-		[ND_CMD_GET_CONFIG_DATA] = "get_data",
-		[ND_CMD_SET_CONFIG_DATA] = "set_data",
-		[ND_CMD_VENDOR_EFFECT_LOG_SIZE] = "effect_size",
-		[ND_CMD_VENDOR_EFFECT_LOG] = "effect_log",
-		[ND_CMD_VENDOR] = "vendor",
-		[ND_CMD_CALL] = "cmd_call",
-	};
-
-	if (cmd < ARRAY_SIZE(names) && names[cmd])
-		return names[cmd];
-	return "unknown";
+	switch (cmd) {
+	case ND_CMD_SMART:			return "smart";
+	case ND_CMD_SMART_THRESHOLD:		return "smart_thresh";
+	case ND_CMD_DIMM_FLAGS:			return "flags";
+	case ND_CMD_GET_CONFIG_SIZE:		return "get_size";
+	case ND_CMD_GET_CONFIG_DATA:		return "get_data";
+	case ND_CMD_SET_CONFIG_DATA:		return "set_data";
+	case ND_CMD_VENDOR_EFFECT_LOG_SIZE:	return "effect_size";
+	case ND_CMD_VENDOR_EFFECT_LOG:		return "effect_log";
+	case ND_CMD_VENDOR:			return "vendor";
+	case ND_CMD_CALL:			return "cmd_call";
+	default:				return "unknown";
+	}
 }
 
 #define ND_IOCTL 'N'
-- 
2.17.1

