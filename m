Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4F0C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC23276BD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BXsHR0eg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ERZld6oX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC23276BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935814AbeF1Qse (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:48:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935744AbeF1Qs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGka5U013501;
        Thu, 28 Jun 2018 09:48:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=qjsrZ+UpQr71rdLDCmH6ZlU6jMU0pZECTxaJJUYoPZg=;
 b=BXsHR0egV4RMrhEbDSCB5UwlV/VNkfDWu92PdFU/4Zzz3HC1Ix/hk9hqsVaFceEU/iBL
 VOhNWM+dkx9h7JLnme/vMc1cPfCdVyDJZOmBsMwlpRD2TWzJwCYYzo9n1MaYYhBuX9A6
 YQPCCvKaQLXKQFAioA05SHhlbv8yMWjgKDw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2jw2u0074v-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:06 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjsrZ+UpQr71rdLDCmH6ZlU6jMU0pZECTxaJJUYoPZg=;
 b=ERZld6oXTlC1Mcwk334Nq2SCxQw36cFJ1hlSWkreWqkytY+kMZGUsvAilAJJX5vTh1vneMviBqVlfjT3n0abIWH8N3/VcLVjr1SioeP+1Xe5RmbWQnZ/4erUeQy5JkTrN9b/XzBfoq4WmPIbC4dZ8yilG4LVZcYiDWBsqYCoyWw=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:48:00 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 05/14] bpf: extend bpf_prog_array to store pointers to the cgroup storage
