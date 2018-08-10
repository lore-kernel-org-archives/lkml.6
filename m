Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075DBC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2AD21B32
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2AD21B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHKAQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:16:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:14467 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725754AbeHKAQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:16:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 14:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,221,1531810800"; 
   d="scan'208";a="80356178"
Received: from jdrachal-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.35.232])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2018 14:44:49 -0700
Date:   Sat, 11 Aug 2018 00:44:48 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Harlan Lieberman-Berg <harlan@dds.mil>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: Fwd: PROBLEM: tpm_cpg can't request region with AMD/Dell fTPM
Message-ID: <20180810214433.GA15044@linux.intel.com>
References: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
 <CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>
 <20180810165735.GT4692@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810165735.GT4692@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 07:57:35PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 07, 2018 at 02:43:10PM -0400, Harlan Lieberman-Berg wrote:
> > (Resending as it seems to have been spamfiltered out from the ml;
> > sorry Peter, Jarkko for the duplicate)
> 
> I came on Monday from four week leave and have been basically been
> catching up with my emails :-) I'll look into this next week with
> time.

The error message is saying that someone else has reserved the resource
(-EBUSY).

This looks odd:

e78bf000-e7bbefff : ACPI Non-volatile Storage
  e7bb6000-e7bb9fff : MSFT0101:00
  e7bba000-e7bbdfff : MSFT0101:00

Why would be TPM registers mapped inside ACPI NV?

I would *guess* that what is happening is that perhaps drivers/acpi/nvs.c
maps the address space. This looks like a firmware bug, and such that we
cannot do anything about it.

I'm having a weird issue with the ACPI tables:

$ acpixtract acpidump.txt

Intel ACPI Component Architecture
ACPI Binary Table Extraction Utility version 20180105
Copyright (c) 2000 - 2018 Intel Corporation

  DSDT -   31048 bytes written (0x00007948) - dsdt.dat
  SSDT -     349 bytes written (0x0000015D) - ssdt1.dat
  SSDT -   18086 bytes written (0x000046A6) - ssdt2.dat
  SSDT -    5225 bytes written (0x00001469) - ssdt3.dat
  SSDT -    1082 bytes written (0x0000043A) - ssdt4.dat
  SSDT -    1017 bytes written (0x000003F9) - ssdt5.dat
  SSDT -    5369 bytes written (0x000014F9) - ssdt6.dat

$ iasl -d *.dat   

Intel ACPI Component Architecture
ASL+ Optimizing Compiler/Disassembler version 20180105
Copyright (c) 2000 - 2018 Intel Corporation

Input file dsdt.dat, Length 0x7948 (31048) bytes
Table [DSDT] is too long for file - needs: 0x815D, remaining in file: 0x7948
Could not get ACPI tables from dsdt.dat, AE_BAD_HEADER

This has not happened to me before.

/Jarkko
