Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD359ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3792081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3rg8McE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3792081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeKIARp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:17:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbeKIARo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:17:44 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB282086C;
        Thu,  8 Nov 2018 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541688116;
        bh=ZWLW47bXHn7F3r6H7XG7E2djdbp2iZLEvoiD+fZi5B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=T3rg8McEl7tozyTnP4fyfppFEazo0LoC5CeCem1yANzVrPvK/7zIem4lGOwmT2c25
         us9p7Vaxz1o2qm1dDNFLHAMLYcv79qt2SqWEZ2BU42dfc8LAOBnNiaccv3iGz2Ar99
         HZiV7Yzc8U5c6dKsIG2Pp8aN3nzuhkS+QJIhAlxE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     vincent@bernat.ch, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: Prevent hist_field_var_ref() from accessing NULL tracing_map_elts
Date:   Thu,  8 Nov 2018 08:41:48 -0600
Message-Id: <ed47313cdfa640c6df1c5e92cf950e83fddf3e3e.1541687121.git.tom.zanussi@linux.intel.com>
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

hist_field_var_ref() is an implementation of hist_field_fn_t(), which
can be called with a null tracing_map_elt elt param when assembling a
key in event_hist_trigger().

In the case of hist_field_var_ref() this doesn't make sense, because a
variable can only be resolved by looking it up using an already
assembled key i.e. a variable can't be used to assemble a key since
the key is required in order to access the variable.

Upper layers should prevent the user from constructing a key using a
variable in the first place, but in case one slips through, it
shouldn't cause a NULL pointer dereference.  Also if one does slip
through, we want to know about it, so emit a one-time warning in that
case.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reported-by: Vincent Bernat <vincent@bernat.ch>
---
 kernel/trace/trace_events_hist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index eb908ef2ecec..3795207a48a0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1632,6 +1632,9 @@ static u64 hist_field_var_ref(struct hist_field *hist_field,
 	struct hist_elt_data *elt_data;
 	u64 var_val = 0;
 
+	if (WARN_ON_ONCE(!elt))
+		return var_val;
+
 	elt_data = elt->private_data;
 	var_val = elt_data->var_ref_vals[hist_field->var_ref_idx];
 
-- 
2.14.1

