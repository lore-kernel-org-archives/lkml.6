Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZoKnbVWza0SBS8AUs8iiSPIpwy5VkNN4F6L3I3pUKxBn9WY+j5M/ZoT4D7d7aSkZrhqJ/lU
ARC-Seal: i=1; a=rsa-sha256; t=1526275636; cv=none;
        d=google.com; s=arc-20160816;
        b=uyByKNNj1zKMd6duaMVlBtqfK6UuZs02vzoCccq/fHEIrzirvARUUiqNoiGu0nIB3r
         ZWsx9vTsUC5dCpzpBsWyZeoFKLdoB556JZHn8CHDw7IHqrsnOu4u2A+Tr7KX3oFSVAQY
         evZ79QTr8hGVMb93YvnntjrdGBuKSJxC/w4fDeZrvOMU5MPxy6mPpsqmMWib2E3SGwWQ
         UxItc1PGA77fRMF8+YUbltwa3VgAM3J6Iruo3BKcsNSHJk83h/uxixv+t2nv1+ssfgyb
         cfLWfI3Wk290kZj1jbLF0gLe2+8i2NjVZc8bnt/m+PbststPtXdEL0iQVcVExrYiylsN
         qbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=bLA3n92k+97O7fwxumzVG5ewngzx5vr4SJhsXuHxA7c=;
        b=Ue2vxH0/m4OoE49rrb8VucqOyq6bp0U9dc2F3DCreQJT/XBOtYT/Jj595WO0YQ9JC+
         vZ3rr1kl+aSBM+Tn7C0g2HEgWvBNZmRXaDTJOmQFZIJ/GTMMb3TSshAK/eld9MLSzJB4
         Fay1yQo6/FM5gp95FMFRtlZEPw/zRFEdn0WBatmvWr85PLqZMTOwoiO/sBbACndAumss
         ZQ9BHR7d92+HRmwMVBHxw8WSFf6QnGpM+VSoga2k3t2K7RwiMVVZBNwjjjm7Hqez9QfD
         PE82nMBe5a+8yGyYTnpAvAvDd8X64UWjPmRl6rVAAX8N01D2c+9NW206j3va5oZ1EQil
         F1Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,398,1520924400";
   d="scan'208";a="48981029"
Subject: Re: [PATCH v5 11/23] driver core: add per device iommu param
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-12-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF91E31.9060705@linux.intel.com>
Date: Mon, 14 May 2018 13:27:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-12-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363087328844?=
X-GMAIL-MSGID: =?utf-8?q?1600416002067389093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:54 AM, Jacob Pan wrote:
> DMA faults can be detected by IOMMU at device level. Adding a pointer
> to struct device allows IOMMU subsystem to report relevant faults
> back to the device driver for further handling.
> For direct assigned device (or user space drivers), guest OS holds
> responsibility to handle and respond per device IOMMU fault.
> Therefore we need fault reporting mechanism to propagate faults beyond
> IOMMU subsystem.
>
> There are two other IOMMU data pointers under struct device today, here
> we introduce iommu_param as a parent pointer such that all device IOMMU
> data can be consolidated here. The idea was suggested here by Greg KH
> and Joerg. The name iommu_param is chosen here since iommu_data has been used.

This doesn't match what you've done in the patch. Maybe you
forgot to cleanup? :-)

The idea is to create a parent pointer under device struct and
move previous iommu_group and iommu_fwspec together with
the iommu fault related data into it.

Best regards,
Lu Baolu

>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Link: https://lkml.org/lkml/2017/10/6/81
> ---
>  include/linux/device.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 4779569..c1b1796 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -41,6 +41,7 @@ struct iommu_ops;
>  struct iommu_group;
>  struct iommu_fwspec;
>  struct dev_pin_info;
> +struct iommu_param;
>  
>  struct bus_attribute {
>  	struct attribute	attr;
> @@ -899,6 +900,7 @@ struct dev_links_info {
>   * 		device (i.e. the bus driver that discovered the device).
>   * @iommu_group: IOMMU group the device belongs to.
>   * @iommu_fwspec: IOMMU-specific properties supplied by firmware.
> + * @iommu_param: Per device generic IOMMU runtime data
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:	Set after successful invocation of bus type's .offline().
> @@ -988,6 +990,7 @@ struct device {
>  	void	(*release)(struct device *dev);
>  	struct iommu_group	*iommu_group;
>  	struct iommu_fwspec	*iommu_fwspec;
> +	struct iommu_param	*iommu_param;
>  
>  	bool			offline_disabled:1;
>  	bool			offline:1;
