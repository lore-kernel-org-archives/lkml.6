Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8000ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A162087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eIue8Dtz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VurghPpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A162087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbeGMT6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:58:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39656 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730149AbeGMT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:58:00 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DJcpc7013895;
        Fri, 13 Jul 2018 12:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=t1UQxPEtkjAl5mkC/90yoJAEQtIZvQtPetPysB9zJTw=;
 b=eIue8DtzKuvwLWS7qKR+nkeR5PlB2W2xpqXKJ7KVPHiX4wNmtaZs0S3PY9taNeZB9MB0
 9xrya58FGlogEaZNS8r+luJCcvNjG9SuINA0Pya1hDpg7A34+UssNePwNV17YyOL9H1O
 shdDYlqIT870mMS9/2v3+Nfs45lM49Oc9A8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k7075rd26-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 12:41:40 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 13 Jul 2018 12:41:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1UQxPEtkjAl5mkC/90yoJAEQtIZvQtPetPysB9zJTw=;
 b=VurghPpkcKw3IiLiq0Nq7qZ0EWmjswtEcVhiuxHc1a82NMsS4MrAyMwthA0pB0BDrEVpmFrebvuJA+sz0U4RN5NppSC/PUMi8KwEh0CRMpA+y6kjPR+5brClqA4MEPcN22SSrBpfLvC84wbnEe1RAjf1PtjbhsWMXHQIT/ugFuA=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:1cec) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Fri, 13 Jul
 2018 19:41:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf 5/5] bpf: add missing rcu_dereference() in bpf_prog_array_copy()
