Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F71AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4257820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4257820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389271AbeHAOo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:44:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389226AbeHAOo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:44:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8D028197022;
        Wed,  1 Aug 2018 12:58:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 546A120389E1;
        Wed,  1 Aug 2018 12:58:46 +0000 (UTC)
Subject: [PATCH net-next 00/10] rxrpc: Development
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Aug 2018 13:58:45 +0100
Message-ID: <153312832565.27702.15302541876382957550.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 12:58:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 01 Aug 2018 12:58:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are some patches that add some more tracepoints to AF_RXRPC and fix
some issues therein.  The most significant points are:

 (1) Display the call timeout information in /proc/net/rxrpc/calls.

 (2) Save the call's debug_id in the rxrpc_channel struct so that it can be
     used in traces after the rxrpc_call struct has been destroyed.

 (3) Increase the size of the kAFS Rx window from 32 to 63 to be about the
     same as the Auristor server.

 (4) Propose the terminal ACK for a client call after it has received all
     its data to be transmitted after a short interval so that it will get
     transmitted if not first superseded by a new call on the same channel.

 (5) Flush ACKs during the data reception if we detect that we've run out
     of data.[*]

 (6) Trace successful packet transmission and softirq to process context
     socket notification.

[*] Note that on a uncontended gigabit network, rxrpc runs in to trouble
    with ACK packets getting batched together (up to ~32 at a time)
    somewhere between the IP transmit queue on the client and the ethernet
    receive queue on the server.

    I can see the kernel afs filesystem client and Auristor userspace
    server stalling occasionally on a 512MB single read.  Sticking
    tracepoints in the network driver at either end seems to show that,
    although the ACK transmissions made by the client are reasonably spaced
    timewise, the received ACKs come in batches from the network card on
    the server.

    I'm not sure what, if anything, can be done about this.


The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-next-20180801

and can also be found on this branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-next

David
---
David Howells (9):
      rxrpc: Display call expect-receive-by timeout in proc
      rxrpc: Show some more information through /proc files
      rxrpc: Fix the trace for terminal ACK (re)transmission
      rxrpc: Trace packet transmission
      rxrpc: Fix ACK proposal tracepoint
      rxrpc: Trace socket notification
      rxrpc: Increase the size of a call's Rx window
      rxrpc: Propose, but don't immediately transmit, the final ACK for a call
      rxrpc: Transmit more ACKs during data reception

YueHaibing (1):
      rxrpc: remove redundant variables 'sp' and 'did_discard'


 include/trace/events/rxrpc.h |  129 ++++++++++++++++++++++++++++++------------
 net/rxrpc/ar-internal.h      |    4 +
 net/rxrpc/call_event.c       |    2 -
 net/rxrpc/conn_client.c      |    3 -
 net/rxrpc/conn_event.c       |   17 ++++--
 net/rxrpc/input.c            |   15 ++++-
 net/rxrpc/local_event.c      |    5 +-
 net/rxrpc/output.c           |   32 ++++++++--
 net/rxrpc/proc.c             |   23 ++++++-
 net/rxrpc/recvmsg.c          |   23 ++++++-
 net/rxrpc/rxkad.c            |    7 ++
 11 files changed, 193 insertions(+), 67 deletions(-)

