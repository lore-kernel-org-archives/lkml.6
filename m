Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AB8JxZoL2vaP2GesWMsNq16v6h7fuPWE2Ds7AF+H/flpswf0tqXqF15G2QXUp8Wma1fWrfYwYijI
ARC-Seal: i=1; a=rsa-sha256; t=1525168858; cv=none;
        d=google.com; s=arc-20160816;
        b=TzhO89DnmLuJRAmZ6wxZJPEZfdcZHFREXDopiMUwpyHV0cBOWPSLLQpIkevInytaDD
         Fr0ZqXDV6sd7PcERg3Tkb2rZNv7mC+piQt7FbGML/rHc+vi34kPvUiOXpAv+24NsoxQ5
         07uOD/QM6qBMp7Yya13cndGkZz4Pne/RgilcVseRcyUbfr+TGJBZnAVWpL63JFw7xszB
         4vLhx6VtCiPyDhcCzzKWZ27bckEkJ4lGK2VUhuJR6+9tZaFrt/gXQXqF/8mDakhmh4e+
         UiD7jPdJ0PtcMUNKfm82PVxVydSFv3gp5xXMr/64udRtJpdJdIUCu9xR2mVdokUmIu+y
         x7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=H1ZoAAzOjPRA/nG8HmB+jULNXpLl+95gL+ItcPbyd8E=;
        b=t4LSDYp30tHdFq0BCs9PDULWVFqdWHNMRyqXGtrwhIAl+CFJMnXf6a68YXrde61sRO
         A+leuHWCoksvTz2fbFwyP1usCEtxmUmDgbOw89gH/VqBp7JsZ2R4PC2nkDWh7fGo8/YG
         0D75/1CNz7F92uKi+lTcSdPpkbQF5cUqV10O17zpwyO3Ih6SJUF8PDTQFLBZCNjVjnpp
         xAGKBdwOzf7Un3BsEf3Tlrk037hQBDDCAbzQ8mR4ORQ9B1SzjYa+n8hwbzH70LBx19uy
         dxw+PQ2FXLbLhcgDTzVUhtNE4yFOSBg+6JERVj8gvwKtJw38PbihtrIBNn1qcB1oga33
         2AZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QpyjgDT2;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bw+XJ4Ry;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QpyjgDT2;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bw+XJ4Ry;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 01 May 2018 15:30:57 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v14 0/9] Address error and recovery for AER and DPC
In-Reply-To: <20180430224002.GI95643@bhelgaas-glaptop.roam.corp.google.com>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
 <f97676e307fe7a02f1f2059a140a5e32@codeaurora.org>
 <20180430224002.GI95643@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <42d49b12f1465d6d6c2fdfd182031881@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550963799959493?=
X-GMAIL-MSGID: =?utf-8?q?1599255461031780545?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-01 04:10, Bjorn Helgaas wrote:
> On Thu, Apr 26, 2018 at 11:00:52AM +0530, poza@codeaurora.org wrote:
>> On 2018-04-23 20:53, Oza Pawandeep wrote:
>> > This patch set brings in error handling support for DPC
>> >
>> > The current implementation of AER and error message broadcasting to the
>> > EP driver is tightly coupled and limited to AER service driver.
>> > It is important to factor out broadcasting and other link handling
>> > callbacks. So that not only when AER gets triggered, but also when DPC
>> > get
>> > triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
>> >
>> > The goal of the patch-set is:
>> > DPC should handle the error handling and recovery similar to AER,
>> > because
>> > finally both are attempting recovery in some or the other way,
>> > and for that error handling and recovery framework has to be loosely
>> > coupled.
>> > ...
> 
>> Hi Bjorn,
>> 
>> I know I need to rebase this whole patch-set to 4.17 now.
>> 
>> But before I do that, can you please help to comment.
> 
> My overall comment is that I think the series will be simpler and read
> better if you first change AER to do remove/re-enumerate, before doing
> anything with DPC.
> 
> This could be done by extracting just the AER part of "PCI/AER/DPC:
> Align FATAL error handling for AER and DPC" (i.e., adding
> pcie_do_fatal_recovery()) and moving that to be the very first patch.
> 
> It's a small change in terms of code size, but significant to drivers,
> and it's really the core of the series, so it would be good to clearly
> establish the policy of:
> 
>   ERR_NONFATAL => call driver recovery entry points
>   ERR_FATAL    => remove and re-enumerate
> 
> before bringing DPC into the picture.
> 
> Then the subsequent patches would all be more or less mechanical
> changes to make DPC follow the same model.

ok I have taken care of you comment, please follow v15, coming next.
I could not make that the first patch, because I needed to unify 
pci_wait_for_link function.
hence it is the second patch, but now the order looks quiet obvious and 
simplified.

Regards,
Oza.

> 
> Bjorn
