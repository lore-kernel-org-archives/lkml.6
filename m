Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A6DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B437D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nTaPiVUS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="R1prFulA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B437D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbeHAXZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388529AbeHAXZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:33 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LWbHl007722;
        Wed, 1 Aug 2018 14:37:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=R6SL8MWP0Mf6kG/U0G20BLxim8z8t80VeHH9u/nOJrs=;
 b=nTaPiVUSPbZqA0x0Kk4QaOo4WleGOdkOB9Fu7i3ukglRIpaKp8FigoKNkmi+QS7ufy2Z
 3o6yb9oHoWBjbXMJznXqYGD2hziS8U/Ay+rLgl/lsCVMcZw8FW6QRr8/OZXfOScdMkgn
 Y40QPl+A/wstk1kQxDPY2fiJUs/s4hEJWnk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkgjvgsx6-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:26 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 14:37:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6SL8MWP0Mf6kG/U0G20BLxim8z8t80VeHH9u/nOJrs=;
 b=R1prFulAGAKn8eY2HipY/teNq6FrcSYjZlZnGtPWcnOsgPe4JnWp9QXZPO31hDVnjzZtt9rI/QyXfRJ3GYMdicFNmDAc22KIrIbzBfh+LZ0wpXTdiCSJ6vELAqqDqh9vKKuENVKjW07PQsr5pqZR5tk4MBAqrMwGn2JD32sBYQU=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:20 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 10/14] bpftool: add support for CGROUP_STORAGE maps
