Return-Path: <jean-philippe.brucker@arm.com>
X-Google-Smtp-Source: AB8JxZqL22fFEVRzrU+WAqZRoQkXV86ZGv1TH9UGwYIJVtauItJu3PSAWhEmIjAEHzUakyT4ttik
ARC-Seal: i=1; a=rsa-sha256; t=1525775711; cv=none;
        d=google.com; s=arc-20160816;
        b=zMSBRRpPWgwlpBQB/IlxLbEuzRoQIE/ykNk3+Kc3pI/u6YV22g0Kz4C8/Z8FQHVVli
         wWogC9VERD/zy0iEsFM2KFDyXMPQxIuCZoUZZd0XRGLu5gMk+9pfuoekKM6sAPhTAuAx
         sl642as3T8kOfZlrX1JJIg93zZYB6HRvohyxTdEjRo76KgQZL6sUpxFpSR70mtcL1H8B
         449TNfIkeZb5VT4zOdPR4RNzAx+2qbzPdEnAbyT1KHC3u1wy4JbSxUI9cTlJAvyzdsK/
         QHw3k9kNZTdVfGORZJ6QtZxmnAhwkzWJ6jl7AfpL5pD/e3r7kn2TRbUFS6F5u6pJvCnL
         zsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=hRMHQj+c6pODQWLThm6URuSoUmrCPVD1myxCGmPvDwc=;
        b=p7TExDW4ZGb68m4RtUh2ec95BoTEVGrF64wmOkmmjUoVODvsUeaacXxuwdnNpyKTYP
         /Tm9+0yccTga4sWDw/1plXgQc8/hsdAQ9wwXPYVKCUbYpBTAWo6EFrzcNioB80jlZyTZ
         qUkOIjaBL9HvcCj2hf0jBvhYFsmv8ud78ZI1z5xDJwUl1Z36CgHpR919hiy9wUmkcMOk
         3H/tOK3TBZg2/JSVGsJBmrZWSM2be/h4Eq7cZMTTTViVk8TDL0IsFIR1as4FYAY6PcRP
         ZiIZ3JF4xBL2OQ9yx6YLz8Z1hSpHloWskPXDvExEiDcNXegUlt4V79v8I2jxzkY2xmPh
         z/8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 "Liu, Yi L" <yi.l.liu@linux.intel.com>,
 "Liu@ostrya.localdomain" <Liu@ostrya.localdomain>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20180420181951.GA50099@ostrya.localdomain>
 <20180423134325.6780f6ac@jacob-builder>
 <72ee47c4-55fa-4ff1-d94e-cc26203e3eda@arm.com>
 <20180501155838.4ec3720c@jacob-builder>
 <b12bcd35-9472-83ed-a26f-e5be3794e2d2@arm.com>
 <20180503214616.51553247@jacob-builder>
 <20180504110706.3392a98e@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <ef462e73-01e3-d581-cf91-3e012a337c61@arm.com>
Date: Tue, 8 May 2018 11:35:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504110706.3392a98e@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909254056563?=
X-GMAIL-MSGID: =?utf-8?q?1599891792678179980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jacob,

Looks mostly good to me, I just have a couple more comments

On 04/05/18 19:07, Jacob Pan wrote:
> Now the passdown invalidation granularities look like:
> (sorted by coarseness), will send out in v5 patchset soon if no issues.
> 
> /**
>  * enum iommu_inv_granularity - Generic invalidation granularity
>  *
>  * @IOMMU_INV_GRANU_DOMAIN:		Device context cache associated with a
>  *					domain ID.
>  * @IOMMU_INV_GRANU_DEVICE:		Device context cache associated with a
>  *					device ID
>  * @IOMMU_INV_GRANU_DOMAIN_ALL_PASID:	TLB entries or PASID caches of all
>  *					PASIDs associated with a domain ID
>  * @IOMMU_INV_GRANU_PASID_SEL:		TLB entries or PASID cache associated
>  *					with a PASID and a domain
>  * @IOMMU_INV_GRANU_PAGE_PASID:		TLB entries of selected page range
>  *					within a PASID
>  *
>  * When an invalidation request is passed down to IOMMU to flush translation
>  * caches, it may carry different granularity levels, which can be specific
>  * to certain types of translation caches. For an example, PASID selective
>  * granularity is only applicable PASID cache and IOTLB invalidation but for
>  * device context caches.

Should it be "PASID selective granularity is only applicable to PASID
cache and IOTLB but not device context caches"?

>  * This enum is a collection of granularities for all types of translation
>  * caches. The idea is to make it easy for IOMMU model specific driver to
>  * convert from generic to model specific value. Not all combinations between
>  * translation caches and granularity levels are valid. Each IOMMU driver
>  * can enforce check based on its own conversion table. The conversion is
>  * based on 2D look-up with inputs as follows:
>  * - translation cache types
>  * - granularity
>  * No global granularity is allowed in that passdown invalidation for an
>  * assigned device should only impact the device or domain itself.

That last sentence is a bit confusing, because "global granularity"
might also refer to the "global" TLB flag which is allowed. In my
opinion you can leave this rationale out, I doubt userspace will ever
demand a mechanism for global invalidation.

>  *
>  *             type |   DTLB    |    TLB    |   PASID   |  CONTEXT
>  *  granule         |           |           |           |
>  * -----------------+-----------+-----------+-----------+-----------
>  *  DOMAIN          |           |           |           |     Y
>  *  DEVICE          |           |           |           |     Y

I can't really see a use-case for DOMAIN and DEVICE. It might make more
sense to keep only DN_ALL_PASID, which would then also invalidate the
device context cache. But since they will be very rare events, factoring
them doesn't seem important.

>  *  DN_ALL_PASID    |   Y       |   Y       |   Y       |
>  *  PASID_SEL       |   Y       |   Y       |   Y       |
>  *  PAGE_PASID      |           |   Y       |           |

Why not allow PAGE_PASID+DTLB? We need a way to invalidate individual
DTLB entries

Thanks,
Jean
