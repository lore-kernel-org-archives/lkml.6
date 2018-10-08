Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5223AC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9492087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfKvjHX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9492087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbeJICAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJICAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE96204FD;
        Mon,  8 Oct 2018 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024467;
        bh=gxUctPa8XgcIEbfQwXdRQQAEkVDqB2q+gB4TKrLDGVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfKvjHX3n9aX+rqTVuE1SyNOpTLHdkLBcCS1rXTIZT+J1JKg1LNMSPQdF2rwi5Vr/
         pCyLFKSZbEQLfEfJ4Q7/AvlZHA5jk1X8kUatdM/Gvof2RX95+/wMwyyxdYuyJi97qC
         y1SVHna6iWuRShZf7nok96p2PRAN6XBv093Y1iZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 049/168] selftests: pmtu: detect correct binary to ping ipv6 addresses
Date:   Mon,  8 Oct 2018 20:30:29 +0200
Message-Id: <20181008175621.919251665@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit c81c7012e0c769b5704c2b07bd5224965e76fb70 ]

Some systems don't have the ping6 binary anymore, and use ping for
everything. Detect the absence of ping6 and try to use ping instead.

Fixes: d1f1b9cbf34c ("selftests: net: Introduce first PMTU test")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/pmtu.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -46,6 +46,9 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+# Some systems don't have a ping6 binary anymore
+which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
+
 tests="
 	pmtu_vti6_exception		vti6: PMTU exceptions
 	pmtu_vti4_exception		vti4: PMTU exceptions
@@ -274,7 +277,7 @@ test_pmtu_vti6_exception() {
 	mtu "${ns_b}" veth_b 4000
 	mtu "${ns_a}" vti6_a 5000
 	mtu "${ns_b}" vti6_b 5000
-	${ns_a} ping6 -q -i 0.1 -w 2 -s 60000 ${vti6_b_addr} > /dev/null
+	${ns_a} ${ping6} -q -i 0.1 -w 2 -s 60000 ${vti6_b_addr} > /dev/null
 
 	# Check that exception was created
 	if [ "$(route_get_dst_pmtu_from_exception "${ns_a}" ${vti6_b_addr})" = "" ]; then


