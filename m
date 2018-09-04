Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A2EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1A62075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1A62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeIDLKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:10:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:59635 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbeIDLKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:10:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 23:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="68187362"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2018 23:46:06 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 454292069E; Tue,  4 Sep 2018 09:46:05 +0300 (EEST)
Date:   Tue, 4 Sep 2018 09:46:05 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Qiu, Tian Shu" <tian.shu.qiu@intel.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Bing Bu Cao <bingbu.cao@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Zheng, Jian Xu" <jian.xu.zheng@intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Cao, Bingbu" <bingbu.cao@intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2 async
 notifier complete
Message-ID: <20180904064605.6prcawieb4ooxtyl@paasikivi.fi.intel.com>
References: <20180831152045.9957-1-javierm@redhat.com>
 <cd307d41-ed19-5ab0-cbdb-a743cdb76e09@linux.intel.com>
 <c1e54228-a21a-b4a2-1083-c75b2dda797c@redhat.com>
 <b15b236e-e0a7-8b2f-1e1f-196c9dc04f4d@linux.intel.com>
 <44eb94a8-3712-155b-b3ab-35538f5b6b38@redhat.com>
 <F4B393EC1A37C8418714AECDAAEF72A93C9A39FC@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F4B393EC1A37C8418714AECDAAEF72A93C9A39FC@shsmsx102.ccr.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier, Tian Shu,

On Tue, Sep 04, 2018 at 05:01:56AM +0000, Qiu, Tian Shu wrote:
> Hi,
> 
> Raise my point.
> The case here is that we have multiple sensors connected to CIO2. The sensors work independently. So failure on one sensor should not block the function of the other.
> That is, we should not rely on that all sensors are ready before allowing user to operate on the ready cameras.
> Sometimes due to hardware issues or incompleteness, we did met the case that one sensor is not probing properly. And in this case, the current implementation blocks us using the working one.
> What I can think now to solve this are:
> 1. Register multiple media devices. One for each sensor path. This will increase media device count.
> 2. Use .bound callback to create the link and register the subdev node for each sensor. Leave .complete empty.
>      Not sure if this breaks the rule of media framework. And also have not found an API to register one single subdev node.

I'd prefer to keep the driver as-is.

Even if the media device is only created once all the sub-devices are
around, the devices are still created one by one so there's no way to
prevent the user space seeing a partially registered media device complex.

In general that doesn't happen as the sensors are typically registered
early during system boot.

Javier is right in asking a way for the user to know whether everything is
fully initialised. That should be added but I don't think it is in any way
specific to the cio2 driver.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
