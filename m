Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeCNSW4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:22:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbeCNSWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:22:54 -0400
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ruscur@russell.cc, aik@ozlabs.ru, david@gibson.dropbear.id.au,
        fbarrat@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
 <20180314180642.GC179719@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
        <desnesn@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 15:22:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180314180642.GC179719@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031418-2213-0000-0000-0000027F8090
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003024; UDB=6.00510423; IPR=6.00782354;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 18:22:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031418-2214-0000-0000-00005969C94D
Message-Id: <30c63477-620b-3f8b-82df-fd1e34cd99b8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140201
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,

On 03/14/2018 03:06 PM, Bjorn Helgaas wrote:
> On Wed, Mar 14, 2018 at 01:34:54PM -0300, Desnes A. Nunes do Rosario wrote:
>> Add PCI_DEV_FLAGS_QUIET_PCI_REALIGN to pci_dev_flags and use it to
>> silent PCI realignment messages if the flag is turned on by a driver.
>>
>> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
>> ---
>>   drivers/pci/pci.c       | 3 ++-
>>   drivers/pci/setup-res.c | 3 ++-
>>   include/linux/pci.h     | 2 ++
>>   3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 8c71d1a66cdd..be197c944e5f 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5505,7 +5505,8 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>>   		return;
>>   	}
>>   
>> -	pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
>> +	if (!(dev->dev_flags & PCI_DEV_FLAGS_QUIET_PCI_REALIGN))
>> +		pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
>>   	pci_read_config_word(dev, PCI_COMMAND, &command);
>>   	command &= ~PCI_COMMAND_MEMORY;
>>   	pci_write_config_word(dev, PCI_COMMAND, command);
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index 369d48d6c6f1..00a538def763 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -172,7 +172,8 @@ EXPORT_SYMBOL(pci_claim_resource);
>>   
>>   void pci_disable_bridge_window(struct pci_dev *dev)
>>   {
>> -	pci_info(dev, "disabling bridge mem windows\n");
>> +	if (!(dev->dev_flags & PCI_DEV_FLAGS_QUIET_PCI_REALIGN))
>> +		pci_info(dev, "disabling bridge mem windows\n");
> 
> As far as I'm concerned, we can just remove these messages completely.
> I don't think there's any real value there.

After I found out that this was happening to all PCI devices on powerpc 
due to the __weak
pcibios_default_alignment() interface (necessary for VFIO passthrough 
and performance), I confess that this was my first approach to this 
matter; however I couldn't vouch the need of these messages on other 
architectures.

If there are no further concerns, I definitely prefer sending a second 
version of this patch only eliminating these messages and attesting the 
reason why.

Thank you very much for your review Bjorn,

-- 
Desnes A. Nunes do Rosário
