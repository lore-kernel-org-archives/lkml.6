Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660EAC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106392082C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 22:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106392082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeIXEod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 00:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725742AbeIXEod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 00:44:33 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25DBD30820D0;
        Sun, 23 Sep 2018 22:45:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB8FB3091342;
        Sun, 23 Sep 2018 22:45:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180922161406.6beo2ob6ki2otrjx@brauner.io>
References: <20180922161406.6beo2ob6ki2otrjx@brauner.io> <20180922132106.wfa6xaxwbu276qka@brauner.io> <20180921155455.flkf5vdrm3vgn6do@brauner.io> <20180920151214.15484-6-mszeredi@redhat.com> <20180920151214.15484-1-mszeredi@redhat.com> <17157.1537542475@warthog.procyon.org.uk> <20311.1537548756@warthog.procyon.org.uk> <8221.1537631312@warthog.procyon.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3867.1537742717.1@warthog.procyon.org.uk>
Date:   Sun, 23 Sep 2018 23:45:17 +0100
Message-ID: <3868.1537742717@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 23 Sep 2018 22:45:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> Of course, I'm not sure what the reasons for all of the other arguments to
> this function are since it's not yet implemented.

Well, dfd, path and atflags are pretty standard.  atflags conveys things like
AT_EMPTY_PATH or AT_SYMLINK_NOFOLLOW and dfd conveys a file descriptor
pointing to a vfs object or AT_FDCWD.

> Seems that attr_values and attr_mask could be compacted to a single
> attr_mask maybe?

If you don't have a mask, you can't really do recursion.  Without the mask,
you have to supply the entire set of options absolutely - and this would get
stamped on everything in the target range.

With a mask in combination with the set of desired values, you can turn on or
off a specific subset of the attributes without affecting the rest - without
needing to know the rest.

David
