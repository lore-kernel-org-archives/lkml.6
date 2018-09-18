Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0716C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E37C2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E37C2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbeIRVHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:07:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729947AbeIRVHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:07:47 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77C2D30833B1;
        Tue, 18 Sep 2018 15:34:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E62E830912F4;
        Tue, 18 Sep 2018 15:34:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180918090722.GA463@jagdpanzerIV>
References: <20180918090722.GA463@jagdpanzerIV> <20180911220743.GA13208@roeck-us.net> <20180911174641.GA15149@roeck-us.net> <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk> <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk> <27113.1536702746@warthog.procyon.org.uk> <32382.1536707855@warthog.procyon.org.uk> <20180911235403.GA10107@roeck-us.net>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     dhowells@redhat.com, Guenter Roeck <linux@roeck-us.net>,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock creation/configuration context [ver #11]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23042.1537284879.1@warthog.procyon.org.uk>
Date:   Tue, 18 Sep 2018 16:34:39 +0100
Message-ID: <23043.1537284879@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 18 Sep 2018 15:34:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

>  static void do_emergency_remount_callback(struct super_block *sb)
>  {
>  	struct fs_context fc = {
> +		.ops		= &legacy_fs_context_ops,
>  		.purpose	= FS_CONTEXT_FOR_EMERGENCY_RO,
>  		.fs_type	= sb->s_type,
>  		.root		= sb->s_root,

Actually, we do need to call ->init_fs_context() or legacy_init_fs_context()
to set the ops pointer.

David
