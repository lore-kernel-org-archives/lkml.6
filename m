Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ABBECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A8520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hld2X+/l";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Fl2jgM1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A8520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbeGTSh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:37:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38678 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387909AbeGTShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:37:25 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhhGp025819;
        Fri, 20 Jul 2018 10:47:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=hld2X+/lZhcaEY0eziXFNdkbYgy8J8sQbaKFiUFQSJAG3zTHNFTkCDdM/kE6ZebOe/cK
 3pdCcHOElMHWZA0yG87i8FUiWq72bWoacc9sT8Cz9rGOEGnsSliep1QRHy/rn3Mpsfp3
 sKu9LUZ4BlXKwHGLn4pocOBQS0lxGQYzFOY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80h7-13
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:47:45 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 10:46:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccUkIiuy+r9fHc6FqtW+NV/batrBqZJEIjW+tLZ/ydU=;
 b=Fl2jgM1fOo1n4o+mAVuAVL0hXUjiq2PBGweVzYZPDfAPoPHdduPxzKkVO9e8V1dT4n0okY+W7tasQ9mUw4m5Po3pO8z11QIKzpocQhtIGjBEPlIcqQ5gs+zhybFdNbcgCwQ1X2WolNB0Y+Yh7vAGKyZjwc2gKA9Wf7oCh9Zgl+Y=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:29 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 14/14] samples/bpf: extend test_cgrp2_attach2 test to use cgroup storage
