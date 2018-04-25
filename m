Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeDYVnU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:43:20 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45899 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbeDYVnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:43:17 -0400
X-Google-Smtp-Source: AIpwx48dYkW6V+w4hXW30ok+ZCDDnxv6CmCAwII1bNibspqxxcX0fYifyYUjhHo0Z6e+HElvv1XVQA==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH v2 net-next 0/2] tcp: mmap: rework zerocopy receive
Date: Wed, 25 Apr 2018 14:43:05 -0700
Message-Id: <20180425214307.159264-1-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a lockdep issue caused by tcp mmap() support.

I implemented Andy Lutomirski nice suggestions to resolve the
issue and increase scalability as well.

First patch is adding a new setsockopt() operation and changes mmap()
behavior.

Second patch changes tcp_mmap reference program.

v2:
 Added a missing page align of zc->length in tcp_zerocopy_receive()
 Properly clear zc->recv_skip_hint in case user request was completed.

Eric Dumazet (2):
  tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive
  selftests: net: tcp_mmap must use TCP_ZEROCOPY_RECEIVE

 include/uapi/linux/tcp.h               |   8 ++
 net/ipv4/tcp.c                         | 189 +++++++++++++------------
 tools/testing/selftests/net/tcp_mmap.c |  63 +++++----
 3 files changed, 142 insertions(+), 118 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog
