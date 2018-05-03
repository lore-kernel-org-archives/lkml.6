Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZqTUoR5jow7kOFC3RRF6lMnL8LeApSODKmlIftjedCyQtdVVB4GeCO3kLEQ3M8Ysln/CSsI
ARC-Seal: i=1; a=rsa-sha256; t=1525363024; cv=none;
        d=google.com; s=arc-20160816;
        b=hX0FV7NsQfootXv4Yb9uBv+BOXjv4OcMvH/P7xTbD9Auim4/Qf6aDNqG61EnDZ9K17
         dR2o/cLyZXnyOuXGXyThzrdaf2KQo/dyQQttvyqrjS6+g8shVO9enuFumRoFyGqTllQj
         vvoxesaRbh8MPXpInFAlybOxwlsJJrpUwkODC9Wv4Cs2fCgpvWbRYtZ5tU13HhjWzrE9
         w2FyBuxnPGaxE29GAjUtgtebLiHxQfcj6ukSiLKHMJ+I4+xhtDOz0E+LaJUYs1hRhvlD
         wuNbFAQ59Mdph+mryAx7aoqFqMlg4FWgavTXAcGK6Zh6t4iKmjscikJ6qI7W2QCN9dl2
         DPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=h1YFRIvcbYvNCWSqSmpOCI6Qb4d9L4nqPVWcXymkcP0=;
        b=XjHC5Tx+1Ql0JDx3Y5Zl10TmZLtABeNzyskhu6zhVvDrNHZSfxguXfzNMV2/gDC7Hx
         zvVuuNGzS3eTvs7JUyn6QMtmFH0Vm2mUMtrN264sWnxzZu76b9PQyVF15xZ5nqOng/dB
         saAjcCckZ7pCzgC2Ai6NxpLhP5HPSxI0XEIpJWS/zAfhcC1CZ2DnFQIEfkD6b9W2mVMS
         RWT7U+ReWmkhQWajjYff9Bo6Se4BTZSZymMtP8dp/M9Fyup1NO2P2yBjL0YeKZ8a4VSj
         s4iQQH3KRfpGCL/d/WK04QEj7T3q9nhyWtvSZceYAp7w1kcCu2zG3P2j97wgWEYkz5bw
         qCog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 3 May 2018 17:56:58 +0200
From: Willy Tarreau <w@1wt.eu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503155658.GG23311@1wt.eu>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
 <877eol808s.fsf@intel.com>
 <1525357984.3225.12.camel@HansenPartnership.com>
 <20180503144850.GC23311@1wt.eu>
 <20180503150608.GM18390@sasha-vm>
 <1525361268.3225.17.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525361268.3225.17.camel@HansenPartnership.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599459058641996420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 08:27:48AM -0700, James Bottomley wrote:
> It's also a sad fact that a lot of things which look like obvious fixes
> actually turn out not to be so with later testing.  This is why the
> user visibility test is paramount.  If a bug fix has no real user
> visible effects, it's often better to defer it no matter how obvious it
> looks, which is why the static code checkers often get short shrift
> before a merge window.
> 
> A script measuring user visibility would be nice, but looks a bit
> complex ...

I totally agree with this and it matches my experience in haproxy. We
have had series of fixes that broke something else in very subtle ways
that made us want to improve non-reg, but many of the times we noted
that reg testing would hardly spot them given that the failures require
so many conditions to happen only once every million that it's hopeless.
It's just that some users are (un)lucky enough to meet all the conditions
at once very often and to be very sensitive to one error per million.

User exposure is needed. Having multiple stable release ensures everyone
gets their expected level of trust. Those on -rc want to see bugs before
they hit their users. Regressions are bad and require self-moderation and
self-estimation of the amount of trust in one's code, but they're better
in -rc than in -stable. I do happen to write some fixes I'm not totally
sure about and prefer not to backport them immediately. Users value
transparency because that helps them take safe decisions. If I say "this
is my fix, but I'd love more testing as I'm not yet sold on it", I'll get
some testers, but not the ones complaining that I broke their setup. Only
later it makes sense to progressively backport.

I have broken stable releases many times with failed backports. Almost
every time it was my fault due to incomplete testing. I could argue that
once you've built one hundred times in a week-end you're probably a bit
more lenient about next builds, or whatever. But in the end I was the
one breaking a working version. Seeing my branches picked up by Guenter
was a huge relief and it started to spot many build issues that I could
not figure myself. It doesn't make remaining bugs less important but at
least they are easier to swallow, to spot and to address.

What's not acceptable is rushed fixes that have obvious side effects that
could have been caught by closer analysis or better testing. It always
happens but it must not happen too often for the same person/subsystem.
This I think is where the line must be drawn. When Linus shouts once in
a while, it's a reminder for all others. Tune the potentiometer of his
detection threshold a bit lower and we'll get less regressions because
it's never pleasant to be called stupid in public like he does.

Willy
