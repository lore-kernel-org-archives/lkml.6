Return-Path: <benh@kernel.crashing.org>
X-Google-Smtp-Source: AIpwx4+2YcVwFiQY16F+eY16LuCfQo9U8fvcbQcRriHPqBEROeGBGbFGQNt5faI0IiNmWuS0DMWy
ARC-Seal: i=1; a=rsa-sha256; t=1523372008; cv=none;
        d=google.com; s=arc-20160816;
        b=dzQuEZG2J2heL3FiXCkG9vidOTSigm8xT+Q/DxwmEkUGrsMACYMldBXdcsp5XypLs0
         zdoZ9DBmH0a6tkKMz9J9T5qsKRj9Lk0+qX/yDHKo6BdAEyKMnL1uU1R4aAl0eFpR4Qpm
         ZI+erayiGY8odq/MQHDIyLSXu7nRM9Hx0ESGyOC3z47GEHVtohsSeLuElVzpPs8CVqjJ
         6ypUrGIYqt9s5G8tBCtBQ3WOKWKyByOvHu0cMLn4JGu7y9ldtjeh7kV76mCmylQnXAKG
         7g7EvwEpNoBOb68SyeeiEtA6MbwtExC4kCuKDCctDRgMbdz7PNS5tgwv456nntFCF9EL
         yoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=pL2v50+4a6Q73T6XjffPLR7W6nYtud+cbVUOooozNrE=;
        b=hMwetNrjXSZ3pJWXywKpg8yp8JJDy9m1gwgTawssdxswezz8vWxx2OKRfS0q2ElMkh
         JqGdzFzKRZLc4qXsGQVdLHUxyAvOPO16pdyIbHu4JBuxlC3aA1JhBcltTWyK63CLHVkM
         5gnKpxuZVnNAtE/DqeSPBiL9jG2JzY8yyqDpg9ZTay9SZGgxMgnZCXOPnU2W39z1OIYR
         waDKInxJ7uzhKRvCdfEh/RkPnNTDG7buT/C2nnAgBDgeA/1VKxYZuuVD7kUfbMGG84Sw
         1ZsgOk6Sq/Sg92kFVZ7PJxUPqyM5WJ7CoFXPqoILOFk4ZT+8JxIIBuEKBrMC1MzhJUVZ
         1YUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of benh@kernel.crashing.org designates 63.228.1.57 as permitted sender) smtp.mailfrom=benh@kernel.crashing.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of benh@kernel.crashing.org designates 63.228.1.57 as permitted sender) smtp.mailfrom=benh@kernel.crashing.org
Message-ID: <1523371986.11062.101.camel@kernel.crashing.org>
Subject: Re: How to expose various BMC chip controls ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew
 Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel.stanley@au1.ibm.com>,
        Jeremy
 Kerr <jeremy.kerr@au1.ibm.com>
Date: Wed, 11 Apr 2018 00:53:06 +1000
In-Reply-To: <CAK8P3a1vEKOvX-p=QLX_BPCXGJrN-5SQgkA1GYggSukG7SosUQ@mail.gmail.com>
References: <1523351850.11062.80.camel@kernel.crashing.org>
	 <CAK8P3a2rC3jymPDJbpxsYZRYMAcSJy6zXjYrxKPHrGxj63vBtg@mail.gmail.com>
	 <1523365055.11062.95.camel@kernel.crashing.org>
	 <CAK8P3a1vEKOvX-p=QLX_BPCXGJrN-5SQgkA1GYggSukG7SosUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597350209516531918?=
X-GMAIL-MSGID: =?utf-8?q?1597371326790387769?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-10 at 15:06 +0200, Arnd Bergmann wrote:
> On Tue, Apr 10, 2018 at 2:57 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2018-04-10 at 13:29 +0200, Arnd Bergmann wrote:
> > > In the cases where an ad-hoc interface is needed, I can see
> > > two options: we can stick something in drivers/soc that exposes
> > > it in the least ugly way, completely specific to that particular
> > > SoC, or we can create a new subsystem from "random BMC
> > > slave-side interfaces" and have it maintained by you all (leave
> > > me out of the picture, except if you are looking for ideas).
> > 
> > I don't think there enough commonality in these things to create a "BMC
> > slave interface" class that is anything other than a bunch of sysfs
> > files.
> > 
> > That's why I ended up with my personal conclusion/preference of just
> > having the syscon "driver" for the SoC just expose a table of a dozen
> > or so such knobs, and use the DT to describe them to abstract a bit the
> > difference between SoC models/revisions and how they are wired up in a
> > given platform.
> 
> The idea with having a subsystem for it would be to group stuff together
> in one directory and have that owned by people that care about it,
> even if there is little commonality between the things it's used for.

Ok, so we could use a subsystem as a grouping method in sysfs, that
does make some amount of sense ;-)

That said, fundamentally, it is going to be exposed by whatever creates
the syscon for the SoC, so yes, a "SoC" driver is probably the right
thing to instanciate that thing, as those knobs are very much SoC
specific. Though I do want to keep the actual definition DT based at
least for Aspeed.

As for finding the commonalities, the connundrum here is that we juts
don't have enough experience of platforms with different kinds of BMCs
to do that (provided there's anything to find).

So we can wait a few years until we do and keep out-of-tree crap
drivers, or just solve the immediate problem in a semi-reasonable way,
and maybe make things evolve as we get more SoC's into the picture.

My issue right now is that we need products out of the door (and not
just we IBM, but everybody using OpenBMC) and we are just carrying
various horrid out of tree hacks to do so, and that needs urgent
fixing.

The main worry I have with my own idea here is that it's too easily
abused for things that shouldn't get in there. But I can't find a way
around that, we'll just have to be vigilant I suppose...

Cheers,
Ben.
