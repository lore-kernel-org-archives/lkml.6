Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HW+DNP79GFt+GQAAmS7hNA
	; Thu, 07 Jun 2018 09:43:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 811DD607F7; Thu,  7 Jun 2018 09:43:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EAF3A605A2;
	Thu,  7 Jun 2018 09:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAF3A605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753593AbeFGJnX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:43:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49358 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeFGJnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:43:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C02615AB;
        Thu,  7 Jun 2018 02:43:21 -0700 (PDT)
Received: from [10.37.9.91] (unknown [10.37.9.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27D1F3F5A0;
        Thu,  7 Jun 2018 02:43:15 -0700 (PDT)
Subject: Re: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
To: Kim Phillips <kim.phillips@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        Todd Kjos <tkjos@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com>
 <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <30e98462-237f-df2f-39d9-f0414f52b950@arm.com>
Date: Thu, 7 Jun 2018 10:43:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180606155501.704583e1412996a1a2c6fa61@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 09:55 PM, Kim Phillips wrote:
> On Wed, 6 Jun 2018 10:46:36 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> 
>> And while we are at this, I also realised that we hold references to the
>> parent devices for each connection (via bus_find_device() from
>> of_coresight_get_endpoint_device()), while parsing the platform data,
>> which is never released.
> 
> Would this fix that?:

Not completely. We store the dev_name() as a reference, which itself can 
be free'd, when the device is gone. I have a fix for this in my next
version of the DT clean up series [0], where I clean up most of the
platform parsing code.


[0] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582904.html

Cheers
Suzuki

> 
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index a33a92ebe74b..a43ab078c85e 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -181,6 +181,8 @@ of_get_coresight_platform_data(struct device *dev,
>                          pdata->child_names[i] = dev_name(rdev);
>                          pdata->child_ports[i] = rendpoint.id;
>   
> +                       put_device(rdev);
> +
>                          i++;
>                  } while (ep);
>          }
