Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6339E2177B
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfBQXvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:51:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfBQXvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:51:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FC3066C4B;
        Sun, 17 Feb 2019 23:51:53 +0000 (UTC)
Received: from localhost (ovpn-117-203.ams2.redhat.com [10.36.117.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF8B2608C7;
        Sun, 17 Feb 2019 23:51:52 +0000 (UTC)
Date:   Sun, 17 Feb 2019 23:51:51 +0000
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     smcdowell@cloudbd.io, kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Subject: Re: nbd, nbdkit, loopback mounts and memory management
Message-ID: <20190217235151.GZ12500@redhat.com>
References: <20190215191953.GB17897@amd>
 <20190217084458.GY12500@redhat.com>
 <20190217231514.GA10675@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217231514.GA10675@amd>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 17 Feb 2019 23:51:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:15:14AM +0100, Pavel Machek wrote:
> But Shaun reported it happened somehow often for them, so he might
> have a practical test case... better than my theories :-).

Yes, certainly not saying this isn't a problem.

I think the good news is the fix seems quite easy, ie. to add mlockall
and adjust the OOM killer score, as is done currently in the client:

https://github.com/NetworkBlockDevice/nbd/blob/3969c3f81a11a483f267a55ed6665d260dc9e1d2/nbd-client.c#L867-L885
https://github.com/NetworkBlockDevice/nbd/blob/3969c3f81a11a483f267a55ed6665d260dc9e1d2/nbd-client.c#L1219

For now I have added a note in the TODO file to follow up in case we
get a test case or reports of a problem:

https://github.com/libguestfs/nbdkit/commit/72e0afe2e280d895f68941677fafa559ddc3bb0d

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
