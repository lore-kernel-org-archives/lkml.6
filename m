Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7C6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A46E2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217585;
	bh=ncBZs/RbNAKr8NePm2DxOWd893qoUkB39U2PSU37irg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ond/ZOZ6Ej2WZ3npkAH7rldNJZf34wUP2qKyNQzrW1ukMr+leR9mEgZzG0LJhOPWs
	 IMLUgrSiCxWisLez9LwVfwTH8w+JzQTikrH1dbQ2PpeT4Yzdq++k9v+qbK3Q7JTdAC
	 UL0APG8vyNeQFNBktIwsXVhl192tV5H4oaTyFJVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbfAKOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390222AbfAKOjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FDB72133F;
        Fri, 11 Jan 2019 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217581;
        bh=ncBZs/RbNAKr8NePm2DxOWd893qoUkB39U2PSU37irg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhX+R7FkB5syycvUkoSGA9kkmxQnMdBLekk4GcUmSiQeFcIfyotWwEJnCLAjnfHEL
         mgKGkrjnAmHG5QqrXeupVqYAIyzXrPath34hpg/DU+w2vkrpTcUPMYa4qGWGLtARn+
         l4gsaRlNfLXDaf8JFCmN6xopNcfAl21/XW6/svxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.19 115/148] dlm: possible memory leak on error path in create_lkb()
Date:   Fri, 11 Jan 2019 15:14:53 +0100
Message-Id: <20190111131118.852745140@linuxfoundation.org>
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

From: Vasily Averin <vvs@virtuozzo.com>

commit 23851e978f31eda8b2d01bd410d3026659ca06c7 upstream.

Fixes 3d6aa675fff9 ("dlm: keep lkbs in idr")
Cc: stable@kernel.org # 3.1

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dlm/lock.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1209,6 +1209,7 @@ static int create_lkb(struct dlm_ls *ls,
 
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
+		dlm_free_lkb(lkb);
 		return rv;
 	}
 


