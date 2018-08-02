Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63209C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E834721571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YzbupWVD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="V8uuVres"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E834721571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbeHBXVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:21:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59168 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732190AbeHBXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:27 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72LROUj012185;
        Thu, 2 Aug 2018 14:28:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=HkjTY9917jaa5vJngEByKtiskZT7PS+Gpyf3N6mx0yI=;
 b=YzbupWVD5sxuQoh7q4flRllpIVGv2iRPlc2MgGIoEhXHxLyG0JVJS1KhraOz8oX0Jv1q
 vdsXQpfNaERPo9JZGVZGhlp3Ka9FpgkTPbnTvHv9dTjHxmwWaqMkGWLkR0L0GWKgdjMM
 d2VH3Df/zLaWCbu9X/Mnz7AwiiKm49INiyU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2km6jy8nt5-9
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:28:08 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 14:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkjTY9917jaa5vJngEByKtiskZT7PS+Gpyf3N6mx0yI=;
 b=V8uuVressughEmM6cW/amrYclGkcWcAKCKaBmZLb043HpmBU8bo4GXhXBOvUQwQlIOjnlitSMWS0JIcwW+mZ/Xrjwkxp0D0wlWsH0AFpKPGsdLXKAiqxC4OCuYc2DJM/y+2qdF2hq595bfjTNPJ0tfxWdJnBiqSkNG0Ax/TU0Ug=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:28:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 08/14] bpf: introduce the bpf_get_local_storage() helper function
