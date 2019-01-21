Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1029C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F7E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079121;
	bh=5W1ALWuo4aSKflE2zyhzoOykiHHGaYEumgxXBYj6a1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvQ6UW0ynSfTFRY7/t7wZIV4Bnc1BCVprFErWINwgxDd47iPpgPfNP8ncpYh4atH6
	 bqocN8NY/HXE5S6mxNB7bHWSZPEZp94Vk8TL9SqRJon6665Lb4KMn8EmTYptzP0Z9V
	 5R9mdiBrlFHu7Lp/xX2RiCRqJGIyHZTYMc0y+/TM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfAUN6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:58:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732034AbfAUN6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:58:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3554E2084C;
        Mon, 21 Jan 2019 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079117;
        bh=5W1ALWuo4aSKflE2zyhzoOykiHHGaYEumgxXBYj6a1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3BxoYTqlKpFX/vG5W1HtXO9/gRhXvCF4iCnoj+X5MraXIcg42Inu/CKilWBklhzH
         GVEYSwBtuEve/yeIXGDaxsP2UnHgowRR2VfplfcIXtOe/u93sygbJ9C5p2fubA3sF+
         62H7c/7N+8giK6kIyLtKIjMJGmUwbJw/vxHK7xrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/99] Revert "scsi: target: iscsi: cxgbit: fix csk leak"
Date:   Mon, 21 Jan 2019 14:48:07 +0100
Message-Id: <20190121134914.499267920@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

This reverts commit c9cef2c71a89a2c926dae8151f9497e72f889315.

A wrong commit message was used for the stable commit because of a human
error (and duplicate commit subject lines).

This patch reverts this error, and the following patches add the two
upstream commits.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index b289b90ae6dc..8de16016b6de 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -631,11 +631,8 @@ static void cxgbit_send_halfclose(struct cxgbit_sock *csk)
 
 static void cxgbit_arp_failure_discard(void *handle, struct sk_buff *skb)
 {
-	struct cxgbit_sock *csk = handle;
-
 	pr_debug("%s cxgbit_device %p\n", __func__, handle);
 	kfree_skb(skb);
-	cxgbit_put_csk(csk);
 }
 
 static void cxgbit_abort_arp_failure(void *handle, struct sk_buff *skb)
@@ -1193,7 +1190,7 @@ cxgbit_pass_accept_rpl(struct cxgbit_sock *csk, struct cpl_pass_accept_req *req)
 	rpl5->opt0 = cpu_to_be64(opt0);
 	rpl5->opt2 = cpu_to_be32(opt2);
 	set_wr_txq(skb, CPL_PRIORITY_SETUP, csk->ctrlq_idx);
-	t4_set_arp_err_handler(skb, csk, cxgbit_arp_failure_discard);
+	t4_set_arp_err_handler(skb, NULL, cxgbit_arp_failure_discard);
 	cxgbit_l2t_send(csk->com.cdev, skb, csk->l2t);
 }
 
-- 
2.19.1



