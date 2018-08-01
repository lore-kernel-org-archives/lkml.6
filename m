Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8553C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F44820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TS5LBD3F";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="O+Ub0udL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F44820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbeHAX2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:28:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45608 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387618AbeHAXZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:29 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LbFJW024053;
        Wed, 1 Aug 2018 14:37:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=2f2oZ5nTFhXCCxmD98z07ydS7myVbDZ2bdmu5+ktmlM=;
 b=TS5LBD3FgDm3ka2dvaG6p5YIynEfBX68Gy+Ab3Xb2wI0TkVFYDREOHYYSVNY9WUESJ1M
 vzNHDjWKjyGgqxUj+pcIeC35JHr57KnGzP45lbUb4Fm2Lce/cJuz8CNR90nOEJjdyBns
 ngCSlXEMx1f26nWlqK5z5NFn4wp2wuHwUhw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kkfcvh53p-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:21 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 14:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f2oZ5nTFhXCCxmD98z07ydS7myVbDZ2bdmu5+ktmlM=;
 b=O+Ub0udLfSrvpxLo/swUftMNCrqysDoI213j0jDuidqNU2Le/9CiRut9d9rMczaYnSO7RAgb1StFpOYuhVR9XGmUAoDIVICxHkPLUNs388mHAH5V7PDxsq5dEDUA4D81JTkrjJjhrXEs6i3zvW5S4nWFdKa69HxDEaY/NHdE9vM=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:16 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 06/14] bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
