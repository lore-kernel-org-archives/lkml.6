Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZp9rpmAdInmKWUdB6Qg25cvXZI6ARAK0xCDSf7BbYZzPTrqznVMspfBUA+tdP1QpVsWICwh
ARC-Seal: i=1; a=rsa-sha256; t=1525115360; cv=none;
        d=google.com; s=arc-20160816;
        b=EbPUGbrvD9NA9QUju/PmhRmmnoI2F2DJbxSbseHH3M0vDZK7MkWE6Kl4f2Ph8Aeshd
         Y2YqQv/QSb1A5rqYNfwVzwaSTO3yCzJ8+gWCKzy8FYzUoIkDMagZ3T/8/OO+R/vhuaYq
         WMp7V1L5DZ5hYeX/kZ/RMMjQyd6sDYRjr8+NmKgBCwscDdtSFWCXK4K92v7CysdWPnDg
         yHzUADoEClobZ/WLMXibbIOQRi+tlme2Bm47GpIRfB99DTrwsLV6txwJmVbr0TKF6Eeb
         JXVEAy7obaDi/OTifO1V1vzs71/eDwI4MvpQfXShdFVdkDYmcOjvTThnN5lVWa/cDNTf
         vMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Oza184VGashl5Tj5x7YRmCgtm5k7gdZVbtHrtmh/5kc=;
        b=QUQeq75RFrJOHm9r5/iAwddYLrQJ8O/ORvoly4WoLGuL9JBglvxYIQ+gZWpIvYkIhE
         3hMMZajuDxohQjMEEzLJQMiktH8tbtHwYCZg/louSn6q90obz6AdXFX1ShtP1+P+hRvI
         j/KJdZw7kd1UW5apLo7e7WAsScuy8VYpxPx/TUFRWwaBQyUacVxVnp7Bb6qq0UhkC7Xe
         gg24YxmmkOtfrYIjavPH+3egpY6o25ySf7A4Sn6/q2O3AjATW0p7y9niceQPMwHMDdl4
         BD/H1hbIaxhRCVxvXdwmny+cPDqx0B9r5k4bbiFRvNfL0DIHwzSod95QrGjjr69F1vKf
         gp6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Mon, 30 Apr 2018 21:09:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches (or: -rc cycles suck)
Message-ID: <20180430190918.GA8718@1wt.eu>
References: <20180430175829.GB1544@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430175829.GB1544@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599194910340136485?=
X-GMAIL-MSGID: =?utf-8?q?1599199363952194676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sasha,

On Mon, Apr 30, 2018 at 05:58:30PM +0000, Sasha Levin wrote:
>  - For some reason, the odds of a -rc commit to be targetted for -stable is
>  over 20%, while for merge window commits it's about 3%. I can't quite
>  explain why that happens, but this would suggest that -rc commits end up
>  hurting -stable pretty badly.

Often, merge window collects work that has been done during the previous
cycle and which is prepared to target this merge window. Fixes that happen
during this period very likely tend to either be remerged with the patches
before they are submitted if they concern the code to be submitted, or are
delayed to after the work gets merged. As a result few of the pre-rc1 patches
get backported while the next ones mostly contain fixes. By the way, you
probably also noticed it when backporting patches to your stable releases,
the mainline commit almost never comes from a merge window.

> 2. Maintainers need to stop writing patches, commiting them, and pushing them
> in without reviews. In -rc cycles there is quite a large number of commits
> that were either written by maintainers, commited, and merged upstream the
> same day. These patches are very likely to introduce a new bug.

Developers are humans before anything else. We probably all address most
bug reports the same way : "ah, of course, stupid me, now that's fixed".
Keep in mind that for the developer, the pressure has lowered now that
the code got merged, and that mentally the fix is "on top" of the initial
work and no more part of it. It often means a narrower mental image of
how the fix fits in the whole code.

I think that you'll also notice that fixes that address bugs introduced
during the merge window of the same version will more often introduce
bugs than the ones which address 6-months old bugs which require some
deeper thinking. In short it indicates that we tend to believe we are
better than we really are, especially very late at night.

> I don't really have a proposal beyond "tighten up -rc cycles", but I think
> it's a discussion worth having. We have enough data to show what parts of
> kernel development work, and what parts are just hurting us.

I'm inclined to believe that making individuals aware of their own
mistakes can help. I personally like to try to understand how I managed
to introduce a bug, it's always useful. Very often it's around "I was
pretty sure it didn't require testing, the change was so obvious". We
all know this feeling when you write 100 lines in a new file, you
compile, and it builds without any warning and apparently works, and
suddenly you think "uh oh, what did I do wrong?" and you have no idea
where to start to look for possible mistakes.

Probably that some statistics on mistake classifications and maybe some
affected subsystems (if that doesn't blame anyone) could be useful.

Just my two cents,
Willy
