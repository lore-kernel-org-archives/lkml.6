Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E897C282E6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AA02084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfAUHve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:51:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:43657 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbfAUHvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:51:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2019 23:51:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,502,1539673200"; 
   d="scan'208";a="136376927"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.37])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2019 23:51:31 -0800
Date:   Mon, 21 Jan 2019 15:51:02 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
Message-ID: <20190121075102.GA3758@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:47:23PM -0800, Dan Williams wrote:
>In recent days, 2 engineers, including the original author of
>nd_pfn_init(), overlooked the internal call to nd_pfn_validate() and the
>implications to memory allocation.
>
>Clarify this situation to help anyone that reads through this code in
>the future.
>
>Reported-by: Wei Yang <richardw.yang@linux.intel.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>---
> drivers/nvdimm/btt_devs.c |    5 +++++
> drivers/nvdimm/dax_devs.c |    5 +++++
> drivers/nvdimm/pfn_devs.c |   21 +++++++++++++++++++++
> 3 files changed, 31 insertions(+)
>
>diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
>index 795ad4ff35ca..e0a6f2491e57 100644
>--- a/drivers/nvdimm/btt_devs.c
>+++ b/drivers/nvdimm/btt_devs.c
>@@ -354,6 +354,11 @@ int nd_btt_probe(struct device *dev, struct nd_namespace_common *ndns)
> 		put_device(btt_dev);
> 	}
> 
>+	/*
>+	 * Successful probe indicates to the caller that an nd_btt
>+	 * personality device has been registered and the caller can
>+	 * fail the probe of the baseline namespace device.
>+	 */
> 	return rc;
> }
> EXPORT_SYMBOL(nd_btt_probe);
>diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
>index 0453f49dc708..65010d955fa7 100644
>--- a/drivers/nvdimm/dax_devs.c
>+++ b/drivers/nvdimm/dax_devs.c
>@@ -136,6 +136,11 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
> 	} else
> 		__nd_device_register(dax_dev);
> 
>+	/*
>+	 * Successful probe indicates to the caller that a device-dax
>+	 * personality device has been registered and the caller can
>+	 * fail the probe of the baseline namespace device.
>+	 */
> 	return rc;
> }
> EXPORT_SYMBOL(nd_dax_probe);
>diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
>index 6f22272e8d80..a8783b5a76ba 100644
>--- a/drivers/nvdimm/pfn_devs.c
>+++ b/drivers/nvdimm/pfn_devs.c
>@@ -576,6 +576,11 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
> 	} else
> 		__nd_device_register(pfn_dev);
> 
>+	/*
>+	 * Successful probe indicates to the caller that an nd_pfn
>+	 * personality device has been registered and the caller can
>+	 * fail the probe of the baseline namespace device.
>+	 */
> 	return rc;
> }
> EXPORT_SYMBOL(nd_pfn_probe);
>@@ -706,6 +711,22 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> 		sig = DAX_SIG;
> 	else
> 		sig = PFN_SIG;
>+
>+	/*
>+	 * Check for an existing 'pfn' superblock before writing a new
>+	 * one. The intended flow is that on the first probe of an
>+	 * nd_{pfn,dax} device the superblock is calculated and written
>+	 * to the namespace. In this case nd_pfn_validate() returns
>+	 * -ENODEV because no valid superblock exists currently.
>+	 *
>+	 * On subsequent probes nd_pfn_validate() will find a valid
>+	 * superblock and return 0.
>+	 *
>+	 * If an assumption of the superblock has been violated, like a
>+	 * change to the physical alignment of the namespace,
>+	 * nd_pfn_validate() will return an error other than -ENODEV to
>+	 * fail probing.
>+	 */

Let me reply in this thread. Sorry for my poor understand, I don't get it
clearly now.

To be honest, the structure is a little bit complicated, if my understanding
is not correct, please forgive my poor understand.

Below is a code flow. To simply analysis, I setup kernel parameter memmap to
emulate, and configure one namespace to mode devdax. So that we would have the
same root for code flow.

Let's start with nd_region_driver:

    nd_region_probe
        nd_region_register_namespaces
	    create_namespaces
	nd_region->btt_seed = nd_btt_create(nd_region);
	nd_region->pfn_seed = nd_pfn_create(nd_region);
	nd_region->dax_seed = nd_dax_create(nd_region);

After this, there are 4 devices created:

	namespace0.0, btt0.0, pfn0.0, dax0.0

And there are two drivers related to these devices. The relationship between
devices and drivers are:

	nd_pmem_driver: namespace0.0, btt0.0, pfn0.0
	dax_pmem_driver: dax0.0

Only the probe function on namespace0.0 succeed. Even others get -ENODEV,
those devices themself is not released.

Then let's look at the probe on namespace0.0:

    nd_pmem_probe
        nd_btt_probe
	nd_pfn_probe
	nd_dax_probe

When namespace is configured as devdax, only nd_dax_probe do some real work.

Then I see some different behavior as your description.

    * nd_dax_probe->nd_pfn_validate() return 0 instead of -ENODEV.
    * so device dax0.1 is created
    * dax_pmem_probe is called on dax0.1 and nd_pfn_validate() return 0 too

This means pfn_sb is created twice in following functions:

    * nd_dax_probe
    * dax_pmem_probe

Also, I have one confusion about your saying: two probes.

If the two probes are:

    * for dax%d.%d: 1. nd_dax_probe 2. dax_pmem_probe   
    * for pfn%d.%d: 1. nd_pfn_probe 2. nd_pmem_probe    

Then, if the first probe fails, the device itself would be destroyed. How the
second probe do its job?

> 	rc = nd_pfn_validate(nd_pfn, sig);
> 	if (rc != -ENODEV)
> 		return rc;

-- 
Wei Yang
Help you, Help me
