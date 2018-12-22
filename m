Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6892EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A9A21A47
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391471AbeLVRc6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:32:58 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21716 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391420AbeLVRc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:32:56 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1545486440; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Tqd7EJr38JljH2g3WeS8HRRT2WvFb5xOEyZc/6i0KfL/VU57RXFh2hmbNz8UlPVXNdcM1fj7TkQxthv0Cwh7dPRstBU5LDLIsooQTuyxZBuQO3HOlYdkhUzEFs1+ntYv6ZXpyy8N0uaFFTr7moy5SR/f0sYL2D+VJY73caiQblM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1545486440; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=itqnhxWNrHLdnkkCsW3z0T5I1XolTMo/Y9SOGj0uSgw=; 
        b=B84TzFQ7qB5PIn7REC/JconqntVmAqqEHRMlIIWthwsIrl5R0879vSoJXAjp+RFKaPTXBbwfDjwUSchC92NdoIwZxaX1JeehjeDGV25SZlIVlNnFRHchZADV5mSB5BatWpNVj+vVzhGjyYn1Ie8A4yN/L5OmtkIMdA7feGiL95Y=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1545486437594444.0936340937685; Sat, 22 Dec 2018 05:47:17 -0800 (PST)
Message-ID: <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 22 Dec 2018 14:47:13 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sun, 2018-12-16 at 14:32 +0100, Michael Niewöhner wrote:
> Hi again,
> 
> after my UEFI firmware mod/hack to flash the newest available Nuvoton firmware
> to the NCPT650 the selftest error went away. Since then the TPM worked without
> any further problems, at least after warm reboots.
> 
> What I didn't notice before is that it does NOT work after a cold (re)boot.
> There is no difference between Intel Firmware TPM and the Nuvoton TPM.
> I can reproduce the error for both. I did not test TPM1.2 again.
> 
> dmesg warm (re)boot:
> --------------------
> > dmesg | grep -i tpm
> 
> [    0.000000] efi:  ACPI
> 2.0=0x9e07e000  ACPI=0x9e07e000  SMBIOS=0x9ebeb000  SMBIOS
> 3.0=0x9ebea000  MEMATTR=0x98fb2018  TPMEventLog=0x972bc018 
> [    0.003368] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
> S06   00001260 AMI  00000000)
> [    3.610138] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> 
> 
> dmesg cold boot with tpm_tis.interrupts=0 tpm_tis.force=1:
> ----------------------------------------------------------
> > dmesg | grep -i tpm
> 
> [    0.000000] Command line: initrd=\initrd-test console=ttyS0,115200n8
> break=premount tpm_tis.interrupts=0 tpm_tis.force=1
> [    0.000000] efi:  ACPI
> 2.0=0x9e07e000  ACPI=0x9e07e000  SMBIOS=0x9ebeb000  SMBIOS
> 3.0=0x9ebea000  MEMATTR=0x98fb2018  TPMEventLog=0x972bb018 
> [    0.003531] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
> S06   00001260 AMI  00000000)
> [    0.162005] Kernel command line: initrd=\initrd-test console=ttyS0,115200n8
> break=premount tpm_tis.interrupts=0 tpm_tis.force=1
> [    3.616806] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [    3.683117] tpm_tis tpm_tis: can't request region for resource [mem
> 0xfed40000-0xfed44fff]
> [    3.691378] tpm_tis: probe of tpm_tis failed with error -16
> [    4.572539] ima: Error Communicating to TPM chip
> 
> 
> dmesg cold boot:
> ----------------
> > dmesg | grep -i tpm
> 
> [    0.000000] Command line: initrd=\initrd-test console=ttyS0,115200n8
> break=premount
> [    0.000000] efi:  ACPI
> 2.0=0x9e07e000  ACPI=0x9e07e000  SMBIOS=0x9ebeb000  SMBIOS
> 3.0=0x9ebea000  MEMATTR=0x98fb2298  TPMEventLog=0x972bb018 
> [    0.003559] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
> S06   00001260 AMI  00000000)
> [    0.161958] Kernel command line: initrd=\initrd-test console=ttyS0,115200n8
> break=premount
> [    5.245801] ima: No TPM chip found, activating TPM-bypass!
> 
> 
> Any ideas how to debug this?
> 
> Thanks
> Michael


I have been doing some more debugging - as far as I were able to. These are my
results:

Doing a cold boot I was getting "No TPM chip found" in most cases. I found out
that the TPM will not be found if the bootloader (systemd-boot in my case) has a
timeout value of 10 seconds. This was set for some other tests...

When I remove the timeout and boot directly to the linux kernel, I get that
"2314 TPM-self test error" since it has not finished, yet. The TPM is detected
by IMA and works fine then.

Some more tests showed that any delay before booting the kernel causes the TPM
to not get detected. I tested, 10, 15, 20, 30, 60... seconds. Only in some very
rare cases the TPM got detected.

I wanted to know if the TPM is in an well initialized state at the time of that
error. Since I was not able to get some test/debug kernel patches working I
decided to try kexec. It turned out that the TPM is indeed correctly working and
will be detected just fine by linux after kexec!

Is there anyone having an idea what could be wrong here? I am willing to debug
this but I have really no idea where to start :-(

Best regards
Michael

----

kexec test output:

<...>
(initramfs) dmesg | grep -i tpm
[    0.000000] Command line: initrd=\initrd console=ttyS0,115200n8
root=zfs:rpool/ROOT tpm.override_rng_quality=1024 quiet break=top
[    0.000000] efi:  ACPI
2.0=0x9ea7e000  ACPI=0x9ea7e000  SMBIOS=0x9f5eb000  SMBIOS
3.0=0x9f5ea000  MPS=0xfca00  ESRT=0x9c07b118  MEMATTR=0x9982d018  TPMEventLog=0x
98ace018 
[    0.001310] ACPI: TPM2 0x000000009EAB7F70 000034 (v03 LENOVO TC-
S06   00001260 AMI  00000000)
[    0.159568] Kernel command line: initrd=\initrd console=ttyS0,115200n8
root=zfs:rpool/ROOT quiet break=top
[    1.376200] ima: No TPM chip found, activating TPM-bypass!

/ # kexec -f --initrd=/initrd.img-4.19.9\+ --reuse-cmdline /vmlinuz-4.19.9\+
[  890.632541] kexec_core: Starting new kernel
<...>
(initramfs) dmesg | grep -i tpm
[    0.000000] Command line: initrd=\initrd console=ttyS0,115200n8
root=zfs:rpool/ROOT tpm.override_rng_quality=1024 quiet break=top
[    0.000000] efi:  ACPI
2.0=0x9ea7e000  ACPI=0x9ea7e000  SMBIOS=0x9f5eb000  SMBIOS
3.0=0x9f5ea000  MPS=0xfca00  ESRT=0x9c07b118  MEMATTR=0x9982d018  TPMEventLog=0x
98ace018 
[    0.001272] ACPI: TPM2 0x000000009EAB7F70 000034 (v03 LENOVO TC-
S06   00001260 AMI  00000000)
[    0.168244] Kernel command line: initrd=\initrd console=ttyS0,115200n8
root=zfs:rpool/ROOT quiet break=top
[    0.632922] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)


