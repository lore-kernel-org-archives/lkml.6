Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602DDC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32894214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32894214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeKLEkc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:40:32 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21848 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbeKLEkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:40:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1541962266; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ftVeRYJb5qciDRq8XdF6St7ZEDoPerZhJuwbazZTBGtWKeDqqxY9ZqPSol/xJdArYBQU8ADdnztPS3pme05pvfvaO5079AZdiGPLsZ0+z7cICS/fKDh9LcRjGrJpzOpdc6VyK0bPi3qA2hVJYknk0bWxHReNaCu2SgKfY7dbbvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1541962266; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=G2qg0/nqOmE5wFC6Shq099qCROZ3COoCFHBJ+pkz9Nw=; 
        b=KYFsVf5tE5Squ3zeQlsqLqG/YnLbHaWDWtu8QYEXZREOMlLepHkuQHnUTlc+lDnK7Kkbt3z3PSuYBL3MeeIhW+KHW4sUOZI5ySVlM6Ix61i1chXzdwYfG7ZQWtwAMw7VBe/BSVe4wxkqE2RG65B20Fq7BH5weyE9hd7qIE0/qUk=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1541962264894801.0334694998747; Sun, 11 Nov 2018 10:51:04 -0800 (PST)
Message-ID: <b1f403b78da6d70ae493272fd7e9fede0714cf30.camel@mniewoehner.de>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Mimi Zohar <zohar@linux.ibm.com>, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1541961216.3734.60.camel@linux.ibm.com>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
         <1541961216.3734.60.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 11 Nov 2018 19:51:01 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

On Sun, 2018-11-11 at 13:33 -0500, Mimi Zohar wrote:
> On Sun, 2018-11-11 at 18:55 +0100, Michael Niewöhner wrote:
> > Hi all,
> > 
> > Nuvoton NCPT650 does not work in TPM 2.0 mode with tpm_tis / tpm_i2c_nuvoton
> > while it works in TPM 1.2 mode (I can reflash it via UEFI setup).
> > Kernel version is 4.19.1
> > 
> > Kernel config:
> > 
> > $ cat .config | egrep 'TCG|TPM|CRB|_TIS'
> > CONFIG_TCG_TPM=y
> > CONFIG_HW_RANDOM_TPM=y
> > CONFIG_TCG_TIS_CORE=y
> > CONFIG_TCG_TIS=y
> > CONFIG_TCG_TIS_SPI=y
> > # CONFIG_TCG_TIS_I2C_ATMEL is not set
> > # CONFIG_TCG_TIS_I2C_INFINEON is not set
> > CONFIG_TCG_TIS_I2C_NUVOTON=y
> > # CONFIG_TCG_NSC is not set
> > # CONFIG_TCG_ATMEL is not set
> > # CONFIG_TCG_INFINEON is not set
> > CONFIG_TCG_CRB=y
> > # CONFIG_TCG_VTPM_PROXY is not set
> > # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> > # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> > 
> > 
> > TPM 1.2 mode dmesg:
> > 
> > $ dmesg | egrep -i tis\|tpm\|crb
> > [    3.210040] tpm_tis 00:0a: 1.2 TPM (device-id 0xFE, rev-id 2)
> > 
> > 
> > TPM 2.0 mode dmesg:
> > 
> > $ dmesg | egrep -i tis\|tpm\|crb
> > [    0.000000] efi:  ACPI
> > 2.0=0x9e457000  ACPI=0x9e457000  SMBIOS=0x9ec44000  SMBIOS
> > 3.0=0x9ec43000  TPMEventLog=0x9711f018 
> > [    0.003517] ACPI: TPM2 0x000000009E490ED8 000034 (v03 LENOVO TC-
> > S06   00001300 AMI  00000000)
> > [    4.071550] ima: No TPM chip found, activating TPM-bypass!
> 
> It's possible that eventually the TPM is initialized, but not in time
> for IMA.  Could you you check to see if the TPM is responding to
> userspace commands after boot?

No it isn't even detected. There is no /dev/tpm0 and /sys/class/tpm is empty.

> 
> Mimi
> 


