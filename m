Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953CDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B04520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="koF8LgRJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="I6/7cMTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B04520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbeHAX2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:28:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387636AbeHAXZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:29 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LbFJS024053;
        Wed, 1 Aug 2018 14:37:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=PsFBNVPuVMF+SvV/1krrdXxRu1r6s2fz4OaxhOOiVxQ=;
 b=koF8LgRJeqqkOmy1Ks2F9Vsb+ZOLepdxMMusfe/QB0DWiGkEysd1WLLa89oxe2Wgv7yk
 IfZHoAdQdp1mlD+qEVvkdYwXM2shQLjaSXHS/9OpsR5pCvZoizq1RbDnukiZHEt6ovzF
 x4EWbnTX6SKXxfjK9Z4puQs74pD4FezTlgo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kkfcvh53p-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 14:37:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsFBNVPuVMF+SvV/1krrdXxRu1r6s2fz4OaxhOOiVxQ=;
 b=I6/7cMTAk+AevMs0k9cVvUIwNTPu3c13Sju4/4VlzNxFOblZzY/JI8Jn8S7zkj7MbjphWfXiID+gFymNqrghFRClkTEN15fds5fuhJskKaAKvj4wUsC1zAzWFamjKpmXujLorMOQBbf+Lh5YRZ4oT4sF8J4Q5RZejQyiqZSLvQ4=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 03/14] bpf: pass a pointer to a cgroup storage using pcpu variable
