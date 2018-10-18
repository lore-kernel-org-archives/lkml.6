Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AE6C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B772054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B772054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJSDkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:40:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:17083 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSDkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:40:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 12:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,397,1534834800"; 
   d="scan'208";a="266859868"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.24.10.123]) ([10.24.10.123])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2018 12:38:03 -0700
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
To:     Bart Van Assche <bvanassche@acm.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
 <20181015150926.29520.45280.stgit@localhost.localdomain>
 <1539886275.81977.17.camel@acm.org>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com>
Date:   Thu, 18 Oct 2018 12:38:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539886275.81977.17.camel@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 11:11 AM, Bart Van Assche wrote:
> On Mon, 2018-10-15 at 08:09 -0700, Alexander Duyck wrote:
>> +static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
>> +{
>> +	struct device *dev = _dev;
>> +
>> +	__device_driver_lock(dev, dev->parent);
>> +
>> +	/*
>> +	 * If someone attempted to bind a driver either successfully or
>> +	 * unsuccessfully before we got here we should just skip the driver
>> +	 * probe call.
>> +	 */

The answer to your question below is up here.

>> +	if (!dev->driver) {
>> +		struct device_driver *drv = dev_get_drvdata(dev);
>> +
>> +		if (drv)
>> +			driver_probe_device(drv, dev);
>> +	}
>> +
>> +	__device_driver_unlock(dev, dev->parent);
>> +
>> +	put_device(dev);
>> +
>> +	dev_dbg(dev, "async probe completed\n");
>> +}
>> +
>>   static int __driver_attach(struct device *dev, void *data)
>>   {
>>   	struct device_driver *drv = data;
>> @@ -945,6 +971,25 @@ static int __driver_attach(struct device *dev, void *data)
>>   		return ret;
>>   	} /* ret > 0 means positive match */
>>   
>> +	if (driver_allows_async_probing(drv)) {
>> +		/*
>> +		 * Instead of probing the device synchronously we will
>> +		 * probe it asynchronously to allow for more parallelism.
>> +		 *
>> +		 * We only take the device lock here in order to guarantee
>> +		 * that the dev->driver and driver_data fields are protected
>> +		 */
>> +		dev_dbg(dev, "scheduling asynchronous probe\n");
>> +		device_lock(dev);
>> +		if (!dev->driver) {
>> +			get_device(dev);
>> +			dev_set_drvdata(dev, drv);
>> +			async_schedule(__driver_attach_async_helper, dev);
>> +		}
>> +		device_unlock(dev);
>> +		return 0;
>> +	}
>> +
>>   	device_driver_attach(drv, dev);
> 
> What prevents that the driver pointer becomes invalid after async_schedule() has
> been called and before __driver_attach_async_helper() is called? I think we need
> protection against concurrent driver_unregister() and __driver_attach_async_helper()
> calls. I'm not sure whether that is possible without introducing a new mutex.
> 
> Thanks,
> 
> Bart.

See the spot called out above.

Basically if somebody loads a driver the dev->driver becomes set. If a 
driver is removed it will clear dev->driver and set driver_data to 
0/NULL. That is what I am using as a mutex to track it in conjunction 
with the device mutex. Basically if somebody attempts to attach a driver 
before we get there we just exit and don't attempt to load this driver.

