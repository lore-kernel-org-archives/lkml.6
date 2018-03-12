Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AG47ELt2JDBTeV+1sGmDMqdkmWODIbPiJAcKDW+WlzWdedcTlMvunnU0Cc2sLeGDcXcI7w3wONN+
ARC-Seal: i=1; a=rsa-sha256; t=1520866590; cv=none;
        d=google.com; s=arc-20160816;
        b=kEqSGbnu8e70vnQ9wgurEGpMgkXtL41rSIVRc0ahNY4Ty6NNUb1+Eq6XW3oNbS5Yzo
         8OvaqcOFpWSKbKMstKEKsqh1EEobUS7SMsKpOlX5np0mu84tRINVZ6I4oPUOU2cCNmT5
         zohgjMhvmJ78UKvPW4gTytsLVuYMpZUvPJ/dwaAONrEWGke/um1kOnFBbfIdU8qNfatj
         dPgXu9thYNnqW82djqllM8W8+lkFnRNCxAunCCdeeHcebM5MBTj6YUV6Atksj4be0dr4
         57MCpjbI1J0N4ejQk5ga8iAR/UBcujjxj9f39DGIrvPE18gRdar3bXFF6YRvsMAFMF1w
         Y5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nH8Fxe/cMFkjx7rPiTDK0Wo5E8f/iR4HKAxJxB0275I=;
        b=xVOzhDnQ8vCwTBX3ihMV1CvJpVKnTWd1aaC3PyF6spSw5iOemO5wgyazOYpa83325D
         jLrGEGtKP0lbz8JGxElp9r9fN9nsvrZaF/eL48Vgd/vMd4xPGpl5zf2Hqa1b/ky5G9Ms
         b6jb2j0VvisMc+JcQb/WPdrBUqAH3b1E5mltydvVIVqnCHq+YT0P9uMOr1yL3ogmxn18
         fi1MBhXA5EveGWv1av0ed90HyY8j2BNlo/gLIt/yMqiTLFKkyrN1YHPN+C3a159wGoHv
         qwqpm5y80NgwoqZKpOlyKvOlw6UaImQJt1ub6wol64aCouSBrv5N/pxVFyijCLU5wKi9
         5LYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="36619280"
Date: Mon, 12 Mar 2018 08:58:24 -0600
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
Message-ID: <20180312145823.GC18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594744205715324809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 08:16:38PM +0530, poza@codeaurora.org wrote:
> On 2018-03-12 19:55, Keith Busch wrote:
> > On Sun, Mar 11, 2018 at 11:03:58PM -0400, Sinan Kaya wrote:
> > > On 3/11/2018 6:03 PM, Bjorn Helgaas wrote:
> > > > On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
> > > 
> > > > That difference has been there since the beginning of DPC, so it has
> > > > nothing to do with *this* series EXCEPT for the fact that it really
> > > > complicates the logic you're adding to reset_link() and
> > > > broadcast_error_message().
> > > >
> > > > We ought to be able to simplify that somehow because the only real
> > > > difference between AER and DPC should be that DPC automatically
> > > > disables the link and AER does it in software.
> > > 
> > > I agree this should be possible. Code execution path should be almost
> > > identical to fatal error case.
> > > 
> > > Is there any reason why you went to stop driver path, Keith?
> > 
> > The fact is the link is truly down during a DPC event. When the link
> > is enabled again, you don't know at that point if the device(s) on the
> > other side have changed. Calling a driver's error handler for the wrong
> > device in an unknown state may have undefined results. Enumerating the
> > slot from scratch should be safe, and will assign resources, tune bus
> > settings, and bind to the matching driver.
> > 
> > Per spec, DPC is the recommended way for handling surprise removal
> > events and even recommends DPC capable slots *not* set 'Surprise'
> > in Slot Capabilities so that removals are always handled by DPC. This
> > service driver was developed with that use in mind.
> 
> Now it begs the question, that
> 
> after DPC trigger
> 
> should we enumerate the devices, ?
> or
> error handling callbacks, followed by stop devices followed by enumeration ?
> or
> error handling callbacks, followed by enumeration ? (no stop devices)

I'm not sure I understand. The link is disabled while DPC is triggered,
so if anything, you'd want to un-enumerate everything below the contained
port (that's what it does today).

After releasing a slot from DPC, the link is allowed to retrain. If there
is a working device on the other side, a link up event occurs. That
event is handled by the pciehp driver, and that schedules enumeration
no matter what you do to the DPC driver.
