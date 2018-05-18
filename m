Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeERRiA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:38:00 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41511 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeERRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:37:58 -0400
X-Google-Smtp-Source: AB8JxZo3X/c17pWVmz5EKSCsogvZHR6rzej0go1piCRFK/1U5+LX4IRKfTHffANtmIiOv9snHf2W5Q==
Date: Fri, 18 May 2018 13:37:54 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: Re: [PATCH 10/10] Dynamic fault injection
Message-ID: <20180518173754.GB31737@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-21-kent.overstreet@gmail.com>
 <20180518160245.GE22791@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518160245.GE22791@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 09:02:45AM -0700, Christoph Hellwig wrote:
> On Fri, May 18, 2018 at 03:49:18AM -0400, Kent Overstreet wrote:
> > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> 
> Completely lacks any explanation or argument why it would be useful.

It's in the cover letter...


 * Dynamic fault injection

 I've actually had this code sitting in my tree since forever... I know we have
 an existing fault injection framework, but I think this one is quite a bit
 nicer
 to actually use.

 It works very much like the dynamic debug infrastructure - for those who aren't
 familiar, dynamic debug makes it so you can list and individually
 enable/disable
 every pr_debug() callsite in debugfs.

 So to add a fault injection site with this, you just stick a call to
 dynamic_fault("foobar") somewhere in your code - dynamic_fault() returns true
 if
 you should fail whatever it is you're testing. And then it'll show up in
 debugfs, where you can enable/disable faults by file/linenumber, module, name,
 etc.

 The patch then also adds macros that wrap all the various memory allocation
 functions and fail if dynamic_fault("memory") returns true - which means you
 can
 see in debugfs every place you're allocating memory and fail all of them or
 just
 individually (I have tests that iterate over all the faults and flip them on
 one
 by one). I also use it in bcachefs to add fault injection points for uncommon
 error paths in the filesystem startup/recovery path, and for various hard to
 test slowpaths that only happen if we race in weird ways (race_fault()).
