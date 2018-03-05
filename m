Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934565AbeCEMOv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:14:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:58094 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932817AbeCEMOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:14:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="25268665"
Date: Mon, 5 Mar 2018 14:14:45 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Sahil Rihan <srihan@fb.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [Regression] TPM char device not created if TPM 1.2 is disabled,
 but visible
Message-ID: <20180305121445.GA3138@linux.intel.com>
References: <875E6A7D-483D-4A8F-9382-6B3970598866@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875E6A7D-483D-4A8F-9382-6B3970598866@fb.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2018 at 09:27:36PM +0000, Sahil Rihan wrote:
> (Please CC me on replies - I'm not subscribed to LMKL)
> 
> Prior to  0cf577a03f21 if a TPM 1.2 device was disabled, but visible (sysfs node "enabled" returns 0), creation of the TPM char device was only skipped if  tpm_bios_log_setup returned -ENODEV. 
> 
> On some systems like HP DL380 G9, if the TPM is disabled but visible, the TCPA log is empty, which means tpm_read_log_acpi returns -EIO.  Starting with 0cf577a03f21, -EIO triggers an early return from tpm_chip_register which means the char device is not created.
> 
> Log snippet:
> [    4.320387] tpm_tis 00:00: 1.2 TPM (device-id 0xB, rev-id 16)
> [    4.455389] tpm tpm0: A TPM error (7) occurred attempting to read a pcr value
> [    4.457762] tpm tpm0: TPM is disabled/deactivated (0x7)
> [    4.459461] tpm tpm0: tpm_read_log_acpi: TCPA log area empty    <----------------------
> [    4.461312] tpm_tis: probe of 00:00 failed with error -5
> 
> Thanks,
> Sahil

Thanks for the bug report, I appreciate it!

Personally I think we should keep the warning if the log area is empt
but tpm_read_log_acpi() should return -ENODEV in this case.

/Jarkko
