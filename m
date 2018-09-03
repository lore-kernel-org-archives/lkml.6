Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA8EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18502086C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYsveRW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18502086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeICTNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICTNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:13:08 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07742086C;
        Mon,  3 Sep 2018 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535986357;
        bh=lxkngoD/4kXNjCGRDD196vmBWzjv6AwuYOh4K21IYjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYsveRW53vD0QQFzHuWcmSEJmnbvOwCbbGxyjJH0y5Jh24TC3tFXVsz+rgdksvBwk
         MMOrBAQGoMFfXXQEaxRG7AygMOz+0vh8Av82Vc1fCyt2U0tK1p3ByQrnrQSpbkMzoQ
         KAdxCeLmJaqZKyU5Sp69Oko+4PkikWEYIhXiKZfU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/13] perf annotate: Properly interpret indirect call
Date:   Mon,  3 Sep 2018 11:52:12 -0300
Message-Id: <20180903145224.12318-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Liška <mliska@suse.cz>

The patch changes the parsing of:

	callq  *0x8(%rbx)

from:

  0.26 │     → callq  *8

to:

  0.26 │     → callq  *0x8(%rbx)

in this case an address is followed by a register, thus one can't parse
only the address.

Committer testing:

1) run 'perf record sleep 10'
2) before applying the patch, run:

     perf annotate --stdio2 > /tmp/before

3) after applying the patch, run:

     perf annotate --stdio2 > /tmp/after

4) diff /tmp/before /tmp/after:
  --- /tmp/before 2018-08-28 11:16:03.238384143 -0300
  +++ /tmp/after  2018-08-28 11:15:39.335341042 -0300
  @@ -13274,7 +13274,7 @@
                ↓ jle    128
                  hash_value = hash_table->hash_func (key);
                  mov    0x8(%rsp),%rdi
  -  0.91       → callq  *30
  +  0.91       → callq  *0x30(%r12)
                  mov    $0x2,%r8d
                  cmp    $0x2,%eax
                  node_hash = hash_table->hashes[node_index];
  @@ -13848,7 +13848,7 @@
                   mov    %r14,%rdi
                   sub    %rbx,%r13
                   mov    %r13,%rdx
  -              → callq  *38
  +              → callq  *0x38(%r15)
                   cmp    %rax,%r13
     1.91        ↓ je     240
            1b4:   mov    $0xffffffff,%r13d
  @@ -14026,7 +14026,7 @@
                   mov    %rcx,-0x500(%rbp)
                   mov    %r15,%rsi
                   mov    %r14,%rdi
  -              → callq  *38
  +              → callq  *0x38(%rax)
                   mov    -0x500(%rbp),%rcx
                   cmp    %rax,%rcx
                 ↓ jne    9b0
<SNIP tons of other such cases>

Signed-off-by: Martin Liška <mliska@suse.cz>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Kim Phillips <kim.phillips@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 20061cf42288..e62b69ea87cd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -246,8 +246,14 @@ static int call__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 
 indirect_call:
 	tok = strchr(endptr, '*');
-	if (tok != NULL)
-		ops->target.addr = strtoull(tok + 1, NULL, 16);
+	if (tok != NULL) {
+		endptr++;
+
+		/* Indirect call can use a non-rip register and offset: callq  *0x8(%rbx).
+		 * Do not parse such instruction.  */
+		if (strstr(endptr, "(%r") == NULL)
+			ops->target.addr = strtoull(endptr, NULL, 16);
+	}
 	goto find_target;
 }
 
-- 
2.14.4

