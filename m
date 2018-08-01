Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EA2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5B320862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="K0kRzEHt";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Rh6MPZAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5B320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbeHBA0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38782 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730632AbeHBA0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:43 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MYwxR020856;
        Wed, 1 Aug 2018 15:38:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=jPzNxfiGslEUr1V/kMxhiLSEwVUauwtLenKVVNPogIc=;
 b=K0kRzEHtHZQSgBgT4k+lcuo+LRuOsSt/aBuhzsQ5BQ4XEofAPWKu9Fu2oJOc27PZPPQ8
 dP7MjtYAhNkaYjU87LNhDKOVeBwYoVM2cYIXLVCwMKxYo1z/L2oLfuULV6kTdzkCueDr
 nwFTpJG+QKbyLkivx5dCRsTOKMBNWFCl5TI= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkmqb05qg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPzNxfiGslEUr1V/kMxhiLSEwVUauwtLenKVVNPogIc=;
 b=Rh6MPZAzMFZcwIx+JmdaZ737ak8lsT4XituNdhWziHRo0NI27Y9GXRMylSOP0EZVAws4Llotc9GsDDYIN+Ffm8moIjlblmtbCqTvk0KuD8srcqWq/tzjKtqO3VzVH1ddye+fCU/W6fWFAnHQ+U/lLFNcwaw25jRzD1teKJktIEg=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:15 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 02/14] bpf: introduce cgroup storage maps
