Return-Path: <david@fromorbit.com>
X-Google-Smtp-Source: AIpwx48/Jv/GRMkUxEq7x/rVEPMjaxwKcu/Y+a60Gd2Kn8WFqajpBXfS45qfj2zXbeZnuiFo/Qyc
ARC-Seal: i=1; a=rsa-sha256; t=1522278431; cv=none;
        d=google.com; s=arc-20160816;
        b=MYWnaMs5Hw7avo1IX+tM5vuWqyE8REuwnjqOONAQefjR3BZeHBkv9GVnfwyJthXWQT
         GCU02h/C/OMNopMerCHpeZ0jtUhwsLFZyozs98vzpzv0DQ+x5D8B8TrgIowio8rNhUCX
         tCp3BH77k9NEyTq1ZW5O/YZsR+QZQaKCQzPH2GywEhukoGjM4m29qF1UPbVBP45kb4xb
         xaXmPiMwU7phfO3ZMzFiIOhk9Bfphr2y3lHp1u+rdMD7pBqAvfWwAdDBu3imrB3ZQ2FC
         b3gJwTRGzF73nQHFtXHIkKe9ZD4D8xvQ7gBc8N8Xl880s4Tkw/3KpOD4ZSJ0nhU6tjlR
         qQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=bGYssTgs1XnMcYzpTo8Je6IaJqaMPcjXJma2XCRLk/Q=;
        b=Crhmi8cr7TrDIm+aN4ZUxqO2S3FzjbaCDrPbj1MrMQwW/dBDp/2q2RohedGVAW270w
         D02TZWK0TwDPJOQ/qykAaYSOOq4KaSCBmllMtmvVl7DL5162yZ+BzFaoxYzOjR5kOZnd
         H9ETRVUb0LmxFZmvGZYeu5htxJJpziFKqPYdUDewui28we4RU6PgmcSqpnCsEcJsFV8L
         +ukVGszptDMwM2P0hu1zmXPXF7rMoJ0eBtPvYe8Kr6qvzil90ir3PuQIBqtN307/xclT
         exNd60ou4gO4k8TSsUuJ+2TEOtkKbsy1/jErHaKoTpL4pw0OnRRQHXJJ2N/Hw/eAEmLX
         ksFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 150.101.137.129 is neither permitted nor denied by best guess record for domain of david@fromorbit.com) smtp.mailfrom=david@fromorbit.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 150.101.137.129 is neither permitted nor denied by best guess record for domain of david@fromorbit.com) smtp.mailfrom=david@fromorbit.com
Date: Thu, 29 Mar 2018 10:05:35 +1100
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
Message-ID: <20180328230535.GE18129@dastard>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180328033228.GA18129@dastard>
 <20180328193004.GB7561@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328193004.GB7561@sasha-vm>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596224629303044691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 07:30:06PM +0000, Sasha Levin wrote:
> On Wed, Mar 28, 2018 at 02:32:28PM +1100, Dave Chinner wrote:
> >How much time are your test rigs going to be able to spend running
> >xfstests? A single pass on a single filesysetm config on spinning
> >disks will take 3-4 hours of run time. And we have at least 4 common
> >configs that need validation (v4, v4 w/ 512b block size, v5
> >(defaults), and v5 w/ reflink+rmap) and so you're looking at a
> >minimum 12-24 hours of machine test time per kernel you'd need to
> >test.
> 
> No reason they can't run in parallel, right?

Sure they can, if you've got the infrastructure to do it. e.g. putting
concurrent test runs on the same spinning disk doesn't speed up the
overall test run time by very much - they slow each other down as
they contend for IO from the same spindle...

I have 5-6 configs on each of my test VMs that I use for validation.
They all have the default config, all have a reflink enabledi
config, and then have varing numbers of other unique configs
according to how fast they run. i.e. it's tailored to "overnight"
testing, so 12-16 hours of test run time.

With them all running in parallel, it takes about 16 hours to cover
all the different configs. I could create more test VMs and run one
config per VM, but that's slower than (due to resource contention)
than running mutliple configs sequentially with limited
concurrency. What is most efficient for your available resources
will be different, so don't assume what works for me will work for
you....

> >> > From: Sasha Levin <alexander.levin@microsoft.com>
> >> > To: Sasha Levin <alexander.levin@microsoft.com>
> >> > To: linux-xfs@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>
> >> > Cc: Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
> >> > Subject: Re: [PATCH] xfs: Correctly invert xfs_buftarg LRU isolation logic
> >> > In-Reply-To: <20180306102638.25322-1-vbendel@redhat.com>
> >> > References: <20180306102638.25322-1-vbendel@redhat.com>
> >> >
> >> > Hi Vratislav Bendel,
> >> >
> >> > [This is an automated email]
> >> >
> >> > This commit has been processed by the -stable helper bot and determined
> >> > to be a high probability candidate for -stable trees. (score: 6.4845)
> >> >
> >> > The bot has tested the following trees: v4.15.12, v4.14.29, v4.9.89, v4.4.123, v4.1.50, v3.18.101.
> >> >
> >> > v4.15.12: OK!
> >> > v4.14.29: OK!
> >> > v4.9.89: OK!
> >> > v4.4.123: OK!
> >> > v4.1.50: OK!
> >> > v3.18.101: OK!
> >> >
> >> > Please reply with "ack" to have this patch included in the appropriate stable trees.
> >
> >That might help, but the testing and validation is completely
> >opaque. If I wanted to know what that "OK!" actually meant, where
> >do I go to find that out?
> 
> This is actually something I want maintainers to dictate. What sort of
> testing would make the XFS folks happy here? Right now I'm doing
> "./check 'xfs/*'" with xfstests. Is it sufficient? Anything else you'd like to see?

... and you're doing it wrong. This is precisely why being able
to discover /exactly/ what you are testing and being able to browse
the test results so we can find out if tests passed when a user
reports a bug on a stable kernel.

The way you are running fstests skips more than half the test suite
It also runs tests that are considered dangerous because they are
likely to cause the test run to fail in some way (i.e. trigger an
oops, hang the machine, leave a filesystem in an unmountable state,
etc) and hence not complete a full pass.

"./check -g auto" runs the full "expected to pass" regression test
suite for all configured test configurations. (i.e. all config
sections listed in the configs/<host>.config file)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
