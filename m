Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32D3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BD0218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545165232;
	bh=DShZ37p9t1aZM4zJ5saDPKfIFa58z+3quR6CyzToK7E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pyRkshnv3mHYUCNognnSZigbNhTeiiTWievZ8GvWoLB7iuAVHiRgYGk6MzoZZKKRK
	 /eiA/sQ9Hd+0mcu4VcZuNZJyqPVKRd7j+fHyPolasovN9vbgRqKXEG6lMcqOOsMgKe
	 Fz3tCl5KxYystSJGK7EnHvnyZn4CwnKacVKIMmCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeLRUdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:33:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeLRUdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:33:51 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 425BE20675;
        Tue, 18 Dec 2018 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545165230;
        bh=DShZ37p9t1aZM4zJ5saDPKfIFa58z+3quR6CyzToK7E=;
        h=From:To:Cc:Subject:Date:From;
        b=NjnVUdv73lfm4tt28PSaCyJ28fOQJWgKW/CyRlb1PsK4m7orn0ANXZ7RxFMjW+SpW
         7GzYz4sVjAEPGIxhrcRjBSYZzsZr9xDOSovMde7N9EjjnXK1dkqx++MQbnuqaasVGr
         LPRmuShUAeBWw4OGV24fYRiMWyma6Q0XF2c/fCGE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 0/7] tracing: Hist trigger var-ref cleanup and comments
Date:   Tue, 18 Dec 2018 14:33:19 -0600
Message-Id: <cover.1545161087.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi,

This patchset is a standalone series broken out of the v8 version of
the 'tracing: Hist trigger snapshot and onchange additions' patchset.

It's a series of changes resulting from some suggestions from Namhyung
for making the variable-reference handling code more understandable
through some refactoring and comments.

It also added a new patch changing all strlen() to sizeof() for string
constants, in trace_events_hist.c

Also, in the 'tracing: Remove open-coding of hist trigger var_ref
management' patch, in create_var_ref(), moved the saving of ref_field
and update of ref_field->var_ref_idx into the 'if' as pointed out by
Dan Carpenter/smatch 0-day robot.

It doesn't introduce any functional changes and can be applied
independently of the other patchset.

Tom


The following changes since commit 5d6ddf6acce68d1290112cb08b12fd78b201e7d5:

  arm64: Use ftrace_graph_get_ret_stack() instead of curr_ret_stack (2018-12-08 22:21:31 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/hist-var-ref-cleanup-v1

Tom Zanussi (7):
  tracing: Remove unnecessary hist trigger struct field
  tracing: Change strlen to sizeof for hist trigger static strings
  tracing: Use var_refs[] for hist trigger reference checking
  tracing: Remove open-coding of hist trigger var_ref management
  tracing: Use hist trigger's var_ref array to destroy var_refs
  tracing: Remove hist trigger synth_var_refs
  tracing: Add hist trigger comments for variable-related fields

 kernel/trace/trace_events_hist.c | 267 +++++++++++++++++++++++----------------
 1 file changed, 156 insertions(+), 111 deletions(-)

-- 
2.14.1