Date:   Wed, 1 Aug 2018 15:37:28 -0700
Message-ID: <20180801223740.11252-3-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801223740.11252-1-guro@fb.com>
References: <20180801223740.11252-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de74bed4-2b2e-4c01-d5d3-08d5f7ff7924
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:xxAswIrMcchwvSTdBE9gyOQNbMHnOthnZHhuamEVx5yQuJBuMGj2fVo2cBrBsx8HV0gzKDKxrPfLVUCq2JBD4qn1rWScsncZrDU2NLC6BtUD+gsNPmgiHNszazgV9WX/ys89Q8G1iyr6BMp+MkN3bK5mndE5xu4gsHay05DCO5EXhwnjlMC9KzZgWKhmeOWHc9w7Zzu3eZfAJSQBZOJPjZnYJXZYZ7WWHVV4O7c8vvwrA0V952jjSs1E/2IXg/x2;25:GCA1fROqlMWtXzksNLWy7L2jQ3Nw37ToF8Cx756GLsDDMYzIDRVKwGQeeWtLH5967XXSHwQ7poOkfjJsMnq1/NOm+ASH3gq5lXLY+sFNs38I0btNNoaYj9HYOAWJMQDPT3XSDfZ6FEW9HFLsNaHmNKvHQORtTExp5nkT+Gqy+t/QdpSBDBo6/9Pr1C0n9KtkKFcrhkMpaSEJdCe9GiRPA5nkkgZq0Ab0KCN/sgkjD2cw5nOLLvASvGLxrz8iBS95jQYHYS308d0klDNShjbw5p9BhgVaI+rXFeqFrLNmWfKacTkfTAwFrHxBWPdTsAcwyL8YDbpZHYcGR1wGrCxyPQ==;31:KMJNLRZt0XVSaDbwZoD2b/5dp+tCxv04Sqwg6+yj6UVMsavVT3UJJrOIq3Q6R5XOk++2g2ZbzMugLAYoDwFXEqhkgrwGpjXTfM9KTddGMRL9o6rtn023t5rETo8iW0WZ3v2KgEXJ2yjwv/DEs7yHDlPYJTp5uvwY2OOtImIEExKw9hsLUIU0hGdXCJ2yuLkHCTUNeutpG6DHncHo+1/LO3wymngvhIIdSVLbx4N96vc=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:g7I2974NlkcLH+gHAx4296BEKEdzhxIWhwT315EbqIhOoOvQMgrsqWtGq7IymNN7sYodDCr465zwdcITs3aI0mnaC3umw0kMMwxrBbwHS3GEWLjaCcEidz18Ow/6pvjs5PePOj1xehMbc0A0vj0bPplIcuD78TtYw1OwDuuZpdxqF28NoVz2V5UeJuwHgiMgVUmTOBc5g0MSz0L1MkRL9Xgu0FBmdN7/P4nm34JHSJleyW+mLP/SDQNIgj7KbB2ABw2461RtzWQCk6QNj8GNmlYlfjwTfgH9STZD8Frq2deI0rKxcMbSPgp3z1bMjyU+UrGeA2ZEg8WxEPKHmEvLC64tS5lNRM4HekzpA+Sp5NGpJgkDO3avzkPLqhjeB5DweQYnqW2FL5aCoE3vtp4sHI1NOsKVxiBgCAZuAyjY27zEal9HU9PFi/0NzUeEYCEaKu71LYM3wBelatHQbfYfSK0l/PpzzEbpCCTGAYD8uV+ws64sa1Y15FgDWzWy31sk;4:wm3LgGfN4e9FChacwn4ZC5A97MBamdRqZU80sA6fxOEr/tvXSuZlD83r9e9/Z3dFb/Z9nykcbQSJC2AbthBhKzrF0N8o1y5K4v+H4nMVf7g6fwu/otIXrgZKkoKHOKMoY2SFdNChH6koeV2DwpoFT5NxcMLa4fr/7sIPBlY4l33OjZuPGc/m6tXa/mGIw/bts42fPWblqR5hC8Mn4xY7EoEuWHlj4WSNrKS0GdIE/mcYrtXn2ZKyzz3yoLKQMcx7Qowh0uOyE52SEYwXX69opEjwCZOIvv3rsQb6fo8Oait/SLKorSz5N+gp2mouX3xP4+Xh/D/R1yJohLknPjIsUg==
X-Microsoft-Antispam-PRVS: <SN1PR15MB017612F1B40BEC1F0CF62AE4BE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(575784001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(5024004)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:J6N9eQ/K58RBeSiWU0tglLsX2VG5z5xvSeBLZt4Nf?=
 =?us-ascii?Q?+CyIDDSUlAYzKR7X9j9ejAnLu0Vml/1w8hCnjdsI0Q5tgd2dmwoJH3sqSysz?=
 =?us-ascii?Q?qxzZvaY68vkCKkLhXO6Uvr15VR8dztrKmJZzEy/KGEIzy9IpeGJLAiNLt4/V?=
 =?us-ascii?Q?e0qCX56LIGxToQwSp3of6yytxhMUtlWAjlaYrSQ1N0xA6kByhH3Ya5F1AtWG?=
 =?us-ascii?Q?wG1MmqH5oU3lBzRvyWEMfXq2JOuCZyjZR00XUS8162YavWAbO8hz8avuAzpH?=
 =?us-ascii?Q?Zy8xw9Vma/R1+zsa5zbscBr8daQJO9l1zdJMSQty0bw97w1gwlCG51Ns9NLP?=
 =?us-ascii?Q?iWM4xHm0sLuazYjmw8TmdMAUsy/LWZGI3cN+WjScQR7IflnwCaoPG2ivl+xf?=
 =?us-ascii?Q?XGO8mkK8sd4h8ovdVFCnsxqeOXrek4O2meUE3ROzntTXViCszHOpUbCmH+gR?=
 =?us-ascii?Q?h7f3EgHleiTO/WUqoYUrgyVXw9dDaNPuqTW0q1DU63n+PeWu7+8SyoO84jrO?=
 =?us-ascii?Q?lg0adu7S8tJOZHB3Ar6O+RESNXD3Nfgdd6ddT7ksPnALWz/u0kHx/Txs85h5?=
 =?us-ascii?Q?ZU+pi2dkhRCcv4oB7dBqASoHutt6hkb7xf1dOCcPjWIyNJuIxtfOYIDyWJu1?=
 =?us-ascii?Q?Nn1lnfiCXD0uVvSUk2M65pwaaIIxhl+w9lyedGy3qqVvqXSamosj9thmyBYY?=
 =?us-ascii?Q?lJ2l3VFDIcXUfKt9SqJC9W9UNelSRsDa2HpofP7efZJ0Yhjq6j7wzdrRI/eT?=
 =?us-ascii?Q?TA6qTIc0YbIjtAKJZlz5bO7WuuGPAwXkeQJJHxAfq8/g76wNzT5HW+uuOZ/p?=
 =?us-ascii?Q?dsPc7rWj5mLWx8DDpKlWpRf9UGyiqXq+zeNbd9mKdsI/8DIXlnKY0A/mt678?=
 =?us-ascii?Q?QtcWSZxzAiUChK4nTcTMgStL2sbScgKCME8p38qf7MITr7aRNXjIwn6qaeWj?=
 =?us-ascii?Q?8wbdNkiWmK3LW7Xq25BCkdrMdCtsDslcW39eJapFz4iRLtpUFwsRtx7nORHC?=
 =?us-ascii?Q?QmDvGt44Hy3501RlW5jyLeocuOtH62I0weIgecTBngQ6x6N/xA+D5vDOL+YZ?=
 =?us-ascii?Q?xckirHyfKtNj67ySERbzg7vZ0iby4Vrn5J7S2cYKcopNhDseK6f4bwL0V5vC?=
 =?us-ascii?Q?rqe1p4V1PhEIDs6joO+fS0/QdIu0ucEmjwlQXKyW4AJPXOtRT8Pa+5LRAPpd?=
 =?us-ascii?Q?UFhqWtOIezOyc0GuepHGHAR/u8J0yKr9dT2UAnJT5eTr+IAxXNNwhJ9TCtTN?=
 =?us-ascii?Q?Fask5a5vyNuOfu2dw45taz0Ri01H5FWXe+qaf0rBXXbofRNwuJuf26o9z1IC?=
 =?us-ascii?Q?X5w8p5T+Sn5FX8ezcILUC97xku3RtHRgshyDq60DY66?=
X-Microsoft-Antispam-Message-Info: i3hHmjy2MxXtnclw21Q4m4Aek/UaEOcHAH+EqrE1Rzbc5XKtN7rZp/URJxQqPUY2I1D+5Rvzpeaf3tL87Al0lA6Hw8aRgqcizg7lI7CRgETmFXGwZoKiM2etJ9peHgTCAps11tbo1m9702UITtwrw6Gyatku2g58X2Gh8iwW6MyGVbxa0CBrhoCyadGEuGQc1BHJk4nBnBM+76diP5w1cWSmZU0YAEZVOPfv0PenuZhqayFeHMkqfae77tNET2kC2gsx9iX9aeBFBRqlKAvdTJlIEp/RH3AEtYK2hgESbc2lSJXsGon/3LvXiLgrV6Wxqh6qhd/zoGunFhtz0f/XoKkWwmhm4QfX0z0WzjCBf6I=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:D6h7ZkfmRzGgshiqY8kMQZRVBgGF2ci06OsdDd/ztvRIbAj3e6jOQCjEnE3n9l+Xe2rDsdQp+OLEb0kSwJgO+3Uzkx2wx7b03+d5NVf0xqTdYbLR6beI5X1mviKdzg3vZyZiH0WHhYxmSo1z9bjAV5sahr7jUEs6269dvPp6zhC6wwsL+BcXmnuzNf7MuoHZt4O658ZqgIR6iZ/FM9yd7oJERixiDS40EmD1vM/3woPJCnXOFvI48mbNw77gC5Q64IhMSY8edkPkHI7W+3pWFrg0mRutIBAVSz62jofQrfjrrdkZILGMkljjVza1fuv8xcAa3J4/+CVLfclwWBvMWFq/vPc0UyPp41Ou4dqOqmszULrKPnEcttN2KoFNjYv+nvX7LQUEwjAm/mCKEAeDmDjcvTmKNX2uZF6n6ylIxrgxMKqksr4bE46SiHtLHVIcHibjhOfw3vXl1Q3MvvCblw==;5:Dw024SuzZCHEl2A6UTXYM5g3omhNz/bd4+kcDUSzwuTz0NdiA9N58IPGBt2sUptVBbCCVskPFyonmKzq7tPyQkpvihyGtyXunl4DZx1dJ7YkB5wjrfK/sGo6u3TmhSw33d0m65V6inQigDzgPYPekzJV/072ZxVuI/iNydaCRBI=;7:pSAhxRql5TQAZ6wueIQHP9c8mSdGt4ShbuBjyxkVqaLqqFWJ4dNXFPliqN5Scta78QzAQtEyOQGM84IletyuBaT3xS6XbqChelZR/0hKYKtR52X5zIsZwqtFq6vciOzVGRAPj9FpJUN7SXcczDgWzbo0WMU7oBsczbXxrD4Aqhm/D34P9lGaWfpvIrz5hNIKmf1xUfqoxYMV51k7qw1hnZC+Ov5TFqyQ5uX6QVxs1/Q2yPHYes3/lGAM0pxDdb+E
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:IP2K/nQNt3TiQjbYosU0PxkUDLysyFz4/RiD2xQnQfy9dKzzMCmIT3YSVRfFwvFlGlkUwulMl85MmaBO5ZUBSA6w2f6dQ2HhJSzU2IHt+dCNC444i7Joz0nHvB9gTW7tgl1gsMXgNjIAcL/ls0hcA1wjnaK+6XMIIyDhqUZwH5M=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:15.7765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de74bed4-2b2e-4c01-d5d3-08d5f7ff7924
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces BPF_MAP_TYPE_CGROUP_STORAGE maps:
a special type of maps which are implementing the cgroup storage.

From the userspace point of view it's almost a generic
hash map with the (cgroup inode id, attachment type) pair
used as a key.

The only difference is that some operations are restricted:
  1) a user can't create new entries,
  2) a user can't remove existing entries.

