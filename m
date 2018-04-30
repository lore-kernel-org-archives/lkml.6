Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZp114TcDo+9UKfoyNRQgOIjickgQfw+l9nv4j9rNTKMm2+ZywpssriA+OV8BuDyZmSc2iXN
ARC-Seal: i=1; a=rsa-sha256; t=1525128005; cv=none;
        d=google.com; s=arc-20160816;
        b=l5AZXFEOyEWPP22gOa9fFcUaVB5eDAazB04nx9LkS722G+C0M5FxSNCu8f/YbSy7VW
         4SJQKeXuJ7aFp/c9UkIbt/9db9T1dEsCndZiNdcTCOUuzf0j7YuHAYW04RtgNdj95FCg
         V2v9fENhvFjEC/dqNudbeHmGONdij9JrN5BykzzuZDS5yZSwEn6FE3rWVd2fXRYESC/C
         D/hgOpp4tW/RPFOpYyI3TH/k+nKlAi7jxmMx3PsZLekWJp+8KgQYw4cN2Mg9X+coFe7+
         r/IOfiz2M68U9Jd4nEkQuQ2m+WlGe8+b2bLFsqo/Ras25NqVcQiX7r6tFsVrJvqpp9pq
         S+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=Lzi6ClPv4KjzwYPeShSfP3u2IGSUpWwPgSzcpTMkr2s=;
        b=aH5xCQLcY0WNArUstd/ckydZRZ//lpsv9vq4GAElP3si1lgv2BePWZG4yGL0ZKFie2
         M4GJJXmWtImDhs7D5zrezSK54Ik/TUJUAYm746zMcp171CfE7bpMqzIZxOmcQn8onx/B
         bnXxQWByv4QcH0S1ky6Vsxv3Ue+cpW5JJjoXE6bTI0Wq4p54wy/U4QsVSOqSNcfgvAIx
         yZ34OCcee3b4Rf7pf1+Z3OeMlWNIvO0jozT/ZWdvipGmwbQYKgM2QgldEK6zTDf5OSeE
         aaL9mFcChh/78YdBVwgBcDMLzkz4lGG4nBo3/VqeLynkvdPLu9iNJqmzc7+yxBYrQN5m
         LM6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D50122E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 30 Apr 2018 17:40:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v14 0/9] Address error and recovery for AER and DPC
Message-ID: <20180430224002.GI95643@bhelgaas-glaptop.roam.corp.google.com>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
 <f97676e307fe7a02f1f2059a140a5e32@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97676e307fe7a02f1f2059a140a5e32@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550963799959493?=
X-GMAIL-MSGID: =?utf-8?q?1599212623350347230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 11:00:52AM +0530, poza@codeaurora.org wrote:
> On 2018-04-23 20:53, Oza Pawandeep wrote:
> > This patch set brings in error handling support for DPC
> > 
> > The current implementation of AER and error message broadcasting to the
> > EP driver is tightly coupled and limited to AER service driver.
> > It is important to factor out broadcasting and other link handling
> > callbacks. So that not only when AER gets triggered, but also when DPC
> > get
> > triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> > 
> > The goal of the patch-set is:
> > DPC should handle the error handling and recovery similar to AER,
> > because
> > finally both are attempting recovery in some or the other way,
> > and for that error handling and recovery framework has to be loosely
> > coupled.
> > ...

> Hi Bjorn,
> 
> I know I need to rebase this whole patch-set to 4.17 now.
> 
> But before I do that, can you please help to comment.

My overall comment is that I think the series will be simpler and read
better if you first change AER to do remove/re-enumerate, before doing
anything with DPC.

This could be done by extracting just the AER part of "PCI/AER/DPC:
Align FATAL error handling for AER and DPC" (i.e., adding
pcie_do_fatal_recovery()) and moving that to be the very first patch.

It's a small change in terms of code size, but significant to drivers,
and it's really the core of the series, so it would be good to clearly
establish the policy of:

  ERR_NONFATAL => call driver recovery entry points
  ERR_FATAL    => remove and re-enumerate

before bringing DPC into the picture.

Then the subsequent patches would all be more or less mechanical
changes to make DPC follow the same model.

Bjorn
