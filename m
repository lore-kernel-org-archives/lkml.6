Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELt003ysp30ZGu+cKSgn/SBGAVePmVsi/ah20Beew8J5bFz3jIp5OXnP64Jq3Z7SZu7yDgNf
ARC-Seal: i=1; a=rsa-sha256; t=1520480682; cv=none;
        d=google.com; s=arc-20160816;
        b=GVqPLyLMa0e+mUtddGkCn+dZw0eACzEMlASZ2ie1x+fWVAmn90f1wtXNbuEYgBSf6c
         0klKaOxhmA30rjtRSU7v00biZGhiHAr+XBLsRMU8GmnMPVLnlxJhZ/YD/xw5PHIKytnv
         KTSgyUB2JaN4H4YoelQOa9AGaEQdwRNbl4n3RZ6BccpSdzcExbaxMd/bxX4pkQu3aPET
         76WxXyCWkrWi9SiO5o1VE3ZNdNevotmtpm6urq1RwRolV3Tuxjc7e7iY3VG0HZmIgHA4
         /UbwqvqZOw6bgwGXpA3LbAVMqlyehKPGR/Aknr/0N0QRjiNf4iJOTHLkUeZwUAxlIvdx
         EgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=6xV4sBZs0so/XSVS1bYcZi2JfiZ53czjF4UPc6igX/c=;
        b=LdGIjB6wPaN9wod7HKOFyxyplkfecDdNG2O1/UrMCZamQy/NGyh+ETGB297hJo0v+i
         Dl7bzV0V6VPe9jeOjpVjOyKtXBr7ct3mMw4o4NDKTCA8WiEXN5ObVzyOpm6sXkJnZCTu
         G+cGZE+WMSSvQixjYfALXTeIk5i9oUYzgjPkmj6OBE3bsKjjfO1uPh6LvaOrDIIKUkpY
         NXu8n7+HknFm9NVAobChqw3H6a95juKcz7baPd3tjF+JmIZ1gS9Ge+NmpdMMnA9q8XyW
         PCAuxu4HdVGRoCVMl03Ui8q5li/fZCKWXInkT12DZvsnpSuIA6ldaMvo/Nd0bqObSrTt
         zheg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Thu, 8 Mar 2018 03:44:38 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	nbroeking@me.com, Vikram Mulukutla <markivx@codeaurora.org>,
	stephen.boyd@linaro.org, Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com, LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] firmware: split firmware fallback functionality
 into its own file
Message-ID: <20180308034438.GP14069@wotan.suse.de>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-8-mcgrof@kernel.org>
 <CAGXu5jKoRsXm00=dQePgrjF+EauphKnPQXVgL=rv_d579eNE7g@mail.gmail.com>
 <20180228012802.GG14069@wotan.suse.de>
 <CAGXu5j+tFg+rGn5baCFRF5ARwExuD45oRE=dmzB8T84XDL=f-w@mail.gmail.com>
 <20180228071131.GA17185@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228071131.GA17185@kroah.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248720090748696?=
X-GMAIL-MSGID: =?utf-8?q?1594339552245765634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 08:11:31AM +0100, Greg KH wrote:
> On Tue, Feb 27, 2018 at 09:33:28PM -0800, Kees Cook wrote:
> > On Tue, Feb 27, 2018 at 5:28 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > > On Tue, Feb 27, 2018 at 03:14:53PM -0800, Kees Cook wrote:
> > >> On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > >> > The firmware fallback code is optional. Split that code out to help
> > >> > distinguish the fallback functionlity from othere core firmware loader
> > >> > features. This should make it easier to maintain and review code
> > >> > changes.
> > >> >
> > >> > The reason for keeping the configuration onto a table which is built-in
> > >> > if you enable firmware loading is so that we can later enable the kernel
> > >> > after subsequent patches to tweak this configuration, even if the
> > >> > firmware loader is modular.
> > >> >
> > >> > This introduces no functional changes.
> > >> >
> > >> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > >> > ---
> > >> >  drivers/base/Makefile                  |   4 +-
> > >> >  drivers/base/firmware_fallback.c       | 661 +++++++++++++++++++++++++++
> > >> >  drivers/base/firmware_fallback.h       |  61 +++
> > >> >  drivers/base/firmware_fallback_table.c |  29 ++
> > >> >  drivers/base/firmware_loader.c         | 803 +--------------------------------
> > >> >  drivers/base/firmware_loader.h         | 115 +++++
> > >> >  6 files changed, 874 insertions(+), 799 deletions(-)
> > >> >  create mode 100644 drivers/base/firmware_fallback.c
> > >> >  create mode 100644 drivers/base/firmware_fallback.h
> > >> >  create mode 100644 drivers/base/firmware_fallback_table.c
> > >> >  create mode 100644 drivers/base/firmware_loader.h
> > >>
> > >> Does it make sense to have a separate subdirectory for firmware
> > >> instead? I did this _ stuff with lkdtm and have regretted it. (I'm
> > >> likely going to make a subdirectory for it this cycle...)
> > >
> > > Sure, the only eyesore is that drivers/base/firmware.c what is that for?
> > >
> > > drivers/base/firmware_loader/ ok?
> > 
> > Yeah? Seems fine to me. Greg, do you have thoughts on this?
> 
> I don't care :)

Alright, this was much easier done as a separate patch after.

  Luis
