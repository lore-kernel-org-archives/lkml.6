Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F66C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67D420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67D420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeFTKxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:53:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752787AbeFTKxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:53:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 753D740214E2;
        Wed, 20 Jun 2018 10:53:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-94.rdu2.redhat.com [10.10.120.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A07CF7C25;
        Wed, 20 Jun 2018 10:53:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180620074647.4152617-1-arnd@arndb.de>
References: <20180620074647.4152617-1-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     dhowells@redhat.com, y2038@lists.linaro.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: use a consistent interpretation of time values
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5319.1529492016.1@warthog.procyon.org.uk>
Date:   Wed, 20 Jun 2018 11:53:36 +0100
Message-ID: <5320.1529492016@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 20 Jun 2018 10:53:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 20 Jun 2018 10:53:37 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:

> which avoids the y2038 overflow

No it doesn't.  The AFS protocol is limited.

> +	time64_t		mtime_client;	/* last time client changed data */
> +	time64_t		mtime_server;	/* last time server changed data */
> ...
> -	time_t			creation;	/* volume creation time */
> +	time64_t		creation;	/* volume creation time */

Unless you can change the AFS protocol, this is a waste of memory.  It might
be better to change them to u32 as they are protocol values rather than system
values.

> -	inode->i_ctime.tv_sec	= get_seconds();
> -	inode->i_ctime.tv_nsec	= 0;
> -	inode->i_atime		= inode->i_mtime = inode->i_ctime;
> +	inode->i_ctime = inode->i_atime = inode->i_mtime = current_time(inode);

Surely, the tv_nsec should be zero since anything else cannot be represented
in the AFS protocol.

I will grant, however, I should be consistently using them as unsigned values.

Note that the answers to the above may change if and when I start supporting
the YFS protocol extensions, but for the AFS protocol, this is simply not
there.

David
