Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeBWGLC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:11:02 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:51037 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBWGLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:11:01 -0500
Subject: Re: [PATCH 1/2] pci: endpoint: Free func_name after last usage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
 <20180221124707.26308-2-embedded24@evers-fischer.de>
 <20180222181901.GA13694@e107981-ln.cambridge.arm.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9cdc8c1c-b448-b00b-d5b8-b664bd96f856@ti.com>
Date: Fri, 23 Feb 2018 11:40:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180222181901.GA13694@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On Thursday 22 February 2018 11:49 PM, Lorenzo Pieralisi wrote:
> On Wed, Feb 21, 2018 at 01:47:06PM +0100, Rolf Evers-Fischer wrote:
>> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
>>
>> This commit decreases the number of jump labels and ensures
>> that the next commit doesn't increase the number of occurrences
>> of 'kfree(func_name)'.
>>
>> Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1
>> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
>> Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
>> ---
>>  drivers/pci/endpoint/pci-epf-core.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
>> index 766ce1dca2ec..23d0e128d1a5 100644
>> --- a/drivers/pci/endpoint/pci-epf-core.c
>> +++ b/drivers/pci/endpoint/pci-epf-core.c
>> @@ -220,9 +220,10 @@ struct pci_epf *pci_epf_create(const char *name)
>>  	*buf = '\0';
>>  
>>  	epf->name = kstrdup(func_name, GFP_KERNEL);
>> +	kfree(func_name);
> 
> I am certainly missing something but what if we reworked the code
> and just:
> 
> kstrdup(name, GFP_KERNEL);
> 
> once instead of allocating another local copy (that we then have to
> free) ?

name will be something like pci_epf_test.0 and in epf->name we want to just
have pci_epf_test.
> 
> Reworded: why
> 
> epf->name = func_name;

memory should be allocated for epf->name before it can be initialized. IMO
without kstrdup, there will be a null pointer exception.

Thanks
Kishon
