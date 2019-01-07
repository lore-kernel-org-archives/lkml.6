Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61F1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AD020449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865022;
	bh=DOStrqzC/B2lJG/bFy4nOd7zXg0QZr1BFH1zffjpkpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mqG+NtL7k+0/bkNx+m6agg8YzVQwX0z3yEIdmseVHMFzc4JdrmE4++HfB4Dz1EuY1
	 h0la0x0DGM5rMHzgc+VmgmwjDBereWAbSi0kXBIVwMOJRSMXvdCrtrMq7PU3lAFAQ9
	 ADF7uAAHCCYBBmgOjL9u9qxkyHQofNssKq/bHdZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfAGMnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfAGMni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2969120449;
        Mon,  7 Jan 2019 12:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865017;
        bh=DOStrqzC/B2lJG/bFy4nOd7zXg0QZr1BFH1zffjpkpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aqpj1/Iv61rVqw2lFdYWFlsTPlMBz2NAr1g9exRwcdbURbAeg43ld6rFnLuvBBcKF
         2K+nv+YV6HS87P4iYVCrAcr1dhrWnI9gLdQud5CF0hDNgrngR/PhxZquseZdigFaL/
         1rWwGxi7oOrIpxhi+VG2Z4NfSl/vD+T3wkomNwgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.20 119/145] tools lib traceevent: Fix processing of dereferenced args in bprintk events
Date:   Mon,  7 Jan 2019 13:32:36 +0100
Message-Id: <20190107104452.785874755@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit f024cf085c423bac7512479f45c34ee9a24af7ce upstream.

In the case that a bprintk event has a dereferenced pointer that is
stored as a string, and there's more values to process (more args), the
arg was not updated to point to the next arg after processing the
dereferenced pointer, and it screwed up what was to be displayed.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 37db96bb49629 ("tools lib traceevent: Handle new pointer processing of bprint strings")
Link: http://lkml.kernel.org/r/20181210134522.3f71e2ca@gandalf.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/lib/traceevent/event-parse.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4970,6 +4970,7 @@ static void pretty_print(struct trace_se
 
 				if (arg->type == TEP_PRINT_BSTRING) {
 					trace_seq_puts(s, arg->string.string);
+					arg = arg->next;
 					break;
 				}
 


