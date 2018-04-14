Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeDNAJD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 20:09:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:40560 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeDNAJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 20:09:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,446,1517904000";
   d="scan'208";a="220296884"
From: "Mehta, Sohil" <sohil.mehta@intel.com>
To: "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Topic: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Index: AQHT04THDyVaDNNW7k6hYyQjJLsxvQ==
Date: Sat, 14 Apr 2018 00:08:55 +0000
Message-ID: <1523664612.2747.13.camel@intel.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
         <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
In-Reply-To: <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.110.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF21F5DFCD25FD46A7289FE14D9FBEAD@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3E09xjj002648

On Fri, 2018-04-06 at 08:17 -0500, Gary R Hook wrote:
> 
> +
> +void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
> +{
> +	char name[MAX_NAME_LEN + 1];
> +	struct dentry *d_top;
> +
> +	if (!debugfs_initialized())

Probably not needed.

> +		return;
> +
> +	mutex_lock(&amd_iommu_debugfs_lock);
> +	if (!amd_iommu_debugfs) {
> +		d_top = iommu_debugfs_setup();
> +		if (d_top)
> +			amd_iommu_debugfs =
> debugfs_create_dir("amd", d_top);
> +	}
> +	mutex_unlock(&amd_iommu_debugfs_lock);


You can do the above only once if you iterate over the IOMMUs here
 instead of doing it in amd_iommu_init.

> +	if (amd_iommu_debugfs) {
> +		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu-
> >index);
> +		iommu->debugfs = debugfs_create_dir(name,
> +						    amd_iommu_debugf
> s);
> +		if (!iommu->debugfs) {
> +			debugfs_remove_recursive(amd_iommu_debugfs);
> +			amd_iommu_debugfs = NULL;
> +		}
> +	}
> +}

-Sohil
