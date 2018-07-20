Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75F2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7005720671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NwA+CrzI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SMf9X2TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7005720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbeGTSgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48076 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388248AbeGTSgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:07 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhnse025347;
        Fri, 20 Jul 2018 10:46:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=PhR/xlbeiqF/vPQucmBmPxNrNch58rDdW7OXsqEZZVU=;
 b=NwA+CrzIhYxgnlKZNm1wp8RaPZbnww2cguEdm8EcsiPiZsm+j2ZOCcSnHXsvghi7LTis
 wwxlQhimOPFz9oiCigWzU91FFO9BeumgOqK5lbRvEMIA8uezrCnM73Tc0ei1VOEVzGvW
 sx+7G3yeNh2vcIBPjWDVogLnEKEN/YEvFfk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbjxmrbv6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:28 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhR/xlbeiqF/vPQucmBmPxNrNch58rDdW7OXsqEZZVU=;
 b=SMf9X2TQfjebi9Z+gyuQJIFg3quzfevhoR85XU8MFdprVi1yApp3kbYzWSmrDKvYBILAA7w0GW4k84DPukbtIRbAgRHYlRM03tSTmhdHlesp/iWK0Rt9osc9ss9MTPTTWJtC6xannAd8Z+Flz6n2FSo8r1q9xzmOrCFPLfcjo8o=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 10/14] bpftool: add support for CGROUP_STORAGE maps
