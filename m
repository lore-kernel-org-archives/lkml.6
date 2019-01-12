Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A1C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2D12177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 09:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfALJwV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 04:52:21 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21784 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfALJwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 04:52:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1547286727; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=UZRrDciQxH1j9OMNebZGsu0Qhw68cz7e9+x2qdd7GE8PvAEvo/P4sQfo4AU/qYLLYkF0IgOQuTKMNQoC/3GY9IU8FE8dtEfiq5CMIvPdOQ+GK18FzpTDZ8PBkrbLDH32dmbF96N6/GZSK9XrqwCbHp9TfqiBVTBQzXZ7a4I4BBU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1547286727; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=ARNOOvFj2diIzxlLWeNivkt/4FkJtP4zGRx+1Pey9bk=; 
        b=AUAQGDv4fA8C2rhF+gII4U9JaKYwfYpP1kIBy6J6AwLvxRh/Ex1NT0o1jSKV2SGnZ3D6vcrjwLuoatkxkOiwVJDuyiogKnUNE9+bbnPG8TK7n34hBmGUvX9BV53Ghq1kpSm9Fhmgo75GqozuPSsxwGcRyV0QgaxZmW4ymaqqYgM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1547286726002108.85719570779668; Sat, 12 Jan 2019 01:52:06 -0800 (PST)
Message-ID: <1ee67fe6cd7cc556a28e97529febf52ab0247ab4.camel@mniewoehner.de>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1547221227.19931.453.camel@linux.ibm.com>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
         <1541960689.3190.4.camel@HansenPartnership.com>
         <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
         <1547221227.19931.453.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 12 Jan 2019 10:52:02 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.3 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

On Fri, 2019-01-11 at 10:40 -0500, Mimi Zohar wrote:
> Hi Michael,
> 
> On Sun, 2018-11-11 at 19:50 +0100, Michael Niewöhner wrote:
> 
> > Well, there are at least two implementations I know of:
> > For my Lenovo X260 I can choose between Infineon TPM 1.2 or Intel PTT TPM
> > 2.0
> > This here is my ThinkStation P320 which can choose between PTT 1.2, PTT 2.0,
> > Nuvoton 1.2 and 2.0. When switchting between 1.2 and 2.0 the Nuvoton gets
> > reflashed with the appropriate firmware.
> 
> With IBM's LTC help, we finally found a Lenovo with the Nuvoton
> NCPT650.  It's a System x3550 M5[1], not a ThinkStation P320, running
> Fedora (vmlinuz-4.16.14-300.fc28.x86_64). I replaced the 4.16 kernel
> with the latest stable 4.19.y kernel.  Both the TPM and IMA seem to be
> working properly.  Not sure if this helps...
> 
> From dmesg:
> # dmesg | grep -i tpm 
> [    0.000000] Linux version 4.19.14 (mimi@x86tpm2Server.rtp.stglabs.i
> bm.com) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #6 SMP
> Thu Jan 10 22:32:54 EST 2019
> [    0.000000] efi:  ACPI=0x7b786000  ACPI 2.0=0x7b786014 
> SMBIOS=0x793fe000  TPMEventLog=0x426fa018 
> [    0.014413] ACPI: SSDT 0x000000007B784000 0003A7 (v02 INTEL 
> Tpm2Tabl 00001000 INTL 20130328)
> [    0.014416] ACPI: TPM2 0x000000007B783000 000034 (v03 INTEL  EDK2  
>   00000002 INTL 01000013)
> [    2.667052] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2
> 
> # cat /sys/kernel/security/ima/ascii_runtime_measurements | head -2
> 10 5425744ce804c8cae89a08d53b41ab20ff1b3ea6 ima-sig
> sha1:7996f7339c3ce64e63f1232ef1aa6033247af784 boot_aggregate
> 
> I installed the ibmtpm2tss[2], built (eg. autoreconf -i; configure --
> enable-hwtpm) and installed it.
> 
> # export LD_LIBRARY_PATH=/usr/local/lib/
> # cd /usr/local/bin
> # ./tsspcrread -ha 10 -halg sha256 -ns
> f73ff9109b06d4f7a7cbe7eac32b20d2ca662e55cb4c81e152beea261989ad4b
> 
> Mimi
> 
> [1] https://lenovopress.com/lp0599.pdf
> [2] https://git.code.sf.net/p/ibmtpm20tss/tss
> 

what UEFI version is installed on that machine?
Is the TPM connected via LPC or I2C?

Best regards
Michael




