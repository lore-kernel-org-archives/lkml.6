Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A5ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95AC206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95AC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeIXMvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 08:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45961 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeIXMvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 08:51:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C58E23081247;
        Mon, 24 Sep 2018 06:50:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72651CDBE2;
        Mon, 24 Sep 2018 06:50:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180923230150.32qbjhnnzy56x3yy@brauner.io>
References: <20180923230150.32qbjhnnzy56x3yy@brauner.io> <20180922161406.6beo2ob6ki2otrjx@brauner.io> <20180922132106.wfa6xaxwbu276qka@brauner.io> <20180921155455.flkf5vdrm3vgn6do@brauner.io> <20180920151214.15484-6-mszeredi@redhat.com> <20180920151214.15484-1-mszeredi@redhat.com> <17157.1537542475@warthog.procyon.org.uk> <20311.1537548756@warthog.procyon.org.uk> <8221.1537631312@warthog.procyon.org.uk> <3868.1537742717@warthog.procyon.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30363.1537771838.1@warthog.procyon.org.uk>
Date:   Mon, 24 Sep 2018 07:50:38 +0100
Message-ID: <30364.1537771838@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 24 Sep 2018 06:50:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> Ok, understood. What about passing the different attrs as a struct?
> 
> struct mount_attr {
>         unsigned int attr_cmd,
>         unsigned int attr_values,
>         unsigned int attr_mask,
> 
> };
> 
> mount_setattr(int dfd, const char *path, unsigned int atflags,
>               struct mount_attr *attr);
> 
> I find that to be a little cleaner in all honesty.
> One could also add a version argument similar to what we currently do
> for vfs fcaps so that kernel and userspace can easily navigate
> compabitility when a new member gets added or removed in later releases.

Yeah, we could do that - it's not like I expect mount_setattr() to have to be
particularly performant in the user interface.  I would put the attr_cmd in
the argument list, probably, so that you can use that to vary the struct in
future (say we run out of attribute bits).

David
