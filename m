Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F652098B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F652098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933791AbeGDJPB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:15:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932479AbeGDJO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:14:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70E7681A4EAD;
        Wed,  4 Jul 2018 09:14:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-203.rdu2.redhat.com [10.10.123.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E4591C581;
        Wed,  4 Jul 2018 09:14:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <877emb2740.fsf@notabene.neil.brown.name>
References: <877emb2740.fsf@notabene.neil.brown.name> <20180222073330.36259-1-carmark.dlut@gmail.com> <afbfd186-1f06-a03c-79b5-c98a12d35c75@metrics.net>
To:     NeilBrown <neilb@suse.com>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Anthony DeRobertis <aderobertis@metrics.net>,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        Lei Xue <carmark.dlut@gmail.com>,
        Vegard Nossum <vegard.nossum@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        KiranKumar Modukuri <kiran.modukuri@gmail.com>
Subject: Re: [PATCH] cachefiles: fix multiple-put race.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24654.1530695695.1@warthog.procyon.org.uk>
Date:   Wed, 04 Jul 2018 10:14:55 +0100
Message-ID: <24655.1530695695@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 04 Jul 2018 09:14:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 04 Jul 2018 09:14:59 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.com> wrote:

> +	fscache_enqueue_retrieval(monitor->op);
> +
>  	spin_lock(&object->work_lock);
>  	list_add_tail(&monitor->op_link, &monitor->op->to_do);
>  	spin_unlock(&object->work_lock);
>  
> -	fscache_enqueue_retrieval(monitor->op);

That won't necessarily work because the work processor can then happen before
you've added the work to the to_do list.

I'm thinking that KiranKumar's solution might be the best one.

The problem is that cachefiles_read_waiter() doesn't have a ref on the monitor
object but is entirely dependent on the waitqueue lock for safety.  I think
KiranKumar's patch is correct to take a ref before doing the queuing.  It
might be possible to then pass this along to the work processor, but that
might be too fiddly.

Actually, I want to get rid of the page monitoring stuff entirely as it's
quite fragile and use an iterator and direct-IO instead, but we have to fix
this for now.

David
