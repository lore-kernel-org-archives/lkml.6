Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E9DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38C52172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38C52172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeI1Qc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:32:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729093AbeI1Qc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:32:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75C17C058CB9;
        Fri, 28 Sep 2018 10:09:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3BC55DD87;
        Fri, 28 Sep 2018 10:09:51 +0000 (UTC)
Subject: [PATCH net 0/8] rxrpc: Fixes
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 11:09:51 +0100
Message-ID: <153812939111.10469.179989653628053410.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 28 Sep 2018 10:09:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are some miscellaneous fixes for AF_RXRPC:

 (1) Remove a duplicate variable initialisation.

 (2) Fix one of the checks made when we decide to set up a new incoming
     service call in which a flag is being checked in the wrong field of
     the packet header.  This check is abstracted out into helper
     functions.

 (3) Fix RTT gathering.  The code has been trying to make use of socket
     timestamps, but wasn't actually enabling them.  The code has also been
     recording a transmit time for the outgoing packet for which we're
     going to measure the RTT after sending the message - but we can get
     the incoming packet before we get to that and record a negative RTT.

 (4) Fix the emission of BUSY packets (we are emitting ABORTs instead).

 (5) Improve error checking on incoming packets.

 (6) Try to fix a bug in new service call handling whereby a BUG we should
     never be able to reach somehow got triggered.  Do this by moving much
     of the checking as early as possible and not repeating it later
     (depends on (5) above).

 (7) Fix the sockopts set on a UDP6 socket to include the ones set on a
     UDP4 socket so that we receive UDP4 errors and packet-too-large
     notifications too.

 (8) Fix the distribution of errors so that we do it at the point of
     receiving an error in the UDP callback rather than deferring it
     thereby cutting short any transmissions that would otherwise occur in
     the window.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-fixes-20180928

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David
---
David Howells (8):
      rxrpc: Remove dup code from rxrpc_find_connection_rcu()
      rxrpc: Fix checks as to whether we should set up a new call
      rxrpc: Fix RTT gathering
      rxrpc: Emit BUSY packets when supposed to rather than ABORTs
      rxrpc: Improve up-front incoming packet checking
      rxrpc: Make service call handling more robust
      rxrpc: Fix transport sockopts to get IPv4 errors on an IPv6 socket
      rxrpc: Fix error distribution


 include/trace/events/rxrpc.h |    4 --
 net/rxrpc/ar-internal.h      |   36 +++++++++--------
 net/rxrpc/call_accept.c      |   45 +++++++--------------
 net/rxrpc/call_object.c      |    2 -
 net/rxrpc/conn_client.c      |    4 +-
 net/rxrpc/conn_object.c      |   14 ++++---
 net/rxrpc/input.c            |   90 ++++++++++++++++++++++++++++++------------
 net/rxrpc/local_object.c     |   32 ++++++++++-----
 net/rxrpc/output.c           |   54 +++++++++++++++++--------
 net/rxrpc/peer_event.c       |   46 +++++----------------
 net/rxrpc/peer_object.c      |   52 +++++-------------------
 net/rxrpc/protocol.h         |   15 -------
 12 files changed, 189 insertions(+), 205 deletions(-)

