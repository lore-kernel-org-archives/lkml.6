Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753887AbeBLTuo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:50:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751229AbeBLTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:50:41 -0500
Date: Mon, 12 Feb 2018 11:50:14 -0800
From: Dave Watson <davejwatson@fb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: [PATCH 09/14] x86/crypto: aesni: Move ghash_mul to GCM_COMPLETE
Message-ID: <20180212195014.GA60920@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: MWHPR22CA0026.namprd22.prod.outlook.com (10.168.250.140) To
 CY4PR15MB1750.namprd15.prod.outlook.com (10.174.53.140)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc7cf8a-0500-4984-ed46-08d57251d92b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR15MB1750;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1750;3:MTFxG+SBCu01uZ3hhYOTPZecVRvExz04+Na8i7H9Z4sYvQkW9GwLJn+x+GCYjf5tCq0zDLjDPW31PaiKJ6NrJQZNjGoZtLMpKPTQaG+HXeOIGT88nVPgs8+HwaBrFqQL6UuoOH4+AT0+jjOfJmmzdKXD5So6Ok9J4mOGFiJ88OJbUwDRf//C/fewYCVzFo7YA88oanxudH3cMqoV0dA90I2SAE7FQIUHCTXWVqXi4546LiOddjvHm5bJX6iYSF4d;25:i4HXj3/82s3TE8w+Ksg3xosWmNze36KTr+YUJkYM2QGrqNjluGdYbKEdRucuhoLvHg0BOEQ+Loa/4mO5NPQ/ihhkiN9DSmuawZ+BrxsoBajckl1JPe8tjNHHIbRy5bQ+b0x9ocPGyqf1LWHmAS0CjEfzVyXmPEkal4Q+JO7LUCoH57YA7JEYfZFTtmWRJUX1hHRQlaKD1QmrGUjWHDi1HnK4FArcc6W8r4Rzvd6Pq0MTGXXUievVq5fIEIG602dNKdl/l6W3sq8G8oCwrLLTagyrmQbmcRlEGtEONqqaZyGUQjekSH+Fhsk6V/HH84tWxUmf31uMh+TMbfRhmqKklw==;31:NeHVUNiAQ+BELAinKUACBFBvMCh6rmV0n9fr1t4vmLChlpuEhSdPiinaUqIMdJOVY10CwhM3yyCWJzbGiJqrg1nqpi+cpTKYyvgmUpSBn0j3I79vKqT/f8c6ZAy0hAyylQePL2h52iVMWrFoKmupItnMA4J8N5//49+IZnUmJsNgmw4OD0FBJGKqZjvJ2VU9lRoHXxKCZvCv7t/QE15FMV30alAYy9yzzwBpAnrOyGY=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1750:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1750;20:mrrN7prdijM6B9cHzIm7/2AJQ1QFNc33rkiw6KsbnzMkr1nINyR6tFAqID75yNa3PALoChHY88j4kcBOmggBCdG+ERZ2AKXMs7IAxSXj65gK7bBMm2xOnP0x8De0DhuH02f7sh4E3peG++Uispc/KFBp1V7G5oTGo2+boUm76MQI+rHhVm0ot2XIhgzKHc+DCKKqq+UPQWlGEc3XPe8IM+Kmx/BokMl+ZPBz4jgmeSyyH+7CZ3UP2WEN5VkUNn9OWxH7wNReEbter2glvR3RsRrx5N1kvyIGZrkjO5TK8rgjZ9aGQzuKuO6i0Ha+Tse+P2b10SJRKvPQQp1wGFNpfbgUIBX5HPOWJUY7Of7lGxS6kZMrPag1U3NqwGTC/EBNKgB4DY5oP5Z3VDc2G9cZGq2FXu8MPg/xrtnIEsL2L1qvEnbDzADhbC5ObqpijZjRlQcu4VGN4N1cq5zWNMgW4/iZRSSR2KVJNhJ8JFUf3GkML0FnLZnsSNAvvSNyyryo;4:b1FrislLbHNzuOn5ZZw6JVcGTljzGliQK3nbkQFtE1iw2STvZ/gUYHtFEFbaC8KxuXxJ0QCearV+U4bSff+vaOk7+Mx0laPkpIkrHZ6vj+Fep8J7xr4gGjp1wUm4JpNG3qQQLbeGfsC42XbLq8PEFAd8khb04mT4oM8CfiUK1cjB9j+1x63sC9Lrc3f4ZX9c/pat/4pDip//bpJS8V6Hq3IlQFpeLsFDrxFAlNzGEkZ+SAZTIU4y5Sd4JOi6XmljuHDSJ7W9O4b5IQYICMyhXpP3DelMxr/jd1ahhYOIDgdprDdmfiYk0A5N0FX7CQczLMCfpNFEcEza+7H5Tv9HMtAAT7A5SYJtptRv7M7DniM=
