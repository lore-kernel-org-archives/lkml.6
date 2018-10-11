Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DAA21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DAA21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJKRlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:41:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44008 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbeJKRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:41:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so9004783wrt.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 03:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=niAD3yPNwr9gNcdDpTJmCQL73bFMxXwE8Gvk/WIdiJI=;
        b=QDiqX85qY4zCtPPfwJuL01ccbUP4l1Qk4qMpoiGw1XlR/pqiqYlGxxkpLMTsaGZg3O
         x6uV9pgod7Fi75HTXJCEP5Y52Vvb30uz9wWiPpZo6GX9Q20Lmun85BJ6VDXxBCB6JJMM
         w1nXBK9RHm0r8u0SWfZE4W8m2PYtWBES3dKqWNM3qNsVPRFUFUAqkpEbrFtvtBfMQjz5
         BXe+uSbg7a4+FDM4O9pj09aFVGSrsLakSDhgvIYRsmD7im/cV+ofLJg0rWVT5jiJ7wln
         gxUtI2gnF7iQCRSPn2slfsbMwJb1WdOYzR2zwhXKreWNfNbkEOXjb4yGJHbcZ2ali85d
         EeLg==
X-Gm-Message-State: ABuFfoi6R+03LIpFWqOgkoiiapmN/+lWlZrGWhssPao0J27jRruHrEOh
        bxcvP2R2m5M/5B8A8tj/ZH6C82V1S30=
X-Google-Smtp-Source: ACcGV62k6zGXOKlAsk6RSCaUYnIZwdKvJcnOgy5FUOkGMmU+YUxbKW7elyx7eVQrOpPbE8UlXNkItQ==
X-Received: by 2002:adf:c793:: with SMTP id l19-v6mr970709wrg.230.1539252868496;
        Thu, 11 Oct 2018 03:14:28 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id v1-v6sm22800641wrd.24.2018.10.11.03.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 03:14:27 -0700 (PDT)
Subject: Re: [PATCH 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-acpi@vger.kernel.org,
        linux-i2c@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20180923144510.4564-1-hdegoede@redhat.com>
 <20180923144510.4564-2-hdegoede@redhat.com>
 <20180924094855.GH15943@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5f47d8ed-0c69-25b3-4eb8-fb92e90699a6@redhat.com>
Date:   Thu, 11 Oct 2018 12:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180924094855.GH15943@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24-09-18 11:48, Andy Shevchenko wrote:
> On Sun, Sep 23, 2018 at 04:45:08PM +0200, Hans de Goede wrote:
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
>> ---
>> Note this commit deliberately limits the i2c-designware changes to
>> only touch i2c-designware-baytrail.c, deliberately not doing some cleanups
>> which become possible after removing the semaphore code from the
>> i2c-designmware code. This is done so that this commit can be merged
>> through the x86 tree without causing conflicts in the i2c tree.
>>
>> The cleanups to the i2c-designware tree will be done in a follow up
>> patch which can be merged once this commit is in place.
> 
>> +static void iosf_mbi_reset_semaphore(void)
>> +{
>> +	if (iosf_mbi_modify(BT_MBI_UNIT_PMC, MBI_REG_READ,
>> +			    iosf_mbi_sem_address, 0, PUNIT_SEMAPHORE_BIT))
>> +		dev_err(&mbi_pdev->dev, "Error punit semaphore reset failed\n");
>> +
>> +	pm_qos_update_request(&iosf_mbi_pm_qos, PM_QOS_DEFAULT_VALUE);
>> +
>> +	blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
>> +				     MBI_PMIC_BUS_ACCESS_END, NULL);
> 
>> +	mutex_unlock(&iosf_mbi_punit_mutex);
> 
> Can we actually move this to the callers?
> To me sounds slightly more logical to see lock in *block*() call and unlock in
> *unblock*() respectively.

Done for v2, which I will send out as soon as I've ran some tests with it.

>> +}
> 
>> +int iosf_mbi_block_punit_i2c_access(void)
>> +{
>> +	unsigned long start, end;
>> +	int ret = 0;
>> +	u32 sem;
>> +
>> +	if (WARN_ON(!mbi_pdev || !iosf_mbi_sem_address))
>> +		return -ENXIO;
>> +
>> +	mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
>> +
>> +	if (iosf_mbi_block_punit_i2c_access_count > 0)
>> +		goto out;
>> +
>> +	mutex_lock(&iosf_mbi_punit_mutex);
>> +	blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
>> +				     MBI_PMIC_BUS_ACCESS_BEGIN, NULL);
>> +
>> +	/*
>> +	 * Disallow the CPU to enter C6 or C7 state, entering these states
>> +	 * requires the punit to talk to the pmic and if this happens while
>> +	 * we're holding the semaphore, the SoC hangs.
>> +	 */
>> +	pm_qos_update_request(&iosf_mbi_pm_qos, 0);
>> +
>> +	/* host driver writes to side band semaphore register */
>> +	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
>> +			     iosf_mbi_sem_address, PUNIT_SEMAPHORE_ACQUIRE);
>> +	if (ret) {
>> +		dev_err(&mbi_pdev->dev, "Error punit semaphore request failed\n");
>> +		goto out;
>> +	}
>> +
>> +	/* host driver waits for bit 0 to be set in semaphore register */
>> +	start = jiffies;
>> +	end = start + msecs_to_jiffies(SEMAPHORE_TIMEOUT);
>> +	do {
>> +		ret = iosf_mbi_get_sem(&sem);
>> +		if (!ret && sem) {
>> +			iosf_mbi_sem_acquired = jiffies;
>> +			dev_dbg(&mbi_pdev->dev, "punit semaphore acquired after %ums\n",
>> +				jiffies_to_msecs(jiffies - start));
>> +			goto out; /* Success, done. */
>> +		}
>> +
>> +		usleep_range(1000, 2000);
>> +	} while (time_before(jiffies, end));
>> +
>> +	ret = -ETIMEDOUT;
>> +	dev_err(&mbi_pdev->dev, "Error punit semaphore timed out, resetting\n");
>> +	iosf_mbi_reset_semaphore();
>> +
>> +	if (!iosf_mbi_get_sem(&sem))
>> +		dev_err(&mbi_pdev->dev, "PUNIT SEM: %d\n", sem);
>> +out:
>> +	if (!WARN_ON(ret))
>> +		iosf_mbi_block_punit_i2c_access_count++;
>> +
>> +	mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(iosf_mbi_block_punit_i2c_access);
>> +
>> +void iosf_mbi_unblock_punit_i2c_access(void)
>> +{
>> +	mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
>> +
>> +	iosf_mbi_block_punit_i2c_access_count--;
>> +	if (iosf_mbi_block_punit_i2c_access_count == 0) {
>> +		iosf_mbi_reset_semaphore();
>> +		dev_dbg(&mbi_pdev->dev, "punit semaphore held for %ums\n",
>> +			jiffies_to_msecs(jiffies - iosf_mbi_sem_acquired));
>> +	}
>> +
>> +	mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
>> +}
>> +EXPORT_SYMBOL(iosf_mbi_unblock_punit_i2c_access);
> 
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_BAYTRAIL),
>> +	  .driver_data = PUNIT_SEMAPHORE_BYT },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_BRASWELL),
>> +	  .driver_data = PUNIT_SEMAPHORE_CHT },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_QUARK_X1000) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_TANGIER) },
>>   	{ 0, },
> 
> Perhaps it can be converted to use PCI_DEVICE_DATA() macro.

Also done for v2.

Regards,

Hans
