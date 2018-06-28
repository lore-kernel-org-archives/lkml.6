Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA9EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A52250D1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A52250D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935334AbeF1Qa3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:30:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:22480 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933822AbeF1QaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:30:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 09:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="62287164"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2018 09:30:20 -0700
Date:   Thu, 28 Jun 2018 10:30:20 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v14 00/74] Convert page cache to XArray
Message-ID: <20180628163020.GA18192@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180617020052.4759-1-willy@infradead.org>
 <20180619031257.GA12527@linux.intel.com>
 <20180619092230.GA1438@bombadil.infradead.org>
 <20180619164037.GA6679@linux.intel.com>
 <20180619171638.GE1438@bombadil.infradead.org>
 <20180627110529.GA19606@bombadil.infradead.org>
 <20180627194438.GA20774@linux.intel.com>
 <20180628083909.GA7646@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628083909.GA7646@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:39:09AM -0700, Matthew Wilcox wrote:
> On Wed, Jun 27, 2018 at 01:44:38PM -0600, Ross Zwisler wrote:
> > On Wed, Jun 27, 2018 at 04:05:29AM -0700, Matthew Wilcox wrote:
> > > On Tue, Jun 19, 2018 at 10:16:38AM -0700, Matthew Wilcox wrote:
> > > > I think I see a bug.  No idea if it's the one you're hitting ;-)
> > > > 
> > > > I had been intending to not use the 'entry' to decide whether we were
> > > > waiting on a 2MB or 4kB page, but rather the xas.  I shelved that idea,
> > > > but not before dropping the DAX_PMD flag being passed from the PMD
> > > > pagefault caller.  So if I put that back ...
> > > 
> > > Did you get a chance to test this?
> > 
> > With this patch it doesn't deadlock, but the test dies with a SIGBUS and we
> > hit a WARN_ON in the DAX code:
> > 
> > WARNING: CPU: 5 PID: 1678 at fs/dax.c:226 get_unlocked_entry+0xf7/0x120
> > 
> > I don't have a lot of time this week to debug further.  The quickest path to
> > victory is probably for you to get this reproducing in your test setup.  Does
> > XFS + DAX + generic/340 pass for you?
> 
> I won't be back in front of my test box until Tuesday, but that test
> does work for me because I couldn't get your instructions to give me a
> 2MB aligned DAX setup.  I had to settle for 4k, so none of the 2MB stuff
> has been tested properly.

Ah.  I've documented both my qemu setup and my filesystem setup here:

https://nvdimm.wiki.kernel.org/pmem_in_qemu
https://nvdimm.wiki.kernel.org/2mib_fs_dax

This should be enough to get you up and running in QEMU and able to reliably
get filesystem DAX PMD faults.
