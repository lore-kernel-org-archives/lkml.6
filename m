Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E062AC67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E62E2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E62E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeJIGBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:01:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeJIGBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:01:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE10B3082E4D;
        Mon,  8 Oct 2018 22:47:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBF3B6530F;
        Mon,  8 Oct 2018 22:47:19 +0000 (UTC)
Subject: [PATCH net 00/10] rxrpc: Fix packet reception code
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, pabeni@redhat.com, eric.dumazet@gmail.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Oct 2018 23:47:18 +0100
Message-ID: <153903883882.17944.17642727588248415623.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 08 Oct 2018 22:47:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are a set of patches that prepares for and fix problems in rxrpc's
package reception code.  There serious problems are:

 (A) There's a window between binding the socket and setting the data_ready
     hook in which packets can find their way into the UDP socket's receive
     queues.

 (B) The skb_recv_udp() will return an error (and clear the error state) if
     there was an error on the Tx side.  rxrpc doesn't handle this.

 (C) The rxrpc data_ready handler doesn't fully drain the UDP receive
     queue.

 (D) The rxrpc data_ready handler assumes it is called in a non-reentrant
 state.

The second patch fixes (A) - (C); the third patch renders (B) and (C)
non-issues by using the recap_rcv hook instead of data_ready - and the
final patch fixes (D).  That last is the most complex.

The preparatory patches are:

 (1) Fix some places that are doing things in the wrong net namespace.

 (2) Stop taking the rcu read lock as it's held by the IP input routine in
     the call chain.

 (3) Only end the Tx phase if *we* rotated the final packet out of the Tx
     buffer.

 (4) Don't assume that the call state won't change after dropping the
     call_state lock.

 (5) Only take receive window and MTU suze parameters from an ACK packet if
     it's the latest ACK packet.

 (6) Record connection-level abort information correctly.

 (7) Fix a trace line.

And then there are three main patches - note that these are mixed in with
the preparatory patches somewhat:

 (1) Fix the setup window (A), skb_recv_udp() error check (B) and packet
     drainage (C).

 (2) Switch to using the encap_rcv instead of data_ready to cut out the
     effects of the UDP read queues and get the packets delivered directly.

 (3) Add more locking into the various packet input paths to defend against
     re-entrance (D).

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-fixes-20181008

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David
---
David Howells (10):
      rxrpc: Fix some missed refs to init_net
      rxrpc: Fix the data_ready handler
      rxrpc: Use the UDP encap_rcv hook
      rxrpc: Don't need to take the RCU read lock in the packet receiver
      rxrpc: Don't check RXRPC_CALL_TX_LAST after calling rxrpc_rotate_tx_window()
      rxrpc: Carry call state out of locked section in rxrpc_rotate_tx_window()
      rxrpc: Only take the rwind and mtu values from latest ACK
      rxrpc: Fix connection-level abort handling
      rxrpc: Fix the rxrpc_tx_packet trace line
      rxrpc: Fix the packet reception routine


 include/trace/events/rxrpc.h |    1 
 include/uapi/linux/udp.h     |    1 
 net/rxrpc/ar-internal.h      |   23 ++--
 net/rxrpc/call_accept.c      |   27 +++-
 net/rxrpc/call_object.c      |    5 -
 net/rxrpc/conn_client.c      |   10 +-
 net/rxrpc/conn_event.c       |   26 ++--
 net/rxrpc/input.c            |  253 ++++++++++++++++++++++--------------------
 net/rxrpc/local_object.c     |   30 ++++-
 net/rxrpc/peer_event.c       |    5 +
 net/rxrpc/peer_object.c      |   29 +++--
 11 files changed, 236 insertions(+), 174 deletions(-)

