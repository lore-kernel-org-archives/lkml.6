Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AH8x224mheRmav49neoF5b/NQRmwLbvtU2OF+CBukTNK4nNuF5j780mp7B1fhCpLrM8/LJ4Y5Wh1
ARC-Seal: i=1; a=rsa-sha256; t=1519781284; cv=none;
        d=google.com; s=arc-20160816;
        b=qryiX2dY7pgvNXWOqQzLLVSizA4+TqKmB7Yr8rs7CqLUAIuBNGgHU9DOQkZGm2lntf
         c8enPhMbOvr8rUrRAo6T+fDcWgMPcEL+R2SXXGS34k/0jwyOo70tCoMOCLPTkKmsKurN
         YQNO9251GynwePNU+S24TsC35dFk5udRkGGXl77/5cHvxDOv3Ppol5GXataZKjpYZnUr
         AiP6slcdyLjiZGv1BV8dTPqkqFnHHP+VuLKktErPu01BvNveGcv1FMBjsGUyAoA7n2AL
         RxWvZS6PDvMkmTIWqv1rp2jaeJXxcKa8bSY6jTt7AfDJGKWX4cgBymbaFVDe1epSoAHI
         JHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=9omUFrarBRakkEUZdmUMc6zcgEbZ4qK8olQigtwsrzk=;
        b=a7/w51n3sS6eYBsBhuK5dmitP6r8hNbnF7O1TxDUGA8Brb1upsgy6xYS0kEPq4di+7
         GgKW+lyOFLhUhI0fp+QOXVu2rEB7yykB8YRr77hRXeISTPPAon03ZaOoUJT+5JtMPrD2
         uuU8+Iy1/FSZZBf3upU23xiUn5+H6nE/RR7nxne4GREWF/Ahm8oKDo5ek5SKNTMsNiRy
         aOE4jzYpv+GEjdUx5JtFFaKIdHPEik/m+xRAG1jUOT2gHsmDAVzeB/0luzFHmcpXlh+Z
         IU+jiltRhKbXCbA3HkthR+FtZeFLGkK2c+vL08YPfI6IxZKJRihtymJeW6TJDxH177UV
         gvog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 28 Feb 2018 01:28:02 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20180228012802.GG14069@wotan.suse.de>
References: <20180224024613.24078-1-mcgrof@kernel.org>
 <20180224024613.24078-8-mcgrof@kernel.org>
 <CAGXu5jKoRsXm00=dQePgrjF+EauphKnPQXVgL=rv_d579eNE7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKoRsXm00=dQePgrjF+EauphKnPQXVgL=rv_d579eNE7g@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248720090748696?=
X-GMAIL-MSGID: =?utf-8?q?1593606180551798816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:14:53PM -0800, Kees Cook wrote:
> On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > The firmware fallback code is optional. Split that code out to help
> > distinguish the fallback functionlity from othere core firmware loader
> > features. This should make it easier to maintain and review code
> > changes.
> >
> > The reason for keeping the configuration onto a table which is built-in
> > if you enable firmware loading is so that we can later enable the kernel
> > after subsequent patches to tweak this configuration, even if the
> > firmware loader is modular.
> >
> > This introduces no functional changes.
> >
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > ---
> >  drivers/base/Makefile                  |   4 +-
> >  drivers/base/firmware_fallback.c       | 661 +++++++++++++++++++++++++++
> >  drivers/base/firmware_fallback.h       |  61 +++
> >  drivers/base/firmware_fallback_table.c |  29 ++
> >  drivers/base/firmware_loader.c         | 803 +--------------------------------
> >  drivers/base/firmware_loader.h         | 115 +++++
> >  6 files changed, 874 insertions(+), 799 deletions(-)
> >  create mode 100644 drivers/base/firmware_fallback.c
> >  create mode 100644 drivers/base/firmware_fallback.h
> >  create mode 100644 drivers/base/firmware_fallback_table.c
> >  create mode 100644 drivers/base/firmware_loader.h
> 
> Does it make sense to have a separate subdirectory for firmware
> instead? I did this _ stuff with lkdtm and have regretted it. (I'm
> likely going to make a subdirectory for it this cycle...)

Sure, the only eyesore is that drivers/base/firmware.c what is that for?

drivers/base/firmware_loader/ ok?

  Luis
