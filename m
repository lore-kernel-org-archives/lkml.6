Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E6EECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8D020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GLnwhvUg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Xe7Ms9yW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8D020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbeGTSgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38286 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388414AbeGTSgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:08 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhh0t025812;
        Fri, 20 Jul 2018 10:46:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=79UrqdJRtJvsS0blTmNOmoVoTagaWl+Y6xDaozbmzrY=;
 b=GLnwhvUgFDexw83BclT46AtItn8VF5AB4SnLsNbprFIbGOLQdDC+bqIlSFyD6CuB0qf0
 LQJJ+regwppdQ3tMiNwA3AYdcScUWryI4dTq2US02hRB/qvC4nOXcPBOc4AKlvfRp+QJ
 TIu9OIwR1cJzP0gjjddNOdgX/ssspgM1Zps= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80dv-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:27 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79UrqdJRtJvsS0blTmNOmoVoTagaWl+Y6xDaozbmzrY=;
 b=Xe7Ms9yWxRglddw88bVnsnNVrEQ5MXnIfNyoEr3uf+jpFiVbyfpYQkabp3sjzh0m9rxVaQhAZfmAHp5EEFP0fkAZb93bz5xyoCI2i1A3rvq1jdH7HAmfcM/fS7c8a26pLSpHfua5uacxKyLERyAGAJn+lbxAoqvG/0aziBiTEKE=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 08/14] bpf: introduce the bpf_get_local_storage() helper function
