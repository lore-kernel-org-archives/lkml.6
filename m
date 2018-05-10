Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeEJWpU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:45:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750716AbeEJWpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:45:18 -0400
Subject: [PATCH net 0/5] rxrpc: Fixes
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 10 May 2018 23:45:17 +0100
Message-ID: <152599231687.26376.15020977491573449830.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are three fixes for AF_RXRPC and two tracepoints that were useful for
finding them:

 (1) Fix missing start of expect-Rx-by timeout on initial packet
     transmission so that calls will time out if the peer doesn't respond.

 (2) Fix error reception on AF_INET6 sockets by using the correct family of
     sockopts on the UDP transport socket.

 (3) Fix setting the minimum security level on kernel calls so that they
     can be encrypted.

 (4) Add a tracepoint to log ICMP/ICMP6 and other error reports from the
     transport socket.

 (5) Add a tracepoint to log UDP sendmsg failure so that we can find out if
     transmission failure occurred on the UDP socket.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-fixes-20180510

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David
---
David Howells (5):
      rxrpc: Fix missing start of call timeout
      rxrpc: Fix error reception on AF_INET6 sockets
      rxrpc: Fix the min security level for kernel calls
      rxrpc: Add a tracepoint to log ICMP/ICMP6 and error messages
      rxrpc: Trace UDP transmission failure


 include/trace/events/rxrpc.h |   85 ++++++++++++++++++++++++++++++++++++++++++
 net/rxrpc/af_rxrpc.c         |    2 -
 net/rxrpc/ar-internal.h      |    1 
 net/rxrpc/conn_event.c       |   11 ++++-
 net/rxrpc/input.c            |    2 -
 net/rxrpc/local_event.c      |    3 +
 net/rxrpc/local_object.c     |   57 +++++++++++++++++++++-------
 net/rxrpc/output.c           |   34 ++++++++++++++++-
 net/rxrpc/peer_event.c       |   46 +++++++++++------------
 net/rxrpc/rxkad.c            |    6 ++-
 net/rxrpc/sendmsg.c          |   10 +++++
 11 files changed, 209 insertions(+), 48 deletions(-)