Date:   Fri, 13 Jul 2018 12:41:14 -0700
Message-ID: <20180713194114.2711-5-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180713194114.2711-1-guro@fb.com>
References: <20180713194114.2711-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:1cec]
X-ClientProxiedBy: MWHPR14CA0063.namprd14.prod.outlook.com
 (2603:10b6:300:81::25) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cf18761-1830-4736-a267-08d5e8f8a3f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:G3JKIszkG2n/0cg4P/E+T7utURslgLSsCgRU/taQWesAWsPMU31j4APC8uvFqICIRbPNkESaoKMym8dlLLejum4FH7YyDGd5guWQ6rqhPDe5IUOAwx1rZ1uJiKY9nql/9EkFgQOWwXvYfJfh6/niXo7KsLXKPhIxihbpTE2fTpr3WsVvmaAsbecCj83oZopL8GRgYwunBC3/CiC5swe+cY8fO1n5W0JouBHDFvLPtPzyfv0Vzh+WdWqttuVMjEoC;25:xQlpZLR5Q7rce39bczRUpFg7aDbRgOZjsBcCjdO/ACwmn1141oUeiTK4ri4rswOQJI+8qfK5DV6ukvG9YIkkduu7ULtJMAlL+NKyMdqJ9LwX2ymzqFTNMBA47RqM5srljGGvY+isfGCZPa2vWstsS5wh7vGKAYfs0Z1TydkXN/ArUOd5ZGaMY3Rf726MU/KylPnewVgvJM0UdLDMH/xkkALoOcL4GrnmTNqAicT5eZkS6zObmZL/nfJ2QV2X3aXxr3Zddm4UxWvBfiSfwPdONLheskT58iL1TS5rlfot3/GoVBxpJ6AjAvF2BfBe4bBlc/tm/Fo+H8dITfFZqwsG7w==;31:Wqct38kizuZSc6q8ikwt9Yn9ikgszWNpqwe44LhwlJq5vNNl70yDsgUXERNZic4LxX/Aq3rkymPqgj3c2/JVtc94vSCDaxtwho+mPXyOxR5N/p+moOttI+n8uw154RFQlgIEkcDqYQrR0L8WAAz/L+woTDMZylghmHBCJFdr3JDCEbUDQcwqt2f2gM5lT7y9SYkJfYbcUYEwXvG1/gle3DjPBBNQT7vGqZjjacEUSlc=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:vRzn0JUZb7NJ0F8H/twBek/KQDl4q3mZrcubAnQ8wKoHDipx6ocaAcKK3BLyS5GYP/EXTZ3YYDZ1ZjECBaz6elwiZhNB1TWsYaQcI13esrT7FEtWC+HsPGzZPCGbi1PhKtXQkhG9DsbIqhSnLUQIdRzyzsXXCr6tvw5N45AszQ5rgJHxybSCs3YBD2nWa0XYu9/Tt2bBfz6PAVPYWC6fQoOL/vh4P88Gg+SNcDjFuoxy+XY8jGciDt0TUdkjkeHH4ua9A9fJBeOroDELU+NfGdSyHTHx5K906huU5dh2BW7pIOWMqrDaEMd3EvxBABe3EjXM/3MYiH1gctSBIEYFMpykurQDn5pxdd84OKmKICoYWBPD4HFz+m1IdrpFnRvwRBHXG/d+vC+U1+OiIn6PKXCrnjAgx/xUmjmR/DkH0ei34ihS5iucsuWyG6fEClaAciNaRiY9x7ySESUrPZMT38qd7uIP47AW4Tr+MJrwwCtGwl9RSfdFz+7creNeAZfY;4:6JzK26C/BWdK7gv9wnr8bCutzUgTRGNE4MiPEzceF6di/gk1GV0qnS7gTmk1zhNLDTF0iTXS94BSTL57SFVq9R9Cr1Lg0eV4o0S+E2BGIFTlRfJgasbiUFtHoJFd7hYAN0Qm9Rsu+xww1O3+w358PZUyK7fbuGwQLHCVU+kkZenEMdbj884ifdg3COUjIm5ox49tSWbMtjwJfvkA25Vm21cmk1/x7jkmKQZf1N76z8qxO9Nrqk43lE6JpqOD3WKWudJMU96auMtdGgkR84BokRTdQNEcGkqAoDgz5PSiwLRZFGP6L3lSeFALbiP8CQIZ
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171AE9C5B1C5A85504635B9BE580@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(53416004)(52116002)(16526019)(6506007)(6916009)(14444005)(50466002)(48376002)(386003)(6666003)(1076002)(8676002)(46003)(186003)(86362001)(6116002)(5660300001)(69596002)(8936002)(47776003)(6486002)(305945005)(2351001)(7736002)(478600001)(2361001)(81166006)(81156014)(105586002)(50226002)(76176011)(68736007)(106356001)(11346002)(54906003)(51416003)(476003)(52396003)(446003)(5024004)(2616005)(25786009)(16586007)(316002)(36756003)(4326008)(2906002)(97736004)(6512007)(486006)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:UV7LpG+dzk12eD6xuTA4D/JQPFgpdEBZtkyZigOwM?=
 =?us-ascii?Q?IMIocuvglNhYP8Rfq1y4wZ8UTWl/elXslRO9KOlsQhfq4gDqrIwjOqmR9Pib?=
 =?us-ascii?Q?jNDkxTNJNGTbJSTCSQpZe6J3FlIYlRG3EuSH+Ew11VYkw6EAi1BUE8L20rHm?=
 =?us-ascii?Q?VGOwUthRl5ApO9NkrRbsfU/rSkr57mvH0AG2sgvh714/r1sDD+QPBJOPkvju?=
 =?us-ascii?Q?fftH0QZJFqquwtRzswcJBXO+IVQUQisZFCqkCUzA8IvrLybgI9EjNzdcp//l?=
 =?us-ascii?Q?zGFS7bLIj0x9kvdwBLu5qoPOJdAYJiat6CBO8A1r6aybzKUO6cbtZWdT70nl?=
 =?us-ascii?Q?6tJEB8wTIfZLDewmbx0/oUIkmJh9C3PXWcUKNJQDOQJza1mHsdcyQGHGksok?=
 =?us-ascii?Q?5BvRoosNiQWEloTMqlEeOAvNrFLP5OJlPK8UoVRjjiK27HWM92m+YUyUJIaG?=
 =?us-ascii?Q?nADAZ+2iLvdFLWmmBMct0hjrs2oKITbYX9I29nSn2V1tiondS+hzgWo5Om6B?=
 =?us-ascii?Q?oltUOhRRfP8PvKmyprfA5F5mb5XRHtrbIXRWLS1ADZQtkGoxKlxmDcKjARJr?=
 =?us-ascii?Q?BBpPTxtejzNBYOwQx93vtMQpj/OXgImYnxD19ym2a/VUA02YFIYrssOUB+FD?=
 =?us-ascii?Q?UPE6tyle/wICTXGhrl7rsdX6IwxUzuX8wsdw0pTEUoMXmJZd7+qAixFjM1cW?=
 =?us-ascii?Q?90ys6v5iTxFLQaz3taJD2+yHke2xCCijdGEZvLf85sT48Be2yND+gO4FYtFi?=
 =?us-ascii?Q?xXKzR3nhDFWLdtBYTmShtbCCv3C+iRZ/YPYA24lPObv+0gJOlmc5wwFt8vu6?=
 =?us-ascii?Q?DXMC424XV+M8ybJArqS0ql6CGIZMo7jpNSIakQlhZknLaZw8k3VrOTZjcyLE?=
 =?us-ascii?Q?XPgQFhr0gPRJGYcxSJ995FTjGNu9uUjJEFzZPJtpn7LySXgz0NdQfeEt2Tq3?=
 =?us-ascii?Q?Tr1nM9YCWSvXUAUwodGvffUO+JesRDWI8vK5eisdg0Q/fAgP1aZyH7uKUxcv?=
 =?us-ascii?Q?Vt/ieY2rnQ/eupNjHaWt/lTGgzy/712kNNus7RsO4SRjUBB3ShjrXzm0tjwT?=
 =?us-ascii?Q?Gld76lugZI+cXPSioDBdr+3pu4uF82/sHmkqkSS/dG0Z3o+aXdPP70sUwUW5?=
 =?us-ascii?Q?R9tP4hk4aWL3J6mvaQXBYT3WOU2C6SxF6ArDfLVDsfKuQhcIXgS5U6yFf8K8?=
 =?us-ascii?Q?KOQIrCe337ARYTLFOW1eUIb5aimzwGK531ku/pKkx2Hbj/gv8q3KrH56CQP2?=
 =?us-ascii?Q?nG0HtrhAE8L27MbjuZljO6eYFQChrAl/RSlvgqXabCf3LhpCHU3IqGxFumx2?=
 =?us-ascii?Q?vUHOpFE6F0wvUX9QI3RJJk=3D?=
