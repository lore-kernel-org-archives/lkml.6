Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0778C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2794920862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nJRR6k1i";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="czNZBWyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2794920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbeHBA1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:27:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58162 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732407AbeHBA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:52 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MbveH010033;
        Wed, 1 Aug 2018 15:38:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=G36NWQ4d7yccF4eIsCkNlqW0mu4uqv5ySe5S+f6doAs=;
 b=nJRR6k1iKeyUjeRSg9+PLssarD7jAy8Kte9MkXdJ+9Rek66+WkKWjLc6pIICYDnHlM5q
 Zl5zs9Dw/uNxEtFAp7rkQRKjp+7aWJjRxTfVMgAiGCWsE8p+mWD3BD9ubGWkuyXZICG3
 0EZNbmWo2VrauYXvhWk6tHk7JavdyKCUwf0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2kkfcvh9pk-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.29) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 18:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G36NWQ4d7yccF4eIsCkNlqW0mu4uqv5ySe5S+f6doAs=;
 b=czNZBWygKDEgXfQl6tFDYjvpIH5oyoY5FDNC5l+m3pDwoRi/JAGAHiueI8K/2lbDgkdeRyo6SKrgtr3Grhh6siLd2QEd/kWqN8dQ8AcKx8ppvI8oPqG6Tk7+MWZ5vaEQdk8UlqV4SqFDyu2sJtEYBdj9ABIl/xHmdc+pXw2wCjE=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:18 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 05/14] bpf: extend bpf_prog_array to store pointers to the cgroup storage
