Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqHP6eovRb1qJFnpyh498CLiC/89hw318skedSirwYgQ7HsBczvPixYYhOEsnxWRJ/G9u1b
ARC-Seal: i=1; a=rsa-sha256; t=1525110707; cv=none;
        d=google.com; s=arc-20160816;
        b=QjfLT5pHeZGIDpQPULmRtqYWGUYqCzSd+gbq7x45SEKLVYfA2+b7Ixhn+PBu2H4XM1
         TQNv6sIkKxKUWdiB3vqani7bBhuTIb60h6j6V106kNpYjBDAfp74nnj+75qDOM/4udM+
         kUR3ML5Rsm9w785z61jVnJQuC+L6vHzUQ9k3N5el1pyCVTtgeYAppRPrIUHIVVicFXpS
         RhGy9d21JzcYmYRGt3rTLEBTLEn83Ajd700uBKYqyrtzfwAVNYUyzFOC/BP0s8CT6r6h
         UakTXjaxH+QC/QdcUXa77HphHuw19ZRgh3A3qi9lyp0Y+Wbj5SOpIsUDJbfXerSscwFg
         PPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=dqwoStTgCnqKB+qXABpZNFTLemE7aLy6Gjpsk/YSjII=;
        b=wizXgxvdVJJblL05RpPz6AksaMdNFXQw8PB9bn28hZxR3C0VHZlGV6s7lWlTTjPin8
         MeW2iCi2ifgyraDTz0UMRqM69yAOZ7CXaLNO4dI8JIK2YplC2ZtBieNDJYxV7NBNArim
         bgSgglvrjit8GYuxWp8DYvvZtEso8wbRzaKtg4nq6G5uJNfgS869SLwYDBX/SvsBZ49g
         LKgnmdMCOziTvqLd8kVL0hVRS1tY0ekpb9SyO2bYpRB+E15ECFHn4tMgQRNys3wKFzru
         2D8Wo8LprEmwvEdQO43zGwkuzabD9JR2R9Jh89fl0U7SNW88H1CQt6wOPWVKiCI4zvIU
         Fr0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="52039507"
Date: Mon, 30 Apr 2018 10:54:24 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok
 <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 14/22] iommu: handle page response timeout
Message-ID: <20180430105424.3f12f792@jacob-builder>
In-Reply-To: <e98a1385-9e55-c021-4e89-7d07701f4b84@arm.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-15-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180423153622.GC38106@ostrya.localdomain>
	<20180425083711.222202e7@jacob-builder>
	<e98a1385-9e55-c021-4e89-7d07701f4b84@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910205943696?=
X-GMAIL-MSGID: =?utf-8?q?1599194485289194459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 30 Apr 2018 11:58:10 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 25/04/18 16:37, Jacob Pan wrote:
> >> In the other cases (unsupported PRI or rogue guest) then disabling
> >> PRI using a FAILURE status might be the right thing to do. However,
> >> assuming the device follows the PCI spec it will stop sending page
> >> requests once there are as many PPRs in flight as the allocated
> >> credit.
> >>  
> > Agreed, here I am not taking any actions. There may be need to drain
> > in-fly requests.  
> 
> Right, as long as we first ensure that no new fault is generated (by
> using a Response Failure). Though in my opinion not taking action
> might be the safest option :)
> 
> Another thought: currently the comment in iommu.h says
> "@IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent
> faults from this device if possible. This is "Response Failure" in
> PCI PRI."
> 
> I wonder if we should simply say "Drop all subsequent faults from the
> device". Even if the PCI device doesn't properly implement PRI, the
> IOMMU driver should set a "PRI disabled" bit in the device data that
> prevents it from from reporting new faults and flooding the queue.
> Anyway, it's a small detail that could go in a future patch series.
> 
right, we should disable PRI and let future PRQ response pending on
re-enabling of PRI on the device. I will leave that to future
enhancement.
> >> If there isn't any possibility of memory leak or abusing
> >> resources, I don't think it's our problem that the guest is
> >> excessively slow at handling page requests. Setting an upper bound
> >> to page request latency might do more harm than good. Ensuring
> >> that devices respect the number of allocated in-flight PPRs is
> >> more important in my opinion. 
> > How about we have a really long timeout, e.g. 1 min similar to
> > device invalidate response timeout in ATS spec., just for basic
> > safety and diagnosis. Optionally, we could have quota in parallel.  
> 
> I agree that for development a timeout is useful. It might be worth
> adding it as an option to the IOMMU module instead of a define.
> Perhaps a number of seconds, 10 being the default and 0 disabling the
> timeout? Otherwise we would probably end up with a succession of
> patches incrementing the timeout by arbitrary values, if people find
> it inconvenient.
> 
make sense. will do.