Date:   Wed, 1 Aug 2018 14:36:45 -0700
Message-ID: <20180801213649.30751-11-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 44446e28-0f6b-4a6b-51a0-08d5f7f6f648
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:NgJ78bdBO+r1txBTsFqdH/gUO9Oma7RWMjcz+Sos2QZa+qwS69mrRXoMf/YBaA5vpENdiPwtKo6nVnDDL/tiWyQHBJoF4//51wTXgbfZujKkobzQQG63DDLBmxiGFLZiDv6KUB/fk9N4h2w3KQM+BRNMzOZQsQbc8F4Yuq5iGqoRYS4tGKwoqUuOC2AIpKwnoZHyEXeR2Jux5gazasGQWJ5sSJOZdoxDqYr7VOLzF6Lu3S4Ld7qFaexNd5bi2xjp;25:lgIG+vi0U5IAi+YamcxWExoCn+MLHbI2h17fWAhkk9hLweg+6JFzd85XuAfARUOAp/sWyBOBYrtfO2BNCrOxeiS6i5Iy5//GTlIfcID+NUeC6riq6FFJ+ayYRYK8NdKvcda7RHE9iJXc63uDeaAjDas9oO3lpYgrERhh6whWF6ryKRdhBT3zAFHOsq3bRzpUNWb2GHbnuLtgXv7YYe9efjwYRA4zYD3IMhGmEo8CeA6+AZ/MawFWqa4PhYwRZ02eF08MNPItGVr01nGfpVRkq5h+SkV1tzc1OnxKKSmm2WjB3T32WdSDpe9OxFhL1ez+mnsgA+oTKkobl/R5MppTdQ==;31:iFcF+X74YxvBD6ZtzsZMs+8lr0dCLqFpGQJAVsQX5nwLrEi22sGHInuA8Kq2Z7tEqSdBr+WgFJcLL4CYENCPpweu9N71T+Iqiu9aha6JgpOK/8oaEc+vtOKRaSsrvOEo/euXh7+TY3aoWLouoG0ia8srRyrDFvU2WCZOuwIABYmxwvoGYfaDqz97m7ZoIN7n11PAcW3DOcxtt5JO7pHthvpXBQO3AosYcg6/4DanceU=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:AGkhZtw2aGD+Iy6nXGIf9D+RYkRFBVlM4PUH3wCgXIj+GQIkFFqSqqGsHIrA2Jz0+HNILrpkkJq4gJkaHqS6XgnQ2e0zo91UWOgNy1xqPORr2bMe3k6EowiDFl2gacA6XFnFobfp2q8dfxpL8wGRhXJM5R1F1d/VTz45AN8MCM0UoObOeVueZvOJ6wHmR/Cj2tHMYKpoHBf7mzFvAuWbSwrK63bcjtVduvCvhGHJ+dGyj3XMT2qZo0ZaB2aOyfvscLTLnCfgmK5C0Vqdg7dj361FnJ5bmwQQJQjNhtXn49x6Mzy+nfE8oyyfk1dgcAfu/zOIikvkV+bZjbHQFjROPHruwvTcbGMY9csRUIHAwVkk1/dXPHFX1RGJfs0QYTOc9m9/lnW59GJritv+d4BL4YyKo9B78Bg3lmtSggHlF2WIGWeG2wvzDQPJnjxWF9t/fxhdugJ26UVe7axFv2nJg2VtlvB9WJtR+Zf0/F9jKc57RrZzUf5QnL29KMtx0J0S;4:kx1tOqnTEjgZZNQBouN/zAzzVskveaIAm5A5hS5vloXxBk3bfM/DnAd4RXq76xSoaWcZiDS3T1t6vNWpjvLuEOZm6By7C1yMRobueh8wvejY3NKaTy/wIKDmzzlfD/ZPK6yJEM3MNMDH5rUvVjPN5nCFHmupfT3quHVdXUXp+aRdYauqPicXyKsrhOxIbyiurAbMHHma/rP3RvYq6nhq4lcy7i3ENEeALkPY4LLTfXuhWrDQsXSUoD9qn8zf9t1hsUtfRMg/X+wt0mSiznxDCRwKg5ubIuvk/UOoiNxA3k1lT+jZ7rr542fhMvKWr8q4
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167088E7B85D89B7F2E1B66BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:R7fzDXGdTdYLRbvTH1MWYO3rMXOcWkoRJq0ozAMls?=
 =?us-ascii?Q?G5fFG474DbUyPtBpsluw7DiBSjRy6KshCaPaWieAOIHnSmrpEMN0VshMrmfz?=
 =?us-ascii?Q?fIbbrrOtFWR7O5G5Rk11ztBYuYA78EgHxuP1r5F9i31vcn6D+W4WVsLnyEaP?=
 =?us-ascii?Q?mCBVkNWnxj3ibbo/AfnuDgvoNqUtVu/zGm0HMHrRKdkOFOBx4DeDYw/ssRy2?=
 =?us-ascii?Q?uAqX47sJn6yisJzAHQAORf9BLklJZSmc6Pz/fewKGxogzzMEPS0zmGx3J9bc?=
 =?us-ascii?Q?ZjodaXCsR50/1RoDzmirqQ0fR6l7/sv4x2jCIByIRfTh1QMNK+f8PLdkhbzS?=
 =?us-ascii?Q?/Uy+b9a0z+S9xgidYc6yLL+x5eTm9rN6C9ERLCd8U00xm2efr8gzgoVzOUiP?=
 =?us-ascii?Q?6wn+4vQEgF7TBS43PlHZ5ffSerFZiaaowIrRPZKLNJatMxUQkB1BJ8oYFLGB?=
 =?us-ascii?Q?vV2YdpfOOFEcjPA9juprhTTWi7icClbh5Q5vp1xIiAIor4+vU4nwDuE0A3zh?=
 =?us-ascii?Q?ofnnnjIHKtJXNexV8OublVAN28ZzLV/Cf1sqsRbKMlIB3XF226vfNgFTzHMa?=
 =?us-ascii?Q?bxlKcVlMa+q6f7Q22O5nwYbArr34/CBY9Mqk2wVyW7AUiM4cSJI0RhZboPM7?=
 =?us-ascii?Q?Zie8XXaoRk3rnewK0NlUZ/3r9cY2j8OtpMxmMFMvvY8h7c2HGqfJaul372z6?=
 =?us-ascii?Q?ZsHjvr2pb+3wMBdzAwZCE/dYLDGKAkxwePAMGCBLniPSy3wJHhI79lIn5kUT?=
 =?us-ascii?Q?94lajdJnGy4UgTGMdoFiChYJpthCILqM0e07jQbGK668WvLOthDo2ndY1K6K?=
 =?us-ascii?Q?eHooiWndjSnJEj5jFpy26EXBoZeFaDDqaHkW7grJZnVQL0UiH91OfgWzsSoQ?=
 =?us-ascii?Q?3ATZZnn9CEDVvdFtiD4VrSOfl/ZNbf8+h6MNR5nVa8YZx1FGNJ2tQCFXg8vm?=
 =?us-ascii?Q?5pCHUmwoZDT3/l9CLqfDiYrXbpCJ21ZOZHM0BZoVTaIIMojl16Rxkf66kIpI?=
 =?us-ascii?Q?y0N6Cp56KTWFWYb97kiN1/Y7vSLQjeyyGpsC5HVrvWKSRX3E/tXzqdr3xjHb?=
 =?us-ascii?Q?nrrmNnU3hFotFzsRR5UcXojDHRsRhRT5Y+78W4+OkC85X4csYOPHPsUmsd+8?=
 =?us-ascii?Q?6NT69KCo0zP36B+pyAeAcaqSoN3Js2HIUVKeMOkMndbynYwhO9EPe8xr9aYI?=
 =?us-ascii?Q?FDX8iGaxpbAR5Ot633YmssykCXlZLxTV+v3Sf4wROZdganqXwGuAttFhgQq4?=
 =?us-ascii?Q?drhBViktAo9x3di9gB/EwlMRrSiBzsBki3Z2bhl+w06mMgfxqvw7YaN+0VH3?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: e0fzupjlOcBbURhnsGM/sGl9KQOrr+wq/RXdZon5c69aKSmlm3PeRcsyJWkYNOc/50pcq62WuQ0fXMjx3fFv37ybedQsQ2uWd/wudDKht/e+6LjrxgYNM9JI1T8lHgd4GpHisezvgqbysrluWv4g2od1Y2s1yRiex6uLTECOqmhO4VJxdMVsdTMmB7PUCnOGKMS6JcdKlHLwmHIfrWMAUrDi6pdMkCxYjHCGrr2TFq8fov4/wMAV1URs7ElZORXa0jFQvXdlSOj/R4GzMxoedi2soJxGkRxcDXT8oeqNIe4dz0GnQILHbrwr8uDWUtFZ6ez463MNqs8uCfL7lD0hOGiK3BXE44TVed14gPRJ7XY=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:uNKEB3Fvj3MT/Fo8vF0QapWmuGjZKhy//0oSo6Zuy4bo0UZWHPkieuauECGQr9iwY+TlG56ACyin8LA61K0Em+7ULGgN5DA9EwOJPSa5dWWbtdrYivGHD881taFKtg5ThZaHjPF7R8UTFc6JgolQX+zYEewHETgjQoZ7AJksLE58ApqTx3D6hp2CQgpK8grlz7f5cZV4WICKhwPnS/bPJaeoATSDMgM2Yu9hudfUxmpUVGf3JeFI6ZSkQFgRLTmrnvf/5LaH54+GiE+0VBuQOdpkoVTTk095wFuuG+AeC/VSPKm2TGPfm3aW/On4dkmQNeNwL6k7E104TBH1dyUSa1JhYr+r3wC69wz69iOgjcyUN0RuDr65YmVilQCLZ/j6GLWRs67actn6vjK2+t/qdM106BuhPyumW6scg2nqU4xOQ6Rbsv+XyHQPyK0K4Zr8kZXuvpOCGNNpauSvOCx/gg==;5:GWk7p0xL68ww0Fv9D4RLkNaBYzSA4ZVuQC/KOY12kIDWIiAqICzrk1kJZiOQIRhzV2S9MynD0O82joa3BheVQ9+jVlP62rNCzJoCtfJTe4C2fk8Hzn24XbXOdz0reUO1NhoJQ5jyd4dbfl1J/iOj6kKRTZN0ZExheD+SggdRn7g=;7:PrapXLZdxXA10TgdqAhf2BdygX7vISCm4oxyUEksOAZaAPfhkwNixEx8b8wtWq8DvGox2zzl1uWT/wF2DKW+jj8mXcrmdEaklpj46KFcyTfyLA018tSfNZQ43V+Dw/xclupCv5TZWmM7ge0LzNVjFSRHDm85wT97TMzupfYo3LE6r5Q6O8EwE3redEmQVnrTd0EZeYCkxpW0TuAcXyqllBSUX9m3lXEJ+7WIw9QJQXJPhlXECz6/ZhADw7CGv2Hc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:KcEJJi3rghj7R4xL10+HdMh9s9MNr7aqifmr15prqwpfhuWHVg5NHwuWOqAlVUITZ+hOjREVyIp2l4kPAzOKB/k1kLvjZHNO1DmtYKqTe/FZBGBbKPLzkt6gUdan3Pw28r12VFb5Dnw808DJbZzlLEJsVLsm4P1ciaqURVbJBYM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:20.3568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44446e28-0f6b-4a6b-51a0-08d5f7f6f648
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
index 0ee3ba479d87..2dd1f8d9cc2d 100644
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