Date:   Wed, 1 Aug 2018 15:37:31 -0700
Message-ID: <20180801223740.11252-6-guro@fb.com>
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
X-MS-Office365-Filtering-Correlation-Id: 558d8275-79d8-4bd5-1f44-08d5f7ff7af9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:wstBHgJnMhlLmBTb6X2JqaaVd3JQRtI15BaK4PF8cRRuTRKWtsnstX4jlrYpKaPqGmMsxySdN7xUcz3fT89FJPBgX3OJ6donhDHjXQnv4UuBZDkc2omQ5QNpjwZpCxKgZzAYpkeIOABF21s+Vm2QUAe1A+ZhaEVQqobQ5Pz59CYhUanvqAY0FUfKKKo9/ORRuvKjTE7SeGGMrWfQNujE8FFdiJock7afYBy1boRJZklouN+EE6ME55zRuMnc2hhe;25:frzQv4+bOinpVF5dqUmDC6kjeWkjBdDutJP6c9+NVmMMgYnpQB+oiJYd+WOmpHvykdeGiIJOoZJBBtSdYGgGbqjqf3S9r9TmG843j9IDj6nvoWKqCaWZcYHVtWKk684eSOrxNiNq3ORy+y0HBI0zcEtChyk0GwLfu07pmdSW0vBJI3BDcVjukfvZLIYptXNbwBlea535lR89yxTc/JGnVzFp4fresOeCeL60kXkb5bwk1E4vbNyJPxUuJkD8QSXm1AiNMN3EmThlPgPi5G0dV+HBcOX4XKWjk/voLkmNe8CglKgSRboEMmBw6PjgF6cEAHEN+zhg5ORsn4VFdABnbg==;31:SF33TWkYgpjvXkz/NYeagM7CG1FHHnCKJ4Y6V0G3b1vESfPQbA0l9wNaMYCaEEoDdM4pB+Pda/U980bV+XKnutdWa/tOLEQCwOiP+aVPDMHh0cDyNpCfuLRo1UH8PJ0W8cLna92/dehF/BXRA+XgSuKvCT2puwQ6fMtspvBNPU2qKwHsPP9lctAHp4qqzTgVAhFpL7L8lGvp9q3fZZuM6BzGzFfrcVODG7/mi+Qgw7M=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:sl3/r3pqGFQJNJhxV1UGBWAAZtmqxpCTyGXk7iBSiSSC0RGHZkmMp14MoPkC3eK//vBErg6pWoq0ESxknhcD9QQJb8ORBZaOh+6nhwp78q9fAc5VjZMygwsUlN/GD3Ua9unXFjs2pXLAptoXm58YtemLo0Oeqxq6KeuEYyHD7vBKDG1UCuUOPcjPQsWwWz+xBkhEHiyGxn0WA2NWQ8WURiev/BP0ROZai0V6yiIx2ZCrkPaCCGqMul90lfQnSgZz0oQbJHb1n4iZU4Dodvqbd1EbFufiXeyAYSJl7MwUFp4RFxxdidTqK5gFuedSMFZxfg2j2GGhinIGG4qAJKpb8f8k1sZUG/QPpFrGVIclsF46VEyzLTyQBEcUvWe6CnEIEZOQdK3X1lLPHPKu504NLwunFpUOydUdSlU1+m/PTlfqp0rqZOfdxgxXYOFVNmhspRlMkTQmdY0urizCp8RI0DuOqqh9utiITinRvtKG8YQUlGpcdWQelYWRkbe5aZVn;4:gV9fqvIn9xFI/mkuzap+x9b14JyXzpLhmQT7N26AT+hn4ZlkF21j/YjhDTCbx1BT6+7RQ1FTGe1LoZVto4FgYQond9slUy5RT48oNBfCgO+YJJquYpSZjBGXaenkhkCmzf+90xiXkW8j0oaZof0nDQE9deqxtyBzt/RkIc0yw6mU8FVgf3ULZr+7gFTqTQmbclll4jeyekVp8RBao9KfL1RoR5n/OR12aAP02Ul2qW1dxxl1pQRgdfN9CIWuyqNjpuJeM7GGvnGMR+r0Fj53Kiiqamq3RTtUdRm3P4VFxRLXsAjVKxO5oQAjrhkIfHpN
X-Microsoft-Antispam-PRVS: <SN1PR15MB0176B4ECC805C921A41CF64DBE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(5024004)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:vKAq9g/VAuyYmV7RTBJ4Expe/UvKy7ibjxu6VXYfX?=
 =?us-ascii?Q?iij6GGCeEeRdVgDhswd6O4Q7rF1ATN1ggbaVFh0z1xV4QIBhtBCwDfRBKI8h?=
 =?us-ascii?Q?QJyTz5jJnOSDCrenDm5waX0xfVE9Z1LCggBXGX0gdagB9aiYEVNq1RQV6phn?=
 =?us-ascii?Q?pVpRy1T3h1XD8fbkcLKT/+3t8QanuLVicCCLKzdPZlLGo3sx7Omj9YGJlW88?=
 =?us-ascii?Q?oretJRFI9o7cCB37seoBWqfW+2aXRFpvOxrOSpw86JaclZlU13wjsS8rLkiy?=
 =?us-ascii?Q?VvxEUW/WJFII0BsBX4ETAiUbZZ9qkGUbyMzcFtSk3s9Dti4E8LpFHzLODhqF?=
 =?us-ascii?Q?++kKNn/AwkbZdwGspEW2Y+nXA5kITxOqJ+0yRMJioHL3q5kCicdMNvItltsU?=
 =?us-ascii?Q?GZ+7jBT7hI4SH3unW1XZ9bspdAUCI2llZXLfnhwMDbs06CQMoitdHq3JxNuN?=
 =?us-ascii?Q?DLQeVzjHJXAWK+ZHD39NrXjNOSo2EgMfnRD9NgwaksMp2YDZWyHCMoeXE8Uz?=
 =?us-ascii?Q?dlYN7aSRQH2QXe6BTZOM9Q0o9RsLFTQbSN7CKmNMUK4K67ozgzw4Ao0l6Lq6?=
 =?us-ascii?Q?kdw7letEEhlzJo8jZyus8wjbcmRaD6yE8DwPo06OpaM8hFbCIuMwzTP2pr7v?=
 =?us-ascii?Q?7SOOkpl4+8xZ/PyqNc1aS6GS5GcoKyZG4R/GbYko0BnEPJWOUAwgW7wTjjNi?=
 =?us-ascii?Q?O+mgMEb07Gln58Hm6ZDGo8tNChmaXZAR8GX9zADygmjzjVqjv5TIzoP7cwZv?=
 =?us-ascii?Q?PPy6IAM2UoQoCUcsQ7dZthS6d1Wiripxd54Ea1qkjoqIEguyTtCNCBzQlmI1?=
 =?us-ascii?Q?JU2yODOpUVnVFS+hBLnE2UM1G5Zv5b4d2ML+R6xHyeIGFA2nzPwHm16I94oP?=
 =?us-ascii?Q?JeSDS/FRTLfvrOl/FP8ug/vwfcwCYRP/XWNU7YSwh760IdvEB5niZuphbLuE?=
 =?us-ascii?Q?YbE/xfql5/AOPE4gyZ+TzgZgsWgZS1or+7Y5HhwnV+J9H8wzW/xKVGt3b8td?=
 =?us-ascii?Q?F5VV1wLI4IZAosQTl0eQNALTVuI+BO/HLDMJQIu4RJLMj3+D3MbqxQP8CJpe?=
 =?us-ascii?Q?9QKEgUupwoHa494Zztxxx799HKAWV5zoBv+7rjxQo6+lyw2sLiDzX7FnDOjE?=
 =?us-ascii?Q?k8hHkgfpbVxVuiZFUHxICjKrHWS/gsYLqv9vDy0RXwkANgUbJTTIpfrZ9x84?=
 =?us-ascii?Q?shMbcck7PAdHK/9HvdtUI7G0iDmJTJeF/2UBSV2afdnNxNBlrFmlGrCfQPn+?=
 =?us-ascii?Q?tHpezM4aE2ruyZSbUOf3tqdKAiRVvs6y7scxWDO+eatBsrR3l8TM51afa1Ez?=
 =?us-ascii?Q?2KJsSeLmUZ0P0dWEyyfJcjJREcRAkOrHxPRZeBT9zsF0Ji7X5NVYdkiEWSSC?=
 =?us-ascii?Q?uptJtb9Ioy1/lBblDXW30jb23BQYEK9o8o5HRvPTWx8gWtz?=
