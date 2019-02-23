Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832BDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DED20652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eDCPmLQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfBWGez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:34:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44369 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfBWGex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:34:53 -0500
Received: by mail-qt1-f193.google.com with SMTP id d2so5077581qti.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 22:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zc6wY8rNCewGZVDgSPtq8BlfOuPURI6nN/IPxD75L4o=;
        b=eDCPmLQERqkYYc/bGxU7OS66Icgp+XunDLdFECdIPqDGXVeyhvqvuBAhTiXdAR99Dq
         s+GbkyxtCPFUulsLNPUdRTKGM0yr1m9jKQr9M2WpCmNb5xL1jyylsgvJeD71CIg0p0eu
         pfWs7ErgnCkoanOoY6gZQxnaRcq5DSWNmDVWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zc6wY8rNCewGZVDgSPtq8BlfOuPURI6nN/IPxD75L4o=;
        b=VJTPMZBaels+v38+xRKU+CJwDeH0Z1MUrATn1CTxzNhwpgB2S/nWBlZakpW2v27ehM
         GJmMROcQq6iRwtMmbyV8nbovmPfFx0S5pdEUoK4fyA9JXpMHO213+WExWaoibvbKDP7l
         KFVrkx/gMSfW+jUEwKdpKM1+27pXqEBOBjdrfAsF/Rtdd4QVvW8rAicIEkhJFTMBdM5K
         q3wikLKNQ/nDgylJ24Mn6rV6L1Irtu9VJT1pz+fYLczSX0Ga0l7bvJfuVKpUXYJN9qli
         z1EimaWlIGWTbpN7XjnpoPJTs+pHndrFDXMEgSJkBPEUwzEi1dxa9KuumrbuagCVeGsp
         wJxw==
X-Gm-Message-State: AHQUAuZRhaLcrpgv/R1Px3Y+2nmac1VILNUDA4FK40bi2WWTsVvd6Epv
        0vv1Huwd4bZyNBQ3Vxvn/lM7eTtULBo=
X-Google-Smtp-Source: AHgI3IYdAZ9LpDlYKNIOJJbI2dWRj2jR/BzqrefjE6BsZ3jOMxDi9AMbLP8ORBFoMg4jKW+d9sv/aQ==
X-Received: by 2002:a0c:9802:: with SMTP id c2mr6078462qvd.13.1550903691926;
        Fri, 22 Feb 2019 22:34:51 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d32sm2189408qtc.88.2019.02.22.22.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 22:34:50 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 1/6] net: rtnetlink: Fix incorrect RCU API usage
Date:   Sat, 23 Feb 2019 01:34:29 -0500
Message-Id: <20190223063434.6793-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190223063434.6793-1-joel@joelfernandes.org>
References: <20190223063434.6793-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtnl_register_internal() and rtnl_unregister_all tries to directly
dereference an RCU protected pointed outside RCU read side section.
While this is Ok to do since a lock is held, let us use the correct
API to avoid programmer bugs in the future.

This also fixes sparse warnings arising from not using RCU API.

net/core/rtnetlink.c:332:13: warning: incorrect type in assignment
(different address spaces) net/core/rtnetlink.c:332:13:    expected
struct rtnl_link **tab net/core/rtnetlink.c:332:13:    got struct
rtnl_link *[noderef] <asn:4>*<noident>

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/core/rtnetlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 5ea1bed08ede..98be4b4818a9 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -188,7 +188,7 @@ static int rtnl_register_internal(struct module *owner,
 	msgindex = rtm_msgindex(msgtype);
 
 	rtnl_lock();
-	tab = rtnl_msg_handlers[protocol];
+	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
 	if (tab == NULL) {
 		tab = kcalloc(RTM_NR_MSGTYPES, sizeof(void *), GFP_KERNEL);
 		if (!tab)
@@ -329,7 +329,7 @@ void rtnl_unregister_all(int protocol)
 	BUG_ON(protocol < 0 || protocol > RTNL_FAMILY_MAX);
 
 	rtnl_lock();
-	tab = rtnl_msg_handlers[protocol];
+	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
 	if (!tab) {
 		rtnl_unlock();
 		return;
-- 
2.21.0.rc0.258.g878e2cd30e-goog

