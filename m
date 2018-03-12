Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AG47ELuhf3fyV9XG2XUqhFYfn4AzJO5cUvROpdVZUP9/6N21NnN0HZBxCw43UZQQpeOMgOEmDltv
ARC-Seal: i=1; a=rsa-sha256; t=1520897071; cv=none;
        d=google.com; s=arc-20160816;
        b=rxCl7ZXqxj8SBmypNGAP51Jg7zw7NYwV54OyjqMpa912um1SeH/8YJI/kACnQJucjv
         0EbH7xyYN5yLs4iepmP3S3l3xn+6jxzw5bapZdkNTYo1SVvewXBm8Fej1BbewglXbc9Q
         G9tG1NvfXchJC9piRU77xoo9JhRfhfxnSEZUgxS5Vm8K4UZ+YIhqAZeVbt4qL5+LlLmq
         YO8KKNt8jcZUwY2Ssx6I71zxLPfcCBalF8BII2ElQjxKJ0p3Z+I+Hycydd+pdew13QMC
         LbFW/FOuPOgb3NHo7fGZEdNT5Mvtsec6Cwe8Maw1IB50N6PZPfMAr09Hodd3PbusXKGg
         1Q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=EfwEoqzw2awRxFEpFwRou4W5iPp0SOERIDQJ8QeJhmc=;
        b=mhO8q9R4HIMEkCr2VdKJhQmwFYf8G/y7NKP9qpOyEszoDXJjT08PJTvYP+iMqAu4wV
         W6GKUF3m6uXXNQLKDtbCKLch1RXHWHDVSHKGTL7H1lDh1d7sdWoDq/Xnxtv0w0Jz3sKt
         fAt2/cX0kWKPlOaVmrWrOKxM1wvj5gq1/OAHJAAofT1mAKugfhGJ0MmWSnomqyZTXSVZ
         ZdO2zkMF5sbzhX/HWY/g5n81YDuQbkoqNa3kdKPE0z8zm0MBnich2vLLqrfVi1o65RkX
         n9a7xliJdlEsMl5PuhcOeFJCkciJBUvPynatDmxO8Is88CU3n7tf3UvN+qrkg6wrCAB5
         sJIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="34430397"
Date: Mon, 12 Mar 2018 17:26:26 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Oza Pawandeep <poza@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180312232626.GI18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <20180312194236.GA12195@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312194236.GA12195@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594776167455543875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 02:47:30PM -0500, Bjorn Helgaas wrote:
> [+cc Alex]
> 
> On Mon, Mar 12, 2018 at 08:25:51AM -0600, Keith Busch wrote:
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
> > other side have changed.
> 
> When DPC is triggered, the port takes the link down.  When we handle
> an uncorrectable (nonfatal or fatal) AER event, software takes the
> link down.
> 
> In both cases, devices on the other side are at least reset.  Whenever
> the link goes down, it's conceivable the device could be replaced with
> a different one before the link comes back up.  Is this why you remove
> and re-enumerate?  (See tangent [1] below.)

Yes. Truthfully, DPC events due to changing topologies was the motivating
use case when we initially developed this. We were also going for
simplicity (at least initially), and remove + re-enumerate seemed
safe without concerning this driver with other capability regsiters, or
coordinating with/depending on other drivers. For example, a successful
reset may depend on any particular driver calling pci_restore_state from
a good saved state.

> The point is that from the device's hardware perspective, these
> scenarios are the same (it sent a ERR_NONFATAL or ERR_FATAL message
> and it sees the link go down).  I think we should make them the same
> on the software side, too: the driver should see the same callbacks,
> in the same order, whether we're doing AER or DPC.
> 
> If removing and re-enumerating is the right thing for DPC, I think
> that means it's also the right thing for AER.
> 
> Along this line, we had a question a while back about logging AER
> information after a DPC trigger.  Obviously we can't collect any
> logged information from the downstream devices while link is down, but
> I noticed the AER status bits are RW1CS, which means they're sticky
> and are not modified by hot reset or FLR.
> 
> So we may be able to read and log the AER information after the DPC
> driver brings the link back up.  We may want to do the same with AER,
> i.e., reset the downstream devices first, then collect the AER status
> bits after the link comes back up.

I totally agree. We could consult Slot and AER status to guide a
smarter approach.

> > Calling a driver's error handler for the wrong device in an unknown
> > state may have undefined results. Enumerating the slot from scratch
> > should be safe, and will assign resources, tune bus settings, and
> > bind to the matching driver.
> 
> I agree with this; I think this is heading toward doing
> remove/re-enumerate on AER errors as well because it has also reset
> the device.
> 
> > Per spec, DPC is the recommended way for handling surprise removal
> > events and even recommends DPC capable slots *not* set 'Surprise'
> > in Slot Capabilities so that removals are always handled by DPC. This
> > service driver was developed with that use in mind.
> 
> Thanks for this tip.  The only thing I've found so far is the mention
> of Surprise Down triggering DPC in the last paragraph of sec 6.7.5.
> Are there other references I should look at?  I haven't found the
> recommendation about not setting 'Surprise' in Slot Capabilities yet.

No problem, it's in the "IMPLEMENTATION NOTE" at the end of 6.2.10.4,
"Avoid Disabled Link and Hot-Plug Surprise Use with DPC".

Outside the spec, Microsemi as one of the PCI-SIG contributors and early
adopters of the capability published a white paper "Hot and Surprise
Plug Recommendations for Enterprise PCIe" providing guidance for OS
drivers using DPC. We originally developed to that guidance. The paper
unfortunately appears to be pay-walled now. :(

DPC triggers don't necessarily mean a surprise removal occurred, and
I understand those conditions are motivating motivating these current
proposals. I've no qualms adding smarter handling as long as we don't
break removals: there are installations relying on this.

> [1] Tangent: I have similar concerns with the device reset paths.  We
> currently save some config state, reset the device, and restore the
> config state.  It's theoretically possible that the device was
> replaced or came up with different firmware after the reset, so I
> would really prefer to remove and re-enumerate there, too.  But that
> would make it hard for things up the stack that want to reset the
> device but not re-setup the whole stack.
> 
> I wonder if DPC is going to cause trouble for that scenario.  That's
> not an argument against DPC, but it might be a stronger reason to
> figure out how to deal with remove/re-enumerate in those stacks.

Indeed, that's a great point. From a storage perspective, when a removal
tears down the block devices, re-adding the same device initializes as a
new block handle. Applications with open file descriptors on old handles
are going to have a bad time. You can open through device mappers to
avoid those problems, but inflight IO may be aborted.

I assume other classes of devices have similar implications to consider,
so I agree expanding remove/re-enumerate may need to be considered
carefully.