The lookup from userspace is o(log(n)).

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  38 +++++
 include/linux/bpf.h        |   1 +
 include/linux/bpf_types.h  |   3 +
 include/uapi/linux/bpf.h   |   6 +
 kernel/bpf/Makefile        |   1 +
 kernel/bpf/local_storage.c | 375 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c       |   3 +
 kernel/bpf/verifier.c      |  12 ++
 8 files changed, 439 insertions(+)
 create mode 100644 kernel/bpf/local_storage.c

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index d50c2f0a655a..7d00d58869ed 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -4,19 +4,39 @@
 
 #include <linux/errno.h>
 #include <linux/jump_label.h>
+#include <linux/rbtree.h>
 #include <uapi/linux/bpf.h>
 
 struct sock;
 struct sockaddr;
 struct cgroup;
 struct sk_buff;
+struct bpf_map;
+struct bpf_prog;
 struct bpf_sock_ops_kern;
+struct bpf_cgroup_storage;
 
 #ifdef CONFIG_CGROUP_BPF
 
 extern struct static_key_false cgroup_bpf_enabled_key;
 #define cgroup_bpf_enabled static_branch_unlikely(&cgroup_bpf_enabled_key)
 
+struct bpf_cgroup_storage_map;
+
+struct bpf_storage_buffer {
+	struct rcu_head rcu;
+	char data[0];
+};
+
+struct bpf_cgroup_storage {
+	struct bpf_storage_buffer *buf;
+	struct bpf_cgroup_storage_map *map;
+	struct bpf_cgroup_storage_key key;
+	struct list_head list;
+	struct rb_node node;
+	struct rcu_head rcu;
+};
+
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
@@ -77,6 +97,15 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog);
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type);
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map);
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *map);
+
 /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