Date:   Thu, 2 Aug 2018 14:27:24 -0700
Message-ID: <20180802212730.18579-9-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af3314d3-63fe-4e52-aaf3-08d5f8bed395
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:gexw/ak/C60HvcKBium6x4nlGKAAK6VHXFQp3rrGE/il8Db488Tv9SpjeyJjPt2Gaeiyh6O4fVRDYDct+UHX91GbHDUrc/jtesLRt1FPkhO1NmuqgGjVUlkdebD32bpfbJ9pPN3LkHimz9wj8pTdu5OrR8XoPX3kMIaFVHXuywN7jdpxVNLF6sbloOJDdBNSMCQxz7nW1pcyLVHYfXWFc9M0Xo7TvK99L099Rx37sxonW53qZtm4/C3yd9ug6Sv/;25:/7PKNn/fX9Prm+5usYkrAPSj1rT9f+nnz/8RihurdSt+u2tEnLiS+9us2bldHUsMCVuyI4ukzEvBlx5KZF6tEDeA8J+HKW2MDHCyXnZKyXMpsOWsJgcFjRgmrPPJohUqBzttKlpHnFcqnbZ/2wRfmk3AtXO/L5NIP+PwBrgI1WF23ImkgUM5ylcWnOnuOAXIUweG23cwEkOZUmUNcGitcQtabwvcFe61z43UMMlFN0PkNvpXgAxBHq24oG2dBbzoAecNJz6i5Umb4dvgycmtPSBB1BiQ/iGlTi8GzaNhLfnDd/0vFQrbCHniOhH1tNO/oSUg51ycPz5VL5H7x5Wo0A==;31:GjMFAcjPSSn9IdhKMmGCbpg/Mt3fTXz559IjpOS/GEA9EN4OlIALB+z01SZwrCT7qpwxnbiwtTbmY4AX67RcOXHQRirlo/kaOR7SCJVItuWMcSzyWqonqZpdhYX7p+f1dRueJAdPBw9y1akhH1vgld/nKqaPafFvQS0+1AbhDFa4p54sa+sXwaoOffNQ4Rh4B2BsYViSMMYu4oxY9dpi+RdIOwUKd+IiFFDAqyk5wl4=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:OkcjnixXSqtw5cMKLumrW/s6n+WoqRSFTIcpRJ+V6OVlE6KoFPvgJqQoBeEu7h+WnvLpVTSKrcoiWX87ALyyp0SneTgZd2yFfSD1Jl3DycEWN0s6WvUfNdVeq4FSB8cOtiLMjBOCOiag/fMFQk4xveDOtGu0ehcUatA5AnukG+lCtnrni8pVt3M5JaBu/15YIBfyvOBJk6nHzTiaOu9Wh23xNlSEjsQgr8aD73VylqosrfAXLHyMvXnLa27269EFbh63S9HzU/XnU/sOUy/H4YWch6l0Wg2tlEy5vk8Xi6JXh+SNJP1BqEl66ZTknlJhWZ2DSS+KyYSyalynKcU+TDC5+l+FDMqJKwkCAXOXnaWlV/OPbYGzVaLDyP64NC99tLp5aLE8qmS5YE9qgIVEdG3HftpYuhNLPuOftvG9cqN6gigb13pudAvQPYnT0Oq8kdDDmtjnHHIBNYcNy4WlIOoO3DMU7r7ztqokFv2P57t8GWdDP1rAoqQyaxEAsYzU;4:/U/wEDMVFAMQAXGafDXL2pRybS5lwpwJqs6JPTPrsjCTydzazELVGBzdotYZ8/RIWNYgbWh7R8+WdI9sGIVt00PjYlywclpgqbAPgFmYPI2ZzJi1Sh+khs0fN0LhJniwsamDrdScRHCGhxLTOyUPazlwsAD11nZwcUrubdJAMJJXnnbVPjK5JSGsWiOuDXofFv5+/mkZdlxGaVP//4oCffXnRKGWjy5/5kO75G7csaZpJNJwHJSjaLwF4zgXOGEaqXvkIK0IvKxI4TJ9k/4AgwmOEIPEMA9E6pv30Sh3zZ6/ve5uK1/+YZ6774aUX9H6ENvhy+WBOhf4uLHRR0sbKfMzULc+eKM/iKVNPO1z+xQ=
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167A1FFA286123E00D60CC5BE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:LTW3dam3hvizhUjKDP4IgutAneov0fb94uNDjtzN4?=
 =?us-ascii?Q?us1dfQdcskCxCsmYd3hoACbz+N4cC5KrEyTlL5proMB6wzZezRsk37AKglH6?=
 =?us-ascii?Q?JLIrHZfpoV8xldvO8jahVmVxmH32X7naX2tu2MYUDpejtv9TUSQR5t4Cl6L6?=
 =?us-ascii?Q?5eVmk6hWKcQQ3Cm6tiJ8RI/k2dIWcKy5qqrODP5EVqE1ZQCFiYUQgBWJJr8O?=
 =?us-ascii?Q?xGrEVquL4vvZ5dlr3lUsInSaefPFWhRG7x/0s5QZ0S8cOLisqnKf1ZVMHQ2J?=
 =?us-ascii?Q?7WDGyZTsA2i7CHKgSC3L0k49lrVJUDvqssoEgLMqX6qgsXIYxMAkz0rYpNY1?=
 =?us-ascii?Q?JUvNuDZGcRjKojso9u00nHepVCTg2JfNqivyV7j3XvWA6Ekc3U8Zww7QbhIq?=
 =?us-ascii?Q?55JGPvvuIWjgDEeqsN+8B2i1PxEOWikoOpImFMj7QBEu/kw6LCH9LCmZ1dPj?=
 =?us-ascii?Q?q3T/1nP87NJ4zXggpJYfQjWc3DDFh/JhWkfcEhKE7LPScbViOY0ptJLh5UyL?=
 =?us-ascii?Q?EHAIapO8LFDv1WpCpXLyrq1fQnrE8yEHxQih1UfhdflnzwHoIa2gcXXTC9C9?=
 =?us-ascii?Q?75QnzGm5kviZ+W9NcZmDujd8NGnJH8QE9OsWWimLE+CkQHBAu4ytCIPfPGLU?=
 =?us-ascii?Q?O62UpG6EFvsBHDCnE8HB03SJPvyeQEm7hagUAhFZl9F5GFpebp04KkMdK71z?=
 =?us-ascii?Q?oBffoD31MRYVcdlWOdIuR0zzQ4imxjfvQLyJud46yR4/p6T/mBNSV/K28cGv?=
 =?us-ascii?Q?7Ve9N0VWknpRKZ+kwl8UMta9WAs652NNJuU6tRAMnNXeXh7VncaVfVaOAnbg?=
 =?us-ascii?Q?9hCR2uTkzn7KpKUACjqUlMQcZulS77shaBiFF4d88f3PgFcM9Tc9/0bfIuRt?=
 =?us-ascii?Q?Qi3qrAJw2iy7zk3ohYNtDLoMCw5lbImMfk8wHMo94hAGMMW0ld3irvinIsyk?=
 =?us-ascii?Q?ymgmTYfeonKGkKl4efXbuOJ40kNqOK8EptQPFGeyF12cWx5nfrZvodTsA0om?=
 =?us-ascii?Q?zv7iO266PKhcEwdoem/MD4d4t8LqUq9myXYPKsYRaiV8JIUJuCMqiP9abmX+?=
 =?us-ascii?Q?Ke3u99do5KpxpL6Dn57kXe5hIBCWA3ODlF/Xw2C9POpBjszeOYERFIpT96hL?=
 =?us-ascii?Q?lz7ZarKR99vpp+ZBA5ITlzcMi0F0ZRcrJlquwhlgYQz0G389bg48bd2e3it6?=
 =?us-ascii?Q?gMJKwt+0b+NK3xm3mJWizc8HhOMwHQBrw5KaAXBt+KugjV5XKSHQaeDmmo16?=
 =?us-ascii?Q?qwtKtZdrT6nRb/GS0XXeytC9sPR50l9ZEqs6YdAxYbQfx/8CRjK+jghvwat9?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: J898rNSVi8kSUtmaOQvoTrMCY7xGRwEkFhLZ7fHuI7wwj/LE2uajjKgYICzzSE+cWnHJ71EQBq2rGWMWKALmaQfL3Bd1V0CnkUHONOAJ0G4rqucQ1HMjAKPRsakhnElEd9n4jKEyZDMns12ZWSVVMPR8EzU7SYDGNtR6l++5/z0qz/SHgou7kZnWEUvQDUwQvyUo4d2dOeqgEgmBaXJqOI8CBBElazD/8g4/olafqz1nSYAMKKMS6g295jteCw0uc1hlst+1w8O1BS8KAdYUyXC1LOVUEuxt+Hd1pfsCXdK34nuA/+fjZPglx7XJlKEz3j8foeOQHT6K1Z461iQmgOzzpVwecsjIjmlJOGlaEUA=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:qjDYFcIZ2AnNQepGNAy7LuziTS6GnA6DkA4QI95pTN0LfysXpS2I03zJei6drBJB5ezHt4372Qcumz1lCzkEbIfnhghJBCFE9esdpv1HLjrMygDTqUQxqdkIzBD5YbXzu3AKqyLvn2XFss14Bc5WX8OjI1oCKr5yD+uwagsrwbxc2Upj7/Tb45kcOJpUQUMWiF4cjwQwXid13OoCqpVfFfbkzWgABioqMcxzPN60OGGzFfGBK/Kuo00XUisQr+HQacUAjxvlolKhqjX+x0Nm7VPjC2Zdq8xAyxMOvqpVRUGnFlsmTrH+f7fYXvAomdFXSEuXEXi+0Dp2e6Uu7EgCAVraWgcdujd/xXouL9QygyVkMNS2fexhaZ/cvTYfYunl41YFj3hoPlX0AHg4OWSnKZQuLG17qssFWiCVEZHN8X+GDCLSssSEErQA49gH63yYjvrZnvn/DaATSKOtPBQr6w==;5:0/MbLhktja9vY7/qPzmkwLC/pTSCU1cx99fdqK5ZHpfmrxjpDRO/4Y47qeZzKMwRnM6X1O2hSMD3QiOzoUeIbb9siuMKmJgkK/fjXQDrWkUbre8UJPQX0THqQaFE3qQk86hsvMnL9j6S5NMkoLWxcmk6oE+cSZGO1Ni23sQZW84=;7:kSb1yOVPIgjU5F6Ng5TIHzNlW7sS7ZZVrfYL5L5x7SNulvyY1Kp64qmT7WF3JIugms4DGposmJDYsPxkBBKnqGg+J6b0PbfZrBmnbKg/DjrhCmHxuDs2zvW99l2BnTkZxM/ofB0LMq4JcqC4r5yApjjhVvn9FXTeS7rOKzuFFULD58A1w4L1+KebMzBUduedEimeERVlZOnGThOtQae5mWnc2YlfNc3clqB+9zcq+/3W622wBPR4vug3fy8UC682
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:WUiPd2OyqnGK1rMeSMPtzK78nV0E5IkiW1kZqPLuOFIZ7uro2nKgLN8Hi1HO4NUWjn5lkjtoj+BohE7f8QyD2GZltTxiAhMoF6QG+L+dGNrH83ZiiWO3YymI/FGO2M9H9j21JrH1EUUaE1YdVdSVjrEvXru6u+ZFqd9xs3Zolx4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:28:01.3092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3314d3-63fe-4e52-aaf3-08d5f8bed395
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpf_get_local_storage() helper function is used
to get a pointer to the bpf local storage from a bpf program.

