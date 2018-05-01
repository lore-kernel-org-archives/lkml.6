Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZoFmFFUn2Afs8bnsRFaYiyBMph1NflRlF4pHJNqFY2alGFRQobzhfcruWLxLsuT6VgETIDa
ARC-Seal: i=1; a=rsa-sha256; t=1525206806; cv=none;
        d=google.com; s=arc-20160816;
        b=WjgdyVB4Cp/Ev4my/8gul8+lsSxZkTb3MuwZzdCsXt0uSvO3yfBmMU1OMFpY9mPh29
         pbq06Eo+kFN7qs3jZIx4+AMtrHanpq731x4rbH+Oz7oJ35mLUU4vGi5CSjoCRqPn3tTu
         L8OhTNNlPZ/Wha7z60NQnRF2dBe31ne/v9yWL4RiZLdgp82/5OZOSd1VrYaFmZWfXS3Q
         EVVvnyWdwuwOOPxNNItxuTBRtb9G4C9IIs6NkyocWOpEBH3QLtMguF1o7CPd5mG/dXtR
         dvIcSwtH3Cq3t3sglrmYlT/geoxHl4+F1QIR9rkg89x3C5MucZBSImtHTJ0rSdONzZqY
         V2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=VqTqtZbfADKH9K09A6Wdke+i+ni1r1usaI79pKXsDvk=;
        b=a/+GU9HF6fdQMHhfI6yMc1AThb35UcYf/DRpOGKPc6uTyDkbPuvWMinsVQtc45qgJS
         WIxTZ2nPCklfb7j6aSvuot1Nws/949ZbQfDWKZMyttfPBEzIm5yLkz+WGIVCOIAu1xSM
         G0iyPgQ71JXN11Q6/JfcRqu9kmSuNpCjBt98eKLxyawIgTNFi2wed0tYjIpxsrK/RHJK
         ydOFUNw5CLBz2CORkJ/hnMI54gZXBZEIhzyZqyWrvuWs02tHxzImgABzBUqtvd7rtfG5
         ysGGNgM05V98g4PkwzDEuKVacZSrJv6qkOgDs7E/hyduh4069AWJ9BLcaeJ1/D8oU+tw
         JbrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Tue, 1 May 2018 22:33:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Message-ID: <20180501203325.GB11618@1wt.eu>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501200019.GA7397@sasha-vm>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599295252862228725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 08:00:21PM +0000, Sasha Levin wrote:
> What's worse is that that commit is tagged for stable, which means
> that (given Greg's schedule) it may find it's way to -stable users
> even before some -next users/bots had a chance to test it out.

But it's a difficult trade-off. I think that -next is mostly used by
developers and that as such the audience remains limited. On the
opposite, -stable is used by many users. So how many days of -next
does it take to get the equivalent coverage of one day of -stable,
I don't know but it's probably a lot. Also server workloads are
almost exclusively on -stable. So a bug affecting only server users
will not benefit from -next exposition.

In the end it's all about responding to users' expectations to see
the bugs fixed. In -stable we regularly see users asking to backport
certain fixes. Sometimes they have to wait one or two extra versions
before they get their fix, and they are really not happy at all. If
the fix is rushed too fast and doesn't work, they won't be happy
either. Making them happy means backporting the right fix the quickest
possible. Too little test can result in a wrong fix, but too much test
results in a slow backport.

Again, I really don't find the -stable situation bad nowadays, quite
the opposite. I often suggest to people who don't follow too closely
to stick to latest LTS minus 1 or 2 releases. This way they don't get
the very latest fixes and have a chance that if something breaks very
badly, it gets fixed quickly. It works pretty well apparently.

I suspect that some of the issues that really need to be improved are
the fixes to recently merged code. That's never easy by definition
because if the code is young, it's not yet very well known even by
its author.

What *could* possibly be done (though I'm not fond of this) would be
to state a rule that past a certain number of stacked fixes for a
recently merged code, an extra review delay will be enforced on the
subsystem or on patches coming from the submitter. But I really doubt
it would significantly improve the situation.

Willy
