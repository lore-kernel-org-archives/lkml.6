Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAADC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D4A20847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCaE57aP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D4A20847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeKCDwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKCDwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:52:10 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4456220847;
        Fri,  2 Nov 2018 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184237;
        bh=dpZkfPrg9larV5EtNTu1msmcHHQKvRGZW63YcXvCjSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCaE57aPTPJDqnua7+gB17r+c5KKTQAhf/jGNmMVKNk0pzMwu4YIx9NEV3pAr7o05
         VMEWvgCzkJvLheUW8OhJDejmbHo4ub7Xhl8DAY+dvxz9lzOJgbPKBEkFUCphEw+pPz
         sMtGF9xrDcfLk0TFzYQ2iCmNeAbjPAUm5hI39Rm8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 112/150] net: socket: fix a missing-check bug
Date:   Fri,  2 Nov 2018 19:34:34 +0100
Message-Id: <20181102182910.978994735@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit b6168562c8ce2bd5a30e213021650422e08764dc ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -2887,9 +2887,14 @@ static int ethtool_ioctl(struct net *net
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
 


