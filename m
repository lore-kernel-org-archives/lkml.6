Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDF6C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1DF2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1DF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeJEUlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:41:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJEUlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:41:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 920463091D4F;
        Fri,  5 Oct 2018 13:42:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B425561B7F;
        Fri,  5 Oct 2018 13:42:57 +0000 (UTC)
Subject: [PATCH net 0/2] rxrpc: Fixes
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 05 Oct 2018 14:42:56 +0100
Message-ID: <153874697684.18195.15264114363303320691.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 05 Oct 2018 13:42:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Here are two fixes for AF_RXRPC:

 (1) Fix some places that are doing things in the wrong net namespace.

 (2) Fix the reception of UDP packets in three ways:

     (a) Close the window between binding the socket and setting the
     	 data_ready hook in which packets can come in and get lodged in the
     	 receive queue without data_ready seeing them.

     (b) Make sure the UDP receive queue is drained before returning from
     	 the data_ready hook.

     (c) Ignore Tx errors returned by skb_recv_udp().

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	rxrpc-fixes-20181005

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

David
---
David Howells (2):
      rxrpc: Fix some missed refs to init_net
      rxrpc: Fix the data_ready handler


 net/rxrpc/ar-internal.h  |   10 ++++---
 net/rxrpc/call_accept.c  |    2 +
 net/rxrpc/call_object.c  |    4 +--
 net/rxrpc/conn_client.c  |   10 ++++---
 net/rxrpc/input.c        |   68 ++++++++++++++++++++++++++--------------------
 net/rxrpc/local_object.c |   11 ++++---
 net/rxrpc/peer_object.c  |   28 ++++++++++++-------
 7 files changed, 76 insertions(+), 57 deletions(-)

