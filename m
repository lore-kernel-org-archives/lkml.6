Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC959C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5709120834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5709120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeJEXcu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:32:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:32:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C5C4315009D;
        Fri,  5 Oct 2018 16:33:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE1E443FF2;
        Fri,  5 Oct 2018 16:33:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <80cf9647-ffdf-210a-7b0e-22bf35a57239@gmail.com>
References: <80cf9647-ffdf-210a-7b0e-22bf35a57239@gmail.com> <bf1d0734-d73a-83e9-c8e5-0fa4d447bc51@gmail.com> <153874697684.18195.15264114363303320691.stgit@warthog.procyon.org.uk> <153874699086.18195.6819270943388841145.stgit@warthog.procyon.org.uk> <15184.1538749081@warthog.procyon.org.uk>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     dhowells@redhat.com, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 2/2] rxrpc: Fix the data_ready handler
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25988.1538757200.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 05 Oct 2018 17:33:20 +0100
Message-ID: <25989.1538757200@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 05 Oct 2018 16:33:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <eric.dumazet@gmail.com> wrote:

> sk_data_ready is not meant to process packets, it is meant to signal
> to another entity (preferably running in process context and thus with proper
> schedule points, and not blocking BH) that there is data ready to be consumed.

The issue is that I need to route the packets to the appropriate call, and the
BH appears to be the right place to do this, especially as I can quickly parse
and discard certain types of packet right there.

If I move all of this to process context then that adds extra context switches
between the routing process and the destination process.

> Under DOS, it is possible multiple cpus will sk_data_ready in parallel.

Ummm...  I've been led to believe that sk_data_ready will *not* be called in
parallel and that the code it calls can assume non-reentrancy.  Is this not
the case?

What about the patch I attached, whereby I use the encap_rcv() hook.  Do you
say that won't work?

David
