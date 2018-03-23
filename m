Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807135-2-16463366919818030753
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807134; b=sZvywr4zuBpVOB7+cbC1puDrgElRXXzuzj6QwIPuEdvr68e
    eoOSKBK8NDZk8NMp3X3NBssHUYFyhIAFlzsvVBcVtrRau29YLA6Qe+fTaxLWScZ5
    Cip5VdSwKtN0EUIh44ySaKti+bb6lZ+dlCmGFJpmL8nZ00vvbfHrEa2tZjaOhbFS
    aZ5cwP0p9LN0njZ8AqAIXm4lVfB144cQF9A2cAKM349pzKIwn7UjB0h5D4OupR2I
    jHaLmyT+Fif1oKxg9yjAnn5QuGnfq5mF87x4cZB6s8Q8upmNfBMJZZSmnnFZewKy
    HBfMGOZh76DjO6sED9H3Em1mRu2JfjJ/6lGLqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807134; bh=c86C+Ayu1dFU+s7HcgMYGyY+17
    XQap+MDrSoovZggas=; b=I8vQpIq8jlkv1KeKRf1pFP2SneABfKak32C3Ef4o9o
    EErxwym2ZRDzSRIbxDWpyatuUseVtzt2yK2dPOdPhoa4HSBdcS28t5gPGXUwpnIn
    98BsicrJv1tNvPmaBDNg6Y1Yr6+bi4GBoFDkoeVsMtXPlRhC/LQM/47PW/n8+tvG
    ouhdLxkLViwBLXXLawkFiAXcT3gYPeCqC5I2YsN6Kf9RoroP9WL1wefZgPimIDTu
    e52WhjKpbl+EutVnJCsHRpDHFwHpDKxnoPskxc7OL+aLD2DyeGiXvB/I37TxqneT
    hYUtbT5pS1qTdq7ffH/5RXGAnkxVTe8zVEmPvqbYCH4A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1752897AbeCWJ5i (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:57:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeCWJ5g (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 42/84] iser-target: avoid reinitializing rdma contexts for isert commands
Date: Fri, 23 Mar 2018 10:53:56 +0100
Message-Id: <20180323095418.316618309@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bharat Potnuri <bharat@chelsio.com>


[ Upstream commit 66f53e6f5400578bae58db0c06d85a8820831f40 ]

isert commands that failed during isert_rdma_rw_ctx_post() are queued to
Queue-Full(QF) queue and are scheduled to be reposted during queue-full
queue processing. During this reposting, the rdma contexts are initialised
again in isert_rdma_rw_ctx_post(), which is leaking significant memory.

unreferenced object 0xffff8830201d9640 (size 64):
  comm "kworker/0:2", pid 195, jiffies 4295374851 (age 4528.436s)
  hex dump (first 32 bytes):
    00 60 8b cb 2e 00 00 00 00 10 00 00 00 00 00 00  .`..............
    00 90 e3 cb 2e 00 00 00 00 10 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8170711e>] kmemleak_alloc+0x4e/0xb0
    [<ffffffff811f8ba5>] __kmalloc+0x125/0x2b0
    [<ffffffffa046b24f>] rdma_rw_ctx_init+0x15f/0x6f0 [ib_core]
    [<ffffffffa07ab644>] isert_rdma_rw_ctx_post+0xc4/0x3c0 [ib_isert]
    [<ffffffffa07ad972>] isert_put_datain+0x112/0x1c0 [ib_isert]
    [<ffffffffa07dddce>] lio_queue_data_in+0x2e/0x30 [iscsi_target_mod]
    [<ffffffffa076c322>] target_qf_do_work+0x2b2/0x4b0 [target_core_mod]
    [<ffffffff81080c3b>] process_one_work+0x1db/0x5d0
    [<ffffffff8108107d>] worker_thread+0x4d/0x3e0
    [<ffffffff81088667>] kthread+0x117/0x150
    [<ffffffff81713fa7>] ret_from_fork+0x27/0x40
    [<ffffffffffffffff>] 0xffffffffffffffff

Here is patch to use the older rdma contexts while reposting
the isert commands intead of reinitialising them.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/isert/ib_isert.c |    7 +++++++
 drivers/infiniband/ulp/isert/ib_isert.h |    1 +
 2 files changed, 8 insertions(+)

--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2124,6 +2124,9 @@ isert_rdma_rw_ctx_post(struct isert_cmd
 	u32 rkey, offset;
 	int ret;
 
+	if (cmd->ctx_init_done)
+		goto rdma_ctx_post;
+
 	if (dir == DMA_FROM_DEVICE) {
 		addr = cmd->write_va;
 		rkey = cmd->write_stag;
@@ -2151,11 +2154,15 @@ isert_rdma_rw_ctx_post(struct isert_cmd
 				se_cmd->t_data_sg, se_cmd->t_data_nents,
 				offset, addr, rkey, dir);
 	}
+
 	if (ret < 0) {
 		isert_err("Cmd: %p failed to prepare RDMA res\n", cmd);
 		return ret;
 	}
 
+	cmd->ctx_init_done = true;
+
+rdma_ctx_post:
 	ret = rdma_rw_ctx_post(&cmd->rw, conn->qp, port_num, cqe, chain_wr);
 	if (ret < 0)
 		isert_err("Cmd: %p failed to post RDMA res\n", cmd);
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -126,6 +126,7 @@ struct isert_cmd {
 	struct rdma_rw_ctx	rw;
 	struct work_struct	comp_work;
 	struct scatterlist	sg;
+	bool			ctx_init_done;
 };
 
 static inline struct isert_cmd *tx_desc_to_cmd(struct iser_tx_desc *desc)
