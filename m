Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519796010; cv=none;
        d=google.com; s=arc-20160816;
        b=LddBHAxHYhxLnajkjYs8BhTBop3/1XL+l/13ly1AA3m9Klw+v833bNVetJ3NhQpTY2
         aM+MCDsZPDS3qkHLRxEKKUOlyPyTjC9h86V7xvTamCWOccTw0+3avDld7k0qMLGDY+HX
         ZOZ8wv09npVIYLjs7Y0ipAwfaIES1o5Sr4xh8eghULHhO8TeVezoyrMPLU/spSyWvekz
         0nEjO7yTX3xeeAjSX1ygb6wvkyNMDRZ67luduxVTuk68DSK+5R0BR1thKYYZh1j7DAyD
         2pVKiLa/3Bgq8dXHSouDJ7E/ZvaeEpwt7Ud2vy0dNuyA+iIgJSecC9wb1AyzQfsNMFwY
         fC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=dzn2wDkE6RQasDf8rTYe3/Hd+Uymay5JDPeCrBTPv1U=;
        b=Xaif/EPKoSiT6Oqh7IX6vTObO7crINhzY9Q5ht61pLDMGsN1+SqNgQTS/TRA1Ivm0+
         bThoRvczAH2HKow/r2jQTTSaHnVhKhlygmBQUnpVoToPGA87UhDoulpn/cLmr++5fPb6
         I5mLhJnzJi7Vir6HRrYUodFRaK897GCk6Maa36r1sb033hgeaNoGVkcQ6Qj5PAfQbJLK
         Asd6uS2LYNmNPYkz+meupNVBJjkeVmP+g3syZ1CfJfRwfrwXbJrxcIIDSqJsD7bOYyqq
         HcIaqonsH1LnfHJlzfkQ5VRaZt2Xs+5zlVPe4x1Vy+wD/ZHJVp8tPBxu+ov4+eJpOweW
         fJ+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=tWa/qSGM;
       dkim=pass header.i=@chromium.org header.s=google header.b=nAK5AIPi;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=tWa/qSGM;
       dkim=pass header.i=@chromium.org header.s=google header.b=nAK5AIPi;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsMXFVj40IOUwA4zLc3iZ2mFHi3YTteiHr+Cjw8eYYsafy3LIEyBBDZcu82y/u0gcRqFT6SxRjSN8/FfAy4Nl8=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180228012802.GG14069@wotan.suse.de>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-8-mcgrof@kernel.org>
 <CAGXu5jKoRsXm00=dQePgrjF+EauphKnPQXVgL=rv_d579eNE7g@mail.gmail.com> <20180228012802.GG14069@wotan.suse.de>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 21:33:28 -0800
X-Google-Sender-Auth: avcLit11JCD4fqr1i42a2WzdCTg
Message-ID: <CAGXu5j+tFg+rGn5baCFRF5ARwExuD45oRE=dmzB8T84XDL=f-w@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] firmware: split firmware fallback functionality
 into its own file
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	Martin Fuzzey <mfuzzey@parkeon.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com, Takashi Iwai <tiwai@suse.de>,
	arend.vanspriel@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	nbroeking@me.com, Vikram Mulukutla <markivx@codeaurora.org>, stephen.boyd@linaro.org,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248720090748696?=
X-GMAIL-MSGID: =?utf-8?q?1593621621698095323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 5:28 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Tue, Feb 27, 2018 at 03:14:53PM -0800, Kees Cook wrote:
>> On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> > The firmware fallback code is optional. Split that code out to help
>> > distinguish the fallback functionlity from othere core firmware loader
>> > features. This should make it easier to maintain and review code
>> > changes.
>> >
>> > The reason for keeping the configuration onto a table which is built-in
>> > if you enable firmware loading is so that we can later enable the kernel
>> > after subsequent patches to tweak this configuration, even if the
>> > firmware loader is modular.
>> >
>> > This introduces no functional changes.
>> >
>> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
>> > ---
>> >  drivers/base/Makefile                  |   4 +-
>> >  drivers/base/firmware_fallback.c       | 661 +++++++++++++++++++++++++++
>> >  drivers/base/firmware_fallback.h       |  61 +++
>> >  drivers/base/firmware_fallback_table.c |  29 ++
>> >  drivers/base/firmware_loader.c         | 803 +--------------------------------
>> >  drivers/base/firmware_loader.h         | 115 +++++
>> >  6 files changed, 874 insertions(+), 799 deletions(-)
>> >  create mode 100644 drivers/base/firmware_fallback.c
>> >  create mode 100644 drivers/base/firmware_fallback.h
>> >  create mode 100644 drivers/base/firmware_fallback_table.c
>> >  create mode 100644 drivers/base/firmware_loader.h
>>
>> Does it make sense to have a separate subdirectory for firmware
>> instead? I did this _ stuff with lkdtm and have regretted it. (I'm
>> likely going to make a subdirectory for it this cycle...)
>
> Sure, the only eyesore is that drivers/base/firmware.c what is that for?
>
> drivers/base/firmware_loader/ ok?

Yeah? Seems fine to me. Greg, do you have thoughts on this?

-Kees

-- 
Kees Cook
Pixel Security
