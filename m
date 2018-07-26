Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AFF20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="GJOajr5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AFF20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeGZKxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:53:44 -0400
Received: from mail-eopbgr710047.outbound.protection.outlook.com ([40.107.71.47]:12448
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729031AbeGZKxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdW0CyMkLYobrM5ooAmgtCBtfqAnL4dGRSntUnVVBYk=;
 b=GJOajr5PZyidtproZcx0v8gP9OVketWEqUgjUU0XmDCW3xuxGiQX3hjegvawGY2Rw3eEH3gowLxOWSOvMz9WhIJHyv1pK6gERRBE16/4FlpBOu7nHOcE01L1C5yE7DGYqDrnvk1PYwUpKP/IVcGmSrlSt/TtwDtPBOV5ez+0m7g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (5.2.211.124) by
 SN6PR07MB4384.namprd07.prod.outlook.com (2603:10b6:805:58::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 26 Jul 2018 09:37:39 +0000
Date:   Thu, 26 Jul 2018 12:37:28 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net, linux@rasmusvillemoes.dk, dgilbert@redhat.com,
        mawilcox@microsoft.com
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
Message-ID: <20180726093728.GA9069@yury-thinkpad>
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [5.2.211.124]
X-ClientProxiedBy: HE1PR06CA0162.eurprd06.prod.outlook.com
 (2603:10a6:7:16::49) To SN6PR07MB4384.namprd07.prod.outlook.com
 (2603:10b6:805:58::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb59c5a8-020d-4f76-4cd9-08d5f2db6dfa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4384;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;3:0gq8QbZyjqdQRggT+plenFGwT7P5wOYHOVRSDe0qIbcfjbCMq3mvf4/MsUEAma02SVtjQv/4jdqH4TPQJzoc0YV6OIyLAMBVTlha/nop21rAw3Lu4N/AROKykQVSiC9AQ89uG/A9zw41qzajP9HeOYJuZ83HrFlX3OBh0nD0FQbnDYBQ8n+3gjO12pvxJwGy6LwvQF5Q+l3L2Grl9KAT+AJkR3PU3pGRmSgCbEm6iOjDqqkxOyQvOdzDzxVmPyCq;25:M//q8VopERHq1sUll8RfEnVAwKR52zY10HvbMVAQP4wEfJ/YeY81080ndUTZIgBsJGCwSmrnBFlJifYBL6inTRYdrUNX+O0exEr8qHX093Zot26zkVnV+jRIMYQRTzPeVMN6bvWAIm0zyQFJCfKFebobfgMqhK81fscpufUrf9/A95Xv6TA86xHPLZWMb8JtlDKC4alkGWuDC4x4j00IW+Run+GdCZSQxwffm+cxHy39bvZzUL1WjGRgw+RdzW2i/oqsaghGy8JALsy9XlJXg+VePHlG4Hgbfuea6EjGAieqI3kHjFekKy1zFkG6xUkFr7rwOmypHqd8Y1j3/Df8rA==;31:fRg9QO5ZAGSf4VNos90DYzyVP70/5BDGXeh2F8x4opTscZ7Fin3Wzxj161Evw94QtW02CKDRnsiNZkKid87m1lTKmvVM9dIPlHfNBgvPyz6n5Y5Am4d47SWO7FaSZMfQvsJMoavagxcuWfJzE9JheIs8p0m7YZQXnQQrJvUTjU1XkA2tn1bK/Fgjk/eWY+VZgNI1JawLQqLLexn4YzVv763Vz03oopYLWPtaininzwk=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4384:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;20:7/uCTBOhJN1fLn69YJnHD0EAoLNskWlEbMRSPXtd09NpwExaue8+1RVec9FmtxYC9KGA6Y5uxHHAwrHiheNQQCUz6IhIl9geK7g5uHXplnaCV25Onj4LJnL5gJ0DMecqg93vqojMLfI2P+cExX/WuDpNeKWCJZ91RtFpzF3whdoYWa0lYR5VPtv/nShaHbmyYpZcPNc1xUaKOxfgX7xByK34YtrJMIIFK3VMOD3rRGiu/cT7gRBfoDyM7woghK2IVC3i4UwDHutvTA1AcWPcDe6R61gpVJIa58rMPx+35Svfwb/D1EjlScZnZg4xWTo4GlNvY4IaEycWu+Bt88kPCih3djQQyXvfz8RVvif1bUuPGABm5/3CD0FJXl0SA6yxxqkBNIZPGZ8dMXCZgVNz8ckdMAaNcGqFABfU0o0mp1SCPvq1JgJh0LtPZThhP/sQYCUS050LLwTi8H4CENshdFFInkbijlqtz2l8LBLkRUr0WNxKteUTsX2bq4/XJSuDk2lLUo978FJ+Yn/GAVweztUIw7O0FC/bKgHNFXH/QpKHJ2NB6oo8yXotQ74j5uelAYtJeQA7aIKJKu2RShxeQZE7Kdd/iYwP5GXY1whRMmE=;4:6jgR6YuYD/E/9/AvstXIYiiYQu8H+mkOFPznKOFSESfc5lJXsz6vY3poa1au2sZR8yeoU9WA0xTIJNy+8TfNiIv7XwOgj+mauzN6ZCOUNkqYPU6t0WU+3BgxZcUXkdITJdMgNzYJA0hlxDG6yZsGN/EmCXaSBh8d/1yGLvfEvl396Y2gBYrQZWZ2TGWD2RtEfj237yUZAself77I1k/HqawRM9fqHVrEhhR9Rlbk7WELq+ctX1qUqMMNwb8HheJmadQq14tUU45g3s3LmIvjnK3E7Kn0+zCucYpvdho34qQDrfc2+fMhiOVw/EsvwjQK
X-Microsoft-Antispam-PRVS: <SN6PR07MB4384B3EEDF3BCB541D415DB1E32B0@SN6PR07MB4384.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4384;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4384;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(396003)(39850400004)(136003)(346002)(376002)(366004)(199004)(189003)(16586007)(33896004)(58126008)(6246003)(8676002)(50466002)(52116002)(81156014)(186003)(11346002)(76176011)(2906002)(68736007)(42882007)(316002)(4326008)(105586002)(66066001)(6496006)(6916009)(26005)(53936002)(106356001)(6486002)(486006)(8936002)(16526019)(81166006)(14444005)(386003)(446003)(9686003)(7736002)(229853002)(33656002)(23726003)(97736004)(76506005)(47776003)(72206003)(6116002)(1076002)(71446004)(33716001)(478600001)(25786009)(305945005)(956004)(476003)(5660300001)(3846002)(6666003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4384;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4384;23:Fjg0sbMuC4hhoSKMMlumq6pj53M8lDGcHcMlsASOH?=
 =?us-ascii?Q?k+FdIoPlendG4JzKZ+oNZWbC7FJaJaIvEg0xi1nvrNs4/F08yrvZn1VKwxi5?=
 =?us-ascii?Q?e1k4XueDfA5u2Sa+Ngfz+V+800fV0e/US0Av3AxJeJiSTK03lI7MfrE7mvZS?=
 =?us-ascii?Q?szfSQcHl1vQTA4KajSTHf0dOp0GTMMOMn7DO6IE7eTgJpTnmOPrMuQ/X+d5M?=
 =?us-ascii?Q?to2khIbGHtBnwiDGpFahRu455lHF8rx+z5sXbWf1vv7eQSeugLfcdEGLO7mB?=
 =?us-ascii?Q?if8HJ0z5QDUNbFHDkYJmwyTTIrV49ugVIrKOG/elnntk+teDvw5IYhmnm+5I?=
 =?us-ascii?Q?xmpicPSgZjDXVOdMLr9UtjmqCdEoeqGR1i99Q0HTDjaGd9NMP2cK9x4lsCnt?=
 =?us-ascii?Q?BVIB5vcRraFxOHi91ivFSjDeFw8DYFsdBOEHM6LQxP4luxUMWRnhu33qq5Ed?=
 =?us-ascii?Q?N6/bvIIsWRbuCU3+tAhK59cfyT4cvbjzpmJ0m8sD6JqLbjBF+UGEioKHuJUj?=
 =?us-ascii?Q?8EEYz/zpCJ5tUSPlRL4sPudm4I5HpbQeqb0qtwfEhGfEp+f1JLYtzjoYsTVQ?=
 =?us-ascii?Q?0cDNP8d/mmaVO2kwcaP88f1vPaexXKDp+k86mJCE7oUi4KMJ7AGjdi0LyDV5?=
 =?us-ascii?Q?TUlkYSohERCtzUEc9ypp82uoyCoWVeDuhUFQHOxWu+9cqnvhvqtHicPls8u4?=
 =?us-ascii?Q?j1kfzcRigZxyh7/rlP/x9XUQthMNKWQN54yy5IUp3ofw8pmPNcYXk98rOBKO?=
 =?us-ascii?Q?k/EK0ItKALvOb2mf8dK2qpAE4GWPrzWt78WoHpFF1ewrERmFwivVNQh1Zf4t?=
 =?us-ascii?Q?bcnrh+N3YYdVdpgCpRj0CkF/aQuJ6ilnNE9igemfM3GJ0LRyk+txFKQF9PI5?=
 =?us-ascii?Q?DdEDUrPRhE2/G/aviD2MK6RLTtukBM519wHe5ymNKBXAllNtixTp1BgaK/qo?=
 =?us-ascii?Q?zQRzvd5vVeHSldhUuwwRsa8SF9GUYKI3f8mPwbMsdJK9xJJPm6gKETCXXQMC?=
 =?us-ascii?Q?GNdz1wAR9ad7lgWN4Bfs1Ug8OwfAG32+bAHaiclC/ZiIdjjsPp2xhp5Z0OYW?=
 =?us-ascii?Q?IhX5x5a5UaLOQyGZc6hxOAuuJGfOr+6SpmZ5qFcbenA0LPLZAVkdNe/3Ty52?=
 =?us-ascii?Q?BYrV/wFI9cgJfTPgrRBwbjeANWJqoqvZRA8tVJX/kDiFxIn+9Cw8sbHpoTp3?=
 =?us-ascii?Q?RRimNQyDQnk2hlNYEKP/6Bwom50MaRM+w3amwTpMNsydS3AViTLzN7D5LesO?=
 =?us-ascii?Q?u4h4fzXW6/jZsP0j01IFRTEBCSiEShQW/js64a+7uRvDirw+p3K6cN2700fp?=
 =?us-ascii?Q?JL/JIkchMSO/cLx1hKsQWr844Pw/Q1byjYNHtkTKzY0DtMkz66jO1N8RnN5u?=
 =?us-ascii?Q?LkScJ/Fbh7B7T5li6dD1pWHRxE=3D?=
X-Microsoft-Antispam-Message-Info: efTBcFc6kVjAIDdymz48dVQ6pUN3FtH10PE5OzCzgajbZ8RdJVWYmzadkBlw1bWGMvYEm8cPsRsGxLbLF9WKXFigu6NhWWsc3ZIMHDkXECFxMEQUHVCsic732fVS7qS5fv5lBUu0zWZETVNASQ76ytdES60LVypBXaWKtg0u/u/0i6olg9XMl7357gXgSkIVE0CeWhTedrY50YjgE8Sjf/MB6vVuHIjQ4CKQAbi1b/jZPx/srVfw9cZwQbIGgEDG0KfiVq7+L5jp5kXS6aLw6NsiO3yDiz2j4DX1xy0m3bfMEYhmDGJAQEoi6nPGqDnosqQycnPMjvBQ7RWStjEQkF+R+QMFHDMnKv9nAn82tKY=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4384;6:2fLozm7xpDdGXNlqzDlgttr4m+6ormnxwREgHlgpYx6OShTRsNapKD/Yyyd8nFk89OUPZfLVIlXqbg1hFR4yPt2eNZLMnvL997wUyqiGFg8NkZy2MmmX7hEiRZu87JJZhashlhy1WeXOiifU2cBW74nsdMx3t7pv0QniR64++EoVM2wMC900yMFzgg+rARyKnBONC8qh3IuZyGxPg2Mt9roTZ+c8rVaesZ/6qVGX7SQuvGboUzb8teDUgxV6NcOtyPkTmx8puY2VBUL6vDl3AqaI+zN6SO4CNNiB6QOGQ9sedAGkZSl9AIo9zs4tlTTXy/80N1TSPRkFGBRbu2ik7X+mVRwCGf+TIWFrmGtcVEfLo8PjM/JhWpfMO5qs/6AEEjDmr0VJGBiKX2BvHP7qBgIbZYbH86BI9AhECKamxU4HZqG5DHNhLhogF148enmwJYJ2CQdHRSghhhZnLfRBPA==;5:QzoYRPlDYVqycbYiI3WweNzckePVMTf62Am0eh3APJlujoNVtrBUTsR37utI9h4yu7SQoqoJSuYd37WOfXk0HIviIhOwJbKgPXrGCXOQcuEpn5d0ghwDu8bLwC6BeoZczyJjaSMjo24LiD5ACDHAVDOdoRk+80xW/q/QE6jQXfg=;7:t79ioCNI1GHiILpyrni7s30O9K/FPabjUGx8uiVS6F1JBpBEygumZikPFNdbgXVaXHXPgk8APoswt9nLTTRl4Pry3GIgzB5If5odRzniDDibyeF5P/BU8fDJG7ee4ZMXxdkcMVatnhDslrEROfUC83sR1urvKuX7UueDPnnnngAmxwKBVcVw/qkB5hO7hE+IMPTmI219RahzXOBvO2sTnEmVxUIeuVH0jcALDfoxlKq7difAS3pzSHuyoQQXPgie
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 09:37:39.4360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb59c5a8-020d-4f76-4cd9-08d5f2db6dfa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:07:51PM +0800, Wei Wang wrote:
> The existing BITMAP_LAST_WORD_MASK macro returns 0xffffffff if nbits is
> 0. This patch changes the macro to return 0 when there is no bit needs to
> be masked.

I think this is intentional behavour. Previous version did return ~0UL
explicitly in this case. See patch 89c1e79eb3023 (linux/bitmap.h: improve
BITMAP_{LAST,FIRST}_WORD_MASK) from Rasmus.

Introducing conditional branch would affect performance. All existing
code checks nbits for 0 before handling last word where needed
explicitly. So I think we'd better change nothing here.

Yury

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  include/linux/bitmap.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 1ee46f4..12af3d7 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -194,7 +194,10 @@ extern int bitmap_print_to_pagebuf(bool list, char *buf,
>                                    const unsigned long *maskp, int nmaskbits);
> 
>  #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> -#define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> +#define BITMAP_LAST_WORD_MASK(nbits)                           \
> +(                                                              \
> +       nbits ? (~0UL >> (-(nbits) & (BITS_PER_LONG - 1))) : 0  \
> +)
> 
>  #define small_const_nbits(nbits) \
>         (__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
> --
> 2.7.4