X-Microsoft-Antispam-Message-Info: FvSTsS0UV2hYw5VO2Gv9p21uLWKE1u0TLruSYZt9FWwJon6/JSfOCguOom2PopLkjOfd3MnqDte85FFpBKBVGMJ7xFf/yIdsfEE66a7wgNcJD62HJIWCpfiI/X0SUji/M3g2WS8mwDf9OK3odxKjIPi4uqlb8pPUnbDVIQOh8MuP1tgrksoPchMulo8eKliBnCEzBt8O+sOiLf/Sltv/08BTDTqkqs8jDOrGcrZnEypnBEnLlmjwGJDjpIU7e3yHusck255Uqp66/Nj0csk84Z2BN3u9R9OMxGRq8pYK7lvkiO35uP8/z8UER0OKB/knrV8ZfdW66eGsE6WZ5KtHVrc6OY6/8ehcua4p3VO7+oc=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:HeXcUn6kHpZ5/w74jAxkCZR/QRhIvYsi4q9VFuzF5njPqixZI8IpsbufStlPlsLhrHADrctqlJe1wThQTF9khVYVIbS2bouzsZaSrlZaMiG55ThDFaF0uQ8rXMtET5K56c8GAAVspia5F4Z0XI9yXQm9vvtc7sQWo5Z6JZk29SGD0NBT5BSZRj6W8wtoq+lsNbK2PXy6ghCZzgurE/KI3wQdYcIegHa6h50Y6Fa1k1mbIrRMxNFtAMYRKO/wxatDE7jgSgVQ+ymRDE1PQvysdDmWo+nHk2srZ36sgKrjCi13yI6uYv2DOFD3a3r5ciXVGpgCWlZQv8fpZH9B8vVguKSCTM86fYQHkFSApTMbrESvNsqO/Y9yVB15qoA6QA8nBCuBmHlwBMTuWX6+o7arHv+yOwgIojSTiAYcG0im4G9Ww2IU9ySo0YNlYC6KIKFw9XvapgHMpc/xtvEPMUjbGg==;5:gnevbLpfp7J7AR0pA2cyvrS16IX8E5D4l5CtYNMazXQgwvCaAsQni+X//Xhop5WT2quJBbrf8+wCqMNRMYrGrY997Ng/LkfSdz5RJ2smX9wO/6wyviqyMOeugYuZJNStoC+ff7vOZ95FVASCxw+vI6JGsq1o+eF9uNIwkCBtDa8=;24:8XTd3KiW/sZdZmNmWIfXMPWNrTOtnphj7M8rIvISp1Htv5hVvFPDRYT2gBF3vZUNtFcnUDMVHbI6tFG0iipjUzUwsrPr9CwUsO4cPBc4sf8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;7:Eu7EYtCtlnjuibrd+81/GneoN6/aZIzM+AYK2Spe4TwCPeaC76buFi+A0XCtQqfB3KobpNSkuennMRJ8mSooOuhPsY3u+kbAXC5FvHMFy3Tz9WChStA2fgzjZW1oS3hHrmGWF2qv0gYt9BjRyKAOnRELpIXn5JvRuiYAcUMq/TCrUbbTiiiQOiFAU+WNVTLYyA0fkulRL9Zaf6CNpxhZwZsuYdNcj8BMCfEpn+ZAQNAe7H8o7jOOcsVzH5idWdXc;20:XtTh45Tj4oDdw1Mk9eaWxFxov7kC1+TbtM1a6L93NJweLzAaxZ/1yNjFIc/sWLR4Tz37JgaiZzIOXoDp3Kv/2g0OZ3u9aU4hBDRwEs/IseIJg+YXuXXEf5AEUAVH0fR1Vqk07O7u5KG9yp46wXPTX1NRkB8NdQKFtYRpCmeZOzY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 19:41:33.6196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf18761-1830-4736-a267-08d5e8f8a3f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old_array argument in bpf_prog_array_copy() is marked as __rcu,
so the dereferencing should be performed using rcu_dereference().
As we do this a couple of times, and we want to be sure,
that we copy a single array, let's safe the result of dereferencing
in a local variable and use it further.