X-Microsoft-Antispam-PRVS: <CY4PR15MB17500CFEB6CF18D4E54E3A4EDDF70@CY4PR15MB1750.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(11241501184)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR15MB1750;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1750;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(199004)(189003)(25786009)(76176011)(98436002)(83506002)(4326008)(16526019)(186003)(1076002)(23726003)(59450400001)(106356001)(6116002)(33656002)(7736002)(386003)(33896004)(68736007)(305945005)(47776003)(478600001)(97736004)(50466002)(81156014)(54906003)(5660300001)(6486002)(58126008)(9686003)(53936002)(81166006)(8936002)(7416002)(105586002)(76506005)(86362001)(52396003)(6496006)(2950100002)(316002)(110136005)(8676002)(52116002)(16586007)(2906002)(6666003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1750;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1750;23:ZMRTkB6PhdUS1OL3AzyPFegltJvs+mPqVvh+D94qF?=
 =?us-ascii?Q?Zz9j1S2ghHNyF/SM+dQY1cYVsqC2NIzIImkQl696a/ftArrnM0quJZw1HXLH?=
 =?us-ascii?Q?GehdH2Zhk4OPBe87E3SwTassjbwtyIw0nI96e18lgy97LTOyVjvZGSTXv9nW?=
 =?us-ascii?Q?sSwQxts5wBJVTwbndshlZyjdWwrnzFQdquYq74LrVM8N3kmZUedu/mI8qNz9?=
 =?us-ascii?Q?9D+CR3OMgJmo68f+bQCCEfApKDY/djNTL7Ux0QFjHuD3baLZtORqrmT1q4EG?=
 =?us-ascii?Q?Rzuwzbr0Agga2ADWAehqRRGUJdZNJSAoW9YmtXnwlvoLESHkXko752fOnWod?=
 =?us-ascii?Q?igjWuEQDGwHrJg2ZwY1tttFG2sb3PZfQzu3vayj6TQzNk3N48hmBP42uAg03?=
 =?us-ascii?Q?+C0ZdE2VHxO5vnyEKMLCtjnvJoNBaFDxVthbxBv2qPQu2e8KYFGlkY+zh47+?=
 =?us-ascii?Q?ZzPWHAtQLumQqOSPrUPPpAOWR+RttC8Mr7RljnFvKfdoJQiO6nwumwdDb9Wa?=
 =?us-ascii?Q?5AoSGuy1rySk75+KyFgwIw3BRPIFSMS/uav9wbSWYhLHDo99knawwJ+X8jDu?=
 =?us-ascii?Q?WoqpGskwQNqF5JeaFLDSwr6evOfXSdNZDojFgU6c5Tp1eA+aKFpYkljitDyj?=
 =?us-ascii?Q?2YanLsTFz3JGpgq+fQ4spcVAcJPgys92tkFPeqV78T3A9Yy75qfLRAvR2azZ?=
 =?us-ascii?Q?H4cvIYMhZte3IaJBWUcgIuHpXc6Uazu9N2OW3ymIFJybrR82eQvorpKcFwd+?=
 =?us-ascii?Q?0+PmebvLee6U8LhB8naaLOxvN36iIxvltgpxEt/XH7pgK7gkZn80DQX16ipc?=
 =?us-ascii?Q?E5inD2RLeKZcODJUZK43e1+F5mm0pw3nm95SUcUfe2DXfEpnI+PEDxtdhTmh?=
 =?us-ascii?Q?hD5URrpBJMZwHYbpAEfWoAUdQsaiU4YRSz7qUFrBhP/dSHxDrsVBkVueQYkX?=
 =?us-ascii?Q?4TbHbwzSG+cKtwHArpoMzfx0ZUkZ/2814TcF7/egMgYhEYc1rMTqiQnL70Dn?=
 =?us-ascii?Q?zOq0thjDLnVw7GudfEQvb8Oi8bV6l/2TxSVRsJ9v9IsJE2STxvV+x6Qc9OOt?=
 =?us-ascii?Q?H5ut0Ei+ZPTjUc7KDYTSx3OdDp1Prnix6FTnBT7jm0Jm5BEs0bL7tSBTwSh4?=
 =?us-ascii?Q?+Rm7/80Bq8fXmlawndxAxcjFFC2TBbvg4pSc4uxaFD6lujDUHj5Xipi1hcsZ?=
 =?us-ascii?Q?Hb5Pl8WUROV5kiEHGQqQG4DArBOAHD1yRb46LmMaiOO+jV9QrEc2n2mqZgMe?=
 =?us-ascii?Q?ic2MB+MBgQrTpOZmL5wcetfsed/C9wz/URjQjnk?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1750;6:cgyvzrSvZCzofDJT30uz+PNlGnQgyj4r3X/Ez5E8HWGOqYa/j+NnioAOUNQ9ku9OlCbq4gpztWP2cUbgrRFJWRayhjnpmXSNiOUK/OU3KXPYgOOcLYJIZ3HhGykAMuNv/nVojDy9n23VpoBufsk9aVPSEfU5uL0ShCbYEKCRFrgOh9bcPvxJAAHDTve1qNGnnhKhL8vgZ6Mj/Hjm0VXIjZpKiUM/r6sBRKpejFMegJzmiZIXuE4mtQyp3B/kXmwltnQA13dgRzvciVVMXifW8846j29+ohUBVt5CG0YqTyGzHhyaP7DJBgQU8XoMGeN6Jh51AiFClt6Upqm31yjYd4T8jAGb/UWwwW6T8sTYHr8=;5:NHtcHENMRSnG2RIudnLl9bS2vtqz76XJudGhVa9AYYqm6K9tzb7+lkYrLmi5pf1XG+564xom6/3FV+DFw49nW3opnY/+LbWeo8CufkLoZUMKxnBsKwpgaisEn1fMsJUywjK0OI+q+iliQkN8hppj0nagCUWfCeHNvEfZ4hQVlb4=;24:1qUZm9LCCSGI3Xme/0sknyzRK+fdttHvFfTpoiKLaZtfevksOWAiSolEkG7K+X01YNBbTQTqtBCUIgSdVOONG5r/ZznDJy6YANqrQxQrHOM=;7:yKo8tztgA7/3pr1wIJ7LGrgYzfdb5phA1RJ3GQpT3Kh4M94u/IV4LLOlKrhrVVwnx6pXrDW3qBS0U5TAFCy5IFDLfmIOGp5DiX9Rq6KZw4rtaVeGpPUziW3G12XBxPUpP2uZ/cEk8YwOfmZKICEfFBRCrG/zo7X8cEe9bke4q67l6GJtNgdo6qJEUiM8+uvxC29ukqPkydMr2pxE9flOn6sh2U1tZ/PdYx+enfwY/pQsJTd4zX8mwPReZ7ybxtIs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1750;20:hK5w6snAGoH687/Xomyed6a7nals5yDbwLiWezjU4JMOU2SKjNjpPRsRKmkmUxM6iNKZsa4pMQamog3MNRImCxIhDaKg49rhVPy3dbkMgWsqACWgmEiYidfp4VH/k39hqDxUzPP/D+EDABDOcn+ih3wQBB/GMWQUZMRYXr6PpC0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:50:20.2995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc7cf8a-0500-4984-ed46-08d57251d92b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1750
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to handle partial blocks between scatter/gather calls.
For the last partial block, we only want to calculate the aadhash
in GCM_COMPLETE, and a new partial block macro will handle both
aadhash update and encrypting partial blocks between calls.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index aa82493..37b1cee 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -345,7 +345,6 @@ _zero_cipher_left_\@:
 	pxor	%xmm0, %xmm8
 .endif
 
-	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
 	movdqu %xmm8, AadHash(%arg2)
 .ifc \operation, enc
 	# GHASH computation for the last <16 byte block
@@ -378,6 +377,15 @@ _multiple_of_16_bytes_\@:
 .macro GCM_COMPLETE
 	movdqu AadHash(%arg2), %xmm8
 	movdqu HashKey(%rsp), %xmm13
+
+	mov PBlockLen(%arg2), %r12
+
+	cmp $0, %r12
+	je _partial_done\@
+
+	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
+
+_partial_done\@:
 	mov AadLen(%arg2), %r12  # %r13 = aadLen (number of bytes)
 	shl	$3, %r12		  # convert into number of bits
 	movd	%r12d, %xmm15		  # len(A) in %xmm15
-- 
2.9.5