Date:   Thu, 28 Jun 2018 09:47:10 -0700
Message-ID: <20180628164719.28215-6-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628164719.28215-1-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d8ce2ed-73d8-4381-07fa-08d5dd16e906
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:XjZZY7RsILJ3uwzz3ml1wrVw1tSWTdng73oRlk8jf4f5cedvhAp2CXlLRsVcGdp7B9QPTZgVsnCOzRcSZw4+plth0DbDQxjtNBvxtWfE0Ks3+IdUiOQhGvIoMbhCIDB22UEdNAVs/JpaBfgAYglH4FnHT5pLm36TNPX9XmxLmDBVtgagVf2F5UtywXXfX60V/V3Dl5ppGW1PPZujUtgCM0+o8lyPS4hXo/as2TPCQXpGQlNXvIEDo9Gr6ivfDSWd;25:JXtkylzb4lJ8UdJjU2H9pYrw7xcJyBIBOVh/5tv2j0E0rizwn2yjTeGF+1tS0R91s2/AQynLWXKIt4kZb9SCmOR+Y4j3wDjvPPk4HjUWnw4nochRTbpBGV5vGZLjRei53xQYw4/yWiWZkz8H2eUs5hA5KzzDKiDA1IMBbuw9V/iW81DR1bIKEzHgVhN2Ee7kVfNlgf/7Qb2eC4x/ojMekX17gB3ymqaDp/405LLVSk10TE99LAlwP+98yT/4ej6qXnAE1b9GqQtO9oOAFad1ct+HDM43KJWiUPJ+X3vbNgYgyMO1awPuqrKFwQWGgmuJ79TMhcMRY3pNTxtrfeAO0Q==;31:PSPWoRZIVIsHxjWJE1CiQ2wx6AMnrZq/Z82QadytTRZmdnjMcVuaVRllhafrr48oHqLId9M6dqmDPat26F0wnEpiH22KdB/W0QFQpaX+wnyQIbEY5a+/U0s5vMPu+4R0SXB0fUc91ydvlIIlHyuchqxRyagaZ780xpKe8t8a2Yy6k83TCyL58JS9su0rnnOrNbu8S56REgdHPPit6+pCGfAmpJ/IwfkJ01pgrUsy3LU=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:ZN///9eyqLHYO+RLPq6gOGjCC7RsZOsj8fZEnqSmdvqU40f4+d2otxiLPCVuXWPaWnKJkVm2v/FRdFfntdz3yaKMr8lj//mh2TJ5VdqZ0G/qT/uvOfmQZNV+az54wegCWoPom4ifS5CyVaUTJ2H5DUCDOsPJKQZlqf+yCmXdzWta804ewqKC03zib+jq3fzOsV3MgSEuM3q74iuHtCgxniJGtUOsI7/5zub5YVXUVqVV/8iJeyFZI8B62bBwyxcSJMfzqaPF3OvZYaCS4REDbsHvKAGg/Q/3uoqPXfqn948NKj9NGmgP+bzdY451PomsUYX8O9uw6zHCQIJ6kfs/eC7957P3JBfNjYE3DxcwNv0+OoaZ9W0M3VvBa2zY3PgfQ8k3Z7FnwP7iLUOAPRsNx7wvbN7lokJuiSPzKSV2w7PkCgW4ZHwiG6CyedhFu0xihuAe/oF6PTui9L6hxrRL/mDTMs4HqSchwjRNC3SLAxOr+Z2bSxOqmyiHjyX/uPkV;4:yXyDbAD3v8U1HOnwT1FNFs24z2ckkiCPV0dXtvaEWyZL8usD4sbidiyepLIkU9s74LCoxsGS4voGBqo0fPMyGnwGid65jo1Yexy9btgeg8efM1k+7MvTZPAGfFnwUTe4ZGhWc4Lua11bSODzt/22wwz8cWPMyOWw8TnZEYYN301pYMAiR8WFAdZd1zWTth7GUBEi5+bMOFBIVHOESCbZHd3mCXZVCm6VLJfWHpLUumm2gKSivD35LEbdw9EpkRIWXtLnnBUeQAtiIOg3Z6SkrHfNzlA9dE55+v4DaRZIisk56FL35e+Pn8W3Jd3H3/da
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081D925C8F0DC9962DCBEF7BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(575784001)(5024004)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:GiQ9+20zGkPncR50Iu7ebZ1roffhCyZ3yvjw5s+Hq?=
 =?us-ascii?Q?M+h+5/nkSTjYg51mA7EdMsDvgt8W6+gCp++wtAV96kcfwMzZduSKPmbV0sJ/?=
 =?us-ascii?Q?/7mZvGik/pyFUs1VUgvzSTiL5ycVM2FK6L5bSFv6Lmijvjl4ZFq/xVhwo1of?=
 =?us-ascii?Q?d4ySHXCQ9n4AcnfOQhgWT5Sek6z7YpzEubrN0bi0ppgmbUBcRkmctqmb5U1n?=
 =?us-ascii?Q?0gdBC7pFg5RJZ9kXyB3BDhldj4M0HTKKDSFhPapahV8Tf+mS8RlZKucaoXNz?=
 =?us-ascii?Q?7cFgZq7hcOYfloItFLcPcVHkzqlDG/++uJugoefJ+EYSFZor2Z/6g9SzUEp5?=
 =?us-ascii?Q?jC9atbobyyy7RV0RsY5QUs/WRPr7JlM2sywBKsC0tFexVCaE7jllf59xLwoX?=
 =?us-ascii?Q?Vz5aXsPKgdMPxBJeJRTuk80t1eSS93MhygsQQ+8UVWf55EuSudPpQyOTM/GF?=
 =?us-ascii?Q?GAWojnEHNpeKL4IKDN0QdbCpTcJGRx7JtsRunzK9Xcc+PxwtIRShgxxcD2je?=
 =?us-ascii?Q?QQGyNU249Bd/dP1Kx5fBpOd+BUAMp5xWm+0LpYUwOB/1ajpdq7ARELxKgm+S?=
 =?us-ascii?Q?Hfct5f5HuXEB3/P5Sqs/+K4WzxA4oVvWfEyb2cdpyzGGmXeBtPtDGxi4ZE7Q?=
 =?us-ascii?Q?IJqXBMou8tSqfIldqemde0fiYdtoPHRHylP6Ep/8BAXxZvApG8TUpL7e8fh1?=
 =?us-ascii?Q?7enlNaDLljOOWQRiWAcnYtLME0ZG7qKO21Odi04XKZ6MnCK5IDRwmcmVgO5I?=
 =?us-ascii?Q?WqAdBtk65R/LlvrPgix9Bd/4p+HFWYWeC4ViIz6MX0zx9jHZxXgcdXaAlc9a?=
 =?us-ascii?Q?c26E2/BphOoFtALdDVk/ju7hADDALcAyn3n2cjO+pxh4J9Shf4bCQ7HliaXx?=
 =?us-ascii?Q?DGZC2tvvcjAS9PYQV+iXZcne3EmooSgnpYIerKFJ3rgC8jdIsQAW99m7ecrB?=
 =?us-ascii?Q?LzvOLQdsJRAOm918mxd6y7r3rre77EHF/C3Ye4eUzYw0b4Mbr8rHtB5d2yvq?=
 =?us-ascii?Q?/wXmir+S4WbNAFNCNnQdb0WGN65jW4HZgVi/tlgb4t8Y4eCAJxEDDHsgYR+v?=
 =?us-ascii?Q?8foOmbHWCIR1zySYl5ErUG8m4jfuyQcaZBckhS4BHWATEs0v4wbg1FylYGPU?=
 =?us-ascii?Q?je4lxwuYj9t43+CEx9bpaIr0e0NcnMNDOkLV+gGa8/ZphADbHGvji1f3WMyb?=
 =?us-ascii?Q?4OlDvQTFklDepmDcULcJhCYuc1EhdpSQI42UMMa1+a4Hs3L2Ikc7Tl7PHpbX?=
 =?us-ascii?Q?iupoBr1DT6zaXVI8WvOc2taxhvnmqBKFIYVGUUZXzMCrLDsfkSbvkQr+Ctzz?=
 =?us-ascii?Q?iz0qwv1025AKs4Ot5L/auujqyPnryMgYfj8JlJviBLE?=
