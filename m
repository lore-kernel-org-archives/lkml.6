Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AB8JxZogqcvzqZnxAbeYA74zVFWmkqFpaKoOUiziIuQL3u8iqwWd3p99Hx6QaiVTjvgApMjSWjhM
ARC-Seal: i=1; a=rsa-sha256; t=1525205200; cv=none;
        d=google.com; s=arc-20160816;
        b=HgYbSBDfBdMT6Tm6/ExPlG7bgH+t1Ru7mJoAss5X7ThjH4kf6yApkySSTkNNq4hiKj
         DtVbYCG8GpSE51VTpaSDmeY4kZZBXt4SSGjWU1Nk0FBsSxYw09xh1+j3e7roVKCxje1j
         mySq2sLsJcAfCNJWXnDF/XGW4+5ZnILSw8Wn+q6wUeGD72OrZGToQyeKPJZTkD8csVB7
         Wo8ckzM7eiWbBlYi5J/BaORKgPtmgPL5gL1OW486qomN9JHKUDTCIORI8TonMzy0qeuU
         9cKOXnornpnAv8Fx+owjWPBIJZ52fNlWrTULr1LZ4pkwzgMv5mP1aaiupxhu6CcG32kw
         YWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=TYzt7dlomvLmqbmXxZqRigp16+Yt3zBmVSeT2kWBSGU=;
        b=uB3CNmY06q2bnEwM83QUo58h3i18pae+CuaUD9jd9QXghyh0zPAZe1cz5WNwVTnRvW
         +MliJtgOFRlQsjaaqjvkR9R7ydw+eiEJT5Nbr6ctHJDrOO49teyAIzTfvaMsygiEgUCy
         gGj5ILs1pvlYSIhRWXy0+NW0OITfKsojj2wYdKVAK9SGH/UY7FaQN3nofjHqVuz5d1pi
         qjA31/T9TI0LVRD5W4dCMXNthyNqY87VNt+uwQ9bZKs9dVaqpsmHTXoIAmAJaqUDcR/m
         rG8ZNWpQwWumRA3cFoNMxiAKQdq2CwxE02gwJbU4HxNg8HqtNB7P5PpwD2hRc1u27j7n
         rJAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 176.9.242.62 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 176.9.242.62 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Tue, 1 May 2018 22:06:39 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Jones <pjones@redhat.com>, dave@bewaar.me,
	Will Deacon <will.deacon@arm.com>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	Bjorn Andersson <bjorn.andersson@linaro.org>, duwe@suse.de,
	Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
	linux-efi <linux-efi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180501200639.GA3628@wunner.de>
References: <20180429093558.5411-1-hdegoede@redhat.com>
 <20180429093558.5411-3-hdegoede@redhat.com>
 <CALCETrXDrcxyESajDZs3L7sAAfDXXc_CUzy5nUZxLPxaTHZ80g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXDrcxyESajDZs3L7sAAfDXXc_CUzy5nUZxLPxaTHZ80g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1599293568305924327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 07:29:19PM +0000, Andy Lutomirski wrote:
> On Sun, Apr 29, 2018 at 2:36 AM Hans de Goede <hdegoede@redhat.com> wrote:
> > +       for (i = 0; i < size; i += 8) {
> > +               if (*((u64 *)(mem + i)) != *((u64 *)desc->prefix))
> > +                       continue;
> > +
> > +               /* Seed with ~0, invert to match crc32 userspace utility
> */
> > +               crc = ~crc32(~0, mem + i, desc->length);
> > +               if (crc == desc->crc)
> > +                       break;
> > +       }
> 
> I hate to play the security card, but this stinks a bit.  The kernel
> obviously needs to trust the EFI boot services code since the EFI boot
> services code is free to modify the kernel image.  But your patch is not
> actually getting this firmware blob from the boot services code via any
> defined interface -- you're literally snarfing up the blob from a range of
> memory.  I fully expect there to be any number of ways for untrustworthy
> entities to inject malicious blobs into this memory range on quite a few
> implementations.
[snip]
> It would be really nice if there was a way to pull a blob out of EFI space
> that is marked, by EFI, as belonging to a particular device.

Upthread I suggested to read the firmware from the EFI Firmware Volume.
>From my point of view that would fulfill your requirements:
https://lkml.org/lkml/2018/4/3/568

In the case of Hans' HID device, the firmware is embedded as a binary
array in the EFI driver for the device.  So the kernel would read the
driver from the Firmware Volume, but it would still have to extract
the firmware from the driver, either by scanning for the 8 byte magic
or by hardcoding the offset and length in the kernel.

An attacker would have to modify the Firmware Volume as opposed to
just modifying a particular space in memory.

My suggestion was dismissed by Hans and Peter Jones on the grounds of
causing additional work without perceived benefit, given that a working
(albeit admitted to be hackish) solution exists.

Moreover Ard criticized that the EFI Firmware Volume Protocol is not
part of the UEFI spec.

I agree with you completely BTW.

Thanks,

Lukas
