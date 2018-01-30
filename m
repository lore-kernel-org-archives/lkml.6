Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeA3KL4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:11:56 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26879 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751722AbeA3KLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:11:52 -0500
From: Benjamin GAIGNARD <benjamin.gaignard@st.com>
To: Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "Andy Gross <andy.gross@linaro.org> ; David Brown"
        <david.brown@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-soc@vger.kernel.org" <linux-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>
Subject: =?utf-8?B?UmU6IENvbXBpbGF0aW9uIGVycm9yIHJlcG9ydCBmb3I6IGRyaXZlcnMvZmly?=
 =?utf-8?B?bXdhcmUvcWNvbV9zY20uYzo0Njk6NDc6IGVycm9yOiBwYXNzaW5nIGFyZ3Vt?=
 =?utf-8?B?ZW50IDMgb2Yg4oCYZG1hX2FsbG9jX2NvaGVyZW504oCZIGZyb20gaW5jb21w?=
 =?utf-8?Q?atible_pointer_type?=
Thread-Topic: =?utf-8?B?Q29tcGlsYXRpb24gZXJyb3IgcmVwb3J0IGZvcjogZHJpdmVycy9maXJtd2Fy?=
 =?utf-8?B?ZS9xY29tX3NjbS5jOjQ2OTo0NzogZXJyb3I6IHBhc3NpbmcgYXJndW1lbnQg?=
 =?utf-8?B?MyBvZiDigJhkbWFfYWxsb2NfY29oZXJlbnTigJkgZnJvbSBpbmNvbXBhdGli?=
 =?utf-8?Q?le_pointer_type?=
Thread-Index: AQHTi7/6cCLfG9S430qZBKphJ7+B0qOMPTOA
Date: Tue, 30 Jan 2018 10:11:46 +0000
Message-ID: <e804928d-deb9-668a-7012-2843ba85285e@st.com>
References: <a2a6bf12-529c-cb20-c69f-106d34e1204a@st.com>
In-Reply-To: <a2a6bf12-529c-cb20-c69f-106d34e1204a@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AABBCC0BB6DBD9459651CA045945B055@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UABxkJ002388


On 01/12/2018 05:11 PM, Arnaud Pouliquen wrote:
> Hello Andy,David,
+ Arnd

I have the same issue on drm-misc-next.
Does Arnaud's fix make sense or should we update/change the way of how 
we compile the kernel ?

Regards,
Benjamin
>
>
> I'm facing a compilation error using COMPILE_TEST config,
> could you crosscheck the issue.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> commit: b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d :Linux 4.15-rc7
>
> reproduce:
> ---------
>    #apt-get install gcc-arm-linux-gnueabi
>    #apt-get install gcc-arm-linux-gnueabihf
>
>    apply .config (in attachment)
>
>    #make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j4
>
>
> error:
> -----
>    CC      drivers/firmware/qcom_scm.o
> drivers/firmware/qcom_scm.c: In function ‘qcom_scm_assign_mem’:
> drivers/firmware/qcom_scm.c:469:47: error: passing argument 3 of
> ‘dma_alloc_coherent’ from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>    ptr = dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
>                                                 ^
> In file included from drivers/firmware/qcom_scm.c:21:0:
> ./include/linux/dma-mapping.h:549:21: note: expected ‘dma_addr_t * {aka
> long long unsigned int *}’ but argument is of type ‘phys_addr_t * {aka
> unsigned int *}’
>   static inline void *dma_alloc_coherent(struct device *dev, size_t size,
>                       ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:310: recipe for target
> 'drivers/firmware/qcom_scm.o' failed
> make[2]: *** [drivers/firmware/qcom_scm.o] Error 1
>
> patch to fix compilation issue:
> ------------------------------
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index af4c752..8dfbe61 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -448,7 +448,7 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t
> mem_sz,
>   	struct qcom_scm_mem_map_info *mem_to_map;
>   	phys_addr_t mem_to_map_phys;
>   	phys_addr_t dest_phys;
> -	phys_addr_t ptr_phys;
> +	dma_addr_t ptr_phys;
>   	size_t mem_to_map_sz;
>   	size_t dest_sz;
>   	size_t src_sz;
>
> Thanks,
> Arnaud
