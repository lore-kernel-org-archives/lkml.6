Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AB8JxZraisQ2LBEyDptK8QJqrSTg2U8rEYKIitNn2lCJH28iwghHrCvKAPugJBimmLovF/Wjzq8m
ARC-Seal: i=1; a=rsa-sha256; t=1525202972; cv=none;
        d=google.com; s=arc-20160816;
        b=lyDvfFJ+1KtYTYWXynxSwCI6Bg7VFD1Zhq5bvdRpXj43nh/ZPhNjxwfFUcRvw0Nuy+
         BMq5Kf3cG1zXGG+meLJHKF0OqqZUV5WSevgoXNe6aL2FLz3xHNNaArXxumeHcE8MN6UQ
         5AAF7hrM+Vqjy22Rw2QmwiHrV7AtSdtFtfcX/mI9RY0GM4ui7ql0q3xsL1uszNyEJyMU
         NTz+nJBxRUh/MXzSIroyzIWv+Yxp1Nws5v1KOeSqGGDVyQTY5fHh8QMs+kw45UvIjWn3
         ykKxmI2JyMLGTnBnGFnsrbxdHvCQqBJHLvPQRRK2IGw/jnjd8T7koFqXzo+Gu0/F2pJV
         w/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=T7inblU0jetzrIgR56kMhXSbStqIunryn5B8xtPXMpY=;
        b=o6jnyjY2WMEDJLxaljsIIuesfm4cQVsGElmLJI3vloP/efn96c7aFy8VSd7uU73e+e
         SED/qHMhN0eIQgdUvq6sqyMirarGdfDPhs6MNX1KcGQxunWvQ16ugOPEpIlDHG4+K+Xm
         bK8v87jeDtsqWxfzt/j7wbchGYbc64AdmeEOuNzpygG0QuTsiTssBkL4OBSh655bkb+0
         m5lQBo8Nf9HahOgRh1royPdvlVtEnLggMAqaJkq4HNbVL2Crp2HccteoZcsrNKyD9GA/
         EHmoXo6Xo9AFHgHR+LEbgMjkEEX/aejhYtvI/reXSMi7/CN2924QaHOdz4IBeRFe+VCq
         05RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7820223712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
References: <20180429093558.5411-1-hdegoede@redhat.com> <20180429093558.5411-3-hdegoede@redhat.com>
In-Reply-To: <20180429093558.5411-3-hdegoede@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 01 May 2018 19:29:19 +0000
X-Gmail-Original-Message-ID: <CALCETrXDrcxyESajDZs3L7sAAfDXXc_CUzy5nUZxLPxaTHZ80g@mail.gmail.com>
Message-ID: <CALCETrXDrcxyESajDZs3L7sAAfDXXc_CUzy5nUZxLPxaTHZ80g@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Jones <pjones@redhat.com>, dave@bewaar.me,
	Will Deacon <will.deacon@arm.com>, Andrew Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>, David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Kalle Valo <kvalo@codeaurora.org>, Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	Bjorn Andersson <bjorn.andersson@linaro.org>, duwe@suse.de,
	Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
	linux-efi <linux-efi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1599291232193254378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 2:36 AM Hans de Goede <hdegoede@redhat.com> wrote:
> +The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE
memory
> +segments for an eight byte sequence matching prefix, if the prefix is
found it
> +then does a crc32 over length bytes and if that matches makes a copy of
length
> +bytes and adds that to its list with found firmwares.
> +

Eww, gross.  Is there really no better way to do this?  Is the issue that
the EFI code does not intend to pass the firmware to the OS but that it has
a copy for its own purposes and that Linux is just going to hijack EFI's
copy?  If so, that's brilliant and terrible at the same time.

> +       for (i = 0; i < size; i += 8) {
> +               if (*((u64 *)(mem + i)) != *((u64 *)desc->prefix))
> +                       continue;
> +
> +               /* Seed with ~0, invert to match crc32 userspace utility
*/
> +               crc = ~crc32(~0, mem + i, desc->length);
> +               if (crc == desc->crc)
> +                       break;
> +       }

I hate to play the security card, but this stinks a bit.  The kernel
obviously needs to trust the EFI boot services code since the EFI boot
services code is free to modify the kernel image.  But your patch is not
actually getting this firmware blob from the boot services code via any
defined interface -- you're literally snarfing up the blob from a range of
memory.  I fully expect there to be any number of ways for untrustworthy
entities to inject malicious blobs into this memory range on quite a few
implementations.  For example, there are probably unauthenticated EFI
variables and even parts of USB sticks and such that get read into boot
services memory, and I see no reason at all to expect that nothing in the
so-called "boot services code" range is actually just plain old boot
services *heap*.

Fortunately, given your design, this is very easy to fix.  Just replace
CRC32 with SHA-256 or similar.  If you find the crypto api too ugly for
this purpose, I have patches that only need a small amount of dusting off
to give an entirely reasonable SHA-256 API in the kernel.

(To be clear, I don't love my own suggestion here.  What I'd *really* like
to see is a better interface and no attempt to match the data to some
built-in hash at all.  In particular, there are plenty of devices for which
the driver wants access to a genuinely device-specific blob.  For example,
I'm typing this email while connected to a router that is running ath10k
and is using a calibration blob awkwardly snarfed out of flash somewhere.
It would be really nice if there was a way to pull a blob out of EFI space
that is marked, by EFI, as belonging to a particular device.  Then the
firmware could just pass it over without any particular verification.  But
since your code is literally scanning a wide swath of physical memory for
something that looks like a valid blob, I think you need to use a
cryptographically strong concept of validity.)
