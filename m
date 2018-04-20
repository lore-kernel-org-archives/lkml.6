Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755836AbeDTPzs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:55:48 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40710 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755531AbeDTPzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:55:46 -0400
X-Google-Smtp-Source: AIpwx48Kp0EvCjvuVTVepmJ6flKYmrhEHcwcC9YRUQqxqOPPpk7vIKWVu/SUeHegjETmtq9IOPEW5A==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH net-next 0/4] mm,tcp: provide mmap_hook to solve lockdep issue
Date: Fri, 20 Apr 2018 08:55:38 -0700
Message-Id: <20180420155542.122183-1-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provide a new mmap_hook to fs willing to grab
a mutex before mm->mmap_sem is taken, to ensure lockdep sanity.

This hook allows us to shorten tcp_mmap() execution time (while mmap_sem
is held), and improve multi-threading scalability. 

Eric Dumazet (4):
  mm: provide a mmap_hook infrastructure
  net: implement sock_mmap_hook()
  tcp: provide tcp_mmap_hook()
  tcp: mmap: move the skb cleanup to tcp_mmap_hook()

 include/linux/fs.h  |  6 ++++++
 include/linux/net.h |  1 +
 include/net/tcp.h   |  1 +
 mm/util.c           | 19 ++++++++++++++++++-
 net/ipv4/af_inet.c  |  1 +
 net/ipv4/tcp.c      | 39 ++++++++++++++++++++++++++++++---------
 net/ipv6/af_inet6.c |  1 +
 net/socket.c        |  9 +++++++++
 8 files changed, 67 insertions(+), 10 deletions(-)

-- 
2.17.0.484.g0c8726318c-goog