X-Microsoft-Antispam-Message-Info: SfFiJAEI54+nBFFcOmj2MZwh0cEaH8MxogMVq06GPmO9FNX98z0q/0eit0mYy0kvgZMz4qbUUz6VgU6hDE5yqIOHfdbFtygbkIcMP7BCVkuTnnEXtvay8Mf9T6ugs0TKMYtBB6DYR3pfAsvx908PItF7PGTa1W0kfKU5mEzA2KDeOgnNwMrowsaZJzDja16loYUYgG9owt3wrmxGDizJ+3rf32t6Q++AslEdbQvpT6n+8a7Nc7/Z+lv5tET9zBpUt/A2EOgv8lCAzkLq8/PPykzZ9RICfXjKnmYHuy2dK0ABWJZ/dx2P+EsKS1KjuUDd/EdV+C8fVKYFQpx3Jxy8owC1OfDUeFrBMLKKaabwsCM=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:z1796W9lEssSZ6Zfg5B4OKqHoElXdZockbtCAWK0CDA+kW/oPRZL/eHWgArV9pepDFhW9HzXHAJaHUyMdQfTDHOR0VvlToFPhUVGUX47n8D4QhgOoEg8dOVOB4/03mR5qj0rCJLdXhD51SqW5qlghcJ8gv9A8jyAI+JrDbGi06by7smVI6UOsL1HB5qjDShToGU5iUpMX7Wvifq7QuTbConxB2vZeVOeGTecLsWnZfWy43Ujx4bHH1TB4ZJp4cYIceCdqGAQOqMAreqImoRid35Ivo0EA3hoUnG6tQLZD4gqciFe7ER3zEU+XMJHvkK87YaYoSrYjWoKQ17Do/iCFS7N2JdsXibxxf4stM/Od4gYE200yCxe/1I7vn4c43XX3A9AGEPKGG1BqEdKtRzF95GZ+Au0A0TJdRjdsuA86p2vrjiLhGPwiq+6f3ETpQRrcn6fpqmJJbQnrBVX4ub9Tw==;5:AVIa23gy8bo22ksyemLL9yK5s4PStIcr7T8WrH7FJ48Sw77iMMbl6NLJOPU9+CpY+u/KSATJt0AYxuhSrLpIjSAamRm3armP9ZkNIBJNl3a5/6zN5E96ruQouqjIJs2BA06TN7ydFQsQ62HNcn2zZW3/tH1AYS+UZW765LuLm/A=;24:szETIoG1rurn5A54uZ2f5HYonLGhtocXmK8+HzM79AHz5CDOMt0MNZx41HCOv5cpl8eLqGnUYxX0XjmErD+K06Z4754OTzMkd71OODJ/KcY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:oSSuCVRWu+wICrjeUkuxYygoxg8GVG8cYXSfFgrOI3OLiKxnPh2JJunvdWd2dfmBMRgMWzP/BPipo9qNESu9j0ewHHkylhO3hWVNApnRMLcLt3CbwmfnOlOWlyaY6tLRGtVBKjGY/u6KdlY39AveKVbNDCrCLDTOnmflybpRoo7h/SzqUisGXiYR3Ah+Cbp0NphEuTL4TuqfozzbK+yscQJPXet3eBd6ewNH6G0dnC8vLBXrpBY+y4AR4qS5nM+k;20:UtEia1uSmpuvoMp/fOHWCEjXHOAwfxPBmK2ydoCkTOgjpeDBCjqJWOXu1lLJ6f6SoWAL1vS3IDtTey8J1K8BMxs6a7JHPmMS/W91FU84IyD15T/OrJRLf+lN2UQD+S981udpjNjvWnjTpEkqVVFJxnhFALs1yyfm9S82QczTBM0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:48:00.3173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8ce2ed-73d8-4381-07fa-08d5dd16e906
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts bpf_prog_array from an array of prog pointers
to the array of struct bpf_prog_array_item elements.

