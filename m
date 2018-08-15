Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961CFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85972208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oSc0AdPi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="G4XE8gAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85972208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbeHOUXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:23:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55102 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727604AbeHOUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:23:06 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FHTddj032095;
        Wed, 15 Aug 2018 10:29:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=facebook;
 bh=VAChRuwD1WbJxe2j73p6Z/wMluQNWr6/J9Gys7GdqZc=;
 b=oSc0AdPi+d+FajsKvCEDf/SJhbbUY44B+z5zxVZFne5K6tK7S014i9plQ5jpcPxJHK0S
 lpeY8/dfBepeinmFday7EjePv5wawx5QyBMwUDQJgaZ7s7T4fds5XGQh9OuuOxF/7l7n
 LBRIzsB2v1Nv+adTMQjgROBUQnvdc7V+gWs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kvrhj00pt-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 15 Aug 2018 10:29:49 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 15 Aug 2018 10:29:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAChRuwD1WbJxe2j73p6Z/wMluQNWr6/J9Gys7GdqZc=;
 b=G4XE8gAfyCdKTZEmz3kjn0JDG5AbiuK8k0PUdw4ujJLAeyF1PRfLiGivnzdklaDGgNJ+yG7AqZFMiIcPlZvDejvCOQTWqguicJIm+Lfn5TOHYG9bBFi39906OfYQVhqgl5oduo1w+3iAUfz1GGMUiXDcIMFst0trGR/+UZAbDnA=
