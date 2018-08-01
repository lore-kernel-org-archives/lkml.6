Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635DC20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="d68G3QIJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kARvNHtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635DC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbeHAXZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60980 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388539AbeHAXZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:34 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LWbHj007722;
        Wed, 1 Aug 2018 14:37:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=HkjTY9917jaa5vJngEByKtiskZT7PS+Gpyf3N6mx0yI=;
 b=d68G3QIJzM4s4Zv2a+njH9eE5NpinDoMkx96SoMMd68J4fTtGHpbA/+46XOYy+5Dqufr
 Y357QnJe4q0JPSeSQmXKmy+vDvWgpwhW24ywdkeBdFN/ckxe5i+I0Prkw3cJ9Pi0iT/Z
 WoOHosRcg7OtVK2JNaJmahvwIh8xlzKY60k= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkgjvgsx6-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:25 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 14:37:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkjTY9917jaa5vJngEByKtiskZT7PS+Gpyf3N6mx0yI=;
 b=kARvNHtKipk5vCRSFmXARltA/Wly58m8iT1k0rPikOwZhMGL2JHzX6dVuvaPUbE5Z6w/i+H3lHqPHqpPEolc+p1YYUnfKW0edLJBeuerzmBwW7JoG58gHCUhddZMrnB8u7ugQhcIVUhM6f/oqXvkLgVQxA936YagDjg379oXPnY=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:18 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 08/14] bpf: introduce the bpf_get_local_storage() helper function
