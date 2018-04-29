Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZqmCaFVe1h0zhD0Q9zu02oXFh3swsJoDD6U7xP4fw+iFNK5lF/UwNu7n1mrJwdxvcaua1eg
ARC-Seal: i=1; a=rsa-sha256; t=1524994564; cv=none;
        d=google.com; s=arc-20160816;
        b=l5G8TO4LYSPlYhbYzICnPmnVumfgjtmYRGz3VfbTG7YorFOO6rmt28kD+QE/dc89hd
         pDC6QnSG4ObIQSq0iCfQwVayL9payUEfn4WYpwnuyW9Xs1GL1/79nXXHY44nLj/mcuzN
         nvz6tKwI322/0elvqgI4mg5n8+qk/2F4A5LvxxdRjCEa+ZHt7DroS4aNUdRIn4+ZCP2r
         d77Egg2g2kft1B39sfYKJX5pKfd/F77xn0XPhEVbsZYr6wLDfZRRQoC3FvqWAY/YgWl+
         NoZBPxlYSmRNgsu05CU/v6B1fd/0/K4h8eBpEQMJ2FNlYYsefdYYib/BT8Qjv70SqSRb
         SESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=+vBip1QzbO//OkxTsTNKeKunUHXRLODC1tD+pToYqfk=;
        b=zPJQg1WV4W1fD2L+OwyUgzIaaP1k6oRH8/WLgiGPxz9i03J0FGhwqGI4Wzbl4+R6c4
         r3CZEFvH19U311ldAYaWN/0BQfJ0dWQRuk4qJUsl7vNTqqCxRBWoO+oRPSl3RLo/OsHF
         5s5UjEbA72xDIsw1IJCkD9medpt+nGGB/mJZFPjRgCqS1PajF/i3h05LBifH1NzH1V2W
         RRlPnWmeywXZkDrUNAzq+YXm0Ra3AwjnoSncpUSMOGeI6n0s3OTnCrnNnpKxyHFT8OfK
         /5LCb9epe4lL4QWqNtl26sWmyV45SgGRfDpQJYRczT//fb9prVFhizu2SvjXxcyM6Jdl
         HDjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
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
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	nbroeking@me.com,
	bjorn.andersson@linaro.org,
	Torsten Duwe <duwe@suse.de>,
	Kees Cook <keescook@chromium.org>,
	x86@kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] efi/firmware/platform-x86: Add EFI embedded fw support
Date: Sun, 29 Apr 2018 11:35:53 +0200
Message-Id: <20180429093558.5411-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072701077174089?=
X-GMAIL-MSGID: =?utf-8?q?1599072701077174089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Here is v5 of my patch-set to add support for EFI embedded fw to the kernel.

Changes since v4:
-Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS

So I think this patch-set is getting close to ready for merging, which
brings us to the question of how to merge this, I think that patches 1
and 2 should probably both be merged through the same tree. Then an
unmutable branch should be created on that tree, merged into the
platform/x86 tree and then the last 3 patches can be merged through
that tree.

Ard has already indicated he is fine with the EFI bits going upstream
through another tree, so perhaps patches 1-2 can be merged through the
firmware-loader-tree and then do an unmutable branch on the
firmware-loader-tree for the platform/x86 tree to merge?

I don't think taking all 5 through 1 tree is a good idea because of
the file rename under platform/x86.


For the record here are the cover letters of the previous versions:

Changes since v3:
-Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part of
 UEFI proper, so the EFI maintainers don't want us referring people to it
-Use new EFI_BOOT_SERVICES flag
-Put the new fw_get_efi_embedded_fw() function in its own fallback_efi.c
 file which only gets built when EFI_EMBEDDED_FIRMWARE is selected
-Define an empty stub for fw_get_efi_embedded_fw() in fallback.h hwen
 EFI_EMBEDDED_FIRMWARE is not selected, to avoid the need for #ifdefs
 in firmware_loader/main.c
-Properly call security_kernel_post_read_file() on the firmware returned
 by efi_get_embedded_fw() to make sure that we are allowed to use it

The 3 most prominent changes in v2 are:

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
