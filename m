Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B3CC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54D521873
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865132;
	bh=gXURwoeuxwDrFynjjhxvPRTT2jiP3keZIAq4gSbQcNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aRDqZqY1ofx+TDp+9/O1DClFsc5CCs1aSlI0hisnqLkh/pEC0xtdbwS1HhKU+GctX
	 IuyfrCbkCweA4K8k4s86ajcmRPwka1+h8Uxs+QHB6tk0M3Wew9iKE092JDK6OWRWiU
	 b6JpAkz1UxjPazqbx37eyx6eVDMFGUzicAsD6B3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfAGMpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbfAGMp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387492183E;
        Mon,  7 Jan 2019 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865127;
        bh=gXURwoeuxwDrFynjjhxvPRTT2jiP3keZIAq4gSbQcNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/We5NknCgADNRDViThxaHrnJ8SWja1xDuA8gN5ipjG/vgjTSZ2qTwhEtEo/Kyd/z
         RgHw+S5EK0YolDl8dS/krk7y9wGIpkiA6KG+GP7zqYjatV70WvuTFjPp2dnn2xXDw0
         VKWl8EUusjWy4uIEZaxdoXOPDPH2UhThjT6MyFn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 012/170] net: core: Fix Spectre v1 vulnerability
Date:   Mon,  7 Jan 2019 13:30:39 +0100
Message-Id: <20190107104454.482721892@linuxfoundation.org>
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

[ Upstream commit 50d5258634aee2e62832aa086d2fb0de00e72b91 ]

flen is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/core/filter.c:1101 bpf_check_classic() warn: potential spectre issue 'filter' [w]

Fix this by sanitizing flen before using it to index filter at line 1101:

	switch (filter[flen - 1].code) {

and through pc at line 1040:

	const struct sock_filter *ftest = &filter[pc];

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -68,6 +68,7 @@
 #include <linux/seg6_local.h>
 #include <net/seg6.h>
 #include <net/seg6_local.h>
+#include <linux/nospec.h>
 
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
@@ -1033,6 +1034,7 @@ static int bpf_check_classic(const struc
 	bool anc_found;
 	int pc;
 
+	flen = array_index_nospec(flen, BPF_MAXINSNS + 1);
 	/* Check the filter code now */
 	for (pc = 0; pc < flen; pc++) {
 		const struct sock_filter *ftest = &filter[pc];