Date:   Fri, 20 Jul 2018 10:45:58 -0700
Message-ID: <20180720174558.5829-15-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720174558.5829-1-guro@fb.com>
References: <20180720174558.5829-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70bdb759-4661-441f-6127-08d5ee68b979
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:xNinmYrK2y7ykH4Q2fnVdltJHABSVMDCj6+O7ot1SXmxqOu9C7AcYwH3GqcuilXO2IZRLhWuZffRTTknC0gJq0n6IB/oKOYzwqelV/nhSsU4IQBfZuU7flhVCOguxWsbwxysV2DCMfgM6p96w3yw4dLzfo/1cnW14Dxa6ys22HtqjX/x66zZhFI1Kf5KwwrJRziS3SaSrM5VJG8N+sTcNb3/+w5yTvaViWGmuIPll7r0ah4fvdkAVC9jTTTlLjYH;25:D2B26821b1RTXXNoUynNRG1sSvp28l7mNlZI7p/IYvYJN9tf66cRm7AAi5vWW1ewd9fZ4wHvQS1pDfUwLVzWK3g/+cGcuLK2hVvnJoOQiDkt4vLN3oy0o8W+s6nfgRAvps/pDEuJ5l2CY/2d2RFq+vRz8LpmX1QYUVZN4cBhiLNST2fhMmTDl/9VGys9SujUpUw9kx4j5w3GfdHEd38lw2gBp/K9On3xcoeqyIbtO9DZEQjSsElHcixtmIWYkDmgZHcP2NdYOvH6zhkr7cBYLkvKnBcp33/TwrHqU/s3B114y+HKvbz6kh1hBltoOPFojsHJZ9zbDx5TGSZOgcbu8A==;31:aoRY396QrTd35c6uqkteDjMW024yeAq08NzUs6afrGnF7yxgI1XCv7O7lvJ9hQHfLBTUarHpQnnSrLNSOJH8uzY7fyqY5RKOGdlFmGKk1HY5oKEjwv0Cf1jBufFq+vY6ODGqk7A330Nr0p7S3S19E4vji6lLCx9R2FMoggafwybTouV8zDs00sWNdnxRkHWwXAFwWSbxNsy7ErpWmTQHf8yyE1XNi8D0fTxHWBQtw/E=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:HvUXws7dCx8iTzPw7Hd6AwtBS8yM++ALIv2Cc4jabCzrBJcQXWp0wxGZB6x1hyj/gD2jOIsBgQ5weN70CKMaYxcuRVYqcGeGzYFM/JT+eg6mYQUUiJDi8yQmDynMllCFwLFqyaSnhTr0ORvQwcYsECvJQeFDZK1BZ86yd10W0JUbOiolGyFhO9+o/9UPu1GTog7GM+kif1rYanKTu54oa6XM5NQBfET/mqEenwQ0hIEUbFW347lQtoj7qNuN/Uv+vBa9e0JGem5etaq6hvD8AujFtbNCwHmPhCUn/y3p0o18r+hxoVNc5r1hllgQDjKy9qYyWFQGwDhKjosEsgtSFDIOw0R+dPDIqd45W4sBKcarJSox15iMiFSZQnJFBh2v2QeQ6Sge79NGGaicqX1la5HsPZolGIRD5UQ9VbeddlGmXByS8xWIJnn5piHtskfyKUCp5mr5k51mzg41sHJq+nvVTtGKhR6LWfoNyKEqfDjTB+rJujzXBDYs/8BCefA0;4:Njp2q6BJI56fy9HvysowwB1UTJYRpNaeqyN7bZpWboAlGFBShW3CsS28nQ62tEmJfBGwAaNOXWbbbpqZIk+I2OFiMuH5QnMywWyQwc1tofFBF1n9LR7QwCU4NbcRTw7vqe5WBH2LJYB8hIRYheliDyaxnoPKrUsx3DaF2Q9wLT3Lkp5Ydt1coFsK50QMiUQLkCQqeAFxSVGX335EFHH9kLUB61jUp6419dmQJX8i1kZRQ5AAfMrRNcGd/CED7IevugpJzKSVqmdr/uZIk+GlX9psyCoQMHWnoLA9T8G0RrmgHw9akRsiZyGk69mhr9DH
X-Microsoft-Antispam-PRVS: <SN1PR15MB017578A8C7CA90FF5498E47DBE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(5024004)(476003)(486006)(15760500003)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:bSaCToy3SPw1R5FALm/BFzU+JMkK03rjkn+iHXaVB?=
 =?us-ascii?Q?QYafoPdbghGerVS3l3eNhU7vgubC9vcQ/2Lm1M+YoJNM4eSHfy4/fgoYYqzt?=
 =?us-ascii?Q?PrcHzjAQv/I5pz2ltjOBumFwDco6E8fZL8AMHBcGvQqSbIZm9nQ1Ih/2dcSP?=
 =?us-ascii?Q?rrSUS8duLlWdzEDpE/VygItv2CTJoRiJ+R+BMHpK+RsWdEEcq0E1N4uqCX39?=
 =?us-ascii?Q?yT/1+XOdTsWdhpVqbAnGSeCXnKp94DA9Ngb6lsThr799ng0ufa1BQb6y/FyD?=
 =?us-ascii?Q?airJQAKYw/1moOiO3KumIvnSKxKN2em2shx5jmjfwAHj0xzlhEzgip78auMG?=
 =?us-ascii?Q?Oed0ZuS8D5ee4RjZKZmjbhbtMlArqlB8BHOp/iWfn7fRKeGwQgqa46tTdC4c?=
 =?us-ascii?Q?CisWBmsJ1uO93lYSV5Gj1MreO3Avpj379dKbHDXrcKSwLhp+fGDj1BWAgOYt?=
 =?us-ascii?Q?KdnZ3sjNiQMe+f/YOWl/WR7h2bqMBdlpl8tUngBVCQmTL1lhVHWkmyz/Zfox?=
 =?us-ascii?Q?lJCW5tlJv+TsdQIPoRHDeISbXZTwrAlncTcyH2Q2TSUxexR49bMO66lQkPIf?=
 =?us-ascii?Q?Q4HIexWtkzGfiAHbTKB4JYc+YmYm+T2Z4NeHz0P8ES4v385z3ngXnN4QQQJn?=
 =?us-ascii?Q?yRtvFXN6lQMJ5y7b4BzzQRky3dvvAEIgZfitgLDDBWg0yFY/OjOBo07QLF64?=
 =?us-ascii?Q?pVvUoTwDpt7TJVVWWqpFsHJ/sNGPTScv4iGeA0QSRT2MAhXwpS7OjGG9Rv6H?=
 =?us-ascii?Q?RVHrWXEjJxEdk3AtC27ZOkwPp7H2KSvKPnJXzH/Y0ozU7YxRmQ239BCPhslN?=
 =?us-ascii?Q?GJ2qgq08MUPnAB+6/er/SeKb6sRv8KcI3oNLaKZYBs7T5ZSyhs6cX/iPleT6?=
 =?us-ascii?Q?/kM9qte3ebeUCYT87AjbdEt/YYxy+YqAn0mmWHiMQuP42FEjndR/H9woFVja?=
 =?us-ascii?Q?a0IbuRQofwRfENvDfVzdF5HA/sakUvzdV4yDbvxjSqB3/9mLd6muxCnjtP+X?=
 =?us-ascii?Q?ox/TG+TTLLkvlUmxKjGtN5pt+kwQtWytkE8da9/lipyEQsnZ9YQJYE/wGLF9?=
 =?us-ascii?Q?ItbkkrQMio0DGdkcBJjEQqoBx8uLr2qZry+FcgcTTouM/znXHJQUd7tYr/5F?=
 =?us-ascii?Q?EmnpGi3tf14KJjnmdpgBvH4Ob6uWrX3PgvquqvqKvosl+ffBhnfrO5Os1KwG?=
 =?us-ascii?Q?+YPwXkrZnhQ2e5TeiNk2dOoZ7OivEB/pR+G/FNyItsiuUhVcWEIIeMN4cWWD?=
 =?us-ascii?Q?WBAKy+Eehb8ns5OLLA8DLS3CkPTmdZ+P9qAnqZpszLWx1FYnAzxPIrecjcKX?=
 =?us-ascii?Q?pnOyNEIEguDBc88dCcUGkmh4dGlbr5WQDZSYbgDrS4MBnnUp/KCfqspYXKa5?=
 =?us-ascii?Q?ppdTw=3D=3D?=
