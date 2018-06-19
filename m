Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CEBC5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE8320850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE8320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937251AbeFSDNB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:13:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:39968 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755376AbeFSDM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:12:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 20:12:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,241,1526367600"; 
   d="scan'208";a="48113641"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2018 20:12:58 -0700
Date:   Mon, 18 Jun 2018 21:12:57 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v14 00/74] Convert page cache to XArray
Message-ID: <20180619031257.GA12527@linux.intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 06:59:38PM -0700, Matthew Wilcox wrote:
> The XArray is a replacement for the radix tree.  For the moment it uses
> the same data structures, enabling a gradual replacement.  This patch
> set implements the XArray and converts the page cache to use it.
> 
> A version of these patches has been running under xfstests for over
> 48 hours, so I have some confidence in them.  The DAX changes have now
> also had a reasonable test outing.  This is based on next-20180615 and
> is available as a git tree at
> git://git.infradead.org/users/willy/linux-dax.git xarray-20180615
> 
> I shall create a git branch from -rc1 and ask for that to be included in
> -next.  I'm a little concerned I still have no reviews on some of the
> later patches.
> 
> Changes since v13:
>  - Actually fixed bug in workingset conversion that led to exceptional
>    entries not being deleted from the XArray.  Not sure how I dropped
>    that patch for v13.  Thanks to David Sterba for noticing.
>  - Fixed bug in DAX writeback conversion that failed to wake up waiters.
>    Thanks to Ross for testing, and to Dan & Jeff for helping me get a
>    setup working to reproduce the problem.
>  - Converted the new dax_lock_page / dax_unlock_page functions.
>  - Moved XArray test suite entirely into the test_xarray kernel module
>    to match other test suites.  It can still be built in userspace as
>    part of the radix tree test suite.
>  - Changed email address.
>  - Moved a few functions into different patches to make the test-suite
>    additions more logical.
>  - Fixed a bug in XA_BUG_ON (oh the irony) where it evaluated the
>    condition twice.
>  - Constified xa_head() / xa_parent() / xa_entry() and their _locked
>    variants.
>  - Moved xa_parent() to xarray.h so it can be used from the workingset code.
>  - Call the xarray testsuite from the radix tree test suite to ensure
>    that I remember to run both test suites ;-)
>  - Added some more tests to the test suite.

Hit another deadlock.  This one reproduces 100% of the time in my setup with
XFS + DAX + generic/340.  It doesn't reproduce for me at all with
next-20180615.  Here's the output from "echo w > /proc/sysrq-trigger":

[   92.849119] sysrq: SysRq : Show Blocked State
[   92.850506]   task                        PC stack   pid father
[   92.852299] holetest        D    0  1651   1466 0x00000000
[   92.853912] Call Trace:
[   92.854610]  __schedule+0x2c5/0xad0
[   92.855612]  schedule+0x36/0x90
[   92.856602]  get_unlocked_entry+0xce/0x120
[   92.857756]  ? dax_insert_entry+0x2b0/0x2b0
[   92.858931]  grab_mapping_entry+0x19e/0x250
[   92.860119]  dax_iomap_pte_fault+0x115/0x1140
[   92.860836]  dax_iomap_fault+0x37/0x40
[   92.861235]  __xfs_filemap_fault+0x2de/0x310
[   92.861681]  xfs_filemap_fault+0x2c/0x30
[   92.862113]  __do_fault+0x26/0x160
[   92.862531]  __handle_mm_fault+0xc96/0x1320
[   92.863059]  handle_mm_fault+0x1ba/0x3c0
[   92.863534]  __do_page_fault+0x2b4/0x590
[   92.864029]  do_page_fault+0x38/0x2c0
[   92.864472]  do_async_page_fault+0x2c/0xb0
[   92.864985]  ? async_page_fault+0x8/0x30
[   92.865459]  async_page_fault+0x1e/0x30
[   92.865941] RIP: 0033:0x401442
[   92.866322] Code: Bad RIP value.
[   92.866739] RSP: 002b:00007fa29c9feec0 EFLAGS: 00010212
[   92.867366] RAX: 00007fa29ca00400 RBX: 0000000000001000 RCX: 0000000000008000
[   92.868219] RDX: 0000000000000009 RSI: 0000000000000000 RDI: 0000000000000000
[   92.869082] RBP: 00007fa29c9ff700 R08: 00007fa29c9ff700 R09: 00007fa29c9ff700
[   92.869939] R10: 0000000000000070 R11: 00007fa29e571ba0 R12: 00007fa29ca00000
[   92.870804] R13: 00007fffd5f24160 R14: 0000000000000400 R15: 00007fffd5f240b0

This looks very similar to the one I reported last week with generic/269.

- Ross
