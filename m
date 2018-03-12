Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AG47ELuv1n7iMWwS38OcnmTI1kQqsrKx8Vko6sdLi8ijIlOlctYA1ICfmTU8rpGG8RUWY0tVua9J
ARC-Seal: i=1; a=rsa-sha256; t=1520875866; cv=none;
        d=google.com; s=arc-20160816;
        b=jE73N1rLMDml4HiN4eqxJ1HIG5ybSCrf0jmyEtgJSJbNywZCqN9+YHxB1TggH+6Q2q
         eTVf53Xx00nBjLAFxmZtpaBgORjD9cqF4LWs3fRDxPDxw6dsUCuqX1ERMbRCD9KkUh//
         VmGI4i8cvi+ZiluIBTLNejjyj1EV1wPbYbl/a827CCzZbxCufkH07iadIoTcNwPgb5Gh
         yi1x6xxbJxBQy2V29qv6cyPubxc5WLOyR/fqnkjFz5dzOVXzwI0eT3ilmODUX7+ZLOa4
         KjS/R+j4hzk7axcR6nSF652DYFXVNGAIjmszCCekr9FsJ8F6Jv4SZ4s7/RFVpnIuF8LP
         NPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=alsf8Eo4OswkI/SN2j/fLwlSc8UH9uoHD4635p0L+M8=;
        b=ze7x82i5OQFRPInGcyBqL0QqrxM7wGT4TVuoKUvrARCYDOPBgFAVtWSL9QJYoTisf6
         j2ZZCHYSl2yQmyD/ql96zhREifVvDTQBwgPd57nDUIklUVinx8WewnLwiENzOXdhBY5R
         wJm+i84/F3r6C754tI0B2ZyktQiPuVPHdGwuRPIkTA15Aebm085MwzzhY9yIqxCuyBtG
         Bx9G8maIZctL/MfySGv6ivQRVgLneMRHUH2rUvmUlNIxj/F1wsHX4tz3Up9nXUF7hoQP
         S1sF23h3LpF9Ev2sp/25anHEwnLNZuNuLb7IZH+G3Eh/1irzXHYQKySocc6V52//gYij
         t3Yw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,462,1515484800";
   d="scan'208";a="37520585"
Date: Mon, 12 Mar 2018 11:33:01 -0600
From: Keith Busch <keith.busch@intel.com>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180312173301.GD18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
 <20180312145823.GC18494@localhost.localdomain>
 <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594753932952419804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 09:04:47PM +0530, poza@codeaurora.org wrote:
> On 2018-03-12 20:28, Keith Busch wrote:
> > I'm not sure I understand. The link is disabled while DPC is triggered,
> > so if anything, you'd want to un-enumerate everything below the
> > contained
> > port (that's what it does today).
> > 
> > After releasing a slot from DPC, the link is allowed to retrain. If
> > there
> > is a working device on the other side, a link up event occurs. That
> > event is handled by the pciehp driver, and that schedules enumeration
> > no matter what you do to the DPC driver.
> 
> yes, that is what i current, but this patch-set makes DPC aware of error
> handling driver callbacks.

I've been questioning the utility of doing that since the very first
version of this patch set.

> besides, in absence of pciehp there is nobody to do enumeration.

If you configure your kernel to not have a feature, you don't get to
expect the feature works.

You can still manually rescan through sysfs, /sys/bus/pci/rescan.
 
> And, I was talking about pci_stop_and_remove_bus_device() in dpc.
> if DPC calls driver's error callbacks, is it required to stop the devices  ?

DPC is PCIe's preferred surprise removal mechanism. If you don't want
the DPC driver to handle removing devices downstream the containment,
how do you want those devices get removed? Just calling driver's error
callbacks leaves the kernel's view of the topology in the wrong state.
