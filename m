Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802721-5-11022057651613163536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802721; b=XdYR7znL4Wuk9vyr0fAEn7uwbyliG9NGkO50WBr4s38TRpG
    Yxy3b5ohn/GdOjSA5pWQ9Y5Ff8pGdrGteSD4P8ScpveUPbEYtOvh0Elneu2Ma5oK
    NXalRlfH/Be5P/5J9k3+PX1RLoqztIlAtlsUjHGfdEHSLSnRUSvbTNT/wgbfV5Zg
    s45IeMHbKWEcgYfuuDUeRn7DUvEhF0E2Ayeb+YwdjNSOYI61FDJYP2kzfkrByFWU
    TsvbFgVGaBjfvO0/O09AHb9SHVE4i/MfP56W1qIqVneliOTtROCh3CGVlqXntXiP
    JLWFDbcqepdft3RKMQeHseVRZsJR2/9LD7lmMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802721; bh=Nn2C/O+S70jZ1GF4pSziyaa5vG
    s95uq0pjYXmx6SXcU=; b=D6o4vruRA2kn/vDpDkRRWsb3TtKT7G319MOnLn5f6A
    BkQo1/XjjA9YlXwMxhYv2bH+BCHChqUuKQWLp+IMbSo2/PAmwTYr5YuNCUCwu3cU
    l9uTkP+Q+1nohbNq/gPWvX1sgGdHf26LwXDCkq3pLanRCEBmNFxUeGHY87KgkBSj
    C7iQhmX32ZGFqYkFW8TdF+OLX2RxvAsLm05wZbpo2+m19RH81ZtzVfIPhOx5ZR9m
    fR5uPEPB4WTxPoDkkByhXABTC+cS1tSyTitIK6pBZYbLhfP4E7vDAmcySSu9NjNW
    vcXeuviHXcxIo/7UYTcaZ3uQWnm78sexahr6uYCo3tfg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeCWKMk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:12:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933256AbeCWKMj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.9 172/177] IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
Date: Fri, 23 Mar 2018 10:55:00 +0100
Message-Id: <20180323094212.739234676@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Pismenny <borisp@mellanox.com>

commit c2b37f76485f073f020e60b5954b6dc4e55f693c upstream.

This patch validates user provided input to prevent integer overflow due
to integer manipulation in the mlx5_ib_create_srq function.

Cc: syzkaller <syzkaller@googlegroups.com>
Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/srq.c |   15 +++++++++------
 include/linux/mlx5/driver.h      |    4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -243,8 +243,8 @@ struct ib_srq *mlx5_ib_create_srq(struct
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_srq *srq;
-	int desc_size;
-	int buf_size;
+	size_t desc_size;
+	size_t buf_size;
 	int err;
 	struct mlx5_srq_attr in = {0};
 	__u32 max_srq_wqes = 1 << MLX5_CAP_GEN(dev->mdev, log_max_srq_sz);
@@ -268,15 +268,18 @@ struct ib_srq *mlx5_ib_create_srq(struct
 
 	desc_size = sizeof(struct mlx5_wqe_srq_next_seg) +
 		    srq->msrq.max_gs * sizeof(struct mlx5_wqe_data_seg);
+	if (desc_size == 0 || srq->msrq.max_gs > desc_size)
+		return ERR_PTR(-EINVAL);
 	desc_size = roundup_pow_of_two(desc_size);
-	desc_size = max_t(int, 32, desc_size);
+	desc_size = max_t(size_t, 32, desc_size);
+	if (desc_size < sizeof(struct mlx5_wqe_srq_next_seg))
+		return ERR_PTR(-EINVAL);
 	srq->msrq.max_avail_gather = (desc_size - sizeof(struct mlx5_wqe_srq_next_seg)) /
 		sizeof(struct mlx5_wqe_data_seg);
 	srq->msrq.wqe_shift = ilog2(desc_size);
 	buf_size = srq->msrq.max * desc_size;
-	mlx5_ib_dbg(dev, "desc_size 0x%x, req wr 0x%x, srq size 0x%x, max_gs 0x%x, max_avail_gather 0x%x\n",
-		    desc_size, init_attr->attr.max_wr, srq->msrq.max, srq->msrq.max_gs,
-		    srq->msrq.max_avail_gather);
+	if (buf_size < desc_size)
+		return ERR_PTR(-EINVAL);
 	in.type = init_attr->srq_type;
 
 	if (pd->uobject)
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -380,8 +380,8 @@ struct mlx5_core_srq {
 	struct mlx5_core_rsc_common	common; /* must be first */
 	u32		srqn;
 	int		max;
-	int		max_gs;
-	int		max_avail_gather;
+	size_t		max_gs;
+	size_t		max_avail_gather;
 	int		wqe_shift;
 	void (*event)	(struct mlx5_core_srq *, enum mlx5_event);
 
