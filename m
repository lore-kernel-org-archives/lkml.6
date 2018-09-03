Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457F9C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0871920868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0871920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeICLkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:40:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:41942 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeICLkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:40:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 00:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,324,1531810800"; 
   d="scan'208";a="67954351"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.198]) ([10.238.232.198])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2018 00:21:12 -0700
Subject: Re: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2 async
 notifier complete
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
References: <20180831152045.9957-1-javierm@redhat.com>
From:   Bing Bu Cao <bingbu.cao@linux.intel.com>
Message-ID: <cd307d41-ed19-5ab0-cbdb-a743cdb76e09@linux.intel.com>
Date:   Mon, 3 Sep 2018 15:25:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180831152045.9957-1-javierm@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/31/2018 11:20 PM, Javier Martinez Canillas wrote:
> Commit 9832e155f1ed ("[media] media-device: split media initialization and
> registration") split the media_device_register() function in two, to avoid
> a race condition that can happen when the media device node is accessed by
> userpace before the pending subdevices have been asynchronously registered.
>
> But the ipu3-cio2 driver calls the media_device_register() function right
> after calling media_device_init() which defeats the purpose of having two
> separate functions.
>
> In that case, userspace could have a partial view of the media device if
> it opened the media device node before all the pending devices have been
> bound. So instead, only register the media device once all pending v4l2
> subdevices have been registered.
Javier, Thanks for your patch.
IMHO, there are no big differences for registering the cio2 before and after all the subdevices are ready.
User may see a partial view of media graph but it presents what it really is then.
It indicate that device is not available currently not it is not there.
Could you help tell more details about your problem? The full context is helpful for me to reproduce your problem.
>
> Fixes: 9832e155f1ed ("media: intel-ipu3: cio2: add new MIPI-CSI2 driver")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> index 29027159eced..d936f3426c4e 100644
> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
> @@ -1468,7 +1468,14 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
>  		}
>  	}
>  
> -	return v4l2_device_register_subdev_nodes(&cio2->v4l2_dev);
> +	ret = v4l2_device_register_subdev_nodes(&cio2->v4l2_dev);
> +	if (ret) {
> +		dev_err(&cio2->pci_dev->dev,
> +			"failed to register V4L2 subdev nodes (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return media_device_register(&cio2->media_dev);
>  }
>  
>  static const struct v4l2_async_notifier_operations cio2_async_ops = {
> @@ -1792,16 +1799,12 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
>  	cio2->media_dev.hw_revision = 0;
>  
>  	media_device_init(&cio2->media_dev);
> -	r = media_device_register(&cio2->media_dev);
> -	if (r < 0)
> -		goto fail_mutex_destroy;
> -
>  	cio2->v4l2_dev.mdev = &cio2->media_dev;
>  	r = v4l2_device_register(&pci_dev->dev, &cio2->v4l2_dev);
>  	if (r) {
>  		dev_err(&pci_dev->dev,
>  			"failed to register V4L2 device (%d)\n", r);
> -		goto fail_media_device_unregister;
> +		goto fail_media_device_cleanup;
>  	}
>  
>  	r = cio2_queues_init(cio2);
> @@ -1831,10 +1834,8 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
>  	cio2_queues_exit(cio2);
>  fail_v4l2_device_unregister:
>  	v4l2_device_unregister(&cio2->v4l2_dev);
> -fail_media_device_unregister:
> -	media_device_unregister(&cio2->media_dev);
> +fail_media_device_cleanup:
>  	media_device_cleanup(&cio2->media_dev);
> -fail_mutex_destroy:
>  	mutex_destroy(&cio2->lock);
>  	cio2_fbpt_exit_dummy(cio2);
>  

