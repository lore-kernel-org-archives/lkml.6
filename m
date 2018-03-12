Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AG47ELsqRG0Vmlr2xUI/JXxvzP/ivdNnkT+FatGeD1kWjhxsv2n+wEAzkZ1k+kzMrJkLL9nvDxEh
ARC-Seal: i=1; a=rsa-sha256; t=1520877282; cv=none;
        d=google.com; s=arc-20160816;
        b=vxuhWp64WdyimlNLyil6t4uFVw9D/e6RwiMMO5v7EKM8juCm4FSrmEhf1GKGewIkO0
         O1KENqp6cq4xz7327v2GjU13j7UJM6MFzCUQyGXCbeyV7p5HZWYUj+3PIThqJP/otkOC
         e0a2AkZeMcUzUPurTVUfmlwJlYPQtZFsf3bFb6Ja/sKTJzWtnf039LB+X7QZQs/Wb2D+
         YWBmP9jqYmYz+GMAcAhXyLBJoUsEj8awld4kFSMU/+osvEgPAwLONAd6BPIfRSh2JNmu
         RDMdbqh4B7rYHDu5c6vKdnUyVCNDvVQYQPDLyKDDNeI46yXWrO1fHMqaRWtFFJbwRShk
         4ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=dIChs5uiM69yEwOkZ1BZfLmCZzjOOj9CpJvNrO4S3RY=;
        b=FIKOZudRrZPCYucN8RIKe0KkW+BLRi8h2VgoRL6mSEWHkHnBBG1urs9j5wuCxfkW0U
         lc4YN/i6J25fmQYVyTyRzJCuDrlyAsQ2lyI7UUrxqcToWoRnkPzimP95SdwQmavi1f5q
         IxTe/cudDAGSSyoyJShlPddGQqFLY34oeB/bCQSaP7utL/Si+QDxHVGRSYbrPA6wweoi
         rlO64GwpHbHlsndCfEmrbtpgeCpLbhk4R4YUhueANPjpMPFWMAMh9uvyZdHL3rxvsfT3
         wkzzGH2bsyfEf+FsidD25VER/yjyKy1tFCexXtT0WcZ2DvmnPHn2UQ/oYlGxtbzTH8oF
         2W3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,462,1515484800";
   d="scan'208";a="23659933"
Date: Mon, 12 Mar 2018 11:56:30 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: poza@codeaurora.org, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
Message-ID: <20180312175630.GF18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
 <20180312145823.GC18494@localhost.localdomain>
 <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
 <20180312173301.GD18494@localhost.localdomain>
 <57d0b245-aecb-1518-c8bb-df8b69a86bcc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57d0b245-aecb-1518-c8bb-df8b69a86bcc@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594755418079766630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 01:41:07PM -0400, Sinan Kaya wrote:
> I was just writing a reply to you. You acted first :)
> 
> On 3/12/2018 1:33 PM, Keith Busch wrote:
> >>> After releasing a slot from DPC, the link is allowed to retrain. If
> >>> there
> >>> is a working device on the other side, a link up event occurs. That
> >>> event is handled by the pciehp driver, and that schedules enumeration
> >>> no matter what you do to the DPC driver.
> >> yes, that is what i current, but this patch-set makes DPC aware of error
> >> handling driver callbacks.
> > I've been questioning the utility of doing that since the very first
> > version of this patch set.
> > 
> 
> I think we should all agree that shutting down the device drivers with active
> work is not safe. There could be outstanding work that the endpoint driver
> needs to take care of. 
> 
> That was the motivation for this change so that we give endpoint drivers an 
> error callback when something goes wrong. 
> 
> The rest is implementation detail that we can all figure out.

I'm not sure if I agree here. All Linux device drivers are supposed to
cope with sudden/unexpected loss of communication at any time. This
includes cleaning up appropriately when requested to unbind from an
inaccessible device with active outstanding work.
