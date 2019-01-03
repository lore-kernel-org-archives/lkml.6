Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C74C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C719421479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbfACN4H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:56:07 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21841 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbfACN4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:56:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546523750; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=iq8rcgBE3Jmi9HIv3rf7ywUPh9fjExp31pezmAR427UcYtVU6P2TmVT7x2Oi9ET+MqFi5svQ7/SG1ilsPfeRak3+xSWRNe8SF++obYWOyqNVPlwSM+hbGbD9UL1FtNL9vsE3F6knNODy8eJmWUauE1bcbrO4btnhzN5hzlmDLtU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546523750; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=ziR1lVwKW2vr4ZDNlLnThJ8pjbU7JrXDrOhhgzgu1es=; 
        b=l7XgPTaVflxPffnqa555zKnxF9jiwVjZN8onQdxFzbdsS/eTUuou/FpXH/ECaJ2j1XztRyQE6L09tXrZvosV5iYArR5lcP9So+i0NnnF/MkWKJEugaNbrkkJ3+EQ481ASWqpJjZHzBmG6H7mrT+XGxLD/ObiBI64qPCD6pivZss=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1546523748624259.8068004857464; Thu, 3 Jan 2019 05:55:48 -0800 (PST)
Message-ID: <25e00fe6c92da8adf37450fe3b98a9ea4ae43c1a.camel@mniewoehner.de>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <20190103134147.GE10491@linux.intel.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <20190103134147.GE10491@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 03 Jan 2019 14:55:44 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.3 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 15:41 +0200, Jarkko Sakkinen wrote:
> On Sun, Dec 16, 2018 at 02:32:38PM +0100, Michael Niewöhner wrote:
>  
> > dmesg cold boot with tpm_tis.interrupts=0 tpm_tis.force=1:
> > ----------------------------------------------------------
> > > dmesg | grep -i tpm
> > [    0.000000] Command line: initrd=\initrd-test console=ttyS0,115200n8
> > break=premount tpm_tis.interrupts=0 tpm_tis.force=1
> > [    0.000000] efi:  ACPI
> > 2.0=0x9e07e000  ACPI=0x9e07e000  SMBIOS=0x9ebeb000  SMBIOS
> > 3.0=0x9ebea000  MEMATTR=0x98fb2018  TPMEventLog=0x972bb018 
> > [    0.003531] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
> > S06   00001260 AMI  00000000)
> > [    0.162005] Kernel command line: initrd=\initrd-test
> > console=ttyS0,115200n8
> > break=premount tpm_tis.interrupts=0 tpm_tis.force=1
> > [    3.616806] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> > [    3.683117] tpm_tis tpm_tis: can't request region for resource [mem
> > 0xfed40000-0xfed44fff]
> > [    3.691378] tpm_tis: probe of tpm_tis failed with error -16
> > [    4.572539] ima: Error Communicating to TPM chip
> 
> Wonder why this happens. What does /proc/iomem show?
> 
> /Jarkko

root@debian:~# cat /proc/iomem 
00000000-00000fff : Reserved
00001000-00057fff : System RAM
00058000-00058fff : Reserved
00059000-0009dfff : System RAM
0009e000-000fffff : Reserved
  000a0000-000bffff : PCI Bus 0000:00
  000c0000-000c3fff : PCI Bus 0000:00
  000c4000-000c7fff : PCI Bus 0000:00
  000c8000-000cbfff : PCI Bus 0000:00
  000cc000-000cffff : PCI Bus 0000:00
  000d0000-000d3fff : PCI Bus 0000:00
  000d4000-000d7fff : PCI Bus 0000:00
  000d8000-000dbfff : PCI Bus 0000:00
  000dc000-000dffff : PCI Bus 0000:00
  000e0000-000e3fff : PCI Bus 0000:00
  000e4000-000e7fff : PCI Bus 0000:00
  000e8000-000ebfff : PCI Bus 0000:00
  000ec000-000effff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-942eb017 : System RAM
