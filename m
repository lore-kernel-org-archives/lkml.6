Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx49JemKNgUC5zE2SOqpXjNZI+kvhwlAcyartRzAt1pOYvV5gaVkSplUSrWKITVUm5RA3lDuD
ARC-Seal: i=1; a=rsa-sha256; t=1522347147; cv=none;
        d=google.com; s=arc-20160816;
        b=Z/wotm7KwtKcP0PUNl/1Hi7TFbfD8wTV8D37VuWBBFoimR5jnVxX6NsBcezBKfKOku
         FbEsA9410M1sXaYeT2yc/YqfPpw4831yade6KfVkoxi7AcrkiISpM0HnD2CswbXhteSt
         PyMWvOplGJ+s6T5Chgv1/qgegB0GxjRKugbNbL9WqsMXi6IjRvwkZF+B3wdQmWWZ7KLB
         jblv1Frv/xTpNDO79zQb1zgoguNIT/+/YyrDIFXoxmYN4+9H7OsW8gu5tuDBL9l6VYpD
         pevO97DprIiXMWwUiKShYAUqXQaFr09yRXeS7RFHPrq0IfvJf3RlvzUp6KCDJxTTFTUe
         fLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=zppSShg/WWQ/m1YIILlwVMRWlc2AiHfQyrJM7U8bQ5k=;
        b=TGBozxAPEWDQJlluTtL0N7a1GaF2pz4H5WbDIJNAoWfI+RpEBM+d/0jL2kfeY/boS7
         FqwXDU1saXwpmfOeem6yLfY3Sn/CEyDbyKtj0zEUJfypJxByrsKwuptJ3hMfeYowwbmv
         o1XNdvHkaCkc6iwb2Ut6ZVmfsfuZEVCafRAapyav0AWN/L2so9RvbW/qyPgAreyZnZte
         L0q13tgArSBBS1COZ/5eHqtqnya1kawiePJ2w8NyTkezjCaOz9qg/H9TL3G2NtWkxuzu
         DPqrV+JbADHaBm1pYNxeJhscHiHUCBWPD64FFILsWhPK/M52+JUn9OY9FJfx/rufMu7R
         wReQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Thu, 29 Mar 2018 18:12:23 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
	Sasha Levin <levinsasha928@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
	Michal Hocko <mhocko@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Josef Bacik <josef@toxicpanda.com>, Tso Ted <tytso@mit.edu>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180329181223.GK30543@wotan.suse.de>
References: <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180328033228.GA18129@dastard>
 <20180328193004.GB7561@sasha-vm>
 <20180328230535.GE18129@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328230535.GE18129@dastard>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596296681914294707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 10:05:35AM +1100, Dave Chinner wrote:
> On Wed, Mar 28, 2018 at 07:30:06PM +0000, Sasha Levin wrote:
> > 
> > This is actually something I want maintainers to dictate. What sort of
> > testing would make the XFS folks happy here? Right now I'm doing
> > "./check 'xfs/*'" with xfstests. Is it sufficient? Anything else you'd like to see?
> 
> ... and you're doing it wrong. This is precisely why being able
> to discover /exactly/ what you are testing and being able to browse
> the test results so we can find out if tests passed when a user
> reports a bug on a stable kernel.
> 
> The way you are running fstests skips more than half the test suite
> It also runs tests that are considered dangerous because they are
> likely to cause the test run to fail in some way (i.e. trigger an
> oops, hang the machine, leave a filesystem in an unmountable state,
> etc) and hence not complete a full pass.
> 
> "./check -g auto" runs the full "expected to pass" regression test
> suite for all configured test configurations. (i.e. all config
> sections listed in the configs/<host>.config file)

ie, it would be safer to expect that an algorithmic auto-selection process for
fixes for stable kernels should have direct input and involvement from
subsystems for run-time testing and simply guessing or assuming won't suffice.

The days of just compile testing should be way over by now, and we should
expect no less for stable kernels, *specially* if we start involving
automation.

Would a way to *start* to address this long term for XFS or other filesystems
for auto-selection long-term be a topic worth covering / addressing at LSF/MM?

  Luis
