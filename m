Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA29DC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD3D20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8HSH8sW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD3D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeKIIKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbeKIHhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:37 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2C7620818;
        Thu,  8 Nov 2018 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714408;
        bh=YJgSIwq/FHbuX/oxEIw8zmLh5sJhbf6uRrGthG7iKQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8HSH8sWjq6kgIAJGcBy6z9zpvyI9xVKQzyYJo1pAa0HmYPfqvG1LbwwwU7QNKjlh
         dFRQwPmO3HVAatNsoA0bACeKFht0xz+wBDgUT0+2SysjlcsZKTnQPdCLhogii0OBbP
         MZlAR5gvy2Y/eqqZBkI5jJEWL5RgSs/kRLpIG6JA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Yu <chianglungyu@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 039/114] perf/core: Dont leak event in the syscall error path
Date:   Thu,  8 Nov 2018 13:50:54 -0800
Message-Id: <20181108215104.648898045@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 201c2f85bd0bc13b712d9c0b3d11251b182e06ae ]

In the error path, event_file not being NULL is used to determine
whether the event itself still needs to be free'd, so fix it up to
avoid leaking.

Reported-by: Leon Yu <chianglungyu@gmail.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: 130056275ade ("perf: Do not double free")
Link: http://lkml.kernel.org/r/87twk06yxp.fsf@ashishki-desk.ger.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8532,6 +8532,7 @@ SYSCALL_DEFINE5(perf_event_open,
 					f_flags);
 	if (IS_ERR(event_file)) {
 		err = PTR_ERR(event_file);
+		event_file = NULL;
 		goto err_context;
 	}
 


