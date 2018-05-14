Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeENIAz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:00:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60437 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750750AbeENIAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:00:53 -0400
From: Fabien DESSENNE <fabien.dessenne@st.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Jean Christophe TROTIN <jean-christophe.trotin@st.com>,
        Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: Are media drivers abusing of GFP_DMA? - was: Re: [LSF/MM TOPIC
 NOTES] x86 ZONE_DMA love
Thread-Topic: Are media drivers abusing of GFP_DMA? - was: Re: [LSF/MM TOPIC
 NOTES] x86 ZONE_DMA love
Thread-Index: AQHT5ItQQSTYoFbpC0CKaMHEuUh6r6QkI0wAgAAfnACACoXDgA==
Date: Mon, 14 May 2018 08:00:37 +0000
Message-ID: <547252fc-dc74-93c6-fc77-be1bfb558787@st.com>
References: <20180426215406.GB27853@wotan.suse.de>
 <20180505130815.53a26955@vento.lan> <3561479.qPIcrWnXEC@avalon>
 <20180507121916.4eb7f5b2@vento.lan>
In-Reply-To: <20180507121916.4eb7f5b2@vento.lan>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D628BB47A8DF0541A38FCEAB49C4D57A@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E80wNZ008336



On 07/05/18 17:19, Mauro Carvalho Chehab wrote:
> Em Mon, 07 May 2018 16:26:08 +0300
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
>
>> Hi Mauro,
>>
>> On Saturday, 5 May 2018 19:08:15 EEST Mauro Carvalho Chehab wrote:
>>> There was a recent discussion about the use/abuse of GFP_DMA flag when
>>> allocating memories at LSF/MM 2018 (see Luis notes enclosed).
>>>
>>> The idea seems to be to remove it, using CMA instead. Before doing that,
>>> better to check if what we have on media is are valid use cases for it, or
>>> if it is there just due to some misunderstanding (or because it was
>>> copied from some other code).
>>>
>>> Hans de Goede sent us today a patch stopping abuse at gspca, and I'm
>>> also posting today two other patches meant to stop abuse of it on USB
>>> drivers. Still, there are 4 platform drivers using it:
>>>
>>> 	$ git grep -l -E "GFP_DMA\\b" drivers/media/
>>> 	drivers/media/platform/omap3isp/ispstat.c
>>> 	drivers/media/platform/sti/bdisp/bdisp-hw.c
>>> 	drivers/media/platform/sti/hva/hva-mem.c

Hi Mauro,

The two STI drivers (bdisp-hw.c and hva-mem.c) are only expected to run 
on ARM platforms, not on x86.
Since this thread deals with x86 & DMA trouble, I am not sure that we 
actually have a problem for the sti drivers.

There are some other sti drivers that make use of this GFP_DMA flag 
(drivers/gpu/drm/sti/sti_*.c) and it does not seem to be a problem.

Nevertheless I can see that the media sti drivers depend on COMPILE_TEST 
(which is not the case for the DRM ones).
Would it be an acceptable solution to remove the COMPILE_TEST dependency?

BR

Fabien

>>> 	drivers/media/spi/cxd2880-spi.c
>>>
>>> Could you please check if GFP_DMA is really needed there, or if it is
>>> just because of some cut-and-paste from some other place?
>> I started looking at that for the omap3isp driver but Sakari beat me at
>> submitting a patch. GFP_DMA isn't needed for omap3isp.
>>
> Thank you both for looking into it.
>
> Regards,
> Mauro
>
>
>
> Thanks,
> Mauro