X-Microsoft-Antispam-Message-Info: eovqUWbsw0bXH2D3erasXH6fLELiCXfX60nG3F1jobTe9MQ2j2O2nOF7DYLkyRr+2f8xKoBh+UbszY09OUzkIV0DHJUCRGqJwq/MTPNauXeUN00vd2Dr1ZsDQqiI8KJ6sdiJ+6wbe1hYY+hh/xQMu/Ytfrxf7HsdVc7Jwrp2oNVAmbPnQPxmiQS45QG6Z7uTk5Q91uDvFEeOQUyLg442t0o6ukpnlM37LhFQAxRjnPZaj6nD/Ioge1aBmw9z50acrQ00vpUpQwYK9Eu2BT1rPIzNX/Zin3kh3RkO5ZD8VLvAlm5XRLAjr6XBkwMlfte/khk/0h2oVq/BQNi2tRikZITz5KVXeMf+ymZe37FXqn8=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:7Bl+66DSARY4FbJgb41Otbiw0Fzs5GP3sFWcj5bhSuNYNZmifCZEFQQChvw8vZbwSqV5awWEYXq2wnL/9Ui+ZaNGr67F84qBTwuouc3miSPFKCSyoRxUw0oqJH9Jhasz31eJmdt2btw6fpF4Y5DPFPkbMmdWatZ75PnsQm4zSXhiVEPr6SAyJ3B/5oamYUsq/OjHXNekOn+TXmYJp7x2vHD6bi2J5r8ETShBmgbt5rCq9jbzyY+x1jovAlzJfpiMC7a2wu5gGHFo9JiB42UHIsYTdyQd9723NCTzMsBOYT3ne+CRCeyUE9ckgIF3C8EaLI0NiIENuBO6ZAx/42MnwD+TeXXgxrA1FnfKOVZsSAMghtwpZpP23yhWoLLW3OfuJ7yUdhrWCHBQz8s2FajRs1e9KIRp03OFxQROk1yNz/gT7W3wfTVd0kUCNn6Akx+vbjVVTqchjHxU9bNPn0l8MA==;5:LBPVENViqSRZmjRHdRlnPB9X/wezIge+dkDjEflsRVgc9jiOD/QwpDxFx0VUPDjV5Yq3BdvA0hNeu+VljKtwWY+EDkgyC1Lb9ivy8+WeCUjzwVGvzVocPiWyuYdy9gYuyXbsgmWwK7PU/jVtGnbE0nsnx3CBTVcd/zFWlvnjp44=;7:3wl16ttWH7Vsjq6OuQP8erFYAZ12Qnd4ji73GzrkLBN/gQrXqHk3rg+xYHS6cyH84RlsB2Vm3IiId+eexxp05f8nRZVaNBSwvV7J3UGzr35DkDPCP8S9dK7F9tBNETJICHecxSZgZguyRQW7KamE084swcz0D3kJg0R+4P7VyQUHpOwY6CusAb7ysTmWBOoCwWebKyif4ai1eG455QxavG2wLDbvPhgWMCzLxhoL7WIM9aIaplUzqutEtPaWMgee
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:7DT45pDZSepf4NZVxhvzYuJf+hz7ppb06rEUFL2hp78d/lhO2JPC4WSu294UUY9+fGPPRh7xuY/r64vZj+TiQUP1/NSEEa1WdogmSAlPBQQwLhSp+JFyyMMuH2crr8DUHpZK14sCVPaOja2DQ6cImvcfHayrupr33gtTurw56+o=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:29.1506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bdb759-4661-441f-6127-08d5ee68b979
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_cgrp2_attach test covers bpf cgroup attachment code well,
so let's re-use it for testing allocation/releasing of cgroup storage.

