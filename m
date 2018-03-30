Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeC3VOH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:14:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752314AbeC3VOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:14:05 -0400
Subject: [PATCH net-next 00/12] rxrpc: Fixes and more traces
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Fri, 30 Mar 2018 22:14:04 +0100
Message-ID: <152244444395.4629.2080470182140292459.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are some patches that add some more tracepoints to AF_RXRPC and fix
some issues therein:

 (1) Fix the use of VERSION packets to keep firewall routes open.

 (2) Fix the incorrect current time usage in a tracepoint.

 (3) Fix Tx ring annotation corruption.

 (4) Fix accidental conversion of call-level abort into connection-level
     abort.

 (5) Fix calculation of resend time.

 (6) Remove a couple of unused variables.

 (7) Fix a bunch of checker warnings and an error.  Note that not all
     warnings can be quashed as checker doesn't seem to correctly handle
     seqlocks.

 (8) Fix a potential race between call destruction and socket/net
     destruction.

 (9) Add a tracepoint to track rxrpc_local refcounting.

(10) Fix an apparent leak of rxrpc_local objects.

(11) Add a tracepoint to track rxrpc_peer refcounting.

(12) Fix a leak of rxrpc_peer objects.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-next-20180330

and can also be found on this branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-next

David
---
David Howells (10):
      rxrpc: Fix firewall route keepalive
      rxrpc: Fix a bit of time confusion
      rxrpc: Fix Tx ring annotation after initial Tx failure
      rxrpc: Don't treat call aborts as conn aborts
      rxrpc: Fix checker warnings and errors
      rxrpc: Fix potential call vs socket/net destruction race
      rxrpc: Add a tracepoint to track rxrpc_local refcounting
      rxrpc: Fix apparent leak of rxrpc_local objects
      rxrpc: Add a tracepoint to track rxrpc_peer refcounting
      rxrpc: Fix leak of rxrpc_peer objects

Marc Dionne (1):
      rxrpc: Fix resend event time calculation

Sebastian Andrzej Siewior (1):
      rxrpc: remove unused static variables


 include/trace/events/rxrpc.h |   85 ++++++++++++++++++++++++++++++++++++
 net/rxrpc/af_rxrpc.c         |    6 +++
 net/rxrpc/ar-internal.h      |   68 +++++++++++------------------
 net/rxrpc/call_accept.c      |    9 +++-
 net/rxrpc/call_event.c       |    4 +-
 net/rxrpc/call_object.c      |   17 ++++++-
 net/rxrpc/conn_client.c      |    3 +
 net/rxrpc/conn_event.c       |    3 +
 net/rxrpc/conn_object.c      |   10 ++++
 net/rxrpc/conn_service.c     |    1 
 net/rxrpc/input.c            |   17 +++++--
 net/rxrpc/local_object.c     |   65 +++++++++++++++++++++++++++-
 net/rxrpc/net_ns.c           |   24 ++++++++++
 net/rxrpc/output.c           |   59 +++++++++++++++++++++++++
 net/rxrpc/peer_event.c       |   98 ++++++++++++++++++++++++++++++++++++++++++
 net/rxrpc/peer_object.c      |   93 +++++++++++++++++++++++++++++++++++++++-
 net/rxrpc/proc.c             |    6 +++
 net/rxrpc/rxkad.c            |    2 +
 net/rxrpc/security.c         |    3 -
 net/rxrpc/sendmsg.c          |    7 +++
 20 files changed, 509 insertions(+), 71 deletions(-)
