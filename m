Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqhC4Gij+br51VRWc0qPrQhxuADeXHpqJdxbRxdcGA2tCKp4/M5p+MgZgDSfuJbOcRxbUzO
ARC-Seal: i=1; a=rsa-sha256; t=1526330962; cv=none;
        d=google.com; s=arc-20160816;
        b=aX6pYqFB+jQGiUis1MuRDRoKI9DEWvp0ZhkDLX8iS/nagb4+oIc1Vrk42xgFYuZtgo
         jNZvxpAyxcXGreqsBASZZGkJhgDCpHgQCgszHSw7EXEv/nDTkxymmhLrxbQMWMVaJcMk
         OerF1CGOPrw/dl3thPNE9HK2HF5twGPtvG+KAkI74TURa52jica8itPmhVIXYLJJCaQD
         Bt0ES3DtovM/R3q0pvPq7SJ90Jrm7bfx+DUinX/JT1odLF0TP5QNll+JAZ6hiqp9G6tg
         KfK15oCJ7rF+qvkSfMy+zVQlzY6yKgFyxKhN2J9TPL+5czQ0ih+fIhJIFpUrCH0+cxWg
         RJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=mcw/UjEX9qpxvjWLW46ohwFqZVFH6T/IapwveMsnBKE=;
        b=DgSXG0VzqEsCrrpvSjaDjVZXmmaaJ4Sr2/wAkkxWZLs1ENoyevRCkeHaO2mWgujdc3
         YpC1l81cF+xIDb+8CpDKDqHaxO500A871gDpYZEFYa1o1d3UHUxwHUVEXR4S+oL6N30k
         /xbr8SZU8ng/ToGOa8x3IxRE8P7GBY18chS1zMKJWUbQMG0Q3Y/cgmxHJo4SE7h5YScQ
         df5ImC1kuXKRRhgcu6ndiywXZu8hJLDyfp4NKheu1wt5O676gTZOMIBePpJurHySSCWx
         PrMgDRKA7zyflpcxsqWGI0YuNr752TMVcQDjhFssc1NYlB3P+SbiqtDM/jYC3NDlnBdF
         oBkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="58574926"
Date: Mon, 14 May 2018 13:52:08 -0700
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
Subject: Re: [PATCH v5 11/23] driver core: add per device iommu param
Message-ID: <20180514135208.51987d8f@jacob-builder>
In-Reply-To: <5AF91E31.9060705@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-12-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF91E31.9060705@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363087328844?=
X-GMAIL-MSGID: =?utf-8?q?1600474015294422815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 13:27:13 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 05/12/2018 04:54 AM, Jacob Pan wrote:
> > DMA faults can be detected by IOMMU at device level. Adding a
> > pointer to struct device allows IOMMU subsystem to report relevant
> > faults back to the device driver for further handling.
> > For direct assigned device (or user space drivers), guest OS holds
> > responsibility to handle and respond per device IOMMU fault.
> > Therefore we need fault reporting mechanism to propagate faults
> > beyond IOMMU subsystem.
> >
> > There are two other IOMMU data pointers under struct device today,
> > here we introduce iommu_param as a parent pointer such that all
> > device IOMMU data can be consolidated here. The idea was suggested
> > here by Greg KH and Joerg. The name iommu_param is chosen here
> > since iommu_data has been used.  
> 
> This doesn't match what you've done in the patch. Maybe you
> forgot to cleanup? :-)
> 
No, I was trying to explain the thought process behind naming
iommu_param. I meant to say iommu_data is a probably a better name but
taken already.
> The idea is to create a parent pointer under device struct and
> move previous iommu_group and iommu_fwspec together with
> the iommu fault related data into it.
> 
> Best regards,
> Lu Baolu
> 
>  [...]  
> 

[Jacob Pan]
