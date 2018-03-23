Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804660-2-14626800228917442973
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
    t=1521804659; b=h0QnULd3gL0JgUueJl+Gnk8oOJ/COiNG+7j/CI3pwQWSKhY
    sJ1c8Scziw2+YSZHeqhgCW605OVxu1qf11cYZjAVYL1wGjbARcH1+XqKZQehscyz
    ZA3TvUpvzhMtVkoz6kY+7RTnyoQ6F1An4jfwy9ldgqzbiZYGN8+tMWUqDRpnqUOV
    E5cRStfp5ThNQllvDCG3qSjXJsg+FefNOopiM2Xr1L8VPipLgyfnejyYINw++4yH
    /GfWWyJ29FRKOV7jrgQHw5RNuw+yUxsOkdNEYXsjVnXh4rY2SwYSDkZckuT+5qAi
    uk6L48zWfHdVSl3M3TnWuy7SMjqq34nezGuYxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804659; bh=F+grc00UXFo7y8hCrRysH4gbib
    nx6OO5/gB3d6CUL64=; b=b+gHrVPbfm+cyd8diggK8uQc4w2lG9f/aMh08nJpva
    n9d96ipaalQeTnU2coKkjKg0OZrsj+eGBWRlMnvKGRnE934MskxQQo6Asia4+hbu
    Y81T68KJt0Qj0KcfwABbhJvlPayvsFAFQO1CL4BWYdqv0ajG0VunTdHgc6pMxm6o
    6KP3XR5RTuqg/auWDA91EYpdQU5e/nukgk8NwnJhRGSSYGrpWhxM4B6h7rWk9jzD
    RmkGbROGVDcL9uz6dyTwWFrLLS4ruA2anvAuGTXwbz8J5APKmmBSF9bgRnMxnEtO
    dpCA52suLwC+UknNx7nd/skVhjA7vWPdzaRiK9AL9Lcg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1754813AbeCWKGQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755146AbeCWKGO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 051/177] IB/mlx5: Set correct SL in completion for RoCE
Date: Fri, 23 Mar 2018 10:52:59 +0100
Message-Id: <20180323094207.575845755@linuxfoundation.org>
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

From: Moni Shoua <monis@mellanox.com>


[ Upstream commit 12f8fedef2ec94c783f929126b20440a01512c14 ]

There is a difference when parsing a completion entry between Ethernet
and IB ports. When link layer is Ethernet the bits describe the type of
L3 header in the packet. In the case when link layer is Ethernet and VLAN
header is present the value of SL is equal to the 3 UP bits in the VLAN
header. If VLAN header is not present then the SL is undefined and consumer
of the completion should check if IB_WC_WITH_VLAN is set.

While that, this patch also fills the vlan_id field in the completion if
present.

Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/cq.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -172,6 +172,8 @@ static void handle_responder(struct ib_w
 	struct mlx5_ib_srq *srq;
 	struct mlx5_ib_wq *wq;
 	u16 wqe_ctr;
+	u8  roce_packet_type;
+	bool vlan_present;
 	u8 g;
 
 	if (qp->ibqp.srq || qp->ibqp.xrcd) {
@@ -223,7 +225,6 @@ static void handle_responder(struct ib_w
 		break;
 	}
 	wc->slid	   = be16_to_cpu(cqe->slid);
-	wc->sl		   = (be32_to_cpu(cqe->flags_rqpn) >> 24) & 0xf;
 	wc->src_qp	   = be32_to_cpu(cqe->flags_rqpn) & 0xffffff;
 	wc->dlid_path_bits = cqe->ml_path;
 	g = (be32_to_cpu(cqe->flags_rqpn) >> 28) & 3;
@@ -237,10 +238,22 @@ static void handle_responder(struct ib_w
 		wc->pkey_index = 0;
 	}
 
-	if (ll != IB_LINK_LAYER_ETHERNET)
+	if (ll != IB_LINK_LAYER_ETHERNET) {
+		wc->sl = (be32_to_cpu(cqe->flags_rqpn) >> 24) & 0xf;
 		return;
+	}
+
+	vlan_present = cqe->l4_l3_hdr_type & 0x1;
+	roce_packet_type   = (be32_to_cpu(cqe->flags_rqpn) >> 24) & 0x3;
+	if (vlan_present) {
+		wc->vlan_id = (be16_to_cpu(cqe->vlan_info)) & 0xfff;
+		wc->sl = (be16_to_cpu(cqe->vlan_info) >> 13) & 0x7;
+		wc->wc_flags |= IB_WC_WITH_VLAN;
+	} else {
+		wc->sl = 0;
+	}
 
-	switch (wc->sl & 0x3) {
+	switch (roce_packet_type) {
 	case MLX5_CQE_ROCE_L3_HEADER_TYPE_GRH:
 		wc->network_hdr_type = RDMA_NETWORK_IB;
 		break;
