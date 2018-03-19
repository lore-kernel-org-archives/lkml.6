Return-Path: <dsterba@suse.cz>
X-Google-Smtp-Source: AG47ELujC/Ybl7s5TmdJKx5hzr1wVXvm8nXuvVhN3/ARrLm5Ggk3KXGZxGRcJuaGgu38fD/SH4mI
ARC-Seal: i=1; a=rsa-sha256; t=1521488088; cv=none;
        d=google.com; s=arc-20160816;
        b=JK39dHsKMEQRbLz4DyctRRVvFqauQ2dN/oz7sJKqXDtnORoyNnelJjEibwgPHpRr2p
         4WFqrd+32fOz+MOb1pkqQ0Io502o1f3bX/6s9dPLrsKim6i+lUUM7DZRF5xdqO2anEiY
         cWmAAgtpXcOCfcY36Udv8QaHSZdp2I10PhKt+q19ko1lPT1MUPczQ//2xNXir89mTBOb
         dXVdmgMkOaPF9Du2ZAEow3lLYbPwoJTq0GeX/iL25WlAQIBvfzCXhUcUiIt3M5V4zFRJ
         ooGy8PrRWLZNsSiMu7HWpp6QYNJFKHE8EVMwHiY4spvcQ6sH81KLOEc9PBumyJEGNErN
         VUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=T2TyVwYlgs9/SHJ/GahqsbKRMHmqCsDwfgM5SxLyVVc=;
        b=bFgHKpXzlSlDK8HfypU1m5YY8XwIDly+6X91sg2xXxtRiqwT6AIuvepzFLIehd0eKn
         /sfoWa24WshOqTpEwFoGDVpJ5zUEiMBrmyIwdlGqs5WqnipwrbXo2tRmWNh1Sgs9bOac
         n4HjRn3M4BDc1IsT4AbJDvGoh7yQkfday8P967hgto8pT//HEXgKKrdMUcIHIBwngkJj
         d/xhdNr4P2qIPK7QEgRDX3ufSSF1eLkrOtlE5pJAdLPDIMxjx1TWAlr7SWwL8kQtHKKJ
         OHYC3uj7FFwyxSX7PrUbrOlgq4Q1yDbMhTW7rE7+eIBjyaZp826k955rF77xi/meEjDa
         FrtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dsterba@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=dsterba@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dsterba@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=dsterba@suse.cz
Date: Mon, 19 Mar 2018 20:32:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anand Jain <anand.jain@oracle.com>, Liu Bo <bo.li.liu@oracle.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.14 024/110] btrfs: use proper endianness accessors for
 super_copy
Message-ID: <20180319193221.GP6955@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
	Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Anand Jain <anand.jain@oracle.com>, Liu Bo <bo.li.liu@oracle.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20180307191039.748351103@linuxfoundation.org>
 <20180307191042.810088712@linuxfoundation.org>
 <1521139304@msgid.manchmal.in-ulm.de>
 <20180316123049.GC25079@kroah.com>
 <1521305582@msgid.manchmal.in-ulm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521305582@msgid.manchmal.in-ulm.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594309090147375870?=
X-GMAIL-MSGID: =?utf-8?q?1595395894260741914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 06:27:15PM +0100, Christoph Biedl wrote:
> Greg Kroah-Hartman wrote...
> 
> > On Thu, Mar 15, 2018 at 07:55:42PM +0100, Christoph Biedl wrote:
> 
> > > > commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.
> 
> > > On big-endian systems, this change intruduces severe corruption,
> > > resulting in complete loss of the data on the used block device.
> 
> > That sucks.  Can you test Linus's tree to verify the problem is there?
> > I'll gladly revert this if Linus's tree also gets the revert, I don't
> > want you to hit this when you upgrade to a newer kernel.
> 
> Confirmed: The problem is, err ... was in Linus' tree as well. The
> rather recent commit 8f5fd927c3a7 reverted the change, after that
> everything is as expected again.

Thanks for checking.

> Looking at the original commit, I don't have a clue why things go wrong
> so horribly

It's a half endianness conversion. The plain in-memory structures are in
LE and has to be accessed via the helpers, super block copy and the
root item.  The commit adds only one half of the conversion, that
naturally does not exhibit on LE, because the macros are no-op.

Originally, the items were stored from the on-disk type to on-disk type,
regardless of the CPU:

  super->chunk_root = root_item->bytenr;

The patch should have added conversion of both values, like

  btrfs_set_super_chunk_root(super, btrfs_root_bytenr(root_item));

and not

  btrfs_set_super_chunk_root(super, root_item->bytenr);

It's not very obvious from the context though, typically there's one
structure that needs the accessors and is set from a value that's in CPU
byteorder. I think that the exception to this pattern confused all
involved developers.

The root_item members are annotated as __le64 that should be caught by
sparse/smatch checker in the buggy case, but we don't run the checkers
every the time.

> - otherwise don't be afraid of my data. I took this as a
> chance to verify my data recovery procedure, with success.

Should that not be the case, the damaged items in superblock can be
byteswapped back. That's 6 x u64 at most, I have a tool for that now.

Thanks again for the report and sorry for the trouble.
