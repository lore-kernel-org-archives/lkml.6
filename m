Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C228F20828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ABbokJpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C228F20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeK0LXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:23:30 -0500
Received: from m12-12.163.com ([220.181.12.12]:48545 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeK0LXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=8KUL6
        bkNPGbXSPw+V/6mQty5nllCIc0vXGkFSlaw6lc=; b=ABbokJpAoW1o9akccmf6d
        qgXJE8Es1We0wb7AD9fOdJQBxi8Pi7Oc6h225i7GwSVxu07aLpfwPkk/hrpVw1B/
        UGu3XhjAF4EpwvLoxK/G0nokMAoDLViygQcYjhOlkBE66P1lHLbC5WBXpJnS1a/0
        3O+sw/le2AIBgkRoDTI5bQ=
Received: from bp (unknown [106.120.213.96])
        by smtp8 (Coremail) with SMTP id DMCowACHx3ddj_xb2z+GCA--.22173S2;
        Tue, 27 Nov 2018 08:27:09 +0800 (CST)
Date:   Tue, 27 Nov 2018 08:27:10 +0800
From:   PanBian <bianpan2016@163.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Carlos Maiolino <cmaiolino@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: libxfs: move xfs_perag_put late
Message-ID: <20181127002710.GB109273@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1543052660-58625-1-git-send-email-bianpan2016@163.com>
 <20181126093139.cgojlmtubzuzdb23@hades.usersys.redhat.com>
 <20181126103619.GA95394@bp>
 <20181126141750.GA14585@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126141750.GA14585@bfoster>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: DMCowACHx3ddj_xb2z+GCA--.22173S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyUAr15uFy8Cry7JFyftFb_yoW8AFW5pF
        WfCF1FyF4kKr47C3yIyr48Z340qwsxKrWFgryYgr1xuas8XrnagwsxKryj9F9FgrW8J348
        XF4jq393GrnIyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jmNtsUUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzwUMclaD0bPVVQAAsD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:17:50AM -0500, Brian Foster wrote:
> On Mon, Nov 26, 2018 at 06:36:19PM +0800, PanBian wrote:
> > On Mon, Nov 26, 2018 at 10:31:39AM +0100, Carlos Maiolino wrote:
> > > On Sat, Nov 24, 2018 at 05:44:20PM +0800, Pan Bian wrote:
> > > > The function xfs_alloc_get_freelist calls xfs_perag_put to drop the
> > > > reference. In this case, pag may be released. However,
> > > > pag->pagf_btreeblks is read and write after the put operation. This may
> > > > result in a use-after-free bug. This patch moves the put operation late.
> > > > 
> > > 
> > > The patch looks reasonable, can you detail more how did you find it? Via code
> > > inspection of you hit this user-after-free in some way?
> > 
> > I wrote a tool to check such bugs statically. It first scans the source code 
> > to extract paired alloc/free functions. Equipped with such functions, it
> > performs an intra-procedural data flow analysis to detect mismatched
> > alloc/free bugs and use-after-free bugs.
> > 
> 
> You should probably drop the "use after free" text from your commit log
> because that's not how the perag reference counting works. If you look
> at xfs_perag_put(), you'll see it only drops a reference count and
> returns. We only ever free the perag structs on unmount (or mount
> failure), where we assert the refcount is zero. It looks like some other
> serialization mechanism would have to break down for that assert to fail
> due to this error in the allocation code because the fs is mostly shut
> down at this point in time.

I will follow your guidance to correct the commit log and resubmit the
patch.

Thanks,
Pan

> 
> Misleading commit log aside, the change seems fine to me. I think it's
> appropriate to follow the traditional/implied _get()/_put() pattern.
> 
> Brian
> 
> > Best regards,
> > Pan Bian
> > 

