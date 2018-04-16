Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AIpwx48NSIdUZGWZsxP6413G/TFK2p8DKSqWER04pmV4S5WMx06+UuBDN/cgVzVho9AjJW6ZSYCh
ARC-Seal: i=1; a=rsa-sha256; t=1523858594; cv=none;
        d=google.com; s=arc-20160816;
        b=QuSSmo1N28d3xxQSQNLE2/wI3plMLk4pqW57Fe9xxu2f7AHSelZQHByLF9CPm5XxyW
         O6rY2mqp5KE/q1vlI8RgRoVzhi2ETojKxO24HC8hHQsDOmUNOYfGyE/MSYuBbtWTRZAS
         AkhyH3RXHUaMg9EyqHQpIajLaaPkkoLDTC5XaTxCDaYmFsMxmFMenoxcRy074iH2KUOH
         vq0MAapwMNrrXVdOiSqNVllYHY+vKEvHF+fDV9yzbS6PdPKJZiKWnZ0rW6q6X66N7j/u
         sIy6vWROywE5wPAwWJF9bBfrR+iG9JqjF+n4SY0noA14hMC+XPrjJCF/nA9/ocBysMVQ
         345A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=toFoDYF1N7ONODP8U/238uLqZvqpvz6SDoTGQ2QcR0w=;
        b=J54ood6AJmegqvNlW4or3dDUspuacoKaAE49Vusbiyc0AMheXcC6dhDMtUYLA5zKR9
         urJ9I+dJ+dAq0ORSAssNHnQmYs9q4bKAn7kWyfEeIK+pOXHrdbJKNMmx6G3TuBm+mfpZ
         02C+2VAfIJfptBuT/9OlmzsFwozswy/YbG4Y1u3iHPyzEaNsRzCMajBpQgXsHPZIQofo
         Re+2j7BGayS3HtDZOqubAJ254e1fI0bF6tl/3MSevXzgvl9D82AAAE5F+lDrtJ+xtOMi
         YiYXnvCSvI0SOf7RVt8+we5Wm+Mvliwn5Mhiw5sWeZpHOuATA3IyY5RsCPHqpJK3X2Kz
         8Tww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QfSP1JKL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eX+9P120;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QfSP1JKL;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eX+9P120;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Apr 2018 11:33:13 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner
 <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate
 Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Timur Tabi
 <timur@codeaurora.org>
Subject: Re: [PATCH v13 0/6] Address error and recovery for AER and DPC
In-Reply-To: <5b4e667f-bead-a007-78dd-e42d3194f232@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
 <5b4e667f-bead-a007-78dd-e42d3194f232@codeaurora.org>
Message-ID: <9301606a70a213c180d9e6764b002cf9@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027023020186?=
X-GMAIL-MSGID: =?utf-8?q?1597881549573259978?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-16 09:23, Sinan Kaya wrote:
> On 4/15/2018 11:16 PM, Bjorn Helgaas wrote:
>> On Mon, Apr 09, 2018 at 10:41:48AM -0400, Oza Pawandeep wrote:
>>> This patch set brings in error handling support for DPC
>>> 
>>> The current implementation of AER and error message broadcasting to 
>>> the
>>> EP driver is tightly coupled and limited to AER service driver.
>>> It is important to factor out broadcasting and other link handling
>>> callbacks. So that not only when AER gets triggered, but also when 
>>> DPC get
>>> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
>>> 
>>> DPC should behave identical to AER as far as error handling is 
>>> concerned.
>>> DPC should remove the devices and not to do recovery for hotplug 
>>> enabled system.
>> 
>> Is there a specific bug that's fixed by these patches?  I didn't see
>> one mentioned in the changelogs.
>> 
> 
> There is no actual bug.
> 
> We realized that DPC and hotplug is heavily integrated today. We have 
> use
> cases for systems without hotplug support but still support DPC. That's 
> the
> problem we are trying to solve with this patchset.

Adding to what Sinan said;

DPC should handle the error handling and recovery similar to AER, 
because finally both
are attempting recovery in some or the other way,
and for that error handling and recovery framework has to be loosely 
coupled.
It achieves uniformity and transparency to the error handling agents 
such as AER, DPC, with respect to recovery and error handling.

So, this patch-set tries to unify lot of things between error agents and 
make them behave in a well defined way. (be it error (FATAL, NON_FATAL) 
handling or recovery).

Regards,
Oza.
