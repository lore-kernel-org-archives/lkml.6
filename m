Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B036DFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3F20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB3F20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeING0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 02:26:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbeING0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 02:26:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A68C53084219;
        Fri, 14 Sep 2018 01:14:51 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2112C5D6AA;
        Fri, 14 Sep 2018 01:14:49 +0000 (UTC)
Date:   Thu, 13 Sep 2018 21:14:48 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Joe Thornber <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 13 (dm-thin-pool)
Message-ID: <20180914011448.GA7110@redhat.com>
References: <20180913152753.60866288@canb.auug.org.au>
 <258e14a1-0dbc-74ff-23a5-cd676fdf4579@infradead.org>
 <20180913185147.GA5647@redhat.com>
 <6572c1a5-3db0-af6d-30cc-f9f7c0dc604c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6572c1a5-3db0-af6d-30cc-f9f7c0dc604c@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 14 Sep 2018 01:14:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13 2018 at  8:45pm -0400,
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 9/13/18 11:51 AM, Mike Snitzer wrote:
> > On Thu, Sep 13 2018 at  1:28pm -0400,
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> >> On 9/12/18 10:27 PM, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> News: there will be no linux-next releases on Friday or Monday.
> >>>
> >>> Changes since 20180912:
> >>>
> >>
> >> on i386:
> >>
> >> ERROR: "__udivdi3" [drivers/md/dm-thin-pool.ko] undefined!
> > 
> > Well, as I pointed out in reply that nobody will see to the buildbots:
> > 
> > There is something off in this report... I cannot reproduce.  It is
> > almost like the warning was generated when building an older version of
> > this change, but then reported against the latest commit.
> > 
> > I switched to sector_div() specifically because of the undefined
> > __udivdi3 error.
> > 
> > So I'm ignoring this given I cannot reproduce when using 'make ARCH=i386'
> 
> > gcc --version
> gcc (SUSE Linux) 4.8.5
> 
> # CONFIG_LBDAF is not set
> 
> Perhaps you could try to reproduce it with the attached randconfig file.

Ah, yeap.. sector_div() is only viable for use with sector_t.
dm_block_t is typedef'd to uint64_t -- so that explains it.

Need to use div_u64() instead.

Thanks,
Mike
