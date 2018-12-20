Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421B8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACA02177B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297578;
	bh=Qtuqz8tGTFsD1y+7LX7keYd0LOKPrPtSpByXC5dsw5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lgehO1ztw2lcxpSQGhPaCngkVjsfHlRUXiTQe5VmxFfarYJClzlZLuiGnoWj7i01u
	 tybFE99ZCHDJJhyHsw1k2sHkdNGHrhrfCNtoxrCelofmxxONmWFolkODkN6O2/z3XA
	 R45xGfIaxhZcXyTedn4S6P/hJzqNPnEc1L0Udojk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeLTJTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbeLTJTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:19:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31FA12177B;
        Thu, 20 Dec 2018 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297572;
        bh=Qtuqz8tGTFsD1y+7LX7keYd0LOKPrPtSpByXC5dsw5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2G+A2Bqw/35hPcT2DBnk0ht3DJHdN+D3gB3bDmsIBcPxsR9hk6KjneU1jWr6I8arK
         VvAL8H4hpfqgtPXRmRyNAKp1/Nt2YRKSUSWW1qZ3q8cmPisXoIgZIMlN5we5uqPe+t
         L5X7SD7K1VuoouN6FO1jZ4FfTHazmyw3H6Ymtiiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 3.18 10/31] tracing: Fix memory leak of instance function hash filters
Date:   Thu, 20 Dec 2018 10:18:22 +0100
Message-Id: <20181220085743.000741369@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 2840f84f74035e5a535959d5f17269c69fa6edc5 upstream.

The following commands will cause a memory leak:

 # cd /sys/kernel/tracing
 # mkdir instances/foo
 # echo schedule > instance/foo/set_ftrace_filter
 # rmdir instances/foo

The reason is that the hashes that hold the filters to set_ftrace_filter and
set_ftrace_notrace are not freed if they contain any data on the instance
and the instance is removed.

Found by kmemleak detector.

Cc: stable@vger.kernel.org
Fixes: 591dffdade9f ("ftrace: Allow for function tracing instance to filter functions")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4496,6 +4496,7 @@ void ftrace_destroy_filter_files(struct
 	if (ops->flags & FTRACE_OPS_FL_ENABLED)
 		ftrace_shutdown(ops, 0);
 	ops->flags |= FTRACE_OPS_FL_DELETED;
+	ftrace_free_filter(ops);
 	mutex_unlock(&ftrace_lock);
 }
 


