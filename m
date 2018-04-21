Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx48D8Zrou/YU98+B2doR7snN7d8zd1+FcjwyJ5pMeG6ExHDM7KpNeTq9dmqnFGu6viK06Q0E
ARC-Seal: i=1; a=rsa-sha256; t=1524332215; cv=none;
        d=google.com; s=arc-20160816;
        b=mxOZujFwiTsdvMA2EOc8QSDLj4IenlxOqBhlXvbPWMVb/Tz6wmPJpWJwS3tmb9Bp3t
         Hpf1jxwPvMZBDk8s0uuulgbSo+yrS1tgnzKd3MWSwL0ET73CgmZyTWa0yU1KY09OsbVk
         mz3x8+SDQvwmgZ7mYpmVGdKEwk/L2Kx3zsvDx/ICPxHtMAzRBFy+BAR3tGw4R0V8IQeS
         iMEe/VIxst+3axLjEzrbZ6q/7FLAWlNN25PgpbFXrH4DGa0NmkKEEH7HEY2p2H/imfHo
         rJKw1xoquK4acKo8UQAimz7KZTdClVn0PdLv1g/m5+FtWvMSK8izKZgiVrD90B1cT16E
         h+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=jo8AprrE0cq3dOQcK08EwvpIs9dtbvF1+FrJtyUtHSE=;
        b=Rfu8daYMVziSvGrjVzu5VjVs/FAfFs5/GdMoHgEddr8DeyqAyY7ov2gfUJ1WygeGwd
         kHpPOex+urZmGwkQ2dEDMh9ruQG81SGZBJD6PxyCXg2M2M4v24tglhqN06zmvyg3aHRk
         3QB49x7sO/mSZRph5rESubrzAt3EOViDxfYdH3jq37JNsBdjTppZY4iWtzjepxBK32Wb
         0Rgscu5WI05zhzXrQS3RIQ8F0gIJDAoIDS4KfNwe9HMM0F8fALNxNZUhGDY92EfY+Tps
         grHV2uhcZG+QVHcLimxuF32Dsjv0t53L/St2Naz5Ad42qLHEoKqFY24nkzqH4mLBZmV0
         w3VA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sat, 21 Apr 2018 19:36:50 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Andres Rodriguez <andresx7@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	ckoenig.leichtzumerken@gmail.com, Kalle Valo <kvalo@codeaurora.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 5/9] firmware: add functions to load firmware without
 warnings v4
Message-ID: <20180421173650.GW14440@wotan.suse.de>
References: <20180417153307.3693-1-andresx7@gmail.com>
 <20180417153307.3693-6-andresx7@gmail.com>
 <20180421143206.GQ14440@wotan.suse.de>
 <20180421144911.GV14440@wotan.suse.de>
 <CAGXu5jKVv8R1yVcuCCPJb1YD9u8tiZyj86wdz043PKxKPZj4Lg@mail.gmail.com>
 <CA+55aFw4WxBDD3YA9Ksj=mxcYmAg7+bnjfuDVtBnzn+0w6mtbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw4WxBDD3YA9Ksj=mxcYmAg7+bnjfuDVtBnzn+0w6mtbw@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008015463324966?=
X-GMAIL-MSGID: =?utf-8?q?1598378177104400582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 08:32:00AM -0700, Linus Torvalds wrote:
> On Sat, Apr 21, 2018 at 8:11 AM, Kees Cook <keescook@chromium.org> wrote:
> >
> > What was the objection to using parameters for this? i.e. something
> > like the gfp flags, but have a behavior flag FW_RQ_NOWAIT,
> > FW_RQ_NOWARN, etc?
> 
> The objection was that the patches that I think Luis refers to

There were different topics of discussion, people can conflate the topics
discussed easily as all these topics were discussed around the same time so
best to recap and split them up:

  a) bikeshedding on the name: I suggested long ago we've already passed usage
     of the fw API to things which are *not firmware*, so suggested we use a new
     naming scheme, the last one I recommended was a driver_data_*() prefix.
     Greg last suggested a firmware_*() prefix -- and to rename *all* existing 
     callers with this new prefix as well long term... I am done with bikeshedding
     and frankly don't care anymore. Whatever you folks decide, I just want to
     move on with life, so I am moving along with the firmware_*() prefix.

  b) evolving the API: data driven Vs functional -- where to draw the fine line
       -- this is the topic we are discussing now again --

  c) firmware signing: we've decided against it for now and folks who need it
     can open code it, mainly due to most hw supporting FW signing already

>  (a) passed in a union of random arguments

It split the API into two main routine calls, a sync and an async call,
and also accepted a *structure of parameters* which describe the request
requirements [0].

It turned out this approach was *too data driven*, and Greg advised against
it, asking for a new call *per new functionality*, as is typically done...

[0] https://lkml.kernel.org/r/20170605213937.26215-2-mcgrof@kernel.org

>  (b) changed all the users, even the ones that didn't want to be changed.

That *never happened* actually. The SmPL grammar I provided long ago was for
those who *did* want to change the new API if they had a new *feature* they
wanted to take advantage of. The patches you may have seen were *examples* of
*two drivers* which were converted over just an example with the grammar.

On the last iteration of my series I skipped adding the SmPL helpers, and
only converted *one* driver for *new functionality*.

In the last driver data patch series I only converted iwlwifi as I was changing
it to use the new functionality to replace its own internal recursion set of
calls with an internal deterministic solution which lets drivers call for a
range of API files and lets it use the first one in a range it finds [1],
with this diff stat:

 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 91 ++++++++++------------------
 1 file changed, 31 insertions(+), 60 deletions(-)

[1] https://lkml.kernel.org/r/20170605213937.26215-6-mcgrof@kernel.org

> they were nasty and illegible and pointless.

Clearly request_firmware_nowait2() is *not* much better... right? So it illustrates
the problem I was hinting which we'd eventually cross...

> Using some single flag field for an extended function, and leaving the
> existing functions alone so that you don't have to convert existing
> users - that would have been fine. That's not what was tried and
> rejected.

Actually it was tried, however the divide was perhaps *too broad* and split
all possible *new* functionality into two calls, a sync and a async call.

A flag based mechanism *is* reasonable to me given I have been an advocate
of such type of mechanism for a long while. It however is against what
Greg requested -- to have a new call *per functionality*.

So feel free to advise... I really just want us to move on.

  Luis
