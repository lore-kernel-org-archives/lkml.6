Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3967EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE0920883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE0920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeIQVty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:49:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53591 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeIQVtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:49:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id b19-v6so10353494wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 09:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tZCKb/5OQijuj6vU4V/srB7PftBO1bFcau519IGbvAs=;
        b=luk+gYGATZt8o274ATnOb/o0h842iIEn6V9wX4rCU2lyJFnNBJdU+w7pT6+BQn6/RU
         S6ZYcIq+Jwb/ny+pl+H/MuNPNVRODCQa0nAUEtTECIGfKrymWTndTxXMoOEH9MvmZWON
         zLr8Wpwao6BTWu4BS4C94T8yKCxnX8L9jjWiBcKW3qsu4BDqFQagJu6Ix83SMRkLH4o0
         HeKpOnypWzfxgk9Doc9eXXBUUaei6G0LT8nHrnVHF6VEdff+wQlmmkvR5yv8xhCsbHHJ
         nF/gDKWyMqZppe0YMPa+5o2EiHh/fuFskotI7YonDsm3EZxTiYQduLvaR1ri+gX60tN6
         +9Rg==
X-Gm-Message-State: APzg51AHuNKK0dRNz+bOwAf61EKtpTnPBwoCy7Enwpw7ykypN3hdQY/n
        dtfMPzvgR3KYDyJR5SdcqHBU/g==
X-Google-Smtp-Source: ANB0VdZbnhrHWgtxoTZ+WNt1xqABiHM+K76GWzkUqvYTZz5tEL4QxMmoAPs+IJa/xTrHXw3jF24f8w==
X-Received: by 2002:a1c:c019:: with SMTP id q25-v6mr12373015wmf.148.1537201308757;
        Mon, 17 Sep 2018 09:21:48 -0700 (PDT)
Received: from [192.168.1.13] ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id u40-v6sm20175656wrc.43.2018.09.17.09.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 09:21:48 -0700 (PDT)
Subject: Re: [PATCH 0/2] media: intel-ipu3: allow the media graph to be used
 even if a subdev fails
To:     linux-kernel@vger.kernel.org
Cc:     Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
References: <20180904113018.14428-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <4e2acf4a-e466-c830-35e0-69a653c797ff@redhat.com>
Date:   Mon, 17 Sep 2018 18:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180904113018.14428-1-javierm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tianshu and Sakari,

On 9/4/18 1:30 PM, Javier Martinez Canillas wrote:
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

Any comments about these patches?

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
