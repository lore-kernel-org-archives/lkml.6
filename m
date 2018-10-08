Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D61EC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371AA21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIodaAoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371AA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeJIBux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIBuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:50:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8030D2064A;
        Mon,  8 Oct 2018 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023869;
        bh=CFlIr9YQWTvU0kggpfehbKC8mBS3wmetnwwpz3rowmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIodaAoeAKWtdVEySdJKbYMI3DEwk3Uepx22YmkI96EQ/cLpB9II55nUVP2jEO3ae
         FjPPuDaZfsGrZTgB3tBLQQW4zz5aopllgBMYm0kpA6ys5KV6MTU7+Om8MTmp4+hht5
         WU/ZhZrYAzrli9xiskfTAnhRdFsF6pOqXOI6Hmrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashish Samant <ashish.samant@oracle.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Jun Piao <piaojun@huawei.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.4 113/113] ocfs2: fix locking for res->tracking and dlm->tracking_list
Date:   Mon,  8 Oct 2018 20:31:54 +0200
Message-Id: <20181008175537.476600591@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
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

From: Ashish Samant <ashish.samant@oracle.com>

commit cbe355f57c8074bc4f452e5b6e35509044c6fa23 upstream.

In dlm_init_lockres() we access and modify res->tracking and
dlm->tracking_list without holding dlm->track_lock.  This can cause list
corruptions and can end up in kernel panic.

Fix this by locking res->tracking and dlm->tracking_list with
dlm->track_lock instead of dlm->spinlock.

Link: http://lkml.kernel.org/r/1529951192-4686-1-git-send-email-ashish.samant@oracle.com
Signed-off-by: Ashish Samant <ashish.samant@oracle.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Acked-by: Joseph Qi <jiangqi903@gmail.com>
Acked-by: Jun Piao <piaojun@huawei.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ocfs2/dlm/dlmmaster.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -589,9 +589,9 @@ static void dlm_init_lockres(struct dlm_
 
 	res->last_used = 0;
 
-	spin_lock(&dlm->spinlock);
+	spin_lock(&dlm->track_lock);
 	list_add_tail(&res->tracking, &dlm->tracking_list);
-	spin_unlock(&dlm->spinlock);
+	spin_unlock(&dlm->track_lock);
 
 	memset(res->lvb, 0, DLM_LVB_LEN);
 	memset(res->refmap, 0, sizeof(res->refmap));


