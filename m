Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx4/PME2XxqugHYEIU3lRpzdVjjjg+skrUD3O4+sKZUSca5+iZpumpxgyen09Cap4LREymeti
ARC-Seal: i=1; a=rsa-sha256; t=1524744403; cv=none;
        d=google.com; s=arc-20160816;
        b=i27HAS8fh44L27qSXow4055KQqiQ2sSrh0j2skxn6DKRFxZQ61cZSgmqZL15doVEKo
         XFrYPOT8UyMiUmvzV1cMroJbAWaEbujoL36hRb/ubABHxCSjDl2ZEMZDapvosnvUWn5W
         GUqLp3++qNjPiHK/vOZT7pQrhr8X2CpmFJ/sUxEWRcJj944Xupu8/XB62FYLxon+2KwN
         wC96HnhQfa1IfvYfMOoxE/Nhl8HrFTxO9zSkfdIyeD4ItJmtCfhPuMmXdgEFyc7ACIlW
         3t80BTWrOwKGUo9k0Rq/yR9kBkOAQCaLukqEh5n8lIATOWdimsQ5DmV47FavTHDuNBxK
         uouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=hAdN/YF+Uh+h/2/Ff1UGKdE9SjflNdnPYLH14IjmVzI=;
        b=cb2nIfcsiRGXCRAptQzrhKVCOhRdczGxNHHKnp9DWgvXv9XUHHZmoOFaWRmZ8NevqG
         GDSrECrfkuDImG4b455ZLP3nVnv7CqEmyTOdcLlWudVcVvd7Hh0lrJoFoUGHx9R0XRQQ
         Ar8QDsMLV1JTobRN7HMz06cevUdYMuKNUi8zASVvponL4GmjC5/IBxYhxSvawTxgQiXM
         0eBy506K1C6jQXuKb/u+fAOi7cG8p5N5Il9k1DIZCQgiaG1WooLXv6v+IF/pevLnofHO
         Gn2dj6T33zUaadlAxt1Nz3TpDeAwaAp310XO2TRN5L9uRBAeAQ0BIPpTqrKnrWmAV3/I
         T2Vg==
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
Subject: [PATCH v4 0/5] efi/firmware/platform-x86: Add EFI embedded fw support
Date: Thu, 26 Apr 2018 14:06:32 +0200
Message-Id: <20180426120637.21258-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598810387552220035?=
X-GMAIL-MSGID: =?utf-8?q?1598810387552220035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Here is v4 of my patch-set to add support for EFI embedded fw to the kernel.

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

So I think this patch-set is getting close to ready for merging, which
brings us to the question of how to merge this, I think that patches 1
and 2 should probably both be merged through the same tree. Then an
unmutable branch should be created on that tree, merged into the
platform/x86 tree and then the last 3 patches can be merged through
that tree.

For the record, here is the coverletter of v2 of this patchset:

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
