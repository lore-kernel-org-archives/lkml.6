Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB917ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28B521479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28B521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeJTAGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:06:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbeJTAGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:06:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C27688307;
        Fri, 19 Oct 2018 15:59:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 580835D783;
        Fri, 19 Oct 2018 15:59:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181019143932.6697-1-mszeredi@redhat.com>
References: <20181019143932.6697-1-mszeredi@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 6/5] statx: add STATX_RESULT_MASK flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18141.1539964788.1@warthog.procyon.org.uk>
Date:   Fri, 19 Oct 2018 16:59:48 +0100
Message-ID: <18142.1539964788@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 19 Oct 2018 15:59:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> wrote:

> FUSE needs this, because it uses legacy inode initialization, that doesn't
> return a result_mask, so needs a refresh when caller asks for it with
> statx().

Can't you just make it up in fuse?  Presumably, fuse doesn't support any of
the non-basic statx fields either?

> It might make sense later to promote this to a proper statx mask flag and
> return it in stx_mask to userspace.

That sounds kind of recursive - a bit in stx_mask would be saying whether or
not stx_mask can be used.

Besides, what would it mean if that bit says you can't use stx_mask?  None of
the stx_* fields are valid?

> +#define STATX_RESULT_MASK STATX__RESERVED

Please don't use that bit.


Sorry, this patch doesn't make sense.  Just set result_mask to
STATX_BASIC_STATS in fuse_fill_attr().

David
