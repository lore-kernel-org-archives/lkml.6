Return-Path: <david@fromorbit.com>
X-Google-Smtp-Source: AIpwx4/+KnOJg6EyDQJurRtiXSb3kXGNEoWpDpxVptm76WBgfRXWIpaGzfCQeFkq1iix60vKp+1w
ARC-Seal: i=1; a=rsa-sha256; t=1522533769; cv=none;
        d=google.com; s=arc-20160816;
        b=J6SGEHsJFrhqsTps8qgKUbW2q8SuOapUI+a3BEn5ut/fehAqFJMjlZm5kxA63occ4c
         8Vh4W2q2Hj6wpjh5w9RgaqlCzqdVoMXLH/vfiTu2josHsG0pwGdqUWOazPpL65bQEalQ
         bDTPF21B9RbDrnSrDy9JSVBHX6bc1aPQiKjhtprrq9DoB6+7SZrNb1ulgjR24PUVm+M9
         7eeLq223bTCOqlXxDejTfyJasybQBKrMZuVLUz/G1sC/s0+1up6itFNTOnKi08dZvmBq
         xdnVbDdLvJLN90MzDCw1bsg0Xs6UGWMMaWMyLrbZoB5E5a94A3FgYc1AB9dLUUxLwnND
         Xwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=c0aHYuNJSwS/Z0Ua6moBuEWrZjTd4NSXWizlqWo+gts=;
        b=a5a+SQ8yrLi9Hh8cxDTbDplBHkDp7OBFKC9KCCPvWybj0sqA1xfqRGAkLNSlunMoP3
         in6Hep1offda7pNfN2Nc0EQnwVr9HUDW9GTfk1X03rVq97VwnncgtLBvjM6EhASj5aR2
         x/SAtxgd+WdY0yYey4lPJKmUbLkaAnaxOLh+EEdOma9P885/8s1MXlwtuXyNus6L9sOC
         iYMlSing3CxfYqYcKbvEqsgBbgW4pFBX5aVvva4GMCBJ0eud7H/nePYuvfhWo0zxfIIK
         4HduKqPe+r/3BGvPGrJS74P8pn6vGYDDf9zVrTMy0TEC79VACf5r0PTF7tI97GMuisYI
         Fjgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 150.101.137.129 is neither permitted nor denied by best guess record for domain of david@fromorbit.com) smtp.mailfrom=david@fromorbit.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 150.101.137.129 is neither permitted nor denied by best guess record for domain of david@fromorbit.com) smtp.mailfrom=david@fromorbit.com
Date: Sun, 1 Apr 2018 08:02:45 +1000
From: Dave Chinner <david@fromorbit.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Sasha Levin <levinsasha928@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
	Michal Hocko <mhocko@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180331220245.GG1150@dastard>
References: <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180328033228.GA18129@dastard>
 <20180328193004.GB7561@sasha-vm>
 <20180328230535.GE18129@dastard>
 <20180330024704.GE7561@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330024704.GE7561@sasha-vm>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596492369973762565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 02:47:05AM +0000, Sasha Levin wrote:
