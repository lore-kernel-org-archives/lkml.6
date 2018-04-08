Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx4+aDqG2DJmRYtdRrdv+aOr25EKcEwu1LTmio7Uf13WXoA/jXHU3ePfz2shS6MZrbabYkAlW
ARC-Seal: i=1; a=rsa-sha256; t=1523209219; cv=none;
        d=google.com; s=arc-20160816;
        b=jtLVnTBBQrvth7puDvzwY2bOa1CL6n2ls+kcFjTKJzUPn01nzewL6aYyt0gGxH750H
         cCeZjpWq1UmFSpQb+hALFUMI+7lMxKIMi98mtZuQBp6ncuV40IX3D1rZgXKdnqQqRW5b
         LAInbadZLP4Bwcc+rtM5WbjpX7y8SYofJYCfI7+/lNflNN9WhixWKjPyzeii56ChyOJL
         /WNh1hjlRIuiuLmnTw3C7+lEAXSYYfWzYQG21LUQiLpZltGF465A0BHazMqwAeFa9CDC
         kR8fyU+0bo/JDwfy4B3dj+iByjl11J/Vk8OVi1GCbeRD7aTuFwyQyiRn42jwt86FwRmR
         mVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=bfShRy/zDWSslrry3+oK7d/nk4sxvB/W2D9/7NQJaPw=;
        b=GRwl/jPordwMUYRYJBXu8gmTe5OqfkTUChyiyUlU1AJSLsVVplCDU/J3lhJJytFSLM
         2ssIOxU00y9CvuoSuNhLbQG3k8EyOksTRJZrTt5PkebWLZW8Fi2Y7QjpHc/jzpyHAiBu
         0m9T2IXph9YjCQmK+0ttyh/AYS/3ndfTDtFGOCoYlnYPUQUYA8d9ZtZHyv/Acl89bAZX
         j4ewAu8bIwfU7iUoI0vItz0PBj8QOInRQt6N8cRMwgqxZptocWD/9RH0ofei6rL2J9RD
         /SdvZeJIOArdVVLK/JjVjs/qHIstV9L24aqpPoYLe8OKycjwFHqatO3kDGMKvMtIE6eO
         RHUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Jones <pjones@redhat.com>,
	Dave Olsthoorn <dave@bewaar.me>,
	Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	dmitry.torokhov@gmail.com,
	mfuzzey@parkeon.com,
	keescook@chromium.org,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	nbroeking@me.com,
	bjorn.andersson@linaro.org,
	Torsten Duwe <duwe@suse.de>,
	x86@kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v3 0/5] efi/firmware/platform-x86: Add EFI embedded fw support
Date: Sun,  8 Apr 2018 19:40:09 +0200
Message-Id: <20180408174014.21908-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199774524534426?=
X-GMAIL-MSGID: =?utf-8?q?1597200630945431169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Sorry for sending a v3 so soon after v2, I got the property name wrong in the
documentation added in v2 and of course noticed that minutes after sending v2.
This version fixes this.

Here is the v2 coverletter again:

Here is v2 of my patch-set to add support for EFI embedded fw to the kernel.

The 3 most prominent changes are:

1) Add documentation describing the EFI embedded firmware mechanism to:
   Documentation/driver-api/firmware/request_firmware.rst

2) Instead of having a single dmi_system_id array with its driver_data
   members pointing to efi_embedded_fw_desc structs, have the drivers which
   need EFI embedded-fw support export a dmi_system_id array and register
   that with the EFI embedded-fw code

   This series also includes the first driver to use this, in the form of
   the touchscreen_dmi code (formerly silead_dmi) from drivers/platfrom/x86

3) As discussed during the review of v1 we want to make the firmware_loader
   code fallback to EFI embedded-fw optional.  Rather the adding yet another
   firmware_request_foo variant for this, with the risk of later also needing
   firmware_request_foo_nowait, etc. variants I've decided to make the code
   check if the device has a "efi-embedded-firmware" device-property bool set.

   This also seemed better because the same driver may want to use the
   fallback on some systems, but not on others since e.g. not all (x86)
   systems with a silead touchscreen have their touchscreen firmware embedded
   in their EFI.

   Note that (as discussed) when the EFI fallback path is requested, the
   usermodehelper fallback path is skipped.

Here is the full changelog of patch 2/5 which is where most of the changes are:

Changes in v2:
-Rebased on driver-core/driver-core-next
-Add documentation describing the EFI embedded firmware mechanism to:
 Documentation/driver-api/firmware/request_firmware.rst
-Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedded
 fw support if this is set. This is an invisible option which should be
 selected by drivers which need this
-Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
 from the efi-embedded-fw code, instead drivers using this are expected to
 export a dmi_system_id array, with each entries' driver_data pointing to a
 efi_embedded_fw_desc struct and register this with the efi-embedded-fw code
-Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware,
 this avoids us messing with the EFI memmap and avoids the need to make
 changes to efi_mem_desc_lookup()
-Make the firmware-loader code only fallback to efi_get_embedded_fw() if the
 passed in device has the "efi-embedded-firmware" device-property bool set
-Skip usermodehelper fallback when "efi-embedded-firmware" device-property
 is set

Patches 3-5 are new and implement using the EFI embedded-fw mechanism for
Silead gslXXXX and Chipone icn8505 touchscreens on x86 devices.

Regards,

Hans
