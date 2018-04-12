Return-Path: <keith.busch@intel.com>
X-Google-Smtp-Source: AIpwx48BKtyW04kj6bLKA7U5QCzrNLoovag6miCpL53SqBX3keNpYA2YF5lGVrLeIfiUkIccRUgk
ARC-Seal: i=1; a=rsa-sha256; t=1523545298; cv=none;
        d=google.com; s=arc-20160816;
        b=Y1aeqpMJ4bi8amAMnz41QqqEMH8qdEs148J92jVwf+OVbkVXK71lUxfvNx2uEtnZiD
         6Qaxt/EKClrNujAvgHvRCs+huVuM2Cm4yTOR0hsDj4m8XBPytOyieZq7ic/gP0zxGDJW
         uK8O+WXbq7HsTMJlb6/q6uJb3ZV2NG3gMnOXMnMUDwltDbPHuesw444EvT0b5i8W8epm
         w7ehmWWVNBex42VMoBDdSGxzBKYr/ApCRMFWEwv1ARBFbUD8jXBplkusHFepjlXltBAd
         177u6+/+meVsTVbxckHvjtvjah35O92X9zZMrCCFIUjNZobQGqpVE/M2GF1mA6Zn18j3
         bSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5XixfCIOSLkLdq/I1HY0XyEStHYil+f4lO2Epmmr4us=;
        b=BP+xi2YMa628Vwk83xO2S1dE3ksA7IZx38vGM83TDu/IN7E2EoXy4TAQILSgcuOlGJ
         iZVO6z0Aw+p8qrwv10FPwK/PgnAUaMQ2OEsqiTykWhvvQtOUOIGUIVg0SUmjo5SFqx7Q
         byfIXI5tbUONS/gSTuW+vzGTAjQfhKCqJ5aULLWZJAHAlF8iFKD5hJsltadUiu3F62VJ
         irTTacaZlK4d+O+4KsUxvWs35CpTSK4eMr4DRY+XSAmaFk8F6kh7qQA7PzUVKzrM39f3
         wrp0x0hTdVM1zQD2tq+aiDe+m0O6rJ/ybOAkOF7qMRJXk1GuPHUar2yuHMT8HyzLHYgT
         HRQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=keith.busch@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of keith.busch@intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=keith.busch@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,442,1517904000";
   d="scan'208";a="36741649"
Date: Thu, 12 Apr 2018 09:02:31 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
Message-ID: <20180412150231.GD4810@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412143954.GB4810@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597553034787175193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 08:39:54AM -0600, Keith Busch wrote:
> On Thu, Apr 12, 2018 at 10:34:37AM -0400, Sinan Kaya wrote:
> > On 4/12/2018 10:06 AM, Bjorn Helgaas wrote:
> > > 
> > > I think the scenario you are describing is two systems that are
> > > identical except that in the first, the endpoint is below a hotplug
> > > bridge, while in the second, it's below a non-hotplug bridge.  There's
> > > no physical hotplug (no drive removed or inserted), and DPC is
> > > triggered in both systems.
> > > 
> > > I suggest that DPC should be handled identically in both systems:
> > > 
> > >   - The PCI core should have the same view of the endpoint: it should
> > >     be removed and re-added in both cases (or in neither case).
> > > 
> > >   - The endpoint itself should not be able to tell the difference: it
> > >     should see a link down event, followed by a link retrain, followed
> > >     by the same sequence of config accesses, etc.
> > > 
> > >   - The endpoint driver should not be able to tell the difference,
> > >     i.e., we should be calling the same pci_error_handlers callbacks
> > >     in both cases.
> > > 
> > > It's true that in the non-hotplug system, pciehp probably won't start
> > > re-enumeration, so we might need an alternate path to trigger that.
> > > 
> > > But that's not what we're doing in this patch.  In this patch we're
> > > adding a much bigger difference: for hotplug bridges, we stop and
> > > remove the hierarchy below the bridge; for non-hotplug bridges, we do
> > > the AER-style flow of calling pci_error_handlers callbacks.
> > 
> > Our approach on V12 was to go to AER style recovery for all DPC events
> > regardless of hotplug support or not. 
> > 
> > Keith was not comfortable with this approach. That's why, we special cased
> > hotplug.
> > 
> > If we drop 6/6 on this patch on v13, we achieve this. We still have to
> > take care of Keith's inputs on individual patches.
> > 
> > we have been struggling with the direction for a while.
> > 
> > Keith, what do you think?
> 
> My only concern was for existing production environments that use DPC
> for handling surprise removal, and I don't wish to break the existing
> uses.

Also, I thought the plan was to keep hotplug and non-hotplug the same,
except for the very end: if not a hotplug bridge, initiate the rescan
automatically after releasing from containment, otherwise let pciehp
handle it when the link reactivates.
