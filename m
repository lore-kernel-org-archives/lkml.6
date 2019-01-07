Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444E4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F9320859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865347;
	bh=Jb2/5CL62w9yQgmAOukgXo7E2fIoPC2BTMJ8vCSHyFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ah0SFO8AmFdHD3XShqEpRoJB6YQeNt766VyiSR3SpUAcl6xfU7EKtg/gvHjNH0u2L
	 /cyhl+MfH9YHEBwyUzQna+DitvSOE8p4h0fECurQHW+uJ0oF8eVNuAvVn2QjJm+/k2
	 +9t/ZwsNs695Az7FGphs1iiYGeaVstCQmHNOgX8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfAGMtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbfAGMtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CF120651;
        Mon,  7 Jan 2019 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865343;
        bh=Jb2/5CL62w9yQgmAOukgXo7E2fIoPC2BTMJ8vCSHyFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxfoJKYKme4JueurkMgXLaozX3qlMNYonDRr7E9+bcyd9fnFvEV0ojuaV0PCnELqh
         sFp+n847/BOglFNIkeM3zaNyuDADN1e4bXkMo7ZbHApKYpO6uALvvCcMRnpmxV3OMg
         oKHVvm1lxHRnDJmc+Fnh3i1KK6/ir6sLAOnwOEag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 025/170] phonet: af_phonet: Fix Spectre v1 vulnerability
Date:   Mon,  7 Jan 2019 13:30:52 +0100
Message-Id: <20190107104456.064296316@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit d686026b1e6ed4ea27d630d8f54f9a694db088b2 ]

protocol is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/phonet/af_phonet.c:48 phonet_proto_get() warn: potential spectre issue 'proto_tab' [w] (local cap)

Fix this by sanitizing protocol before using it to index proto_tab.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/phonet/af_phonet.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -34,6 +34,8 @@
 #include <net/phonet/phonet.h>
 #include <net/phonet/pn_dev.h>
 
+#include <linux/nospec.h>
+
 /* Transport protocol registration */
 static const struct phonet_protocol *proto_tab[PHONET_NPROTO] __read_mostly;
 
@@ -43,6 +45,7 @@ static const struct phonet_protocol *pho
 
 	if (protocol >= PHONET_NPROTO)
 		return NULL;
+	protocol = array_index_nospec(protocol, PHONET_NPROTO);
 
 	rcu_read_lock();
 	pp = rcu_dereference(proto_tab[protocol]);


