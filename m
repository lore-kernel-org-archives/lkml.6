Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43588C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17262064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17262064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJOWBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:01:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:17328 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJOWBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:01:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 07:15:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="81346025"
Received: from mylly.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2018 07:15:41 -0700
Subject: Re: [PATCH v3 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
To:     Wolfram Sang <wsa@the-dreams.de>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20181011142911.13750-1-hdegoede@redhat.com>
 <20181011142911.13750-2-hdegoede@redhat.com> <20181014131724.GA863@kunai>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <f040787b-3f64-e338-7a9c-0d44f968f496@linux.intel.com>
Date:   Mon, 15 Oct 2018 17:15:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181014131724.GA863@kunai>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2018 04:17 PM, Wolfram Sang wrote:
> On Thu, Oct 11, 2018 at 04:29:09PM +0200, Hans de Goede wrote:
>> On some BYT/CHT systems the SoC's P-Unit shares the I2C bus with the
>> kernel. The P-Unit has a semaphore for the PMIC bus which we can take to
>> block it from accessing the shared bus while the kernel wants to access it.
>>
>> Currently we have the I2C-controller driver acquiring and releasing the
>> semaphore around each I2C transfer. There are 2 problems with this:
>>
>> 1) PMIC accesses often come in the form of a read-modify-write on one of
>> the PMIC registers, we currently release the P-Unit's PMIC bus semaphore
>> between the read and the write. If the P-Unit modifies the register during
>> this window?, then we end up overwriting the P-Unit's changes.
>> I believe that this is mostly an academic problem, but I'm not sure.
>>
>> 2) To safely access the shared I2C bus, we need to do 3 things:
>> a) Notify the GPU driver that we are starting a window in which it may not
>> access the P-Unit, since the P-Unit seems to ignore the semaphore for
>> explicit power-level requests made by the GPU driver
>> b) Make a pm_qos request to force all CPU cores out of C6/C7 since entering
>> C6/C7 while we hold the semaphore hangs the SoC
>> c) Finally take the P-Unit's PMIC bus semaphore
>> All 3 these steps together are somewhat expensive, so ideally if we have
>> a bunch of i2c transfers grouped together we only do this once for the
>> entire group.
>>
>> Taking the read-modify-write on a PMIC register as example then ideally we
>> would only do all 3 steps once at the beginning and undo all 3 steps once
>> at the end.
>>
>> For this we need to be able to take the semaphore from within e.g. the PMIC
>> opregion driver, yet we do not want to remove the taking of the semaphore
>> from the I2C-controller driver, as that is still necessary to protect many
>> other code-paths leading to accessing the shared I2C bus.
>>
>> This means that we first have the PMIC driver acquire the semaphore and
>> then have the I2C controller driver trying to acquire it again.
>>
>> To make this possible this commit does the following:
>>
>> 1) Move the semaphore code from being private to the I2C controller driver
>> into the generic iosf_mbi code, which already has other code to deal with
>> the shared bus so that it can be accessed outside of the I2C bus driver.
>>
>> 2) Rework the code so that it can be called multiple times nested, while
>> still blocking I2C accesses while e.g. the GPU driver has indicated the
>> P-Unit needs the bus through a iosf_mbi_punit_acquire() call.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> For the record: once the designware maintainers are okay with this
> change, I am also okay with it going via the x86 platform tree.
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
