Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8606CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2832320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O70eYm7W";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aKl00G2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2832320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbeGTSgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387881AbeGTSgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:05 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhh0r025812;
        Fri, 20 Jul 2018 10:46:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=DX7rdIOZ5zSldQg76TLlywvYRw69nJiAZA6/AZroUuQ=;
 b=O70eYm7Wje/CJWtlMdAYw+QzeCzIzJTymwlop3xzEn1AnCbdBIeKfwpH2zc0sC4Xt1ZN
 rPOFVui1Yo2K09SUPhPuilQ2G6NR07eaxGLn5LyxsoYEUV0GaMcoRAj33HtkUf2uKH8B
 A0Nb75ZN8umBQ8Ik2unuRPdXkGiY9tc4Kag= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80dv-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:26 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX7rdIOZ5zSldQg76TLlywvYRw69nJiAZA6/AZroUuQ=;
 b=aKl00G2ayHxzcC6FemNlJ8Kt3KJJgepPZDkGT4viQlPXI25XdTPRmRBfjlvispkO4qCttwxUVQ867GsYpakuZFePJ/9ADvEDZsLRXpuGDXK7mblsjqqLJ0ztIuNa5KGfWz+6H8OmsYX4GeVZ+LcqryANw0ESKCp58AUG8H2hNE4=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 06/14] bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
