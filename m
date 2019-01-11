Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5084FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1721721841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217681;
	bh=vEVaW8836Ts2jkbK9GqHiLxcWVwtrha3i6JCGn8K/uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KaZJk/PT53sAfM/U6CbrHJiQTckrEaxO4NyGzLOsu9gaJs9FoPyK61JANH9W62+6Q
	 ux4/qHRq5BOW28QHgfxMGgGJ/1TLvjBqFO36MbxXVYj7ndWYM1ZDuMTgmsttpITWrp
	 zeLHiNOwAaFtL6gR/ru9Qh0LykVoI6TPGl5vr3UA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403993AbfAKOlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390990AbfAKOlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EE8D2063F;
        Fri, 11 Jan 2019 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217676;
        bh=vEVaW8836Ts2jkbK9GqHiLxcWVwtrha3i6JCGn8K/uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpfCG+UeDsQ7HYrQxq25fge5DfxcECGjQ6fVjBN1FF2TSgDFLfCJTmTwfaz6MGoO+
         NHQmNaJkSFRl26lmN/n9PuFQtrJPPs28LfT1KvOpMUtRAyuZutQLUyvp95qAOchPXn
         Q/miL8MzZ8r8RY6DNUC/4vi/QDMqXBM95SepuMWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 111/148] Fix failure path in alloc_pid()
Date:   Fri, 11 Jan 2019 15:14:49 +0100
Message-Id: <20190111131118.694414566@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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


