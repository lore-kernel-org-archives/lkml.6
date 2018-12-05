Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5AFC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716AA2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzVT7tLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716AA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeLEM5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:57:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38683 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLEM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:57:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so8991640pgc.5;
        Wed, 05 Dec 2018 04:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kPHdydhUX9ooSL0A7ozYYgMZy1PB7bQSzbcoXLKwK5U=;
        b=UzVT7tLiPj86PGmIAVOEqyGKY4cumawAuv4qlDoOYPvYY1Ci/JActq6uXPg7OtN3nr
         qc3pVY6EBNzTFW0/srnC+q5BX9j/jlMTkDvD3mlCyouVb0cZzH8tEaCsQoXsj89zsJIn
         bdWPBmHBded8Tza6p/ozEh2bxGDBFnf8NRFiuP0H9tIDb7X+zfAcOqz4LQRjInBeY42A
         P6JJ9LMHVojgZgqlbFMGrndLBhWgGJAscfwIF7mCtFK1m3etHnicLzfOa0WlHSOAvlC6
         aNGjEu/7J65lf2TRPpSWlZARXhYQ7PpxVX2WHiJjF1bd2bQSoQW82fOibZfnb8LW+R8t
         LCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kPHdydhUX9ooSL0A7ozYYgMZy1PB7bQSzbcoXLKwK5U=;
        b=B17BMEu3RrFtkxzyz/p9BqUe52GjxO5noMOFWYPCWsC2ox37+wkrXIBmgOsaKedWHT
         kmhXnmcPqHl8/4WIvpA7djCvvbrEs6wfoZRE5YW0MZ1obt55nEDSgJzaWMZqOm2UCUcn
         MrfSVpXgODegA8UEbzSryE9X2Wle+QfufgwUVOjqAfumL8N6xxYYblAjs0G5FRNTQnLZ
         rIU59mZnjM3AXNubVaELcMSwFApbwyi6Dibf2PROg66z/VFSHwfUjpUANJFILUp1A73S
         N3phMx0Rt1+1SiAmb1/GXJ74fFwGB3ol6uW2MGetIwsirbe2pRPoG47Fx8E7mwGRl5Tx
         sODQ==
X-Gm-Message-State: AA+aEWb52kdwVp9uBhJs0FDhFUV2WZQ2Ka+fU7vhAp6I5bBkeD/YzoZW
        Tm1mXTEQJC/2PMrgHjhF5Ag=
X-Google-Smtp-Source: AFSGD/WuthGYWA4jkgbphVBf0nyBM3e0VO3lYSSDK088HJfRvtzV78K6th1Kpc3L46hA6ZbSK2lxxA==
X-Received: by 2002:a63:e516:: with SMTP id r22mr20818726pgh.256.1544014655165;
        Wed, 05 Dec 2018 04:57:35 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id q1sm26348898pfb.96.2018.12.05.04.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:57:34 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, adobriyan@gmail.com, akpm@linux-foundation.org
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 5/5] netfilter: fix error return value of nf_ct_l4proto_pernet_register_one()
Date:   Wed,  5 Dec 2018 20:56:30 +0800
Message-Id: <1544014590-14429-5-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
References: <1544014590-14429-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If pn is NULL, it will return 0.
That's not proper. We should return an error.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/netfilter/nf_conntrack_proto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
index 316fef3..3caf137 100644
--- a/net/netfilter/nf_conntrack_proto.c
+++ b/net/netfilter/nf_conntrack_proto.c
@@ -252,6 +252,7 @@ int nf_ct_l4proto_pernet_register_one(struct net *net,
 			goto out;
 	}
 
+	ret = -EINVAL;
 	pn = nf_ct_l4proto_net(net, l4proto);
 	if (pn == NULL)
 		goto out;
-- 
1.8.3.1

