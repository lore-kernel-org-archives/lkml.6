Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1370CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FFA20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlZMsRZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FFA20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbeKLIRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbeKLIRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:19 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AD6223B0;
        Sun, 11 Nov 2018 22:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975244;
        bh=HBcD7nrjT27F7Yo8fR/R2qQglW3nlmcxDe5LkV2LbGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MlZMsRZnEhhecyepRvpDGy9Jlf3e22JQ/s+L9xYeN3IqEnewnS9dPlf0yLD++EE4k
         iCBMwClf9Jj4/KJdu8E5IIlmyAX0pM9N/YDPFVAgWu7lVdQZpD3ZpyeTIU5yJZ6wdR
         W8FXCnr6h9tQXujHu1Z16+2qUTm1U13Ran4jjsgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sanskriti Sharma <sansharm@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 066/361] perf tools: Free printk string in parse_ftrace_printk()
Date:   Sun, 11 Nov 2018 14:16:53 -0800
Message-Id: <20181111221629.200032919@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanskriti Sharma <sansharm@redhat.com>

[ Upstream commit 9c8a182e5a73e01afd11742a2ab887bf338fdafd ]

parse_ftrace_printk() tokenizes and parses a line, calling strdup() each
iteration.  Add code to free this temporary format string duplicate.

Fixes the following coverity complaints:

  Error: RESOURCE_LEAK (CWE-772):
  tools/perf/util/trace-event-parse.c:158: overwrite_var: Overwriting
  "printk" in "printk = strdup(fmt + 1)" leaks the storage that "printk"
  points to.

  tools/perf/util/trace-event-parse.c:162: leaked_storage: Variable
  "printk" going out of scope leaks the storage it points to.

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-4-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/trace-event-parse.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -158,6 +158,7 @@ void parse_ftrace_printk(struct tep_hand
 		printk = strdup(fmt+1);
 		line = strtok_r(NULL, "\n", &next);
 		tep_register_print_string(pevent, printk, addr);
+		free(printk);
 	}
 }
 


