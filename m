Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB8ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D277120883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1XbVy8pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D277120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeKIARm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbeKIARm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:17:42 -0500
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C5712081D;
        Thu,  8 Nov 2018 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541688114;
        bh=RRG6Ylt5Ps3u6qQlwBTmarADn/arGNCwwdyoIMorASI=;
        h=From:To:Cc:Subject:Date:From;
        b=1XbVy8pGhaxzCgbk7F6EFxzcu8GeDKcZuqmTXt2nbAYxn8Hlb3ozu4w4zQSQ/IKYR
         TfoamaX95//2gww4YTZUGl9sp29HO0jnGO6s2oxWk0QXJ4QTPsdVHST9hzIWWIWt9D
         gXTe/ghYSV75ZoApjR8sNJfldg8vNU+e9JDGdoWk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     vincent@bernat.ch, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing: Fix NULL pointer bug in hist key expressions
Date:   Thu,  8 Nov 2018 08:41:47 -0600
Message-Id: <cover.1541687121.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hi Steve,

This is a fix for a user-reported bug in the hist triggers, where if a
variable reference is used in an expression in a histogram key, it
results in a NULL pointer dereference and subsequent Oops.

I separated the fix into two small patches, the first preventing the
immediate problem bu disallowing a var_ref from ever accessing a NULL
element, and the second disallowing a user from ever constructing such
a key.

Thanks,

Tom

The following changes since commit ee474b81fe5aa5dc0faae920bf66240fbf55f891:

  tracing/kprobes: Fix strpbrk() argument order (2018-11-05 09:47:14 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/key-ref-fix

Tom Zanussi (2):
  tracing: Prevent hist_field_var_ref() from accessing NULL
    tracing_map_elts
  tracing: Check keys for variable references in expressions too

 kernel/trace/trace_events_hist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.14.1