Date:   Wed, 1 Aug 2018 14:36:43 -0700
Message-ID: <20180801213649.30751-9-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 790538bb-e102-4c23-311c-08d5f7f6f50a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:ziG/77DaRosuEiUBXn0NurUCM/ASoFC7PHKJjvWRVU69H0BBSycayZD43rqMfjUbf6fLVQs2xNUmeEqdnI/nzPXOwre3c2bQ5jEHsGXztEozN4yPw4KQudkIJiDFGCIEClg6E6Ui+cADOiZLi+ie8z8MLqh1NMvhJMCEYfoki7ZFMhqZoZ/63oXtUhJT5WpvFL8SaBrdJZbuXGeQoed3fS8ig5xO5ZRSy35xyFcYWAAhLpsreKCGEGk7dW+FV19h;25:EmNCJ0s2vKndNRU7yU5GP8HkxdXdai2q3kEUEopHMDl3DBc+Jjm3mu+xBCVaaQf6JVOuB2TZgvDD/EwC7hEn6cxcTFD6sRDsLkIN2fd0ZxRwi8fo4G6znR5J2TCWAgDkwlStpx6nfCCSHrYACRDnDirnBN8rEmbjFQ8pR4ZIc8uRQoCpdTWfz6kPXEjDFIX//xYaQ5uZKN4QSjhwtR2udE+OoTCuPxa+IY4HFP9+x90laWDPb5ZIxj/n9bgnBLdQn3FWtTNwpW1sl66UD20iwnJfO8Yy5IapgWq2WBVgW9clIOXqSGxccqf97PLamPTrisiF2a1UL8OB51fCqDEmPg==;31:7QZIxivaAIH1r2Zere9PMKY9HWFG+YvPBJ1qSA3CVOHGVrkBIH8ktcTKltfoqexHyPB1KpnSfsOwmaV7WeSPjmqZCxSNweufNaH4UD6Jc3Mxxe0TiN25yl4XLTe7r9PyTVM013hyYBLDzkTqZ9ZMJAQQrVUURUmZrKh74Il+ioqPxV/RS0UPpSrIep252IxoW7GeSYtibYMiTv+6GJKKF6CZ2i4XTfDsZLmRja3yPiM=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:PSI/SmG1nruL8O5lM8LqbsRwVPCK0hyMh0mYAMPoGqViTUvLeqV6SvGW+9HTl0oE6x4vAIdXeZqkJiGhRisGGwrMTB/aDtKQd/QZnUzwh2UiP/QnmJr15pfbbSqGPSqKWPIt/isbNSuGN7n0ydwzlg2+eZwXaNkhokezNzz33XvknEwt3PYTd2oM4VkncDlp6lRLuBdp3JR0kxGCCRXy6mCtWUwepAUxeQJcVGQCGV5iJwdZJcgRcIEa6lZKU9p2wnKC+Q90l6Oo7lmIIXZ8a5UiaYQPGdiWeiPSL6pYyFf8nLuGtuBotMtJ23nsNYIwcIjpx20Q4izGBMZMJju8+6nY7To8WJHSMW/tTi5lLE8aZcmiGYBeaZyg02Slr1D05P3rbeLQ21oqz7uW+2I/CMD88zhoUwKbl7ayciSL8SfYuqLO9PuT4vGMk78lo8SwF5V2sK8wJmtAhmWGHQi+stM7ChMLEkHDq/BA13fpZEi3qfG63mrdDWGFPN8jFzOB;4:IN9CiV/p4pUcHBFZynV1GqOmZuo+X2gSerbbU2YOsLrWPGFisgaNJS8p0A31n0WDIFra8KpA9io6vxL26EKUk4sbX4G1Ss1QvUTpC3Zg63XemT5xnll4QtmgP/7+a+bOR8ZOlN+yJEjBLpDTpIDEXPZnowcJVtiubEhkiSVH1Q16D/+G1hkHRKyOAchSRtvAOhAxmfb35x42UPCtj4qCp02m6sRvJVshaHmEk3l/bv1MMBP1RDdc9cxcPmXsgv6y9XDx0lOMFrN5i5DIXhHXFAtekN2K8l73Wnzbutpko618jHCK6MN1M6F2eY7Uy1wtfN/NG19PKaju2iqeIR7XIGFdcSzuLQTm/Oku9vOKSb4=
X-Microsoft-Antispam-PRVS: <BY2PR15MB01671B8F5FBC8F5941EBD567BE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:ZXW0INfclF7ZCiOlyovH9LgnRQrBJOas7d4TndRum?=
 =?us-ascii?Q?67bCUap3vh5kXkcs5hS2FzcizCRMdXDyFNJWlkkb51ZpH9QrKB90lpGE/01W?=
 =?us-ascii?Q?/nnA5gixV/dhhYPmieD/pd6U0NSv/pXBk69h923phF/UD5jBji5Tx6YYy2Cv?=
 =?us-ascii?Q?nlzHXQM/fCFirWKFJ5ghIoiJyvFDMKBdoUYInB9byXZnBYSDiTNez9t/dxJO?=
 =?us-ascii?Q?qO2H1FQe9oVSnVQUhmfUIfjHAP/SJgLfk5fk94oHdoDiUzQ7IcPbyRa5RsNR?=
 =?us-ascii?Q?u/d1vTsMIwd5Vv0XqFKDRBV4VXj32LhOAJ8lGUfoXmiHfJxQA03Tf1VKCN1M?=
 =?us-ascii?Q?YkQRi4Il/yjfDAJ03ina8fZEjQSdvrEVyBHIJq/M0oONDvXK0jr1QckXdiVP?=
 =?us-ascii?Q?BLK+5KRYXkAXGRjr6QKQEmALD0sJlPLuu1R8UegjQf8euR5zken4+luijjVe?=
 =?us-ascii?Q?S8cQhArNQVQocXBHQBotxEQDb0WDQSA3WZo+JUsG8O0dNVT9zTh9LMCv+Yj3?=
 =?us-ascii?Q?7opf6UnWwhyLFiiuosH+u45cOtzDsdmezFzKk5tcKa+ngkoGoS8pb9WYO1XJ?=
 =?us-ascii?Q?4dNvL+Q/tzbiOkXrHiRV+7Vo7zoGl7jVbjkZfxg95L2sk9Y1+9Y51Omqbxcc?=
 =?us-ascii?Q?qM6NaigDi9tcho8hYw9u3Lvn66FJe4qNZFLwKVQrAV9dJnq8tRUq957dKBAR?=
 =?us-ascii?Q?gs31Jmwoa6raOwC+4sxndxFY+EyHTVZNeCQzZF6DT3eftSh8+8BYqL55M9aG?=
 =?us-ascii?Q?LCD3KBNG2Vk+W//5SpRGVTYYb3vZ8y2I7ulIqdlcFLp+pEw2RnzXX7Fgl564?=
 =?us-ascii?Q?Yxm+nVH3crVzLH4iyTVK59HdwJCH/FYttU7bFC8CJQVx8934K0HWlm4/XE7B?=
 =?us-ascii?Q?7blIY4gKQHnF/ItytF5UJXiFGhg1ap3TkLw/dNYk6tPSdVxdMooG74Y6rE7R?=
 =?us-ascii?Q?Y5Y4ZFGxPFfvtWPlXO2BKKHz4fwgMFKGz02q7Pmv+siiQuVcSzkp2pf5ubqM?=
 =?us-ascii?Q?nb04o9Wl64XC8FI/7YpT4fepyEsYsMj1SXaM2THIQ/kMkabrTr8ks0hZAkCZ?=
 =?us-ascii?Q?/M7+Y2OxuyREpreSr9oZU3YhrUWOt+DuuYn0knfI5CXqMRU7Ul1fA613Qfdz?=
 =?us-ascii?Q?t2jCFRi+Z32p+dM+NdJ+RyzcpEDwxZ7YRXvL6PeqXHSQv8Av07C8YaZPnNjG?=
 =?us-ascii?Q?+2Tr4v3rEcI/rXhU2yydBjoCKe1GbdtKxpmEb2+e4UA7nxaCbMf8kZMEaqkB?=
 =?us-ascii?Q?KSNWC2Uu/Fwz7Eruo+MAuVSIjej+/dIybYvLlEfEvkbsYJdGyOBVsxnK0CZL?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: YJMIMVSbxBfxXvNSYrpMs4TyiPCi9c0NBCCW3sP4MqZdlr7MgAMChuylqKoIUqCAZMJnRXBrw12g4S7DqO2nDv4OkZKjmgqWVfnIu52OnvXrLmQ0UBoHtIa0FNpTi+wiSaZzWU+vBtaSBwcFY0DKdtzW9JJijlnxZKEzH5rJy+KFpRx9a8nvvf2rMRMlJumBdjuxWpu1uXE78EJZ0Ut1WRfxU132gxBCNGCc1pQA9dbNvYz2bpwwg+LO4VEyURaGSeClug87te28DkOQKReyDiwpWFmFolSeqHYgDG8BYj9gV6hL6LnGMXdNFAK4TXFq1rDtkGkYrSXW/bDI2hRPiTj+ncQkPz1TxboFoX9Kkvg=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:BpA7+xBzr63qJluoF4w9LFXQGZa4ArsVIzzUvWv0DnOjDqnjoPoG7c+15uLGqTMevko+gKj2/GDabJDQabt1nfAQdro2Y/a2vMp+PMNnMe84xgvyIIpJtKjx3iVwYCj1dULBYoIkMD+rwiBRlCubz4dAerxD5wxu3xR81K97m7pmiKqiOpPKK7HIFLmVxyIsfKAynqq6QgVI1/NB9l/AfnNc7R6BPckDSMxgM1WeaC9q/4R8PPkgZrX2o6MIjNeNrd9LcGyajg7h4GG/Z2/2LJife15JhtpJtFAPe//m4OMABhbwPu/1FpLp5vpGdU+zx+C9pyJNzxnbxHcetXe/7YcON9Cnko7+cvvFNtESeyO3rXDFPWfxkHFNZCRaiScj6pyyF6RUCg2v4eJ/0w374pZIIx6fLg1LwdEXgUFC3+aEuI1A89W2k6HEafM+OcJW4xnaPgS+/SGf8dA3RsgvWQ==;5:qyoBSbA4dEOzUZ0Ce9xqXXBw/JjRY9TwrmImj4CMyrYSiy/Nnv39jgmiOd1LYJLmqINHL52HcykSsznjKD0T1R3Tp0bjZCVoXRMRvvlmNdxCkHePObEFURADEPrKqmFknypo3hs5BVx85W04Gwkp1ZBRrubHGIUeRe1A8j2fHW0=;7:by17fKolrRSmrppKVEtyfjIr2sCn6wPppTIwF1HnPAdXjKnuK63c85ePd5lrBd7B4vz9dZPgVMA8OswJzDmpGvMxEec5cqNidVfUc37J9eq8zJ4Q/SZqb2wnuoL24wXBVPNzeq6nzx6vel9GDcmB7YcUy7ARJruVm0In+4Xp3zYY4FKti0QloK1NurNHBXQwqPM54IhQ4bFUW3ONfKoJ61nsV6SIql4bJfI8ST9ovPYrzQ6VkDcfVnoD16TAnA8H
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:ztE8raIy3XsZ8KE2rpOs1hQIF7uPOkTtw3qbeGROAEyWpglVfL/jbX8C2kEYELwH3t/skHsIuqcSsIvJtXjokQ8F96FBkc2t8P/eZVsfbqnHoyVJcPwVATFuJVm8hqtEImyrL3zyklPjSy64j/Du9ene4vYYS4iPcIZs3SfYIJc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:18.2689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790538bb-e102-4c23-311c-08d5f7f6f50a
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

