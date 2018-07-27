Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECF1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470AD20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WJwTVDtb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hj0Xt83l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470AD20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390001AbeG0XRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:17:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52350 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389963AbeG0XRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:21 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLjQuL006591;
        Fri, 27 Jul 2018 14:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=KYnSp7NsKyMzyHdhSDtQhVvHlpJLTQwyiFaE9Hw63ek=;
 b=WJwTVDtb67URXfV9hLUJSGaQzSAWfa6+bUdJm49UcKpcpOUw+4eOgPBBI97A16Cilg6n
 B4BL4NPICO54QL2tJumQtDR0j7hAkMCWRlVXqCkqkCU4JNy7jUu06rJsyZiJKIw/Prq9
 M2AEb8kPVXiN3XgrBP+m4qFIepF0tVaMZhQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb58r2md-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:17 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYnSp7NsKyMzyHdhSDtQhVvHlpJLTQwyiFaE9Hw63ek=;
 b=hj0Xt83lUeKZ76dJS8020FsIDkIoJsWCcqqOQVdQQHSWERgEkEINmzuyJNEq2XP3FghzbBdNJsGDT33Ev9kxgtHuViJ1s2VEtpoNlDmXh71g0MvkncJqv5nAmLu9mzAprVsmqnzGO1QncBib4Q1Jdp0KhVAt8/3CPgQeUb8TWG8=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:03 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 04/14] bpf: allocate cgroup storage entries on attaching bpf programs
