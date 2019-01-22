Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F1EC282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7587020870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfAVDOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:14:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:39474 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfAVDOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:14:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 19:14:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,504,1539673200"; 
   d="scan'208";a="293315290"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.37])
  by orsmga005.jf.intel.com with ESMTP; 21 Jan 2019 19:14:06 -0800
Date:   Tue, 22 Jan 2019 11:13:38 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
Message-ID: <20190122031338.GA3983@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190121075102.GA3758@richard>
 <20190122002915.GA5984@richard>
 <CAPcyv4gANCKeEE5xgC9W99XdiR+rNyN5TEzho18039S2+7TaPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gANCKeEE5xgC9W99XdiR+rNyN5TEzho18039S2+7TaPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 04:45:46PM -0800, Dan Williams wrote:
>On Mon, Jan 21, 2019 at 4:30 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>>
>> May I ask a question about the purpose to create these three device here?
>>
>> I see nd_pfn_create() doesn't allocate pfn_sb here, and the probe on these
>> devices failed. Confused why we need these three devices.
>
>These allow for the namespace creation flow. Namespace creation with
>the pfn personality, for example, goes like this:
>
>1/ Find available region capacity
>
>2/ Allocate capacity to a namespace
>
>3/ Assign that namespace to a free pfn instance
>echo namespace0.0 > /sys/bus/nd/devices/pfn0.0/namespace
>

Here we use __nd_attach_ndns() connect pfn0.0 with namespace0.0

>4/ Start the pfn0.0 device
>echo pfn0.0 > /sys/bus/nd/drivers/nd_pmem/bind
>

Here we trigger nd_pmem_probe() and call pmem_attach_disk() for device pfn0.0,
because this is a pfn device.

>5/ At this point nd_pfn_validate() returns -ENODEV, so the driver
>writes the configuration to the device to be autodetected next time.
>

Then it go through pmem_attach_disk()->nvdimm_setup_pfn()->nd_pfn_init().

The return value -ENODEV leads nd_pfn_init() to configuration write.

Everything looks good here, but I am lost at "Autodetected next time". Because
the driver will continue to finish its work and attach pfn0.0.

Do we need another autodetect? Or you mean after driver detach or reboot? So
nd_pfn_validate() will not return -ENODEV, as it has already configured well.

>This explicit force binding operation is how the driver determines the
>difference between the namespace creation case and the namespace
>auto-probing case at the next driver load.


-- 
Wei Yang
Help you, Help me
