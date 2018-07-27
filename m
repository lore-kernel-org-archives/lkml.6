Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D7FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070AA20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dsT4zYwh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ho7E7qsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070AA20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390147AbeG0XSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:18:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389984AbeG0XRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:24 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLjQuO006591;
        Fri, 27 Jul 2018 14:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=AihxwsOgJ3vHojbSRmgjGnGTD4N/Uvho4GSdi2xdFoM=;
 b=dsT4zYwhnL24/3gELxIyoHHn6GOrbsuItzOYCWoTuyd26UZXYX6Wt1d1R6YYmHfMim9+
 WCzWNK+wRfsV27dhbvSdRMERcJad5WJAj3fVkqEgGjlXSxRkOFDPX65rXuS9/RAZRD/7
 Nya0JpU7xB0yOgVZrE2HeS04XXBcy67Ker0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb58r2md-6
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:17 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AihxwsOgJ3vHojbSRmgjGnGTD4N/Uvho4GSdi2xdFoM=;
 b=ho7E7qsgHJ5pO5PGIGh3r1r5Eeq1kgeIF6IAOq97qW+OiT4SX2UoTzLnOi1quOKWixcKZTB7Fwts7xDad0gzYioCavR3C7rvnP0saWpwvVSHfxpLS58ZQEHD7JsR2x5VCn0tBEep+eBRnb7rwTgZfPw31Osoz4vcd4+u7mCk2L8=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:04 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 06/14] bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
