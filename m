Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09580C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B192D2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qShTQcTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfBUFuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:50:32 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41419 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfBUFt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:49:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so30227377qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 21:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zc6wY8rNCewGZVDgSPtq8BlfOuPURI6nN/IPxD75L4o=;
        b=qShTQcTd754XHzpJwI56vyDHKKusPA4VcL8Y+AAFePWXkeiXxU3ZDqJWhjH7k4OOyI
         TXzMqcdej7TKfKh4dmxMtAfmzK8tYkqqPaq7S6GQZmzMsCVbt1M+LHHodwNxQfjthC6c
         HlkgBykGg3dfgV7xxcqaGoC/3UD8IgTj43wn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zc6wY8rNCewGZVDgSPtq8BlfOuPURI6nN/IPxD75L4o=;
        b=dToxeLwfmGQURihm9d5Bg3vv2v1u7+IzisuM+q1PRKHyYFgEQ/Opz2My0hSmy/u60+
         vKzp4Vj/2WoCtV+yQiEPjefrn9nmDZLrwp7MWXjggY8XcTY6lQmLzAbPkBQbrmP5etaS
         7pcEllnXIssPgtmX/cvV76BTtSpaYmzFVX8Kq6NRdiskbMCHoVJgqpYJGJqCLS3ZUbow
         EP51UpcufsRtJ21gGSO4cKFQW9APhXrT1hbwQ1zh5pBRU5C9LpnuRrB0dNOa+TxGSJ6d
         /yGd7A7aD7RUce7lPwDfgEdJlGDuOxEc7cLQ6yICc5DJHpLRoLeIOEy2R0uZzx+ItJyB
         q/7g==
X-Gm-Message-State: AHQUAuYxPkGP+p540BjaEj4cenuVfDSGUrlOmtr5Z20zWCBP3pTgDV/N
        HCj63RHDxzo9m4NjkDvtYrdLQH+TZ6M=
X-Google-Smtp-Source: AHgI3IZDtKyppM3lu4JTN4viMA53x3Iwpt/uImBH+1nEX2ySNpJsklPizojrXDvzLS5DPjNzUrdbrg==
X-Received: by 2002:ac8:35ad:: with SMTP id k42mr5322820qtb.4.1550728198163;
        Wed, 20 Feb 2019 21:49:58 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id k185sm11561219qkd.62.2019.02.20.21.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 21:49:57 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH RFC 1/5] net: rtnetlink: Fix incorrect RCU API usage
Date:   Thu, 21 Feb 2019 00:49:38 -0500
Message-Id: <20190221054942.132388-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221054942.132388-1-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
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