X-Microsoft-Antispam-Message-Info: STLbxi/2+dxk8NDCL/bfio/h4k+mitFfbeDyUvvtcNVVhsCjLeweygpNMNIMCzYVr80SxI6kvj+Wz789c/ycDuQaG3kiloi7M80GYB73uUx6jz+cjccnpzTd/kVDiLRK61rJjQWDzpQZDde06GQc8Qe009uLk4r3GlUwB6uINe0rQIvMCxwX6WRl748kwa4X9nr21kJVFCAdGlqumSg5s5nlVB1R629ynEt8pQ8iOP6gMtlw/2zb1LUFLrzoJqRoHlEW3nuW1ijbqWpkUqYLBq6d/zCjRLRZS5P4+NF04iAMoGWLHje5xmwGSp0Wi1YTE87GzcDMs6oAgPsQBYsmUFUyEo91bpyXRmw29NeuxVI=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:pwbnwtahG4k8FZlYX+nX2sYgKAw6jcDm4S49OstSyO7G1RIAfiWFOwtnGbZZILVJca0omoV4SS0vVdZSJuQUq26x0NB0wKQjwwbS7EZlo2K5/egGYBmvOpHHd/jNG5ORNJt9hFk5SqNe6QZ79r3NcCw1UcNH82nDXxCFqKpclrqyzhbF7tpBeY9jfbkPADWFJVDQSIVEUBYQzqRr0eMmHvd8HtTnahzCU6rd/YayCl+WnYeRC3qxQk7hr9Ck2d1fqU6DQDEMl5qNEYxlnn3KFEPAbLK7f0L0fMg61QD5QfKstp3mPJV9INYIeGgpG/O7LlZ0ceQiTiotudLT+WqdQEFJV0XyH6V/29CF7WsTW/0vI4GlY2zXEDtJ4xPZVJsR1US2DVoP/gfYmqXfuBHCnbXyqtLNPCTJx9ogDSXFtUUFEw81gecahJ2yXvlrcaR+83pyplgBKeAxFe53zH7cdQ==;5:4f/y4ghNpX0K1R/otUe72noD9EdQcSFNL7pl1EOLP7BlEPSm1P4Q6qR+Y3qx4FbkpVkpnp3etuCPOHIKeAgq5CVdAOurTOEkUoeHaVj8EzGhLiiWSNE6RH5EBE0Oqni5SOv2Vdg/uxFa+aFqjSptfIxVH4+JYRJZDlahOPNr2CM=;7:5zHEpYn3BjFpxgMOVMGMQ7Oyg8aCD+raqf/cQ1S2HUt24lhIfKFQNpehzCuIzT9QsMA9XO1/kNK6Kjgda/QhJjAVfbBR65K48bqY6ZVZX/m5PxF4It4kg+gWwoBxtlSj9bze5lm+VxU0fMsaC6u8xVYpn6iQCzUzwoIqOY6tCl9qLODxzWf+cJPQNUAwULxKkysL+pyZpM7QlkfzW5TtQ8Xg4GsIlKkmKAVGK2AM2hOni/pXv6iESL81aRwNY/O0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:s5yEJiX59r2FzipfgI4SQqhlAAwDYSuLPr83T/vpEZr2ZvZCpWe3FMMPqxuJ+aC3KLsPAl9RxeyTt88oUFZEtoMYLIaK6NzTHOuHFNZuVs3C/QYao+Yhm9tezemRoT29HEkqxLC2/5l3d1KNMkmm5BudM6BMmlk8bnr1Q6TJ278=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:18.8485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 558d8275-79d8-4bd5-1f44-08d5f7ff7af9
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

This patch converts bpf_prog_array from an array of prog pointers
to the array of struct bpf_prog_array_item elements.

