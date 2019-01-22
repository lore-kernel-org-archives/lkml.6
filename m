Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40D62082C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfAVDgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:36:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:31899 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfAVDgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:36:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 19:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,504,1539673200"; 
   d="scan'208";a="312289873"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.37])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jan 2019 19:36:20 -0800
Date:   Tue, 22 Jan 2019 11:35:51 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
Message-ID: <20190122033551.GB3983@richard>
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

How about adjust this a little like:

    Check for an existing 'pfn' superblock before writing a new one.
    
    Return:
    
      -ENODEV: no valid superblock exists 
      0      : valid superblock exists
      other  : superblock violation, e.g. physical alignment change
    
    One superblock should be configured, before an nd_{pfn,dax} device be
    used properly.
    
    One newly create nd_{pfn,dax} device has no valid superblock. In this case
    nd_pfn_validate() returns -ENODEV to make driver continue and write
    configuration to superblock. 
    
    After proper configuration the first time, subsequent nd_pfn_validate()
    will find a valid superblock and return 0. So that driver will return
    immediately without configuring superblock again.
    
    An error other than -ENODEV means superblock violation, which fail
    probing.

> 	rc = nd_pfn_validate(nd_pfn, sig);
> 	if (rc != -ENODEV)
> 		return rc;

-- 
Wei Yang
Help you, Help me
