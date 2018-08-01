Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D323C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D994F20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NQks+D7u";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="J2blapEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D994F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbeHBA0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732387AbeHBA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:51 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w71Mb8xU029725;
        Wed, 1 Aug 2018 15:38:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=KYnSp7NsKyMzyHdhSDtQhVvHlpJLTQwyiFaE9Hw63ek=;
 b=NQks+D7unYERpj+rx7imqIIKJCeqoK0XA2UHxO+1Zo7YAtm3W4KhZ7fR+bk13CR9FElu
 f6VuxiVMdmyE/2/y/7hyjcOolBb3gziV7CYuOTlHskWCTTLXx+zrE831sUFD3H1kXhAb
 qfmmGxif9zb1UJPFyBxAeTSA0tmMYoQHgaA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2kkn4c03m9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYnSp7NsKyMzyHdhSDtQhVvHlpJLTQwyiFaE9Hw63ek=;
 b=J2blapEnvkM04SemnfKsFRBYD2r1ogBAgPLprnYuGtwcCr98MMoHYqzS5ZZZsFE1i/VtHRxbMlvYl/SurqVhS9NEaqKHun0vn3k/VM1hbo6HzZng5eRfXiLvQzEC3kq196lTEsHOcspXQj8WnSEnGQzZcbJjyt1+q+HUz/fxsfM=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:17 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 04/14] bpf: allocate cgroup storage entries on attaching bpf programs
