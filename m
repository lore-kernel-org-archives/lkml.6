Return-Path: <josef@toxicpanda.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522347435; cv=none;
        d=google.com; s=arc-20160816;
        b=UPk9LTBKd4B3ItwVKu5jc6FeeV7a1E9oyFu0BOW/Py/9Fsb3jkJTuVrLB5H8mrrXzN
         YXAxGfziFyb60swtu6blrjx6unslghK4tbGO+3iUS+Pa2BiGb1qBMwECCf3P9mG2TO6l
         sV1FG7ZF9V5+Hkbx6T3rxNurJLCPF4h9poyHckIZwDODwhcZxE0J0f7cuwYe8Vt+8cdu
         703QIa/ejheqD3WDaaKG2kX/wFbdmX5F5UjUC978QWdsc1ooS/2EosqkAxm3c19BKZdp
         OTvRwegvY2G0BxXqDiVVcVAj3hStCgw2Nx/+7u04D5r8GSHTk13R3mTmMRxy3nYJ2Tp+
         j+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=SEomopbO/BjtLWjrWgD8SbRa6jI+6Y/t1mWATo9EXDQ=;
        b=G3R5PrUK5T1z9UCSr5kSIR1oKO+TvUnDFNQTGs7nuniy6KbEab2Bu4ByAhRdxgWO0p
         Bjtn+DeXz9tM7GFNha849SVf5EolMWHKVhxOGJXQ0XlF2RP59dHpCQ/724gTfLJMW5xM
         9jHKlXDlwNanCARPIvgDUfDRxLFkG0fNJAomE8gGSi+7OkxYPZp3EgUgSrgt43lst3T+
         FL7AbsgTP433yU0Gl88ohCRWg5wgQJNp/+q5XwntUzq+2rHctT66oLbGHUnpt6nF3FzA
         1Y8KMKDv5KBHaRVc/ZAyVo3dM14Tegf9DQjRScUA7vNXfY/Z3YZSgggQQSDegTewQgN7
         M9Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@toxicpanda-com.20150623.gappssmtp.com header.s=20150623 header.b=XL9REcoj;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of josef@toxicpanda.com) smtp.mailfrom=josef@toxicpanda.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@toxicpanda-com.20150623.gappssmtp.com header.s=20150623 header.b=XL9REcoj;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of josef@toxicpanda.com) smtp.mailfrom=josef@toxicpanda.com
X-Google-Smtp-Source: AIpwx4/vhpZ2Uyjth+K5bjKga4nvR1eIpZvIzqOwNDIKoUoEAXDBVnBoicPtYlgzj7YAWnbKYolMHA==
Date: Thu, 29 Mar 2018 14:17:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Sasha Levin <levinsasha928@gmail.com>,
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
Message-ID: <20180329181712.ijbruc7rl2i3nh35@destiny>
References: <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180328033228.GA18129@dastard>
 <20180328193004.GB7561@sasha-vm>
 <20180328230535.GE18129@dastard>
 <20180329181223.GK30543@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329181223.GK30543@wotan.suse.de>
User-Agent: NeoMutt/20170714 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596296984479994500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 06:12:23PM +0000, Luis R. Rodriguez wrote:
> On Thu, Mar 29, 2018 at 10:05:35AM +1100, Dave Chinner wrote:
> > On Wed, Mar 28, 2018 at 07:30:06PM +0000, Sasha Levin wrote:
> > > 
> > > This is actually something I want maintainers to dictate. What sort of
> > > testing would make the XFS folks happy here? Right now I'm doing
> > > "./check 'xfs/*'" with xfstests. Is it sufficient? Anything else you'd like to see?
> > 
> > ... and you're doing it wrong. This is precisely why being able
> > to discover /exactly/ what you are testing and being able to browse
> > the test results so we can find out if tests passed when a user
> > reports a bug on a stable kernel.
> > 
> > The way you are running fstests skips more than half the test suite
> > It also runs tests that are considered dangerous because they are
> > likely to cause the test run to fail in some way (i.e. trigger an
> > oops, hang the machine, leave a filesystem in an unmountable state,
> > etc) and hence not complete a full pass.
> > 
> > "./check -g auto" runs the full "expected to pass" regression test
> > suite for all configured test configurations. (i.e. all config
> > sections listed in the configs/<host>.config file)
> 
> ie, it would be safer to expect that an algorithmic auto-selection process for
> fixes for stable kernels should have direct input and involvement from
> subsystems for run-time testing and simply guessing or assuming won't suffice.
> 
> The days of just compile testing should be way over by now, and we should
> expect no less for stable kernels, *specially* if we start involving
> automation.
> 
> Would a way to *start* to address this long term for XFS or other filesystems
> for auto-selection long-term be a topic worth covering / addressing at LSF/MM?
> 

It would be cool to tie tests to commit numbers for things where we're making
sure a oops/hang doesn't happen again, but honestly I'm not sure it's worth the
effort.  Maybe this is my upstream bias showing, but I only ever run xfstests
against something relatively close to linus, so I'm not super worried about
./check -g auto eating my box.  I expect that if I run auto that everything
minus the few flakey tests are going to pass.

Also TIL about configs/<host>.config, that's pretty fucking cool.  Thanks,

Josef