Date:   Wed, 1 Aug 2018 14:36:41 -0700
Message-ID: <20180801213649.30751-7-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: f9091940-e430-48b7-c8b7-08d5f7f6f3fc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:/K0DLetqrpKdS/Tt4KUV8K6b7E0rYghccnBD6wLcapgt5EQIL6J84bkxPrDAaci8ooW/74g7dQE97Vx7tX3v3U/ZX139raB32MpmJWzWEQCtKcQOaen6WWeHS8VR2erWhfT8ejAZ7bBPjaZY+Xp03l3BxmeshoTHLeKeOBuDM+mXBgzirCuhgOnF3WW6SP4aMvFjtoQm1IgW/zrwsPSJ1d06WH9ON3EA3qjwBdKdBijlsmFl/hYvNNJp6l4aGKhX;25:my1jf99rXBJMQ8hArGYRGB1wwxJ/huc6wgEBkO/r8FWIjAGCIJPM1NGJvEYzAZlrpD2TxZuHF5GiquNhz+s05vbnKRhCVoIzYSEfIAmnRO+8opj77x68y3wbIRrDOUJgGr/RdSn3nUKDkpJtRGsL687VVUT/RuQ0Lr9SjH7b0aWwHSFCFRGkng+Q4BA9aRT5vENYJE09gs/QAzeOo5bjBZ6nV/gb7IFU5cXZXHZuUZ5vd4DyICzaGaA5ju0AsyksY/CGxpYiI5pNMFBUtKwe2Yuamme0ypZ6VaTt5gb6of+Bxjni3e9jdg/0PM5fP77WGOQMkNfcU0bRXN/QTMfAjA==;31:XZMiB9USm3FMIcv2ZohKAc26zvtE35TU/FnCz4fqQ5G73g4i8h83ri5XG7eaRumrBYILj28XPKVKksml9ms+F0OSk/rPLcuAn17XI5uRvTaGjNj3W3XltY8OKou2cZIiFTkQq+wRkN9EjKGkQxFjf63mojeLkEva3fhD1LNdugGMHvxHrbaexIoV/YkWRyIGDNdV+Y97vWdlRZ8xDAN32FOfET2MLQwAuBnWgxjBVUc=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:ENQUiEYu6yjAnk2wDD6dIVQgZq+DyEzlBs8sjZRnsA+tp3CwLC0k5qMh8dXWblTKbrqwvkulCJSW5Z4ID9IP3wSBZKyQ0WtN2y1HFx41L6x2xBG2kOFUXED0pk7kc+cz0CCbEEMxjaYi3gKpiCFUG8pbMKdZvfrlGHMdzqhO56Gs9OQKHJyrYz7JLg3xuDPF+NJ45NhudPPtPFrqKDHggtGtJoxBDDcvi2QE/Jk4/J+lAbFZF6svfKdDE2r0t+QUJpEX+NH6jI1is0iUuBKhQYuaE3kfQCPT+Vakl+2Z4MVlqqJn/R8LuYZfw6/M9XhI+LorOMsFcj2zmCxHU90AzNAcJ+1AxH+Y7AbK0LCaGulPT0m6EBfN8GFvmyH1JSa2h4HmCDuBS7Jl1r9YjaNm7NFGwOzvs73wtGXZHvKP0bNQjlw/BEGopi+bRNjhn2/korqcJ5QGUA4FnvrSVIZhN1AX/lUFJWbW9P10zz0v0FxOzb/giMsBFMIHh2nbw2ZQ;4:MjzIfJSwg0Fk5BdSPvNiDZCsVk7hGAdry3Y4Eg0yvt1N8uDZsAeINq50IocWqNDIQ+q8Eo3IziV9tmMxZ5JdvVx+4g2ZEuhdBDMto31HGUm8V03lnCVLYxnm4Kv38QO2QjSEHYbhmlFoLtAm0D4q9KWzgtu9/mE/3pkGrwvggcVgYqXeyL3P1DEIdzGMbNJKb/mfBf816z4C/kGBDwtHob85LmwC5e//g8U4uNLDj5kugaAVbdVS2x7jhJYt2wDscqmOCxnacux1hpNhQqxmojFbtjfmEAaGFmqC37mQGzt6ut1CgS61lQNwkVk97/fj
X-Microsoft-Antispam-PRVS: <BY2PR15MB01675E57F609E0409D9D5495BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:EMAJCwxBQk5MvEX3/ywoktOjrrT4XGJyfm419F+D/?=
 =?us-ascii?Q?LCKn3UXVFQ6EgFqrBCml1T9D4uyXFgiXtsRjVpJQ+lVE69jTf3HydhAcNH6t?=
 =?us-ascii?Q?TuJH3Irz56cWpk0NZ89nvj4jpdAfa6anm8q2oFn8yXb4HQqQIinqBcSPMBDX?=
 =?us-ascii?Q?8mGLvU+NsO4b6k8ZogFKYoo0KeqOih3L3IjucYsKkdcQCnYPlz6Awv5sU1Dj?=
 =?us-ascii?Q?62u/Y7IMpuMxjJiKEFm2oCTiM7XphN+NsFoAvdQou67u+KfiBONRoDLpOKPK?=
 =?us-ascii?Q?NXtXIY3FvdJb1b7Ld2NL6A9G5Dtsdwna+wRYnRfUhX5fyuoM3MCnbHdiM9ee?=
 =?us-ascii?Q?fMbozaZS1redkrTwmXYvqhiTPsfLXKIUj2o+C36cc1fcoliqYCNVZkFJ6aUi?=
 =?us-ascii?Q?WCMBF35TdvJMQLN6+sg5pqgpvkSvqVYbJzMRTHyazEbVVnSnVW1VR8bt7c3f?=
 =?us-ascii?Q?zPPNm4HXxmcU0cuGSBMf2d46k81Jzh1W0yUCAaxKVVCpLArRhEmIR+yNQvUh?=
 =?us-ascii?Q?ZiuCz7SAsglB3z8JlNW3d9LWTCwtwWull35k5z73P8FcYIg39yNGmPt+RtQT?=
 =?us-ascii?Q?3qujE0uTVdOE53FpZOoC6CXdQWbiMH+lEySOMRlxoABKMvSYzLO99SOHW6Ut?=
 =?us-ascii?Q?IElXJFXga3NTPlFaG6EYPP3V8ICWQg3fuS/rbXVqeU/hck3J+K52YRNUQavM?=
 =?us-ascii?Q?8Gr4o4O8XoiQH1ztN8E0c78aeIO/vOvYjZhtaL8UJWw62kWGD5auGspawnHH?=
 =?us-ascii?Q?p9CwnczEwLR/hDPNRY2vKFyBjgfrvTxRbq72MeSZ09/Dk/i8AhUaSTSDOn2w?=
 =?us-ascii?Q?EQI+aRVJjVVmecyH6oOFGcNGmGRKq6MMZF+7PCNrbAaW6Qj4zvnApkjRbCXd?=
 =?us-ascii?Q?PaJDFdhmonKy6fqcYpVW8J3K5HZNPhtKhDQ/E/Hx17KVS5iCf3NK8AdmYvo8?=
 =?us-ascii?Q?+rMzcrUIsuP+lNBza4vRIAKmZG11bjInqRR+emO3a+qpCnlOwdKpkK98bJA5?=
 =?us-ascii?Q?f5akRMU8vIGL/mqbtafCtJ2zF5DcCAa7ANHhSWObvJ1XW15e9OqAzI7VnHzY?=
 =?us-ascii?Q?jeKABmC0l6IoIibwGt1L0Glx6tTAyoGYhgOufw91Tj1HxS0DKEiCBxNed+uV?=
 =?us-ascii?Q?w11pzTQLV7KufAIjvR47l9/VZWKL1HxavElFjppU0QsUP+TgbXzuyaBQnGPz?=
 =?us-ascii?Q?jU+PQSjh3MMBjVziIgligVFR5hY4F9WHAXqB88TOrDUbmc+kwnWtchOa6Yon?=
 =?us-ascii?Q?eu6HlXadaC/6pFYiojduzCNZXq7XW0YGW6QKgM6h+Yygs0Bqmp6dF+6tgsPr?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 0pJ0TUhrAwCENwNKFTYLXBNNhxGDNfjCF2KxVDI0zbEDau/kM8OkO5XOxqo5yFR8TZncYqcYjWRIFsUMHd6XfkYkij/Jz/PQN2pQ3gBZbRARwX/LR68qBU+jIp39e9H7NckIK0cZGVeWze8gVMGkIMishmAekcW4t9PNCw2pUImqJS4mTMSGOGhDipyNgUh9Q8WUP34d52mYo+lMlODCf74HogzSGdDpDH2xhXLwHbMFsW5t76VJp8GM4+k4Zx/BMTpxeJ5Mo6NBs+OUdj+64su7BYcjptBRXGW70aUgiOoGPms+jQOykFTjfIvaFo46XzFcp9FwilaUFfPu6iJF/JnYj2pGz0G9K/oqlycxeRI=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:UXuOijFqUVBq35T8z908iS1aJJpSzblJ0Pt3wMqf1cGR6Mvg69UIDC8hZqHpzEKoPdvTotmWDT7KrP2qgSPwkCnasRl7d4ft6pe3Uo0idymr/WZON0oDHZHSe6+N4AosQMV6AbkBoZMWnZAayYwIAKS4TzO5vaDmld8ld7bJ2oAphLc7kHiGbZqnim/7yqwr7ZwI9WtNBEuul7outuoC+9tcQIKdpM/Q3sNVux0djINT0AGLU0a+Fj+xe0OFVBTASG9Z+GCby4E/Vm/SsO+WgVHmHCk0Du+tfNkczyy7yWsEFHg8B7tkUkfweAZj8xbrPANvkQO5w4rE5uRqJwjuTws2w7KBDcNN1Hrdk+qIfyMWkJ/iKMKqCxQMcY0iFs/4sWEABXwcWUxMoqyeo+xyZM9c9WUNC/fHIr09dbcNcE7x+mI9ObfLbuHXjia0B49icF7bbeefQISlTs3h8aT/xg==;5:awnxxGc0jI9otQLxWp+dZX+WZqZ7ucPx81nlWZhP7kQw+Jqq/6O7dFTfKLlfMLkCbqnQEuyR/52jw7SzwzP3nq8M6S3D1dWw3dxo9US8ovV0KAB9DBc8teI07GL8LEtWNsbOSOQgyaNHlqUt4fk0AdmhtXSzOc1fpwpW3ZsEpcY=;7:JvahVjBCJ6p89zeSg0LTgbZQxqhy0RyK/Yu9WVlSatMZ6qXpVvmyG+6aYPDtvZN3/HvyzTsScZYtxNcLpqDC5xC/pP1/itepsAdnC0g8rMLyzx1nr27KI75Ok0tKct/ZcWBTC3fXnGakbDPdiAvsQd7Ic2nkYdyVXmn8MrHdZG4K3dyIEtHw2U+EjQwiXteIc0Gehk+X/EOuDNfQfvSQEyPVpLiZEe8ammnYzEkHx7lZ6ZcZhgjBBp7wMEtcH/7A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:ZuF07+Ta9xjBZXlvtraXkKaRWmY/w6JjHEFh8k7UWTclLCbR1Ke+Gxlc0djbT13QCj3D/AFVaeb98dvbuFNv7Tc9uKNrvE1I/qvUQ8HdQs2BczI4+KmMWrVNd7Xg3W59UnveXQfd4Ups4AptMOL5RK2hB0AGQpUtw/LEjlIBD9o=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:16.5013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9091940-e430-48b7-c8b7-08d5f7f6f3fc
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
index 7e75434a9e54..1ede16c8bb40 100644
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

