Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42966C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EC820834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EC820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLBAtD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 19:49:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeLBAtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 19:49:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46B86A4042;
        Sat,  1 Dec 2018 13:36:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93A1460BE7;
        Sat,  1 Dec 2018 13:36:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87r2f26qng.fsf@linkitivity.dja.id.au>
References: <87r2f26qng.fsf@linkitivity.dja.id.au> <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk> <154359603369.18703.763590641473461495.stgit@warthog.procyon.org.uk>
To:     Daniel Axtens <dja@axtens.net>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        Shantanu Goel <sgoel01@yahoo.com>,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] cachefiles: Fix page leak in cachefiles_read_backing_file while vmscan is active
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32301.1543671386.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Sat, 01 Dec 2018 13:36:26 +0000
Message-ID: <32302.1543671386@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 01 Dec 2018 13:36:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> wrote:

> >   [dhowells: Note that I've removed the clearance and put of newpage as
> >    they aren't attested in the commit message and don't appear to actually
> >    achieve anything since a new page is only allocated is newpage!=NULL and
> >    any residual new page is cleared before returning.]
> 
> Sorry I hadn't got back to you on this; I think we also discussed this
> with the Ubuntu kernel team and concluded - as you did - that these
> didn't fix any bugs but did make things seem more consistent.

The idea is that if it fails to use the new page it caches it for the next
iteration of the loop rather than going to the allocator twice.  But making
the change you proposed, you should also remove the bit that discards the page
on the way out of the function and probably shouldn't initialise newpage at
the top of the function so that the compiler will let you know about paths
that don't handle it.

David
