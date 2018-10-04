Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911D3C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEF0206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEF0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJDXUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:20:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:61092 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbeJDXUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:20:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 09:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,340,1534834800"; 
   d="scan'208";a="97435716"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2018 09:26:02 -0700
Subject: Re: [PATCH i2c-next v5 2/5] i2c: Add support for 'timeout-ms' and
 '#retries' OF properties
To:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
 <20181003223107.16133-3-jae.hyun.yoo@linux.intel.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <1832adbf-fa95-ccfc-00e5-63568059bcd1@linux.intel.com>
Date:   Thu, 4 Oct 2018 09:26:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003223107.16133-3-jae.hyun.yoo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1214,6 +1214,7 @@ EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
>   static int i2c_register_adapter(struct i2c_adapter *adap)
>   {
>   	int res = -EINVAL;
> +	u32 timeout_ms;

Will change it to:

u32 timeout_ms = 0;

>   
>   	/* Can't register until after driver model init */
>   	if (WARN_ON(!is_registered)) {
> @@ -1239,8 +1240,21 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>   	INIT_LIST_HEAD(&adap->userspace_clients);
>   
>   	/* Set default timeout to 1 second if not already set */
> -	if (adap->timeout == 0)
> -		adap->timeout = HZ;
> +	if (adap->timeout == 0) {
> +		if (adap->dev.of_node)
> +			res = of_property_read_u32(adap->dev.of_node,
> +						   "timeout-ms",
> +						   &timeout_ms);
> +		if (res)
> +			timeout_ms = 0;
> +

Also, it should be:

if (adap->dev.of_node)
	of_property_read_u32(adap->dev.of_node, "timeout-ms",
			     &timeout_ms);

Will submit a new patch set.

Thanks,
Jae

> +		adap->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : HZ;
> +	}
> +
> +	/* Set retries value if it has the OF property */
> +	if (adap->dev.of_node)
> +		of_property_read_u32(adap->dev.of_node, "#retries",
> +				     &adap->retries);
>   
>   	/* register soft irqs for Host Notify */
>   	res = i2c_setup_host_notify_irq_domain(adap);
> 
