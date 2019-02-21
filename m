Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D9820838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760214;
	bh=EthhybdQADAHew4jQDwaHEzCs6h8WlOhhBcUUw4sfKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRBbfovsHvwjtakBiGWESuxhtOalszUazuJJm9hvf5o/eNsY3JLe/MoPqO9nLxEY0
	 iqtEiGFJ8vkbFbYEGGN/8BfBaabG/gqgeQi+2Pkng8hzCWwbceWs6L6cL2Xi7L2wpT
	 Q856zx0M+CbI/hl45alb9xzvyyYQf4Xtq8IkCFqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfBUOnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:43:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbfBUOn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:43:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042062084F;
        Thu, 21 Feb 2019 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760208;
        bh=EthhybdQADAHew4jQDwaHEzCs6h8WlOhhBcUUw4sfKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZHQukRkfcYMzrOigpyb8vvT7p9UpPogGdaODx3z/GAyzuNP86a/Fxl52POdIgtF+
         abZ3bKrfy9QowTFFNY1a8Y2MwXou9v3XYCPm4Gw+iE7rprU5fiF7LpttXYM2ahH4E9
         iDHLU6WA0huVHTRHIL869tlW3CRwDRTZwSAWOHEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.20 29/32] netfilter: nf_nat_snmp_basic: add missing length checks in ASN.1 cbs
Date:   Thu, 21 Feb 2019 15:36:17 +0100
Message-Id: <20190221125252.626191375@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit c4c07b4d6fa1f11880eab8e076d3d060ef3f55fc upstream.

The generic ASN.1 decoder infrastructure doesn't guarantee that callbacks
will get as much data as they expect; callbacks have to check the `datalen`
parameter before looking at `data`. Make sure that snmp_version() and
snmp_helper() don't read/write beyond the end of the packet data.

(Also move the assignment to `pdata` down below the check to make it clear
that it isn't necessarily a pointer we can use before the `datalen` check.)

Fixes: cc2d58634e0f ("netfilter: nf_nat_snmp_basic: use asn1 decoder library")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter/nf_nat_snmp_basic_main.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/ipv4/netfilter/nf_nat_snmp_basic_main.c
+++ b/net/ipv4/netfilter/nf_nat_snmp_basic_main.c
@@ -105,6 +105,8 @@ static void fast_csum(struct snmp_ctx *c
 int snmp_version(void *context, size_t hdrlen, unsigned char tag,
 		 const void *data, size_t datalen)
 {
+	if (datalen != 1)
+		return -EINVAL;
 	if (*(unsigned char *)data > 1)
 		return -ENOTSUPP;
 	return 1;
@@ -114,8 +116,11 @@ int snmp_helper(void *context, size_t hd
 		const void *data, size_t datalen)
 {
 	struct snmp_ctx *ctx = (struct snmp_ctx *)context;
-	__be32 *pdata = (__be32 *)data;
+	__be32 *pdata;
 
+	if (datalen != 4)
+		return -EINVAL;
+	pdata = (__be32 *)data;
 	if (*pdata == ctx->from) {
 		pr_debug("%s: %pI4 to %pI4\n", __func__,
 			 (void *)&ctx->from, (void *)&ctx->to);


