Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ADEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D62220883
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391442AbfAOXcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:32:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:42108 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbfAOXce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:32:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 15:32:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,483,1539673200"; 
   d="scan'208";a="267421640"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga004.jf.intel.com with ESMTP; 15 Jan 2019 15:32:34 -0800
Subject: Re: [PATCH i2c-next v9 0/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
 <20190115224713.duoha332mjlrmwji@ninjato>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <ae348673-f6d5-36ac-a1f2-872d0bab06b1@linux.intel.com>
Date:   Tue, 15 Jan 2019 15:32:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190115224713.duoha332mjlrmwji@ninjato>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/2019 2:47 PM, Wolfram Sang wrote:
> On Tue, Oct 30, 2018 at 02:09:11PM -0700, Jae Hyun Yoo wrote:
>> In multi-master environment, this driver's master cannot know
>> exactly when a peer master sends data to this driver's slave so a
>> case can be happened that this master tries to send data through
>> the master_xfer function but slave data from peer master is still
>> being processed by this driver. To prevent state corruption in the
>> case, this patch adds checking code if any slave operation is
>> ongoing and it waits up to the bus timeout duration before starting
>> a master_xfer operation.
>>
>> To support this change, it introduces changes on i2c-core-base to
>> make that able to read the bus timeout and master transfer retries
>> count values from device tree properties.
>>
>> Please review this patch set.
> 
> Marking this as "Changes requested". I think if the mutex approach
> works, these patches become obsolete then.
> 

Hi Wolfram,

Thanks for your touching base. I made and tested a new patch in my
local. Actually, I couldn't use a mutex because it should provide
locking between driver context and interrupt context. Instead, after
taking lots of experiments, I checked that idle waiting can be supported
by this H/W so I didn't need to use any locking method in the driver
code for multi-master handling. I'll submit a new patch tomorrow using a
different thread. Please drop this patch set.

Thanks,
Jae