Date:   Fri, 27 Jul 2018 14:52:35 -0700
Message-ID: <20180727215243.3850-7-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180727215243.3850-1-guro@fb.com>
References: <20180727215243.3850-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:fd07]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6088746a-b6a5-4568-4791-08d5f40b5524
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:IL2Ne0sUP03Fow+SQ1ybygUbEy4RICGIT3B9FayqHArq5nTMXjIpykMBqGd9jPW0mqGZF4bj/YgvaESd42SjSKiQcbGrAn3So3Iw3ENjJhEAbmbnSvAM1Umgni9IxRQSbsJ7W579a8CDSDPjq6uoo4X5Drgx9PlHPe4I72M/BMqIE+Kq/eGAahXOK3wVnl+LaII9p22xYtykkYLercumDcQVya82zrysV1y5CP0KpADPJ/P/ypTiDjW/tWoIDVuu;25:E7KZ4mjbJwUhW+Af+a1qwN1ctr2t7JCp3f6HnwI3JZLfLgTjAU9GgCADC9C2P+xAP40Vf8Ci4f2RMSuSoqzxgNvAPZnXffcxfP1HFxOXBz+zwK4HAmgeHCSCFA0bc8DA/J1tsE2TJqLLp9hgdgiYamGKVrbWXr34g1GDUgUQXCC+cXSZoZNiCLzDJjJK8OZtgH6ZxHImg+0fhT/31uObO8JAsfrnRLsQULNKuwvuYmK6jNPjVDeYeZjrkxuvOBdGAOCSsvyaEGd/baYe5M3EZdL4Qj1oyAedevudLduH9H4g+ye/X6hXHOMA974vbfLxHsNvLMF6u5hklhydtPVMOg==;31:fOSBCodxz2VxYu4c+OLrmk7LFhBZTusb5Iclmc4hb3dq6R+5T693caM0OpxMjyLn00cXJoECphY4NQCmoyrS7vjOzeQnlf5Lp+h9YRMBOmV75zn8yFsEMtZYKg4K1mcsAV9gHRQQsbvAIzDBoFplk06qz3KhXgSJ9tHZVbyi3i2ijyIyfZoKWYYTqk6X4lJS1qYNgdXvE/mWCORP25odGGcDtjmW75s/rKQ1FLor+EQ=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:ets/m7ABnixd4cjwUDD+QcYFu+0VMQHKYzkJ7a5xrKK8uxhvbzj6jVW3UwuLe5sNjDP6mRRuHW32zuPRX9mCSHvpTI752yubMtFR67YFS8VDyZcUexQLsfCkXQo3McMCSZYmFDMnrLqHR/EOT4sdGnhc+GLS98A++bv8j5e2rxM6ETAkH/G8gYSt6vjdPb0RWRiaWkWvLbxDQv7cvqgKmq1z6ANA5POV0DVilEm4FAFne2MPl2WjAHeJ0wRQyu0q+hdkGVXW1SFHOd+0tGQoWt/tt6L/fXcsKaTsbPn+p/g1CU+Hk5JAp0oc3iR+jmkcWd149vrBxOEdT73l8gwIKznhbeL8D71si5OaI6Ak2svitSeZT0r/D+WVMhOmiCzs9k5xk5rGYURhTGlZhv045dOrKQbGVdW+YHRMO9/XG6OmqP3vdFVyZ3tv8udlWxqBe4YVxDmrkMHFAWz7qck+wTHvtERIcSxbRoKFnCgqrshMmFUJH0ljxdZ7NYfonWVE;4:kOFulyUVaDhmQk2ny2CQZqDuRFdz4bG4KAIV516naxgObcpIbiQM/VAeNxxE3r0Iprd07KPmVoF0gOxYPuvgsHHqUVEyIf7xrA2MJBF4zfSQhvJcNRoeBek1AcQaN+x+pXEsIwrcwqP3PXMJHN/hcBYdFiaWJ/cj35v9y/NSyG2/ryqYaBJQaDW1x4wlXL7z7AXkGsyTM4Q2XnfivC8G4LROVv0wWwUX5UR8T156InkG7WcVJsUkng7Y/GJNrUPY+VeL2wnRmvXEUMfm6jNPALkIIS5RH4IyoVHjLTkTv/8tN3N1kjh62fiPyNj7+geo
X-Microsoft-Antispam-PRVS: <CY1PR15MB01713EDE90BBCCA1869F8599BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:xcTPxsSGSU4Orlrqr1VxA3+kEJQyE0l+CX6ZnmrS/?=
 =?us-ascii?Q?weIQ0b87S4xN0YGObIEzXWp+4bKlMR1g/3/eUQIw7qk2DNro3W2ax5cV3s6r?=
 =?us-ascii?Q?DXAv/ru+pmfH4G2ubBYenILPogOJ34mcGQdeKOGg56bdQ1b1Z5Yw4rQ1lxeF?=
 =?us-ascii?Q?NNUybT2aYhAeVLxG/KnI8MoQW4IUq8KMtVkb45B3GLsqoia2VNhPbwZne7GS?=
 =?us-ascii?Q?XfxktfM8yxkxBXBl8wDTmli3JH54oF+Q8F46f9HUW/JAPRj1Ql0CnqbDnnDT?=
 =?us-ascii?Q?zAwTF8GihCrTxsMOxs13mcEHWYGkxLPICujtkw9MnsdwYPMO8krBIKrpEb97?=
 =?us-ascii?Q?8AlXt5Wt18qJg2ucf6cDWniKlJPNI03SwILgCgPT1ym7AY6wlV0WBE4ShyCe?=
 =?us-ascii?Q?HHRyllm6wiJYORPF29YtC1Vc+KgFPbTo9qw/CIdcHAgyz/qy7+HsM08HtiT5?=
 =?us-ascii?Q?hwDgkW2JGDj/cvee6BJ4ohYr433X3gVJoYFjnDBzex26jUZcXVnVLpl0qMQQ?=
 =?us-ascii?Q?rKr/JsDnNiOfijE2VZGufYFHOQUAThX/JJqi1GUV91pYVgrLlubT30XaP1qy?=
 =?us-ascii?Q?2UhuX0tfmprPU463wzqbSbs7P+019UW+VVl6h27Cq48ECAP48nbY9CBhqaBf?=
 =?us-ascii?Q?r80sYqD7DWtubxqIlPuyNR3QjkNZ0fDuMTdqAPN/vX+jM34PEIc113d0tr6E?=
 =?us-ascii?Q?/vYfwMMl/yRo8ySSnHTFqKS4fOJuOEEYwoOpQ4mATPm4/xwU3rR6FX+XlVn9?=
 =?us-ascii?Q?WRzkiIQLXFgdmxROJC8MYJgw9gY2KUHkjPm4rpHxUGDrj3WhQJZ0wqb3E0Hm?=
 =?us-ascii?Q?b3fTEkmkx4vvH1LsG9eRiWDENVKs2heK/E3xUD5sorhzDHfgK2QugNvYc9+N?=
 =?us-ascii?Q?f/An1aWgJClJI6jsjB3oBZndJVzw6s7csMDD1Oc4qwVx7gVt8GRgfGqa/yDP?=
 =?us-ascii?Q?wzA7vDEL4s5ODgacNn1wzqKydWfUz4qiJd98hsCzPC+Gp9iDzIoUWPspAMjK?=
 =?us-ascii?Q?mmZXUR98sqYeIUiOa6hteGYFbFRp3zKkjvEEKCZ92YS5ljaxX3oMthELV8ef?=
 =?us-ascii?Q?V9Pll43I+Ydrb8iAc90jEPcSVA0MZBV3k62enL7Cwtrw0zHeTdXIwOXhFK36?=
 =?us-ascii?Q?J4xJc/s/XR59elDFuouFdDTCvhFX8nU5VWQaUDZHjP3C9Xw4nHqfZDE1fWTT?=
 =?us-ascii?Q?NEiLJ/oB5YCn25AL4QU+BDM9ldC7PLU4KsKORov200zddA71hmBtkqqtVcsj?=
 =?us-ascii?Q?PooBT+ObE3A/t3JQK2yMnr4HGGDYDYI4wsN2YfzqOH4onyQQxHCqCWHa7JIt?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: 6HiG+DX731LB5AmbGOxo07H9N/YcsFwqwfIz+lut04fi5ph0G2PwPaUMUI3CE06vBgGwKO1DOl2QuJpvsHVzw0Jaung6SXmgJx/GLe6vuGY/EZ2c3pWM7ZbHdQX3NuEwbXA8c2J5Pgskf0luJ1c21+FhXblbrtqmSvsp0dRX+CqeaapQTWukOcfe5czD3sMS+5BaH9YUutufmDFYlGEExP/lhHY8n9dRusCJmK6oLCxGIilrFbJgtsMTBrxlTAdRKTQoHYL3tojPH8oSJQkQO+V6qa7ISfS11ZJtXDE7aCVyO7PM2ypZyEMvBkng5cFqF99/YuJ/AMN5J00DL1iu+1tXFYDOvtESwvAIa5sqGUY=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:GAEVIbMMGwIRrnkxal0uQ1KID/rKKd38vPEHkgg21AJormsd4mdfcaUv9/14mbmyjyctM2d61yCifuEb6456MQMk5n4Aop0T742wc7QHcVzq2Yti5QlG2fyp1hLxIb5xrf8B+oJTsTqCTOf8tl+fsC3i80OqtzQCDC9JTcrPSM0rdYxpw3drPnyiM7PQ1Ab4c363G3MJeVR593hyedPZ906nubhk15WbCLuEOTbp0sNuz4QBPqCmMqrBSR1W2qElKHsoG93/5IU9Rthx9OpKAZwH6g+42xAQgDxrLiEtOcq/iQt7UQq4J9dHoBjMDN3QQqfkCcXT9XXKkkQS7EWfiJfsTJLGBfv3D3K1RnffCMbsYBUNSGeFpDvrp5T2knbHFpycGJReztirBoakHFlkLhwiZOkszmWHEK8J5X2X0MIML8NpWHD3z7q2MPP0flTN8MWD0H4mkc/HmNoRAg4UZQ==;5:orxjJD7+8k+iQLAe4god9D2mX8+gqffx9GueZoCWiY/FOOqmj7zp5QQpgGh5nmeJoveA4so/Y7qV50b+PFYj05l8GxZtDCOvvmPB4SSvGkxpnbg5npTjDxFmZxiFMXm0nWcmTRmpJsdjUsJS9a1RywlKyz0uuYWp/QXmcrkJ3s0=;7:K462hJIzRNvzij0zteFx9E38eoobcFVmmp0z6ZJoGGr1OfdVlf4hLHpky01mxlCMxzs4xzyRhfTA3oAzHxzvcpCo7T+eDSNg0UC/PBicY0IajLNT/bqQ0rXtTn+PQqsYfEuZLApig6jxf0sodRbJj38Tf05bGqyabup/yXVS27XsCiYXartAA7qJLVFiCEzdv10Tu/cFoxLwun6odSEfNEP0PHHm5Nig7yqjj9GzPaUQSAlASzmlgY8RH4MZb9vR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:ejG4z/VG6zN27TcCeWBkeb//RIwQ+4tERBaMRKFnaXIpG227sn6VxkNpd9eIE3y6TNs6VCMESvSeErg0oFA+LFEfrUDWtIJ6Iq2G/tbihLpIYMXRVpsQtw//4D4GXLZixykd0051BVlj8qoqb2MbPOIcLjy04xwsYUiSqIhUNps=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:04.8578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6088746a-b6a5-4568-4791-08d5f40b5524
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF_MAP_TYPE_CGROUP_STORAGE maps are special in a way
that the access from the bpf program side is lookup-free.
That means the result is guaranteed to be a valid
pointer to the cgroup storage; no NULL-check is required.

This patch introduces BPF_PTR_TO_MAP_VALUE return type,
which is required to cause the verifier accept programs,
which are not checking the map value pointer for being NULL.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 16be67888c30..ca4ac2a39def 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -155,6 +155,7 @@ enum bpf_arg_type {
 enum bpf_return_type {
 	RET_INTEGER,			/* function returns integer */
 	RET_VOID,			/* function doesn't return anything */
+	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
 	RET_PTR_TO_MAP_VALUE_OR_NULL,	/* returns a pointer to map elem value or NULL */
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11d3669bf854..1d8d50b6a73d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2545,8 +2545,12 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		mark_reg_unknown(env, regs, BPF_REG_0);
 	} else if (fn->ret_type == RET_VOID) {
 		regs[BPF_REG_0].type = NOT_INIT;
-	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL) {
-		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
+	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL ||
+		   fn->ret_type == RET_PTR_TO_MAP_VALUE) {
+		if (fn->ret_type == RET_PTR_TO_MAP_VALUE)
+			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
+		else
+			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
 		/* There is no offset yet applied, variable or fixed */
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].off = 0;
-- 
2.14.4

