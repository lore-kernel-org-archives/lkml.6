Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A38C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2C214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE2C214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbeHPMHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:07:20 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:57198 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390308AbeHPMHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:07:19 -0400
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51306 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1fqEID-0004R5-Li; Thu, 16 Aug 2018 11:10:09 +0200
Subject: Re: [PATCH10 3/3] ARM:drm ivip Intel FPGA Video and Image Processing
 Suite
To:     "Ong, Hean Loong" <hean.loong.ong@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Vandervennet, Yves" <yves.vandervennet@intel.com>
References: <1534237029-2648-1-git-send-email-hean.loong.ong@intel.com>
 <1534237029-2648-4-git-send-email-hean.loong.ong@intel.com>
 <28d5e08c-4ae2-2d09-6ce4-985578535d34@tronnes.org>
 <1534408434.3432.3.camel@intel.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <d25039b3-9b7f-e36d-5b87-970e11232530@tronnes.org>
Date:   Thu, 16 Aug 2018 11:10:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534408434.3432.3.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 16.08.2018 10.33, skrev Ong, Hean Loong:
> On Wed, 2018-08-15 at 14:26 +0200, Noralf Trønnes wrote:
>> Den 14.08.2018 10.57, skrev Hean-Loong, Ong:
>>> From: Ong Hean Loong <hean.loong.ong@intel.com>
>>>
>>> Driver for Intel FPGA Video and Image Processing Suite Frame Buffer
>>> II.
>>> The driver only supports the Intel Arria10 devkit and its variants.
>>> This driver can be either loaded staticlly or in modules.
>>> The OF device tree binding is located at:
>>> Documentation/devicetree/bindings/display/altr,vip-fb2.txt
>>>
>>> Signed-off-by: Ong Hean Loong <hean.loong.ong@intel.com>
>>> ---

<snip>

>>> +int intelvipfb_probe(struct device *dev)
>>> +{
>>> +	int retval;
>>> +	struct drm_device *drm;
>>> +	struct intelvipfb_priv *fbpriv = dev_get_drvdata(dev);
>>> +	struct drm_connector *connector;
>>> +	u32 formats[] = {DRM_FORMAT_XRGB8888};
>>> +
>>> +	drm = fbpriv->drm;
>>> +
>>> +	drm->dev_private = fbpriv;
>>> +
>>> +	intelvipfb_setup_mode_config(drm);
>>> +
>>> +	connector = intelvipfb_conn_setup(drm);
>>> +	if (!connector) {
>>> +		dev_err(drm->dev, "Connector setup failed\n");
>>> +		goto err_mode_config;
>>> +	}
>>> +
>>> +	retval = drm_simple_display_pipe_init(drm, &fbpriv->pipe,
>>> +					      &fbpriv_funcs,
>>> formats,
>>> +			ARRAY_SIZE(formats), NULL, connector);
>>> +	if (retval < 0) {
>>> +		dev_err(drm->dev, "Cannot setup simple display
>>> pipe\n");
>>> +		goto err_mode_config;
>>> +	}
>>> +
>>> +	fbpriv->fbcma = drm_fbdev_cma_init(drm,
>>> +			drm->mode_config.preferred_depth,
>>> +			drm->mode_config.num_connector);
>> Please use drm_fbdev_generic_setup() for fbdev emulation. It tears
>> down
>> automatically on drm_dev_unregister() and you don't need the
>> drm_driver->lastclose hook.
>>
>> All drivers that use drm_fbdev_cma_init() will move to this shortly.
>>
>> Noralf.
>>
> I could not find any examples that currently uses
> the drm_fbdev_generic_setup (). Would you mind pointing me on where
> such examples are available that would allow me to replace the
> assignment of the fbcma pointer with drm_fbdev_generic_setup() method

This is the only one converted so far:
Commit: dff1c7032ffea20cca2ad3973ed4c69c8182683d
drm/tinydrm: Use drm_fbdev_generic_setup()

Noralf.