Date:   Fri, 20 Jul 2018 10:45:52 -0700
Message-ID: <20180720174558.5829-9-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: f1c80783-2fbe-4273-30bd-08d5ee68b549
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:yCvYKBh1XDnqMtCi4sSkg2IkO0JRl/YXBhiRPuiXCgBAkaFqIM1feOlybKnzXd4jbyyZa4yWahsfUZWCowfIg6H4enpFUlDDzc4bKGXPddqvRDv+zZVPkqUAboAdkREdP4VQDBdc/bjSblCIrZLeq4KIINcG++BHjHcSAuG8PeiwRokx3oV8WbTUUHk0AIExLGTcATHRfvnps3uMJM5stkPRM9e0KIoaK17LYbVpmSPoPGD+lHrufTUYduz/K1Zw;25:xsYlGnpYzqH4W6kKb9c9U8NIVzqzcFyPXGX/i9LO7kT9/bbaaYq9UPOIpQAtjCTUKVzVmpg9VaXL91HveqXHddV4u3YpkUVqgEJoXvzpBB22lVgnAsk+0kDCfmvZlJDsqY/5pcDlwicNERq7TfsIGon0NdIneuIjhUlEtCyvDMNEGpNv84JRtvbpFTKTkuu2mbij/qnDZ6WqDDMx7atkjmeUT54l62pGdb/iUrKVtJecemPQ9ar0SnCis0KZHeLBMEHYvLyhRmv8vqDhQjRF3AL7Wa7s1o1dVbQWxvZwuPF4dK59GT1oOgJZ5rvbEpwt48/Kc7VvlcaLcfM+cqeccA==;31:hY+qm+JY8IjUUSKCBPArrsMbDKlyoJHknhcAMT4r6mTCjHxKHffdZ6a+KoMXaHnOVm/Z46F5HusRtEG5G2ySPsAs9WhVOyWxK/dFnbHEbNrOD8Kdi9A4de5jXxi4RyubKZk3GRvQKDARmcgFSbcmT3tJ9Hi5io8b1gsE22SJLznuPwWhgccnUjHCBj0CZCFXy1+BtacV88UDwcWWXrlf/IYeUVDPjo7cXzsAsz+UCS8=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:P+O6N4ni+Hpo8gFwjN/RagY+BoPTTSi8QVAtU+RAFAy3YC3ys2PyePzca/JSLXLjO0pqsMf6FfNkL5p4JRSIE7RsG/cJHtgufQJs2+jln+hdBvZ++9SqgJ0j8AI/WUa5maMyn/GMZKFoa9G5JSA7VrEbyBf0BpCGHd1FRcvtYJiQicjc1J0aa26XAv6YA2J/h6AfD9CvzMTmkLod9FfBG3sy8Ozy83s2Kspn8KDnzatBI3TAA3eKj9nh+y1hYxZ2cfHtuOd65nXyk8eQ9OYPE8MVs8hTxscov5YNs/Sytm3alhbGaBF9A4uWSlHBl905U5/qEDyXRaI5XuBY/jkExz0FvEO3mJjVT8rhUBtpJNz9yiHgcPVXaj0heFyBBGXDWSC3JnYRjeJGiyNj0j2uK7C51ERw4mY4+ky0bAY9bz+rZKMjjn8uih47kSu1MLJRhfXzK/701/hYjA5Ad71r4lgI07JHrX31f1uxwCrC6ME7waV0apc0T9yMo84AQkmc;4:M2Deof5UXLi5WUQGV5A5jkJl9COW91xxx/CLlFeUHKs4O7yJIM28E70QHtppguSoYgfPd2F+TdrxJB4D0wlufu8e4RagrvfaYoniSK8FvrzNLWDZmQFJiDSCd+oPog/o1GcmBYSVAgjMVuVKzwjhMjQyKpnZJUfbRfGuMBnc6mJzu44V81xZl212S2wPuoX9Lxpp2BAZX1+XEGf5JYHdVtLg9dazqFJIl7kcMvZUZlPhT92nFW2cgWn6xfxJBMBX/R7VLfy0Rs2ONtYoiXXp0kJYsKS2YUPIrbD5QbDAgxt2Oj5KprftZX0/mE5y1kITppcgnDoBEK69v/kpBxJ7Kb5uXKywIDpJyI3m9/ZzA98=
X-Microsoft-Antispam-PRVS: <SN1PR15MB017528D406ADAA9FE674FB29BE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(575784001)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:4M9VT6chl0VDEsT80X4TzwJov5t49Q5qDJmnWq+LN?=
 =?us-ascii?Q?HsybXaP3W1UZQR3k52BErXQh3vUyliHE5jGH8iqPRwgtCc7SStJ2plxK5iQV?=
 =?us-ascii?Q?7s/5SJV5IeWsOZCCBHImfsXqyo0W8yT5kvXFVx10xg6Eewm37MnA/NkwplKH?=
 =?us-ascii?Q?qAjtrb3HiwgBopbWir1zY6c6vHbJEBKfa/NhD3NMfmKpcdRdVD+CyYZWgj2t?=
 =?us-ascii?Q?tR2hWLkSmySrATocs6pJfu0D1rc0BiNyVAw28Zbwzc81CKw3F4LFbVQfxaFC?=
 =?us-ascii?Q?ZqI7n34aWXdnpuq8/OXIuKiM7p0zghmyYIc2wxXB21e/m04pn6IxotGfBSlk?=
 =?us-ascii?Q?3e1KTYflV21PUT83H6kt/p6D6ajhK2ImDH9h3YLNPULfrOxMXm5K/3BT9nBk?=
 =?us-ascii?Q?7b3mJk5NrAfB2D+GxV/7xJBrwmOaMk4XAQ1VqMVbhsVQe5DtYTIK36kwkMrz?=
 =?us-ascii?Q?G11SEeIYbsEqpbI+JxpjkZe3B5D9oK7HvuXIPADsU2KN4chLbjjrLdaQtp2I?=
 =?us-ascii?Q?kddKbOiBJfcHq7BL8cPducy3eZo6IrlN6CMT9CIN+0tzTR+wiPw40aozIKIA?=
 =?us-ascii?Q?ljVo8njFWjWJggVEKOP2wdRm9HTyQghw7w2QJFVpcVusx4AavasZDjNoHWkx?=
 =?us-ascii?Q?Mj8GnCVUqfvSipkBJB7BOxlINHbbMAaDE5Pd2yqzH8Po95LzXcqGEA8Ocm14?=
 =?us-ascii?Q?APsJfzupEyNLC7L9ots8GxxJD4wbXD3P4cO6K3eH+z4not+66Ve8JGrLQz8l?=
 =?us-ascii?Q?AR6hM/UM4kNsCVXKsp2TcWDNf8Sb7MAd1a97gqOSw/I/0zTl7aZuv5IVvzEA?=
 =?us-ascii?Q?4/eRUhJsaO4YhkUCkvxjWZR7JcQif5Hp8KqM5hvZ1FnJiI8iHnltyCLtjFqz?=
 =?us-ascii?Q?ZasrxbHMj8Hcplvsin1y7esHbcMCnxfJ/ioackUnpqy0rcfDyCP1OldEwalt?=
 =?us-ascii?Q?MQCzwt5YK6tRXSzw7/+59cb6sSkvnigK2CMoxX2wklAv/sgAA+QTVNp0GJeh?=
 =?us-ascii?Q?8DXelzsgsFO1swh7NGHa8KjdV5d/BNlOv9OsUyuznDYngOKPPmryDE5XWFWi?=
 =?us-ascii?Q?llY32NtO7aXfc2qi+zEyIqWffx/5v+MXL30q+WMADbUhIHDyB7AjomnU1MIc?=
 =?us-ascii?Q?/U9YKab0FtwtUl7KvzeHBmZyAdii8HwAmLUaFLl7+XNCSjv4suvvsH//IXX6?=
 =?us-ascii?Q?yk6UPYHzxL4Yh2AZoHjuoyzz49NToMpgQRug9EN1u2pZsbpGOmjibqwzCRxP?=
 =?us-ascii?Q?8Ce+kZ0OLmSqyO1+gZiPJWMphYpKK71+pFz4XUJZHCAW1/c/mlgBEXIoWtbl?=
 =?us-ascii?Q?H+PSNO8uOSDRYJM2RctepI=3D?=
