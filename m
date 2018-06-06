Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D00960767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeFFLVF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:21:05 -0400
Received: from foss.arm.com ([217.140.101.70]:39410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751034AbeFFLVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:21:04 -0400
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Yi L <yi.l.liu@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20180417131047.0a9c310f@w520.home>
 <AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
 <20180420164251.5245f822@jacob-builder> <20180529140915.1f174689@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D1911E59C4@SHSMSX101.ccr.corp.intel.com>
 <20180529211746.74f1dd23@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D1911E5F06@SHSMSX101.ccr.corp.intel.com>
 <a07a0a0a-ebdd-c81a-7ed6-cff19e6078d7@arm.com>
 <20180530125240.34e0e80c@jacob-builder>
 <1c1094e8-ecbb-7731-910c-59e4de1e5c70@arm.com>
 <20180605103253.634ef8fd@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <2831caf1-d40b-58c3-313c-afb7262e1861@arm.com>
Date: Wed, 6 Jun 2018 12:20:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180605103253.634ef8fd@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/18 18:32, Jacob Pan wrote:
>> "bytes" could be passed by VFIO as argument to bind_pasid_table, since
>> it can deduce it from argsz
>>
> Are you suggesting we wrap this struct in a vfio struct with argsz? or
> we directly use this struct?
> 
> I need to clarify how vfio will use this.

Right, I think we've diverged a bit since the last discussion :)

> - User program:
> struct pasid_table_config ptc = { .bytes = sizeof(ptc) };
> ptc.version = 1;
> ioctl(device, VFIO_DEVICE_BIND_PASID_TABLE, &ptc);

Any reason to do the ioctl on device instead of container? As we're
binding address spaces we probably want a consistent view for the whole
container, like the MAP/UNMAP ioctls do.

As I remember it the userspace interface would use a VFIO header and the
BIND ioctl. I can't find the email in my archive though, so I might be
imagining it. This is what I remember, on the user side:

struct {
	struct vfio_iommu_type1_bind	hdr;
	struct pasid_table_config	cfg;
} bind = {
	.hdr.argsz	= sizeof(bind),
	.hdr.flags	= VFIO_IOMMU_BIND_PASID_TABLE,
	/* cfg data here */
};

ioctl(container, VFIO_DEVICE_BIND, &bind);


But I don't feel strongly about the interface. However I'd suggest to
keep incremental versioning like the rest of VFIO, with argsz and flags,
instead of version numbers, because it's more flexible.

Initially the PTC struct would look like:
struct pasid_table_config {
  u32 argsz;		/* sizeof(pasid_table_config) */
  u32 flags;		/* Should be zero */
  u64 base_ptr;
  u8 model;
  u8 pasid_bits;
};

(Even though it doesn't use a version field let's call this version 1
for the sake of the example)

------
If someone wants to add a new field to the structure, then they also add
a flag (let's call this version 2):

struct pasid_table_config {
  u32 argsz;
#define PASID_TABLE_CONFIG_EXTN (1 << 0)
  u32 flags;
  u64 base_ptr;
  u8 model;
  u8 pasid_bits;
  u64 some_extension;
};

* Assume user has a version 2 header and kernel has a version 1 header.
  * If user doesn't want the extension, it doesn't set the EXTN flag.
    The ioctl succeeds because the kernel checks that argsz >=
    offsetofend(pasid_bits) and that (flags == 0).
  * If user wants to use the extension, it sets the EXTN flag. The ioctl
    fails because the kernel doesn't recognize the flag.
* Assume user has version 1 and kernel has version 2.
  * User doesn't use the extension. The kernel still checks that
    argsz >= offsetofend(pasid_bits), but also that (flags &
    ~PASID_TABLE_CONFIG_EXTN), which succeeds.
  * User wants the extension, sets PASID_TABLE_CONFIG_EXTN. When
    seeing the flag, the kernel additionally checks that argsz >=
    offsetofend(some_extension), which succeeds.

------
Adding model-specific fields is a bit more complicated, because I think
they should always stay at the end of the struct. One solution is to add
padding for common extensions:

struct pasid_table_config {
  u32 argsz;
  u32 flags;
  u64 base_ptr;
  u8 model;
  u8 pasid_bits;
  u8 padding[64];

  union {
    struct {
      u8 s1dss;
      u8 s1fmt;
    } model_arm;
    struct {
      u64 foo;
    } model_bar;
  };
};

(we might call this version 3, but can be added before or after version
2, it doesn't matter)

A subsequent extension can still add the "some_extension" field and a
flag. If the kernel sees model "ARM", then it checks argsz >=
offsetofend(model_arm). If it sees model "BAR" then it checks argsz >=
offsetofend(model_bar). A model could also have flags to make the
model-specific structure extensible.

The problem is when we run out of space in the padding area, but we
might not need much extensibility in the common part.

Thanks,
Jean
