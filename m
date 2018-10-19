Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D394ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D6F2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D6F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJTH6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbeJTH6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:58:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C5DC30024D8;
        Fri, 19 Oct 2018 23:50:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DE376F927;
        Fri, 19 Oct 2018 23:50:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegtPv4+QxzcqMAGwTt7QALjBaxQtt2Qet98pdmuT1MRUeA@mail.gmail.com>
References: <CAJfpegtPv4+QxzcqMAGwTt7QALjBaxQtt2Qet98pdmuT1MRUeA@mail.gmail.com> <20181019143932.6697-1-mszeredi@redhat.com> <18142.1539964788@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 6/5] statx: add STATX_RESULT_MASK flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2954.1539993032.1@warthog.procyon.org.uk>
Date:   Sat, 20 Oct 2018 00:50:32 +0100
Message-ID: <2955.1539993032@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 19 Oct 2018 23:50:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> This is very much about the basic statx fields.  I.e. what does
> result_mask == STATX_BASIC_STATS means?
> 
>  a) this is a legacy stat() implementation that doesn't fill in the
> result_mask properly
> 
>  b) this is an up-todate stat() implementation that does fill the
> result_mask properly and all fields are valid
> 
> There's no way to tell which one it is, and no way to request that
> filesystem try b) even if it's more costly.

Okay, I think I see what you're getting at.  We need to be able to tell the
user that we don't actually know what's good and what's not.  I guess this
doesn't only apply to fuse, but could also apply to nfs potentially as nfs
doesn't necessarily know what the server is capable of and where it's making
stuff up (imagine an NFS server backing both an ext4 and a fat filesystem).

I would be tempted to represent this with an attribute flag instead, say:

	STATX_ATTR_UNCERTAIN_VALUES

Your attributes are actually in one of at least three states, not two:
unsupported, definite and uncertain.  Definite things might include such as
STATX_TYPE - after all, if you don't know what type a file is, you can't
really use it.

If someone really needs to know, it might be worth deferring further
information to fsinfo().

David
