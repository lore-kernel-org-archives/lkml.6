Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161478AbeBNRlN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:41:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38474 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161447AbeBNRk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:40:58 -0500
Date: Wed, 14 Feb 2018 09:40:31 -0800
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
Subject: [PATCH v2 12/14] x86/crypto: aesni: Add fast path for > 16 byte
 update
Message-ID: <20180214174031.GA62186@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: MWHPR20CA0011.namprd20.prod.outlook.com (10.171.151.149) To
 CY4PR15MB1752.namprd15.prod.outlook.com (10.174.53.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e980dea2-9b02-4415-8e7e-08d573d210bf
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR15MB1752;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;3:uTfg2SMLgCAuzNQwCDnQfFRgkHFOQO7FuWjae0jbW5Z7yD7NskAI7GxeGLe8z06PrqrWtpcZWmP4aroPW9CKx7JzAzGumU6opPdhmkffu9qt87Ydt+PLWVWU7HKcCnwQih3MdXLg0lppXSlIHpjhLG79mtTEsRgDk2LBsrGJcB9imLUHbYlaqSdTaScrU3N2r3o7J8+RTB5F4FXGFFr+I0NpyQHo0+RbIx3sgaRraZz1INLV3Beg8wOxFx82nNvu;25:ANOs8bH6TAoKepIMbPUPG4qwM6gKRlLaR7Buz3YgXxZoOrfvU60FOG1eDDq4Mzb0Gnfbwf2LOClcjoB8zuK8JFH1faxRfkXTUS4Se/qP3yU9hZQ7BJ6FDaRIBEWXdKY60OP1LgSMhUg9PuWZ63VjLIyKxuxHz4TjUXdGCr2mnOn57DEY7FblaJYsxxkwVriPcJLmlVHqWGbJ5c21dyFf5qkx5CUp1jfcAo1zQzrQOnlv5qXXMjoGO6FaYLGboFu9R20PNNRnwbF72DSgIzaHgt8QuI8bCyYnIDRW99mtCnXbqSpdbZJ5bqp1QAkxMdDgAn01rR2vgRdJYHsbAEYFcg==;31:QW9CyaP6ffYDm0lsyxcS1R63TjVuQSXRVqst211UIzIjH02crejsmy03yVcgNhz6kOGGJJm9PoZU6/kvh7baU/uxD/QMA3LgRrlV1bV2mgCB7jW/EqEWwnG4rV/+LwEulf++QKkYC8Xk6IGZ/NIwBr3Io5E3CkHFnMQKLoCr+bKyIuPNxU/BhltU6a9HPAA+DE3OQrChMqUx1Nc+4kbavAknvcP5QMmj1Tj454AYEPE=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1752:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:RZrHOad4vdbo2hOg/tyGvPnn+LJ/IdJhkR2/JEH91N3BgLvnGHoAz/hCM0S29TtcH6xoY0JyeJx7C0N8gD+SR3vzMxPlatfLvJR/mTeXjOI8z2Yb3rUA90CBdGhv+torjmwG5lLffdv1UwEv7dA2icgG2PtDNCyzTUb8U+Pp6Uq875zHA70qj6QIq0G5RChIpSE4rlgazxgR77KXFRIRhAPyKm+XDloazHviixXte1NJwUUAME85SMAN7788HhnyqKzCuyjCARFRIW4z1SlrSVwluK/q3bFdJX5OAUXnBGbTvIeJ+J42yR7/mXaaibjh1yILT/bIwMTXggTH8n92C+QgRmNdC9CNT7YF7oLzxRIzZ103K2MigFR72Spp2ikc9cl6eH6rEKMOMLtepiGa0v2RRr2xgixz8+uTLVlHjp3KXRN6R5hmRlEGc92N3ia03+RTuXhytx+lFIoLi88lMCUnMhFuACZOWUV1yhrSvBxlLgdyYm9mGROFr7sdFsLE;4:0dyd71uyEDuonJK0USPqpWdjus17vxio+M1P3nc+LXJEleUm0anVP5U3mA7b0Lnd288rtEgTh1gBKyIPA2kVY+oAi5FQ3sUErWHy7JYAeeea3d0nbBvTdJup25zUSGUPR1vUfSvXLxB3djhzSoIpOIF5mlcZonwWPKSL4sm3Iup4rkRd4GERdAJolKVoDQhjtcR7Fmy1/VVaU00PdhUl+r7vX2y7cQwZ4IivfZUjx2rT84Tngc/k11xP9qs0oUD/svbCqRJhvsIuAInktZ3pBh/b57VPutYuvGZH7El6rdmYQp/eRNsWx1gYRVanrUSXAJqMFXL/dkypBuN2hVyz+jsmMzqrTqHdxjJDqasPhQA=
X-Microsoft-Antispam-PRVS: <CY4PR15MB17526919AFE5631714F37501DDF50@CY4PR15MB1752.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(11241501184)(944501161)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR15MB1752;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1752;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(7916004)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(199004)(189003)(305945005)(59450400001)(6496006)(52116002)(9686003)(52396003)(83506002)(54906003)(16586007)(58126008)(76176011)(386003)(33896004)(86362001)(16526019)(6486002)(8936002)(316002)(50466002)(97736004)(76506005)(7416002)(110136005)(81166006)(105586002)(53936002)(186003)(68736007)(4326008)(47776003)(1076002)(2950100002)(8676002)(33716001)(6666003)(81156014)(106356001)(2906002)(25786009)(23726003)(33656002)(15650500001)(5660300001)(6116002)(478600001)(7736002)(18370500001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1752;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1752;23:UgCuLQb3i6CA2CM7RcTa9JLvT1ElLO3lQAY0IogDq?=
 =?us-ascii?Q?fkJfIAdVDMk1PFuOsvBdLA5fcKgf13YT+rXIIPXbydKfeghSTwp/l5xx7OlK?=
 =?us-ascii?Q?lUVU4hPCHomqz0Ok1P3bLBTuUBfhKrj7USn3/PFi9jTVw6M+uf9dGq2zloRw?=
 =?us-ascii?Q?bVzd6NwKMD/SXy2dCRRAVFpI/vkb2jcuVYlHxpSegvGQtpezSIaREOKqpaZr?=
 =?us-ascii?Q?0QtuUQ6dg1H7ZeN6YNfepDOYcyQtcdPOtOgWxO5do+aYyLWd5OafpA8e/b4L?=
 =?us-ascii?Q?iW1NUGSjOZ1xxJHrxSNpIq+uleqnv8SXe6en2omNKAglhPJfjDVufSZiySzI?=
 =?us-ascii?Q?TaOdIWlluoa1N0hHCkHcVn3xg2oevTfrLUQ3ZPwO3sVGO7lpKo0nisCmyD2y?=
 =?us-ascii?Q?O7fZfIh/L3amdhLx082q7vIMEwz5fPHQU71MLDS6lEgTxdfs+8Arr7PiwAR/?=
 =?us-ascii?Q?f/178YDx1OofocfFHVx90QCBVA+Oy6/JOUMOTK/4U76A109KSTYvy+YzvsdJ?=
 =?us-ascii?Q?1VKfDPSYhhcqmY1d2EMPofBy3BG7STzONDIf1P9RVjn6ZqHxAirVsnBS0r5u?=
 =?us-ascii?Q?sweoBnFrAPzxuoaDux3BSdtPdKpitDxIvslnjM+4xUvi21NlDct2bYABIKtL?=
 =?us-ascii?Q?3xU1d7B/W5Rm8+VSskXm2BiYILwr36ariXZEEHqj00yIdtafrbyTlPoX204e?=
 =?us-ascii?Q?MYek7YnePJJ9Bq+RgDllUYGp+I3ozKSLY3tbfrAPNrCx+im/oO/ec4Uhjf4w?=
 =?us-ascii?Q?7BhnDc+2NhYyp1rz//IsqaDUg6/CTP7Z/OMX6p1FFzIdz9suxu1GCfbOyfne?=
 =?us-ascii?Q?TvkphRZlsMXesfmlzUDaRcxlvtxTCcWsUJn/Z2cdtWA6RbcLjVAtrokdYZHn?=
 =?us-ascii?Q?nbicT6WF2RZ79x3r//9Vm+xwY53m4je9P32KfMwEwPbsh/xcBgSSXZoUjqv5?=
 =?us-ascii?Q?vRp2SC1fVlnkjV44mCp8cdulOZtWPs50CTj2ieFRnhEll/9lS39ZgeIvQTJ5?=
 =?us-ascii?Q?oeiLmf+05ablBLZFO8eDSOgyogHTKO66Idd4CLRoxBdSJV5Y/9d6frU7+oms?=
 =?us-ascii?Q?CD86GWfSFdVojlnNnsZ8k8/ZVF0JDw6ZZ+CcLx78w/VHIBoGk4ae2aXhodPj?=
 =?us-ascii?Q?Mt/wKRHaQ0P/aW5guXzv/+pijR11dRvaiaR+Gfqv6KfYc/TdJYrplWQq/jau?=
 =?us-ascii?Q?vm8z/rnX8r7qNwWD2YbVWGL7DFZdVR7MOua3P+bsTdmhG8YGgnXW58m0AXp8?=
 =?us-ascii?Q?GvFJMTxYT3Ano6HxocQ5Epee4iIUER6vGkd2A69YRSut3HgI7FzWRuZjbVFE?=
 =?us-ascii?Q?WooHVjAmmCHnjoPelPIC1WGF9e5Deb0RC0yGdNZ4wa/OBosRSgG8DelKJHCP?=
 =?us-ascii?Q?ilHYknZYbq5eucC6EsQKq3XQcqsRg95HOLmK/Z6yFZ9G1Ce?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;6:1o0CbCmiv9i0quxuvXJPzsN0umqhJQX9MoajFuoZvUOuTjoMDcOc1E0omNoV59mMZvmncUJDaPpuDla2tSFe41tx7LHjIhj6+l6PQu7u5TvARCrWf6OCeSo1x7/QF8YH7cYH2SqnWyw/XN7KGW4b2xErPkJLjtkLToMzBjoJkH6i8aFSm1IKAL5HV7bd8fgoFXvN50O8eWyUR3fZXzVZF/TakPzwy79dHprhW9kGPmTv5Dwy/em55Gvz5z4g7c6bJ7zmcl8ELTRShh0XjguXxDqkRt787IoctbzBbLX8POxLyDNUkFYt3Q1eReefDqbFT/06jQ4fN3MDwVrtBaKfPCKvPoLs9J2OGyA4+tN9mAw=;5:jWKercw/aJ/b2fQAN2FCuOZauITRNz2H5/4kKv3+LjXc3TZHwArhwFWBX6knw+SowD4LyH9hfzNvx3HONYNme5wacAP1yL/klK5YdspjrxfcYXHTesU+SmsK6b7xO5OGxhhwlQ+v4bh3CSHcxkXzqpxZoWVscRgY/7UioQTRj+A=;24:TEeZ/OXKIxRcnK1E3UMeMwMVNgIh+UlVyzrWVNQTV6cBpTixvtZniSmFKgWgGVn1jH79NYi1opqRFtE/zIzVRBPmuZdkqYw3xOGcIRbxNRI=;7:lxuBrxpWsjf6JqFR+Ebr95p/mqoU/AUH0PYQo8oZuC6b5TCQ5WuwzRSH208qo31QmPezAOsxW3MGTW7xAqb/Lo0S9oQ4eW9O3VvFOC0FkSm2N5R/ugYUxnV9oiqi1Fs/KupN1shvDgpu3n9vMVhWEav2iIf4aiLgtmhLhybDnTV9SMKb8dxK5+cxLcXHmYxNr72HZTKxYwcKTBVsdYO7koJ5XWqOWGAly2kKVzAc7g4SiE2IiIwy0CaCS9dqpdbl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:MC/VDNAWLmWP0nq542Sls84eBiBf6vOKODUfqoap6U0xh+8vYQ9/5546WYPdAm+FuE2fJNb8bfS6u84VWQ4GJeMkn/cRm2uiNEXuhY8MCTakkGtYKsRA/ufVfuVzA8KFq2ZU85ENco89ALr0gZj8ob1sSsaRxDni4ds4mFtBBss=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:40:40.3015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e980dea2-9b02-4415-8e7e-08d573d210bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1752
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
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