@@ -221,6 +250,15 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline int bpf_cgroup_storage_assign(struct bpf_prog *prog,
+					    struct bpf_map *map) { return 0; }
+static inline void bpf_cgroup_storage_release(struct bpf_prog *prog,
+					      struct bpf_map *map) {}
+static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
+	struct bpf_prog *prog) { return 0; }
+static inline void bpf_cgroup_storage_free(
+	struct bpf_cgroup_storage *storage) {}
+
 #define cgroup_bpf_enabled (0)
 #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk,skb) ({ 0; })
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5a4a256473c3..9d1e4727495e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -282,6 +282,7 @@ struct bpf_prog_aux {
 	struct bpf_prog *prog;
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
+	struct bpf_map *cgroup_storage;
 	char name[BPF_OBJ_NAME_LEN];
 #ifdef CONFIG_SECURITY
 	void *security;
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index c5700c2d5549..add08be53b6f 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -37,6 +37,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_PERF_EVENT_ARRAY, perf_event_array_map_ops)
 #ifdef CONFIG_CGROUPS
 BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_map_ops)
 #endif
+#ifdef CONFIG_CGROUP_BPF
+BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
+#endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_LRU_HASH, htab_lru_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0ebaaf7f3568..b10118ee5afe 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -75,6 +75,11 @@ struct bpf_lpm_trie_key {
 	__u8	data[0];	/* Arbitrary size */
 };
 
