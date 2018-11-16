Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425E4C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FF020883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FF020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbeKQHUv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:20:51 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21771 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQHUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:20:51 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1542402396; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Vhbg/k+WWIdXNOhy4eXFAnRaDhu5a0ACDD09USJ1C7DscYplNDZAdpN732+gF7DQ7omvzizQI0h9vEFor2JNj63WTw+gxwYM+APmLEHfTrlvnFOUbs03Q1rYoTUs07ICZWch0Pg6xahKAnUh0ZlHqQzCoRVjHXq1JXKngmYM+Pk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1542402396; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=MokZj39AinDCRmdSKKljWwTriRDPBu5RvYl+huNjliU=; 
        b=MTEd0BvORE8F+msoX3TWxOY6xvM3Ax+DFyXw/vhIFfURY0lQt24RNX4Xe/eovlM52Jnsc0VArmR8lGztZpYUXd9aKz+K8cdMUZihZfaUEW9RyXb3OtmXiArw3FNZjqKdp7mUNPdXLo794t8f0/FBTZ83fZPFEZoNjzwil71TokI=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1542402392185349.79672657272124; Fri, 16 Nov 2018 13:06:32 -0800 (PST)
Message-ID: <b89c95a496a1512ee3069b6a69cf915906fe697a.camel@mniewoehner.de>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <4f7cc7152f2266d8d0782889db2375d4c1c71987.camel@mniewoehner.de>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
         <1541960689.3190.4.camel@HansenPartnership.com>
         <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
         <1541962653.3190.7.camel@HansenPartnership.com>
         <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
         <1541968191.3190.12.camel@HansenPartnership.com>
         <3243d0325b3ea5878d3f86b0ee4fec1498f21dc1.camel@mniewoehner.de>
         <660b0934bc16c8d195a2724f8be4ba8dfbe71134.camel@mniewoehner.de>
         <1541972556.3734.90.camel@linux.ibm.com>
         <4f7cc7152f2266d8d0782889db2375d4c1c71987.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 16 Nov 2018 22:06:28 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 21:46 +0100, Michael Niewöhner wrote:
> Hi all,
> 
> I tried that patch mentioned by Mimi but it does not change anything for me.
> 
> Then I did some more tests with different kernel configs and finally got TPM
> working by
> a) compiling TPM as modules and rmmod tpm* and re-modprobe tpm_tis.
> 
> (initramfs) dmesg | grep -i tpm
> [    0.000000] efi:  ACPI 2.0=0x9ea7e000 ACPI=0x9ea7e000 SMBIOS=0x9f5eb000
> SMBIOS 3.0=0x9f5ea000 ESRT=0x9c07d918 MEMATTR=0x9bea3018
> TPMEventLog=0x97cbb018
> [    0.003793] ACPI: TPM2 0x000000009EAB7F70 000034 (v03 LENOVO TC-
> S06   00001260 AMI 00000000)
> (initramfs) rmmod tpm_crb tpm_tis tpm_tis_core tpm
> (initramfs) modprobe tpm_tis
> [   44.956905] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> 
> b) compiling TPM-support in-kernel and manually bind the ACPI device
> 
> (initramfs) dmesg | grep -i tpm
> [    0.000000] efi: ACPI 2.0=0x9ea7e000 ACPI=0x9ea7e000 SMBIOS=0x9f5eb000
> SMBIOS
> 3.0=0x9f5ea000 ESRT=0x9c07d918 MEMATTR=0x9bea3018 TPMEventLog=0x97cbb018
> [    0.003546] ACPI: TPM2 0x000000009EAB7F70 000034 (v03 LENOVO TC-S06
> 00001260
> AMI 00000000)
> (initramfs) echo MSFT0101:00 >/sys/bus/platform/drivers/tpm_tis/bind
> [  233.076079] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> 
> 
> It seems to me, the kernel tries to enable the TPM to early...
> 
> 
> Michael

Looks like the manual driver bind works more or less but e.g reading hwrng does
not work...

# echo MSFT0101:00 >/sys/bus/platform/drivers/tpm_tis/bind
[  148.293302] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
# cat /sys/devices/virtual/misc/hw_random/rng_current
tpm-rng-0
# cat /dev/hwrng >/dev/null 
cat: /dev/hwrng: Operation not permitted


