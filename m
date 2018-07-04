Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A0BC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA08123C6A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA08123C6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbeGDRWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:22:37 -0400
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:37081 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752237AbeGDRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:22:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CD70E837F242;
        Wed,  4 Jul 2018 17:22:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hair87_8ae181ee4db37
X-Filterd-Recvd-Size: 2302
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Jul 2018 17:22:34 +0000 (UTC)
Message-ID: <d9bc90af283e03226bcc632e5c8bdf3b5d654b63.camel@perches.com>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
From:   Joe Perches <joe@perches.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 04 Jul 2018 10:22:32 -0700
In-Reply-To: <20180704070305.GB4352@rapoport-lnx>
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
         <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
         <063c785caa11b8e1c421c656b2a030d45d6eb68f.camel@perches.com>
         <20180704070305.GB4352@rapoport-lnx>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-04 at 10:03 +0300, Mike Rapoport wrote:
> On Tue, Jul 03, 2018 at 01:24:07PM -0700, Joe Perches wrote:
> > On Tue, 2018-07-03 at 12:57 -0700, Andrew Morton wrote:
> > > Did you see all this checkpatch noise?
> > > 
> > > : WARNING: Deprecated vsprintf pointer extension '%pF' - use %pS instead
> > > : #54: FILE: mm/memblock.c:1348:
> > > : +	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pF\n",
> > > : +		     __func__, (u64)size, (u64)align, nid, &min_addr,
> > > : +		     &max_addr, (void *)_RET_IP_);
> > > : ...
> > 
> > %p[Ff] got deprecated by commit 04b8eb7a4ccd9ef9343e2720ccf2a5db8cfe2f67
> > 
> > I think it'd be simplest to just convert
> > all the %pF and %pf uses all at once.
> > 
> > $ git grep --name-only "%p[Ff]" | \
> >   xargs sed -i -e 's/%pF/%pS/' -e 's/%pf/%ps/'
> > 
> > and remove the appropriate Documentation bit.
> > 
> 
> Something like this:

not quite as you either need to run the command
multiple times or use

$ git grep --name-only "%p[Ff]" | \
  xargs sed -i -e 's/%pF/%pS/g' -e 's/%pf/%ps/g'


