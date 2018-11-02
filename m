Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFD0C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7453C20848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRo+R7lB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7453C20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbeKCEDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbeKCEDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:03:01 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0BED20848;
        Fri,  2 Nov 2018 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184885;
        bh=0Jg3ZZMg6RpXl3u23Oofso86bXwgPJ3IFpn/f18zids=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRo+R7lBQIQIhv9/62pTUFkSj/OLUFR1D/KHTbwpVsPeCzj05ULnHA1kKGaenevxq
         3MMQ/Q22i5DhpwM0mpORCgOeZ54/wvqkLsfEbgl9wqa5TmosGp/fxM2YJMdS2ch7nV
         PWs+4S03lQFbYbpZqzf6rR5ekWcGjA3aD4sUa+dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+11e05f04c15e03be5254@syzkaller.appspotmail.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 119/143] llc: set SOCK_RCU_FREE in llc_sap_add_socket()
Date:   Fri,  2 Nov 2018 19:35:04 +0100
Message-Id: <20181102182907.376353233@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 5a8e7aea953bdb6d4da13aff6f1e7f9c62023499 ]

WHen an llc sock is added into the sk_laddr_hash of an llc_sap,
it is not marked with SOCK_RCU_FREE.

This causes that the sock could be freed while it is still being
read by __llc_lookup_established() with RCU read lock. sock is
refcounted, but with RCU read lock, nothing prevents the readers
getting a zero refcnt.

Fix it by setting SOCK_RCU_FREE in llc_sap_add_socket().

Reported-by: syzbot+11e05f04c15e03be5254@syzkaller.appspotmail.com
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/llc_conn.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -734,6 +734,7 @@ void llc_sap_add_socket(struct llc_sap *
 	llc_sk(sk)->sap = sap;
 
 	spin_lock_bh(&sap->sk_lock);
+	sock_set_flag(sk, SOCK_RCU_FREE);
 	sap->sk_count++;
 	sk_nulls_add_node_rcu(sk, laddr_hb);
 	hlist_add_head(&llc->dev_hash_node, dev_hb);


