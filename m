Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1406CC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F3620854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F3620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeJEFqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:46:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeJEFqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:46:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95CF8C059B78;
        Thu,  4 Oct 2018 22:50:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9ACE1700B;
        Thu,  4 Oct 2018 22:50:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <87a7nttm5o.fsf@notabene.neil.brown.name>
References: <87a7nttm5o.fsf@notabene.neil.brown.name> <153861496327.30373.10501882399296347125.stgit@noble> <153861471803.30373.6184444014227748848.stgit@noble> <28763.1538662213@warthog.procyon.org.uk>
To:     NeilBrown <neilb@suse.com>
Cc:     dhowells@redhat.com, "J. Bruce Fields" <bfields@fieldses.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, linux-nfs@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] VFS: introduce MAY_ACT_AS_OWNER
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2792.1538693434.1@warthog.procyon.org.uk>
Date:   Thu, 04 Oct 2018 23:50:34 +0100
Message-ID: <2793.1538693434@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 04 Oct 2018 22:50:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.com> wrote:

> Thanks for the review.
> As afs doesn't use the generic xattr code and doesn't call
> setattr_prepare(), this is all largely irrelevant for afs.

Yeah - there's no xattr support yet.

> afs_permission() will probably only get MAY_ACT_AS_OWNER passed when
> someone uses fcntl(F_SETFL) to set the O_NOATIME flag.

There's no atime in AFS.

> Currently a permission test based on UID is performed which, as you say,
> is wrong.  My patch simply preserved this current (wrong) behaviour.
> Shall I change it to always allow access, like with NFS?

You have to have an appropriate key to be able to do anything not granted to
anonymous with the server.  If the server says your key (or lack thereof) is
allowed to do something, you can do it; if it does not, you can't.

> Probably O_NOATIME is ignored, in which case f_op->check_flags should
> probably report -EINVAL (???) ... or might that cause a regression?

No atime.  I just ignore things like O_NOATIME.  You will be able to query the
filesystem with fsinfo() hopefully soon to find out if there is an atime and
if you can disable it.

Davod
