Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZpZezyUmtr+h4d+PAGkXRXn1CrUzNTPg+xWmIA3hqonAkFcJo2ywu/oLecmFuh1HqmbYB76
ARC-Seal: i=1; a=rsa-sha256; t=1526330636; cv=none;
        d=google.com; s=arc-20160816;
        b=NRGZE5YQ3pUeuzNwkZKlXLtW3ca/Bw663DD5uDg39dsAcN4WCSrWS+/Y5E1Ieyaone
         wTX5oQ/XU0IsIVII1m245XXm6LWa8lUEXyXj/T8PCF3w/yH9HrzH6ymx5g6oAguvxnmD
         o8syQalENQn0xwsPvoV1Fn81b0SGCin+ztUt+Ps2f53OUMBSxq8XxdLVdEAmFL1dVEMd
         6ELa8bB7ek7zW4/AvHTUP0c9kET4u2tZByyZHcilymQ5EKK3gcuUv2fcXEyPznWoeLuQ
         NfwnHE8mBXUEfjK6fkN9ZNEsAYlG+YOt8rMxfpKc7FK4HQigq+wQNOCLahf1/4WA3aso
         3zMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=laMDU5cxZfn+9pGk11BPOlvzHDHHdgjH/TMKuc5VZTY=;
        b=QxNh0J7C2c5bIRnN+gb53FXLjwuapgbuG7qOaIPOncnl1/wG0VmsjOs8FJkJz8AkrW
         b1YobjLWnxzE6/mSKgHoz3zFrAgPtLizzC61qCsSd8dSzxscfrV1JhLWRfSBTW5BloBk
         ZrvaR6M9Fn0UzGUEppiXPNtDkqZaMYu0yfE8H1VTikzQwY27uOnGTx1ttJLxbdLyulOR
         LYlxcM9D5Z3wUY0OI0ckjkxkJvxTmAfm2auv31Ck8vhOd6AuvzkRwS/ClULkHrT2KjnV
         4pIU2wfURU/UV+gXqsk5hQ6PRtCtxkz/knmjM/spg1JrUZvWMBlfmVUPmP+0WyTACjZR
         EmoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="54289099"
Date: Mon, 14 May 2018 13:46:42 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean
 Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 08/23] iommu/vt-d: support flushing more translation
 cache types
Message-ID: <20180514134642.45cdbb4d@jacob-builder>
In-Reply-To: <5AF8F204.2010800@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-9-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF8F204.2010800@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362792419747?=
X-GMAIL-MSGID: =?utf-8?q?1600473674171696998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 10:18:44 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 05/12/2018 04:54 AM, Jacob Pan wrote:
> > When Shared Virtual Memory is exposed to a guest via vIOMMU,
> > extended IOTLB invalidation may be passed down from outside IOMMU
> > subsystems. This patch adds invalidation functions that can be used
> > for additional translation cache types.
> >
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/dmar.c        | 44
> > ++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/intel-iommu.h | 21 +++++++++++++++++++-- 2 files
> > changed, 63 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index 7852678..0b5b052 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -1339,6 +1339,18 @@ void qi_flush_iotlb(struct intel_iommu
> > *iommu, u16 did, u64 addr, qi_submit_sync(&desc, iommu);
> >  }
> >  
> > +void qi_flush_eiotlb(struct intel_iommu *iommu, u16 did, u64 addr,
> > u32 pasid,
> > +		unsigned int size_order, u64 granu, bool global)  
> 
> Alignment should match open parenthesis.
> 
> > +{
> > +	struct qi_desc desc;
> > +
> > +	desc.low = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
> > +		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
> > +	desc.high = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_GL(global) |
> > +		QI_EIOTLB_IH(0) | QI_EIOTLB_AM(size_order);
> > +	qi_submit_sync(&desc, iommu);
> > +}
> > +
> >  void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16
> > pfsid, u16 qdep, u64 addr, unsigned mask)
> >  {
> > @@ -1360,6 +1372,38 @@ void qi_flush_dev_iotlb(struct intel_iommu
> > *iommu, u16 sid, u16 pfsid, qi_submit_sync(&desc, iommu);
> >  }
> >  
> > +void qi_flush_dev_eiotlb(struct intel_iommu *iommu, u16 sid,
> > +		u32 pasid,  u16 qdep, u64 addr, unsigned size, u64
> > granu)  
> 
> Ditto.
> 
> > +{
> > +	struct qi_desc desc;
> > +
> > +	desc.low = QI_DEV_EIOTLB_PASID(pasid) |
> > QI_DEV_EIOTLB_SID(sid) |
> > +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE;  
> 
> Have you forgotten PFSID, or I missed anything here?
you are right, missed pfsid in this case.
> 
>  [...]  
> 
> Best regards,
> Lu Baolu