Date:   Fri, 27 Jul 2018 14:52:33 -0700
Message-ID: <20180727215243.3850-5-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180727215243.3850-1-guro@fb.com>
References: <20180727215243.3850-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:fd07]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81df6ab2-565f-4211-5f2d-08d5f40b540a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:41AvWbOErmb8NvavvanfICb1ZIpP4sVCql+NovKP691wGB0/b9dbH3H8Gj3aV2xOT+N9eGn5zi2Kf3hf+WE38kz3sI9MNzVQfjPdoyrrh6C+q8mL2h8WXw1LNqozLUGJjvAThvT2f1slJF82vKytEFQC7CZVYLOkKl0VXMjNIsvE1DQ7pLLploXAy3uN3jB5FV+Skr6+8AmMZMDZjw1WNlaOIPAgeCAgvA11IlFDijOmRjj95Ohbls84Q+f4hL5+;25:oTgXRbbhYRXFQc5qR48Tega7yGd795h4HcwZqbymj1KkjwNCCJVompIfeUg+ECUZ8C/xPl2ZWx7C+xVEI3lait4RQITAMHni2mVnrA0pAal6IJe8vhJvKfYMZuvdUoSfnjxjJ3tiWgbNRGvwmdty+Ect1OfmfAroz5xFxbf2lp0ADhdlDNxzzFWNSF50z0tfzx0I/HJExXW0dYYQ/8M+xx3E5DCLAkoH0lO2oDQXvuRCkOwCdLii5gzeJ6IB5aqHz32k+j3C4kOHad7TMw7ZRGML2VxJB+8c7AkveKQn+xcbellVDRLzUM3qDMqJjqvxvgll/OiTyGerPhY3YhzUWg==;31:UcUj1NRUEbC5OmfHf8QHNgsl+iJ94+BgWJxrRw7R53vDKNGn/gxv5Mgz+vvG1OLQADBwNLPjugsliC7nj7ejA+PrVzGjZkZV6iBGsCHaSN3N4xehERYBa1wIkRzKkRlJEGFAmHwp8zeS3DLQq2SnNs6GhjvHCwwTGOY5pOWqfveyJGamBzJ9DXrRxdNG8KhIArD0UifIh58GKlwosddQqDymOKHQhuPEitsq5b6xlqg=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:LRJJqRqJ2N4fjQ+8KbTOGwzqJWwjjpplB+aF9rz++x8Acoin3WMRCfW/L7dVhd2qGPOpNVZSeUfJ9Sf/jWBjCRA831bqj87wwENzOQeuq3HLod4fsoRVxmntoPLyUZj6lM4Sg42o/wrlTlVrHZOx3aBOiBJpPeoJPyuLKHDkFyJWaM4Ok4dyZEyaZprxMjbkgva4th3Na8Usa/TfvA0EnPCzXWxXCqgpTOypI2tFz/N5pNi3IOSEdUU4Nqf0sHaiZG9k34ff5veQ28tXY+7YCfymadW+PDN5s3ufZUB297UHvoeOEbjU0PTahStRLK0+FfV6YUQS8cqMEXUduRvZnzYW7CB8v9vYVW4OlUzn7HP1JdRmYUoVCxd+cgk3xxMl4f11R4jUElS1Tc2gpy83WEO6ASHAFHIdO96Fequ2KudbHHxKSOeWUTMeLJ/N0tCjqNBYtTrdPUfuT2acOfY/sce9PERcpkxwpZ5nXgIAIBU4EFMcepctvZHfwwvA/XWS;4:xZMNZduoXGgCEcjcE1JFUObB3H7FM3AX+2iBSp/DMg8BwB2wx+7POWeTrM08WOZLEsROyJaCAUo7BPcmHejDfzAhovlxlN2oLCmoBeN7zTzyxFxcangU4g50L7Q+RP1oT3GgLznFiWtpmT9R4kNrafD6g70p3BIQ1HHa4zAK3DDKBVu3U4AA38BwSCPHgZR+z8GsDytgvozGp64jZedNR1idYp9cx+/fnid9OmvtMqyNmYng2uu+rTmAGmRnFy8CS52dg6ImqwnyVxGh1c8+PwY8KEcRQ6b4vrMDwA/NBwNtl2FRYqYj+JlzZbC4ZaFr
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171819970D78EC20CFE793FBE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(5024004)(86362001)(575784001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:7vu7VBCmg3p5tAMQmAj3qL0YWBEkD4+/L66rAH7Z7?=
 =?us-ascii?Q?2Kw372O1gH7Ifc22sJMLahsqp1hWDZ1out+GmzmSNA4YI4hb8ntU605xtVg1?=
 =?us-ascii?Q?dCtuX5oG325Pp2QdBb98Cyykz9SFXRmVwAYrR5ibUPmpM2ueeOgmujBb1VS5?=
 =?us-ascii?Q?HlhubkVeWhcmrXpTtSxOLG182YE+aTeQbXkohzDqCwCqqVWdlxjtRyk2DUSm?=
 =?us-ascii?Q?4Zb6Adzl7CgPkYuANn5xeyFMctmbJCHbUe90jwlUzpmE+Si0B2w57cZldyA5?=
 =?us-ascii?Q?op+LRj8Mr4lnpt+3E574/fOyAEjAM9UcyU1gfPuDGdfKwhZ00+pPZkfiOn78?=
 =?us-ascii?Q?9j3mLgAPg51AhzWOsa1dXxhw8ERlsDnz4GQe48OfyQsM5UHhL39aUC+V5Xpo?=
 =?us-ascii?Q?X+Laf6oZ7T4iymkWmsKb6ZvuCaOJslOyroEJfOkpV9nV67Qnk8EQAXuzyAjf?=
 =?us-ascii?Q?CrRLpgaAjQy/xnIHuLMg2Q/4o9sRW67DjHFU+ugld0oo5o28Spy2+qp+x6us?=
 =?us-ascii?Q?yyWsB/KWZece55TuOuobDFzm/JwclwyiP1j3J0JJWIaGxmKP5QRR94Oa6OY+?=
 =?us-ascii?Q?IP3ZOsD/GbWdqPjNSKK+VMxKAwEecCiQbZUbjQoc2iOmRvrhQVRUor24WtdH?=
 =?us-ascii?Q?YthjO8JZK+7ZIVGoLbXITik68hNz46tgzlFase873IgiA0FzP/53JxE3Wauw?=
 =?us-ascii?Q?ZYAdUYf1JdAYTG3xdyXsBPjjlVjUGzk0QwnZOcQC3caAwhDw6dhPdPGUFtxk?=
 =?us-ascii?Q?EaFhvvYJIluB8wN/uN6kqe30NBORcxxdf8mIx9WjyHrlLjgTey5mYhgrKwZB?=
 =?us-ascii?Q?y708RGf/CuzfgtZ17SFzkDhC9YhCFW2jLDTtp3SncN+kptxCN5ml4rYuo26D?=
 =?us-ascii?Q?PKWJZNtrKD9ml3HOcPWFG08FuHvqtWEyQDVv4CbpBqTlFjws+4Z2tvC0WzMC?=
 =?us-ascii?Q?w4wnCUooKETRiF6qZpBJVw0D5XnHPIa76MI3pmwNUOKl/rNUGr+J/EN2/ivM?=
 =?us-ascii?Q?tCXEudlDtKcO+g1CQpgmB4TSbKZyFoxQmqINzvtAB4yuUtWZSLixXosm1VTz?=
 =?us-ascii?Q?BivIi9e0em2LssVzLfir/wOZQJjFZtKHjNGtLR4zJxBv0dP6uccm6eIvFD43?=
 =?us-ascii?Q?cq6HtzuOv1zy8rWhSXK3lAqbo07n8l98xrx3k6pzldue1arDOnnSM56K2QdU?=
 =?us-ascii?Q?M3A5rKziFTVDvfiIEC5CNUwRVn1KZJzbCtJiLmmjliHnG+yYy5LPMH8j6EdA?=
 =?us-ascii?Q?3M2KeamrZftjiZ8MP2wBfV0f166nR2aPWqfmvH2fLJhQbytHVLPcKdPizH7d?=
 =?us-ascii?Q?TKH1YZVtwR9B+SNnWuUMsxnfC45xzO/mincnxnuVXuF?=
X-Microsoft-Antispam-Message-Info: v2Ae+HMA7jNBQV6wvVMOPqHRMPmkQ+hU9xDu6nYntVgtIqOE2FyTrWmAkWTyKLa0g/DkxRR6JFwa7KC2PaUEa2RfLI7o4fmoDVT9bNPrjuTGOfzWTrIUru4TWJYqpC4gAxKThN8WZOUvdjF6s71ulOUSzXpLIiYBFLUDSoeCUBTX/yx/ypximb1ncvMexbbDIjz47HN8pTLAvgYoPLinZhJrBa0+YpRSY9QKYq7noMcggVCDk47WVtUVeqb7YBbnqg6G6IM/HDf44X6bRtLmzuozgknwPuES37LHfLEVDCaLzrk619MaI5f6uw7xe3F2Y7P7k+ZJkkyKgHDrHPdo7eqUynT9rQMxYE3xdFgcW/8=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:A0N7+WK+0Hi7oscmjunmyM5ulsCkzUvgg5PLuC0QnexH3BplWnHXUHkvn7qyaZnA2ZKRd2xzM4SJyZQJTNkhwzxbhr9c4T0FYAACoU7Tgu8SQ6rYSqZzcYococ50QOWurE8G/woOu/NxZH1CtwXsZ3x+DB+QKd/hnwSJn1XAuv9XDxbimWWdjk/bXlPrBVQHQYB5HWLO+dpFPbEWfNRt7wsYIfLwGv31zXi/WTF8YGouCcjihpcLU+7vg91nCE7y5q9pX5gS6F7vBZnAgcH+wKb0Ocm7iqUI+bwUHGzq/KsbmaB3j16KTTBRs1+2Im7xznYnKIycO3aJJopROBHdR40YhNIS1+BLZYCQpB7F+BBGwryqSCMbI8Uwks8OpNvsHMZiNda96lC1eusGYgJyDt7kmO8PPtPN+6i00EKf/B1LLrHLOfM5+aIiFq32lK5SAIqvEIIwJtN5IsX/4aA4xQ==;5:4UmwU/WnF8pIOSZqS3P4+eITKcCu0DAyhY+MYO8l8X+39cZpz3Pnucmc66aTIaKZE2HJm961vciAWvui8avNTrq70U+Q5tJansPeyR1Iy1YIorEhuumYmlRpUmV3e6RQPDrz/Z2QOTHMyUZDEWkg/YA6Rm6Dw3YBkPs+NcPOxWk=;7:7mcrl8My2EZvEcHXjROupigvGKXivDlEW/RYL5yve61/XWvCGXZepjFyEbLo4p9wi05AWzMG+/yrQDYwkQ/aDgF9m4CfUX9bLJmoyDCjQRuemlkTHOKM8y+rcmOwGsBcPN1KAYV5aHIJX5O3w41/AMxGTBXUqjhROyXQXMSDievKfSpSJ9pG7FRlA4FuKdYY7JF8Hqxbmj1uhl8bS/a+kfbCTmaE5/zBGYQyfe3qBVg6xULdv6saNCNTN6FP7Zco
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:C6njY12Jt8MKaJGq255GsWzWnadv3NEPXVyR+tw1teyoLLeiUKa33SipSVaxeZEPZ1/ZIFQE69u2fQF/gBDXzLIhSToueaZfu/32AsO8x3rjQ48M8Srw/PEUGzdVn3qe+UT4eZKOSVsO3b3SSdkC6EFkK9tdlqLf2NgCTgghZd0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:03.0113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81df6ab2-565f-4211-5f2d-08d5f40b540a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
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

