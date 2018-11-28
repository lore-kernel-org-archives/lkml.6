Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4861EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D472081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D472081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeK2COa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:14:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeK2COa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:14:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E23530842AB;
        Wed, 28 Nov 2018 15:12:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4406B1019624;
        Wed, 28 Nov 2018 15:12:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87r2gd44hu.fsf@notabene.neil.brown.name>
References: <87r2gd44hu.fsf@notabene.neil.brown.name>
To:     NeilBrown <neilb@suse.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fscache: fix race between enablement and dropping of object
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10284.1543417950.1@warthog.procyon.org.uk>
Date:   Wed, 28 Nov 2018 15:12:30 +0000
Message-ID: <10285.1543417950@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 28 Nov 2018 15:12:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.com> wrote:

> It was observed that a process blocked indefintely in
> __fscache_read_or_alloc_page(), waiting for FSCACHE_COOKIE_LOOKING_UP
> to be cleared via fscache_wait_for_deferred_lookup().

Was there a backtrace for that?

> This leaves a window where something else can set FSCACHE_COOKIE_LOOKING_UP

Attempting to enable the cookie again would have that effect.

> There is some uncertainty in this analysis, but it seems to be fit the
> observations.  Adding the wake in this patch will be handled correctly
> by __fscache_read_or_alloc_page(), as it checks if ->backing_objects
> is empty again, after waiting.

That should work.  The read op should just then fail with -ENOBUFS, causing
the netfs to issue the read over the network instead.

I think there's a more elegant solution to be had, but it'll take some thought
as to how to achieve it.

David
