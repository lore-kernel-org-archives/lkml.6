Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E513ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B47620867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B47620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeIRDBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 23:01:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbeIRDBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 23:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 420AF307D851;
        Mon, 17 Sep 2018 21:32:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF8471C95D;
        Mon, 17 Sep 2018 21:32:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <a37220c23479c79239b046e2487cfc95544b8f13.camel@hammerspace.com>
References: <a37220c23479c79239b046e2487cfc95544b8f13.camel@hammerspace.com> <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk> <153685392942.14766.3347355712333618914.stgit@warthog.procyon.org.uk> <20180914041831.GY19965@ZenIV.linux.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com,
        "viro@ZenIV.linux.org.uk" <viro@ZenIV.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 04/10] iov_iter: Add mapping and discard iterator types
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5763.1537219964.1@warthog.procyon.org.uk>
Date:   Mon, 17 Sep 2018 22:32:44 +0100
Message-ID: <5764.1537219964@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 17 Sep 2018 21:32:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> wrote:

> Another question that is relevant for most networked filesystems
> (including AFS, I believe), is how will you deal with encryption of the
> data you are transmitting? Encrypting and decrypting in-place directly
> in the page cache or in a userspace O_DIRECT mapped buffer might not be
> the best and most secure option, so won't you find yourself wanting to
> copy the data anyway?

For kAFS, the interface between kAFS and AF_RXRPC takes an iterator.

Currently, encryption is done in place on the sk_buffs inside AF_RXRPC, but
the goal I have in mind is to use the crypto operation to replace the copy
between sk_buff and buffer.  This is tricky, however, as the encrypted payload
contains metadata as well as data and on reception I have to read the metadata
to find out how much data there actually is.

David