Date:   Fri, 20 Jul 2018 10:45:50 -0700
Message-ID: <20180720174558.5829-7-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7970b75-d6e4-48cc-6090-08d5ee68b3f9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:NXhEo+V3zlodAfD3flS5jhfWh5zKmU+WwcxHAK/HaBRL4eOsm3+eS5GEiR35+jhcwWtJ4roKkwicnduQ9nFeq//hcnpr/2nZPx0ZuhSya70Bu7qAVMUIyClBG4zmN6f9PpLsYttUrnE1VG3Vp3R017o45Sx+bz5CZtgZ5cvoLpa3B4gdqA71HhuENoyXAFYuV46HtIa4naCUe8XWMMZffAI2H+P8tnq3fhiUuEmwCe1hFFKJ0bY/gTRsiUqRO6Hp;25:qZh9ftg1dDatF+Ght2ebrPncxpNwC7qJPsvqyIXqS5ZHO5b2RzLUr4lLP/2wH7Q78cBVarkkHkl41FNbc2bLxA0jcp2C4za1q/aRwRDiskYOFvYr4QeSqT2Lo5lZQWJpBZs2X6+7IZIj4bLPjVNwGa9opKr8Vkf3+cHqf58HM1YKOYhWvq3h4u2LHNATXIB/EfOAZlSuZVhddaDXaPLmsaZ1aX0mG79OxfChfhzwpyBGyQAlC/H+R+zKVnhpiRKp3e3oVHp3f7SCJQ9frj179sok+CNcBOIZ+moH4C6wWB+pYdsLjsco3+/ihukYhj1valMI9cZEOSgTM0IXdvRcrQ==;31:zwrLuMMXQFGqI0JlKUw5Mx0S0DOCtAUkPxMhjN1ibN5shXvMgIZXbHfb8o64SGqy9gySRy6k7L33wdMi08mLRz+41ZTqcgf9hm1HXvEP5VWDGZqgcS1wg0u0kvk5Qpiz4tMdg1t73JF17g+mKQwRtNwPI8ggltxmPYhGSTiV9TuPpczLfv//dUnM7ymww9T/aIjrpJ7LxnC64NEX7691OujzYTg9ZAWuSOYqX77uEBU=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:uABCKQHT7Js0zoZm0roj8QhBPKH/Lv9DeWIUchS8uYK3Z93seSBPXH/pUBACYQ7RQ/B93G3mp2Hui6UoDCnMYWzd8t8vVBBwfl4wAy/UErYOaO/VSfZz+7QCI2HECTCdrJ0kSed41E1LF+ZLgW4Rzvwo54dbR/7JDm+3W/pXXB6KY7qtQJgIell/OhfB0Fdst4eV0dLZIQZKtEMHu8lsNfJBXNt4LJxGZey0RIEcdLV+j6JrlC4xJAOB+BNIGgllxj/UM9x854IG1fi5rzplF5UDWUS0VGOkJXdrcsZaN1j2elwAfr3TfAV/8bo5nERY1C9dc616VyvzMQE124hY0J+JAwoGmJP4SNfPaJBPWhV0amg1N7ZqrAYLH+stMyT2MQA/RYTipDPBisDu9bg363kcC3hj1XiZKH8cCjf5iUbZMr9oYqY78MlvaBCSpE8XhrOzKVsnn+97zyPLZSLv+4JXTjjs76qQ5AXPaFzMFGp1OtCmIZUIbH67V9KdFDOe;4:EEu37NMuptqt4TznZjBS1IPiJLLV+2GQrJwFkUPR8YIvgwW9jJiiMSrCP4L9CYQjUUa02wmtXrABQqiPaYuXdxlO6KH54ChM6Jf/wEg5eOmX6H85IX+iyRCcUUsPuDlAUT+fZAZuA0yn9pI8nHkWtdkrZAavcaxR6oXIrr1xXL7gdyrJ3Lx8I8Y4owUSalkp8fXw57aDRs1ckWd6+W4ZQ9S6kVaL0b3W3dUmmxGu0a374JmvbugU9fDRUYwJsNLGwNygffcpmHPQqSkp8iklWEFU8QNh3D4Dlt+WSHKBKfV+8QYn3sLYtNArgL38TQ3/
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175CA4424DA9F69726E71F9BE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:+cJFglssASWnT9M3DMLcQ52MtUneFztlFYQKpjZba?=
 =?us-ascii?Q?BOZkj/8e0r1dprFqgsmyEYy5CG6SLF7Ay2LROcwzL+FeqbipMXFFOzc+fBSC?=
 =?us-ascii?Q?z6mzxck0W8loTPv1dW/76PyQamctNjfDqyg9NaeEFNa8BlapDjtA1fa6oZFD?=
 =?us-ascii?Q?hTNBoSunUSnvGy8Ys4eK7hnlq84O7BwodnW25OM0HfZNtZ9ohUqqJYEvJVWa?=
 =?us-ascii?Q?4RVhD/Ea2/q69Ye6DARdb8jr6LNsQp6PKitQhrWdy64dSdN4kmUiyV1xxW9g?=
 =?us-ascii?Q?l+yNm2AdJzl55ZKQ/QXerR74m4E25WApWQ/7xxeT3q4ZIgK+bJW0wfIF36Pd?=
 =?us-ascii?Q?IPq6QYpFg6DRu06WTR0BplMBGztETGAbzxCgqbTVrqYgTait7+uifctOmIaM?=
 =?us-ascii?Q?wpV5CtoPcc4Ei13bDuBa3f5rF5egxmKbG/JP7PyDK0CZG4Axmq1QRjVFTuja?=
 =?us-ascii?Q?g9y8bfC8KcPZCSX5uwj56b0PnqlRqBSTsZTy9Xuv3w2LkfsKjPRvBngw387B?=
 =?us-ascii?Q?Nms4UxrdMvz+QHvbbEA3I2A3KHHOq+2x8MhknLhICGWMEe8cO16hBgYMwFlv?=
 =?us-ascii?Q?KU8ZJu/vy4YTr2Z913B3yL1cdGNwW5OrqOeoTFPG84JS5sYw7pJBMQ3kQv5n?=
 =?us-ascii?Q?/N5pompI+ASZZrD8zibVOVIlunTbtabjCMCjTdpuRrlwKl2WGgvCueRmDDue?=
 =?us-ascii?Q?agTbgGtpgK2G2vOmK752lzRNSTAy0R6MrWqmC8xygYeEA6jonZKpRUJUnwbS?=
 =?us-ascii?Q?qqiJjMjj7ClKkuPiNL49lHB8tWhaHIka+yymyi0PiAZ4du9Ncy7rj3yVSatp?=
 =?us-ascii?Q?P22Fs3y5azpciII9mFISB7ND6Pr6y0mexBLZcORhkJaWpnsYBL+dNuWLfItB?=
 =?us-ascii?Q?b65laAPvh8rVZWCqyHFl3DDk8H4c6RTTsC+7I3Zs44VL4Uwfu4c23Z4e0SgB?=
 =?us-ascii?Q?k3DJVjtqKqK80h/8HBd6cede+pVDJMpLS/KJEmKvnNakXG/aGx6GrBSDLZ4q?=
 =?us-ascii?Q?dPv7gSIE1j2dwvNFYTgRZQ/X5RCBtPlvzDIrNQ24X1I+NAkbqzCyDBWh5u80?=
 =?us-ascii?Q?LWVjW+rW5fjKGHwDoPPGBEj31nx6mbK5I0w2yKjAzh4V1ByhpLXPh+kwFwpK?=
 =?us-ascii?Q?Cb6FF/eL8gCkR+2Wprz9E6A5knkXKlCFOcmLFwwNyfaRjGTmV49sBstaL/w8?=
 =?us-ascii?Q?nFhLKzYvmRdF9DmpbcD0YrjtJL8OsyeqU3t2fCN5uXRTnAA6dJmkcYemMutJ?=
 =?us-ascii?Q?tAKVWNBJdGPRI5u1yAvu0ILuLpb1g8S6zn/jVSCV1PlKbL06ABNB2Z5vam5v?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: mwYp2E+5WA2Pwfjc+nC4/nmx9WAuinDKjmveZTCug/Wq7EQFaqUulpCKfZ+izqPzkf2lTmr6zcCtNzczs1SKaEt84BbtmTR9RG5iWpTVihvNKpuN/LVTVgdValv6VC1tVR+fSZppC2PMXY8nfT2qli7ERzWk4cejt4/8EvtDM6xV4lNsaKw8Gro//DmjNBoeZMJIUFFD1/R2uiNXWs/I6+Z/LZu3uDGhHXSsC91gOOhQBdeee9513aWI0Z21YmkuLXG2UTLG9S4um7g9tf5nfpTA/NGT4FOP0ePGhhKathkope16xzzuQpDC6T0SNGA8Pk1MonNejFe9lqa2Opkci59DuGnx5pL2P/XVYvrtPGg=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:KsYhnSN5lx2JGdVK4HjqPQ4gUA0uQ0Kvv7PghqDjKQlHQCBUBBxxMz1qu6hXDeVLD9BKTT7Zaa7knsyEZ1XofTjHl8oXsRH1ofKQkdkWVVGSjAWvIwnwD/TBTpRAMFQ8Mzowx4rxAtk1iWsmkstME5g4hUt9BQDY+0rLyLERNG9NT+qpJAvSzfVCfYM9x/P9/RXiccepM4eB9eGWPkEOoqDwpocoLI2Ss6rNtRMz8su+vGBHT8cBwhMACPE0nq4ijkRj74VaNpIJ4PESyzg8/11nXHdIu3PWZ70NL7lHTapaEciRqVw7S0ZNtjmye772ifuvVzEORgqKQHvM9rzfxEEMtYOps0McyrA5OzM+Mqv0taULtmBvoNalO+04OlAI26R6ZD9tAEZkwbrEIlnWtAITKLLQcQSFq7HW1rgGi3+PvLyy6QAJksRqvPPTz/l0rHpmIoXx8Z2VEHKXZ3eicA==;5:GCoPr0S8uQD99Ye4Rqnmynqrss9neyUHZCr5rWmOdNv7bGC5CI5f+GURW6uTDQAaSGaITca+7/WxIv+osSEghqaLIftVDMfepS3r377j4xFwwtHPKB2rK7fjQmZiqLTYnAHvOEfcJwMkiWsKMSIyBltg/jb5Jd7cUFTOakfaxGY=;7:AlIg5JTWM+5wN8Z40ZRZPTOV4A1sP5Bqg0xDewcwDot+QQEgUOECBOukXvfiw046ptd7CBM7rytqyoFMiymF+nAEwFkDVyg6ILV1fJFIXBF8MOITrXbvdL37Z09+OBtSNu01cGVyytCbVxYZ74nPc17BUm8MHkfYzhoCEOzI4WQUYReHsdG/N1KV6BhjeUXGE5RU6KEOjLQkURhjzAyQX6Bw3dDoVxqjeJY8qO9TTLQuoiGtt3Dryeo+0j++9LxN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:cF3hnpyvk0C+dAS3tG87CQ58mqUOeRRLHOUX2UpNQ2DvkJZyar0r5gVqJZqiXn7jHeZ0yWENYP5OvylGqzeXuAt1rwR/NgXRvF0Fe91KPJYbeluDLs/8JV0iLLe1VzpjBsy6Xog2v3AdeBDQnnUql4ixeESGR3quA9sYTsWOMFg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:19.9221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7970b75-d6e4-48cc-6090-08d5ee68b3f9
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
index 0b089ba4595d..8098e39f825e 100644
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

