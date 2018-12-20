Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270DDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E844D2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545299121;
	bh=XGWQ0oC2lpBUO3mxC3mG4+8DrfF0FSb786hvRXo/Vuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pMCyJZAwNNVvrdv3G7JnDEvT3YrkjJIGdvDT5EcApLCs1Zt48zqtXBL1e49m2ZUNH
	 AmSj1nutB1JNOiPyCghqO0NOSmkXtxcQAXYbjZlpm9HrEUAFAAqTPt59eEbwW/dE6c
	 dfkhIna5vn7jTFgs1wh2HUZJqhLWvofIWCLxnC0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbeLTJVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730950AbeLTJVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 165D021720;
        Thu, 20 Dec 2018 09:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297663;
        bh=XGWQ0oC2lpBUO3mxC3mG4+8DrfF0FSb786hvRXo/Vuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZyTzsBnEcQrGV0t2E5Rd9YfFwosq6vyermTdx4Ox8oGtKfQKnQYjU4NmFhxWn8sHD
         Rn18lSxtZmnnWI2fffnkvDHlgHGYY5bqyV3mIm80gqptP1kvlR9+xb/h4YlpmSAsGe
         morBVSreruUaY6upM7fB1LM2VmYGDOIwW6cOa/zI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.4 12/40] tracing: Fix memory leak of instance function hash filters
Date:   Thu, 20 Dec 2018 10:18:24 +0100
Message-Id: <20181220085826.971075022@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4767,6 +4767,7 @@ void ftrace_destroy_filter_files(struct
 	if (ops->flags & FTRACE_OPS_FL_ENABLED)
 		ftrace_shutdown(ops, 0);
 	ops->flags |= FTRACE_OPS_FL_DELETED;
+	ftrace_free_filter(ops);
 	mutex_unlock(&ftrace_lock);
 }
 


