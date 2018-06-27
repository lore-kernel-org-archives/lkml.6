Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38097C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD30E23EA2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD30E23EA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934879AbeF0SB4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:01:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:24946 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934333AbeF0SBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:01:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 11:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,280,1526367600"; 
   d="scan'208";a="61936094"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.149]) ([10.7.153.149])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2018 11:01:53 -0700
Subject: Re: [PATCH] i2c: aspeed: Improve driver to support multi-master use
 cases stably
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20180626165812.4141-1-jae.hyun.yoo@linux.intel.com>
 <60d0dad1-b735-0650-47b4-40c57b1a5209@linux.intel.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <c1c361de-32a7-83b6-4d48-ad0750c6218b@linux.intel.com>
Date:   Wed, 27 Jun 2018 11:01:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <60d0dad1-b735-0650-47b4-40c57b1a5209@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

Thanks for the review. Please see my answer below.

On 6/27/2018 12:48 AM, Jarkko Nikula wrote:
> Hi
> 
> On 06/26/2018 07:58 PM, Jae Hyun Yoo wrote:
>> BMC firmware should support some multi-master use cases such as 
>> multi-node,
>> IPMB, BMC-ME link and so on but the current ASPEED I2C driver is a bit
>> unstable for the multi-master use case. So this patch improves ASPEED I2C
>> driver to support the multi-master use case stably.
>>
>> Changes:
>> * Added XFER_MODE status register checking logic into
>>    aspeed_i2c_master_xfer to improve the current bus busy checking logic.
>> * Changed the order of enum aspeed_i2c_master_state and
>>    enum aspeed_i2c_slave_state defines to make their initial values 
>> set to
>>    ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
>>    In case of multi-master use with previous code, if a slave data comes
>>    ahead of the first master xfer, master_state starts from an invalid
>>    state. This change fixed the issue.
>> * Adjusted spin_lock scope to make it wrap the whole irq handler using
>>    a single lock and unlock pair covers both master and slave handlers.
>> * Added irq_status variable as a member of the struct aspeed_i2c_bus to
>>    collect handled interrupt bits throughout the master and the slave irq
>>    handlers.
>> * Added control logic to put an order on calling the master and the slave
>>    irq handlers based on their current states.
>>
> This does many unrelated looking changes in one patch making it more 
> vulnerable for potential multiple regressions. For instance busy 
> checking goes from single read to loop with 250 ms timeout in this patch 
> while changing also spin lock logic and interrupt handling.
> 
> Now if there is some regression it might be difficult to find what 
> change in this patch is causing it and more over things goes more 
> complicated if some other kind of regressions are found pointing into 
> the same commit.
> 
> I suggest splitting this into multiple smaller patches. For instance 
> having first simple conversions patches that are unlikely to cause a 
> regression like one patch adding '\n' to error print, another moving 
> irq_status variable into struct aspeed_i2c_bus and so on followed by 
> patches that change logic like busy checking, spin lock change and then 
> patch or more for multi-master support.
> 

Yes, that makes sense and I agree with you. I'll split out this patch
into multiple smaller patches as you suggested.

Thanks,

Jae
