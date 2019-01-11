Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA548C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1865206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218554;
	bh=Ao7BuDVbC3e/mcbonFTaUVD1u8L9By6XlkPxQR0lAyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G6Ll2L72Yf7/mVPAyd1qI8jpmg0meqWcrGQTNWXBnA86KbCww/AvHDef8fYaXK8Q7
	 T2LFlt9h+2h3jGTFCV5M0sjyX7G5TJrHWzFwMRsJDX/szp3H59VbbJupTJfcqHJDbo
	 2dQS384CJbyP9OlPkvh23cGgoh3Sg0H3KdHtCQ8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbfAKOgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:56602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390338AbfAKOgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DEEA204EC;
        Fri, 11 Jan 2019 14:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217377;
        bh=Ao7BuDVbC3e/mcbonFTaUVD1u8L9By6XlkPxQR0lAyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFbFOLHNaeese7A6NkESNZqqGCA3a7FGvsZXiP8qrvpMO4ffRKOdlqHwylTBvZXjM
         E7S91ctoGQ0gr7es9J+1OGbCSQMN+q83Vnhrs4eckegU5Wv2HlcFCJGg+OgUd40GMw
         1ZQl1YBREHss9ZOjALFmIEHNrinj2Rcj/1Mkil1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/148] scsi: target: iscsi: cxgbit: fix csk leak
Date:   Fri, 11 Jan 2019 15:13:37 +0100
Message-Id: <20190111131115.852809858@linuxfoundation.org>
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

[ Upstream commit 801df68d617e3cb831f531c99fa6003620e6b343 ]

csk leak can happen if a new TCP connection gets established after
cxgbit_accept_np() returns, to fix this leak free remaining csk in
cxgbit_free_np().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 8de16016b6de..b289b90ae6dc 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -631,8 +631,11 @@ static void cxgbit_send_halfclose(struct cxgbit_sock *csk)
 
 static void cxgbit_arp_failure_discard(void *handle, struct sk_buff *skb)
 {
+	struct cxgbit_sock *csk = handle;
+
 	pr_debug("%s cxgbit_device %p\n", __func__, handle);
 	kfree_skb(skb);
+	cxgbit_put_csk(csk);
 }
 
 static void cxgbit_abort_arp_failure(void *handle, struct sk_buff *skb)
@@ -1190,7 +1193,7 @@ cxgbit_pass_accept_rpl(struct cxgbit_sock *csk, struct cpl_pass_accept_req *req)
 	rpl5->opt0 = cpu_to_be64(opt0);
 	rpl5->opt2 = cpu_to_be32(opt2);
 	set_wr_txq(skb, CPL_PRIORITY_SETUP, csk->ctrlq_idx);
-	t4_set_arp_err_handler(skb, NULL, cxgbit_arp_failure_discard);
+	t4_set_arp_err_handler(skb, csk, cxgbit_arp_failure_discard);
 	cxgbit_l2t_send(csk->com.cdev, skb, csk->l2t);
 }
 
-- 
2.19.1



