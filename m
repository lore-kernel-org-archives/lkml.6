Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EBAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48CB2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48CB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966935AbeFSQkl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:40:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:52996 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966368AbeFSQki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:40:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 09:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="65467580"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2018 09:40:37 -0700
Date:   Tue, 19 Jun 2018 10:40:37 -0600
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
Message-ID: <20180619164037.GA6679@linux.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619092230.GA1438@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:22:30AM -0700, Matthew Wilcox wrote:
> On Mon, Jun 18, 2018 at 09:12:57PM -0600, Ross Zwisler wrote:
> > Hit another deadlock.  This one reproduces 100% of the time in my setup with
> > XFS + DAX + generic/340.  It doesn't reproduce for me at all with
> > next-20180615.  Here's the output from "echo w > /proc/sysrq-trigger":
> 
> *sigh*.  I wonder what the differences are between our setups ...
> 
> > [   92.849119] sysrq: SysRq : Show Blocked State
> > [   92.850506]   task                        PC stack   pid father
> > [   92.852299] holetest        D    0  1651   1466 0x00000000
> > [   92.853912] Call Trace:
> > [   92.854610]  __schedule+0x2c5/0xad0
> > [   92.855612]  schedule+0x36/0x90
> > [   92.856602]  get_unlocked_entry+0xce/0x120
> > [   92.857756]  ? dax_insert_entry+0x2b0/0x2b0
> > [   92.858931]  grab_mapping_entry+0x19e/0x250
> > [   92.860119]  dax_iomap_pte_fault+0x115/0x1140
> > [   92.860836]  dax_iomap_fault+0x37/0x40
> ...
> > This looks very similar to the one I reported last week with generic/269.
> 
> Yeah, another missing wakeup, no doubt.  Can you bisect this?  That was
> how I found the last one; bisected it to a single patch and stared very
> hard at the patch until I saw it.  I'm not going to be in a position to
> tinker with my DAX setup until the first week of July.

It bisected to this commit:

b4b4daa7e8fb0ad0fee35d3e28d00e97c849a6cb is the first bad commit
commit b4b4daa7e8fb0ad0fee35d3e28d00e97c849a6cb
Author: Matthew Wilcox <willy@infradead.org>
Date:   Thu Mar 29 22:58:27 2018 -0400

    dax: Convert page fault handlers to XArray

    This is the last part of DAX to be converted to the XArray so
    remove all the old helper functions.

    Signed-off-by: Matthew Wilcox <willy@infradead.org>

