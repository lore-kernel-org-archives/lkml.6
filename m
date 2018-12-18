Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AB8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4D5218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151377;
	bh=wW2OUuaod2EWpg0l1Nu3vSNa6dw8GBCKSPjPhgUppe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JfiT6qFM7BaL/YKAgyxnCLVkUdatFb//c8wJv8h/Kuzyc7N8zocQKfHfNW+Ew+PjG
	 pGAG+j/EUiODEXetFm40I2ESVDH2zS1TUNO2E2tPYwVOyQZdwlca9oJhvXBpfK+plk
	 R9trUIjrMIKgWQKbYnvqKj7aMBPBMyn20CGrwgq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeLRQlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbeLRQln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959CD21873;
        Tue, 18 Dec 2018 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151303;
        bh=wW2OUuaod2EWpg0l1Nu3vSNa6dw8GBCKSPjPhgUppe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2l6wIOcJPWlDwgoRa6H8YHgd30Nz2XO7Gw7h6XIET1PMKYvClS62vtkQOG7TU0cGi
         g9Ei96sHsoZLtPNDeDPiedBIawZXC9lhkLnQJ3agIp3Pi+uk9+Cxjcxj4md1tikEu8
         kAkINwC+iju+iRTVj4+KS0AdG4Y4T9RwXvpcnx/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.19 29/44] tracing: Fix memory leak of instance function hash filters
Date:   Tue, 18 Dec 2018 17:39:41 +0100
Message-Id: <20181218163930.874700292@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5460,6 +5460,7 @@ void ftrace_destroy_filter_files(struct
 	if (ops->flags & FTRACE_OPS_FL_ENABLED)
 		ftrace_shutdown(ops, 0);
 	ops->flags |= FTRACE_OPS_FL_DELETED;
+	ftrace_free_filter(ops);
 	mutex_unlock(&ftrace_lock);
 }
 