+struct bpf_cgroup_storage_key {
+	__u64	cgroup_inode_id;	/* cgroup inode id */
+	__u32	attach_type;		/* program attach type */
+};
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -120,6 +125,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CPUMAP,
 	BPF_MAP_TYPE_XSKMAP,
 	BPF_MAP_TYPE_SOCKHASH,
+	BPF_MAP_TYPE_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f27f5496d6fe..e8906cbad81f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -3,6 +3,7 @@ obj-y := core.o
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
 ifeq ($(CONFIG_NET),y)
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
new file mode 100644
index 000000000000..fd5edabc48b3
--- /dev/null
+++ b/kernel/bpf/local_storage.c
@@ -0,0 +1,375 @@
+//SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf-cgroup.h>
+#include <linux/bpf.h>
+#include <linux/bug.h>
+#include <linux/filter.h>
+#include <linux/mm.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_CGROUP_BPF
+
+#define LOCAL_STORAGE_CREATE_FLAG_MASK					\
+	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
+
+struct bpf_cgroup_storage_map {
+	struct bpf_map map;
+
+	spinlock_t lock;
+	struct bpf_prog *prog;
+	struct rb_root root;
+	struct list_head list;
+};
+
+static struct bpf_cgroup_storage_map *map_to_storage(struct bpf_map *map)
+{
+	return container_of(map, struct bpf_cgroup_storage_map, map);
+}
+
+static int bpf_cgroup_storage_key_cmp(
+	const struct bpf_cgroup_storage_key *key1,
+	const struct bpf_cgroup_storage_key *key2)
+{
+	if (key1->cgroup_inode_id < key2->cgroup_inode_id)
+		return -1;
+	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
+		return 1;
+	else if (key1->attach_type < key2->attach_type)
+		return -1;
+	else if (key1->attach_type > key2->attach_type)
+		return 1;
+	return 0;
+}
+
+static struct bpf_cgroup_storage *cgroup_storage_lookup(
+	struct bpf_cgroup_storage_map *map, struct bpf_cgroup_storage_key *key,
+	bool locked)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node *node;
+
+	if (!locked)
+		spin_lock_bh(&map->lock);
+
+	node = root->rb_node;
+	while (node) {
+		struct bpf_cgroup_storage *storage;
+
+		storage = container_of(node, struct bpf_cgroup_storage, node);
+
+		switch (bpf_cgroup_storage_key_cmp(key, &storage->key)) {
+		case -1:
+			node = node->rb_left;
+			break;
+		case 1:
+			node = node->rb_right;
+			break;
+		default:
+			if (!locked)
+				spin_unlock_bh(&map->lock);
+			return storage;
+		}
+	}
+
+	if (!locked)
+		spin_unlock_bh(&map->lock);
+
+	return NULL;
+}
+
+static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
+				 struct bpf_cgroup_storage *storage)
+{
+	struct rb_root *root = &map->root;
+	struct rb_node **new = &(root->rb_node), *parent = NULL;
+
+	while (*new) {
+		struct bpf_cgroup_storage *this;
+
+		this = container_of(*new, struct bpf_cgroup_storage, node);
+
+		parent = *new;
+		switch (bpf_cgroup_storage_key_cmp(&storage->key, &this->key)) {
+		case -1:
+			new = &((*new)->rb_left);
+			break;
+		case 1:
+			new = &((*new)->rb_right);
+			break;
+		default:
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&storage->node, parent, new);
+	rb_insert_color(&storage->node, root);
+
+	return 0;
+}
+
+static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+
+	storage = cgroup_storage_lookup(map, key, false);
+	if (!storage)
+		return NULL;
+
+	return &READ_ONCE(storage->buf)->data[0];
+}
+
+static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
+				      void *value, u64 flags)
+{
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage *storage;
+	struct bpf_storage_buffer *new;
+
+	if (flags & BPF_NOEXIST)
+		return -EINVAL;
+
+	storage = cgroup_storage_lookup((struct bpf_cgroup_storage_map *)map,
+					key, false);
+	if (!storage)
+		return -ENOENT;
+
+	new = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+			   map->value_size, __GFP_ZERO | GFP_USER,
+			   map->numa_node);
+	if (!new)
+		return -ENOMEM;
+
+	memcpy(&new->data[0], value, map->value_size);
+
+	new = xchg(&storage->buf, new);
+	kfree_rcu(new, rcu);
+
+	return 0;
+}
+
+static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
+				       void *_next_key)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct bpf_cgroup_storage_key *key = _key;
+	struct bpf_cgroup_storage_key *next = _next_key;
+	struct bpf_cgroup_storage *storage;
+
+	spin_lock_bh(&map->lock);
+
+	if (list_empty(&map->list))
+		goto enoent;
+
+	if (key) {
+		storage = cgroup_storage_lookup(map, key, true);
+		if (!storage)
+			goto enoent;
+
+		storage = list_next_entry(storage, list);
+		if (!storage)
+			goto enoent;
+	} else {
+		storage = list_first_entry(&map->list,
+					 struct bpf_cgroup_storage, list);
+	}
+
+	spin_unlock_bh(&map->lock);
+	next->attach_type = storage->key.attach_type;
+	next->cgroup_inode_id = storage->key.cgroup_inode_id;
+	return 0;
+
+enoent:
+	spin_unlock_bh(&map->lock);
+	return -ENOENT;
+}
+
+static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
+{
+	int numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_cgroup_storage_map *map;
+
+	if (attr->key_size != sizeof(struct bpf_cgroup_storage_key))
+		return ERR_PTR(-EINVAL);
+
+	if (attr->value_size > PAGE_SIZE)
+		return ERR_PTR(-E2BIG);
+
+	if (attr->map_flags & ~LOCAL_STORAGE_CREATE_FLAG_MASK)
+		/* reserved bits should not be used */
+		return ERR_PTR(-EINVAL);
+
+	if (attr->max_entries)
+		/* max_entries is not used and enforced to be 0 */
+		return ERR_PTR(-EINVAL);
+
+	map = kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
+			   __GFP_ZERO | GFP_USER, numa_node);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	map->map.pages = round_up(sizeof(struct bpf_cgroup_storage_map),
+				  PAGE_SIZE) >> PAGE_SHIFT;
+
+	/* copy mandatory map attributes */
+	bpf_map_init_from_attr(&map->map, attr);
+
+	spin_lock_init(&map->lock);
+	map->root = RB_ROOT;
+	INIT_LIST_HEAD(&map->list);
+
+	return &map->map;
+}
+
+static void cgroup_storage_map_free(struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	WARN_ON(!RB_EMPTY_ROOT(&map->root));
+	WARN_ON(!list_empty(&map->list));
+
+	kfree(map);
+}
+
+static int cgroup_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EINVAL;
+}
+
+const struct bpf_map_ops cgroup_storage_map_ops = {
+	.map_alloc = cgroup_storage_map_alloc,
+	.map_free = cgroup_storage_map_free,
+	.map_get_next_key = cgroup_storage_get_next_key,
+	.map_lookup_elem = cgroup_storage_lookup_elem,
+	.map_update_elem = cgroup_storage_update_elem,
+	.map_delete_elem = cgroup_storage_delete_elem,
+};
+
+int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	int ret = -EBUSY;
+
+	spin_lock_bh(&map->lock);
+
+	if (map->prog && map->prog != prog)
+		goto unlock;
+	if (prog->aux->cgroup_storage && prog->aux->cgroup_storage != _map)
+		goto unlock;
+
+	map->prog = prog;
+	prog->aux->cgroup_storage = _map;
+	ret = 0;
+unlock:
+	spin_unlock_bh(&map->lock);
+
+	return ret;
+}
+
+void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *_map)
+{
+	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+
+	spin_lock_bh(&map->lock);
+	if (map->prog == prog) {
+		WARN_ON(prog->aux->cgroup_storage != _map);
+		map->prog = NULL;
+	}
+	spin_unlock_bh(&map->lock);
+}
+
+struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog)
+{
+	struct bpf_cgroup_storage *storage;
+	struct bpf_map *map;
+	u32 pages;
+
+	map = prog->aux->cgroup_storage;
+	if (!map)
+		return NULL;
+
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	if (bpf_map_charge_memlock(map, pages))
+		return ERR_PTR(-EPERM);
+
+	storage = kmalloc_node(sizeof(struct bpf_cgroup_storage),
+			       __GFP_ZERO | GFP_USER, map->numa_node);
+	if (!storage) {
+		bpf_map_uncharge_memlock(map, pages);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->buf = kmalloc_node(sizeof(struct bpf_storage_buffer) +
+				    map->value_size, __GFP_ZERO | GFP_USER,
+				    map->numa_node);
+	if (!storage->buf) {
+		bpf_map_uncharge_memlock(map, pages);
+		kfree(storage);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	storage->map = (struct bpf_cgroup_storage_map *)map;
+
+	return storage;
+}
+
+void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
+{
+	u32 pages;
+	struct bpf_map *map;
+
+	if (!storage)
+		return;
+
+	map = &storage->map->map;
+	pages = round_up(sizeof(struct bpf_cgroup_storage) +
+			 sizeof(struct bpf_storage_buffer) +
+			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
+	bpf_map_uncharge_memlock(map, pages);
+
+	kfree_rcu(storage->buf, rcu);
+	kfree_rcu(storage, rcu);
+}
+
+void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
+			     struct cgroup *cgroup,
+			     enum bpf_attach_type type)
+{
+	struct bpf_cgroup_storage_map *map;
+
+	if (!storage)
+		return;
+
+	storage->key.attach_type = type;
+	storage->key.cgroup_inode_id = cgroup->kn->id.id;
+
+	map = storage->map;
+
+	spin_lock_bh(&map->lock);
+	WARN_ON(cgroup_storage_insert(map, storage));
+	list_add(&storage->list, &map->list);
+	spin_unlock_bh(&map->lock);
+}
+
+void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage)
+{
+	struct bpf_cgroup_storage_map *map;
+	struct rb_root *root;
+
+	if (!storage)
+		return;
+
+	map = storage->map;
+
+	spin_lock_bh(&map->lock);
+	root = &map->root;
+	rb_erase(&storage->node, root);
+
+	list_del(&storage->list);
+	spin_unlock_bh(&map->lock);
+}
+
+#endif
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7958252a4d29..5af4e9e2722d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -957,6 +957,9 @@ static void free_used_maps(struct bpf_prog_aux *aux)
 {
 	int i;
 
+	if (aux->cgroup_storage)
+		bpf_cgroup_storage_release(aux->prog, aux->cgroup_storage);
+
 	for (i = 0; i < aux->used_map_cnt; i++)
 		bpf_map_put(aux->used_maps[i]);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e948303a0ea8..7e75434a9e54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5154,6 +5154,14 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 			}
 			env->used_maps[env->used_map_cnt++] = map;
 
+			if (map->map_type == BPF_MAP_TYPE_CGROUP_STORAGE &&
+			    bpf_cgroup_storage_assign(env->prog, map)) {
+				verbose(env,
+					"only one cgroup storage is allowed\n");
+				fdput(f);
+				return -EBUSY;
+			}
+
 			fdput(f);
 next_insn:
 			insn++;
@@ -5180,6 +5188,10 @@ static void release_maps(struct bpf_verifier_env *env)
 {
 	int i;
 
+	if (env->prog->aux->cgroup_storage)
+		bpf_cgroup_storage_release(env->prog,
+					   env->prog->aux->cgroup_storage);
+
 	for (i = 0; i < env->used_map_cnt; i++)
 		bpf_map_put(env->used_maps[i]);
 }
-- 
2.14.4

