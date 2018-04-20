Return-Path: <Jean-Philippe.Brucker@arm.com>
X-Google-Smtp-Source: AB8JxZpGS9Ax5Ek9FoH4UbrL2onZ14NKCXtV4MLR3OnawnrE9n7ojGvSYVY2v6jP/0+7EV7Mprp0
ARC-Seal: i=1; a=rsa-sha256; t=1524248745; cv=none;
        d=google.com; s=arc-20160816;
        b=U/QF+Y8LeFxFx4QMjSDgtWTScFb2DQ8ooOuHbbrcX2zkc9gHqJ/bAfmDbykmlGUCN/
         Yk/X5MPj/HnDitemTSo/W8erG065LsWTYwLiZqc3lZqfOG6u/v8kuoK+NAq1yG03kwZS
         9Rb+lpzoNJwP0JI7pvrr7xvSgDszLjsI9ECsbujkJ2Qf9Na3ihRVM4hSliJ/8B8VrJAj
         eXwjNRJN3vhw+BeUvqsc7ZMYdx9tE9am13XAYEr5cx69TNaTVSUZMsOmp1fbIqIlm02y
         ZxUOXxqn2zjyBWRNOJghdDmUEFbWgk7HwlUorJ5A5CKqJL7fQrYiZDgcecUG5qEB4JqV
         se0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-language:thread-index:thread-topic:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=zaL9z5pX9pYXIygcpR1LZVheEcVHR0QNaB2rudPhcKs=;
        b=qdJwzpij7/bGD2aCxlLrhw8LDCaF8VlUoZLBbZeabdyhdj+I1YdfAlzCSo04j6deOF
         NPhGZ1NelmwkHZuw3fy05GK727oBLQVGiOB0cVWt3y96YiJNJJzP9aR7/Pl3HsA5dpHX
         ja87tt8Y8BJsk5g3JwxAXQP5kk8zNo45cVfPi9i6Rg293L94QGuUNcPG6D468qjOUlvr
         G9/GZIC8RRrgI3VIfODMgIQF+R/G8F9VlL3Nkmdc3Fmw+ClsJ4bRJ/nk7vkRJw+9jDEO
         siTA9+Iv2mHNJktWJE+1IvyOcJpkKjEGgwGo2Y5DWVk5aH/JPwXAFl9H9gZC76k6I19w
         xBBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=Jean-Philippe.Brucker@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=Jean-Philippe.Brucker@arm.com
Date: Fri, 20 Apr 2018 19:25:34 +0100
From: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Yi L <yi.l.liu@linux.intel.com>
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Message-ID: <AM4PR0802MB2369F739C91B630CA99B3D3BA3B40@AM4PR0802MB2369.eurprd08.prod.outlook.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20180417131047.0a9c310f@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180417131047.0a9c310f@w520.home>
Thread-Topic: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Thread-Index: AQHT1cx3i3O6vmaIl02/JIPlG/+icKQFU/yAgASEjYA=
X-MS-Exchange-MessageSentRepresentingType: 1
Content-Language: en-US
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-imapappendstamp: AM4PR0802MB2369.eurprd08.prod.outlook.com
 (15.20.0696.010)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909380631347?=
X-GMAIL-MSGID: =?utf-8?q?1598290652054216216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 08:10:47PM +0100, Alex Williamson wrote:
[...]
> > +	/* Assign guest PASID table pointer and size order */
> > +	ctx_lo = (pasidt_binfo->base_ptr & VTD_PAGE_MASK) |
> > +		(pasidt_binfo->pasid_bits - MIN_NR_PASID_BITS);
> 
> Where does this IOMMU API interface define that base_ptr is 4K
> aligned or the format of the PASID table?  Are these all standardized
> or do they vary by host IOMMU?  If they're standards, maybe we could
> note that and the spec which defines them when we declare base_ptr.  If
> they're IOMMU specific then I don't understand how we'll match a user
> provided PASID table to the requirements and format of the host IOMMU.
> Thanks,

On SMMUv3 the minimum alignment for base_ptr is 64 bytes, so a guest
under a vSMMU might pass a pointer that's not aligned on 4k.

Maybe this information could be part of the data passed to userspace
about IOMMU table formats and features? They're not part of this series,
but I think we wanted to communicate IOMMU-specific features via sysfs.

Thanks,
Jean
