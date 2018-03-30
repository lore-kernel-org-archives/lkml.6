Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx48G76J2Can8FJO90xEx5W63cWGvRDtMTxX1o6NfqS5q/k9vAKboteaI/NR6Ch+YTHHt4f2c
ARC-Seal: i=1; a=rsa-sha256; t=1522439387; cv=none;
        d=google.com; s=arc-20160816;
        b=uHvksFxDBM25sK1nME1cBOaeZVgPwT33YYztxaE79AmFKGwy++S8qAlpP+xXJV1tHp
         kJplQw6aJPfNjBbDXtrlfpIty+2uzygzcxovB52UuONDH/YdL8bRqixSjScUiCp65jNp
         Sv8yBe0xnTBIVcTtfW4QbUixVcUu3nJoIG6JuLl6LvuDw1Vo99sE6RNC2KkBfrMU6PLv
         HyfsXEAZLt35f5YFrKbOg95roiDhwyt8LELwcDbcGAj8wph6JByMo9vBtx+BsgW4bNH0
         4yklbh0xW1PATaRoj0QYkFt+J7hp5AThtbZHhuEc5hhWQ9GZePhAM6m9i6+9I8UQbMPn
         EYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/YK14MbqP4ZwIPgNyDZzfhZLT5O3PIZXRDeB7XX/rCw=;
        b=EbvqCLMugM6m5UzLXs098ND8Kyjh4le0EN3YdRw6S6/PsFU1zob7nbqs79pW/Wn/IQ
         gaJXfsKKYKN80XUgDpVpJDvLg6bSy34gIuhDyMzrJB3XDf5kygylS7UUpO7C+NvYMjAs
         mFBsSvuaqTJVpmj3VnZMUoiBL9N+czfPfHE/8CrYOWg9s3plVyzRCXYsjpb8nc3puVSH
         dVgpfCqph5jAe2ZrAZxWDN5dNecJ7RnnIF0scoV94AjYmMLzStxxjuo3vJaEbSDAuJrA
         IvsYyG9if7UPnZVTesJxuPllLgFt92WU11DBVWysgnsWlR1aff95uf4VmwBvqSLMMcti
         5SMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Fri, 30 Mar 2018 19:49:46 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Sasha Levin <levinsasha928@gmail.com>,
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
Message-ID: <20180330194946.GF9190@wotan.suse.de>
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
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596393403789955585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 02:47:05AM +0000, Sasha Levin wrote:
> On Thu, Mar 29, 2018 at 10:05:35AM +1100, Dave Chinner wrote:
> >On Wed, Mar 28, 2018 at 07:30:06PM +0000, Sasha Levin wrote:
> >"./check -g auto" runs the full "expected to pass" regression test
> >suite for all configured test configurations. (i.e. all config
> >sections listed in the configs/<host>.config file)
> 
> Great! With information from Darrick and yourself I've modified tests to
> be more relevant. Right now I run 4 configs for each stable kernel, but
> can add more or remove any - depends on what helps people analyse the
> results.
>
> This brings me to the sad part of this mail: not a single stable kernel
> survived a run. Most are paniced, some are hanging, 

I expected this. The semantics over -g auto yielding "expected to pass"
are relative. Perhaps its better described as "should pass"?

> and some were killed
> because of KASan.
> 
> All have hit various warnings in fs/iomap.c, and kernels accross several
> versions hit the BUG at fs/xfs/xfs_message.c:113 (+-1 line)
> 
> 4.15.12 is hitting a use-after-free in xfs_efi_release().
> 4.14.29 and 4.9.89 seems to end up with corrupted memory (KASAN
> warnings) at or before generic/027.
> And finally, 3.18.101 is pretty unhappy with sleeping functions called
> from atomic context.

>From my limited experience you have no option but to create an expunge list for
each failure for now, and then pass the expunge lists -- that in essence would
define the stable baseline and you should expect this to be different per
kernel release. If you upgrade tooling, it can also change the results, and
likewise if you upgrade fstests.

If you define an expunge list you can then pass the list with the -E parameter,
you can for instance categorize then failures by type and use a file for each
type of failure, whether that's a triage list or a type of common failure.
Format can be:

test # comments are ignored

Since you may want to database this somehow, perhaps a format that lists
some tracking for it or other heuristics:

generic/388 # bug#12345 - 1/300 run fails

I'd recommend to just add all failures to one large expunge list for now,
and later you can split / sort them them as needed.

The idea later is that any failure later would be a regression. What would
be good is to test a stable kernel prior to the auto-selection and use that
as baseline, then bump the kernel and ensure no regressions were created.

A dicey corner issue is that of tests which are supposed to "pass" but yet
can fail every blue moon. For instance I've been running into one-off failures
with generic/388 -- but only if I run it over 300 times.

As such the baseline IMHO should also track these as just failures, however it
will be often picked up as a regression first. The only way to rule this out
is to loop test the same test prior to a kernel update and ensure it wasn't
a regression -- ie, that it *was* still failing before.

This is why all this work is rather full time'ish. There is no way around it,
it will take time to establish a baseline from fstests for a filesystem. There
will also be a lot of odd ins and outs of each filesystem.

  Luis
