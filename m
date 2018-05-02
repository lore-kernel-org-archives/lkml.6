Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZrl+PHQIWtvFtczaZU70/0seYfcYLD/H7nNw36BuiNtnseZaxbVPxF+xKvwIJhEXiuMW8/F
ARC-Seal: i=1; a=rsa-sha256; t=1525235419; cv=none;
        d=google.com; s=arc-20160816;
        b=x5xLAX8ZEt8QdW8S0K4lSd+ogkDXTwERTcW1hQEZ/fHi7cGnuLz74FC7rEobltLUZ0
         jn5Fw4N0KTHPnZdXJkeLRrAaODLA6dcDIJMHpB3CFKC/2efcKqhA+6AHMSImxXaJGt46
         y9PwkdbCHWlUJT2ijV4juuxKtYm4t1T1DBAx/1vMjiwPj7JBXs5ec8xNCAlMtQUl8KYP
         x+wXWrin32MaBIiA3mEbQSoo+RIaN8lfaTGPPJNlkEGEFGLv3Gel+Y6Jcm92NsLicMm2
         Dcxijh9Dm5eIVQyqlYGc5rQIZyo3JYD9WzeC1XYufgQD6BmKtgfvjLxbLb8PX/9ziyLS
         lYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=xSmEs6xmgP8FK4FiX/PPSsbr8BEY2IbXlDzQiqApra0=;
        b=nm0Rw+tmaVHOHEDfe1wqUnynUxYRwR2P7fsEDkvIPdZGR0/gykhH4u9BZYHeXOqHs6
         /TlHmPCzrTcViaMGGYqFaLf4JfjgsHQ+VtYQf5HMDfZhtIOwf3LzKG8155vLskPiFxgT
         NQRcaYF8rUBIvycGdaMPCPz2ni/dzn3HwxX38bs/XSch8q0P2Pf9ELxsZaYssX8EIi3Z
         B3uw//SK/W3TjS4l1C9BD6EeDsVuQPo/6ytSWvk+qVuR2w6od2VxJ/4sUbJ+oz6y+emX
         6+Sd8sK/ARkyZ3wH2lPXER4CMY7NeRnwILeYntGRje3gg8Dq6nkUboUJXIO09uS4a0aC
         c/sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Wed, 2 May 2018 06:30:17 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Message-ID: <20180502043017.GA11938@1wt.eu>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
 <20180501220228.GD7397@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501220228.GD7397@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599325254977147702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 10:02:30PM +0000, Sasha Levin wrote:
> On Tue, May 01, 2018 at 04:54:48PM -0400, Theodore Y. Ts'o wrote:
> >Post -rc3 or -rc4, in my opinion bug fixes should wait until the next
> >merge window before they get merged at all.  (And certainly features
> >bugs should be Right Out.)  And sure, bug fixes should certainly get
> >more testing.  So I guess my main objection is your making a blanket
> >statement about all fixes, instead of breaking out regression fixes
> >versus bug fixes.  Since in my opinion they are very different animals...
> 
> I understant your point, you want to make fixes available to testers as
> soon as possible. This might make sense, as you've mentioned, in < -rc3.
> 
> So yes, maybe the solution isn't to force -next, but rather add more
> "quiet time" at the end of the cycle? Make special rules for -rc7/8? Or
> even add a "test"/"beta" release at the end of the cycle?

I disagree with the proposals above, and for multiple reasons :
  - leaving a known bug on purpose automatically degrades the quality of
    each release. Given that less than 100% of the fixes introduce
    regressions, by not merging any of these fixes, we'll end up with
    more bugs. That's a very bad idea.

  - this will give a worse image of dot-0 releases, and users will be
    even less interested in testing them, prefering to wait for the
    first stable version. In this case what's the point of dot-0 if it
    is known broken and nobody uses it ?

  - letting fixes rot longer on the developer side will send a very bad
    signal to developers : "we don't care about your bugs". Companies
    relying on contractors will have a harder time including fixes in
    the contract, as it will only cover what's needed to get the feature
    merged. Again this will put the focus on extremely fast and dirty
    development, given that fixes will not be considered during the same
    window.

I'd rather do the exact opposite except for those who introduce too many
regressions : set up a delay penalty to developers who create too many
regressions and make this penalty easy to check. I think it will generally
not affect subsystem maintainers, unless they pull and push lots of crap
without checking, of course. But it could prove very useful for those
developing under contract, because companies employing them will want to
ensure that their work will not be delayed due to a penalty. Thus is will
be important for these developers to be more careful.

After all, the person proposing a fix always knows better than anyone
else if this fix was done seriously or not. Developers who do lots of
testing before sending should not be penalized, and should get their
fix merged immediately. Those who just send untested patches should be
trusted much less.

> From what I see, the same number of bugs-per-line-of-code applies for
> commits accross all -rc releases, so while it makes sense to get a fix
> in quickly at -rc1 to allow testing to continue, the same must not
> happen during -rc8, but unfourtenately it does now.

That's where I strongly disagree, since it would mean releasing with even
more bugs than today.

Willy
