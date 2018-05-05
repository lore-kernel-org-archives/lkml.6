Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeEEKDd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:03:33 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:41791 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEEKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:03:31 -0400
Subject: Re: [PATCH] pci: endpoint: Replace mdelay with usleep_range in
 pci_epf_test_write
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
References: <1523365446-31563-1-git-send-email-baijiaju1990@gmail.com>
 <20180504162932.GA16953@e107981-ln.cambridge.arm.com>
CC: <bhelgaas@google.com>, <nsekhar@ti.com>, <john@metanate.com>,
        <shawn.lin@rock-chips.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <de84ea55-5949-dec5-ad8b-5845b99285c0@ti.com>
Date: Sat, 5 May 2018 15:33:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180504162932.GA16953@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 04 May 2018 09:59 PM, Lorenzo Pieralisi wrote:
> On Tue, Apr 10, 2018 at 09:04:06PM +0800, Jia-Ju Bai wrote:
>> pci_epf_test_write() is never called in atomic context.
>>
>> The call chain ending up at pci_epf_test_write() is:
>> [1] pci_epf_test_write() <- pci_epf_test_cmd_handler()
>>
>> pci_epf_test_cmd_handler() is set as a parameter of INIT_DELAYED_WORK() 
>> in pci_epf_test_probe().
>> This function is not called in atomic context.
>>
>> Despite never getting called from atomic context, pci_epf_test_write()
>> calls mdelay() to busily wait.
>> This is not necessary and can be replaced with usleep_range() to
>> avoid busy waiting.
>>
>> This is found by a static analysis tool named DCNS written by myself.
>> And I also manually check it.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I'd request Kishon's ACK on this.

sorry, missed this before.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Thanks,
> Lorenzo
> 
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>> index f9308c2..2f0642e 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>> @@ -237,7 +237,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>>  	 * wait 1ms inorder for the write to complete. Without this delay L3
>>  	 * error in observed in the host system.
>>  	 */
>> -	mdelay(1);
>> +	usleep_range(1000, 2000);
>>  
>>  	kfree(buf);
>>  
>> -- 
>> 1.9.1
>>
