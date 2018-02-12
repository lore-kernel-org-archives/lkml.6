Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754024AbeBLTv2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:51:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44112 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751300AbeBLTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:51:24 -0500
Date: Mon, 12 Feb 2018 11:50:58 -0800
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
Subject: [PATCH 12/14] x86/crypto: aesni: Add fast path for > 16 byte update
Message-ID: <20180212195058.GA61017@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: CO2PR05CA0097.namprd05.prod.outlook.com (10.165.92.23) To
 DM5PR15MB1755.namprd15.prod.outlook.com (10.174.246.137)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32d9499b-f1ff-4aa6-ea49-08d57251f2af
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1755;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;3:UForaje0kNc4KGHzEaSq+GTvLbgkdLT52Uh8MnsfOCXuxBLfi960Mz5QlHCgkiMgXXOsjwo6uHiSk3d+2obBoGV5se4Zu9ryLTdPWRKI43F7Z4ggC0BQCeHkszjJ0N1Bz0VSt3UTZQwBead70S4/QnlPrdse6VSt8Vo9ki/lCoOo6D32amI6KKj4KInwjHhzAa0Ej+Uksh+0+fl8rpUCQU3+VGO2mdtmgPba8+tcveXUgeEK36dN/x16VlPLlXfh;25:zX/5wZVjdcdIk5bOHB+Y2e6yx7TeeVbpinUvWZM75jO1v2hIvEFyxrC3lf769iydYmg36IUwkMLfG8A10e6zIea6KSiIkH+uejmng5vNi9MpCVdC7LZO0HbhTxbHZO8JqxQDBzNz302+W+dsWt4l6AmIesA31AsM6vpGjpKn9QRtYilLo6h7YkyZZFgMTblk17V46akAAu+5goVstX5hxH2JKhAzUFT6Fy7CSKfXtKGkZIYIUYVuhvX6DWiN3txCbqqyi35QqJt4JKZSHXUzonkEUwjGtbdBoKFyDqyBCl8hzrqzYGGLHzIMo+gYYUphh6kf/5/mOT1uFL4vUDHdZA==;31:Xi7+PkomX3YMk4bzC9fPmuK+rh1BxGW56NisOKtm8MJUEVd8JCgbor3FIqqhQsS82qokfsziKR9be/xlPpdZ39MwovquluriNxUtNPZxZBh3s1kd5u3XDicxijGXbKqkCYhQKsATt4ap0hTjaP+hAhsAuY5d1OA9uM9nRGqgWBitS6GUjIQHOGh+aIvl+wLKBCLyGEGyI8jyWjjgd40mGVjhQ1icOWmOYsgherku5RI=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1755:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:wGW6glq2+cU4UpO3fkwH0nalYFzfYIKspaGjkCFSxMWGnb2i1pILEKvh9qIvVjn6jdkf8fC2jiAFm8i061YYeJGR9rieSv5Vy+xWnJdlia2zk05XCtNx1dfPc6QbMGuGE0hlLnfDp9MnW2s6YVmAFPAs9nOguP3viOpWWvlwWQw1ruzzcykHT2Q7vtwEBFW5ltG+i+jk+iAxbQs6kkfstQSZZ6vNX3mKKYwquBIju6FI+iZz8B1zX2StkzW9COOvUmLAqf5q1Sc8UsdbiZ58VHUeEseJbqOa+B1RnvhOcZbLO7dcI01xP2kdqnNiZRDoO9dZBE6s+HWaauTNv7jbdcxDgz779DNxTMMI4B7p9UHMruDwnehvSurQ93xiNugduqLnyGvQzDFYfgoIu6eHoN8b2ULOAEdTq97JVqCvTnL2r5eVzSjSvsBoLapKDm2oYbNMRarTSrq8Agu06l1SKD8RDpDXACd0h1LrY/ZaOJWY7hn4zdxFFj4Zc8qdmHQp;4:ew/XJMCRMis9QNA3egFq6/djsT3CuAjwi0uEKkeOoVv7YYIk3TpUaw53CmYW+jivQMo0Kp1mZJFlSeZkKoMhxs5rsnGuyAJzZi2P1rO6Zu2UQiDW9to9yUxRrI3bjkyvxKe1S1403UupgdaAXhGckMauDSKAG4c+6gK8ePgIpVJYUvk7ibCpYfSPeC2SdOZkKf9V84Xaxa4VyBXrWGj9YSyZIo6W3VrvLd/Pa8HZBmTRAwlz7tkHJZzySasewqtPTePWwBE/GROD8aPtnm2NLqImzESBGqOV5K8qAFp1Th5NM3zVRquiLtKW3jk7nhk2T7oKjpK8Ssrjn1rxW7OZbkormWyS0Bx3ZqYHOPozuT8=
X-Microsoft-Antispam-PRVS: <DM5PR15MB1755751AC4C2F4A1E952D3EBDDF70@DM5PR15MB1755.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(11241501184)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1755;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1755;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(376002)(39860400002)(366004)(39380400002)(346002)(199004)(189003)(23726003)(6116002)(1076002)(8936002)(9686003)(15650500001)(50466002)(81156014)(81166006)(8676002)(186003)(16526019)(86362001)(2906002)(98436002)(33656002)(478600001)(33896004)(97736004)(52396003)(6496006)(106356001)(386003)(68736007)(105586002)(5660300001)(76176011)(47776003)(6486002)(58126008)(110136005)(6666003)(7736002)(316002)(16586007)(54906003)(52116002)(76506005)(4326008)(25786009)(305945005)(59450400001)(2950100002)(7416002)(83506002)(53936002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1755;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1755;23:S2/2FlRv58Nqx8O4bfkP8kSzS9VrKkkgxl3VwVEHx?=
 =?us-ascii?Q?H+DCBGh75fhCtcM1JTXGBrsp2RL5YgK2x6i/Y1y9cxR7PkVJWxeQyP+Q8i9D?=
 =?us-ascii?Q?vBHIEch5uptnK0CF7geu5L6rjwOImYtG92XAzsudW/Hk4ZSX9dNrUtfidASq?=
 =?us-ascii?Q?3ezbder2QkyLGp5HbRsmby1Xmu4zMeKwEcxRE9F+xsHCmqRrOucK+5OKQ4Av?=
 =?us-ascii?Q?VlcT17iwHzHqddWvDeztsWp/6MZfrrfq+p+dpTXQTQ9HwslSL2oJVbEdVlNs?=
 =?us-ascii?Q?QyWnUGAUXcVg1lJaivIZpcMqWT03SQ11GIKC1MtDP7e4IaHSZZtIrwiVi2H6?=
 =?us-ascii?Q?7ZxNUioiy4cBei0VbpcJ099DK2yHZ05vph8fzU0jAlh4bEE96+RtoZWSREfh?=
 =?us-ascii?Q?StddoCZenhJR16sCXiAREnFah6jEaI2S9fjkSlt1S1HoGIkWH+rCkjEvn5US?=
 =?us-ascii?Q?9LxFIe32J78LPe2ttEbXslyFN324FsW3Z4b/I1NA09O3/qyTM6TOE4yhLEz9?=
 =?us-ascii?Q?T/t6ydQjm3t4O97sd0ByVYeYj2ZgWusWzv2qrks/PfTEUfoTf1cKdaXozW83?=
 =?us-ascii?Q?OImXw7UOwfm8r0Ka1o7ov6MtVJajztZvM38mlXSRinUN+uzJruN6Gqp1+yjH?=
 =?us-ascii?Q?d4TxpM9W2q5REcg5r7a+iG5hsKCmqQPhuFv8TWcBL1okPZ9b9wfJxuTH1m+F?=
 =?us-ascii?Q?woR9i5bDmrHmqldVemGrVvYtkhNtDkpvDCxV0SuiCmTfxW/B+SdjsbSm7skJ?=
 =?us-ascii?Q?MMjcaiQMvhNjfnVbVWBfyO6/lX+dDcfillESvSYvS9AJBe8OQTCf462VYDz5?=
 =?us-ascii?Q?1mJSRLCk85/BdGHuQXagenchIKhdQUrkpM3epviFeBgSpMhJCU973HLpj/0Z?=
 =?us-ascii?Q?Tz1EvVnWdyJ4T8H/sTD1XWQUY0XxgsJdf4i77GhKSH25nmPBDXBx9mgx8TL0?=
 =?us-ascii?Q?zLCae+VTDy4USH4TKblE8ocDIklNlgssGusptGfXtDtfBUvmDobeKbGqzxiH?=
 =?us-ascii?Q?GTfmx+oedvV4nHUQIZqaa+/NFBMjeIPSLyqJ8+7mlXq+8Wd9NoH+JrF0+rrK?=
 =?us-ascii?Q?nj5e4yf6zicdQqvGH9SLdn9Wwy9YVIaZxKa9QMFc5I4J7uGVSWn68HlgWw+A?=
 =?us-ascii?Q?hJJ1bPBJ9vk22YPV0V1NhAsUMAL3y/Y2JL1IIMhjJ8sp7euhOHHq3PM8Z5WP?=
 =?us-ascii?Q?5jg5ifCa4QMj4rI1tUsTjzsDY9gNAk6HmnphAW8xhAB+30TBopWRXG25eE+k?=
 =?us-ascii?Q?rDCuzwa7lCr3XftBVcG5az8jTeLwlhdq01YR1dmNPwb7tGUQBb5jHbXniLjE?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;6:7Wsw06G5K0vRO+OER10K2auUdBqnBk8e2G9VlX5cK8jAAowru6aE2HD9EPnI76eY4k/DOOYaSiw9biAq7MZUZv/MSsxoKeZaz+26EvBRQkeBUnDIXZzzi5dKEIMhn0e1cHOzHXwm8g3DDOZZ/XP8gUWWvha34hj1IJB46+1oIyHKufJnO8ZIvlfUb90kb82PLLqlCuUrqR/4BfKoYsWFKEzN9c7SfrbAZGoKHt0fLq6A4Yqp9bp6tnfM0jKFk7y32KzAh0DFG0NQfazxim1kB2hh0mVkhD+zpakWvVZTu4bVX7sq0suTa1EV5EVq6FgsO2mEFC7HSgka1o/Hdk+V/02SvtYu9+/HR8TbOjkW3Tk=;5:zUUZZsdXWdnqxcrtFY76IoGitVD+t2LTmrn9atkhvwVHORug0/U9dOWBmO2SegmIGuWG1ir4YLJOMaPhY6yd8r4dugyOH9Isp5blncMgMWFt2AH85FwJ8QGp5H1jeAMWI6FNHmQhPolqQwIfo0Dd2yibaPZNGZDee8wpfIREA7k=;24:nvk0QU9BTZ2v3ZISGh1BlhZRqvGRFJn2FO5uhr/RfNi3RH9R+aESjeu9I9pdAR2nJeTy/MsXPhrHTjtei9ro3PP3VBdLSfjTN6+NVA9UFDU=;7:2yHigyCmcSxdem6YJz40VSkCpQonuJHFYNmdOxZM94KvyxSObhg6eGPFo4nAyWfKRVyqUh3H5UNjeFUfoYAhv4WH0ulP5ZIQ015DbFMS/601JfO5euZMwa4zVMeCqSe6w+DJpawEgbzbJ7CV74VkaROWwWKpmGdbxhfsjEeqeEzS8hdVR4znLf8E3nbZubuZo5uvMiovgRFZxMDztWL1fe+gVY+YppiI3gF8pnpiRoJRC5yfuNQ7O9OT5X5ETkhe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:v+ES+idUREQJtk+7BD1RBhTUbQodVtAmejruSdG8Z0MOGLVlYQl6BYXEdXx83INsrI5DWzA93kqYHjHNShFdqUCJRXRGUTrNYMV5Vya+TXfO9EuhsWDnSAbnm1CZt1Zf41IO8jrv7iocMd/Rfc9oQ64niTPBFmQK6BWs0bl5ft0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:51:03.0763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d9499b-f1ff-4aa6-ea49-08d57251f2af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1755
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can fast-path any < 16 byte read if the full message is > 16 bytes,
and shift over by the appropriate amount.  Usually we are
reading > 16 bytes, so this should be faster than the READ_PARTIAL
macro introduced in b20209c91e2 for the average case.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 398bd2237f..b941952 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -355,12 +355,37 @@ _zero_cipher_left_\@:
 	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm1        # Encrypt(K, Yn)
 	movdqu %xmm0, PBlockEncKey(%arg2)
 
+	cmp	$16, %arg5
+	jge _large_enough_update_\@
+
 	lea (%arg4,%r11,1), %r10
 	mov %r13, %r12
 	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
+	jmp _data_read_\@
+
+_large_enough_update_\@:
+	sub	$16, %r11
+	add	%r13, %r11
+
+	# receive the last <16 Byte block
+	movdqu	(%arg4, %r11, 1), %xmm1
 
+	sub	%r13, %r11
+	add	$16, %r11
+
+	lea	SHIFT_MASK+16(%rip), %r12
+	# adjust the shuffle mask pointer to be able to shift 16-r13 bytes
+	# (r13 is the number of bytes in plaintext mod 16)
+	sub	%r13, %r12
+	# get the appropriate shuffle mask
+	movdqu	(%r12), %xmm2
+	# shift right 16-r13 bytes
+	PSHUFB_XMM  %xmm2, %xmm1
+
+_data_read_\@:
 	lea ALL_F+16(%rip), %r12
 	sub %r13, %r12
+
 .ifc \operation, dec
 	movdqa  %xmm1, %xmm2
 .endif
-- 
2.9.5
