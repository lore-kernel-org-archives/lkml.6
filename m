Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C4BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF3820645
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF3820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJDUoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:44:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeJDUoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:44:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 033B486671;
        Thu,  4 Oct 2018 13:50:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B8E1675C7;
        Thu,  4 Oct 2018 13:50:36 +0000 (UTC)
Subject: [PATCH net-next 0/9] rxrpc: Development
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:50:31 +0100
Message-ID: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 04 Oct 2018 13:50:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are some development patches for AF_RXRPC.  The most significant points
are:

 (1) Change the tracepoint that indicates a packet has been transmitted
     into one that indicates a packet is about to be transmitted.  Without
     this, the response tracepoint may occur first if the round trip is
     fast enough.

 (2) Sort out AFS address list handling to better enforce maximum capacity
     to use helper functions to fill them and to do an insertion sort to
     order them.  This is here to make (3) easier.

 (3) Keep AF_INET addresses as AF_INET addresses rather than converting
     them to AF_INET6 in both AF_RXRPC and kAFS.  I hadn't realised that a
     UDP6 socket would just call down into UDP4 if given an AF_INET
     address.

 (4) Allow the timestamp on the first DATA packet of a reply to be
     retrieved by a kernel service.  This will give the kAFS a more
     accurate base from which to calculate the callback promise expiration.

 (5) Allow the rxrpc protocol epoch value to be retrieved from an incoming
     call.  This will allow kAFS to determine if the fileserver restarted
     and if two addresses apparently assigned to the same fileserver
     actually are different boxes.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-next-20181004

and can also be found on this branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-next

David
---
David Howells (9):
      rxrpc: Use rxrpc_free_skb() rather than rxrpc_lose_skb()
      rxrpc: Emit the data Tx trace line before transmitting
      afs: Do better max capacity handling on address lists
      afs: Always build address lists using the helper functions
      afs: Sort address lists so that they are in logical ascending order
      rxrpc: Use IPv4 addresses throught the IPv6
      rxrpc: Drop the local endpoint arg from rxrpc_extract_addr_from_skb()
      rxrpc: Allow the reply time to be obtained on a client call
      rxrpc: Allow the reply time to be obtained on a client call


 Documentation/networking/rxrpc.txt |   25 +++++++++
 fs/afs/addr_list.c                 |  101 ++++++++++++++++++------------------
 fs/afs/internal.h                  |    8 ++-
 include/net/af_rxrpc.h             |    4 +
 net/rxrpc/af_rxrpc.c               |   17 ++++++
 net/rxrpc/ar-internal.h            |    4 -
 net/rxrpc/call_accept.c            |    2 -
 net/rxrpc/conn_object.c            |    7 +-
 net/rxrpc/input.c                  |    2 -
 net/rxrpc/local_event.c            |    2 -
 net/rxrpc/output.c                 |   10 ++--
 net/rxrpc/peer_event.c             |   12 ++--
 net/rxrpc/recvmsg.c                |   43 +++++++++++++++
 net/rxrpc/skbuff.c                 |   15 -----
 net/rxrpc/utils.c                  |   23 ++------
 15 files changed, 169 insertions(+), 106 deletions(-)

