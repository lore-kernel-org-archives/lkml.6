Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbeBNIMX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:12:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754549AbeBNIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:12:21 -0500
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org,
        geert@linux-m68k.org, stefan.kristiansson@saunalahti.fi,
        tomi.valkeinen@ti.com, schwidefsky@de.ibm.com,
        dri-devel@lists.freedesktop.org, Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
 <CGME20180202080007epcas5p306896fe66e4bbf4bf5f8d91306a5d016@epcas5p3.samsung.com>
 <246f92c9-15dc-223f-59d9-b2f0756cdf5e@de.ibm.com>
 <1610039.4trOurtpys@amdc3058>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Feb 2018 09:12:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1610039.4trOurtpys@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021408-0020-0000-0000-000003F57CD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021408-0021-0000-0000-000042880B0C
Message-Id: <3f34e137-7a34-a48f-0f27-993e28af1705@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802140097
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I added all three patches to my next tree
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=next
This will hoepfully reveal any fallout.

Would be good to have an ACK from the score, tile and um maintainers in case
they verified that this change did not break anything.



On 02/08/2018 02:11 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> [ dri-devel ML & arch/[score,um] Maintainers added to Cc: ]
> 
> On Friday, February 02, 2018 08:59:57 AM Christian Borntraeger wrote:
>> On 02/01/2018 07:41 PM, Farhan Ali wrote:
>>> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
>>> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
>>> "Graphics support" menu for S390. But if we enable VT layer for S390,
>>> we would also need to enable the dummy console. So let's remove the
>>> HAS_IOMEM dependency.
>>>
>>> Move this dependency to Opencores framebuffer driver which would fail to build
>>> with CONFIG_HAS_IOMEM disabled:
>>>
>>> ERROR: "devm_ioremap_resource" [drivers/video/fbdev/ocfb.ko] undefined!
> 
> "Graphics support" menu covers other things (i.e. DRM), I assume that
> they were also checked to not break due to this change?
> 
> Moreover it seems that after this change "Graphics support" menu will
> be also enabled (besides s390) for score, tile and um architectures,
> I assume that this is okay?
> 
>>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>>> Tested-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>
>> This also enables several PCI based graphic device driver on s390.
>> This makes no sense but they all compile fine so I guess this is ok.
>>
>> I think patch 2 and 3 are clearly for the s390 tree, patch 1 seems trivial
>> Also ccing Bart. Can we maybe get an ack to carry this patch also via the s390
>> tree?
>>
>>
>>> ---
>>>  drivers/video/Kconfig       | 1 -
>>>  drivers/video/fbdev/Kconfig | 2 +-
>>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>>> index 3c20af9..41e7ba9 100644
>>> --- a/drivers/video/Kconfig
>>> +++ b/drivers/video/Kconfig
>>> @@ -3,7 +3,6 @@
>>>  #
>>>
>>>  menu "Graphics support"
>>> -	depends on HAS_IOMEM
>>>
>>>  config HAVE_FB_ATMEL
>>>  	bool
>>> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>>> index 2f615b7..ec9c9ce 100644
>>> --- a/drivers/video/fbdev/Kconfig
>>> +++ b/drivers/video/fbdev/Kconfig
>>> @@ -966,7 +966,7 @@ config FB_PVR2
>>>
>>>  config FB_OPENCORES
>>>  	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
>>> -	depends on FB && HAS_DMA
>>> +	depends on FB && HAS_DMA && HAS_IOMEM
>>>  	select FB_CFB_FILLRECT
>>>  	select FB_CFB_COPYAREA
>>>  	select FB_CFB_IMAGEBLIT
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
