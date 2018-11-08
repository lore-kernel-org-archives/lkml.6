Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F64FECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD632086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kra1pHtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD632086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeKIARq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeKIARp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:17:45 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33EAC20892;
        Thu,  8 Nov 2018 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541688117;
        bh=VMUgvlXkMfcL2JJXvNRSOmaz/rAl8H4JXhKPKCSnwY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Kra1pHtAahKTTIZ7akyl2ynBhOuDrrc3H0mMig42Bwjr4LTNZsAlHmlhMI8QxrjrF
         0UfGHzvX4RUoZotn+o+LRRH6aGtwrw3LKmQ46aiR+kWAhRNm7H9RzroYsKNm92NSjM
         iDZoNyzyxieAuWgiTMfg+H0nsOG+x8JLgrY1kIMc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     vincent@bernat.ch, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: Check keys for variable references in expressions too
Date:   Thu,  8 Nov 2018 08:41:49 -0600
Message-Id: <7fbe5b861d20215f41351d3fc8e70a8447be0000.1541687121.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1541687121.git.tom.zanussi@linux.intel.com>
References: <cover.1541687121.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1541687121.git.tom.zanussi@linux.intel.com>
References: <cover.1541687121.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

There's an existing check for variable references in keys, but it
doesn't go far enough.  It checks whether a key field is a variable
reference but doesn't check whether it's an expression containing
variable references, which can cause the same problems for callers.

Use the existing field_has_hist_vars() function rather than a direct
top-level flag check to catch all possible variable references.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Vincent Bernat <vincent@bernat.ch>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 3795207a48a0..bf993a9a65ec 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3970,8 +3970,8 @@ static int create_key_field(struct hist_trigger_data *hist_data,
 			goto out;
 		}
 
-		if (hist_field->flags & HIST_FIELD_FL_VAR_REF) {
-			hist_err("Using variable references as keys not supported: ", field_str);
+		if (field_has_hist_vars(hist_field, 0))	{
+			hist_err("Using variable references in keys not supported: ", field_str);
 			destroy_hist_field(hist_field, 0);
 			ret = -EINVAL;
 			goto out;
-- 
2.14.1