Date:   Wed, 1 Aug 2018 14:36:38 -0700
Message-ID: <20180801213649.30751-4-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213649.30751-1-guro@fb.com>
References: <20180801213649.30751-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:18d2]
X-ClientProxiedBy: MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1dbb209-9888-4591-4b75-08d5f7f6f248
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:SZRpjN74EYcdVD+jnHZux1CFEu7oOafSfe/3fU5BNzlUkicz3SJS3hWaKcYCIidOTnaPdIldovhWG/L126CuWk4enQbBSqqh0a7ZGAHk4XaW6G/vW0EzZMr2NtMLUGsFabiKFkIfi6ar/3rw/86cj1MDEhihM9IHIzcdWiUAbZ82GEiGzXHP7Dlk0MOiNdBumakoGhMf8rG2tUaXUlYAfdSCH7HMihMrtXh/W0WWcgONaFQHsa1W6Zj5Ml60TL6m;25:dAQoB7eWNH2FeKY42yOoEttEn5vDjuVqx7t5GiTw/RiXJ9fnTbZthkoq5PRZJ5XxiFraep/Bna1zjnoL6Max2PEt5l3q9MCQVG3uVOP5tPujRtpQ7A3ZZvmOlU9xZSsh8bj9vywzCK8ILPKPU/8hsmAWpyLiF2QJ0EEcSPqGAOf8Q1Y68QFomOB5JDT0NTfvcfeCUgepRk1KWhRlrifwRwrhhSLVFAMYViUC8omW19lqAxVkjIiKgjZOhiiEKaHfR+fzyhDDR6PbIAWd7jRXI6VnjP3WILZqSSK7lxMihmR1rcFU4BqsSK1v+brXUGe9mEnabC6e2hZ5APJsRyk+gg==;31:wAw+CiENRnW5BT3J7LuiRuSIW8DlZPhXRjVlqtlDR5uiqjygc2Mz7SoyDSI6Ksogk6qodT8Dfu2vtLLZcxdILBwGgKQ+B3vBvM0U3PTfM4dgwKmMglnDNnvKg8P2fs00ROfOn1knCMyInG/hS+no5Ofdn5HDFNq8zgBDZ2ODeUDd9ueQXYG1YoT9twsngwdigw0l5g8tVa/N5hWJxZ7fSs0oK+0UJFzo+EMUVcDMAgM=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:RHG90DRCQlc1QXFZtxAV2Wp3KpNgdH9tzgKvsFI6kkL1vqO+yfFNj4Cnfhh/upTT9H1vmMoDkM5CmzbZeas70W75MddUaOme9Oo2x+xN1jr+eDZQ6fRxRwd8tSNbDDPtamw4+Bn8B1tbNbX/3jLBFsw+Qct8ePiuRPQV/pW2UaJYHsH5sBrTSZQBiwzsSjsJh+lZLsi9NWxIWIqVoelyVl+pQoe7BoMgABVvkJI7T4HJPnzKhtEEaEl+pizotDktuCecnUhlJlgQLphV9abH8mxsMcPFZRy2tKxfvtcnC7PRLBdQ0Kjw3TH6gt4/iw3+oG/KW9ENB7agEch1jUH1Q9up1up12CLDJANBlu0f5Bn0o7IQAFQfg3km0MGD00cehFPf9f+Npf/J+Khn5LC4BtNcNOzf1ukGoorym3FRPFPhQgC3iqt5pmmklzikA+z83NTgaW6IpOozP9CvJSHmDe5CKZsp2yy79Qmeh12L3TFmtm+5eEl0tVzRXven0qrE;4:E99IBecd8Vm05qQ0Hd/I0jU2+CTeYI287TIzg9wuoCtF/ze43vT/Y/vgHVekeXQsPkfkdPwIwKve7GKPAVpcUDhWVl7G4fepYJbwpynczSucIUPrfk5zN/frGnmWnKI8gT5/yr5fYq/kHLsyEg8H/Hx88yeIuf/0xs4igdoyzErIeaBlUq+r/r5Zi7+pT/Rf6ax4gQdmNJ76gFahAY6pv47Hjok8p2Dw83lTyev0svzD1kLFZ6WF3lpTEGQHO9PN+oZRo2RBq1aDPAeV9dHRRQqqSZIDHfqOxNr9gytGgxkBY8/z7eGcynUYIEEej5/3
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167BB95C4A9BDFC9331E2CDBE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(5024004)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:6L51uu1/szdWjRGpWAnm81B2CLir/bEycAA4muYr0?=
 =?us-ascii?Q?F06hNyRFFykPcqQrGmozs9wVDJPHugFOxEcR9hjipySD6jXSIkhdUGbV23MG?=
 =?us-ascii?Q?5WXJyckpFNQE3MMb2itDnAPpqRsNUOlbcoCbII8SJykC4f6QHW0pjuIdVM1e?=
 =?us-ascii?Q?4/2U0oJqPUddDSE8ZEHrXsCY8iXf5rM7NtWhvRxvXevjnN2FmopJjZsLwOLY?=
 =?us-ascii?Q?uRhVbI4LGq+fyJBVbk6UZPyqNUN2sUFOGaVB55L8KC0LtMeIjVYGteUOIJoa?=
 =?us-ascii?Q?GxY32w0ltoonuYG4hl2jXje1tPIuWCQBj81b/0rSwOfqtEsOKNTZpxLprSPq?=
 =?us-ascii?Q?PuSh5xnNOM7d09caYgn0Q5ViRvsoZCd4iT7lxGcbtI7OsstPRYPnZPjpSbMB?=
 =?us-ascii?Q?3JYCxDKL5UQ4o9h4KOssPmUJBK/q7jPudTUNwvSEjagq//gQC2VBb4EhxHkE?=
 =?us-ascii?Q?ASEpdwWSz/02H8A3d+GR1mXWey/X+SbLIcRn0+769wmVGqjAMJRqLxBftNUN?=
 =?us-ascii?Q?XMw44jOnxhLGi9h9lQgKnYcI99tH1Mzkfg3VV8U6vbfiuIl4SEoapIqoproI?=
 =?us-ascii?Q?MsZEfrp1XF6/feeqzSkhPd/+YbNI9ZEU3XsYxWrpKnn0iSbGsfpenBeUXUpD?=
 =?us-ascii?Q?8hDLVmR7hIAicdoXU2kR5wYhWrpQAI9YH20m+V/MmV9tn7A5LRVJFlnw3Gb2?=
 =?us-ascii?Q?NiYnMqzO6NYGqONM5VSfUel1geO/oicvEEvBhwTZoKqnPo8AU2Q+jogdqWPi?=
 =?us-ascii?Q?0Z2Nx6vUqBXonRDwnBx36dl751Q3kXZo0vAnFp5jtnRhree10+RNzoUXfj4a?=
 =?us-ascii?Q?SwhL5xyEGCSw2JIENrp+2KlBUWbR1HvyYHMtVgrOzG/doQpU0i5PC4ax3tyP?=
 =?us-ascii?Q?HsL3F/Gb106+jSYRpj+jF8+XoGeaZWX5eJ6hYqKeogmnR4nH6nABJI+KqLHc?=
 =?us-ascii?Q?BnQ7zGpEoaHjGMhYWvWbVII5yXwfFmiPYVGI94DXWwoVlTguaBDKGHsAKg/m?=
 =?us-ascii?Q?5FfbcgWNU+Vt2oeC3gDRcuqw0MLIA6Fz/2fjqXGwcdyI4PPXuRQStjIMcLLi?=
 =?us-ascii?Q?OfhFVilsOmOp6UDW+tvaV5T53TihocfP065PvgGULGQYruE5TlTvWxCAoR24?=
 =?us-ascii?Q?7/Fmy3+ew+Ai4X2DPRYkYxETqukLp9al4/dd/tMl0Ln33KL/f//jZajuaYug?=
 =?us-ascii?Q?nvE+gLVqNdKc7nr6JkgU51WIev5OTU6vm+SmmbU4pUsRvrc7ROl96RAYDwEO?=
 =?us-ascii?Q?yoqBACM5tWq9arlzsmhEIKIC4S7a3UFtYYrc+dhoCt3xh2C+s9sydOjyg0bz?=
 =?us-ascii?Q?9sQz2cWb/8XQWIG9zcQHd4=3D?=
