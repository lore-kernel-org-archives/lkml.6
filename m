Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74076C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5532087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiTqQSIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5532087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbeJICEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbeJICEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62707204FD;
        Mon,  8 Oct 2018 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024661;
        bh=VyaRao/hSpi2MbNiS3lD/XfHVHGrTJSknjf0haIoxOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiTqQSIGnnm8NhbpbhEiSQm0L5TDIbBIe8osHSvqi5yINr4/8Ayjh7vjykHDBOAi6
         1uWmiGPBT8V5hlZF8uFcPcnH1C4RrrxCzHobhVc5f9FhdZY1X6RcOq6/QaDlR3+LHa
         iKZaH2KO+wWjLzBnnghnIeY2EtBmkhO+yRNLO0vU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 089/168] perf annotate: Properly interpret indirect call
Date:   Mon,  8 Oct 2018 20:31:09 +0200
Message-Id: <20181008175623.444859570@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Martin Liška" <mliska@suse.cz>

[ Upstream commit 1dc27f63303db58ce1b1a6932d1825305f86d574 ]

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
#  --- /tmp/before 2018-08-28 11:16:03.238384143 -0300
#  +++ /tmp/after  2018-08-28 11:15:39.335341042 -0300
#  @@ -13274,7 +13274,7 @@
#                ↓ jle    128
#                  hash_value = hash_table->hash_func (key);
#                  mov    0x8(%rsp),%rdi
#  -  0.91       → callq  *30
#  +  0.91       → callq  *0x30(%r12)
#                  mov    $0x2,%r8d
#                  cmp    $0x2,%eax
#                  node_hash = hash_table->hashes[node_index];
#  @@ -13848,7 +13848,7 @@
#                   mov    %r14,%rdi
#                   sub    %rbx,%r13
#                   mov    %r13,%rdx
#  -              → callq  *38
#  +              → callq  *0x38(%r15)
#                   cmp    %rax,%r13
#     1.91        ↓ je     240
#            1b4:   mov    $0xffffffff,%r13d
#  @@ -14026,7 +14026,7 @@
#                   mov    %rcx,-0x500(%rbp)
#                   mov    %r15,%rsi
#                   mov    %r14,%rdi
#  -              → callq  *38
#  +              → callq  *0x38(%rax)
#                   mov    -0x500(%rbp),%rcx
#                   cmp    %rax,%rcx
#                 ↓ jne    9b0
<SNIP tons of other such cases>

Signed-off-by: Martin Liška <mliska@suse.cz>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Kim Phillips <kim.phillips@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/bd1f3932-be2b-85f9-7582-111ee0a43b07@suse.cz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/annotate.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -245,8 +245,14 @@ find_target:
 
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
 


