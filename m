Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4FFC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0B420844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0B420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeKII0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:26:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:53143 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbeKII0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:26:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 14:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,481,1534834800"; 
   d="scan'208";a="272544316"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga005.jf.intel.com with ESMTP; 08 Nov 2018 14:48:59 -0800
Message-ID: <b92d7ea58dafefc30128dacebc6de6fb9c7fa8e8.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v6 3/9] device core: Consolidate locking and
 unlocking of parent and device
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     jane.chu@oracle.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     len.brown@intel.com, bvanassche@acm.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, jiangshanlai@gmail.com,
        linux-nvdimm@lists.01.org, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org
Date:   Thu, 08 Nov 2018 14:48:59 -0800
In-Reply-To: <791408d3-bf97-0f54-adc5-9b06540015c6@oracle.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170041590.12967.4367086895437513524.stgit@ahduyck-desk1.jf.intel.com>
         <791408d3-bf97-0f54-adc5-9b06540015c6@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 14:43 -0800, jane.chu@oracle.com wrote:
> Hi, Alex,
> 
> 
> On 11/08/2018 10:06 AM, Alexander Duyck wrote:
> > +/*
> > + * __device_driver_lock - release locks needed to manipulate dev->drv
> 
> You meant to say __device_driver_unlock, right?

Yes, you are correct.

> > + * @dev: Device we will update driver info for
> > + * @parent: Parent device. Needed if the bus requires parent lock
> > + *
> > + * This function will release the required locks for manipulating dev->drv.
> > + * Normally this will just be the the @dev lock, but when called for a
> > + * USB interface, @parent lock will be released as well.
> > + */
> > +static void __device_driver_unlock(struct device *dev, struct device *parent)
> > +{
> > +	device_unlock(dev);
> > +	if (parent && dev->bus->need_parent_lock)
> > +		device_unlock(parent);
> > +}
> 
> -jane

Thanks.

- Alex

