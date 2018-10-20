Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBFEC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 15:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3996F2154C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 15:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="devfIgFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3996F2154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeJUAJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:09:14 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45502 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeJUAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 20:09:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 1C646C52
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 15:58:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xyhg7wilFi8V for <linux-kernel@vger.kernel.org>;
        Sat, 20 Oct 2018 10:58:19 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id E9375B45
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 10:58:18 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id x5-v6so33643564ioa.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PpylUJRi+0VJzyebaLSwn2j9nluvaiMZSRh9B46nFc8=;
        b=devfIgFJVipfdDDeVT943YXz4V/n1mrwHiXIYFwGU5OXy8RERKrcg1IW+/0E5y0uAm
         gVPnV/ZZGwVKLdKrQGb7A4gHq39bFFo8a/HGC0b4iQmRvMGkF4nwW0t/LQ0pPjF89E1q
         jN4IIR7IM7KNDBtrYbsjVMX+dj46IyWOcRmpDBydXNEkQEH6J6sn2x9wZoQMOMskA0h1
         TGEhY3x+5GDnq0b9RFWqrS/lTmr99CDd0ePmGM4KPhUEnYw/BG2ynwUgKCeAJQkC4W3w
         RtFZ2BebtVaPZp9WwvKa9O4i/GK9z5gb/mjMg4dgYLrEAiW66SmHFxEwinthbF7XeqRh
         Gmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PpylUJRi+0VJzyebaLSwn2j9nluvaiMZSRh9B46nFc8=;
        b=WNT/vCEZJmJ+OoCRhNEKFnFAbuDvN8pWUHmrmZ71WT4Cwog8Hh8ZBnwstHKc+wSyTx
         5uHHMVKLNlOBjescc+2sm+A/3XU2+EbexUpsqEQy0Wf/ZIz/R0FZ8rrmEIRNBNRRAVlj
         Z9ECNrj/LGaltenbAY5wuHBA+uWw4DE/JmPhup+HxmZcNusnD1610muScPXSVlyWyIxe
         VO8F7kJCovZn2MkxTaV4lm/X//Y9He1oHZwmuQX2fGMzNzic5Eg4ExW1tAUlCdY1oriH
         G7Tjb2gOEx4thk1VQl0T3nYlYPVlUgdYbCm1tJqpiSSlcGiJ7ODl5VRQMeHMXWNDFUW3
         BqWQ==
X-Gm-Message-State: ABuFfohIWF5c3TtYpbV2HZdduJ7H0xUfoY3dJ8MYjIyin8Fno4zu7KS9
        bjpxnC4maHPlj598fEzf71pZBQd+fUiEs+G4exZnG9q5nw0UsFSIiAAfdVA/JPLHiD2yLkC2hKA
        TkWCZ8/3LjRMb6d2x746HlK2vKYZd
X-Received: by 2002:a24:7f06:: with SMTP id r6-v6mr5981435itc.107.1540051098417;
        Sat, 20 Oct 2018 08:58:18 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63lJU/bgK4bM6zib3LG1eaVNKK53SQkNnUYGdjzqQukZ95Ct2VNP000gMHsKmXOhtnWKIxMjA==
X-Received: by 2002:a24:7f06:: with SMTP id r6-v6mr5981427itc.107.1540051098230;
        Sat, 20 Oct 2018 08:58:18 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id u8-v6sm7582386iof.47.2018.10.20.08.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 08:58:17 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: socket: fix a missing-check bug
Date:   Sat, 20 Oct 2018 10:58:10 -0500
Message-Id: <1540051091-16604-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ethtool_ioctl(), the ioctl command is firstly obtained from the
user-space buffer 'compat_rxnfc' through get_user() and saved to 'ethcmd'.
Then, 'ethcmd' is checked to see whether it is necessary to pre-process the
ethool structure, because the structure ethtool_rxnfc is defined with
padding, as mentioned in the comment. If yes, a user-space buffer 'rxnfc'
is allocated through compat_alloc_user_space() and then the data in the
original buffer 'compat_rxnfc' is copied to 'rxnfc' through copy_in_user(),
including the ioctl command. It is worth noting that after this copy, there
is no check enforced on the copied ioctl command. That means it is possible
that 'rxnfc->cmd' is different from 'ethcmd', because a malicious user can
race to modify the ioctl command in 'compat_rxnfc' between these two
copies. Eventually, the ioctl command in 'rxnfc' will be used in
dev_ethtool(). This can cause undefined behavior of the kernel and
introduce potential security risk.

This patch avoids the above issue by rewriting 'rxnfc->cmd' using 'ethcmd'
after copy_in_user().

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 net/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index 01f3f8f..c5f969c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2879,6 +2879,8 @@ static int ethtool_ioctl(struct net *net, struct compat_ifreq __user *ifr32)
 		    copy_in_user(&rxnfc->rule_cnt, &compat_rxnfc->rule_cnt,
 				 sizeof(rxnfc->rule_cnt)))
 			return -EFAULT;
+
+		rxnfc->cmd = ethcmd;
 	}
 
 	ret = dev_ioctl(net, SIOCETHTOOL, &ifr, NULL);
-- 
2.7.4

