Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF24CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6CD20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v5Q4YQGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6CD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbeJQBRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:17:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D797204EC;
        Tue, 16 Oct 2018 17:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710739;
        bh=Vaz+9jtxsEItW+zQ0fqA3YgjkqyJ7POSScH+ivnlNgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v5Q4YQGocPdh+/ADL3djDByBFYyve/Xsf7TSqqB3Vz0pYtBpNn+N/eNyD7GFVzwJ7
         0gAoHT6hI9EL+lXzuJWTxBwI6ow298nZeckukX6tJmZuxUo5WNKak6cD8XMLi6eeAf
         XkMu5e033eY4v9SRmLtG2j3BkJABpXwvlCpBbubE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 71/71] ipv4: frags: precedence bug in ip_expire()
Date:   Tue, 16 Oct 2018 19:10:08 +0200
Message-Id: <20181016170542.957039013@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

(commit 70837ffe3085c9a91488b52ca13ac84424da1042 upstream)

We accidentally removed the parentheses here, but they are required
because '!' has higher precedence than '&'.

Fixes: fa0f527358bd ("ip: use rb trees for IP frag queue.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -203,7 +203,7 @@ static void ip_expire(unsigned long arg)
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMTIMEOUT);
 
-	if (!qp->q.flags & INET_FRAG_FIRST_IN)
+	if (!(qp->q.flags & INET_FRAG_FIRST_IN))
 		goto out;
 
 	/* sk_buff::dev and sk_buff::rbnode are unionized. So we


