Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73109C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3666620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX/l+WrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3666620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeLEM5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:57:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41444 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLEM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:57:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id 70so8988790pgh.8;
        Wed, 05 Dec 2018 04:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HZ0Xqc8PGVWzAi/hwDCp2WBWvtjBbAmFHe3E+G7gDkY=;
        b=mX/l+WrAVuNtgRAIwxDdZYgWOQvsJXbdfDAYPB/wrq8BCT/BUDywwF8SSo3Ac+M6YB
         /0anSC4VdyTZIRLJ+nKKIFf2JaeuO93TCs+Ft07VInqvgJfErM+I/zXV+fWjogoIeJwR
         0497o3hoz4E4a1voh+2UL1u90FBgXj5SgrfieZXQ3Yh+MznwuuADitYD7diSEm6x0Thy
         jf5WESfa76ZtHG3dqCo/t36oX6jPwvU4FtWbVSqVk2FZf81NgryNM+NV6f3FmeFZzdSj
         gbq8zgPw1j0oU5cEBvbFXwhXsQZlFNbr1p93Q6MCKnQ8seswjx25ZvJx3k9hgoQiqGDz
         JZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HZ0Xqc8PGVWzAi/hwDCp2WBWvtjBbAmFHe3E+G7gDkY=;
        b=g+dJKcrjCmMfzmmpjG6J3Cv/nQP/zpaU7R4LQ/B4AJTg25II2EFSsB17ED6bnT9PpL
         Rw8Iid8atvkUkGwwTNQYY7KxyRLE/d55Nmq2QkrR/Ex/s96de+f3aWJaNI8yNQAqUpWk
         J6ZH6CtaHOJZnseb/MF7To93Ww+fJ/1uI4+rbTk+WxWL458jZlR57QaMgNDk7AqSUDZl
         Lr4t2k1CpPFxZ9nAKOOxwAfCxxf5xMbt4mo3MfarJ+Igp4QgFOr8Lt6RqQMMSZMxcFdT
         vhN/IGdXu/JwBHjkD1Rd7o0/G+oey49ypYlhmD5qSgSviQcUGfokRqcqLXl5Q6nIbuMJ
         WWOQ==
X-Gm-Message-State: AA+aEWbdN9vZvjj6BUIKxl/SE0wPDL5XzA0klEXMOdp5RQVaQEXs8T0x
        Ewwn2hmUK/d45ni64eoeFuQ=
X-Google-Smtp-Source: AFSGD/WhDitiNX4zVXN1t4sPYy6dJqGjHx7Iuv7JznwbU/WFccakNrN5YpXKp8MNaFEdymLBZ+kDXw==
X-Received: by 2002:a63:f959:: with SMTP id q25mr20579422pgk.315.1544014651322;
        Wed, 05 Dec 2018 04:57:31 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q1sm26348898pfb.96.2018.12.05.04.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:57:30 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, adobriyan@gmail.com, akpm@linux-foundation.org
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 4/5] netfilter: fix missed NULL check in nf_conntrack_proto_pernet_init()
Date:   Wed,  5 Dec 2018 20:56:29 +0800
Message-Id: <1544014590-14429-4-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
References: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nf_ct_l4proto_net() may return NULL.
That may happens if some module forget to set both l4proto->get_net_proto
and l4proto->net_id.
We'd check the return value here, in case crash happens.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/netfilter/nf_conntrack_proto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
index 154e8c0..316fef3 100644
--- a/net/netfilter/nf_conntrack_proto.c
+++ b/net/netfilter/nf_conntrack_proto.c
@@ -946,6 +946,9 @@ int nf_conntrack_proto_pernet_init(struct net *net)
 	struct nf_proto_net *pn = nf_ct_l4proto_net(net,
 					&nf_conntrack_l4proto_generic);
 
+	if (pn == NULL)
+		return -EINVAL;
+
 	err = nf_conntrack_l4proto_generic.init_net(net);
 	if (err < 0)
 		return err;
-- 
1.8.3.1

