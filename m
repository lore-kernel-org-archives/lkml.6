Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480D1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178D82184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217750;
	bh=XywuONYUbvnpLPhto4LEM6fqvo8oSzWFxY/v/QPWoPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QNrZW1x1UIDH8v0ALjA/M1d81QgFyYk3IeHX0GRfYHw82kSLuW30g9Myp9fQ6y/0v
	 uxeh2MXtOy7ZuneB8Yn281iLm/vyqSNhUz5buAZx8BX39nMIKbmSlkl/FeBmZA7p0d
	 XjjTTS8hINaISVt+ZKc52HxUxgf5hOpkr7O+nyYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404170AbfAKOm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404157AbfAKOm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FAA520872;
        Fri, 11 Jan 2019 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217745;
        bh=XywuONYUbvnpLPhto4LEM6fqvo8oSzWFxY/v/QPWoPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0zWScB/H1cd+Qv2ouZBjHcQ8E553G7NHZ4ajRqpDMC0bl/7uAsTKjQIwjYycZkP8
         anxfMEpjYsPbhYhls+HIyDS4Pqets5AnsOASVsgwDs5rqxkmOg2Z6Bv9nxyc/YtEtg
         anz/3JAnNyLg36pNYmMb0pgO7Q38BKCFsiWN21hk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 25/65] Fix failure path in alloc_pid()
Date:   Fri, 11 Jan 2019 15:15:11 +0100
Message-Id: <20190111131059.825870605@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

From: Matthew Wilcox <willy@infradead.org>

commit 1a80dade010c7a7f4885a4c4c2a7ac22cc7b34df upstream.

The failure path removes the allocated PIDs from the wrong namespace.
This could lead to us inadvertently reusing PIDs in the leaf namespace
and leaking PIDs in parent namespaces.

Fixes: 95846ecf9dac ("pid: replace pid bitmap implementation with IDR API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/pid.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -233,8 +233,10 @@ out_unlock:
 
 out_free:
 	spin_lock_irq(&pidmap_lock);
-	while (++i <= ns->level)
-		idr_remove(&ns->idr, (pid->numbers + i)->nr);
+	while (++i <= ns->level) {
+		upid = pid->numbers + i;
+		idr_remove(&upid->ns->idr, upid->nr);
+	}
 
 	/* On failure to allocate the first pid, reset the state */
 	if (ns->pid_allocated == PIDNS_ADDING)