It takes a pointer to a storage map and flags as arguments.
Right now it accepts only cgroup storage maps, and flags
argument has to be 0. Further it can be extended to support
other types of local storage: e.g. thread local storage etc.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h      |  2 ++
 include/uapi/linux/bpf.h | 21 ++++++++++++++++++++-
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/core.c        |  1 +
 kernel/bpf/helpers.c     | 20 ++++++++++++++++++++
 kernel/bpf/verifier.c    | 18 ++++++++++++++++++
 net/core/filter.c        | 23 ++++++++++++++++++++++-
 7 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ca4ac2a39def..cd8790d2c6ed 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -788,6 +788,8 @@ extern const struct bpf_func_proto bpf_sock_map_update_proto;
 extern const struct bpf_func_proto bpf_sock_hash_update_proto;
 extern const struct bpf_func_proto bpf_get_current_cgroup_id_proto;
 
+extern const struct bpf_func_proto bpf_get_local_storage_proto;
+
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b10118ee5afe..dd5758dc35d3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2095,6 +2095,24 @@ union bpf_attr {
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
+ *
+ * void* get_local_storage(void *map, u64 flags)
+ *	Description
+ *		Get the pointer to the local storage area.
+ *		The type and the size of the local storage is defined
+ *		by the *map* argument.
+ *		The *flags* meaning is specific for each map type,
+ *		and has to be 0 for cgroup local storage.
+ *
+ *		Depending on the bpf program type, a local storage area
+ *		can be shared between multiple instances of the bpf program,
+ *		running simultaneously.
+ *
+ *		A user should care about the synchronization by himself.
+ *		For example, by using the BPF_STX_XADD instruction to alter
+ *		the shared data.
+ *	Return
+ *		Pointer to the local storage area.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2177,7 +2195,8 @@ union bpf_attr {
 	FN(rc_repeat),			\
 	FN(rc_keydown),			\
 	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),
+	FN(get_current_cgroup_id),	\
+	FN(get_local_storage),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ddfa6cc13e57..0a4fe5a7dc91 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -684,6 +684,8 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_map_delete_elem_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9abcf25ebf9f..4d09e610777f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1795,6 +1795,7 @@ const struct bpf_func_proto bpf_get_current_comm_proto __weak;
 const struct bpf_func_proto bpf_sock_map_update_proto __weak;
 const struct bpf_func_proto bpf_sock_hash_update_proto __weak;
 const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
+const struct bpf_func_proto bpf_get_local_storage_proto __weak;
 
 const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 73065e2d23c2..1991466b8327 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -193,4 +193,24 @@ const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 };