Received: from localhost (2620:10d:c090:180::1:e08d) by
 MWHPR15MB1134.namprd15.prod.outlook.com (2603:10b6:320:22::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.23; Wed, 15 Aug 2018 17:29:46 +0000
Date:   Wed, 15 Aug 2018 10:29:42 -0700
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Mauro Rossi <issor.oruam@gmail.com>,
        <linux-crypto@vger.kernel.org>
CC:     Junaid Shahid <junaids@google.com>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH] crypto: aesni - Use unaligned loads from gcm_context_data
Message-ID: <20180815172942.mkk56gh6poqgjgnb@davejwatson-mba.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Originating-IP: [2620:10d:c090:180::1:e08d]
X-ClientProxiedBy: BN6PR14CA0038.namprd14.prod.outlook.com
 (2603:10b6:404:13f::24) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42c5ce34-9bde-4cd7-9e69-08d602d4b228
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1134;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1134;3:BmE3MUeoB3AiRIU5SygFDid2oM4aTlfLmZmKGpqKV2orn94oxZEazwy3Mlo2UBSUVWGiFbnWyCRnuxxsOMypYJjgshC4eNs6zNMOmGPkFS/1ZeDZuxS4rXWVy9Lr5eV2VNxwN6VYPQb8fvZt32D0uizpDL4mgOOjrXejtYfIgsJrbKtc78+eOPrNg3iu5bJQcsLyBSXjOYP5/+lWfrFxD3dIiAe3s8OS8OHLqWs0fv/UQE0WGhw15uXwgY3zOMEI;25:ykdjtIBBfy9D2Emi48aOlFedHq3KsCjjx0cOD1cuGJaHTvgXGHVO3xjz81THeNWxsrP85fK0F8sJJ2N9ee9z7TKDiA25MIj36Or8ZHCyXEhyFVY2A3/0uATMFUVy7YdzXlJDejUnzW1U6v0n7x2J+gEV40BczfdZCxFDX8AI27LIFlEp7vNQTnMFdcg9SzPCRpnNya1JO6eUxh118q4JVczhrgHMhSsCoTV9vetyjNpE+VNqu/ahpOn3bO22djzIkuU7Bc6j+Pl0Ep+gSr2BGPUQe72nu660PG9p6kAx78dNPt3Pcf3+BqLgTpHsF6U6MtY06juqBMd8Q0KYE9kYqQ==;31:k/W9HMlkY1v5C04LPvaWjKipWd2Q2b6TTSLfVV3scxkcezgYT6JEQGFOUnxom+VlbZ1bTUN8bYA0l5XYZYZwUFLsgbNWg7Ix+LN5l3i3QFR5z3z7jYZxni6lZUNQTABBhGpN17VqMcQUEjB7AXflIjESYyGWUNL84t+b4TKIJH+arRntrx0+GI4yhnLbH53NwqwHmOqKi0F30iiZAfe7+XIibM1pDYZ79LF4vMWmRsA=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1134:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1134;20:bGWnEbBCyX1b34WxzZZbz1x/QB56Y4cUodMVimBcESZ4ayCveq5Kzz1tXm4UpfAX9RvnE8qvbTY/KQQ/uybeVHyZGxE9iJS+mfxYrfrFYd7k406bVlymg/xXCcobS5JtqWNmwBYGV2/lP27APZhd3TorZeI/bIdgw8/PcLwZXC07idwqNK+REMFa+Ob1n/E2k1WcChbyvDZRlBp2t1XTbQG3LLAc5l7m8YA76AvJEM9AUntfBhzSof1Ip+13qy3pux+wBsXx/iCLv7CjVkWLvuAdn3oEaBk3uiZNE4qk82poLcfKEPuLtJpsdtZk5YCKt0NYnqtkB0GhMWbgDtyzrW4qx+K6iViXWqJKQ5eEnhwLaA7tbPggoOKRtH7mi/Na5OmjcOMtc4MxUfxvvv8qZ4E+Js69duhlzSOGxWMGJ8wFolO0lFhy9Hk4YSbL7XBI6U2I0nqxVs3NgwsSrKrj/wRAD6Wmcrkq4VUVsm40e0Fuw7Zw/yfkq8Dpl4qaFZa4;4:7tIwnRw7s+EX2Mxvt5aIN5gt47lauTyT0ZmL0ACyUCirsSuRiJJokQ1s8XiyOV6kZgaQlMUvGnPYyLpJvm1WE4OZfUxvF9qgmBpPprAnPGEEIFOh1vsDlwHuPxxboo3xGDsU4nKNrqoI78cGvgqRgIwAuLrus/V+6l7vA4jkObtaCmNtP3p4mUegkV904xUyKpAqO1GZZllURz5FK6QQMyuitZiaT0pi0Prj1ponkaijdDTv0OWFqSSIepl/YOE8jLop6C25DwZ1KdAN/1J/TON86GBouCrLGKBmX4yeey+gOG4/uRAzi1LR75Tt7DfYkgakiKvpCNvot0nLU1C8j6xB3r5qa7h/bHnQLu3+YXIe0GtKQj1Bwpm/slp2lvrL
X-Microsoft-Antispam-PRVS: <MWHPR15MB113468AE9C071DFD8E378171DD3F0@MWHPR15MB1134.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(266576461109395);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1134;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1134;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(39860400002)(366004)(376002)(396003)(346002)(199004)(189003)(105586002)(106356001)(5660300001)(186003)(8936002)(81156014)(76506005)(8676002)(478600001)(110136005)(58126008)(316002)(81166006)(53936002)(16586007)(39060400002)(9686003)(16526019)(54906003)(86362001)(50466002)(97736004)(46003)(2906002)(6116002)(98436002)(4326008)(1076002)(386003)(6666003)(33896004)(25786009)(52396003)(68736007)(6496006)(305945005)(47776003)(486006)(6486002)(52116002)(23726003)(476003)(1857600001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1134;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1134;23:DPWAqKNmiH+ja79x2B+5NnuDFj15dRNwV0ANIZolt?=
 =?us-ascii?Q?/Vjc+/xlNVo750aDMeNb+eJL63Kvd+3VcT3dbktS6LXHtbKNpQYTCCGCuuFn?=
 =?us-ascii?Q?/9khFnxs2qQI6UTKKc/rZH0Tqfu+Hsi7v8CRcOCJ2w/JkPRwQ8aPVcZnJkOa?=
 =?us-ascii?Q?Htv729TlQnzUD0nZFOpDslSrd13LIAzvjRT7Cf0CAgOKohtnB36G0F0MGKa8?=
 =?us-ascii?Q?/88l5glmWr93mYYeRWM4cr2Yrtki3cNf4gDzEiB+M1vZDHDFcS3yHdkLMlgl?=
 =?us-ascii?Q?15za7VEkvAjcK8CaFq4ObbM0Wtk1IfSpvqopwJp84/NeFve7iJvyoLZPPMTg?=
 =?us-ascii?Q?SQe08EEUSNyWRsbMlYkwwujDH7+NpgaugZJa8SVyyayiaEabLr2iQ1sCQHCQ?=
 =?us-ascii?Q?be1ieHFhQRX4sNbpuowpP+ZsqaIKMhwhpDbJ7JY8G+2dOzjMk8SyUdB8iKqU?=
 =?us-ascii?Q?58g6OAZIhF3MyRMBVM08TNVIKUq5CLY1OopJcTx59V7MWGwyC6qWu9O3Fr29?=
 =?us-ascii?Q?9Ypr26OtHnTCvBZuN6h4Ge4ITfzErpWePQSfJItyGAg6qGheawz8d6m/pIKb?=
 =?us-ascii?Q?r6d3lTZUQ+t/qa/YyItyf5bp2Xq/BmBtGwiBfB1sSvtJwAqqljbQEh0v0jZi?=
 =?us-ascii?Q?pNkUGWO1YrZD2Ufs4GstaB9wFcvhhmAYfvE96VzQ0XEk87xEKFKi6/9fLEC6?=
 =?us-ascii?Q?t1b5Fwwgd921vpHXMZuNggBg6IFXZ0odW+x/7qGKJAXvtlgmcGSHkP6pLoix?=
 =?us-ascii?Q?ymOnjUMx1bHIyC0ugiY1VZMMG7VuoCb7BEIBFL0FkO+3shyp+L1cEEu7+q5W?=
 =?us-ascii?Q?wpcOjy466zC7rYLI4pQrlggC1DRJzMcNTpy77P5UjNsBUh8DV97wzta0qytK?=
 =?us-ascii?Q?t7tvUWwk8J45bXPraluM1q/UbbCR962uipy0uV3byqWR3YmEH8nsN+4fBJKK?=
 =?us-ascii?Q?byKQfmQAOPQau2uz2VnaqqbbV1+zHWDFNX3Dsbrh4g5r6yJFzFLV7ck8yjQB?=
 =?us-ascii?Q?+0NUw5rU+6ZS8ifkArbNY8mv8lQwp0bM+sRDQ2MGhEbUd7dWUDFayXWn83G6?=
 =?us-ascii?Q?XKw8AE6PqM14F5jM9Ln5R18PXqmJBpteblLkhL3amecLMhS/OrlyqkV0RwMy?=
 =?us-ascii?Q?A0bdR/uITMwfa7GR3n7gflSxrpRAa+p0G7hD+T/o+Ik1PesR41ZEtwIpio7u?=
 =?us-ascii?Q?OOHBlmEBd6hfJY=3D?=
X-Microsoft-Antispam-Message-Info: 6Up9UEkOemL8oC0/ajyNyp8+G06zZ1lxY6Le8UDbRvs57DrpdDFbQ1dGzQU0o2RRCOBRvqyhlxK86dMkayOjr4OlX7lrE5XujeImTCKtEbVHd+RvvEAvyaxEHO9uAW2YvLh+3F/7cuFvYZ7o9veyXr9DvF7P7y90+51ifSieLmu4Cmt2zzONGJaRd2pj3SyAD7Z//HEYrMdblCW0ASFFQojU1pGIlegdh/ON7lSqe2NfJdiHBHWdsKDAq0egU64FZFcnz6lkOKmdqK+cvWzJITQKlL39xBvlLC7xzR8N7bh+RfUPU8EbV5wAdcE5733P0Y3bRT+1yPInkI5OqcyIYY1IjC7Zgp1EECxO1B2B7Bg=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1134;6:5PyIKXLhEiwncvpcpvnUJG0gmRgJVY+JFWlMUmurGseeoiC6JyvyJCabcA3nE5kFoLxV/rG846pVo6nQn1bDefNDj4Oi5scg0QiZeamgYaR+XbCugLMwAjCtvmlUQI3EEmgUcEdIH/ANdCagEjFgNV9kGQUgQDc+zXGjDVwRYtAEhAkt7GLX6bEeDyKkQVw/JfaZEDTOUXPfWVATHHSxyVBqWZ6mgt5uuEujKvhn8TefzwJ5ZPyf+ilErDWlKbnus3pDnQCf9FsiISnf3FzbLehPs0/5m1xHE0evBxOM1lAT+1t06T0asxqj10WorlBcmdYqmcx67KgPDwvOjXfMqkQqElHvV8G1ZkwJyf9a4pIsokq+hSwhc7zuPhmTy2SMaK81sSzvHAnealURkYj3K5AdLyPbR+XAlD0ECQIUdrtRtfuddfpC08n3KT/72WyZIPC5RXYuDd6fmKceeI9Q6Q==;5:hBMA6IfuzjVvqMGsOKHgWePgXV4G+4tS4nb1+vUZPn7reW+F5R8b0o7KaIkjPl/8+RsrV1w9xzKkdOkM2Wu1JSVfW4ZmW+/gnnlqYs8V7c5QQHbtecnJIWEyPuAulxb7KHGLgp9QtGLz6ijLkqUSOLJ1pcwg0oIs7jUUTWyqlRU=;7:2cfuMD+RKu4mkerEGrmiDiWBMy3YvyirbSjThVYPap/dDyoNXuF6j0Km7ndRNQFRvW/MfzaekBWDtjtXVD2aD/cj43o9gAE13P01md3JgD6Q0i6tsCRs8bjPq/Zry5EwlSxe/n7Oxhymid2La/WCIjWBl7NUYj/5TtuEJdjdxX4x+c99tGOC3bU8fVNpJqggXEE0pOi9h8BZ7UAvWdUmgdypqB2CKm3tXcNxU9r0juQRnTY/hpXZ+5aHSgkkntur
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1134;20:EV5mndnKg/XfddUjEqTcYP65G8yebUnzgAxNXjyWY8XE7ir9O9nCevquLPtHpT9NntZ8ew91q7UdKm/0nu0xomnk46IstIVkSsL7LD8jAEo4T1qx4eg9dvXxMh8zaKOxMwLJV7eYJUNg3B4/CnBthUA6f7IgMGwXs+C79tvP7QI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 17:29:46.1960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c5ce34-9bde-4cd7-9e69-08d602d4b228
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1134
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A regression was reported bisecting to 1476db2d12
"Move HashKey computation from stack to gcm_context".  That diff
moved HashKey computation from the stack, which was explicitly aligned
in the asm, to a struct provided from the C code, depending on
AESNI_ALIGN_ATTR for alignment.   It appears some compilers may not
align this struct correctly, resulting in a crash on the movdqa
instruction when attempting to encrypt or decrypt data.

Fix by using unaligned loads for the HashKeys.  On modern
hardware there is no perf difference between the unaligned and
aligned loads.  All other accesses to gcm_context_data already use
unaligned loads.

Reported-by: Mauro Rossi <issor.oruam@gmail.com>
Fixes: 1476db2d12 ("Move HashKey computation from stack to gcm_context")
Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 66 +++++++++++++++----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index e762ef417562..d27a50656aa1 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -223,34 +223,34 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	pcmpeqd TWOONE(%rip), \TMP2
 	pand	POLY(%rip), \TMP2
 	pxor	\TMP2, \TMP3
-	movdqa	\TMP3, HashKey(%arg2)
+	movdqu	\TMP3, HashKey(%arg2)
 
 	movdqa	   \TMP3, \TMP5
 	pshufd	   $78, \TMP3, \TMP1
 	pxor	   \TMP3, \TMP1
-	movdqa	   \TMP1, HashKey_k(%arg2)
+	movdqu	   \TMP1, HashKey_k(%arg2)
 
 	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
 # TMP5 = HashKey^2<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_2(%arg2)
+	movdqu	   \TMP5, HashKey_2(%arg2)
 # HashKey_2 = HashKey^2<<1 (mod poly)
 	pshufd	   $78, \TMP5, \TMP1
 	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_2_k(%arg2)
+	movdqu	   \TMP1, HashKey_2_k(%arg2)
 
 	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
 # TMP5 = HashKey^3<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_3(%arg2)
+	movdqu	   \TMP5, HashKey_3(%arg2)
 	pshufd	   $78, \TMP5, \TMP1
 	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_3_k(%arg2)
+	movdqu	   \TMP1, HashKey_3_k(%arg2)
 
 	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
 # TMP5 = HashKey^3<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_4(%arg2)
+	movdqu	   \TMP5, HashKey_4(%arg2)
 	pshufd	   $78, \TMP5, \TMP1
 	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_4_k(%arg2)
+	movdqu	   \TMP1, HashKey_4_k(%arg2)
 .endm
 
 # GCM_INIT initializes a gcm_context struct to prepare for encoding/decoding.
@@ -271,7 +271,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	movdqu %xmm0, CurCount(%arg2) # ctx_data.current_counter = iv
 
 	PRECOMPUTE \SUBKEY, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
-	movdqa HashKey(%arg2), %xmm13
+	movdqu HashKey(%arg2), %xmm13
 
 	CALC_AAD_HASH %xmm13, \AAD, \AADLEN, %xmm0, %xmm1, %xmm2, %xmm3, \
 	%xmm4, %xmm5, %xmm6
@@ -997,7 +997,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	pshufd	  $78, \XMM5, \TMP6
 	pxor	  \XMM5, \TMP6
 	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa	  HashKey_4(%arg2), \TMP5
+	movdqu	  HashKey_4(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP4           # TMP4 = a1*b1
 	movdqa    \XMM0, \XMM1
 	paddd     ONE(%rip), \XMM0		# INCR CNT
@@ -1016,7 +1016,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	pxor	  (%arg1), \XMM2
 	pxor	  (%arg1), \XMM3
 	pxor	  (%arg1), \XMM4
-	movdqa	  HashKey_4_k(%arg2), \TMP5
+	movdqu	  HashKey_4_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP6           # TMP6 = (a1+a0)*(b1+b0)
 	movaps 0x10(%arg1), \TMP1
 	AESENC	  \TMP1, \XMM1              # Round 1
@@ -1031,7 +1031,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM6, \TMP1
 	pshufd	  $78, \XMM6, \TMP2
 	pxor	  \XMM6, \TMP2
-	movdqa	  HashKey_3(%arg2), \TMP5
+	movdqu	  HashKey_3(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1           # TMP1 = a1 * b1
 	movaps 0x30(%arg1), \TMP3
 	AESENC    \TMP3, \XMM1              # Round 3
@@ -1044,7 +1044,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	AESENC	  \TMP3, \XMM2
 	AESENC	  \TMP3, \XMM3
 	AESENC	  \TMP3, \XMM4
-	movdqa	  HashKey_3_k(%arg2), \TMP5
+	movdqu	  HashKey_3_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2           # TMP2 = (a1+a0)*(b1+b0)
 	movaps 0x50(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1              # Round 5
@@ -1058,7 +1058,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM7, \TMP1
 	pshufd	  $78, \XMM7, \TMP2
 	pxor	  \XMM7, \TMP2
-	movdqa	  HashKey_2(%arg2), \TMP5
+	movdqu	  HashKey_2(%arg2), \TMP5
 
         # Multiply TMP5 * HashKey using karatsuba
 
@@ -1074,7 +1074,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	AESENC	  \TMP3, \XMM2
 	AESENC	  \TMP3, \XMM3
 	AESENC	  \TMP3, \XMM4
-	movdqa	  HashKey_2_k(%arg2), \TMP5
+	movdqu	  HashKey_2_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2           # TMP2 = (a1+a0)*(b1+b0)
 	movaps 0x80(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1             # Round 8
@@ -1092,7 +1092,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM8, \TMP1
 	pshufd	  $78, \XMM8, \TMP2
 	pxor	  \XMM8, \TMP2
-	movdqa	  HashKey(%arg2), \TMP5
+	movdqu	  HashKey(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1          # TMP1 = a1*b1
 	movaps 0x90(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1            # Round 9
@@ -1121,7 +1121,7 @@ aes_loop_par_enc_done\@:
 	AESENCLAST \TMP3, \XMM2
 	AESENCLAST \TMP3, \XMM3
 	AESENCLAST \TMP3, \XMM4
-	movdqa    HashKey_k(%arg2), \TMP5
+	movdqu    HashKey_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2          # TMP2 = (a1+a0)*(b1+b0)
 	movdqu	  (%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM1                 # Ciphertext/Plaintext XOR EK
@@ -1205,7 +1205,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	pshufd	  $78, \XMM5, \TMP6
 	pxor	  \XMM5, \TMP6
 	paddd     ONE(%rip), \XMM0		# INCR CNT
-	movdqa	  HashKey_4(%arg2), \TMP5
+	movdqu	  HashKey_4(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP4           # TMP4 = a1*b1
 	movdqa    \XMM0, \XMM1
 	paddd     ONE(%rip), \XMM0		# INCR CNT
@@ -1224,7 +1224,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	pxor	  (%arg1), \XMM2
 	pxor	  (%arg1), \XMM3
 	pxor	  (%arg1), \XMM4
-	movdqa	  HashKey_4_k(%arg2), \TMP5
+	movdqu	  HashKey_4_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP6           # TMP6 = (a1+a0)*(b1+b0)
 	movaps 0x10(%arg1), \TMP1
 	AESENC	  \TMP1, \XMM1              # Round 1
@@ -1239,7 +1239,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM6, \TMP1
 	pshufd	  $78, \XMM6, \TMP2
 	pxor	  \XMM6, \TMP2
-	movdqa	  HashKey_3(%arg2), \TMP5
+	movdqu	  HashKey_3(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1           # TMP1 = a1 * b1
 	movaps 0x30(%arg1), \TMP3
 	AESENC    \TMP3, \XMM1              # Round 3
@@ -1252,7 +1252,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	AESENC	  \TMP3, \XMM2
 	AESENC	  \TMP3, \XMM3
 	AESENC	  \TMP3, \XMM4
-	movdqa	  HashKey_3_k(%arg2), \TMP5
+	movdqu	  HashKey_3_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2           # TMP2 = (a1+a0)*(b1+b0)
 	movaps 0x50(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1              # Round 5
@@ -1266,7 +1266,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM7, \TMP1
 	pshufd	  $78, \XMM7, \TMP2
 	pxor	  \XMM7, \TMP2
-	movdqa	  HashKey_2(%arg2), \TMP5
+	movdqu	  HashKey_2(%arg2), \TMP5
 
         # Multiply TMP5 * HashKey using karatsuba
 
@@ -1282,7 +1282,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	AESENC	  \TMP3, \XMM2
 	AESENC	  \TMP3, \XMM3
 	AESENC	  \TMP3, \XMM4
-	movdqa	  HashKey_2_k(%arg2), \TMP5
+	movdqu	  HashKey_2_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2           # TMP2 = (a1+a0)*(b1+b0)
 	movaps 0x80(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1             # Round 8
@@ -1300,7 +1300,7 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	movdqa	  \XMM8, \TMP1
 	pshufd	  $78, \XMM8, \TMP2
 	pxor	  \XMM8, \TMP2
-	movdqa	  HashKey(%arg2), \TMP5
+	movdqu	  HashKey(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1          # TMP1 = a1*b1
 	movaps 0x90(%arg1), \TMP3
 	AESENC	  \TMP3, \XMM1            # Round 9
@@ -1329,7 +1329,7 @@ aes_loop_par_dec_done\@:
 	AESENCLAST \TMP3, \XMM2
 	AESENCLAST \TMP3, \XMM3
 	AESENCLAST \TMP3, \XMM4
-	movdqa    HashKey_k(%arg2), \TMP5
+	movdqu    HashKey_k(%arg2), \TMP5
 	PCLMULQDQ 0x00, \TMP5, \TMP2          # TMP2 = (a1+a0)*(b1+b0)
 	movdqu	  (%arg4,%r11,1), \TMP3
 	pxor	  \TMP3, \XMM1                 # Ciphertext/Plaintext XOR EK
@@ -1405,10 +1405,10 @@ TMP7 XMM1 XMM2 XMM3 XMM4 XMMDst
 	movdqa	  \XMM1, \TMP6
 	pshufd	  $78, \XMM1, \TMP2
 	pxor	  \XMM1, \TMP2
-	movdqa	  HashKey_4(%arg2), \TMP5
+	movdqu	  HashKey_4(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP6       # TMP6 = a1*b1
 	PCLMULQDQ 0x00, \TMP5, \XMM1       # XMM1 = a0*b0
-	movdqa	  HashKey_4_k(%arg2), \TMP4
+	movdqu	  HashKey_4_k(%arg2), \TMP4
 	PCLMULQDQ 0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
 	movdqa	  \XMM1, \XMMDst
 	movdqa	  \TMP2, \XMM1              # result in TMP6, XMMDst, XMM1
@@ -1418,10 +1418,10 @@ TMP7 XMM1 XMM2 XMM3 XMM4 XMMDst
 	movdqa	  \XMM2, \TMP1
 	pshufd	  $78, \XMM2, \TMP2
 	pxor	  \XMM2, \TMP2
-	movdqa	  HashKey_3(%arg2), \TMP5
+	movdqu	  HashKey_3(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1       # TMP1 = a1*b1
 	PCLMULQDQ 0x00, \TMP5, \XMM2       # XMM2 = a0*b0
-	movdqa	  HashKey_3_k(%arg2), \TMP4
+	movdqu	  HashKey_3_k(%arg2), \TMP4
 	PCLMULQDQ 0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
 	pxor	  \TMP1, \TMP6
 	pxor	  \XMM2, \XMMDst
@@ -1433,10 +1433,10 @@ TMP7 XMM1 XMM2 XMM3 XMM4 XMMDst
 	movdqa	  \XMM3, \TMP1
 	pshufd	  $78, \XMM3, \TMP2
 	pxor	  \XMM3, \TMP2
-	movdqa	  HashKey_2(%arg2), \TMP5
+	movdqu	  HashKey_2(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1       # TMP1 = a1*b1
 	PCLMULQDQ 0x00, \TMP5, \XMM3       # XMM3 = a0*b0
-	movdqa	  HashKey_2_k(%arg2), \TMP4
+	movdqu	  HashKey_2_k(%arg2), \TMP4
 	PCLMULQDQ 0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
 	pxor	  \TMP1, \TMP6
 	pxor	  \XMM3, \XMMDst
@@ -1446,10 +1446,10 @@ TMP7 XMM1 XMM2 XMM3 XMM4 XMMDst
 	movdqa	  \XMM4, \TMP1
 	pshufd	  $78, \XMM4, \TMP2
 	pxor	  \XMM4, \TMP2
-	movdqa	  HashKey(%arg2), \TMP5
+	movdqu	  HashKey(%arg2), \TMP5
 	PCLMULQDQ 0x11, \TMP5, \TMP1	    # TMP1 = a1*b1
 	PCLMULQDQ 0x00, \TMP5, \XMM4       # XMM4 = a0*b0
-	movdqa	  HashKey_k(%arg2), \TMP4
+	movdqu	  HashKey_k(%arg2), \TMP4
 	PCLMULQDQ 0x00, \TMP4, \TMP2       # TMP2 = (a1+a0)*(b1+b0)
 	pxor	  \TMP1, \TMP6
 	pxor	  \XMM4, \XMMDst
-- 
2.17.1