> On Thu, Mar 29, 2018 at 10:05:35AM +1100, Dave Chinner wrote:
> >On Wed, Mar 28, 2018 at 07:30:06PM +0000, Sasha Levin wrote:
> > This commit has been processed by the -stable helper bot and determined
> > to be a high probability candidate for -stable trees. (score: 6.4845)
> >
> > The bot has tested the following trees: v4.15.12, v4.14.29, v4.9.89, v4.4.123, v4.1.50, v3.18.101.
> >
> > v4.15.12: Build OK!
> > v4.14.29: Build OK!
> > v4.9.89: Build OK!
> > v4.4.123: Build OK!
> > v4.1.50: Build OK!
> > v3.18.101: Build OK!
> >
> > XFS Specific tests:
> >
> > v4.15.12 (http://stable-bot.westus2.cloudapp.azure.com/test/v4.15.12/tests/):
> >     No tests completed!

Can you capture the actual check command output into it's own file?
That tells us at a glance which tests succeed or failed.

So I'm looking at the v5.log file:

....
echo 'export MKFS_OPTIONS='\''-m crc=0,reflink=0,rmapbt=0, -i sparse=0,'\'''
....


FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 autosel 4.15.12+
MKFS_OPTIONS  -- -f -m crc=0,reflink=0,rmapbt=0, -i sparse=0,
/dev/vdb
MOUNT_OPTIONS -- /dev/vdb /mnt2

That's not testing v5 filesystems. That's turned off crcs, and
so is testing a v4 filesystem. You'll see this on filesysetms that
don't support reflink:

 [not run] Reflink not supported by test filesystem type: xfs

Also, you need to make the test filesystem to match the options
the test run is configured with (i.e. v4, v5, reflink, etc)
otherwise half the tests don't exercise the expected config.

[not run] src/dbtest not built

 [not run] chacl command not found

 [not run] xfs_io set_encpolicy support is missing

You need to update your userspace.

And the test run has not completed. It's run to:

generic/430	[11172.480621] run fstests generic/430 at 2018-03-30 00:20:12
+ scp -i /home/sasha/ssh/id_rsa -P 10022 -r root@10.3.38.7:/root/xfstests-dev/results /home/sasha/data/results/test/v4.15.12/tests//v5/
+ az vm delete -y --resource-group sasha-auto-stable --name sasha-worker-629016242-vm

generic/430 and then stopped. There's still another ~50 tests in the
generic group to run, and then there's the shared and XFS subdirs to
run, too. So there's still something wrong in the way you are
setting up/installing fstests here....

> > v4.14.29 (http://stable-bot.westus2.cloudapp.azure.com/test/v4.14.29/tests/):
> >     No tests completed!
> > v4.9.89 (http://stable-bot.westus2.cloudapp.azure.com/test/v4.9.89/tests/):
> >     No tests completed!
> > v4.4.123 (http://stable-bot.westus2.cloudapp.azure.com/test/v4.4.123/tests/):
> >     v4:
> >         Thu Mar 29 21:23:57 UTC 2018
> >         Interrupted!
> >         Passed all 0 tests
> >     v4_reflink:

There's no such configuration as "v4 reflink". reflink is only
available on v5 (crc enabled) filesystems on kernels >=4.10 (IIRC).
Perhaps you've mislabelled them?

> Let me know if this would be good enough for now, and if there's
> anything else to add that'll be useful.
> 
> This brings me to the sad part of this mail: not a single stable kernel
> survived a run. Most are paniced, some are hanging, and some were killed
> because of KASan.
> 
> All have hit various warnings in fs/iomap.c,

Normal - the dmesg filter in the test harness catches those and
ignores them if they are known/expected to occur.

> and kernels accross several
> versions hit the BUG at fs/xfs/xfs_message.c:113 (+-1 line)

That's an ASSERT() failure, indicating a fatal error. e.g:

Stuff like this (from
http://stable-bot.westus2.cloudapp.azure.com/test/v4.9.89/tests/v4_reflink.log)

.....
generic/083	[ 4443.536212] run fstests generic/083 at 2018-03-29 22:32:17
[ 4444.557989] XFS (vdb): Unmounting Filesystem
[ 4445.498461] XFS (vdb): EXPERIMENTAL reverse mapping btree feature enabled. Use at your own risk!
[ 4445.505860] XFS (vdb): EXPERIMENTAL reflink feature enabled. Use at your own risk!
[ 4445.513090] XFS (vdb): Mounting V5 Filesystem
[ 4445.531284] XFS (vdb): Ending clean mount
[ 4458.087406] XFS: Assertion failed: xfs_is_reflink_inode(ip), file: fs/xfs/xfs_reflink.c, line: 509

[snip stack trace]

Indicate a problem that should not be occurring. It's debug an
triage time - there's some problem that needs backports to fix. I
doubt anyone in XFS land has time to do this on top of everything
else we alreayd have to do...

> 4.15.12 is hitting a use-after-free in xfs_efi_release().

Debug and triage time.

> 4.14.29 and 4.9.89 seems to end up with corrupted memory (KASAN
> warnings) at or before generic/027.

More debug and triage time.

> And finally, 3.18.101 is pretty unhappy with sleeping functions called
> from atomic context.

Needle in a haystack :/

So this is just basic XFS validation, and it's throwing problems up
all over the place. Now do you see why we've been saying maintaining
stable backports for XFS is pretty much a full time job for someone?

And keep in mind this is just one filesystem. You're going to end up
with the same issues on ext4 and btrfs - the regression tests are
going to show up all sorts of problems that have been fixed in the
upstream kernels but never backported....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