+
+DECLARE_PER_CPU(void*, bpf_cgroup_storage);
+
+BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
+{
+	/* map and flags arguments are not used now,
+	 * but provide an ability to extend the API
+	 * for other types of local storages.
+	 * verifier checks that their values are correct.
+	 */
+	return (unsigned long) this_cpu_read(bpf_cgroup_storage);
+}
+
+const struct bpf_func_proto bpf_get_local_storage_proto = {
+	.func		= bpf_get_local_storage,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_ANYTHING,
+};
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1ede16c8bb40..587468a9c37d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2127,6 +2127,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_current_task_under_cgroup)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_CGROUP_STORAGE:
+		if (func_id != BPF_FUNC_get_local_storage)
+			goto error;
+		break;
 	/* devmap returns a pointer to a live net_device ifindex that we cannot
 	 * allow to be modified from bpf side. So do not allow lookup elements
 	 * for now.
@@ -2209,6 +2213,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_SOCKHASH)
 			goto error;
 		break;
+	case BPF_FUNC_get_local_storage:
+		if (map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -2533,6 +2541,16 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 	}
 
 	regs = cur_regs(env);
+
+	/* check that flags argument in get_local_storage(map, flags) is 0,
+	 * this is required because get_local_storage() can't return an error.
+	 */
+	if (func_id == BPF_FUNC_get_local_storage &&
+	    !register_is_null(&regs[BPF_REG_2])) {
+		verbose(env, "get_local_storage() doesn't support non-zero flags\n");
+		return -EINVAL;
+	}
+
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
diff --git a/net/core/filter.c b/net/core/filter.c
index 9bb9a4488e25..9f73aae2f089 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4820,6 +4820,8 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	 */
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4844,6 +4846,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		}
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_sock_addr_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4866,6 +4870,17 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+static const struct bpf_func_proto *
+cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
+	default:
+		return sk_filter_func_proto(func_id, prog);
+	}
+}
+
 static const struct bpf_func_proto *
 tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -4988,6 +5003,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_hash_update_proto;
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_sock_ops_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -5007,6 +5024,8 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_msg_cork_bytes_proto;
 	case BPF_FUNC_msg_pull_data:
 		return &bpf_msg_pull_data_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -5034,6 +5053,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_map_proto;
 	case BPF_FUNC_sk_redirect_hash:
 		return &bpf_sk_redirect_hash_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6838,7 +6859,7 @@ const struct bpf_prog_ops xdp_prog_ops = {
 };
 
 const struct bpf_verifier_ops cg_skb_verifier_ops = {
-	.get_func_proto		= sk_filter_func_proto,
+	.get_func_proto		= cg_skb_func_proto,
 	.is_valid_access	= sk_filter_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
-- 
2.14.4

