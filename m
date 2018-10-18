Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5446BC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C2B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="BHPlj2gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C2B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeJRWib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:38:31 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:43902 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeJRWib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:38:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 4F690C06
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:37:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mh8Dsvg8vvRc for <linux-kernel@vger.kernel.org>;
        Thu, 18 Oct 2018 09:37:12 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 64715C07
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:36:59 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id z15-v6so28415896iob.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wUj+8VubdrSHItV5wintbS7/hh5RhjqBnCK15aAEX4E=;
        b=BHPlj2gq2l9GXQMEAvTXOJw+KWTRkKnaynVaNDPC0RJ1R7thvuErMkUaxemRBVv+i0
         E6tZ89WE2fwAkaJ6cXJODSaqQD+NXwXN6L31wF7KchR1893nFIzF6eqwlFbPUJj9nIdc
         izRia307hPOt+g6sjSUvfICSe/MdZHScSYHjpMTF+7+uaQG/rqtDXxh35g2jPPaIYbVA
         LGPL6lFmWXaEZeDwIJAwLPi/wJt5B10TfrkH8gGhZhAQp8XjdISihIp9nTAFCg5ShAOV
         0DUdbVpxrvNd+m7oxUIMlNkOoOPIQiDo8sjV8LSbhWr0A7u687zyrXURuEg+sU9u4iS5
         V7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wUj+8VubdrSHItV5wintbS7/hh5RhjqBnCK15aAEX4E=;
        b=rMsF3+mRSpyjxo0pM4vjpvwKe340wbWN4+73tFAnnXqDcvcVeTMkn3pyzUvt5Xm3ai
         5oibe5681HPp+zeR5ln2TgakaTzPP5puh85LNm2OTw3EHjfPJTsHQ7yfRxYLHBKDRc9g
         iK7j0sBtC+Gygn3wSSRUqVwsouL24FdO6lyyFTLPeV7mE7deuuNsQpKXYiGq3rksxLNf
         /1JAeuCqqM47ehU+RDWl9xYASPKQaFiBpzm8UhgCzDmriDLWbZbrO70PkUuBxZq9rjP8
         SGmNBlQHMzrFE8BivdenbffyXiRcdE57zDXt0bmVW+gmVfmHSTxesrAdS79N2K8e3NOk
         nZsw==
X-Gm-Message-State: ABuFfoj/16VC9D0M75NAo5snkXgcLAiN+VmCgT43YWEDtDEPhuFYKIBk
        Cioq29tcSsvY8iZhYQmK6LE96rv1sjiUu3+0MM6wCrbLOxOVHpsqwEb+SRoMOp8ufKX+TM9eqCZ
        Vbhg+vbJF1YJaYzRwJLLOM1BUDCJr
X-Received: by 2002:a24:ad44:: with SMTP id a4-v6mr390585itj.132.1539873419064;
        Thu, 18 Oct 2018 07:36:59 -0700 (PDT)
X-Google-Smtp-Source: ACcGV634oxbaSLWAQi+XiOeTIV8ENdcwMMWjuSRT4+gd74L5uL70Zhtu/xArGX8kEbGdjWWTQAsl3A==
X-Received: by 2002:a24:ad44:: with SMTP id a4-v6mr390558itj.132.1539873418524;
        Thu, 18 Oct 2018 07:36:58 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id 189-v6sm336783itw.35.2018.10.18.07.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 07:36:57 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: socket: fix a missing-check bug
Date:   Thu, 18 Oct 2018 09:36:46 -0500
Message-Id: <1539873406-5967-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ethtool_ioctl(), the ioctl command 'ethcmd' is checked through a switch
statement to see whether it is necessary to pre-process the ethtool
structure, because, as mentioned in the comment, the structure
ethtool_rxnfc is defined with padding. If yes, a user-space buffer 'rxnfc'
is allocated through compat_alloc_user_space(). One thing to note here is
that, if 'ethcmd' is ETHTOOL_GRXCLSRLALL, the size of the buffer 'rxnfc' is
partially determined by 'rule_cnt', which is actually acquired from the
user-space buffer 'compat_rxnfc', i.e., 'compat_rxnfc->rule_cnt', through
get_user(). After 'rxnfc' is allocated, the data in the original user-space
buffer 'compat_rxnfc' is then copied to 'rxnfc' through copy_in_user(),
including the 'rule_cnt' field. However, after this copy, no check is
re-enforced on 'rxnfc->rule_cnt'. So it is possible that a malicious user
race to change the value in the 'compat_rxnfc->rule_cnt' between these two
copies. Through this way, the attacker can bypass the previous check on
'rule_cnt' and inject malicious data. This can cause undefined behavior of
the kernel and introduce potential security risk.

This patch avoids the above issue via copying the value acquired by
get_user() to 'rxnfc->rule_cn', if 'ethcmd' is ETHTOOL_GRXCLSRLALL.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 net/socket.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 01f3f8f..390a8ec 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2875,9 +2875,14 @@ static int ethtool_ioctl(struct net *net, struct compat_ifreq __user *ifr32)
 		    copy_in_user(&rxnfc->fs.ring_cookie,
 				 &compat_rxnfc->fs.ring_cookie,
 				 (void __user *)(&rxnfc->fs.location + 1) -
-				 (void __user *)&rxnfc->fs.ring_cookie) ||
-		    copy_in_user(&rxnfc->rule_cnt, &compat_rxnfc->rule_cnt,
-				 sizeof(rxnfc->rule_cnt)))
+				 (void __user *)&rxnfc->fs.ring_cookie))
+			return -EFAULT;
+		if (ethcmd == ETHTOOL_GRXCLSRLALL) {
+			if (put_user(rule_cnt, &rxnfc->rule_cnt))
+				return -EFAULT;
+		} else if (copy_in_user(&rxnfc->rule_cnt,
+					&compat_rxnfc->rule_cnt,
+					sizeof(rxnfc->rule_cnt)))
 			return -EFAULT;
 	}
 
-- 
2.7.4

