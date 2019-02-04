Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9083DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58316217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277504;
	bh=yyRkU8w5TTcnavHvrkDzcioMBaB2xN3/qUlSYXk1PXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ndQwlaH9L8SscMGOCZ5WJj2mXHszwquGZyaImPLu5D3CFpHz17Q0ztgJCa64pMoOC
	 6/R9T0425bC44eXMEnfiNsw0459QRVlsn9fH4yKDyQkhtbX8Qrssvj4UCzu4YwxzCQ
	 LFyQs7X30J1zgnkcTWkTm1IpgX/gxA58GZHJy7+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfBDKvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbfBDKvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8664217FA;
        Mon,  4 Feb 2019 10:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277498;
        bh=yyRkU8w5TTcnavHvrkDzcioMBaB2xN3/qUlSYXk1PXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2vgIo6xw1xNV9GLwZqseO9XwbzOUrn6g5ud8VKbY3ZFh4j8IdbUFK08Qksim+Rv4u
         V2pUex2Gf6J8LqTiPoJlAhL4k2ExKagVtGrWG1KJZKuhlZQyBj2fC+kqw7/LwoVuxr
         yEdZbwV0Z+Izc1PdnOe8Av0njgdKY4ljqRwaZ8js=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Elsasser <jelsasser@appneta.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 12/80] net: set default network namespace in init_dummy_netdev()
Date:   Mon,  4 Feb 2019 11:36:32 +0100
Message-Id: <20190204103622.023262081@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Elsasser <jelsasser@appneta.com>

[ Upstream commit 35edfdc77f683c8fd27d7732af06cf6489af60a5 ]

Assign a default net namespace to netdevs created by init_dummy_netdev().
Fixes a NULL pointer dereference caused by busy-polling a socket bound to
an iwlwifi wireless device, which bumps the per-net BUSYPOLLRXPACKETS stat
if napi_poll() received packets:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000190
  IP: napi_busy_loop+0xd6/0x200
  Call Trace:
    sock_poll+0x5e/0x80
    do_sys_poll+0x324/0x5a0
    SyS_poll+0x6c/0xf0
    do_syscall_64+0x6b/0x1f0
    entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 7db6b048da3b ("net: Commonize busy polling code to focus on napi_id instead of socket")
Signed-off-by: Josh Elsasser <jelsasser@appneta.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8624,6 +8624,9 @@ int init_dummy_netdev(struct net_device
 	set_bit(__LINK_STATE_PRESENT, &dev->state);
 	set_bit(__LINK_STATE_START, &dev->state);
 
+	/* napi_busy_loop stats accounting wants this */
+	dev_net_set(dev, &init_net);
+
 	/* Note : We dont allocate pcpu_refcnt for dummy devices,
 	 * because users of this 'device' dont need to change
 	 * its refcount.


