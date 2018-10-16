Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2205BC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E9521476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ/gNMal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E9521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeJQBDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbeJQBDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:44 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3B420866;
        Tue, 16 Oct 2018 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709942;
        bh=bwSPM5fkf2iDDRN02VgyLeLQFc0Iq3dl8nB8fqDRzHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQ/gNMalKgdmimtUknfBb+6pqslSYzWblzISXuAGzrqowmu6zX9Chgz+FiSOw2Oda
         BQU5AnfPxBrQ+1+N++4wyr6VN/wJCz9IRG6Nm8vet3pdBP9/2hTMpJZzI3UHhr6TGQ
         yB2NIUbbqCuWbTCGJ/3Ukrldcg/4esjXFPjqgU1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 050/135] rtnetlink: Fail dump if target netnsid is invalid
Date:   Tue, 16 Oct 2018 19:04:40 +0200
Message-Id: <20181016170518.120355219@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 893626d6a353d1356528f94e081246ecf233d77a ]

Link dumps can return results from a target namespace. If the namespace id
is invalid, then the dump request should fail if get_target_net fails
rather than continuing with a dump of the current namespace.

Fixes: 79e1ad148c844 ("rtnetlink: use netnsid to query interface")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/rtnetlink.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1848,10 +1848,8 @@ static int rtnl_dump_ifinfo(struct sk_bu
 		if (tb[IFLA_IF_NETNSID]) {
 			netnsid = nla_get_s32(tb[IFLA_IF_NETNSID]);
 			tgt_net = get_target_net(skb->sk, netnsid);
-			if (IS_ERR(tgt_net)) {
-				tgt_net = net;
-				netnsid = -1;
-			}
+			if (IS_ERR(tgt_net))
+				return PTR_ERR(tgt_net);
 		}
 
 		if (tb[IFLA_EXT_MASK])


