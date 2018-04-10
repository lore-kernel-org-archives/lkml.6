Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523365612; cv=none;
        d=google.com; s=arc-20160816;
        b=fAmct19nEw78v4Gr8Z0UcsShCW7fnaF7/177fIZGWtXG8TNve4FAZGgLok2sbHCrxn
         E9fL+4HN/hZnSLc9V3y3JjL03wxBZ1knAOsgIW7tA6xzNbvgaM0WsUpe4dobI9JbMqCl
         YDLXkep9JbicIcsdtsRSbHLg0EhoSt5mVeFpnDOhGnLdepC8/hlOoLHEO4XdyPcgYsmn
         cVLYCH9KXlkQ+0t24UtxbdvrdxFuwHFQ438ybo77UvBLfZJ/s7IjbqV5pAcSqikUNvaD
         vvIPvVpmcs/KIQMEx1K2Rb7S7w404nmvBuANk9ocKXcpZeOv1CGaL7xB96VOMejhHtRZ
         r0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/mlksFav6VBpsFexkypMJ/8uXJTQSa1cj+Xa6XEmZbU=;
        b=dajgc+HM2O3M8f6UvKUbBbnzqx4Yf6kDl/CiZFbus3MayoXkAy460CiiM0G0ZBRwke
         yyHVQB9lDXw7zNXNj6SijCqQIciuT7n3KaNNSfTynyU3dJCSgPg/DiD1CdVL34pLiKQO
         nLdYLFDVSHNzlrWF/W446QcqryKAmGBya9talFnSOInW9yDgFyCdR4jgSdoJDL0VwJuJ
         XUZpZ/ze/tVDz0rsMmSk687LBdT24iTYc+Dja7BVvq9fGKA4vT48PjZWW+19sp3nZNg+
         ArVGPbjBMhX2lAut76NDBatMvactlPqtkEzAxhwO0IJwhEX71bWTSgA/PjDVEWOPGyks
         rKQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rrEWVvFG;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rrEWVvFG;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx4+Xq6YToM65GsL9DWXCDZ5JYlGtzDl+1yiaIs41nGq6vmmjScAiuA3cIJFjupNGrtTe3xv/PE2mb/S9+f8GHY4=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1523365055.11062.95.camel@kernel.crashing.org>
References: <1523351850.11062.80.camel@kernel.crashing.org>
 <CAK8P3a2rC3jymPDJbpxsYZRYMAcSJy6zXjYrxKPHrGxj63vBtg@mail.gmail.com> <1523365055.11062.95.camel@kernel.crashing.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 10 Apr 2018 15:06:51 +0200
X-Google-Sender-Auth: YFmBgM2rZvZbWs0p2xpwbvANP60
Message-ID: <CAK8P3a1vEKOvX-p=QLX_BPCXGJrN-5SQgkA1GYggSukG7SosUQ@mail.gmail.com>
Subject: Re: How to expose various BMC chip controls ?
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
	Joel Stanley <joel.stanley@au1.ibm.com>, Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597350209516531918?=
X-GMAIL-MSGID: =?utf-8?q?1597364620698933222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 2:57 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2018-04-10 at 13:29 +0200, Arnd Bergmann wrote:

>> In the cases where an ad-hoc interface is needed, I can see
>> two options: we can stick something in drivers/soc that exposes
>> it in the least ugly way, completely specific to that particular
>> SoC, or we can create a new subsystem from "random BMC
>> slave-side interfaces" and have it maintained by you all (leave
>> me out of the picture, except if you are looking for ideas).
>
> I don't think there enough commonality in these things to create a "BMC
> slave interface" class that is anything other than a bunch of sysfs
> files.
>
> That's why I ended up with my personal conclusion/preference of just
> having the syscon "driver" for the SoC just expose a table of a dozen
> or so such knobs, and use the DT to describe them to abstract a bit the
> difference between SoC models/revisions and how they are wired up in a
> given platform.

The idea with having a subsystem for it would be to group stuff together
in one directory and have that owned by people that care about it,
even if there is little commonality between the things it's used for.

That might be more useful than having it in drivers/misc/ or
drivers/soc/, especially when it comes to recognizing things that
are common between different BMC hardware implementations
or (host) firmware stacks that were initially thought to be more
specific.

>> In any case, I think it makes most sense to discuss new interfaces
>> between the people working on the competing BMC implementations,
>> mainly to see if some functionality can be abstracted in a common
>> way or not.
>
> So we have some ideas of what competing BMC *chip* vendors do since
> OpenBMC people communicates with other vendors.
>
> We know a lot less about BMC SW stacks, but those are a rat nest of
> closed source & GPL stuff that doesn't get upstream (or even released
> sometimes ... ahem ...). Having had access to some vendor code in the
> past, I can tell you that you really don't want to look at what's going
> on in there ;-)

Sure, I really only meant the hardware capabilities here.

      Arnd
