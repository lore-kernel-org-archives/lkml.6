Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AIpwx49+THGxXNzgWRVhC/5IwWERrLkFups6sTAIrF7ynDjaAGOl8zrNKjJ+/OusA9ypS2lVOC+s
ARC-Seal: i=1; a=rsa-sha256; t=1523850832; cv=none;
        d=google.com; s=arc-20160816;
        b=Z7xXJ3KpkX2zI6xdfXLJGOXsoRrVq16gU5gkY5GV9DYnY3qi3Pg4Udzv6d9g224fkz
         FTcklsm4SaSQWam8b3P9KVWpfEZyDaCIt9LlZafp29QVE7UfQZ+qCN9mxgQHS+GeFOwX
         nMtTyRwifOHKe7l2S4is1YCAFgsT4anMF9NJT8742Ti7nzTnmOayp8dUgeDll60Bjt2E
         Fooh8oRPDuG2J3k5CsdpIytkCdaj7osM81CZpJuETyKQnB1dO+BDHdlEbRcn8XljrKmN
         H/1sj0osNDZ0S3Goen7Zj/ZA+5WqkoYg5Ae016yPMB9wdX65PuKyNtfdCUdiKQ2oYU70
         MGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=+efReypN3hTj02hQrvkgiwBI5fp6sZC0QnQUJx9lV/s=;
        b=lNASO+I/mJJt10wVxPKMLsHGv1KVnVkXW7mrA75SUrMhqwyY4MbDxxsWwHdsUnA1QO
         dqJIobw2BptCOoaYZ2Sssy42XQuNkyJ7hnqiHzNNsV4x+m8ujti69FXNdSeJI0dWNzoC
         xKgBAFFfbMbudajh3p1zQ5whXdd4GiozxVSp5PGqBrlWLuI/Aaqtzb8JI9oIK79dDtoL
         5znkNV3CyQEHemKaTDGdOsxdPINPfoh7jG2H0NeLjavXIbvYGwwWFPu/+Npb6nwdkYwZ
         MTo30Iwq+bXsyGDgjURdbv7Kk0Ub/2nQxd3foVBMxedRd0D4cBXy+o4MI0aedyzOvj2J
         OcKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RDKzMO7c;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GFZFUNrk;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RDKzMO7c;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GFZFUNrk;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD1CF6072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v13 0/6] Address error and recovery for AER and DPC
To: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5b4e667f-bead-a007-78dd-e42d3194f232@codeaurora.org>
Date: Sun, 15 Apr 2018 23:53:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027023020186?=
X-GMAIL-MSGID: =?utf-8?q?1597873409975635238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/15/2018 11:16 PM, Bjorn Helgaas wrote:
> On Mon, Apr 09, 2018 at 10:41:48AM -0400, Oza Pawandeep wrote:
>> This patch set brings in error handling support for DPC
>>
>> The current implementation of AER and error message broadcasting to the
>> EP driver is tightly coupled and limited to AER service driver.
>> It is important to factor out broadcasting and other link handling
>> callbacks. So that not only when AER gets triggered, but also when DPC get
>> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
>>
>> DPC should behave identical to AER as far as error handling is concerned.
>> DPC should remove the devices and not to do recovery for hotplug enabled system.
> 
> Is there a specific bug that's fixed by these patches?  I didn't see
> one mentioned in the changelogs.
> 

There is no actual bug. 

We realized that DPC and hotplug is heavily integrated today. We have use
cases for systems without hotplug support but still support DPC. That's the
problem we are trying to solve with this patchset.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
