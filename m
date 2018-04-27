Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758611AbeD0P6X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:58:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46453 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758236AbeD0P6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:58:19 -0400
X-Google-Smtp-Source: AB8JxZpiIN0khhMSZmBHAPnbZoCInE8RkBhyyk5Zac93VSCYsQF8jOXj/IRMYG26l2MaOBYDBh/+Vw==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH v4 net-next 0/2] tcp: mmap: rework zerocopy receive
Date: Fri, 27 Apr 2018 08:58:07 -0700
Message-Id: <20180427155809.79094-1-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a lockdep issue caused by tcp mmap() support.

I implemented Andy Lutomirski nice suggestions to resolve the
issue and increase scalability as well.

First patch is adding a new getsockopt() operation and changes mmap()
behavior.

Second patch changes tcp_mmap reference program.

v4: tcp mmap() support depends on CONFIG_MMU, as kbuild bot told us.

v3: change TCP_ZEROCOPY_RECEIVE to be a getsockopt() option
    instead of setsockopt(), feedback from Ka-Cheon Poon

v2: Added a missing page align of zc->length in tcp_zerocopy_receive()
    Properly clear zc->recv_skip_hint in case user request was completed.

Eric Dumazet (2):
  tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive
  selftests: net: tcp_mmap must use TCP_ZEROCOPY_RECEIVE

 include/uapi/linux/tcp.h               |   8 +
 net/ipv4/af_inet.c                     |   2 +
 net/ipv4/tcp.c                         | 196 +++++++++++++------------
 net/ipv6/af_inet6.c                    |   2 +
 tools/testing/selftests/net/tcp_mmap.c |  64 ++++----
 5 files changed, 154 insertions(+), 118 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog
