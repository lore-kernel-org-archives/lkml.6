Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E78C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E2F206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfBVPAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:00:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbfBVPAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:00:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67DAE5D5EC;
        Fri, 22 Feb 2019 15:00:22 +0000 (UTC)
Received: from laptop.jcline.org (ovpn-124-228.rdu2.redhat.com [10.10.124.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 429E360180;
        Fri, 22 Feb 2019 15:00:22 +0000 (UTC)
Received: from laptop.jcline.org (localhost [IPv6:::1])
        by laptop.jcline.org (Postfix) with ESMTPS id 4E4397045B3B;
        Fri, 22 Feb 2019 10:00:21 -0500 (EST)
Date:   Fri, 22 Feb 2019 10:00:20 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     David Both <dboth@millennium-technology.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: update i_atime when reading files
Message-ID: <20190222150020.GA14465@laptop.jcline.org>
References: <20190221163714.22330-1-jcline@redhat.com>
 <20190222053742.GA4270@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222053742.GA4270@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 22 Feb 2019 15:00:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:37:42AM +0300, Alexey Dobriyan wrote:
> On Thu, Feb 21, 2019 at 11:37:14AM -0500, Jeremy Cline wrote:
> > Prior to commit 1da4d377f943 ("proc: revalidate misc dentries"), the
> > access, modify, and change times of files in /proc were just the current
> > time.
> 
> Ehh, actually no. Doing
> 
> 	$(which sleep) infinity </proc/foo &
> 
> will sabotage atime updates because dentry and inode will be pinned in
> caches.
> 
> "revalidate misc denries" commit simply makes the effect (much) more
> visible by making objects stay in caches for longer.

Indeed. It wasn't my intention to imply there's anything wrong with that
commit, just that that's what caused this apparent change in behavior
for users. In the "common" case when something hasn't pinned the dentry
and inode what users saw was the current time.

> 
> > Now the mtime and ctime values change mostly as a user would
> > expect, but the atime isn't updated when the file read. This patch
> > updates the access time of /proc files when they are read.
> 
> >  			rv = read(file, buf, count, ppos);
> > +			if (rv >= 0)
> > +				inode->i_atime = current_time(inode);
> > +		}
> 
> Maybe it should be done given /proc is virtual so there are no concerns
> about scheduling writes noone cares about to the filesystem.

Sorry, maybe I've not had enough coffee yet, but I don't understand this
sentence.

Thanks,
Jeremy
