Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C9BC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665A121734
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiTEVtJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfAUSmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:42:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42580 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfAUSmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:42:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so10195247plp.9;
        Mon, 21 Jan 2019 10:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UhjdCP88rmdehqeRAetyReXxA9RYk0YtczDaP82x6gc=;
        b=JiTEVtJ9/hYMzHJw/8eEsh5Q9U8kNbOveHZPZZU3jXNbLgJkpGFHchPtf1+SyZBK6Y
         p7422z9D6sHHWNaBmIprRV+hr1bQ1HHp8zRWp1NfvigcZdd8rUUlEaxfvgZ5BRtHm5kz
         EkuS0iBZQnM6cUC/Uqtx6NGfKXWfWsXNSA+TO2PSngVlUVFpLeK3rcts420sL9S++GTA
         kmAPBCOqe/TiKStC2YDN+nA6NmxsGHqGaA3v5IfqUsEgFHduU1q1E9qsmlsAn8ZuavJv
         xsattUN5S18KdKN0NR8F5600efli2eQAEguNPkF8zcX/goDRfZcPP/UXAewQPA/lplLg
         AUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UhjdCP88rmdehqeRAetyReXxA9RYk0YtczDaP82x6gc=;
        b=UNwMtFrzTu+ymNJu3X/4Z2/fDurno/hZpZUzNcO3b9vil3Ljdm8VMZdrxhw6aM5xVW
         H8IK0PF3X59PmFnBH9kIUglUB7NxKlDvSwSVqbBGWU0/nrgqVt4jP/n3ifwEDhaBCClG
         NljLoEwt5ZPazq1T1715s5hrVcRN4tfI4olupY6AGcRui0rCKmksQ5anbKVw4+lTCHlY
         47NUN2zFQA86JNnngPYSflbMF7KDiTpt0Eaa0mwe7VxVGJelBeLcPYIGvdXLVw/KpupC
         jeXYpJIPGfBXtqBscttTtjZy1Ew9U7IF8ISlxiTDyGMh8LTWhkR+3h0L6RkVLQZ8TFZq
         uRUg==
X-Gm-Message-State: AJcUukd8os9osGzrZyj1Gprgj2gmZIywN8DZlJsm6yPfbc2h3m6WJOJT
        q9c3FEzUsdL7Bfm6IlkdK2rCXKEa
X-Google-Smtp-Source: ALg8bN4infcGVpTpTEpMXU686u9MP5Tbj9tR8s5MLHxkWeWt+FhU6z7e9xCfN5BvJR+HsGMrkWmYGA==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr31561313plk.291.1548096168433;
        Mon, 21 Jan 2019 10:42:48 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s37sm17338085pgm.19.2019.01.21.10.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 10:42:48 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH net] sctp: set flow sport from saddr only when it's 0
Date:   Tue, 22 Jan 2019 02:42:41 +0800
Message-Id: <91961be2ab833139b1a4b0188ba47c2581b991d4.1548096161.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now sctp_transport_pmtu() passes transport->saddr into .get_dst() to set
flow sport from 'saddr'. However, transport->saddr is set only when
transport->dst exists in sctp_transport_route().

If sctp_transport_pmtu() is called without transport->saddr set, like
when transport->dst doesn't exists, the flow sport will be set to 0
from transport->saddr, which will cause a wrong route to be got.

Commit 6e91b578bf3f ("sctp: re-use sctp_transport_pmtu in
sctp_transport_route") made the issue be triggered more easily
since sctp_transport_pmtu() would be called in sctp_transport_route()
after that.

In gerneral, fl4->fl4_sport should always be set to
htons(asoc->base.bind_addr.port), unless transport->asoc doesn't exist
in sctp_v4/6_get_dst(), which is the case:

  sctp_ootb_pkt_new() ->
    sctp_transport_route()

For that, we can simply handle it by setting flow sport from saddr only
when it's 0 in sctp_v4/6_get_dst().

Fixes: 6e91b578bf3f ("sctp: re-use sctp_transport_pmtu in sctp_transport_route")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/ipv6.c     | 3 ++-
 net/sctp/protocol.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index ed8e006..6200cd2 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -280,7 +280,8 @@ static void sctp_v6_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 
 	if (saddr) {
 		fl6->saddr = saddr->v6.sin6_addr;
-		fl6->fl6_sport = saddr->v6.sin6_port;
+		if (!fl6->fl6_sport)
+			fl6->fl6_sport = saddr->v6.sin6_port;
 
 		pr_debug("src=%pI6 - ", &fl6->saddr);
 	}
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 4e0eeb1..6abc8b2 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -440,7 +440,8 @@ static void sctp_v4_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	}
 	if (saddr) {
 		fl4->saddr = saddr->v4.sin_addr.s_addr;
-		fl4->fl4_sport = saddr->v4.sin_port;
+		if (!fl4->fl4_sport)
+			fl4->fl4_sport = saddr->v4.sin_port;
 	}
 
 	pr_debug("%s: dst:%pI4, src:%pI4 - ", __func__, &fl4->daddr,
-- 
2.1.0

