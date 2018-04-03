Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx4/dKnrMnZFeiRFgjB5qFkMzOQm8SSgfaLLV9claZJwspDZFWIvhvr917IvPqD5Y2R9et7lB
ARC-Seal: i=1; a=rsa-sha256; t=1522781930; cv=none;
        d=google.com; s=arc-20160816;
        b=wH+Mm0/+3KDFcbPZu38TQIcpQaKonEB5B4WAXS/+jYEmcLmQGjqox2vZakyCk69Pcw
         wUWqothpUPvcndTH124S5pGy9U/MhoZRZAnhSgWNX3W02S85QhbG2wL42uLb0sW8TazV
         EaAmQzcNEqp7nJXlD6ASltKQRlbiwbqlBexQi4NCDF0/E1QdYRLQ/sF1YBawzm8gD4uj
         2Gds4iR0UWRFxZkP3Y69Zl9ialgiZwTvvTv3jzcN5EfXMKJUbVH4csrqFN2l1wqa+Zgy
         yCHxisTeH4ag2gjuTlVX4PjkZLCcvOSFG9C2CMLlJ9yAG2tGj0pfeQy4yet+zsmmQ81M
         0ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=7kVkuUtQDUX1aDVHblgqIjOqsC1RWVD7544SomC6/qs=;
        b=Jcde21KMIWaR5LKgUO2OK10SZbCzfGp3EhWmFIV9xPaVFmW0ShZ3Rvc9IRS7ZOWAWo
         ezg/f9sbyyQilE7ccEEi2fwPIpph4YSUtTPdN+j3+q8HiXHDO0SJaMj+6cG3/BR1KrIZ
         mIiJyufyr5hRa5SFKZs00hTLrsgLFW2ofFqVACMWXhkdAnxKJXZK3488Fb4/sknOpHAM
         4ZxMKfQTDPmFRu6poPMoqpDGUwVO/+eYTZuI6RSSHM4+5O3ssldcmZ3o90PoqqvqnNru
         Xveod1svEKXK+WcU2dZHSKzTDRYIBhB6eofp4rt6o7mjBsKvfRUxM530JZbWn6saIDOG
         N56w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Tue, 3 Apr 2018 18:58:48 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hans de Goede <hdegoede@redhat.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
	Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
	linux-efi@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	dmitry.torokhov@gmail.com, mfuzzey@parkeon.com,
	keescook@chromium.org, nbroeking@me.com, bjorn.andersson@linaro.org,
	Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH 2/2] efi: Add embedded peripheral firmware support
Message-ID: <20180403185848.GD30543@wotan.suse.de>
References: <20180331121944.8618-1-hdegoede@redhat.com>
 <20180331121944.8618-2-hdegoede@redhat.com>
 <20180402232333.GU30543@wotan.suse.de>
 <17fb3c28-78ff-2e1f-2ada-d33320567761@redhat.com>
 <20180403180711.GA7957@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403180711.GA7957@wunner.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455691844480056?=
X-GMAIL-MSGID: =?utf-8?q?1596752585056628105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 08:07:11PM +0200, Lukas Wunner wrote:
> On Tue, Apr 03, 2018 at 10:33:25AM +0200, Hans de Goede wrote:
> > I asked Peter Jones for suggestions how to extract this during boot and
> > he suggested seeing if there was a copy of the firmware in the
> > EFI_BOOT_SERVICES_CODE memory segment, which it turns out there is.
> > 
> > My patch to add support for this contains a table of device-model (dmi
> > strings), firmware header (first 64 bits), length and crc32 and then if
> > we boot on a device-model which is in the table the code scans the
> > EFI_BOOT_SERVICES_CODE for the prefix, if found checks the crc and
> > caches the firmware for later use by request-firmware.
> > 
> > So I just do a brute-force search for the firmware, this really is hack,
> > nothing standard about it I'm afraid. But it works on 4 different x86
> > tablets I have and makes the touchscreen work OOTB on them, so I believe
> > it is a worthwhile hack to have.
> 
> The EFI Firmware Volume contains a kind of filesystem with files
> identified by GUIDs.  Those files include EFI drivers, ACPI tables,
> DMI data and so on.  It is actually quite common for vendors to
> also include device firmware on the Firmware Volume.  Apple is doing
> this to ship firmware updates e.g. for the GMUX controller found on
> dual GPU MacBook Pros.  If they want to update the controller's
> firmware, they include it in a BIOS update, and an EFI driver checks
> on boot if the firmware update for the controller is necessary and
> if so, flashes it.
> 
> The firmware files you're looking for are almost certainly included
> on the Firmware Volume as individual files.

What Hans implemented seems to have been for a specific x86 hack, best if we
confirm if indeed they are present on the Firmware Volume.

> Rather than scraping
> the EFI memory for firmware, I think it would be cleaner and more
> elegant if you just retrieve the files you're interested in from
> the Firmware Volume.
> 
> We're doing something similar with Apple EFI properties, see
> 58c5475aba67 and c9cc3aaa0281.
> 
> Basically what you need to do to implement this approach is:
> 
> * Determine the GUIDs used by vendors for the files you're interested
>   in.  Either dump the Firmware Volume or take an EFI update as
>   shipped by the vendor, then feed it to UEFIExtract:
>   https://github.com/LongSoft/UEFITool
>   
> * Add the EFI Firmware Volume Protocol to include/linux/efi.h:
>   https://www.intel.com/content/dam/doc/reference-guide/efi-firmware-file-volume-specification.pdf
> 
> * Amend arch/x86/boot/compressed/eboot.c to read the files with the
>   GUIDs you're interested in into memory and pass the files to the
>   kernel as setup_data payloads.
> 
> * Once the kernel has booted, make the files you've retrieved
>   available to device drivers as firmware blobs.

Happen to know if devices using Firmware Volumes also sign their firmware
and if hw checks the firmware at load time?

  Luis

> The end result is mostly the same as what you're doing here,
> and you'll also have a similar array of structs, but instead
> of hardcoding 8-byte signatures of firmware files, you'll be
> using GUIDs.  I envision lots of interesting use cases for
> a generic Firmware Volume file retrieval mechanism.  What you
> need to keep in mind though is that this approach only works
> if the kernel is booted via the EFI stub.
> 
> Thanks,
> 
> Lukas
> 

-- 
Do not panic
