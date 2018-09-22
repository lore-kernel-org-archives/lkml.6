Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A43C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F56D21569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F56D21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391964AbeIVGRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:17:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44103 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391854AbeIVGKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:43 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008BP-BX; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000pw-6Z; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas King" <thomaskingnew@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Christoph Paasch" <cpaasch@apple.com>,
        "Eric Dumazet" <edumazet@google.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.639753801@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 04/63] net: Set sk_prot_creator when cloning sockets
 to the right proto
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Paasch <cpaasch@apple.com>

commit 9d538fa60bad4f7b23193c89e843797a1cf71ef3 upstream.

sk->sk_prot and sk->sk_prot_creator can differ when the app uses
IPV6_ADDRFORM (transforming an IPv6-socket to an IPv4-one).
Which is why sk_prot_creator is there to make sure that sk_prot_free()
does the kmem_cache_free() on the right kmem_cache slab.

Now, if such a socket gets transformed back to a listening socket (using
connect() with AF_UNSPEC) we will allocate an IPv4 tcp_sock through
sk_clone_lock() when a new connection comes in. But sk_prot_creator will
still point to the IPv6 kmem_cache (as everything got copied in
sk_clone_lock()). When freeing, we will thus put this
memory back into the IPv6 kmem_cache although it was allocated in the
IPv4 cache. I have seen memory corruption happening because of this.

With slub-debugging and MEMCG_KMEM enabled this gives the warning
	"cache_from_obj: Wrong slab cache. TCPv6 but object is from TCP"

A C-program to trigger this:

void main(void)
{
        int fd = socket(AF_INET6, SOCK_STREAM, IPPROTO_TCP);
        int new_fd, newest_fd, client_fd;
        struct sockaddr_in6 bind_addr;
        struct sockaddr_in bind_addr4, client_addr1, client_addr2;
        struct sockaddr unsp;
        int val;

        memset(&bind_addr, 0, sizeof(bind_addr));
        bind_addr.sin6_family = AF_INET6;
        bind_addr.sin6_port = ntohs(42424);

        memset(&client_addr1, 0, sizeof(client_addr1));
        client_addr1.sin_family = AF_INET;
        client_addr1.sin_port = ntohs(42424);
        client_addr1.sin_addr.s_addr = inet_addr("127.0.0.1");

        memset(&client_addr2, 0, sizeof(client_addr2));
        client_addr2.sin_family = AF_INET;
        client_addr2.sin_port = ntohs(42421);
        client_addr2.sin_addr.s_addr = inet_addr("127.0.0.1");

        memset(&unsp, 0, sizeof(unsp));
        unsp.sa_family = AF_UNSPEC;

        bind(fd, (struct sockaddr *)&bind_addr, sizeof(bind_addr));

        listen(fd, 5);

        client_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
        connect(client_fd, (struct sockaddr *)&client_addr1, sizeof(client_addr1));
        new_fd = accept(fd, NULL, NULL);
        close(fd);

        val = AF_INET;
        setsockopt(new_fd, SOL_IPV6, IPV6_ADDRFORM, &val, sizeof(val));

        connect(new_fd, &unsp, sizeof(unsp));

        memset(&bind_addr4, 0, sizeof(bind_addr4));
        bind_addr4.sin_family = AF_INET;
        bind_addr4.sin_port = ntohs(42421);
        bind(new_fd, (struct sockaddr *)&bind_addr4, sizeof(bind_addr4));

        listen(new_fd, 5);

        client_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
        connect(client_fd, (struct sockaddr *)&client_addr2, sizeof(client_addr2));

        newest_fd = accept(new_fd, NULL, NULL);
        close(new_fd);

        close(client_fd);
        close(new_fd);
}

As far as I can see, this bug has been there since the beginning of the
git-days.

Signed-off-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Thomas King <thomaskingnew@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/core/sock.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1512,6 +1512,8 @@ struct sock *sk_clone_lock(const struct
 
 		sock_copy(newsk, sk);
 
+		newsk->sk_prot_creator = sk->sk_prot;
+
 		/* SANITY */
 		get_net(sock_net(newsk));
 		sk_node_init(&newsk->sk_node);

