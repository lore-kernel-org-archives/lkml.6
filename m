Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFE0C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C615B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C615B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbeIMTAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:00:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:20559 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbeIMTAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:00:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 06:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,369,1531810800"; 
   d="scan'208";a="89706405"
Received: from mylly.fi.intel.com (HELO [10.237.72.64]) ([10.237.72.64])
  by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2018 06:50:30 -0700
Subject: Re: [PATCH v2] i2c: designware: select gpio/default pin when
 prepare/unprepare recovery
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180913162132.17c9c2b3@xhacker.debian>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <d4ebb8a5-9e56-20c5-2bda-03ca2a40378e@linux.intel.com>
Date:   Thu, 13 Sep 2018 16:50:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913162132.17c9c2b3@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/2018 11:21 AM, Jisheng Zhang wrote:
> On some platforms, the sda/scl pins are muxed with gpio functions, so
> they could be used for recovery. Select the gpio/default pin function
> when prepare/unprepare recovery.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
> 
> since v1:
>   - use IS_ERR_OR_NULL
> 
>   drivers/i2c/busses/i2c-designware-core.h   |  3 +++
>   drivers/i2c/busses/i2c-designware-master.c | 22 ++++++++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
...
> +	pinctrl = devm_pinctrl_get(dev->dev);
> +	if (PTR_ERR(pinctrl) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	if (!IS_ERR_OR_NULL(pinctrl)) {
> +		dev->pinctrl = pinctrl;
> +		s = pinctrl_lookup_state(pinctrl, PINCTRL_STATE_DEFAULT);
> +		if (!IS_ERR_OR_NULL(s))
> +			dev->pins_default = s;
> +		s = pinctrl_lookup_state(pinctrl, "gpio");
> +		if (!IS_ERR_OR_NULL(s))
> +			dev->pins_gpio = s;
> +	}
> +

Should these be documented in 
Documentation/devicetree/bindings/i2c/i2c-designware.txt?

-- 
Jarkko
