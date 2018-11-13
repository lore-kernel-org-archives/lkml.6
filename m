Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB69C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFDB22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFDB22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbeKMUsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:48:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:31254 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732148AbeKMUsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:48:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 02:50:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,498,1534834800"; 
   d="scan'208";a="105837169"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2018 02:50:47 -0800
Date:   Tue, 13 Nov 2018 12:50:45 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
Message-ID: <20181113105045.GC10434@linux.intel.com>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
 <1541960689.3190.4.camel@HansenPartnership.com>
 <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
 <1541962653.3190.7.camel@HansenPartnership.com>
 <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
 <1541968191.3190.12.camel@HansenPartnership.com>
 <3243d0325b3ea5878d3f86b0ee4fec1498f21dc1.camel@mniewoehner.de>
 <660b0934bc16c8d195a2724f8be4ba8dfbe71134.camel@mniewoehner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <660b0934bc16c8d195a2724f8be4ba8dfbe71134.camel@mniewoehner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 10:11:33PM +0100, Michael Niewöhner wrote:
> Very strange... When I pull the power cord, then replug and boot, I get these
> dmesg messages:
> [    0.000000] efi:  ACPI
> 2.0=0x9ea78000  ACPI=0x9ea78000  SMBIOS=0x9f5e5000  SMBIOS
> 3.0=0x9f5e4000  MPS=0xfca00  ESRT=0x9c06e918  MEMATTR=0x99cb9018  TPMEventLog=0x
> 98d0c018 
> [    0.001794] ACPI: TPM2 0x000000009EAB1F70 000034 (v03 LENOVO TC-
> S06   00001260 AMI  00000000)
> [    3.096587] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [    3.105684] tpm tpm0: A TPM error (2314) occurred attempting the self test
> 
> After a reboot I get those "ima: ..." message again. Pulling the plug seems to
> reset anything (the TPM).
> 
> The PTT TPM 2.0 shows exactly the same behaviour.

The error in question is TPM_RC_TESTING i.e. TPM is still processing
selftests in the background.

It is clearly a regression but unfortanely it is harmless and unrelated
i.e. tpm2_do_selftest() should not print an error message because it
is legit behavior.

The function actually masks the whole error:

	if (rc == TPM2_RC_TESTING)
		rc = TPM2_RC_SUCCESS;

/Jarkko
