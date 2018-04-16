Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AIpwx48gKI2wwpFj8XEyjfiDSBrJZMbFIDGS7LCcCei/NgKZ/VCvcLYAh5gDuOSXeY7Zgs+A8frM
ARC-Seal: i=1; a=rsa-sha256; t=1523885275; cv=none;
        d=google.com; s=arc-20160816;
        b=yw0IaCywTzhK5frwGeiM/FfyHkdp8UIJz/xtGzd8XAWAZ7DrtMFQrwQ9P/7nlu+zv7
         NPvnv/IzF4C6SMNqb0S054TyD6EuTkHZMkIFjJli6bLDPP4VNIEuxB/S0vy7KyJqvjkn
         zC2eiLur+8JFlAJQUfgzXGIY91CVAYXsna7Zn6N7kQecedvwBEHInishnynPTyuy1IM7
         AcaJgkJ81RCx2BxwOrunjzyLkSN79AWVF7gr64e1EYksKrnvejokjD1mcqbOKMW/PgUj
         BbEutfeMQMJb0QpZxgjsLmxnz0e9BIg/z58is/cCh7cyFzBERy5QqTy3DdgayOGl1pLb
         fUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=JfTczeZpQsCJqoMoxv7l8VbbaYevggjUIC2UPggSTXs=;
        b=L1izkb7RU1MFfLd0fk4LXvAZ/4RqoxboVNKZplMGv5VN56C/ZDF+xgGsfni7BvNv7x
         yUcnkhcG2tDnIiUAHhy5CSbLiyBYbFhFHyWcuYrKI0QCAF9dLmKOivPKKDiHWdt4Ykof
         tTzEEXzrfdjQKBbIOhGJ3sPKQtysdG5nyxI6BAytheTfmqyR+YHYuDSh4OZgrATb56IU
         65kTEnPgOtOdlZ7O5tivDNZiMcpu8FiHelXcg0m352bhvmQvEMvnydNM7YhMn+sukGEH
         OEbm0TirzWtSKaKju0Q7W3zdZX0sA4RYv3LIPrl7KA9nTi3XRLSOvB6NKc29nURMA/5w
         hFFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13AC82177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 16 Apr 2018 08:27:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 0/6] Address error and recovery for AER and DPC
Message-ID: <20180416132753.GA28657@bhelgaas-glaptop.roam.corp.google.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
 <5b4e667f-bead-a007-78dd-e42d3194f232@codeaurora.org>
 <9301606a70a213c180d9e6764b002cf9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9301606a70a213c180d9e6764b002cf9@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027023020186?=
X-GMAIL-MSGID: =?utf-8?q?1597909527314995561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:33:13AM +0530, poza@codeaurora.org wrote:
> On 2018-04-16 09:23, Sinan Kaya wrote:
> > On 4/15/2018 11:16 PM, Bjorn Helgaas wrote:
> > > On Mon, Apr 09, 2018 at 10:41:48AM -0400, Oza Pawandeep wrote:
> > > > This patch set brings in error handling support for DPC
> > > > 
> > > > The current implementation of AER and error message broadcasting
> > > > to the
> > > > EP driver is tightly coupled and limited to AER service driver.
> > > > It is important to factor out broadcasting and other link handling
> > > > callbacks. So that not only when AER gets triggered, but also
> > > > when DPC get
> > > > triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
> > > > 
> > > > DPC should behave identical to AER as far as error handling is
> > > > concerned.
> > > > DPC should remove the devices and not to do recovery for hotplug
> > > > enabled system.
> > > 
> > > Is there a specific bug that's fixed by these patches?  I didn't see
> > > one mentioned in the changelogs.
> > > 
> > 
> > There is no actual bug.
> > 
> > We realized that DPC and hotplug is heavily integrated today. We
> > have use cases for systems without hotplug support but still
> > support DPC. That's the problem we are trying to solve with this
> > patchset.

Apparently there's a problem with systems that have DPC but not
hotplug.  It will be extremely helpful if you can articulate what that
problem is and include it in the appropriate changelog.

> Adding to what Sinan said;
> 
> DPC should handle the error handling and recovery similar to AER,
> because finally both are attempting recovery in some or the other
> way, and for that error handling and recovery framework has to be
> loosely coupled.  It achieves uniformity and transparency to the
> error handling agents such as AER, DPC, with respect to recovery and
> error handling.
> 
> So, this patch-set tries to unify lot of things between error agents
> and make them behave in a well defined way. (be it error (FATAL,
> NON_FATAL) handling or recovery).

I totally support this objective.

Bjorn
