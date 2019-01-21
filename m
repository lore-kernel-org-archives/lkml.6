Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE853C2F3D3
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A7020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079740;
	bh=BpjhqIE5OMVMEhINxkxYSiI2y9IAX1oTMadtbRkU6ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cHM4eQFg7DWn923P66dVBnvTFnVDLOnx11f0jQqtDja1H2oDs1GvNfIzWmvVlXeMv
	 eIUXHsOuJKcUcafk6b5w1/a2tw817l3Fc9Xht2BqYyfVqKrrjWZ2ognYKpB3eji2IX
	 +8dERbnTZ3XDPXrZuqMUYBGiucd1zNm2aU4kJVWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbfAUNzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbfAUNzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:55:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5F320879;
        Mon, 21 Jan 2019 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078945;
        bh=BpjhqIE5OMVMEhINxkxYSiI2y9IAX1oTMadtbRkU6ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uw3+wBWLHN3OwVgLVB28O+RM1gvL/JT9EhfwF/WGUQ4XCeAaVHZnChU3LZxqLijp2
         NYKiJIfFldJ8r+8kJPIP0MY+ty9rwvxhh+gRVdPBkfcvAVAtJelkxYpbNrev8KMtIC
         8Kfnrp9TH7mNZW0bxqi/GmsYda1YXYR1ZrjZqvp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 09/51] Revert "scsi: target: iscsi: cxgbit: fix csk leak"
Date:   Mon, 21 Jan 2019 14:44:05 +0100
Message-Id: <20190121122454.278633401@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 8323aafe67b31c7f73d18747604ba1cc6c3e4f3a.

A wrong commit message was used for the stable commit because of a human
error (and duplicate commit subject lines).

This patch reverts this error, and the following patches add the two
upstream commits.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 8652475e01d0..2fb1bf1a26c5 100644
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
@@ -1139,7 +1136,7 @@ cxgbit_pass_accept_rpl(struct cxgbit_sock *csk, struct cpl_pass_accept_req *req)
 	rpl5->opt0 = cpu_to_be64(opt0);
 	rpl5->opt2 = cpu_to_be32(opt2);
 	set_wr_txq(skb, CPL_PRIORITY_SETUP, csk->ctrlq_idx);
-	t4_set_arp_err_handler(skb, csk, cxgbit_arp_failure_discard);
+	t4_set_arp_err_handler(skb, NULL, cxgbit_arp_failure_discard);
 	cxgbit_l2t_send(csk->com.cdev, skb, csk->l2t);
 }
 
-- 
2.19.1