This fixes the following sparse warnings:
kernel/bpf/core.c:1653:31: warning: incorrect type in assignment (different address spaces)
kernel/bpf/core.c:1681:15: warning: incorrect type in assignment (different address spaces)
kernel/bpf/core.c:1687:31: warning: incorrect type in assignment (different address spaces)

Fixes: e87c6bc3852b ("bpf: permit multiple bpf attachments
for a single perf event")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/core.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 329026baef6e..3cfc8095d2e0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -363,7 +363,7 @@ void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
 int bpf_prog_array_copy_info(struct bpf_prog_array __rcu *array,
 			     u32 *prog_ids, u32 request_cnt,
 			     u32 *prog_cnt);
-int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
+int bpf_prog_array_copy(struct bpf_prog_array __rcu *__old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
 			struct bpf_prog_array **new_array);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 722ae6913dc0..26bdc99fc807 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1634,11 +1634,12 @@ void bpf_prog_array_delete_safe(struct bpf_prog_array __rcu *progs,
 		}
 }
 
-int bpf_prog_array_copy(struct bpf_prog_array __rcu *old_array,
+int bpf_prog_array_copy(struct bpf_prog_array __rcu *__old_array,
 			struct bpf_prog *exclude_prog,
 			struct bpf_prog *include_prog,
 			struct bpf_prog_array **new_array)
 {
+	struct bpf_prog_array *old_array = rcu_dereference(__old_array);
 	int new_prog_cnt, carry_prog_cnt = 0;
 	struct bpf_prog **existing_prog;
 	struct bpf_prog_array *array;
-- 
2.14.4

