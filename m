Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04410C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0F220837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="rOpaV9WT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0F220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeHaBxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:53:18 -0400
Received: from mail-bl2nam02on0107.outbound.protection.outlook.com ([104.47.38.107]:23904
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727088AbeHaBxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UiEEKNsBgSfnjhNPrYGJ11QrcPhPB3mD2v+agmapXw=;
 b=rOpaV9WTzIyAyQKRe0iCkc89NbBd50yWfR139AzFnN587YFKpu8ynlYYmhuu+NC9Zeo0xW6e9ZVdIDAdmqnWXEtM/5B5ybwRpic2GDiErcTPg6nwEUKr3adcZ7ofBkytNontRF0GngDzz9jnC77E43O6923FAVlmrQTeNWi64DI=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 30 Aug 2018 21:48:59 +0000
Date:   Thu, 30 Aug 2018 14:48:57 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mips: switch to NO_BOOTMEM
Message-ID: <20180830214856.cwqyjksz36ujxydm@pburton-laptop>
References: <1535356775-20396-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535356775-20396-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0034.namprd21.prod.outlook.com
 (2603:10b6:3:ed::20) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0073d2df-eace-473e-8dea-08d60ec264c9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:lucEvCMwsy3zRfRYJFbTTjmQm0DzXMWaDDjPXiugNRXpjHLuVgP3HYvUrTrUF6sijJCa0NXEpdrhwHk6b8JQJbvKU56rr3VawJfIgaFnuw1PuLZl72rDqJR3qRh2ymGn2UX4XVer3ufxK508d3cvpYFWSGfQsDRERtlonQBKXPs7PnbS2aUTA7jnsFCSlRH+0sjvZP6rvCizWyBSkp0+4p0d+x89n9/EASP3lQHE/zi0HCmbPCP0CbD5Yi6rfS+v;25:c87inbXeBLZ9uxTWYn8LoBf5971Uqt/hRct3Gnn950V713nAeXWq7ojf8dFxc4rpBOe188+h7dikqMFlvUO1GBD/T6v5QTJJOIJ/Gd5Nuq/zQDCSNk2MoMv/Q9px741RsgZ6ZSnRnNxGnx48LBsTD4F27Nw8symNdD+8DAC6YVEBGHSOYXELjx3JHFLfYYJzIgbIqvdf1zY34/+yOp3wgc03joFMkA4CyKJCz9EHfV5cJ0IssWmKja7Olc4W4hi+TMKsdMeh+hhe0oXXmqzx0mF5+7synQzhtaPQobfCp1MVR0S76mNaYXn1Ikw5Ot5Kg/QSg7wb5xBN6xA6QadPTg==;31:nuedaEpSgHmwZXQDXSIreEP4Z5O5NEZR4jW17Ar5jpQnsn9LfvPjJ/GeX2wlvEXas+1agluLSeL0Mr2pBWyoqzIoOXu4aFeOMfa2NWLm9IWvXBKluHXDI87Eg11mdKdcB+CFgl+Zqi3kvLSigfy0a66je+ocz3A6iGSvlNpMUvEa7nCDQ13/5l368uObvwgor/20sbBjPhcQnJBDhcIAaxPLUalP4zeuJg3o1XQtkbI=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:NPjBF/xS3N5V/o+821g7xQbBDg2B9lHycJeFqq/E1uHWTE8snWX15iFl4a2dbMwXDEn/ABITmaqqBIzTI8JXzITq3V57FtTHusO9gmL46O7d4VvQFpNowuFtBigWfBEcoqr4h7qfwrcRF++Dy5rEBoAt2oDZ9RYRwlzYPsA6NBMaYdFlZWARPKQ6E3qMrv4N8yIwChI6M7ROKCanFBx74Kd5rtXRfOuMfSQNbLSfYIV3XMsSutYuen4nOiSD+H6k;4:gV8cWvpjKx+GuT8x8BjsOOLcYiJxh0r2PAgRXa+8gOV2UTUt7r5yVbrv+SpjQdBVPhP5BV/hbKwXDqa3O7Gc6xC7OkRSB3hEMEUawwYJiZsQSDWEdwGBZlnbFhtrzjGYT1gJ52+FXcyBlmzHNN6HJOwkmB+YWUkqqIk8Q55E6QI05N7aRtmh05KbO8t1Ug1PfplpwE5nyHk4w9+5Uq/VXHG8H7OQ9ymgzEl45lsZl2gi3K7MFYbltuJXkmABlGv5HfpeACxepTpWET2VVYR5FtrmLnJeftrB6s5ZKCal3QwQ2GExvBFiomEG7ZktDusa3vhQcZUHsDqN4Sgxntkvf8128Njt3IJSRidCtkOVuFg=
X-Microsoft-Antispam-PRVS: <BYAPR08MB493331C69DCB41B7DE758CF1C1080@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150)(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(136003)(346002)(39850400004)(396003)(199004)(189003)(47776003)(44832011)(68736007)(186003)(33716001)(66066001)(478600001)(58126008)(956004)(39060400002)(16586007)(97736004)(446003)(476003)(316002)(6916009)(2906002)(4326008)(25786009)(54906003)(11346002)(486006)(6246003)(1076002)(50466002)(23726003)(3846002)(6116002)(6346003)(386003)(42882007)(81166006)(229853002)(575784001)(81156014)(5660300001)(53936002)(8936002)(105586002)(106356001)(33896004)(8676002)(9686003)(16526019)(76506005)(6486002)(76176011)(6496006)(26005)(305945005)(52116002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:QXA0sz7rdK8H3+OXHUsmJ9UyLswxYLRMxrnpSKuDq?=
 =?us-ascii?Q?3MyhRRKC5WP0HxP0Y+LRX8ceFhkuMMLx/8Z95Aj69Fjwxdgj/XRAB0MzSXUv?=
 =?us-ascii?Q?hGyBUBhC+i9Gp6o3sSe+stxo84cFfqdf4N9VrT51kxq5G7cI5VHppANxK7tj?=
 =?us-ascii?Q?GBSIIyB+Aj6XgpSfsaOhLLATXPhmAJDKDtLnvYm64Y6TWCyCCjmLimmwPTKY?=
 =?us-ascii?Q?Ys5BuHgOsbD4qWR+2tSUD2quvUYDIUBzsmFjVGkLLXcWnm0EvLdRIwjh/BnJ?=
 =?us-ascii?Q?Qk+ZTKYytCQQyaTZA5VGlpbxdiYT+m/rlxm6jRwRgoXXRht9qMfEN+o3yEdr?=
 =?us-ascii?Q?+zAXijsquRs6UWRhH+lD3EicSN/kmIm9S2x1su0s38rm6A3ffa3CdzYwbwcw?=
 =?us-ascii?Q?zxIkVWXt6/DbMMWtAMav742KCzWitUM63/RrAaAvG/ma9BQQq5qgdZ2Ok2Dw?=
 =?us-ascii?Q?bOQcny3x3DUbF8/tKLNrtbIaHgu1M4WneOoe2E+rdkJZfnrOo5Q1t6i3tCF7?=
 =?us-ascii?Q?04bE4qLXkpI43BxhU423N3ihfQZJsbhm2sJiubdp6PrMfw6PbzzXOiFq0s5o?=
 =?us-ascii?Q?YmzHL0zgdC4uUg6ckolEDRTCmlpJHs873h0n2Q/XgYQi3u1c+MvZGbHdF2w8?=
 =?us-ascii?Q?rJrkAxUmCrlVQhfWxH3gwBF8Td+fEjED8VFLj0Vp/omkunMV6ssGdIKk7yaC?=
 =?us-ascii?Q?TBMrC97yes3JS4tYqbiV4VSxXR5LOKlHAo4uM4zydN9Go2D2ZUVfc+PXbWCO?=
 =?us-ascii?Q?1Kfsg3LLn3Mq6palYnb0eKDJt8jRFrsdff8Yt3qM72WrKmNKMaP+Bljp3h5L?=
 =?us-ascii?Q?Jxs0ZVZU+vlUit5DdALloxM3QGMeFjqeQeVgbhDs2jncZC1NrrT23INeLmqX?=
 =?us-ascii?Q?w8tmj/doHW9Y6grrdZGwKgFmpajupOOLjDV4sur9ETUo+XZY5BPGV5oqryMP?=
 =?us-ascii?Q?TEJHjowJ/L3MMMk5eEWTXI0Pj9zwL5hRo9ONLah190y3TM40clUgg1D18h2P?=
 =?us-ascii?Q?aQDDCbrNVDsizk+LUGFNIKymooV+Ro05IIas0vdfyYPCODJI2U/kcllkUFsQ?=
 =?us-ascii?Q?CYnT5OZmez92xbdpoWGh0ypnevuNyoURjMGx3BBuBGKhLlQu0Di/yQlFb3Fw?=
 =?us-ascii?Q?URylK2sH6asR5tgR1+OzHzinxeRUGlAtzS76IYJ1z5HD/hdEAU5/h6rw5kd6?=
 =?us-ascii?Q?8LjbfXUEkcBsbXIYs9brj2qDLN936lmtHlAAxs4TbAjP47OzKDuqBTkH0apX?=
 =?us-ascii?Q?YJ3EjkvrJPrifPHfiyOFWJDBdtPU3WDvBgqskQCZKVvR4L+YwEVD5x45kUE2?=
 =?us-ascii?Q?w4Wien8lXBIW/mnLoWFT6HUlbEQJ8Dp68dmz6YuFlLXNXYLiEp4CZmofxlUH?=
 =?us-ascii?Q?1aL7A=3D=3D?=
X-Microsoft-Antispam-Message-Info: pRtjonRIMEeXiz69ALoDecFzhNOEKsZZFIm1a6Txi9diFsyMHnxWvgsWAriAmuzkiYkm6eRqCmlS3r0C833GvDsibVqZEzGdX6i9i5SfOTBhW6XHo2Y7Ae5wNXugb6GiGzx66pXY7kdjD5aj2XQQFc/BddSMM62Dx3WHuTGxF9Nzn7jGPUEg/5HbG7mOXjaGgIDD1v/3Ol6PbKjm96AnCxPjjbhyrRwsw83kjKprjTU0Iyxde0B7oweM92WyOpBb8T88ELf/Y3ElVDjn2e1fsIlhTvGp0gNcZqIQc4HWBXvHpw+oJdak8qeAG1TJa+6pXF6frbDO0zhC8AzI6PYsERNE3+Gj+pxEHZECOppXZYY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:gUi0PI7/Ty0W3EdOSIXeYIvBOqhWLxkEpW0tYIhUa0JthMW8N77KuR4H8vNV8oqwmpoaBLcxM9SIySmvFoHnqNd4FpqbVpPgzhCQplKgT12yl7u8jrpDMgBztw0xk6/i9HDoYRU2I5bbrgKlPIc4w9sv9E7dCj5SMWNQQ+Y+jjLfCP7YshTi85IW0Q70CcZpyjscCzpKP3evAT7PErMWUNCp8eGy9n41CTrZR7Qhl5l9hVFzXKnhmh6EGryGAsEdP9RQzU4ZtEBhGRRZVL239qBfoNyCHbmBsDL5JBNRDmnFmCPAokBAEf8DF39DL5CzTX5H9s+K1zXe1ntB3uDUXrcgHiEkCWr7TNFR5LcTSCTawpGA66nZsVILc3co8ei/LrZVNG7yiJ1V7lR4LCEpatWpYqb471C+lTRrXcKOKxbxuL8x3AfbSoTL2PMm0Fg70p9+VUZhm9bNfl3mseCU9A==;5:PtNgXjiKIkMSo2Y5ZdtSN8e4qjvkAI84zSpStnkbci+ujjdbYdMTISl0Srf+7TTOMZiJz41dtW1V17c+PzWxBXwNO9V1YipEhyBCax2yaDGUKCgw0+ht/C0GiKjtiQ954pCAcDQAuPulgmvYoObttcJWFp+O/SleGHbVc79lVKk=;7:NhSXGskzEhwbThJcEXfiF9u4+SijkbmwP22mwn8puvfacnjVSGs7irA0PtBDBfGruVkRn5N36/oJXdt3NOYa01mw/UDFxK0OqrtWXYaRon7y+k8cmTVPnbpEMT2OYoG6BntKttXoFAqTq80gtJJfgkfGgUaGqnqF3n1IBYsupPnbOD/UGzVXie3d59nfOw4ZM9oQN85SDMeVfTqEsK9w3nIldYCEGX0QVLInllVw8k19aojiI7Vas7gBmVdCoGGg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 21:48:59.4535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0073d2df-eace-473e-8dea-08d60ec264c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, Aug 27, 2018 at 10:59:35AM +0300, Mike Rapoport wrote:
> MIPS already has memblock support and all the memory is already registered
> with it.
> 
> This patch replaces bootmem memory reservations with memblock ones and
> removes the bootmem initialization.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
> 
>  arch/mips/Kconfig                      |  1 +
>  arch/mips/kernel/setup.c               | 89 +++++-----------------------------
>  arch/mips/loongson64/loongson-3/numa.c | 34 ++++++-------
>  arch/mips/sgi-ip27/ip27-memory.c       | 11 ++---
>  4 files changed, 33 insertions(+), 102 deletions(-)

Thanks for working on this. Unfortunately it breaks boot for at least a
32r6el_defconfig kernel on QEMU:

  $ qemu-system-mips64el \
    -M boston \
    -kernel arch/mips/boot/vmlinux.gz.itb \
    -serial stdio \
    -append "earlycon=uart8250,mmio32,0x17ffe000,115200 console=ttyS0,115200 debug memblock=debug mminit_loglevel=4"
  [    0.000000] Linux version 4.19.0-rc1-00008-g82d0f342eecd (pburton@pburton-laptop) (gcc version 8.1.0 (GCC)) #23 SMP Thu Aug 30 14:38:06 PDT 2018
  [    0.000000] CPU0 revision is: 0001a900 (MIPS I6400)
  [    0.000000] FPU revision is: 20f30300
  [    0.000000] MSA revision is: 00000300
  [    0.000000] MIPS: machine is img,boston
  [    0.000000] Determined physical RAM map:
  [    0.000000]  memory: 10000000 @ 00000000 (usable)
  [    0.000000]  memory: 30000000 @ 90000000 (usable)
  [    0.000000] earlycon: uart8250 at MMIO32 0x17ffe000 (options '115200')
  [    0.000000] bootconsole [uart8250] enabled
  [    0.000000] memblock_reserve: [0x00000000-0x009a8fff] setup_arch+0x224/0x718
  [    0.000000] memblock_reserve: [0x01360000-0x01361ca7] setup_arch+0x3d8/0x718
  [    0.000000] Initrd not found or empty - disabling initrd
  [    0.000000] memblock_virt_alloc_try_nid: 7336 bytes align=0x40 nid=-1 from=0x00000000 max_addr=0x00000000 early_init_dt_alloc_memory_arch+0x20/0x2c
  [    0.000000] memblock_reserve: [0xbfffe340-0xbfffffe7] memblock_virt_alloc_internal+0x120/0x1ec
  <hang>

It looks like we took a TLB store exception after calling memset() with
a bogus address from memblock_virt_alloc_try_nid() or something inlined
into it.

This was with your patch applied atop the mips-next branch from [1],
which is currently at commit 35d017947401 ("MIPS: ralink: Add rt3352
SPI_CS1 pinmux").

Thanks,
    Paul

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