942eb018-942fb457 : System RAM
942fb458-976bbfff : System RAM
976bc000-976bcfff : ACPI Non-volatile Storage
976bd000-976bdfff : Reserved
976be000-9d7fafff : System RAM
9d7fb000-9ea61fff : Reserved
  9dde3018-9dde3019 : APEI ERST
  9dde301c-9dde3021 : APEI ERST
  9dde3028-9dde3039 : APEI ERST
  9dde3040-9dde304c : APEI ERST
  9dde3050-9dde504f : APEI ERST
9ea62000-9eaedfff : ACPI Tables
9eaee000-9f2c7fff : ACPI Non-volatile Storage
9f2c8000-9f743fff : Reserved
9f744000-9f7fffff : System RAM
9f800000-9fffffff : Reserved
a0000000-dfffffff : PCI Bus 0000:00
  dfb00000-dfdfffff : PCI Bus 0000:03
    dfb00000-dfb7ffff : 0000:03:00.3
      dfb00000-dfb7ffff : igb
    dfb80000-dfbfffff : 0000:03:00.2
      dfb80000-dfbfffff : igb
    dfc00000-dfc7ffff : 0000:03:00.1
      dfc00000-dfc7ffff : igb
    dfc80000-dfcfffff : 0000:03:00.0
      dfc80000-dfcfffff : igb
    dfd00000-dfd03fff : 0000:03:00.3
      dfd00000-dfd03fff : igb
    dfd04000-dfd07fff : 0000:03:00.2
      dfd04000-dfd07fff : igb
    dfd08000-dfd0bfff : 0000:03:00.1
      dfd08000-dfd0bfff : igb
    dfd0c000-dfd0ffff : 0000:03:00.0
      dfd0c000-dfd0ffff : igb
  dfe00000-dfefffff : PCI Bus 0000:02
    dfe00000-dfe03fff : 0000:02:00.0
      dfe00000-dfe03fff : rtl_pci
  dff00000-dff1ffff : 0000:00:1f.6
    dff00000-dff1ffff : e1000e
  dff20000-dff23fff : 0000:00:1f.2
  dff24000-dff25fff : 0000:00:17.0
    dff24000-dff25fff : ahci
  dff26000-dff267ff : 0000:00:17.0
    dff26000-dff267ff : ahci
  dff27000-dff270ff : 0000:00:17.0
    dff27000-dff270ff : ahci
  dffe0000-dfffffff : pnp 00:06
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
  e0000000-efffffff : Reserved
    e0000000-efffffff : pnp 00:06
fd000000-fe7fffff : PCI Bus 0000:00
  fd000000-fdabffff : pnp 00:07
  fdac0000-fdacffff : pnp 00:09
  fdad0000-fdadffff : pnp 00:07
  fdae0000-fdaeffff : pnp 00:09
  fdaf0000-fdafffff : pnp 00:09
  fdb00000-fdffffff : pnp 00:07
    fdc6000c-fdc6000f : iTCO_wdt
      fdc6000c-fdc6000f : iTCO_wdt
  fe000000-fe010fff : Reserved
  fe036000-fe03bfff : pnp 00:07
  fe03d000-fe3fffff : pnp 00:07
  fe410000-fe7fffff : pnp 00:07
fec00000-fec00fff : Reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed00fff : Reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed10000-fed17fff : pnp 00:06
fed18000-fed18fff : pnp 00:06
fed19000-fed19fff : pnp 00:06
fed20000-fed3ffff : pnp 00:06
fed40000-fed44fff : MSFT0101:00
  fed40000-fed44fff : MSFT0101:00
fed45000-fed8ffff : pnp 00:06
fed90000-fed90fff : dmar0
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : Reserved
ff000000-ffffffff : Reserved
  ff000000-ffffffff : INT0800:00
    ff000000-ffffffff : pnp 00:06
100000000-85fffffff : System RAM
  2afc00000-2b06031d0 : Kernel code
  2b06031d1-2b0d120ff : Kernel data
  2b1119000-2b11fffff : Kernel bss
2000000000-2fffffffff : PCI Bus 0000:00
  2ffff00000-2ffff0ffff : 0000:00:14.0
    2ffff00000-2ffff0ffff : xhci-hcd
  2ffff10000-2ffff100ff : 0000:00:1f.4
  2ffff11000-2ffff11fff : 0000:00:14.2
    2ffff11000-2ffff11fff : Intel PCH thermal driver





