Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2067CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F5121582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F5121582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeI0QKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:10:06 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:39482 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbeI0QKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:10:05 -0400
Received: from [192.168.1.10] ([80.101.105.217])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 5SyJgvC5DgyCD5SyKgUmn0; Thu, 27 Sep 2018 11:52:37 +0200
Subject: Re: [PATCH 0/2] media: intel-ipu3: allow the media graph to be used
 even if a subdev fails
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
References: <20180904113018.14428-1-javierm@redhat.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <0e31ae40-276e-22be-c6aa-b62f8dbea79e@xs4all.nl>
Date:   Thu, 27 Sep 2018 11:52:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904113018.14428-1-javierm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCg7rBr719AgtAd1kBnW9vWrh4/OBHXY5KotqAcEwE62k9xHcJsuCV6v8EzvL/F047s0jvgeMYCtmnWl4i8MKKin1nhBBbjy2b8wx7uRlYZSfjecsDLj
 0dHqaOX3ry33Pm0vJEwsGYNwPOleE2I0IlTRkCYZfOLJbnUgnUY9NrLV5QBpdARf88YjfThF4u4UHSE+kZeEkx0AVGkNJfM2/rsRSh53PrFw1jxKj7YHJX+k
 E7jjINUGMBIOCxLOcN6o2A4aZnNLuqbqfLE2OrFm4GXrcXl6iMLRmDAowsMrpKLG1nx3TRVJM4tIMtcylF3dvvIhZwMxtsoxHbi4BvYwhznWYmWcn9iQSDrY
 37CMQChRcr3IgpXm2e/Tvo/480/GZRMB0+Gsqu9MzugzvGXNRymH+ZSn4ICd8r/vGpulWWN9YoMACyvX7EJCVSVJbtbI5vTWg2EnK+PBPdYUlHaBD9M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On 09/04/2018 01:30 PM, Javier Martinez Canillas wrote:
> Hello,
> 
> This series allows the ipu3-cio2 driver to properly expose a subset of the
> media graph even if some drivers for the pending subdevices fail to probe.
> 
> Currently the driver exposes a non-functional graph since the pad links are
> created and the subdev dev nodes are registered in the v4l2 async .complete
> callback. Instead, these operations should be done in the .bound callback.
> 
> Patch #1 just adds a v4l2_device_register_subdev_node() function to allow
> registering a single device node for a subdev of a v4l2 device.
> 
> Patch #2 moves the logic of the ipu3-cio2 .complete callback to the .bound
> callback. The .complete callback is just removed since is empy after that.

Sorry, I missed this series until you pointed to it on irc just now :-)

I have discussed this topic before with Sakari and Laurent. My main problem
with this is how an application can discover that not everything is online?
And which parts are offline?

Perhaps a car with 10 cameras can function with 9, but not with 8. How would
userspace know?

I completely agree that we need to support these advanced scenarios (including
what happens when a camera suddenly fails), but it is the userspace aspects
for which I would like to see an RFC first before you can do these things.

Regards,

	Hans

> 
> Best regards,
> Javier
> 
> 
> Javier Martinez Canillas (2):
>   [media] v4l: allow to register dev nodes for individual v4l2 subdevs
>   media: intel-ipu3: create pad links and register subdev nodes at bound
>     time
> 
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c | 66 ++++++-----------
>  drivers/media/v4l2-core/v4l2-device.c    | 90 ++++++++++++++----------
>  include/media/v4l2-device.h              | 10 +++
>  3 files changed, 85 insertions(+), 81 deletions(-)
> 

