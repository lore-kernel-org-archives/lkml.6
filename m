Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AIpwx49M5Wd3UN6kNKNs54y0iCKM4G3Pbwh8a3pgrKDaebpurliIR/+PEgBW0Khq0ecumhYgev77
ARC-Seal: i=1; a=rsa-sha256; t=1523887966; cv=none;
        d=google.com; s=arc-20160816;
        b=Y6LNI9X+1Hb2O7L2FAE8zbULr2CevlhUDaQR6XXZcUJVVqD/dGxfY9IQpjctz1ZW2J
         2g/qKjCtHEejMim6GYYaIBq+1+4TWAWAbMWd74hlN7jkHCbVukE6MfuPY/7tfAQXVUJn
         oYR2DIRXHOH6h97jj6+rUh1+54ZljHTfqmENGB5qS4jyt8NOlnM029As7iKjLanlZPeJ
         5aBBlH3BLyn/4niQgAgAWjtZuwavpNwuDAE0GtrkkihUjDIM94fQU+S+xYUnMCVXhalP
         CDVMDqGCvO7iw8ceSCr4q93oCGsqjKap/Pc3KDVe1yo62la8qRJHAwuLa7ZN1bwxu0SP
         8Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=7RMGiAhUD4/D0kNjrtHygRC0sYeBlcVJi9S5jSE6f/M=;
        b=HcmfIaq4+n0SB8KZL7rshpyNeeM7VXGX3ZzDnwZciyTU1WvvhlCaqOioP/5ROebSmE
         +umcokB16V8aBpjShmp2ht+Mb7fpWy+TeS1rfocM8GaHckiWTrQjWXA25SB7apkRdDxK
         l+iMt213unraQDQWQsaLpXPpIEu9piVaGTRLH9YBAOe/stDB3Qe3VH8W3IcQDh5JyLZN
         7ZStOimW0XSxV6BgbFuJCJO7hWwpF7tTuljwB3LLqO99XNCjWmdktmBeB+0rB1oqJkgT
         XCVmIWwmQt/MlXYIC4vJ0Szu9nHWj4QOgri2/Hj9wVuTPddDj+xkiqwQuQKfRNvr0zKR
         gLpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eNbRUkZf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eNbRUkZf;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eNbRUkZf;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eNbRUkZf;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Apr 2018 19:42:44 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner
 <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate
 Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Timur Tabi
 <timur@codeaurora.org>
Subject: Re: [PATCH v13 0/6] Address error and recovery for AER and DPC
In-Reply-To: <20180416132753.GA28657@bhelgaas-glaptop.roam.corp.google.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
 <5b4e667f-bead-a007-78dd-e42d3194f232@codeaurora.org>
 <9301606a70a213c180d9e6764b002cf9@codeaurora.org>
 <20180416132753.GA28657@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <0b94f5a75fbfec9063e2c07006be3fbb@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027023020186?=
X-GMAIL-MSGID: =?utf-8?q?1597912348070514749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-16 18:57, Bjorn Helgaas wrote:
> On Mon, Apr 16, 2018 at 11:33:13AM +0530, poza@codeaurora.org wrote:
>> On 2018-04-16 09:23, Sinan Kaya wrote:
>> > On 4/15/2018 11:16 PM, Bjorn Helgaas wrote:
>> > > On Mon, Apr 09, 2018 at 10:41:48AM -0400, Oza Pawandeep wrote:
>> > > > This patch set brings in error handling support for DPC
>> > > >
>> > > > The current implementation of AER and error message broadcasting
>> > > > to the
>> > > > EP driver is tightly coupled and limited to AER service driver.
>> > > > It is important to factor out broadcasting and other link handling
>> > > > callbacks. So that not only when AER gets triggered, but also
>> > > > when DPC get
>> > > > triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
>> > > >
>> > > > DPC should behave identical to AER as far as error handling is
>> > > > concerned.
>> > > > DPC should remove the devices and not to do recovery for hotplug
>> > > > enabled system.
>> > >
>> > > Is there a specific bug that's fixed by these patches?  I didn't see
>> > > one mentioned in the changelogs.
>> > >
>> >
>> > There is no actual bug.
>> >
>> > We realized that DPC and hotplug is heavily integrated today. We
>> > have use cases for systems without hotplug support but still
>> > support DPC. That's the problem we are trying to solve with this
>> > patchset.
> 
> Apparently there's a problem with systems that have DPC but not
> hotplug.  It will be extremely helpful if you can articulate what that
> problem is and include it in the appropriate changelog.
> 
>> Adding to what Sinan said;
>> 
>> DPC should handle the error handling and recovery similar to AER,
>> because finally both are attempting recovery in some or the other
>> way, and for that error handling and recovery framework has to be
>> loosely coupled.  It achieves uniformity and transparency to the
>> error handling agents such as AER, DPC, with respect to recovery and
>> error handling.
>> 
>> So, this patch-set tries to unify lot of things between error agents
>> and make them behave in a well defined way. (be it error (FATAL,
>> NON_FATAL) handling or recovery).
> 
> I totally support this objective.

Thanks Bjorn, I will include this objective in Changelog along with 
Sinan's text.
I am not clear on one last thing Bjorn; which is;
do we need last patch ? patch-6 which handles hotplug case.
Also I think we could take this patch-set as basic changes/attempt to 
unify the code which it does.

And, in the next follow-up patches we can improve upon the things such 
as,
whether to do different actions for FATAL cases and NON_FATAL cases. And 
then I can make needed changes to AER and DPC
Please let me know how this sounds.

> 
> Bjorn