This allows to save a cgroup storage pointer for each bpf program
efficiently attached to a cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h | 19 +++++++++-----
 kernel/bpf/cgroup.c | 24 ++++++++++-------
 kernel/bpf/core.c   | 76 +++++++++++++++++++++++++++--------------------------
 3 files changed, 66 insertions(+), 53 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4b3e42e5b6d0..709354a0608a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -348,9 +348,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
  * The 'struct bpf_prog_array *' should only be replaced with xchg()
  * since other cpus are walking the array of pointers in parallel.
  */
+struct bpf_prog_array_item {
+	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *cgroup_storage;
+};
+
 struct bpf_prog_array {
 	struct rcu_head rcu;
-	struct bpf_prog *progs[0];
+	struct bpf_prog_array_item items[0];
 };
 
 struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
@@ -371,7 +376,8 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 #define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null)	\
 	({						\
-		struct bpf_prog **_prog, *__prog;	\
+		struct bpf_prog_array_item *_item;	\
+		struct bpf_prog *_prog;			\
 		struct bpf_prog_array *_array;		\
 		u32 _ret = 1;				\
 		preempt_disable();			\
@@ -379,10 +385,11 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 		_array = rcu_dereference(array);	\
 		if (unlikely(check_non_null && !_array))\
 			goto _out;			\
-		_prog = _array->progs;			\
-		while ((__prog = READ_ONCE(*_prog))) {	\
-			_ret &= func(__prog, ctx);	\
-			_prog++;			\
+		_item = &_array->items[0];		\
+		while ((_prog = READ_ONCE(_item->prog))) {		\
+			bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			_ret &= func(_prog, ctx);	\
+			_item++;			\
 		}					\
 _out:							\
 		rcu_read_unlock();			\
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index f0a809868f92..14a1f6c94592 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -117,16 +117,20 @@ static int compute_effective_progs(struct cgroup *cgrp,
 	cnt = 0;
 	p = cgrp;
 	do {
-		if (cnt == 0 || (p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
-			list_for_each_entry(pl,
-					    &p->bpf.progs[type], node) {
-				if (!pl->prog)
-					continue;
-				rcu_dereference_protected(progs, 1)->
-					progs[cnt++] = pl->prog;
-			}
-		p = cgroup_parent(p);
-	} while (p);
+		if (cnt > 0 && !(p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
+			continue;
+
+		list_for_each_entry(pl, &p->bpf.progs[type], node) {
+			if (!pl->prog)
+				continue;
+
+			rcu_dereference_protected(progs, 1)->
+				items[cnt].prog = pl->prog;
+			rcu_dereference_protected(progs, 1)->
+				items[cnt].cgroup_storage = pl->storage;
+			cnt++;
+		}
+	} while ((p = cgroup_parent(p)));
 
 	*array = progs;
 	return 0;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a9e6c04d0f4a..145f44cb0cad 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1570,7 +1570,8 @@ struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 {
 	if (prog_cnt)
 		return kzalloc(sizeof(struct bpf_prog_array) +
-			       sizeof(struct bpf_prog *) * (prog_cnt + 1),
+			       sizeof(struct bpf_prog_array_item) *
+			       (prog_cnt + 1),
 			       flags);
 
 	return &empty_prog_array.hdr;
@@ -1584,43 +1585,45 @@ void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
 	kfree_rcu(progs, rcu);
 }
 
-int bpf_prog_array_length(struct bpf_prog_array __rcu *progs)
+int bpf_prog_array_length(struct bpf_prog_array __rcu *array)
 {
-	struct bpf_prog **prog;
+	struct bpf_prog_array_item *item;
 	u32 cnt = 0;
 
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	for (; *prog; prog++)
-		if (*prog != &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++)
+		if (item->prog != &dummy_bpf_prog.prog)
 			cnt++;
 	rcu_read_unlock();
 	return cnt;
 }
 
-static bool bpf_prog_array_copy_core(struct bpf_prog **prog,
+
+static bool bpf_prog_array_copy_core(struct bpf_prog_array *array,
 				     u32 *prog_ids,
 				     u32 request_cnt)
 {
+	struct bpf_prog_array_item *item;
 	int i = 0;
 
-	for (; *prog; prog++) {
-		if (*prog == &dummy_bpf_prog.prog)
+	item = rcu_dereference(array)->items;
+	for (; item->prog; item++) {
+		if (item->prog == &dummy_bpf_prog.prog)
 			continue;
-		prog_ids[i] = (*prog)->aux->id;
+		prog_ids[i] = item->prog->aux->id;
 		if (++i == request_cnt) {
-			prog++;
+			item++;
 			break;
 		}
 	}
 
-	return !!(*prog);
+	return !!(item->prog);
 }
 
-int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
+int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *array,
 				__u32 __user *prog_ids, u32 cnt)
 {
-	struct bpf_prog **prog;
 	unsigned long err = 0;
 	bool nospc;
 	u32 *ids;
@@ -1639,8 +1642,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	if (!ids)
 		return -ENOMEM;
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	nospc = bpf_prog_array_copy_core(prog, ids, cnt);
+	nospc = bpf_prog_array_copy_core(array, ids, cnt);
 	rcu_read_unlock();
 	err = copy_to_user(prog_ids, ids, cnt * sizeof(u32));
 	kfree(ids);
@@ -1651,14 +1653,14 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	return 0;
 }
 
-void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
+void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *array,
 				struct bpf_prog *old_prog)
 {
-	struct bpf_prog **prog = progs->progs;
+	struct bpf_prog_array_item *item = array->items;
 
-	for (; *prog; prog++)
-		if (*prog == old_prog) {
-			WRITE_ONCE(*prog, &dummy_bpf_prog.prog);
+	for (; item->prog; item++)
+		if (item->prog == old_prog) {
+			WRITE_ONCE(item->prog, &dummy_bpf_prog.prog);
 			break;
 		}
 }
@@ -1669,7 +1671,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 			struct bpf_prog_array **new_array)
 {
 	int new_prog_cnt, carry_prog_cnt = 0;
-	struct bpf_prog **existing_prog;
+	struct bpf_prog_array_item *existing;
 	struct bpf_prog_array *array;
 	bool found_exclude = false;
 	int new_prog_idx = 0;
@@ -1678,15 +1680,15 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 	 * the new array.
 	 */
 	if (old_array) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++) {
-			if (*existing_prog == exclude_prog) {
+		existing = old_array->items;
+		for (; existing->prog; existing++) {
+			if (existing->prog == exclude_prog) {
 				found_exclude = true;
 				continue;
 			}
-			if (*existing_prog != &dummy_bpf_prog.prog)
+			if (existing->prog != &dummy_bpf_prog.prog)
 				carry_prog_cnt++;
-			if (*existing_prog == include_prog)
+			if (existing->prog == include_prog)
 				return -EEXIST;
 		}
 	}
@@ -1712,15 +1714,17 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 	/* Fill in the new prog array */
 	if (carry_prog_cnt) {
-		existing_prog = old_array->progs;
-		for (; *existing_prog; existing_prog++)
-			if (*existing_prog != exclude_prog &&
-			    *existing_prog != &dummy_bpf_prog.prog)
-				array->progs[new_prog_idx++] = *existing_prog;
+		existing = old_array->items;
+		for (; existing->prog; existing++)
+			if (existing->prog != exclude_prog &&
+			    existing->prog != &dummy_bpf_prog.prog) {
+				array->items[new_prog_idx++].prog =
+					existing->prog;
+			}
 	}
 	if (include_prog)
-		array->progs[new_prog_idx++] = include_prog;
-	array->progs[new_prog_idx] = NULL;
+		array->items[new_prog_idx++].prog = include_prog;
+	array->items[new_prog_idx].prog = NULL;
 	*new_array = array;
 	return 0;
 }
@@ -1729,7 +1733,6 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt)
 {
-	struct bpf_prog **prog;
 	u32 cnt = 0;
 
 	if (array)
@@ -1742,8 +1745,7 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 		return 0;
 
 	/* this function is called under trace/bpf_trace.c: bpf_event_mutex */
-	prog = rcu_dereference_check(array, 1)->progs;
-	return bpf_prog_array_copy_core(prog, prog_ids, request_cnt) ? -ENOSPC
+	return bpf_prog_array_copy_core(array, prog_ids, request_cnt) ? -ENOSPC
 								     : 0;
 }
 
-- 
2.14.4