X-Microsoft-Antispam-Message-Info: cXauGSuGG3idvq8wPfqie1j72SXhjC1031A9Gg1FjVHFDFZwzG+AZTHbNQd+aSP3nUWPTa4H98WobcW61SOiL9POSIEVrDd+GMH6J44XQa7xnPRDnx4XRC6ylUplhmCEcL9FkFjU21lXWPE1kMHgKdgQLmJV8gcgbjhBbu+BkOm/XT+TZmWdeqKOHEJSkHWLh6xO6dyRVN45GD8Xt6ocvnidlMeAgBwwGRPKAWNZ+W88YNXP4++v1g/pTx4f4RtzQ9IPvjHUoVD784qVesehup/FhYsJHgyysv4MT/8wbRZs03vpQZHF04chW5dHGVd4sqKEvQ/iP3LxVJ3szoMisVsDAPSifHl35gRpcYi3jNQ=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:5tbU7RqMYXZ0eqhjT2BdrmyZ5JTrhl3Zyih79G2PUAdQIliHs5e3ZR3VBz8o1KtJykx9JTSAEwba8HQXfzXpXm6+YUUuKZfiV4rPkJDmOFdyiNvqbZZ5YTu5HqvjY1Rjq/OEcfOKqm1TL21o+F6mURM1VqpfNw6t1UeR1mpZnuKGLPyOk2d+1xqJ0GBiGLThK7oHwiYbqIV+HbHYH3m/Y4ZMFF/C/MhWHs/eIRYf60Qu/GNEyLItF2mR275imK+g9wuGa4XEHy8pN8pSjmG3SygILfHKrc+YrcD7fVqicnhK6nbeHAiFd7lRl6t3Xb4oZt5g5RRUglg/xfLV+uwOoMhfatp5BmtZ0dWrFnD50Qeh3e5kgLn0uGH2MwTdg6QrN6s7JzXXGEhUT+I2eNzAXXIV/IgYTIn5dvpGCIKi49fsGKUw90Xk4+ShS0zaVzX11iw5BPXGEBVXFLijMKDgUQ==;5:ESVJh4beYVs7VxgicFf5ft1AHi1EB4yExxeTBu+O85A/KxjgcEH2Gf/nxzHzSB23LWtGbf28BTpEj8qMHx4qxwW6VxCn63ITZUHyw0NHvNjaqLmiTaDfy8zc1cAfefG+Jf3wtLw9hSy7MLU2Qx37d3RVgOldZ4ZByAbNDz1hh6Y=;7:j1rSbB72P9AjaGHBIVt3YSrADLa1p90aYozVmw+cSJKKeuw4yMoCpBGL2pbfx9YxBZVXQ18MpEdLbKyPY4gSJFna2LjqLFEi7naFLHanLL11pvZG7qq2WgmWW4kzrOYYCMHxM0UqZEV5DHpqjYfwC8RGozfMuGDpQ7CUQk3fduFEhCOaQzR6W9ex51vLGyYMBPA/Ny1l0+uAkPS/8Li/In0w1sThrvtpmYyD/Gu97Ujsf0+W13BycJbsno10RB2Y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:9bSfy9j50KjUjsp6qyDC7dyvBiHxbcrPJYLC5n8636Cc0JMbgHYHbMxD+kgEOuX7KmLWb4WblXsfWrn2urhd9kI67h3OlUVPn0MAXzR+qY8Tfrf+PTtKoHA9QP0Euae330CvhdWEOOvtw9s530aNSbF7sOoIw3V9v1O3kF2QDc8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:22.1179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c80783-2fbe-4273-30bd-08d5ee68b549
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
 include/uapi/linux/bpf.h | 13 ++++++++++++-
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/core.c        |  1 +
 kernel/bpf/helpers.c     | 20 ++++++++++++++++++++
 kernel/bpf/verifier.c    | 18 ++++++++++++++++++
 net/core/filter.c        | 23 ++++++++++++++++++++++-
 7 files changed, 77 insertions(+), 2 deletions(-)

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
index a0aa53148763..495180f229ee 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2081,6 +2081,16 @@ union bpf_attr {
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
+ *	Return
+ *		Pointer to the local storage area.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2163,7 +2173,8 @@ union bpf_attr {
 	FN(rc_repeat),			\
 	FN(rc_keydown),			\
 	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),
+	FN(get_current_cgroup_id),	\
+	FN(get_local_storage),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ac480086effd..27236346900a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -681,6 +681,8 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index 8098e39f825e..609ca398d7f1 100644
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
+	    !tnum_equals_const(regs[BPF_REG_2].var_off, 0)) {
+		verbose(env, "get_local_storage() doesn't support non-zero flags\n");
+		return -EINVAL;
+	}
+
 	/* reset caller saved regs */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
diff --git a/net/core/filter.c b/net/core/filter.c
index b9ec916f4e3a..269e5bba119a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4675,6 +4675,8 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	 */
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4697,6 +4699,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		default:
 			return NULL;
 		}
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4719,6 +4723,17 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -4839,6 +4854,8 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_map_update_proto;
 	case BPF_FUNC_sock_hash_update:
 		return &bpf_sock_hash_update_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4858,6 +4875,8 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_msg_cork_bytes_proto;
 	case BPF_FUNC_msg_pull_data:
 		return &bpf_msg_pull_data_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -4885,6 +4904,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_redirect_map_proto;
 	case BPF_FUNC_sk_redirect_hash:
 		return &bpf_sk_redirect_hash_proto;
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
@@ -6687,7 +6708,7 @@ const struct bpf_prog_ops xdp_prog_ops = {
 };
 
 const struct bpf_verifier_ops cg_skb_verifier_ops = {
-	.get_func_proto		= sk_filter_func_proto,
+	.get_func_proto		= cg_skb_func_proto,
 	.is_valid_access	= sk_filter_is_valid_access,
 	.convert_ctx_access	= bpf_convert_ctx_access,
 };
-- 
2.14.4

