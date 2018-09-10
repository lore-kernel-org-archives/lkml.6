Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91123C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D890206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djyvh1bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D890206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeIJNUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:20:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34630 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeIJNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:20:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id j25-v6so4777069wmc.1;
        Mon, 10 Sep 2018 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtT4klQpmEAfo/PvQpyLx+ag25qu8AQa7XpWut6EcF0=;
        b=djyvh1bf5ES1ZcPAYTEtfgCRbPjREk7gL0/x9udLd90UjZxPX/60NJjbugiilf2oZl
         POoEhcpaOaQBLvhKR81WrwP/Urzo7irmNAqSrZAFedqmDV2j0NvPK8Mu0I/w6DvMnHG0
         C2tkPq+r4umccBU+rhBJVRNhfxUsmmTEewOQxyi87i9KqGMGmMB9R+50YReD99W9ZSDA
         8UkzOyKFUNhsE705Cj/23Hea+jxwkoAbhNrKigbLb5MBkfhnmZR3cMmtBnDhSJtyjXTq
         Z/kmOvpgev6iDU98yy5xFbz/e1aAb86zvHhBu2YN//tUuPnEyguEWp5lEzWYGHGMtGih
         YLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtT4klQpmEAfo/PvQpyLx+ag25qu8AQa7XpWut6EcF0=;
        b=Qex1e6Rf/Zzjk/OKq3a4QxgmjDt2j4G6+0njd3HUUoPhvAuebs8daSIvJTAPp1HlmE
         wZ078EmmFVsjxNzfIwae70uNXN/DL8KGF8grpm6oAe3p9e/nSxxCIjrkFqk8WqO0OaQ3
         kqDT+TAOMuzY+colKav4AjCFUSY+9+ivGIbHKvYm3aPgg5xpgSrjJcW6Pe+yTqF5bueT
         SNyGH03RFItqmOO+cJkuxYz/VLu1eRvBW5x3G3A3kjHI092pbCXkouibiA1IJGSf/2mU
         ArZO9ZYnvqL4bjMVIJC++oB7UTEIxsATEkefX0YGIWIenZjOlJv2HSfw1qFGZfcHhtO4
         e4Cw==
X-Gm-Message-State: APzg51BWUl7lV/Wy6YP9m7b43jarfaQOp/Pkf2HbVwWwXzDX/LZRhaLV
        e58GUglnGBHvUll9ZIMRGGGM97DnRY8=
X-Google-Smtp-Source: ANB0VdbQy8533fhdqUS+5gs2cXAthCucAHANNUjClEYRGKEYTDLWf7NzzefAoQ4svCy2A91c1GRbyQ==
X-Received: by 2002:a1c:cbc1:: with SMTP id b184-v6mr12760213wmg.149.1536568044063;
        Mon, 10 Sep 2018 01:27:24 -0700 (PDT)
Received: from Buzz.fritz.box (p200300EE0F0184008022AC53B7CF59F1.dip0.t-ipconnect.de. [2003:ee:f01:8400:8022:ac53:b7cf:59f1])
        by smtp.gmail.com with ESMTPSA id 69-v6sm13236026wmb.27.2018.09.10.01.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 01:27:23 -0700 (PDT)
From:   Andre Naujoks <nautsch2@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     Andre Naujoks <nautsch2@gmail.com>
Subject: [PATCH 0/1] add IPV6_MULTICAST_ALL sockopt
Date:   Mon, 10 Sep 2018 10:27:14 +0200
Message-Id: <20180910082715.11506-1-nautsch2@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch applies to the current net-next tree.

I tried to keep the impact of this to a minimum and to replicate the
behaviour of IP_MULTICAST_ALL.

Andre Naujoks (1):
  ipv6: Add sockopt IPV6_MULTICAST_ALL analogue to IP_MULTICAST_ALL

 include/linux/ipv6.h     |  3 ++-
 include/uapi/linux/in6.h |  1 +
 net/ipv6/af_inet6.c      |  1 +
 net/ipv6/ipv6_sockglue.c | 11 +++++++++++
 net/ipv6/mcast.c         |  2 +-
 5 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.19.0.rc2

