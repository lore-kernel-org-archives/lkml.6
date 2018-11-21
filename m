Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FE52151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+JcaCqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FE52151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbeKVFml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387645AbeKVFmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B66214D9;
        Wed, 21 Nov 2018 19:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827227;
        bh=wWNJuOlR9UkZ6PAiDPXnr/UtbBHv9WIHmSwr5E0mdGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+JcaCqupl0WCMNMCWI9NXkRujQIZ04etPEtuwEeHpJ7NBaSMe2th/DQkiGG1WtUo
         cOpFUvELlD3eI9fDjzYiUOyzYYP29IGz8Hz4WlRPeWYWiRKXF/4Q6T54n1wbDRApoO
         qKIiTFUKuFzg92cwOLFdR6sCFPeEfh2YWUEiN1Hk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 22/42] Revert "sctp: remove sctp_transport_pmtu_check"
Date:   Wed, 21 Nov 2018 20:05:58 +0100
Message-Id: <20181121183148.979459988@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 69fec325a64383667b8a35df5d48d6ce52fb2782 ]

This reverts commit 22d7be267eaa8114dcc28d66c1c347f667d7878a.

The dst's mtu in transport can be updated by a non sctp place like
in xfrm where the MTU information didn't get synced between asoc,
transport and dst, so it is still needed to do the pmtu check
in sctp_packet_config.

Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sctp/sctp.h |   12 ++++++++++++
 net/sctp/output.c       |    3 +++
 2 files changed, 15 insertions(+)

--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -608,4 +608,16 @@ static inline __u32 sctp_dst_mtu(const s
 				 SCTP_DEFAULT_MINSEGMENT));
 }
 
+static inline bool sctp_transport_pmtu_check(struct sctp_transport *t)
+{
+	__u32 pmtu = sctp_dst_mtu(t->dst);
+
+	if (t->pathmtu == pmtu)
+		return true;
+
+	t->pathmtu = pmtu;
+
+	return false;
+}
+
 #endif /* __net_sctp_h__ */
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -118,6 +118,9 @@ void sctp_packet_config(struct sctp_pack
 		sctp_transport_route(tp, NULL, sp);
 		if (asoc->param_flags & SPP_PMTUD_ENABLE)
 			sctp_assoc_sync_pmtu(asoc);
+	} else if (!sctp_transport_pmtu_check(tp)) {
+		if (asoc->param_flags & SPP_PMTUD_ENABLE)
+			sctp_assoc_sync_pmtu(asoc);
 	}
 
 	if (asoc->pmtu_pending) {


