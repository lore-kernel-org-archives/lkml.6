Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeCNSJ5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:09:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751694AbeCNSJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:09:56 -0400
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
        <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc,
        aik@ozlabs.ru, david@gibson.dropbear.id.au, fbarrat@linux.vnet.ibm.com,
        brking@linux.vnet.ibm.com
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
 <CAHp75VdOaE-efzbQV=Mtf+a1-6L5JxF10Uc+uZ+LYz3S757biw@mail.gmail.com>
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
        <desnesn@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 15:09:28 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VdOaE-efzbQV=Mtf+a1-6L5JxF10Uc+uZ+LYz3S757biw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031418-0052-0000-0000-000002C984CC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003020; UDB=6.00510421; IPR=6.00782349;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 18:09:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031418-0053-0000-0000-00005BFEC492
Message-Id: <588ea850-2b28-2b7e-6e95-13d267f05cfa@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140199
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On 03/14/2018 02:41 PM, Andy Shevchenko wrote:
> On Wed, Mar 14, 2018 at 6:34 PM, Desnes A. Nunes do Rosario
> <desnesn@linux.vnet.ibm.com> wrote:
>> Add PCI_DEV_FLAGS_QUIET_PCI_REALIGN to pci_dev_flags and use it to
>> silent PCI realignment messages if the flag is turned on by a driver.
> 
> It doesn't explain "Why?"
> Why the driver needs that?

I have written down the reason on the cover letter, but I concur on 
creating a second version of the patch's comment. Basically, all PCI 
resources on powerpc are printing out expected realignment messages 
which are flooding the systems logs.

Perhaps this would be better?
---
"Some architectures such as powerpc has aligned all of its PCI resources 
to its PAGE_SIZE during boot, thus the system logs will be flooded by 
expected realignment messages, which can be interpreted as a false 
positive for total PCI failure on the system.

[root@system user]# dmesg | grep -i disabling
[    0.692270] pci 0000:00:00.0: Disabling memory decoding and releasing 
memory resources
[    0.692324] pci 0000:00:00.0: disabling bridge mem windows
[    0.729134] pci 0001:00:00.0: Disabling memory decoding and releasing 
memory resources
[    0.737352] pci 0001:00:00.0: disabling bridge mem windows
[    0.776295] pci 0002:00:00.0: Disabling memory decoding and releasing 
memory resources
[    0.784509] pci 0002:00:00.0: disabling bridge mem windows
... and goes on for all PCI devices ...

Thus, this patch adds PCI_DEV_FLAGS_NO_REALIGN_MSG to pci_dev_flags and 
uses it to silent PCI realignment messages if the flag is turned on by a 
driver.
"
---

> 
> Another approach is to increase level of the message. Would it be
> accepted by you (in case Bjorn agrees)?
> 
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -205,6 +205,8 @@ enum pci_dev_flags {
>>          PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 10),
>>          /* Don't use Relaxed Ordering for TLPs directed at this device */
>>          PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
>> +       /* Silent PCI resource realignment messages */
>> +       PCI_DEV_FLAGS_QUIET_PCI_REALIGN = (__force pci_dev_flags_t) (1 << 12),
> 
> I would rather name it _NO_PCI_REALIGN_MSG

I concur on changing it to PCI_DEV_FLAGS_NO_REALIGN_MSG in a second 
version of the patchset.

> 
>>   };
> 

Thank you very much for your review,

-- 
Desnes A. Nunes do Rosário
