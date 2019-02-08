Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0FEC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCF22080D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBHAdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:33:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:44188 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfBHAdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:33:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 16:33:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,346,1544515200"; 
   d="scan'208";a="273371456"
Received: from mwesterb-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.154])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2019 16:33:15 -0800
Date:   Fri, 8 Feb 2019 02:33:14 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
Message-ID: <20190208003314.GB7202@linux.intel.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190206120634.GA4680@linux.intel.com>
 <3d6fdcc1-8221-2137-fc82-596377cc2fdc@infineon.com>
 <20190207212912.GD23906@linux.intel.com>
 <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 06:29:43PM -0500, Stefan Berger wrote:
> On 2/7/19 4:29 PM, Jarkko Sakkinen wrote:
> > On Thu, Feb 07, 2019 at 07:41:56PM +0100, Alexander Steffen wrote:
> > > On 06.02.2019 13:06, Jarkko Sakkinen wrote:
> > > > On Wed, Feb 06, 2019 at 12:47:07AM +0200, Jarkko Sakkinen wrote:
> > > > > Make the changes necessary to detach TPM space code and TPM activation
> > > > > code out of the tpm_transmit() flow because of both of these can cause
> > > > > nested tpm_transmit() calls. The nesteds calls make the whole flow hard
> > > > > to maintain, and thus, it is better to just fix things now before this
> > > > > turns into a bigger mess.
> > > > > 
> > > > > v11:
> > > > > * Drop the patch that tries to flush TPM space on system. Not a proper
> > > > >     fallback + out of scope for this patch set.
> > > > > 
> > > > > v10:
> > > > > * Use void pointers to avoid unnecessary casts in functions paramaters
> > > > >     where it makes sense.
> > > > > 
> > > > > v9:
> > > > > * Fixed again tpm_try_get_ops().
> > > > > * Added missing reviewed-by's.
> > > > > 
> > > > > v8:
> > > > > * Re-add the check for ret < 0 after calling tpm_try_transmit() that
> > > > >     was dropped by mistake while moving code.
> > > > > * Fix error fallback for tpm_try_get_ops() when tpm_chip_start()
> > > > >     fails.
> > > > > 
> > > > > v7:
> > > > > *  Reorganize series so that more trivial and self-contained changes are
> > > > >      in the head.
> > > > > 
> > > > > v6:
> > > > > * When tpm_validate_commmand() was moved to tpm2-space.c, the struct for
> > > > >     the TPM header was incorrectly declared as struct tpm_input_header.
> > > > > * Fix return value in tpm_validate_command().
> > > > > 
> > > > > v5:
> > > > > * Add the missing rev's from Stefan Berger.
> > > > > 
> > > > > v4:
> > > > > * Return 0 from pcrs_show() when tpm1_pcr_read() fails.
> > > > > * Fix error handling flow in tpm_try_transmit().
> > > > > * Replace struct tpm_input_header and struct tpm_output_header with
> > > > >     struct tpm_header.
> > > > > 
> > > > > v3:
> > > > > * Encapsulate power gating code to tpm_chip_start() and tpm_chip_stop().
> > > > > * Move TPM power gating code and locking to tpm_try_get_ops() and
> > > > >     tpm_put_ops().
> > > > > * Call power gating code directly in tpm_chip_register() and
> > > > >     tpm2_del_space().
> > > > > 
> > > > > v2:
> > > > > * Print tpm2_commit_space() error inside tpm2_commit_space()
> > > > > * Error code was not printed when recv() callback failed. It is
> > > > >     fixed in this version.
> > > > > * Added a patch that removes @space from tpm_transmit().
> > > > > * Fixed a regression in earlier series. Forgot to amend the change
> > > > >     from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.
> > > > > 
> > > > > Jarkko Sakkinen (16):
> > > > >     tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
> > > > >     tpm: fix invalid return value in pubek_show()
> > > > >     tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
> > > > >     tpm: print tpm2_commit_space() error inside tpm2_commit_space()
> > > > >     tpm: declare struct tpm_header
> > > > >     tpm: access command header through struct in tpm_try_transmit()
> > > > >     tpm: encapsulate tpm_dev_transmit()
> > > > >     tpm: clean up tpm_try_transmit() error handling flow
> > > > >     tpm: move tpm_validate_commmand() to tpm2-space.c
> > > > >     tpm: move TPM space code out of tpm_transmit()
> > > > >     tpm: remove @space from tpm_transmit()
> > > > >     tpm: use tpm_try_get_ops() in tpm-sysfs.c.
> > > > >     tpm: remove TPM_TRANSMIT_UNLOCKED flag
> > > > >     tpm: introduce tpm_chip_start() and tpm_chip_stop()
> > > > >     tpm: take TPM chip power gating out of tpm_transmit()
> > > > >     tpm: remove @flags from tpm_transmit()
> > > > > 
> > > > >    drivers/char/tpm/tpm-chip.c       | 109 ++++++++++++
> > > > >    drivers/char/tpm/tpm-dev-common.c |  44 ++++-
> > > > >    drivers/char/tpm/tpm-interface.c  | 264 ++++++------------------------
> > > > >    drivers/char/tpm/tpm-sysfs.c      | 138 ++++++++++------
> > > > >    drivers/char/tpm/tpm.h            |  64 +++-----
> > > > >    drivers/char/tpm/tpm1-cmd.c       |  28 +---
> > > > >    drivers/char/tpm/tpm2-cmd.c       |  72 +++-----
> > > > >    drivers/char/tpm/tpm2-space.c     |  91 +++++++---
> > > > >    drivers/char/tpm/tpm_i2c_atmel.c  |   5 +-
> > > > >    drivers/char/tpm/tpm_vtpm_proxy.c |  12 +-
> > > > >    drivers/char/tpm/xen-tpmfront.c   |   2 +-
> > > > >    11 files changed, 408 insertions(+), 421 deletions(-)
> > > > > 
> > > > > -- 
> > > > > 2.19.1
> > > > > 
> > > > Applied to master and next.
> > > Something in this series seems to break basic TPM communication for me.
> > > 
> > > For TPM2.0s the probe command fails, causing them to be misdetected as
> > > TPM1.2s:
> > > 
> > > ---
> > > tpm tpm0: tpm_try_transmit: tpm_send: error -5
> > > tpm_tis MSFT0101:00: 1.2 TPM (device-id 0x1A, rev-id 22)
> > > tpm tpm0: A TPM error (30) occurred attempting to determine the timeouts
> > > ---
> > > tpm tpm0: tpm_try_transmit: tpm_send: error -5
> > > tpm_tis_spi spi0.1: 1.2 TPM (device-id 0x1B, rev-id 22)
> > > tpm tpm0: A TPM error (30) occurred attempting to determine the timeouts
> > > ---
> > > 
> > > And for something that actually is a TPM1.2 it fails in a similar way:
> > > 
> > > ---
> > > tpm_i2c_infineon 1-0020: 1.2 TPM (device-id 0x1A)
> > > tpm tpm0: A TPM error (-14) occurred attempting to determine the timeouts
> > > ---
> > > tpm tpm0: tpm_try_transmit: tpm_send: error -5
> > > tpm_tis_spi spi0.1: 1.2 TPM (device-id 0x1B, rev-id 16)
> > > tpm tpm0: A TPM error (-14) occurred attempting to determine the timeouts
> > > tpm_tis_spi: probe of spi0.1 failed with error -14
> > > ---
> > > 
> > > I see this problem across my entire range of TPM devices and test platforms.
> > > Any idea what could be wrong here?
> > Weird.
> > 
> > Can you run a bisect?
> 
> There are 2 bugs and the following overall patch against your tree fixes
> them. Let me comment on the individual patches in v17. I missed those
> obviously when testing with the tpm_vtpm_proxy...
> 
> 
> 
> diff --git a/drivers/char/tpm/tpm-interface.c
> b/drivers/char/tpm/tpm-interface.c
> index 02e8cffd1163..34c0da55d885 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -94,6 +94,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> void *buf, size_t bufsiz)
>          return rc;
>      }
> 
> +    rc = 0;
>      if (chip->flags & TPM_CHIP_FLAG_IRQ)
>          goto out_recv;

What why?

> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index e74c5b7b64bf..52afe20cc8a1 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -799,7 +799,9 @@ int tpm2_probe(struct tpm_chip *chip)
>      tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
>      tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
>      tpm_buf_append_u32(&buf, 1);
> +    tpm_chip_start(chip);
>      rc = tpm_transmit_cmd(chip, &buf, 0, NULL);
> +    tpm_chip_stop(chip);

Thanks Stefan! I added call to tpm_tis_core as tpm2-cmd.c is to be kept
out of chip management common case being that you call tpm_try_get_ops(),
do 1-N TPM commands and release with tpm_put_ops(). These functions take
care starting and stopping the chip.

I fixed the 2nd issue in the master.

 /Jarkko
