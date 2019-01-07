Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1B6C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60202089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867055;
	bh=oPCrHrX9ZqlxMvDD2q7lz7GXv0buO9OPhJDx9TH6XtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ED3XSA/XzLj1dXGeA8ORJqWAOEK9cxQtbowwec1QvQgpaR/5gTsOAIApQdARA5oAl
	 vOcOob6o5N2eCXztHWq6fp88mt1yWrKhqN78MPMqXPP6ckuzcf1/11elDB6/F9WQJP
	 aoCg2NSErBi1cMPiQKjOWlEIQXBlWJt2RBM7p25I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfAGM7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730325AbfAGM7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C10F2089F;
        Mon,  7 Jan 2019 12:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865989;
        bh=oPCrHrX9ZqlxMvDD2q7lz7GXv0buO9OPhJDx9TH6XtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVJG1nnXZNnp+Mw6xz9Tkh4y0G45HUttDl5cz2ygfHcrf5kYfWCJArPhdObhNGrRF
         iOrzsQbLM9SdjN7oMRtoAbk3L1m4ZurcgcLD59zTCOYo6lCQ9a+q+5bEG37pTyHPNu
         SFXvRSoGXXC2RsYiUgVtwo8XSRhocOdO0SJxle+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 002/101] net: core: Fix Spectre v1 vulnerability
Date:   Mon,  7 Jan 2019 13:31:50 +0100
Message-Id: <20190107105330.528127680@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -56,6 +56,7 @@
 #include <net/busy_poll.h>
 #include <net/tcp.h>
 #include <linux/bpf_trace.h>
+#include <linux/nospec.h>
 
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
@@ -823,6 +824,7 @@ static int bpf_check_classic(const struc
 	bool anc_found;
 	int pc;
 
+	flen = array_index_nospec(flen, BPF_MAXINSNS + 1);
 	/* Check the filter code now */
 	for (pc = 0; pc < flen; pc++) {
 		const struct sock_filter *ftest = &filter[pc];