The extension is pretty straightforward: the bpf program will use
the cgroup storage to save the number of transmitted bytes.

Expected output:
  $ ./test_cgrp2_attach2
  Attached DROP prog. This ping in cgroup /foo should fail...
  ping: sendmsg: Operation not permitted
  Attached DROP prog. This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS prog. This ping in cgroup /foo/bar should pass...
  Detached PASS from /foo/bar while DROP is attached to /foo.
  This ping in cgroup /foo/bar should fail...
  ping: sendmsg: Operation not permitted
  Attached PASS from /foo/bar and detached DROP from /foo.
  This ping in cgroup /foo/bar should pass...
  ### override:PASS
  ### multi:PASS

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 samples/bpf/test_cgrp2_attach2.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_attach2.c b/samples/bpf/test_cgrp2_attach2.c
index b453e6a161be..180f9d813bca 100644
--- a/samples/bpf/test_cgrp2_attach2.c
+++ b/samples/bpf/test_cgrp2_attach2.c
@@ -8,7 +8,8 @@
  *   information. The number of invocations of the program, which maps
  *   to the number of packets received, is stored to key 0. Key 1 is
  *   incremented on each iteration by the number of bytes stored in
- *   the skb.
+ *   the skb. The program also stores the number of received bytes
+ *   in the cgroup storage.
  *
  * - Attaches the new program to a cgroup using BPF_PROG_ATTACH
  *
@@ -21,12 +22,15 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <assert.h>
+#include <sys/resource.h>
+#include <sys/time.h>
 #include <unistd.h>
 
 #include <linux/bpf.h>
 #include <bpf/bpf.h>
 
 #include "bpf_insn.h"
+#include "bpf_rlimit.h"
 #include "cgroup_helpers.h"
 
 #define FOO		"/foo"
@@ -205,6 +209,8 @@ static int map_fd = -1;
 
 static int prog_load_cnt(int verdict, int val)
 {
+	int cgroup_storage_fd;
+
 	if (map_fd < 0)
 		map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
 	if (map_fd < 0) {
@@ -212,6 +218,13 @@ static int prog_load_cnt(int verdict, int val)
 		return -1;
 	}
 
+	cgroup_storage_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
+				sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	if (cgroup_storage_fd < 0) {
+		printf("failed to create map '%s'\n", strerror(errno));
+		return -1;
+	}
+
 	struct bpf_insn prog[] = {
 		BPF_MOV32_IMM(BPF_REG_0, 0),
 		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
@@ -222,6 +235,11 @@ static int prog_load_cnt(int verdict, int val)
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
 		BPF_MOV64_IMM(BPF_REG_1, val), /* r1 = 1 */
 		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_DW, BPF_REG_0, BPF_REG_1, 0, 0), /* xadd r0 += r1 */
+		BPF_LD_MAP_FD(BPF_REG_1, cgroup_storage_fd),
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_local_storage),
+		BPF_MOV64_IMM(BPF_REG_1, val),
+		BPF_RAW_INSN(BPF_STX | BPF_XADD | BPF_W, BPF_REG_0, BPF_REG_1, 0, 0),
 		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
 		BPF_EXIT_INSN(),
 	};
@@ -237,6 +255,7 @@ static int prog_load_cnt(int verdict, int val)
 		printf("Output from verifier:\n%s\n-------\n", bpf_log_buf);
 		return 0;
 	}
+	close(cgroup_storage_fd);
 	return ret;
 }
 
-- 
2.14.4