X-Microsoft-Antispam-Message-Info: 3kyrxoPPgvDEq6wVVMtZgiDFEsXrEnABOXGtNMbLE9R6v41SV2Kh+9g4lM6kpZGBqpjdN+HaEzBBGXO44FFAHtMtJvSRyV2v3UR1DzdH2qdrDU+yHz2aupEazyi7TaqGrWOsXXtll4cNxUXtC1YWJjQBLYFJIoOj66gufr/HuQkKz0mGrbi6Nk0sk41lJ6GOE0Jm1G/gwhiPOk8CjUeqDvD/ewvLmhYYLkLS4FvW5n142G9FTAmJPmIOw01G4oL9GcFY18JdLF1j3jPikIEcXbY/3MUpHz3cpXrUf4hLoDrPEFZ2RzjXHnCzW3espFUaRVJZwgnkUPgDYinNtSTjThDaXqw5ullooNFHMiqW3E8=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:9eYb+nF7wA/jtJZp4+5sXk/Z/rHm5TVeCG8tcDkzv++OmaHqO2xdSso42wL2jp0sdvfERa9wcFmVFY6KHpeYUH5/QtcK9fDl314ESyOxmQyeoJNXvSl8xBsRcOI5AcAOsEKzAwC4KIb8QkkED3AaipYjNjjbi4dou9UUxDjh00uE8ibSNN1xQWt6rXdoTxMFVNvdcuEkrNRhQjPX8p5GQP7xb1I9g+qEH3JXgn94dWlqBznR1rCNqsP/MNN9+4shkp2li6ws0xEWVt+FYKd8IiaNbEjC3perrbtsOhOwgfL+qvp5fXmP2h4tV1J3F4k9U5AsATNNtt6CVjebDs4JKMno0/mBcEwt54/bGwfqtbQ+YOTx88yu966MDoGTAQasvZ914GCRPeg1D+nB+6azQ8hW13/TEOulE3yzrvtD61HV0z3pgjX7HpWLqx1k1JDlgUkFDnyPAOsDeTVoTaPZyA==;5:uBBvwKgtGxmr3KNrskXlm10hJBZE+5+F+Ui269T+l1YUeoKGBCbiW1AotKnvCrLfaB+98GOSkI06zxmmEkxZ/mHmrxRjDWdVTyfH5l7XphoA1IvEyYIhIkbJBa4W3NM9YmHrShTh39WvMDTz7YbLqMPfx0Lsxth8f4qqdzAFhJM=;7:L2V+vE7sOnY+1UK6kiV7Y0tgvYXT7Q3sBGCn/65z7EgyAEh9uMpXmkqzxvd/CmNQlsDCbgV62GPOede3/wiDGxTLTorfYFQSt0Ox+/bao/8fel8CbIcvFZRUZNfi2I920eL8NYDQsVGMnjgD2i6FIEdL8jBQE4G4O5HVwNCIhC9FfIN8N3clCfKTdUpGSEolx0Tv2e+WIsx5GKjY6RmGeGConC6anjlT5u7XZxYusMACfekYdg2b99FMnWfM1NSw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:9sE3aPOGLqgXTx4WqtaGfZCCJVbPlfJfXBSlkPR0o5jOgXSiXudTgnfS0VmAIFWDLEIGX0M7F900CVK5rkPnV5DX729l8egfKKCJ9QL8xWZkqdlC4XdG9wWqQUIIfxneFmCvg8Qr3Ewyf2bAyeUk0/o2kExgc4UORLXe2HwaU2U=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:13.5417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dbb209-9888-4591-4b75-08d5f7f6f248
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces the bpf_cgroup_storage_set() helper,
which will be used to pass a pointer to a cgroup storage
to the bpf helper.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h | 15 +++++++++++++++
 kernel/bpf/local_storage.c |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7d00d58869ed..9a144ddbbc8f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -4,6 +4,7 @@
 
 #include <linux/errno.h>
 #include <linux/jump_label.h>
+#include <linux/percpu.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
@@ -21,6 +22,8 @@ struct bpf_cgroup_storage;
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -97,6 +100,17 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_storage_buffer *buf;
+
+	if (!storage)
+		return;
+
+	buf = READ_ONCE(storage->buf);
+	this_cpu_write(bpf_cgroup_storage, &buf->data[0]);
+}
+
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
@@ -250,6 +264,7 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage *storage) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
 					    struct bpf_map *map) { return 0; }
 static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c2df725a46eb..5f29c6f5ffa3 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -7,6 +7,8 @@
 #include <linux/rbtree.h>
 #include <linux/slab.h>
 
+DEFINE_PER_CPU(void*, bpf_cgroup_storage);
+
 #ifdef CONFIG_CGROUP_BPF
 
 #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
-- 
2.14.4

