Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFC8C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DEA20856
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfACCv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 21:51:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:39257 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfACCv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 21:51:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 18:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,433,1539673200"; 
   d="scan'208";a="115046330"
Received: from dliu15-mobl5.ccr.corp.intel.com ([10.249.175.141])
  by orsmga003.jf.intel.com with ESMTP; 02 Jan 2019 18:51:24 -0800
Message-ID: <1546483882.2077.10.camel@intel.com>
Subject: Re: [PATCH V2] thermal: Fix locking in cooling device sysfs update
 cur_state
From:   Zhang Rui <rui.zhang@intel.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 03 Jan 2019 10:51:22 +0800
In-Reply-To: <5C2D7376.3010408@linaro.org>
References: <1543358591-25189-1-git-send-email-thara.gopinath@linaro.org>
         <5C2D7376.3010408@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2019-01-02 at 21:29 -0500, Thara Gopinath wrote:
> On 11/27/2018 05:43 PM, Thara Gopinath wrote:
> > 
> > Sysfs interface to update cooling device cur_state does not
> > currently holding cooling device lock sometimes leading to
> > stale values in cur_state if getting updated simultanelously
> > from user space and thermal framework. Adding the proper locking
> > code fixes this issue.
> > 
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > ---
> > 
> > V1->V2: Rearranged the code as per Daniel's  review comment 
> Hi Eduardo, Daniel
> 
> Any comments on this ?
> 
it's already in my tree, and will be included in my pull request which
will be sent out soon.

thanks,
rui

> Regards
> Thara
> 
> > 
> > 
> >  drivers/thermal/thermal_sysfs.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_sysfs.c
> > b/drivers/thermal/thermal_sysfs.c
> > index 2241cea..aa99edb 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -712,11 +712,14 @@ cur_state_store(struct device *dev, struct
> > device_attribute *attr,
> >  	if ((long)state < 0)
> >  		return -EINVAL;
> >  
> > +	mutex_lock(&cdev->lock);
> > +
> >  	result = cdev->ops->set_cur_state(cdev, state);
> > -	if (result)
> > -		return result;
> > -	thermal_cooling_device_stats_update(cdev, state);
> > -	return count;
> > +	if (!result)
> > +		thermal_cooling_device_stats_update(cdev, state);
> > +
> > +	mutex_unlock(&cdev->lock);
> > +	return result ? result : count;
> >  }
> >  
> >  static struct device_attribute
> > 
> 
> 
