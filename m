Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeBSQjI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:39:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752973AbeBSQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:39:06 -0500
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com,
        b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
 <cce8b082-c780-3559-4491-c39eb09482b0@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 11:38:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <cce8b082-c780-3559-4491-c39eb09482b0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021916-0028-0000-0000-00000931BC00
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008560; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992069; UDB=6.00503973; IPR=6.00771415;
 MB=3.00019638; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-19 16:39:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021916-0029-0000-0000-000039AA35BE
Message-Id: <6cae85dc-76d5-1b92-ab13-a5e441eb84a0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/19/2018 11:25 AM, Thomas Huth wrote:
> On 19.02.2018 16:47, Farhan Ali wrote:
>> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
>> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
>> "Graphics support" menu for S390. But if we enable VT layer for S390,
>> we would also need to enable the dummy console. So let's remove the
>> HAS_IOMEM dependency.
>>
>> Move this dependency to sub menu items and console drivers that use
>> io memory.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>> ---
>>   drivers/video/Kconfig         | 21 +++++++++++----------
>>   drivers/video/console/Kconfig |  4 ++--
>>   2 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index 3c20af9..8f10915 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -3,7 +3,6 @@
>>   #
>>   
>>   menu "Graphics support"
>> -	depends on HAS_IOMEM
>>   
>>   config HAVE_FB_ATMEL
>>   	bool
>> @@ -11,20 +10,22 @@ config HAVE_FB_ATMEL
>>   config SH_LCD_MIPI_DSI
>>   	bool
>>   
>> -source "drivers/char/agp/Kconfig"
>> +if HAS_IOMEM
>> +	source "drivers/char/agp/Kconfig"
>>   
>> -source "drivers/gpu/vga/Kconfig"
>> +	source "drivers/gpu/vga/Kconfig"
>>   
>> -source "drivers/gpu/host1x/Kconfig"
>> -source "drivers/gpu/ipu-v3/Kconfig"
>> +	source "drivers/gpu/host1x/Kconfig"
>> +	source "drivers/gpu/ipu-v3/Kconfig"
>>   
>> -source "drivers/gpu/drm/Kconfig"
>> +	source "drivers/gpu/drm/Kconfig"
>>   
>> -menu "Frame buffer Devices"
>> -source "drivers/video/fbdev/Kconfig"
>> -endmenu
>> +	menu "Frame buffer Devices"
>> +	source "drivers/video/fbdev/Kconfig"
>> +	endmenu
>>   
>> -source "drivers/video/backlight/Kconfig"
>> +        source "drivers/video/backlight/Kconfig"
>> +endif
>>   
>>   config VGASTATE
>>          tristate
>> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
>> index 7f1f1fb..0023b16 100644
>> --- a/drivers/video/console/Kconfig
>> +++ b/drivers/video/console/Kconfig
>> @@ -85,7 +85,7 @@ config MDA_CONSOLE
>>   
>>   config SGI_NEWPORT_CONSOLE
>>           tristate "SGI Newport Console support"
>> -        depends on SGI_IP22
>> +        depends on SGI_IP22 && HAS_IOMEM
>>           select FONT_SUPPORT
>>           help
>>             Say Y here if you want the console on the Newport aka XL graphics
>> @@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
>>   
>>   config STI_CONSOLE
>>           bool "STI text console"
>> -        depends on PARISC
>> +        depends on PARISC && HAS_IOMEM
>>           select FONT_SUPPORT
>>           default y
>>           help
>>
> 
> Maybe config VGA_CONSOLE should depend on HAS_IOMEM, too? I think you
> can hardly use a VGA card without IOMEM, can you?

True, you can't. And I did think of adding the dependency for VGA, but 
VGA already is fenced off by many (almost all) architectures and I 
wasn't sure if it would be necessary. But I can add it.

> Anyway, this approach now looks reasonable to me, so either way, feel
> free to add my:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thank you so much for reviewing. Appreciate your feedback :)
