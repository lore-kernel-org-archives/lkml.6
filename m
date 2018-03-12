Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AG47ELu/y6B8TTNGkg2c/qiNVYIoYfJmwi1/AVuDc6JtkF/f9WEf6IxSQCA7F5QTLszacK2gFzeP
ARC-Seal: i=1; a=rsa-sha256; t=1520863270; cv=none;
        d=google.com; s=arc-20160816;
        b=cGjde2nKxrbhtddDCcF338G2eeZ1/nhdCXoCE262gO4kQIoOFEaG2C+Rvh7pM4BbVD
         v5NRZNZaqzPyVO3jkXY8h4S+xyhrSVQ9/ozPa+3EwPDBRgefJVRFmhJojBR73KJYwOV/
         10Cx4gov+zKJLFIeqGOcHyS0VbJaU2No/p82hFWHn3aye5wrr3WJ1+9y2fBsGUAZHB36
         mMCFTWzCuGUbiNwXqoglTdWOCxi22V5YbaN2gTquvbMBxlPmqOZ3poNX1gZUGfTBJKdm
         Wt/LkQXOMMr06b6BfwICAbVRJ137OdW3J/OLPeHjyDWRLDdY3kYAs6nTOoKOFen49bIl
         5pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=2S3X0ujorlr3pUBXj69i0h2H2dJUptZo1oetdDhqfQA=;
        b=vQyuLhKiy1+peT7b8B+6BoHAHbJrOOTMmvFrQJp6W4APnhnr4bCorFX6JhhDcXmn9g
         lmbFqHKzOHPh1F0Sqlv9yG5RP4725kHP4AC8RPUQAgHzL5fD0dtz8ym5eGOlfr110mkn
         heHrKa3GBqZWhn5iW1aFHRum7XVAUn+dHrucBthw5VHRf0Z2Xdp9M3WActTSXgFghXPK
         eqhpHcnU2cX+DGEdThKeZEA+dhcQa7sni7b2sW1bgFQygP7egVPOGRqBSb4kA2nKHqjv
         +Bj6t7uh/Me0gUgf2vPvqwAw/N2BnEbfmhq1+JSMaz6QmJrVt+QD4MaMqMuS59ljXI22
         7KXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=AfQdgO+P;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=KLCnutf+;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=AfQdgO+P;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=KLCnutf+;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Mar 2018 19:31:08 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
In-Reply-To: <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <7130ab5d568b721ee59f029cf0d5072c@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594740723969455375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-12 03:33, Bjorn Helgaas wrote:
> On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
>> This patch set brings in error handling support for DPC
>> 
>> The current implementation of AER and error message broadcasting to 
>> the
>> EP driver is tightly coupled and limited to AER service driver.
>> It is important to factor out broadcasting and other link handling
>> callbacks. So that not only when AER gets triggered, but also when DPC 
>> get
>> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
>> 
>> DPC should enumerate the devices after recovering the link, which is
>> achieved by implementing error_resume callback.
> 
> The main point of this series is to call the driver error handling
> callbacks (error_detected(), mmio_enabled(), slot_reset(), etc.) when
> DPC events occur.  We've always called them for AER events, but prior
> to this series, we didn't call them for DPC events.
> 
> That's a good thing -- we should treat DPC events as much like AER
> events as possible.
> 
> This series does make it more obvious that there's still a big
> difference between AER and DPC handling -- for DPC, we remove and
> re-enumerate all the devices, but we don't for AER.
> 
> That difference has been there since the beginning of DPC, so it has
> nothing to do with *this* series EXCEPT for the fact that it really
> complicates the logic you're adding to reset_link() and
> broadcast_error_message().
> 
> We ought to be able to simplify that somehow because the only real
> difference between AER and DPC should be that DPC automatically
> disables the link and AER does it in software.
> 
> Bjorn

Ok, so here is slight modification which I will do and will post final 
looking patches.

1) do not enumerate the devices after link is up (since AER does not do 
it)
2) remove the call to pci_stop_and_remove_bus_device(dev); because now 
DPC also makes use of driver's callback. (like AER does)

above 2 changes should make behavior of DPC identical to AER.

Regards,
Oza.
