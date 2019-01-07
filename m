Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AA3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3342183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865202;
	bh=9T+ssWtjxGLuSoDU5pESEy57F52uqGMpSzUABwSo+Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=npwxeRaeGOfTRFQO8SGDCSez4xpxEuFOgePj5K5gs3U538mxkCXIthPCRLM1KFTdF
	 m2hg3bjzeVZ0VP6POAbofeZfMQzvlLj+aBpkWK4DrDgyx4ehC18wmoskina2XqydQ+
	 llV6Nftq3SfFisvzP6Rvxcz6bZwAVCCkHtFC7Twg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfAGMql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbfAGMqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:46:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1872183E;
        Mon,  7 Jan 2019 12:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865197;
        bh=9T+ssWtjxGLuSoDU5pESEy57F52uqGMpSzUABwSo+Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQO8GwRdgsacqPCK/09HEI9ZvcXvrumLfygFsx4NqhWBKexR74ZIINaCOIKmxeJHh
         UV3OuqkZuxlam45Y4iMo7Oj334zNfZQoAe2Z2BvykXtMGll8fQ+JO6/16E4aWc+pkA
         b/qgG+VfmRGCHFaq8DaS9yxv8JSCekMbZ4VVy6Qg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 021/170] net/tls: allocate tls context using GFP_ATOMIC
Date:   Mon,  7 Jan 2019 13:30:48 +0100
Message-Id: <20190107104455.556682995@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Ganesh Goudar <ganeshgr@chelsio.com>

[ Upstream commit c6ec179a0082e2e76e3a72050c2b99d3d0f3da3f ]

create_ctx can be called from atomic context, hence use
GFP_ATOMIC instead of GFP_KERNEL.

[  395.962599] BUG: sleeping function called from invalid context at mm/slab.h:421
[  395.979896] in_atomic(): 1, irqs_disabled(): 0, pid: 16254, name: openssl
[  395.996564] 2 locks held by openssl/16254:
[  396.010492]  #0: 00000000347acb52 (sk_lock-AF_INET){+.+.}, at: do_tcp_setsockopt.isra.44+0x13b/0x9a0
[  396.029838]  #1: 000000006c9552b5 (device_spinlock){+...}, at: tls_init+0x1d/0x280
[  396.047675] CPU: 5 PID: 16254 Comm: openssl Tainted: G           O      4.20.0-rc6+ #25
[  396.066019] Hardware name: Supermicro X10SRA-F/X10SRA-F, BIOS 2.0c 09/25/2017
[  396.083537] Call Trace:
[  396.096265]  dump_stack+0x5e/0x8b
[  396.109876]  ___might_sleep+0x216/0x250
[  396.123940]  kmem_cache_alloc_trace+0x1b0/0x240
[  396.138800]  create_ctx+0x1f/0x60
[  396.152504]  tls_init+0xbd/0x280
[  396.166135]  tcp_set_ulp+0x191/0x2d0
[  396.180035]  ? tcp_set_ulp+0x2c/0x2d0
[  396.193960]  do_tcp_setsockopt.isra.44+0x148/0x9a0
[  396.209013]  __sys_setsockopt+0x7c/0xe0
[  396.223054]  __x64_sys_setsockopt+0x20/0x30
[  396.237378]  do_syscall_64+0x4a/0x180
[  396.251200]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: df9d4a178022 ("net/tls: sleeping function from invalid context")
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -550,7 +550,7 @@ static struct tls_context *create_ctx(st
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx)
 		return NULL;
 


