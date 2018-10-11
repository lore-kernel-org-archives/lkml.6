Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9639C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818812087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818812087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJKTZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:25:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38540 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeJKTZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:25:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id a13-v6so9375279wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 04:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Deer8wddkzPpEFZ1Ggysg2mwjebzRPxe/eBL0pp0js=;
        b=mRI1BEGbVrHfB7CqmRiOg8V6ozVvzhUZcqZixOiErsW5z1JrySoakMikx3JnkDXQCd
         Ws2H8NIA+dCH9ybVfmd6O1xLrLedayjROs+pGyskA4hJiRIhRUzjXLTWQFXZdCYh81hb
         oEfYYXm+nCX3nfG3ARBNmx1XJ6oOf2Juoh7x5yunZUVj6rZuVKh4gu08UUSKxzCGPf6s
         UEGRtfipMsFQn43KB65518ToL9mr/X+19hKXBkc1c6KqH8SNCHqfm1m6dqsH4vkJpN08
         DnYJyjYoPndNnly6s+7PcwQbRR8tStS3BAzcsWLxVEEdGNyNL+O5ZvivZKIhZnmkFCUy
         Jqng==
X-Gm-Message-State: ABuFfogZ/JRtej+HnGVa8oo+I7BbRbOacrWOxaMKGJSvcA72CB5wXloh
        7NdBDkywEJMdPBUTDAeUEQImMMFUt/E=
X-Google-Smtp-Source: ACcGV61yc2o3RBevuDv69o6iszUp1CoWmY+lnUpc8XFi7faCqVx3yTYdcFu3BkOahAgLR55T2g4hvg==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr1405859wrd.56.1539259104990;
        Thu, 11 Oct 2018 04:58:24 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 67-v6sm18406125wmd.1.2018.10.11.04.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 04:58:24 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20181011102627.7418-1-hdegoede@redhat.com>
 <20181011102627.7418-2-hdegoede@redhat.com>
 <20181011104151.GA31491@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6c7d650d-b65f-da70-ecef-474137369ae3@redhat.com>
Date:   Thu, 11 Oct 2018 13:58:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181011104151.GA31491@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-10-18 12:41, Ingo Molnar wrote:
> 
> * Hans de Goede <hdegoede@redhat.com> wrote:
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
> 
> Isn't this error path leaking the iosf_mbi_punit_mutex held mutex? The 'out' label only unlocks
> iosf_mbi_block_punit_i2c_access_count_mutex:

Yes you're right, I messed this up when adding the handling for the new
iosf_mbi_block_punit_i2c_access_count[_mutex] which is new compared to the
code from i2c-designware-baytrail.c (the rest of the code is just moved
from there).

This is fixed in the upcoming v3 of the patch.

>> +	/* host driver waits for bit 0 to be set in semaphore register */
>> +	start = jiffies;
>> +	end = start + msecs_to_jiffies(SEMAPHORE_TIMEOUT);
>> +	do {
>> +		ret = iosf_mbi_get_sem(&sem);
>> +		if (!ret && sem) {
>> +			iosf_mbi_sem_acquired = jiffies;
>> +			dev_dbg(&mbi_pdev->dev, "punit semaphore acquired after %ums\n",
>> +				jiffies_to_msecs(jiffies - start));
>> +			/*
>> +			 * Success, keep iosf_mbi_punit_mutex locked till
>> +			 * iosf_mbi_unblock_punit_i2c_access() gets called.
>> +			 */
>> +			goto out;
> 
> Ditto - although this does claim that this is done intentionally.

Right, we have 2 sets of functions:

iosf_mbi_punit_acquire()
iosf_mbi_punit_release()

iosf_mbi_block_punit_i2c_access()
iosf_mbi_unblock_punit_i2c_access()

The first 2 are for code which sends request to the P-Unit
which may make it access the shared I2C bus to the PMIC, calling
these will stop any kernel I2C code from accessing the bus.

The latter 2 are for I2C code which wants to access the
shared I2C bus to the PMIC, such as e.g. the fuel-gauge driver,
these block any callers of iosf_mbi_punit_acquire() from
continuing until iosf_mbi_unblock_punit_i2c_access() gets
called.

Basically we have 2 groups of code trying to access the same
shared resource (the PMIC I2C bus), code talking to the P-Unit
(which has its own access to the I2C bus at some level) and
I2C client drivers (or ACPI OpRegions).

If both happen at the same time bad things happen, so we
need to arbitrate and exclusively allow accesses of one kind
at a time. This is implemetned by both type of accesses acquiring
the iosf_mbi_punit_mutex and keeping it locked over the access,
hence the exit from the function keeps the mutex locked on success.

>> +		}
>> +
>> +		usleep_range(1000, 2000);
>> +	} while (time_before(jiffies, end));
>> +
>> +	ret = -ETIMEDOUT;
>> +	dev_err(&mbi_pdev->dev, "Error punit semaphore timed out, resetting\n");
>> +	iosf_mbi_reset_semaphore();
>> +	mutex_unlock(&iosf_mbi_punit_mutex);
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
> 
> So this is a rather unusual looking locking pattern.
> 
> So if this is all intended and works fine then at minimum the semantics of the function should
> be explained - right now it has no description whatsoever.

Ok, for v3 I've added the following comment above the new
iosf_mbi_block_punit_i2c_access() to explain things:

/*
  * This function blocks P-Unit accesses to the PMIC I2C bus, so that kernel
  * I2C code, such as e.g. a fuel-gauge driver, can access it safely.
  *
  * This function may be called by I2C controller code while an I2C driver has
  * already blocked P-Unit accesses because it wants them blocked over multiple
  * i2c-transfers, for e.g. read-modify-write of an I2C client register.
  *
  * The P-Unit accesses already being blocked is tracked through the
  * iosf_mbi_block_punit_i2c_access_count variable which is protected by the
  * iosf_mbi_block_punit_i2c_access_count_mutex this mutex is hold for the
  * entire duration of the function.
  *
  * If access is not blocked yet, this function takes the following steps:
  *
  * 1) Some code sends request to the P-Unit which make it access the PMIC
  *    I2C bus. Testing has shown that the P-Unit does not check its internal
  *    PMIC bus semaphore for these requests. Callers of these requests call
  *    iosf_mbi_punit_acquire()/_release() around their P-Unit accesses, these
  *    functions lock/unlock the iosf_mbi_punit_mutex.
  *    As the first step we lock the iosf_mbi_punit_mutex, to wait for any in
  *    flight requests to finish and to block any new requests.
  *
  * 2) Some code makes such P-Unit requests from atomic contexts where it
  *    cannot call iosf_mbi_punit_acquire() as that may sleep.
  *    As the second step we call a notifier chain which allows any code
  *    needing P-Unit resources from atomic context to acquire them before
  *    we take control over the PMIC I2C bus.
  *
  * 3) When CPU cores enter C6 or C7 the P-Unit needs to talk to the PMIC
  *    if this happens while the kernel itself is accessing the PMIC I2C bus
  *    the SoC hangs.
  *    As the third step we call pm_qos_update_request() to disallow the CPU
  *    to enter C6 or C7.
  *
  * 4) The P-Unit has a PMIC bus semaphore which we can request to stop
  *    autonomous P-Unit tasks from accessing the PMIC I2C bus while we hold it.
  *    As the fourth and final step we request this semaphore and wait for our
  *    request to be acknowledged.
  */

Regards,

Hans

