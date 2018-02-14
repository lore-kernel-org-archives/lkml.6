Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161420AbeBNRk2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:40:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161237AbeBNRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:40:23 -0500
Date: Wed, 14 Feb 2018 09:39:55 -0800
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
Subject: [PATCH v2 09/14] x86/crypto: aesni: Move ghash_mul to GCM_COMPLETE
Message-ID: <20180214173955.GA62088@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: DM5PR19CA0035.namprd19.prod.outlook.com (10.173.167.149) To
 CY4PR15MB1752.namprd15.prod.outlook.com (10.174.53.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc66a03f-7a55-4c3f-4c4a-08d573d1fabb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR15MB1752;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;3:w1ts2gflTVOBly13FJSA9D3WERjiAFfz8WAS6rsE1VW9NwDcl85iph/hNEjk60GisiEh587Foc1NYaee68BdVm0TjP1JDBY5zv9VPI/aWIGzROzyWXnvCfqAPqftOCjrKJSZL1zGEerL6GCF109UHG9GxZoXbwqVj3rv/Q+xgXPpZNXYoW4XjDaNnG+k/VR05TK0mMNtzTJvCNmqHqF2TdppwIaqfg2fy3+gB6Gi74XudT7VybTsxuDmOjMYVJti;25:vjPd1h9NPoNZ1fFKNpLg+UdCnTCTK8zAiaOz+rjGTNAjgo8eesoMTT7fYulXHAkNEKykQ+eLV4IIgoPSVMuB7LpiEY//i0IpVMdUGomlyAnQpvXFoC8HkuAZZrNn0XKUJaob20Hf/q78Fpg6jp/RxoMMqR1pBWH3c858XcME6DmM9FieZKkzxhcCPWE2P+SOp3TMjCiwnaE8054EHTp+9PgZF7rEyHvDf5DnVtbOdmzmLTddKd9ZhBVm/dC+wQQTzESWs24bfHUFXegONmyaiiKRa+e1Z0ZUgQVE6zNFCGROXRyzkmyJH04MQJ0DewL63oFU8wBj/uYR+Ot7iofjsA==;31:zxX7HVdGtl1JRAqLR6E7yvkQAwacSuzeRbbZ00uxMbnTNjCDjct9nS68IJaVHuhkjucyYucm/+LNppHxcOasIYwAy7LM9xXx3nDJkOZL8D7VaTJxb0X0QS/UKXCMrHXTdh5mnXnFgMFrwdpeR32WBjTA6Jor22lLOqpp536HB7Wkb/N/RKTRdmE+oims7XJrNaAwxWXUDdEPuaTXk3AtALks4ubvGv1KEllLU2x18DM=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1752:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:s7RHRaXIT1/dt6EONfnmJ7gCf5iUcvBEiEClywDQQYwrGkJdMkCzRd29q9udiLgvr/POOW+7ZtvuvZ8DYPF3WmmjNhPOf3E0LQE9sNFYu3gGsG+QGnE9mCu6GY19dUrz9p+0kXpsrvVSju5vM9vaxLer/PcN47pkomCDCq2Wu6nHPYvrEr6LraORDKljC7/3PtjffYN8c3zmdYoIsUPVTR3BL7cKk2BNsIdhXGL9KuAMcXop09vTZHWA0B3bsRdscSMGiXDliWLnPMvBE5qwsDlT56UCC7Mb0YEhy8W6cWvaMXXbnlhg/oykBlY6HSejer99PaHuKyqhKgHeyFcBEQygxLhf62FaSfMlJm+hbHu0b12/OXumJF9wQlPBuxQDdvoJ/Q/RXpJ64oqe8RN5vIropj3KQtph+1irpdJYd1dzZonRS04tTi5GemiOCno4EAO2iNfwszzCqRKsgsZOT0fPpROqPbvo599e/gTSD5OMrCZpj+kEIbpRpFSu7dj+;4:coAxjrRRYXKvoLdjz52T3oRyhylodCEi3PKaeHmZ8PkW75pqLfXI3vnXgvpqFBHxBlFIOKHykfggompR0J7wVwX7avHK4Wuz4yr7NAW/QN862R5JX2dfOpzSzhLUPIJf081kyskN8+Zi0a7MUdMXBOE92aK2F84gGRWLPivBVG1ynWgVUx3qgwbEOsCdCGWmujRin+VsoodUnvwK0UGdsM/9RIittjCfRv/4otAXFnebXuGlqBUmQOTebG/TnIGvjfA2sWpAAgIOdNkXA0XSioC/E22vD6dSuDmZPvctD4aZtUxN592lKKvx7Z9d9vHlIeKhWmAN8PJz18uUtvEkTBXZm65aeotEaxEPcSegofQ=
X-Microsoft-Antispam-PRVS: <CY4PR15MB1752243FC0FDA7A5FA177090DDF50@CY4PR15MB1752.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(11241501184)(944501161)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR15MB1752;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1752;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(199004)(189003)(305945005)(59450400001)(6496006)(52116002)(9686003)(52396003)(83506002)(54906003)(16586007)(58126008)(76176011)(386003)(33896004)(86362001)(16526019)(6486002)(8936002)(316002)(50466002)(97736004)(76506005)(7416002)(110136005)(81166006)(105586002)(53936002)(186003)(68736007)(4326008)(47776003)(1076002)(2950100002)(8676002)(33716001)(6666003)(81156014)(106356001)(2906002)(25786009)(23726003)(33656002)(5660300001)(6116002)(478600001)(7736002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1752;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1752;23:qnTSXDFA5134WOiXy6pEGjj+C8Pzs1rFUBawtffPP?=
 =?us-ascii?Q?sK7ebaqj8RLY8YM+wEFKXymoIZYp0BZ6o1+76BKjQUeZ7hXj1lgn/DowILiH?=
 =?us-ascii?Q?mv422xfR2IRFncu7Qkauy7Wy9rduJjCnoGNRCFeyV0ghgvlpBNng/bDpFZih?=
 =?us-ascii?Q?RH5QsKsW5ikIb9Iv6vggtQ9MUTnVY4m5g7ZQMDs72lIs42hpmX6OX8oIBCpW?=
 =?us-ascii?Q?QjkeVDx/xLh3SDmBky4gzw49YcKYZPfIeoBPlTl7ddGqyuj5crm/AK4T5HW6?=
 =?us-ascii?Q?Ev4OFhggYyFrsm/JF+qTMb4HVaE0ZDxpe/HhcYvisi7cnIbnriY1JNmWr9NM?=
 =?us-ascii?Q?SPx3Xj5Gk7ExwWAc1C6WSULqsRWBU6NDAE2R+0riCUcMRuAb2BPiZhnUVyl2?=
 =?us-ascii?Q?ege31Zv5wM+CWqICeRBKZrjYN5DkdFGv1cQ2HA9izhhzjEytfi8z6yFt1rd8?=
 =?us-ascii?Q?740iaqKOBCFNDBEi1/9WVKpQS6gvcqTbNfrtf4VfYYZeuRdzZlH1p6RYFqFp?=
 =?us-ascii?Q?R7Cd2MgrzzMYfUgwpxHOk2ecDG7Laow1aS5wrrIJ6eEBPw98cfOQyUl+uHO/?=
 =?us-ascii?Q?jFwkq0aFr6IG0JgWzcm9QtHBKCdYkTioDNKnGe99uGlNPT/0CyqCVgujGit1?=
 =?us-ascii?Q?j2g2WgBMh2eeD50Ch7/dvfwDtv3FQl0MaboGAWw0xKrHtiOMN2m+om/z3J6t?=
 =?us-ascii?Q?GGWN6IkQXzsoZsHTjHRZ9AyNNGEjWR4tqxJC0CWy3cC5XJdHcCtrcyPxYoB+?=
 =?us-ascii?Q?VSvTVdYoFdhwpU5xSP/trJy8mmJZ6nPv6R3ceBZGPriNt3uS6sHeKPH5UHyN?=
 =?us-ascii?Q?k/huvU+LwsfE5F/DsO7pwgojMCZdrkQmENcTDLHjsHBaIxWc9MW2KhBLQdar?=
 =?us-ascii?Q?NK4YgvB5a77QGxMauU90gVLlhRZbwRfp1NyLO4+bZ+1b+FWV1VFJY1Z0S9HJ?=
 =?us-ascii?Q?y8XwYEEsBZHKfn7Xv+4R9og1OskDtq7muyJfW2ER9fKzYnNYDRzXO9ybFq5q?=
 =?us-ascii?Q?8MQ60j0A0SE7e2I5EskK7RZ1329XnAlmt1eiC6bxMr9XGGnt1YKW7/BFGzJT?=
 =?us-ascii?Q?AZoNKkdKBabbe+GL550C3lt+eyVlyAcaWvNCPWk1NlCQ8iXhxTWL+CegWaSI?=
 =?us-ascii?Q?kbjBML3jqnGCLiE73fwwdVhVnU5rdA3iVlLoszKSxKCPB2pQKYnTB/YJLFdv?=
 =?us-ascii?Q?m6X0E5YGgasBeL29ZyU4SJB+a4U79p5taOxQ33wOTVzJuuerKXoA9ILcNKhg?=
 =?us-ascii?Q?3PCDsLYm9DH+vilhbRCPOOroHfRb8dXck05YaZa57tb6UQZGSkw7+r5f9/6V?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;6:1ccfyrtIfxKpvJTdnd8pKWiVKG7q512f9V++sRjlxsJZ6Rk0V0yPvf/Uh8T+KzG0yKT1qSeNHRPH9DNmwGegDfcaBzEaiI4PNaSt+ILnUtNALHByqnwNWuLH8W6MDDzCmN5OAJMcW1tDIc6ADigCEf9DwTZF0iDl6iJCohks/2n73z5ot6DH/IqofYV2tq9tCkrO2y9ZsWOIHtjLDw7pXm7S7k6ZdzZGOQhP7kdYvIO/yhemxchGsnjk11E78+k7uNYmP1bvn0ad/5V6reclRP/7OPqOEXfmqEGtpZvFo84sE/jNJpeRAoqQGbcNCowD5GXDyPoLzHIjd1iOc0ey4dUafp1QvgvAtDMizOrdf0g=;5:FSJegvZhxvBU+x9ftxpP574GUyahaTvuZOUG6kR5y0PvO2CBZvabwytewfnTXK0VrGoYQX4kMw7QJggQUZ6i5JdF8CsYZO0G2MvsPQajwXo3g802dMUIkUQUZzZv1EnIB+5OKPDNGjr9vPVaQku3p719aeIbc08WFZEfRSgqbcE=;24:bhKSDlV7BWXyo3ApCetCDUuMPhEKLIzO52FBOigcCbJnsmEGkQALZsof/7+rQI3oGtHSdScE61RSCVz83JfynrnxEyeSfha6URHt6o0a/AE=;7:F+k3HA/UuBDNxojqM+/ydnEO5ExZxTZlIhqZYuHDJs9dXTievtYtTwquZelgV3G5LI7RuGnsdtLYjMytKYth55AVSJAi2fLRAi/oFgYqhpFXMuZ1AgYZf9zwVTidGNUDYqMMLcB5BYCHDV684IKh99V47/lSaG6+ClootyWYxqGg1tAMoi4lVlVEVC6ppH5M/kSeNYzXPSPsHhWvzGF4JhEdUxkG6HD5GeQXpQXlChZFsJQv33DKVnQU5EOj3sYN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:EFaPFIWzHtFC5CUf5pS3vz0QqdJ8+WOu5U/qge/ItDT+s95y2vT2uUsazbBdIBKdLf3BcNFUzHpFoqeNCcMCqiigBH1K6nAGha6MyVZZECjK2Spi2r4lZhct5swbe9WiV/H2A73S/TccLMzX4HMweQcKWPjpYl4HaE+wvNKQYjw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:40:03.2387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc66a03f-7a55-4c3f-4c4a-08d573d1fabb
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
