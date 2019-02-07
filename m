Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBBCC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B412175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="WSxduoYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBGSv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:51:57 -0500
Received: from smtp2.infineon.com ([217.10.52.18]:55424 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfBGSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:51:56 -0500
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 13:51:54 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1549565515; x=1581101515;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kABnqEUI8oDFNMb/Zw05k+zHhI9JnmBRwJmh2Ur6Wmc=;
  b=WSxduoYQCKRNQAnK4vJ78eJaOZ5qXceCCmG4TEugEycyP6uqwJRYCkK1
   xz7fNeYIYVQOMCCeLRenMYdf3qAPb1dihp+aYKRDhPrwmHjVEKhbxc6ZE
   Gv3uEThf96Yvm9FOKsTjytHY2hseCo0wWq4wdO6G0OYbmOx9RtbqX9I/+
   0=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="5900,7806,9160"; a="99967746"
X-IronPort-AV: E=Sophos;i="5.58,345,1544482800"; 
   d="scan'208";a="99967746"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2019 19:42:03 +0100
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Thu,  7 Feb 2019 19:42:03 +0100 (CET)
Received: from [10.154.32.72] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1531.3; Thu, 7 Feb
 2019 19:42:02 +0100
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
 <20190206120634.GA4680@linux.intel.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <3d6fdcc1-8221-2137-fc82-596377cc2fdc@infineon.com>
Date:   Thu, 7 Feb 2019 19:41:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206120634.GA4680@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE707.infineon.com (172.23.7.81) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.2019 13:06, Jarkko Sakkinen wrote:
> On Wed, Feb 06, 2019 at 12:47:07AM +0200, Jarkko Sakkinen wrote:
>> Make the changes necessary to detach TPM space code and TPM activation
>> code out of the tpm_transmit() flow because of both of these can cause
>> nested tpm_transmit() calls. The nesteds calls make the whole flow hard
>> to maintain, and thus, it is better to just fix things now before this
>> turns into a bigger mess.
>>
>> v11:
>> * Drop the patch that tries to flush TPM space on system. Not a proper
>>    fallback + out of scope for this patch set.
>>
>> v10:
>> * Use void pointers to avoid unnecessary casts in functions paramaters
>>    where it makes sense.
>>
>> v9:
>> * Fixed again tpm_try_get_ops().
>> * Added missing reviewed-by's.
>>
>> v8:
>> * Re-add the check for ret < 0 after calling tpm_try_transmit() that
>>    was dropped by mistake while moving code.
>> * Fix error fallback for tpm_try_get_ops() when tpm_chip_start()
>>    fails.
>>
>> v7:
>> *  Reorganize series so that more trivial and self-contained changes are
>>     in the head.
>>
>> v6:
>> * When tpm_validate_commmand() was moved to tpm2-space.c, the struct for
>>    the TPM header was incorrectly declared as struct tpm_input_header.
>> * Fix return value in tpm_validate_command().
>>
>> v5:
>> * Add the missing rev's from Stefan Berger.
>>
>> v4:
>> * Return 0 from pcrs_show() when tpm1_pcr_read() fails.
>> * Fix error handling flow in tpm_try_transmit().
>> * Replace struct tpm_input_header and struct tpm_output_header with
>>    struct tpm_header.
>>
>> v3:
>> * Encapsulate power gating code to tpm_chip_start() and tpm_chip_stop().
>> * Move TPM power gating code and locking to tpm_try_get_ops() and
>>    tpm_put_ops().
>> * Call power gating code directly in tpm_chip_register() and
>>    tpm2_del_space().
>>
>> v2:
>> * Print tpm2_commit_space() error inside tpm2_commit_space()
>> * Error code was not printed when recv() callback failed. It is
>>    fixed in this version.
>> * Added a patch that removes @space from tpm_transmit().
>> * Fixed a regression in earlier series. Forgot to amend the change
>>    from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.
>>
>> Jarkko Sakkinen (16):
>>    tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
>>    tpm: fix invalid return value in pubek_show()
>>    tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
>>    tpm: print tpm2_commit_space() error inside tpm2_commit_space()
>>    tpm: declare struct tpm_header
>>    tpm: access command header through struct in tpm_try_transmit()
>>    tpm: encapsulate tpm_dev_transmit()
>>    tpm: clean up tpm_try_transmit() error handling flow
>>    tpm: move tpm_validate_commmand() to tpm2-space.c
>>    tpm: move TPM space code out of tpm_transmit()
>>    tpm: remove @space from tpm_transmit()
>>    tpm: use tpm_try_get_ops() in tpm-sysfs.c.
>>    tpm: remove TPM_TRANSMIT_UNLOCKED flag
>>    tpm: introduce tpm_chip_start() and tpm_chip_stop()
>>    tpm: take TPM chip power gating out of tpm_transmit()
>>    tpm: remove @flags from tpm_transmit()
>>
>>   drivers/char/tpm/tpm-chip.c       | 109 ++++++++++++
>>   drivers/char/tpm/tpm-dev-common.c |  44 ++++-
>>   drivers/char/tpm/tpm-interface.c  | 264 ++++++------------------------
>>   drivers/char/tpm/tpm-sysfs.c      | 138 ++++++++++------
>>   drivers/char/tpm/tpm.h            |  64 +++-----
>>   drivers/char/tpm/tpm1-cmd.c       |  28 +---
>>   drivers/char/tpm/tpm2-cmd.c       |  72 +++-----
>>   drivers/char/tpm/tpm2-space.c     |  91 +++++++---
>>   drivers/char/tpm/tpm_i2c_atmel.c  |   5 +-
>>   drivers/char/tpm/tpm_vtpm_proxy.c |  12 +-
>>   drivers/char/tpm/xen-tpmfront.c   |   2 +-
>>   11 files changed, 408 insertions(+), 421 deletions(-)
>>
>> -- 
>> 2.19.1
>>
> 
> Applied to master and next.

Something in this series seems to break basic TPM communication for me.

For TPM2.0s the probe command fails, causing them to be misdetected as 
TPM1.2s:

---
tpm tpm0: tpm_try_transmit: tpm_send: error -5
tpm_tis MSFT0101:00: 1.2 TPM (device-id 0x1A, rev-id 22)
tpm tpm0: A TPM error (30) occurred attempting to determine the timeouts
---
tpm tpm0: tpm_try_transmit: tpm_send: error -5
tpm_tis_spi spi0.1: 1.2 TPM (device-id 0x1B, rev-id 22)
tpm tpm0: A TPM error (30) occurred attempting to determine the timeouts
---

And for something that actually is a TPM1.2 it fails in a similar way:

---
tpm_i2c_infineon 1-0020: 1.2 TPM (device-id 0x1A)
tpm tpm0: A TPM error (-14) occurred attempting to determine the timeouts
---
tpm tpm0: tpm_try_transmit: tpm_send: error -5
tpm_tis_spi spi0.1: 1.2 TPM (device-id 0x1B, rev-id 16)
tpm tpm0: A TPM error (-14) occurred attempting to determine the timeouts
tpm_tis_spi: probe of spi0.1 failed with error -14
---

I see this problem across my entire range of TPM devices and test 
platforms. Any idea what could be wrong here?

Alexander
