Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756558AbeDZOvF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:51:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35817 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756461AbeDZOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:51:00 -0400
X-Google-Smtp-Source: AB8JxZoX4Xrkkrg3pBU2wc9yaRU8FEk85GyUNPH3diADMo7X5uYkG1uOvmEAT2Z54eac4HZ65AkULA==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH v3 net-next 0/2] tcp: mmap: rework zerocopy receive
Date: Thu, 26 Apr 2018 07:50:54 -0700
Message-Id: <20180426145056.220325-1-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported a lockdep issue caused by tcp mmap() support.

I implemented Andy Lutomirski nice suggestions to resolve the
issue and increase scalability as well.

First patch is adding a new getsockopt() operation and changes mmap()
behavior.

Second patch changes tcp_mmap reference program.

v3: change TCP_ZEROCOPY_RECEIVE to be a getsockopt() option
    instead of setsockopt(), feedback from Ka-Cheon Poon

v2: Added a missing page align of zc->length in tcp_zerocopy_receive()
    Properly clear zc->recv_skip_hint in case user request was completed.

Eric Dumazet (2):
  tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive
  selftests: net: tcp_mmap must use TCP_ZEROCOPY_RECEIVE

 include/uapi/linux/tcp.h               |   8 ++
 net/ipv4/tcp.c                         | 192 +++++++++++++------------
 tools/testing/selftests/net/tcp_mmap.c |  64 +++++----
 3 files changed, 146 insertions(+), 118 deletions(-)

-- 
2.17.0.484.g0c8726318c-goog
