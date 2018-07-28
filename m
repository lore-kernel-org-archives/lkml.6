Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B325C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E5520893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="M97pCoFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E5520893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbeG1Udy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 16:33:54 -0400
Received: from mail-sn1nam01on0125.outbound.protection.outlook.com ([104.47.32.125]:33792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730158AbeG1Udx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 16:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtCZg4UhnZKz+HXrBPhNjS2Bq4QEpLeMFs2y+MVtVgU=;
 b=M97pCoFqT3i1SvggBVjnCXcsRRA6xj+iDVAVT7upPj4EoVDajyVhFIvUXHA7uf6BWCk8tGJXHajaJSRlGdeBNSx+ynPurVfZELt3mZLcKI0J0aYve9Ph3UZq4VEUfqKU/UClBH5LCO2daearSeaiLWa2VtaBarBNa+eBi6Y4bI4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (96.64.207.177) by
 SN6PR08MB4942.namprd08.prod.outlook.com (2603:10b6:805:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Sat, 28 Jul 2018 19:06:21 +0000
Date:   Sat, 28 Jul 2018 12:06:18 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove mips_swiotlb_ops
Message-ID: <20180728190618.sq5xbuc2hnthmkhl@pburton-laptop>
References: <20180727172606.21253-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727172606.21253-1-hch@lst.de>
User-Agent: NeoMutt/20180716
X-Originating-IP: [96.64.207.177]
X-ClientProxiedBy: DM5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:3:c0::29) To SN6PR08MB4942.namprd08.prod.outlook.com
 (2603:10b6:805:69::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21cacb98-2396-4fe2-a757-08d5f4bd353c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4942;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;3:KUw0Xpj9vsCHuBHk33myxIaOloWWZQj6SJNbbCRuy35FBCdY6caJWfJP6dWtobmHzrUTl1olMKbBwD4uBWVu92arZlxcvhmV/vTALthtfP0DPjcG49J0kj6GTczWKpO/VhUAYAmjKudMFaD29M04Ih03pN4+1k0AoiwUegcwmjDrTMj4OwC+jILDLH0FSu129Y93ge4URc3Cgjt6GVcby+Gl6inPriKkP9e/qbrJ4vltFY72IOg82l2Zz/Pkpp/I;25:3uQyl2hwr9uvkZWVftgw/0bAgh+kcaQ4lY4Qhim722c2Ce3ufziqCukGQAaEzdkAPD+m4zERxW3xquEjVrWl8fy8FdClEU3JAz3+7fT7bi4lr/8q7IC0PUTA/7FE1d79yaikCnkw9mxNYPAqAaSqvJHbppXU5OQo4kgys+Wu6NipcDGHn8YiSf3sMbCnynNl9VhSnExgx4izjRKJrZnb4Nk2luhJyXp9VKPADlx/ZX1wOkY4eOqM8zd3AmMNtr2mcyP1p0RNW7pW7EsAxGNiWKm0puuMgGvjSNZVJbDMyXtwGir/LWCP53kiqzbJYpr40//vT3FUsqQVrTH1fGEosg==;31:HdQv27sLkVgP0c3nn/q0IBwWGVYW3GR1ivcTtXxa41ZmPLfjaGNAyIT8Xim/0hg0wmyuhAj9wBn7FR+HeWY7BZ1PD7SrI8vlwnfM0Jjlujlbv4o+c1Lw5lByuEm6JBKeCk3M7gpJWClj4wXm+hO35vZKDwXacytGorFVdYghzWmQGqfGHDBvxX+fZOukkJWJXqNr64VzfeNLlrLrAPhTYtxfQaB1J0mUFJW1V05Cmbw=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4942:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;20:1z9Mms/9GwPq/1UpxcobPBtppSQ/wzp0NA8oKoJFNefXMR0vr7WgDWeh+KXrGacEUT52SOe7iec0UJaEjickEj9mzMjJKh0ark7Dcyi8WldP+Bk453jNPFauvDe6iGjoSC/zicmilwHrxX8PYECu2+nVkuV1va3F9YowDzLsFJNyzz/9TMqK3gwsoFY+tVhh3a6zHoTPCTdP430IrA+7H1hM9dLOZxAyDfWdCAAUu40PalkTQTXIRlaWa6+OrtVK;4:9jez6V7F22Cw9MsOpq/SewUvYbiqLjMZCgl/aI8C+02J1JIzWqEZ61P6w/U2fs73DNzPIz1DLDD9o+bD8d7jUKVb3028R7sOJJnSItxiwg7ULLVSgZFEANMeWVtwgN+CRD+GR8ZX7DAJZTVz7xNV21oZ+urPWUnq5Rnuqte3mZm3kOkbOOtjXnBHWugBA7NhgVDNYYt9aAMOxMq1fYyfSW4OSe1Kkl4T6yMU46TgYythkDtgFN3lcAwGYsJ5jLgM0VN1WW9Besin232+oTbMMA==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4942BE5060F4AFE93C80FD7EC1290@SN6PR08MB4942.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4942;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4942;
X-Forefront-PRVS: 07473990A5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(376002)(396003)(39840400004)(136003)(366004)(199004)(189003)(6246003)(14444005)(47776003)(66066001)(25786009)(33716001)(4326008)(9686003)(53936002)(2906002)(44832011)(229853002)(6486002)(6666003)(6916009)(106356001)(105586002)(97736004)(23726003)(6116002)(3846002)(5660300001)(50466002)(1076002)(8676002)(81156014)(81166006)(76506005)(7736002)(305945005)(26005)(16586007)(16526019)(58126008)(186003)(76176011)(33896004)(316002)(478600001)(68736007)(386003)(8936002)(446003)(956004)(476003)(11346002)(486006)(6496006)(54906003)(52116002)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4942;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4942;23:BykAFA0pseKTKIoclWnqJpLAbn43BUA+kJki09j5c?=
 =?us-ascii?Q?MBmXxhvU/DlHV977qLKrTZi6XOkYTRc7+pwpmKFhsiWnUHLpUlSkYG8uzCNI?=
 =?us-ascii?Q?HD0i0yhn2B7zRwPMzrqKTRpOFnv/R8idtfnFSt8DJ24C4bdifSxUgEY+8DFp?=
 =?us-ascii?Q?mkRJHC9iu0mAh8n7FHjezfuNz6h12FmhikcOwjzHqnCD3/C3A7ScAH9tj3q1?=
 =?us-ascii?Q?1DY7mHN5sqnlrREKqQRfMIrd18iu9hMhlTOhj7kFRchjrLXTSEXLs7v1QiC8?=
 =?us-ascii?Q?LJyWli4cghHJL+BJdXzSBChD+xTZDt6BRIGwvrRvpVzfH/xxmk/NYn5RiIjv?=
 =?us-ascii?Q?W++oV8PGVs0wPwEKxsvhkrYRMHRLFiwofxSt27oqSyGv/nbNgnzS1XLxm1ih?=
 =?us-ascii?Q?HbdY3Lxe0ejevpbQYiQq80SoOx3WJS84dX6wYfWsw2fRMcnYfsroWC7ftVuZ?=
 =?us-ascii?Q?UizzgRd4rz5Vy1c8DunZ3t8qKiF/pkhZoYrSZO0ySnrnJBKGzQXbP2qdROEh?=
 =?us-ascii?Q?fYGm9zX4rz8QI/Ps1k5gU6r7Bbf0sox+LWFlmIDrs3Ft52dmf8UVvsoqDr2N?=
 =?us-ascii?Q?itJq/cHlRnionE0tX38b7hWhsO3+4QLEKHSDXaLgLmvBbV8hX2OsRKdy7puX?=
 =?us-ascii?Q?or0AjUIlfTxc3qVk0+fCL9n2asbdMGV7z1GU/5tYbamCAMGMCrunZzQhcd6T?=
 =?us-ascii?Q?oSstUCQHP3Fsv7Cs0NmFr3168r3WawPZEJpBqIMybI9ntAHUssPbQ7dLiky0?=
 =?us-ascii?Q?y0Uk5//a6xNZ9LKvKG9Bql8rR16I8bJF1F1f0G0G9hVjIx8ol7MVhvEOw8SD?=
 =?us-ascii?Q?AG+Ovvmu2mR4BmCDnKgp6WLln8y9j6cMXNIte6E1KCP3dYXy/r/x+6i4SAOu?=
 =?us-ascii?Q?Z0aNumsp+yCNjf+14HEN5jD3FCFuapHN4JdpyfTTW9fL1FY21HrM6GAtFMwu?=
 =?us-ascii?Q?1t+cI1gctGYba5rtGbW9NoWdMIQ6108k5nVvH67OS4VLjhStZKDLEZq5Vl6R?=
 =?us-ascii?Q?S/PzNp1a6i0ejRXBNhygDgZR/Wy4T+MK1K9ZVgg1rk57z5z+tCaS8a1LqkDV?=
 =?us-ascii?Q?oADTtC3Kjmi1BS5B0a7AlkMs+oPfrIKIpb6qAxJfAeIJdav5RLL3nYeX66BM?=
 =?us-ascii?Q?trcFG/6xDYJvcFR0yCzq3+J1dTF0iCabhucjCsc7knj8On2OlyUUBq4177Ho?=
 =?us-ascii?Q?rYvTkm/kg0Y9J6cWamvN7YMgIfXA48ixEOfZCCnOXmuwtXvire01/CCiTe6G?=
 =?us-ascii?Q?n1kiVCxb155297UyLgw6NIE9xTl0h0j2MJhV1FYCcI/W/+gJRumGER0ZGtd1?=
 =?us-ascii?Q?NtyVJDBAA0bSPLWyjajd4jxp7pRH9bBotF34RDbGsTU?=
X-Microsoft-Antispam-Message-Info: v5Q7F4QS98926TlMI/eYs7IVW8NotiNv2f08LM3drCXluFn3b6cFU32nytsX6pf8J3Xr/mo2Ps5/LAiJkdxgrTKzvSmAuJtuCmOlmWz/JSdO8Ehr+R19F88T5hBzCWUZ9cCfYUm+3WJeHOKGV6kNCKTFGJMlPz4hL7e71vRTgFPKlw+eP82W9zYR4Oqm7czcKjI3RRCPGVbGHjR8HQGQDnw1y5DcVbv1VwDuVyuYp3cBntsmTLHSODgCB2jHjr0DETix+C8nb+/bUjODBDLF0/O5yjuUwx3wIxCW1DguvqeejS493CeHFXCRMYtJVkXiuRhww9UQfeh9bzyZYSKPPjjNxSWZJaKHIaMKXFZwtdw=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4942;6:na8lUu8OIADe7bzGWX9FVfLu6ygPSugGRHkGtSiL6WpB58j6lXawROThpBbsShQxrfcXZxMMsVIHItPhrMHOcoufwZ15BIgRS7paBNOZbm88DFb7P/Elagv3rLJVdXclnIMMGi+vj1ADCJQcgQgx2pGb5jh9I9x5u6wsjVkWvYu7kfmELvBLuTNyeiieL7l1y99bH8pg5LYJI6gCOFqXl/kvxCF92bMFB7k/plENbArZB3KLWo7849pHPTepAZAub00/vmDw36pwtvD1YYRw0Z4TLtFVaeK2ggrV/uLVq9ftw9jfruZmTXRNzDzPiuxKJ+gBCDFjcuam2B0sNxgBqEqxtJoE873Wv8O8RsEA626eUrwJ7yV3tJHQ6l3d71hCYSqfnELfqq75qBmfhbNjae9lxAnmqCD6TiJtmddxdgXYmZ2vHVy+G7D/1KWfNoLJw2oux5UEA3e6ofNCby7Fsw==;5:f0n+EF6cHtyRaZSclaaQOKmNMWrOH8QMMoNAwtYOGfpnCvXqABy52jMPubsUVR0Xv240EIAizVDjCj0NPL7+1lsUFoMj4TW8zTqlO6Xqw+cVcio0V/ydfLR/5nKBk+HWpy/DlVTNebmny9I0+b0Tx5AAHfe6WTDrZGkMX1mTZlY=;7:5eULDpBY0bR40xdUx0SW2Lbcz7CKa+TWvHRMXYHQMZ0EglyraEyeLuuKiHYcKgN7FPHgI1zp5HSslUG8fj/jnr58KxfLhQibtSc2W/WR8dsqlSjZd06FK1giz14uOkqfbYST5tQHU+mz5DqFfShzqgVcOOeXakRRr40HyUYxlVRr3g8/X0PQcQ3iBcsgn4qqgT/lZ47OfosEs8M2kYbJUSet0wjWg2yEPigAstrXVwkHlBHfdqUVCxvW+nUxTYgt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2018 19:06:21.9456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cacb98-2396-4fe2-a757-08d5f4bd353c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Jul 27, 2018 at 07:26:06PM +0200, Christoph Hellwig wrote:
> mips_swiotlb_ops differs from the generic swiotlb_dma_ops only in that
> it contains a mb() barrier after each operations that maps or syncs
> dma memory to the device.
> 
> The dma operations are defined to not be memory barriers, but instead
> the write* operations to kick the DMA off are supposed to contain them.
> 
> For mips this handled by war_io_reorder_wmb(), which evaluates to the
> stronger wmb() instead of the pure compiler barrier barrier() for
> just those platforms that use swiotlb, so I think we are covered
> properly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/include/asm/dma-mapping.h |  3 +-
>  arch/mips/mm/Makefile               |  1 -
>  arch/mips/mm/dma-swiotlb.c          | 61 -----------------------------
>  3 files changed, 1 insertion(+), 64 deletions(-)
>  delete mode 100644 arch/mips/mm/dma-swiotlb.c

Thanks - this looks reasonable, but needed a small tweak to gain the
definition of swiotlb_dma_ops from linux/swiotlb.h (as riscv & unicore32
do) in order to avoid build failures.

Hooray for even more deleted code :)

Applied to mips-next for 4.19.

Paul
