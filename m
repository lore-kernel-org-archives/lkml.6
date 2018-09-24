Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056D6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C0921486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C0921486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbeIXSjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:39:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbeIXSjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:39:43 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52C9E30DF6E7;
        Mon, 24 Sep 2018 12:37:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA5ED30A605C;
        Mon, 24 Sep 2018 12:37:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180924094755.lkwdbrrayfrp45uu@brauner.io>
References: <20180924094755.lkwdbrrayfrp45uu@brauner.io> <20180922161406.6beo2ob6ki2otrjx@brauner.io> <20180922132106.wfa6xaxwbu276qka@brauner.io> <20180921155455.flkf5vdrm3vgn6do@brauner.io> <20180920151214.15484-6-mszeredi@redhat.com> <20180920151214.15484-1-mszeredi@redhat.com> <17157.1537542475@warthog.procyon.org.uk> <20311.1537548756@warthog.procyon.org.uk> <8221.1537631312@warthog.procyon.org.uk> <3868.1537742717@warthog.procyon.org.uk> <30364.1537771838@warthog.procyon.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, aviro@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29955.1537792665.1@warthog.procyon.org.uk>
Date:   Mon, 24 Sep 2018 13:37:45 +0100
Message-ID: <29956.1537792665@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 24 Sep 2018 12:37:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> I have thought a little more about splitting up the mount flags into
> sensible sets. I think the following four sets make sense:
>
> enum {
>         MOUNT_ATTR_PROPAGATION = 1,
>         MOUNT_ATTR_SECURITY,
>         MOUNT_ATTR_SYNC,
>         MOUNT_ATTR_TIME,
> };

Al (I think it was) has been against splitting them up before (I've previously
proposed splitting the topology propagation flags from the mount attributes).

> #define MOUNT_ATTR_NOATIME     (1<<1)
> #define MOUNT_ATTR_RELATIME    (1<<3)
> #define MOUNT_ATTR_STRICTATIME (1<<4)

These aren't independent, but are actually settings on the same dial, so I
would suggest that they shouldn't be separate flags.  I'm not sure about
LAZYTIME though.

> enum {
>         MOUNT_ATTR_PROPAGATION = 1,
>         MOUNT_ATTR_SECURITY,
>         MOUNT_ATTR_SECURITY_1 = MOUNT_ATTR_SECURITY,
>         MOUNT_ATTR_SYNC,
>         MOUNT_ATTR_TIME,
>         MOUNT_ATTR_SECURITY_2,
> };

In UAPI headers, always explicitly number your symbols, even in an enum, just
to make sure that the numbers don't get transparently changed by accident.

> These flags will likely become AT_* flags or be tied to a syscall
> afaict.
>
> #define MS_REMOUNT      32
> #define MS_BIND	        4096
> #define MS_MOVE	        8192
> #define MS_REC	        16384

MS_REMOUNT: fd = fspick(); fscommand(fd, FSCONFIG_CMD_RECONFIGURE);

MS_REMOUNT|MS_BIND: mount_setattr().

MS_BIND: fd = open_tree(..., OPEN_TREE_CLONE); move_mount(fd, "", ...);

MS_MOVE: fd = open_tree(..., 0); move_mount(fd, "", ...);

MS_REC: AT_RECURSIVE

> Internal sb flags will not be part of the new mount attr sets. (They
> should - imho - not be exposed to userspace at all.):

Agreed.

> What remains is an odd duck that probably could be thrown into security
> but also *shrug*
>
> #define MS_I_VERSION    (1<<23)

Um.  I think it would probably belong with atime settings.

David
