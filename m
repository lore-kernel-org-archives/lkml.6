Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F29CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B222146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788905;
	bh=mIc0a0PQkCa701ELA9Qnad0ARPP1NFgWr3SvntwFJkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TxWL7u0N07l7Rotp/Z94PaBYUogdWsgfJoRwOIa/kSI0uSaGa9eoBQrTrSOPQzDLq
	 F3W8ZgKE07QY2Mx0+35OVDDjgfsKbzSxUuU4PJWBh7iZuSNzTSiFvPY2ksFcGdDaGH
	 UA5+cGLL1e6C4+HjKhltdlbODMmnUGLqy+cLFBWk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B222146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeLNMBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbeLNMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:01:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B0F2145D;
        Fri, 14 Dec 2018 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788899;
        bh=mIc0a0PQkCa701ELA9Qnad0ARPP1NFgWr3SvntwFJkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kr/WnLf8Ghb8FMFAaztfqJp4GvGGzWFU5EKR118CJluToLtZ/v1ANv0YI42D1WZnJ
         Ne2TT4dwYn8YNVaG/B40C8KdAmMh32gUmwxEbNQp4uxMUfW43T4bKwpu+YqqQjMd+C
         pl3yrnLNsfAkbggF09HqYfRrFhUsEDeL3uKg1Vmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 016/142] tun: forbid iface creation with rtnl ops
Date:   Fri, 14 Dec 2018 12:58:21 +0100
Message-Id: <20181214115747.699726508@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

[ Upstream commit 35b827b6d06199841a83839e8bb69c0cd13a28be ]

It's not supported right now (the goal of the initial patch was to support
'ip link del' only).

Before the patch:
$ ip link add foo type tun
[  239.632660] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[snip]
[  239.636410] RIP: 0010:register_netdevice+0x8e/0x3a0

This panic occurs because dev->netdev_ops is not set by tun_setup(). But to
have something usable, it will require more than just setting
netdev_ops.

Fixes: f019a7a594d9 ("tun: Implement ip link del tunXXX")
CC: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2268,9 +2268,9 @@ static void tun_setup(struct net_device
 static int tun_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
-	if (!data)
-		return 0;
-	return -EINVAL;
+	NL_SET_ERR_MSG(extack,
+		       "tun/tap creation via rtnetlink is not supported.");
+	return -EOPNOTSUPP;
 }
 
 static size_t tun_get_size(const struct net_device *dev)