Date:   Fri, 20 Jul 2018 10:45:54 -0700
Message-ID: <20180720174558.5829-11-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f012e30-86f1-4f86-581f-08d5ee68b6c8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:gAeBPivIQurXQan2kTG4/KD3KKTkZDVRmB5xC3jNUU7ankr9pOwyOLZSUGH7VU9WVXksLqKQDoez4OsxSiUiTiv180i6lrdn3boneoUXljtjAD7xfFVhC9Cr0qHVcaky702avxj9GLKF74J7vqzSXvafPVnO7/IM1Y/n+OUUg46Ura8UkgXNnb+cYRwVFunWiHhcWJfkS/cb9QeKXtUykvijQRTziX7gPxHM51jf9CHgY+SiI/zgzjGW4YU44UMY;25:UHOb137Pzp7UiHndRaIwsv9APCmG8Zz6WR9m/6gSJWlBiTWP50T/kuZ5voFIa68jKuSw71Ta0Q0QLrjfXCt3+K8izdJ3Ir657rsX2dXap2KLCPxt8XAA8CHWX8v+JzbWBTJ1UQztEHRp1Z12PaPyjLbaElA7EL6wRMFqwRHUD8vO1+heg61lmjRysrEdHB7z3nB4vtGK1si6l70tiRYUxl6sM44oSQwnJP+TCC4B9VyUhZXg76nuJb6MgqEX9mu9AFNAQ1bd7vKqKPX4FSbio8d61iz473HIDDSfjcESe1DKyWITok92q+/ixHQXHarHWqv4d1wjOG2op5WvbisFjA==;31:JH640/2WcNiM2CWhdBz9bOb5C6tIJe7ZJzQhVNHcS7o1bQjOOdEutbAUJSZoybCt0tDWGZRxx1mxgO+uErs7f95vG2vPn8Q8+vsFsL6yOZKod8KWxhc6l5Vr6a8KA0QpoBMKOaWi19c6uguZGWrjXN1rbFqIk9jq/mLUzkPfYskkOxPa/BzidKcStQXlGSca/D+qKFy/t5s+5pL+ujqrOsbLnYopaJNzMz1kMwJxHww=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:ZoLaYR/u6SptuDihvQ90rHylQYErdxWUFk17GLSX37806HsSwlftDxjqIiosXDlS91TvR2Ab0PUFtTLNQ/Dn1C95o2spDPf4+T8lZvXdbZ0YWPONgIP/t/BMnTPyLmszDe/5HsQWkQAVGIshlkHDHShakWYOStt6vlXyyytxfQIjLLdNXA0rMw28dbZtzz/YH655WaSh3LxvptUQ5co7cFRFAfO0RDKWmq2qC/3oJbvgOO1xZpi8Z3dHxi8eU5+UWNOyVHoczm8Q8jCmoBr+EaBLra1TySsSKGNX+VL3x+fT6qRQyVOcOtylJ/rGbDfYfQn84myg3YuXx4gwIk7UOLIPUUPD2gdXY3x8T7Isnhh21QLXS8rbMj97dUeVq54X/YcEcB7NFG3vJrfCsAsllQVed42cNQzbz2YFHy2DMJE/NEpgM8ldUCcPk6x0P7cnvPRggf+IOi8bnDvvxUReF6vxS4IfqieOZx38uRJMqm9zMJuH90MCLqksfi/vx5p0;4:LV670nOHDsFozo5n6O0mprQeyNr68vEJSxXEWiKfKbJMHOQ3X3RuPGODheMEzZwqI4Qh5uIqWlgH6DbxTTVQEfG9RgW1iwxwkBfeljutJT7rMdLpB5m75s7J+D7oOa0Y3+agWAoqfnEbjNGEY7NekgEpSCIbOLjS+XytebR53R/noLbbTJizIAFkRFQ21ao0d8hgdScZxfzOsmWuC/5GeOwaqa3VKl8pRzt+paaRsLEylXLvjYlun8Xuyuq8e0tMdRhCM8rWeglYBqDSbE1H7kpFBXkBcAl6D4CM5CYdMxSoVOlZrUB2MeAkhniXSNTa
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175D3850B98B693EA4F3866BE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:sSGEmCVjtmqtD4OjjeObQHdGjHe5pD1EYsXplQlHE?=
 =?us-ascii?Q?AoHsaNnDpn99FIkW2YsqFEGPzluo5pwIYX0x/C87SS9fIzi28ajhKsdiscnz?=
 =?us-ascii?Q?IFIRSyv7QNLQbunYB5BoTfz/i7u46CfBWC9XUWYfGYt5BmDI+ps9jcKXbkzA?=
 =?us-ascii?Q?4+bsXJ2+8or3RZzdTVGDDTBckGK7Dp8s2EIVGSxZzGBTq0F/OnM/6bZcN8uN?=
 =?us-ascii?Q?suiDzbsTiduE9a0cR7bsLIaODyU8nKt/cXkEtOUsXHr2OoPsrVwaUkTKMyTs?=
 =?us-ascii?Q?G2tqJbLL5cNSiQnIqmbKWYDXAL0AgcVg8/DXpaZA5ccSd3WaCZwHcYmnM1db?=
 =?us-ascii?Q?5kG3gCx83oCap6wGtQJ08QKyc3Yab/jQkTiR5nmqcmw+RnZcw/nVaAEXVfRF?=
 =?us-ascii?Q?5nWlfNEjctduhBHVNx8p2WBr/eG+BK0olIdJNjkNektLYWzFHQkOevKVn0OF?=
 =?us-ascii?Q?elteQ83fGzRwI6B1eMoIU/4p+1AN7UMei4WnpDPKBXXgM36Me0LePKhxzexh?=
 =?us-ascii?Q?B6WR0Py0yTBHeobAB2lcD6ltgoptt1/T9XeFbAKDqHePploXJ11WXXiMh29S?=
 =?us-ascii?Q?xmAuwBT120/PnjT69VW5855t1ErylSsOR1F/aFezctabK+8MbsejT9cI2lin?=
 =?us-ascii?Q?2WRGcx1CK+8R+QJe4UnSlesOX5C1C5JOd/R6f4Xrd8ME1g4fs5Akx4dv/i3z?=
 =?us-ascii?Q?uH4FIYsfiuaKd7VHP7RSjPFU6HWbjYn/2lvPbSmoGMYDIguUz/EdVVh9WZt/?=
 =?us-ascii?Q?HmwaWHXjoTNsOBZMnwA2iQUP4wQjUC3+zVs+k/Bo5t4RpJ0EGvLSM5SOn+sE?=
 =?us-ascii?Q?+W4GWAx86S+OE2hCPwEd62ocr+sZTBR9fnCZpPFRy2v1H98BPLK68HySgM+f?=
 =?us-ascii?Q?c4VGxxzNG0uYz2jQrti/8QJ5GNgfCxs9PqhM8jWM7n9+liHO0Zv6c0UA8rH0?=
 =?us-ascii?Q?9wQ1s9U1gY9UqYxO0tBCRLKXzlHOdatPRO5myy/C1YsptzicbyXFGBlgvOol?=
 =?us-ascii?Q?4PZh1+9wWz6X8U+1DWhbG0Mxn2vNMmW6LBLUy+JKK3AODCSDPndaEvNqoIgZ?=
 =?us-ascii?Q?OGhJ0XSergOvmb/m0DqssASDg1O3vPLzk5vME1ZFamRRgs0SscH4aiezAsAK?=
 =?us-ascii?Q?d6ZNvruHrXmo20yVfpx88IMFEr2G/syUaURUw8EbYhqIv8fkcxXnfliqpxzA?=
 =?us-ascii?Q?17FmcRfl7KtZpv2rI59HjP5/9GXue+dyww4QBdUfPum0bzhhflCEC9dANBNK?=
 =?us-ascii?Q?gRYPc9pht5mBA8nxwHgw8wW4MxT9bNenV/4KdAg/9worTk7cPZNBiGUII+XB?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: nlbB5cJA0F5RxcD1mtjeWuTFOaYDFdQJ7cDwD48XSmoQZwlPUdcY2dYrqIM7kyqUk1MpTgC2nsxVUa+z80jIQTumwQqcOfVyA2I8m/GbNb6igB6S7WE/les3mR/NdXiijXT035qKoCwD2Tv/qZDL2eF8hQLmBWvWa5o6V+at6VKob5ybl9yr7BHkA/KR0v4V0yau2vb3ULf0g0eiqOFOQ5uegML1ULmMhc+2sobu/ETaxlLRhHXQT9bWdoPTPc5mpCzsLhIXHdhyvcy37UOJ2eLoCvs1P/eC+YzdACQfi58nAVocQsv4uX7HkKlHSe3fNAjEkJN1Q2HubjWr1rIy1vUVrOvPiu/G5KpzXziWbDQ=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:txz2H8LtEUdX+nYQOebQNYeWK7TWUaYz8Y3VXgEEey6G6y3Sw8znEc2vnuRoAkIFno8pTGz+fj+0ajGv4hqF1cDJgzTWbisJgWDoree0o0cnLGhURuOzZm8uGpRucuqJ8+tbIArfaG3lDLGjmV8TFwaITP770Xuk7Cz4uOAd3hh/IQIh05uq7JkwDSYA+lwOdAby4CeXD5KMo+Bf1FDv6dBZN/bDsfULZMJSRAJLhqJXFwOSlUe0xN0+jirXgn5xjm1P+2JeLTXl/p6qzLilE9SRhmeMFtLgsadr0PqZdaLPiupy4O2Wx71dmcZZDb6H3avL89dj4OAmwkUuCzDWgL94M34CZqshTuqKEUas/ehFYOVqSM+/47j959FMgT44wbzsBJg4xeAKKDSluDsq5aCu7JidB3rPxNwVXz5cbYlWULCjqmdwzR2th3UQ3aF3Cf4vxNPGNJ/Yd2w1EptpiQ==;5:778r8BxZ1ShkUBQApG4Yc1m++SzTz5tTgB+hkV5yyxxgwkqQTmJzCxd+65PDDU8yYcQanyR+unenx+S1XDAXquw3pf1Wr8QwVyu5FtzmSyNuz/hEWy6OAxqyauBhT29GZfT27suQjZzP5AmJ/Xw7dksfSEaeZCBYTm9S37ZBD1w=;7:ncKPDcE4YSpO83zWuAvQv710/6tlCsjSnC3kShoelbgATUcUgd8mfwHLM90Y7ARBZ9G8I67QgiUPU9sOR/7VELuDF/VCWRpbHAt8+ImcEfZm5WSo1WxUDrlxFZajV9EU9ov81TPLTW5mNAquS/MXCcKqaouYHlHNuAfmW8pK9md5jpWWOw4sG7AQHpl0noFdTgeuaXstSsODL3kaqzQTcY7V4T+2YfHtQ0/lQ6cqQAoO4CbUFvUxRRMLp8a38Vq1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:ebRBxLk3nw+XzcEyPFnce9BABR3pwSWCuxwtnw235rq1E2JeCCjIZaERQhb+Tfqh/uT7K+I288G/0D5ytDOnDJ766wVpb4To4/cVNNuHZfJGbPb6Yeh/J9JDj7Ul5HuHIBe/F824JVGI0m8gnV7ofsYCMfK4likfAmHZkYbseqw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:24.6350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f012e30-86f1-4f86-581f-08d5ee68b6c8
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

Add BPF_MAP_TYPE_CGROUP_STORAGE maps to the list
of maps types which bpftool recognizes.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/bpf/bpftool/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 9c8191845585..2ff02d319c02 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -68,6 +68,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_SOCKMAP]		= "sockmap",
 	[BPF_MAP_TYPE_CPUMAP]		= "cpumap",
 	[BPF_MAP_TYPE_SOCKHASH]		= "sockhash",
+	[BPF_MAP_TYPE_CGROUP_STORAGE]	= "cgroup_storage",
 };
 
 static bool map_is_per_cpu(__u32 type)
-- 
2.14.4