Date:   Wed, 1 Aug 2018 15:37:30 -0700
Message-ID: <20180801223740.11252-5-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7cf7a8a8-21cf-49f3-a32c-08d5f7ff7a5d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:CjQehB3MYTgCvRUDKU3B6vG/kkT1RpBv9D82NP0lTP7/McQIHbuu8eg4G7Nn9G639ibY1iRa0kId0xq1W0MAJ2xTKgTc6f9tHbvIN6X+sZlAysxRFm7uWarfQ/WpcRDMbUORDZ63gE1CV3cjPnilygbNiXszowCih9nSgtD0qDPZp/qRVP1/iuUkmtK4gB1gTBSRflfqAr+cZhrJeREboQ/YuGEqb9AczP2XoOg43k6QYt9cFqZhe58Vg0g2AxrX;25:T27wx1WVoUc5vJ8ZiIWIt480mX7XUw9XdMkwRBMG/mKK+dqkzDCmiNAyH4SNAB96pGxSGhTnnhXVvI8LW0d7RX55p9chUrB0ggWL+xOMXms3V9FXgOe+Q2pqN6VeQA/XE1C5cqW+lhxlnI+Ya2snXw40LwyYs96986JblF7FV51sD3rqpXf9ly7NdY2ZiDV2FMrB6Pi5kn8YUKz+wN/WF2MY6Rc1KRRqw8OE0ZKmlgg37zZcdWTSRCQ4XzvLTBpJIzdzAOIcwebGNNgK955hnaCZD9MxooARVyFSyHvX631Z70uR0cXl/BPkaXmugTUIn4ciKluWlt+uEnrWox47rw==;31:Fo0JCR7fnQI14hTZFyemJEC5Xyqaj6wH5+pZ22vyDPQ+P5Om4dBfg2IN2hAnfIPPwgI+IsKWgLVI6p+6bVFPw+6aKe63QKxqtigAVzc+qDaurjfYCwf59hsKop3yqnOvdDwLLRf//3pmFHhorxs9z97sUtqbJlU7PJiQdhAjHyaTfsUm3f1ym/B2izzGFpHQAQXcC4T1zeYK+mj71+KY/CVwU7RK5w/OfHmym2mzJBc=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:68YvF2QLWizPFTeXWGRTt7xaFm5qaHjWmVZo5FRTvAPHKKuQT6HSRvU+Eh4L1gVt7+Xj6Ux7NjRK90mjL+eoDZlhsBVMneWFpF/z4dD6vtboQfJph5dk6FxmhnXzbSyG4K/XrDE6LZCXXdu7IDm6Pazd72HYeF6gq44mzxgPg4raAjEL75/SI26y7KgQExfpUTFLASCqH1BIbKd+EtAyUFqYPx64705tsKDgFxDVYBwLFRE2k7/GQlprcaJTQyUYIvnhk1jpEqIrwetIqDeyMHgnQXK0/KCmRY4shrMepa2+rbU/kiSm4oNldPufMGUqMavCFyAKM8z8EiULOq6l6oaXwyJU7P/H7cGtjbygkzJn8SrMylHDmofVTLUavnWa3dZSZolamruRaRZvkxk1NwGGV+JZph9B39t/2NNb3GjHizq57amS3WjBPx01yrCo9M4odwUfRSA5BlbikXosE+E7I0cXf2jA7HnJGgm257GSrT0PFR1jajtaGvMa3DsF;4:UlBYKBr9ilPORnV/gRkU4fz27PpR7HV9NucA8ktz/IzSG/RHokOsEFRjVjD/ghxPRQzbK0Uzyu6SdfhadpJVe/fZaFV8lm4cDDZQzHlY0iA6czud3OCOnP6DdXsB+6bFbaULgV0oI6Hy1opBLPi8Illeut6M7nV+cip/pyZ+C/v0owYlPoZ8zklD+BV0Ffc0T8dihM69M8UyAMgdBu5VM+t3ryK1r9RPeRfi3nMmKyx/+aH3pbjW5NrWmIk6GzD/I7HUTbmgnf9vYrXAAc3i89ks9/BB7aR5n9d6BftMYGPjsAiV9SgZ9msb2NR7K08x
X-Microsoft-Antispam-PRVS: <SN1PR15MB017685BA33259EE90816C1CABE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(575784001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(5024004)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:g1lyjsRkPjpBhWIDhseHMDRZsgC9ZWnuWtCSuP+rD?=
 =?us-ascii?Q?AdB9pvhqz402h4BA4akOtN5Zkm7a8ylnCdEER7naMIO1XeI5Q13VSpe+GACW?=
 =?us-ascii?Q?yYzAbO8+XI/8RJlbjeHlwSa15sBDTdQafct5GdkFwhvTbMm1PZDlqi0gBQUf?=
 =?us-ascii?Q?HOB75UKiQeKJSEtgcHZPjB6bI8J87eep8WaY0hM0V14qTSea6klWTS0AWlyC?=
 =?us-ascii?Q?MIsCzW2+7BHpbIDuEFazGncmdjfx+taINz1zWsHQfVGAJ83Gx3kD815Beuip?=
 =?us-ascii?Q?fYdtd1RRNN3GnfzzHHk59dZIq0NdpPy95R1N+EVq5fe8Rkehih4jP4ppeC5f?=
 =?us-ascii?Q?u42rrZq5SpPONo3q6UPi8V34z3Ac7khLJfhmfYsZoovYVfhj0bzQIF/ND9hp?=
 =?us-ascii?Q?2hD11lxPN4g08gkjjzSe21fcErW+vDjCAyA4jYw3u0/u9tCVE4mQTaBVemXO?=
 =?us-ascii?Q?BU1zPFCLiTcFnrYqdKznQdcHSI+/3JRVupavBYTlwKywLVHC2uajCBvAR2+v?=
 =?us-ascii?Q?6HxF83Yrr4RsQesIKiTsmAcm371FFGN1ngzZDr2AZ6NybK4pSRYt/zkx//Bg?=
 =?us-ascii?Q?/bG9pUpq3DByzAByQJMdmt7QY68pLYL+k7A9RBCpI6Tx29BZpdXrAdiY4MmO?=
 =?us-ascii?Q?UKUTQIA/KRKUkCrU2AvY2/l4KK7XwMpaZ8rhge6zYCSqGO1VQSBUlncMmIIQ?=
 =?us-ascii?Q?rLSdOYiIHFvDLf1z6YDk1w7nlt/7TzmAbKI478awR5vc9Nnyt8KX7LIa3LDH?=
 =?us-ascii?Q?xLJRivZsS1iSlMABpwHi7RJtJYas40P2uCefoud0J8bbm3UKbBYy362V/laO?=
 =?us-ascii?Q?3fQRFrCM4pPd8Ruw/Oyp9I5QUgbqYBbbtXTlRdK+I5K9OINgOhihAoAnESEF?=
 =?us-ascii?Q?qmIxW0j42iMOT5JPAl97BfGT4vtsrTH5hta0szMPytgbDLo4q33RH/tqBKeR?=
 =?us-ascii?Q?fBwwWgtQ5HM71GcXPmimSLhF5GAWAgxGnEOJYTIeDHLHp+ceqnBe/O5P/gS2?=
 =?us-ascii?Q?x7j7WqIN1O3E1dNQXIA03G9yFTEu/WXAskb+q070Bhs/B2oE4ER8SzNl/aVq?=
 =?us-ascii?Q?whyxBCUm/+LbVnhllddMRlv1uAai3mZI6kWuTGIOIcVIxgzNGfpUZyIncoi4?=
 =?us-ascii?Q?n7ev/ENg0jfjk1a/nig19u/1SUwjtVGDFrgKf2Dh1lmyHutqmyrpsSijyfLu?=
 =?us-ascii?Q?VfbuKNqTP7AUgmrrdBn/59FDiLAKapUptREGFFudtolJEFBxG2PqWOCqS2JS?=
 =?us-ascii?Q?5+4lJrVqWrMrbwg+s0Gqx6r0/FOLZ6n9OBCZokT305BEmMFp9vTyPyqfuwYe?=
 =?us-ascii?Q?dL7Mm+fdgFqd9/6hH7iL3kMiGaHZ3MOtLrzPaGD3jTU?=
X-Microsoft-Antispam-Message-Info: iuAkUI9kuTuk+Q5UxooOV4QYaYQeDBWYX5RKI3IxQMfSRUr9juma6tMAafr1Hhmb4Ft2gQHnbQbbkMYCOaEKoe2rMFnq2e6Lmahc973D8fEeT6ZaH35Qbod9oLMwSb09QoK5vfUjHPqPzTDA1aLJTdy3PYq2s2TLjs5UcwU4cWHTYUhJjePZep0BBX1vngQdeSKgJVZIdw2f6VVLuW0WR5VFeT9gm7JtXVmbn8WVDctnuLFbNWypdQszarEmuAzJ7ULJ0X/tEKp0y4ZaQFq83/F85tOxmFJMCCtX/HITqEuqUdeQYcPu2Mb22pFvrupPKbMBFBUOD3BrswLA9JbHBMYiL8PbfQCvF4tzdjQ0fYE=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:P7N1JYNtz5+i4LonSOXI+fNr4YF8qm1q4yW4TVREdqHXfalAoqbj1JZcayGzLp73B/sarNz0l+GhS/VQR3Ru8FQnB7JCvm/br3ONZInA6LZcYAH1zdYoIkmx4wiijQFx+alqM1ou0WOAVHxYERni4jwdoZqeiJnnu/xNtIQ4QtDv0gukPCMiCbZoZ2PNV6PDClie6liihk9LrFXtRYZs47k/qqJ0xi8hph1SnOk17ClOKKyMFh3UwTyfeDufxthJECrcaHfC2gdC9IWLCkDHuoevpyIbFaxEpK0o6uWkm+B96flbPqB/tzjLnE6rz6OQ6UF17kqwLa8n+uDzegWTJqMI3iH7sCkuMAcb8MnIEva9MQPYIAMDx4Exphc0RMDyierTu5dr/OOZ9HWs5omRY4n1rTKTMA1YPvnkzRdN/qBOws3LQJ1MHKNtLFtPsVLpZ5Df5okoZxUCka4sxslvyw==;5:iTrA/5RzuTzL0s44ZWwMKmU/atnuHbGSmYOQ7Bjdad3hbdVDPdrjwV6FmGetalecrojX9lODuTHDz5oDtlOJyCFiNNAfxbFTmOgiS7/fAZlqM76PpLTxJxsseMfHZN5c8wUxkfqBuqy62ch5Am9qSSga0DOPNIX12SNTmD1P704=;7:fyFCaoXi8YsGkknIpjoW4T1Qaw061iAzct2TxbpoZnT9OVw3285qyypiU9f0fcfPHJqsuonrzOEXialqHox2fcYuW/z7EaB4NEz0WmyOwwTTTAcbk018epfDP2gQDCXAf8n35h22tTKKIuXDKI4Ato7ji7j+e2ghPmY04NDv5FHeC+MjiKS6hgn3ymPxupjTBN+MwVUbCvn+JL9S803iVD3lPt/xmE+wUlyP4Iy5FHX396zOVZfXRfU+PPGTs5Vx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:L8nsHRZ9C2spC/2wyArJ7oltv1uNjD8MnD4/xTz0yHHKS8VLdPiEy8hnDn4qwUTbZ31+b7xBWGuCLiJQoxKcbMLd5pQ9zsUuvqh/D8nXvy4XRnWjtY6QyiLjsJ5Wr5i0rNPZ+pl5dkot9p7VIbV2daeMKy/+ZMQw/u5sYtc46po=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:17.8235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf7a8a8-21cf-49f3-a32c-08d5f7ff7a5d
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

If a bpf program is using cgroup local storage, allocate
a bpf_cgroup_storage structure automatically on attaching the program
to a cgroup and save the pointer into the corresponding bpf_prog_list
entry.
Analogically, release the cgroup local storage on detaching
of the bpf program.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf-cgroup.h |  1 +
 kernel/bpf/cgroup.c        | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 9a144ddbbc8f..f91b0f8ff3a9 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -43,6 +43,7 @@ struct bpf_cgroup_storage {
 struct bpf_prog_list {
 	struct list_head node;
 	struct bpf_prog *prog;
+	struct bpf_cgroup_storage *storage;
 };
 
 struct bpf_prog_array;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index badabb0b435c..935274c86bfe 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -34,6 +34,8 @@ void cgroup_bpf_put(struct cgroup *cgrp)
 		list_for_each_entry_safe(pl, tmp, progs, node) {
 			list_del(&pl->node);
 			bpf_prog_put(pl->prog);
+			bpf_cgroup_storage_unlink(pl->storage);
+			bpf_cgroup_storage_free(pl->storage);
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -188,6 +190,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 {
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
+	struct bpf_cgroup_storage *storage, *old_storage = NULL;
 	struct cgroup_subsys_state *css;
 	struct bpf_prog_list *pl;
 	bool pl_was_allocated;
@@ -210,31 +213,47 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	if (prog_list_length(progs) >= BPF_CGROUP_MAX_PROGS)
 		return -E2BIG;
 
+	storage = bpf_cgroup_storage_alloc(prog);
+	if (IS_ERR(storage))
+		return -ENOMEM;
+
 	if (flags & BPF_F_ALLOW_MULTI) {
-		list_for_each_entry(pl, progs, node)
-			if (pl->prog == prog)
+		list_for_each_entry(pl, progs, node) {
+			if (pl->prog == prog) {
 				/* disallow attaching the same prog twice */
+				bpf_cgroup_storage_free(storage);
 				return -EINVAL;
+			}
+		}
 
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-		if (!pl)
+		if (!pl) {
+			bpf_cgroup_storage_free(storage);
 			return -ENOMEM;
+		}
+
 		pl_was_allocated = true;
 		pl->prog = prog;
+		pl->storage = storage;
 		list_add_tail(&pl->node, progs);
 	} else {
 		if (list_empty(progs)) {
 			pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-			if (!pl)
+			if (!pl) {
+				bpf_cgroup_storage_free(storage);
 				return -ENOMEM;
+			}
 			pl_was_allocated = true;
 			list_add_tail(&pl->node, progs);
 		} else {
 			pl = list_first_entry(progs, typeof(*pl), node);
 			old_prog = pl->prog;
+			old_storage = pl->storage;
+			bpf_cgroup_storage_unlink(old_storage);
 			pl_was_allocated = false;
 		}
 		pl->prog = prog;
+		pl->storage = storage;
 	}
 
 	cgrp->bpf.flags[type] = flags;
@@ -257,10 +276,13 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 	}
 
 	static_branch_inc(&cgroup_bpf_enabled_key);
+	if (old_storage)
+		bpf_cgroup_storage_free(old_storage);
 	if (old_prog) {
 		bpf_prog_put(old_prog);
 		static_branch_dec(&cgroup_bpf_enabled_key);
 	}
+	bpf_cgroup_storage_link(storage, cgrp, type);
 	return 0;
 
 cleanup:
@@ -276,6 +298,9 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* and cleanup the prog list */
 	pl->prog = old_prog;
+	bpf_cgroup_storage_free(pl->storage);
+	pl->storage = old_storage;
+	bpf_cgroup_storage_link(old_storage, cgrp, type);
 	if (pl_was_allocated) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -356,6 +381,8 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
+	bpf_cgroup_storage_unlink(pl->storage);
+	bpf_cgroup_storage_free(pl->storage);
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
-- 
2.14.4