This allows to save a cgroup storage pointer for each bpf program
efficiently attached to a cgroup.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 drivers/media/rc/bpf-lirc.c | 10 +++---
 include/linux/bpf.h         | 19 ++++++++----
 kernel/bpf/cgroup.c         | 21 +++++++------
 kernel/bpf/core.c           | 76 +++++++++++++++++++++++----------------------
 4 files changed, 70 insertions(+), 56 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index fcfab6635f9c..8c26df9b96c1 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -195,14 +195,16 @@ void lirc_bpf_run(struct rc_dev *rcdev, u32 sample)
  */
 void lirc_bpf_free(struct rc_dev *rcdev)
 {
-	struct bpf_prog **progs;
+	struct bpf_prog_array_item *item;
 
 	if (!rcdev->raw->progs)
 		return;
 
-	progs = rcu_dereference(rcdev->raw->progs)->progs;
-	while (*progs)
-		bpf_prog_put(*progs++);
+	item = rcu_dereference(rcdev->raw->progs)->items;
+	while (item->prog) {
+		bpf_prog_put(item->prog);
+		item++;
+	}
 
 	bpf_prog_array_free(rcdev->raw->progs);
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9d1e4727495e..16be67888c30 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -349,9 +349,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
 
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
@@ -372,7 +377,8 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
 #define __BPF_PROG_RUN_ARRAY(array, ctx, func, check_non_null)	\
 	({						\
-		struct bpf_prog **_prog, *__prog;	\
+		struct bpf_prog_array_item *_item;	\
+		struct bpf_prog *_prog;			\
 		struct bpf_prog_array *_array;		\
 		u32 _ret = 1;				\
 		preempt_disable();			\
@@ -380,10 +386,11 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
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
index 935274c86bfe..ddfa6cc13e57 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -117,15 +117,18 @@ static int compute_effective_progs(struct cgroup *cgrp,
 	cnt = 0;
 	p = cgrp;
 	do {
-		if (cnt == 0 || (p->bpf.flags[type] & BPF_F_ALLOW_MULTI))
-			list_for_each_entry(pl,
-					    &p->bpf.progs[type], node) {
-				if (!pl->prog)
-					continue;
-				progs->progs[cnt++] = pl->prog;
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
+			progs->items[cnt].prog = pl->prog;
+			progs->items[cnt].cgroup_storage = pl->storage;
+			cnt++;
+		}
+	} while ((p = cgroup_parent(p)));
 
 	rcu_assign_pointer(*array, progs);
 	return 0;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 253aa8e79c7b..9abcf25ebf9f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1542,7 +1542,8 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
 {
 	if (prog_cnt)
 		return kzalloc(sizeof(struct bpf_prog_array) +
-			       sizeof(struct bpf_prog *) * (prog_cnt + 1),
+			       sizeof(struct bpf_prog_array_item) *
+			       (prog_cnt + 1),
 			       flags);
 
 	return &empty_prog_array.hdr;
@@ -1556,43 +1557,45 @@ void bpf_prog_array_free(struct bpf_prog_array __rcu *progs)
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
+static bool bpf_prog_array_copy_core(struct bpf_prog_array __rcu *array,
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
@@ -1611,8 +1614,7 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
 	if (!ids)
 		return -ENOMEM;
 	rcu_read_lock();
-	prog = rcu_dereference(progs)->progs;
-	nospc = bpf_prog_array_copy_core(prog, ids, cnt);
+	nospc = bpf_prog_array_copy_core(array, ids, cnt);
 	rcu_read_unlock();
 	err = copy_to_user(prog_ids, ids, cnt * sizeof(u32));
 	kfree(ids);
@@ -1623,14 +1625,14 @@ int bpf_prog_array_copy_to_user(struct bpf_prog_array __rcu *progs,
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
@@ -1641,7 +1643,7 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 			struct bpf_prog_array **new_array)
 {
 	int new_prog_cnt, carry_prog_cnt = 0;
-	struct bpf_prog **existing_prog;
+	struct bpf_prog_array_item *existing;
 	struct bpf_prog_array *array;
 	bool found_exclude = false;
 	int new_prog_idx = 0;
@@ -1650,15 +1652,15 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
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
@@ -1684,15 +1686,17 @@ int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
 
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
@@ -1701,7 +1705,6 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt)
 {
-	struct bpf_prog **prog;
 	u32 cnt = 0;
 
 	if (array)
@@ -1714,8 +1717,7 @@ int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 		return 0;
 
 	/* this function is called under trace/bpf_trace.c: bpf_event_mutex */
-	prog = rcu_dereference_check(array, 1)->progs;
-	return bpf_prog_array_copy_core(prog, prog_ids, request_cnt) ? -ENOSPC
+	return bpf_prog_array_copy_core(array, prog_ids, request_cnt) ? -ENOSPC
 								     : 0;
 }
 
-- 
2.14.4

