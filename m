Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx49U5326B8ColHDjCQf0MH0imPj4m3Jc+FuJmzVUl7OHgyDETmBubbGTqpur9Mcs/Wjysh3d
ARC-Seal: i=1; a=rsa-sha256; t=1524267619; cv=none;
        d=google.com; s=arc-20160816;
        b=a3vmQcLkOhv5f3h/czXu1ajzxDoH2mHLihnQOfEU0tsXvmK+Y1vd+5s5hBSbD3k/Uw
         DeEhz0wfjVJ0ZCAdWf+KE/GboI7o4OKWajFY55XPC+i6KALFTaHvBgp4KZqWoKrhMrkS
         aAy9AW+0ITSPV0LQtgMOI+xszkNU4jigrkxqfQ2UNrn07hymZmShhdFYESmf7tO21vAN
         0O9ENWE+wYxCBNmcDjLBGAeRGPHn42HznjxnmURIbghn4HStGBLah31SJN81RA6tV4F5
         kA03tfnSAIXvvlTpW0d4wYOyo6nBnrHM6nDFYXJzxq7DC2Poch6VsSus7Te+gD70i9+e
         A8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=vbXZTufoGG7J6bBBfosHn948xr97QpyIPBIXF9l0IuY=;
        b=qfxaM9U9JYugRJeOAE6IrRQR0JzYJjg+AJhPYZFVY9YtqAKDEoe+Ig3spOT2fXUEl8
         NwXRUCU3FTXx/JT9W4ZLhZo1o83s9GHH8/Gtow91VQ32J8URVOr27KMSBapIZsT/E5+s
         ck3kmn0l15Z1YAzMcpLKlc8Yy97+c/9jsRmdjN+vdN78W31BLIUTapgixImvw0TsnnIi
         Xw5/mCZLiTlddBBJBHwRQRpQTvxFWNX1ecDGNTzari9pRVobtKNuFdKmbDnzctmJ75LF
         PTZCUjeXR0MbZ6T5FpKSvFd1748gLSWfTc8igORUGpeM9OfK2j9jYdz7J810y9fxwJNA
         0otw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="49586391"
Date: Fri, 20 Apr 2018 16:42:51 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj
 Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph
 Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Yi L
 <yi.l.liu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Message-ID: <20180420164251.5245f822@jacob-builder>
In-Reply-To: <AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180417131047.0a9c310f@w520.home>
	<AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909380631347?=
X-GMAIL-MSGID: =?utf-8?q?1598310443147818528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018 19:25:34 +0100
Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com> wrote:

> On Tue, Apr 17, 2018 at 08:10:47PM +0100, Alex Williamson wrote:
> [...]
> > > +	/* Assign guest PASID table pointer and size order */
> > > +	ctx_lo = (pasidt_binfo->base_ptr & VTD_PAGE_MASK) |
> > > +		(pasidt_binfo->pasid_bits - MIN_NR_PASID_BITS);  
> > 
> > Where does this IOMMU API interface define that base_ptr is 4K
> > aligned or the format of the PASID table?  Are these all
> > standardized or do they vary by host IOMMU?  If they're standards,
> > maybe we could note that and the spec which defines them when we
> > declare base_ptr.  If they're IOMMU specific then I don't
> > understand how we'll match a user provided PASID table to the
> > requirements and format of the host IOMMU. Thanks,  
> 
> On SMMUv3 the minimum alignment for base_ptr is 64 bytes, so a guest
> under a vSMMU might pass a pointer that's not aligned on 4k.
> 
PASID table pointer for VT-d is 4K aligned. 
> Maybe this information could be part of the data passed to userspace
> about IOMMU table formats and features? They're not part of this
> series, but I think we wanted to communicate IOMMU-specific features
> via sysfs.
> 
Agreed, I believe Yi Liu is working on a sysfs interface such that QEMU
can match IOMMU model and features.
