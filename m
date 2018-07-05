Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800C1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CCB2404C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Mw1eRPDr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f2Z1x7T4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CCB2404C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeGEUwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:52:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42570 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754325AbeGEUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:41 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KqIm2026792;
        Thu, 5 Jul 2018 13:52:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=SoaoxsdKgYm2sFHUgyvUoO6660AnLY+PVwUlNeP6gmY=;
 b=Mw1eRPDrQzROnxZDtYSwnS8i0nU5yXTtxIu/uVVG2TCM1hUS8GXARGMuiuH4ooh+3hZN
 ublSM+W5L2Psyyt3uEHUDpF4q+9K38k5AdWnglsui2qlHgzcE8W+ccGssfMI5+YpveTW
 dp2B/u5XWrPe6pyOwn2uOuKerOq1STVXEME= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2k1q6urqhd-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:19 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 13:52:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoaoxsdKgYm2sFHUgyvUoO6660AnLY+PVwUlNeP6gmY=;
 b=f2Z1x7T4Ez4uikeScxSLvJXhbwvzXevJy4yokGataBNafzIBqt2Rha49Cw7NkR0abcCW5U/6S+OkT2wa/ejES0tomf87Qn4JgH9ff+/5WPFt7ZVFyKDGVLbDwG7tEK80LY+avi9RWWUbEUZY0VZyVnHff/j7ovpNiWWP8cyGohE=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:13 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 06/14] bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
Date:   Thu, 5 Jul 2018 13:51:31 -0700
Message-ID: <20180705205139.3462-7-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705205139.3462-1-guro@fb.com>
References: <20180705205139.3462-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9a3d]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70a2ffa1-0937-4530-d3d7-08d5e2b92f76
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:oQQMjZDoayZAfHc8ZH7DkEF6EN37C91fctezCqyJ1KLrr1qt1FiFHgLfAYceZMLf8cDdnqcV+j9OzIHyWc2SEAtpYISp//xOW60x0Qd4qseKmHJx2PBs2gYwiD7rGXZ6ECeoyIqKBn2+3UdQIx7/TqZNwR+xpnEcnVDnFmw7ZZjZDvUpzvohOdd8npSfXRYriJHkxJiWdDPd0+Djl+uXmVXVK/fjeC11RFNNVNqaX5hz4HmlFFwnElpeiPz6CcOI;25:kSRaFk5e2PT7uFKqFAyXVOqx5vYqBapMkHHS3MJ3Bz7BYSZuw49C2wt4ZoI/ND6EMhCCqnG0xFQ18XyJ4SX7iYvX8zq8IvzMsjozsPm2/LgvB+Zl2Vd/0gpLv5OtKKAoAzf8t1LF2/IwVFEmErfwwT90uE82NUB7p/m5gGmCJbeH3MuwT1Lbaaeh10fJ7ttFcj7oFCL2lFqAoPx5cD5uvr/UrU0vqGOt2lyYHClFSdUjU6wC3eK5oB6YPNN/2vT6ajFq5YGsDABUp/+o4JzKMLFAEm1fnL0cZRfzW3Wa+3AJX3k6pWU56IxJFc2ZbNTg/PN2DeBLeVwwv+VVG5Kh5A==;31:dACTMTR0tl33lda9k7JR3eBOFmDmPKt/yozTckaJmdUAZbWoT8SlLzrWCuJlfhkxdAXAgfo1aae9eARB6axFT96FM80nOznbThesbKX1awBEqsInI/v+H7aDgi/5O9pXjnhVuQar6Mxua75WKsZjrPVOA5e/VXM1fqUOHb8uGj4QOtWXjX01e7CMwe3iAk6zy7Cry/L5gF/Pi6HEcVTppBZ8mT9iNz8uqbqoYOv3YN0=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:GdNxtIfWJVs9GtQyvNXEanfXr4TGgMIl+/+G9UhCIEwJ4h7NP6vRGI6QyE1D32Z6Poh0fJMul4zTmU8MqyrNYiQEeME1ZNIu1huQSxMQHnXOQEfWnbMj24rShAgMchnS+R3cz1b9ne423tQ+ySzhqKKQBYwAeN6+ePzspkwnDc567n3+VNZuaFF+mgU5garizO3oKaU8rlYMDi6rY08DtRnRIOBgnPmVdzyxvf0rWs+bzK+f5wX/mjgNM9xB4NCTx8s9YRoghlrd7Fd3eZaQQYmNs4eJDPnHZ3txHIn77a8jfT8M4ms6sPutjzuXFmHZzH6GrXe3PgC0NTAgSbJ7aXlyh7sTSaFj7fhPOYNK4ICd8TIzRLVLvdq0rdz9Jy3abXkv3mkh7xG8QD8IRABFA8IWRw9Y5+l6zOD+fS/DngX1U2VrMTQ1gNY6BLzTEmPHV9A1nN0IKFD+HoHRRN/3JUMFeRKZGXGHXqgd4i71QdNDaQzODolWaBxuWE6aEQxX;4:/+BxytXBODXZBLN/3NozyvENs37SFumpzukkgxztOWp0GjvqQwD8Ko9x5z0RdOCpff1CuXFFrDI2fyFD8NM4rrVwHfZDZMOBc+5txFDWZIQj35COLjVDbhyFCrlGO7bwxJy1wOOxfQeom9suKY5fsEJnIVOLCZ6FubB6NZB0gqgrd52Ho0VTFU7z1sfyT76Zf2VXmAJCwidVgs6PeKr7hHyyUE8beI6IEytXkO2kZ2vHYG/s0FWv/mxOfJMfTWDgmXBJzu5DYobkftH8DUOuLySt3C4eEviR+Oatcz9Ow4NN9p7i1heSrKgbz/ZX7uLU
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166BCA15A20AA5389013106BE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(575784001)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:1s1oibP7JaMxBlTytfljlro5OkrX5p1r3ptybTy7i?=
 =?us-ascii?Q?q+0M2rwB/evmfc5BTUvqJwhhDkhUPeUgZkcQD+l7Y4ffeS8VPQ+GEGC7U1FR?=
 =?us-ascii?Q?PIwCrAiO+NQLOpPaU4kzAOGd7TcQ0Bjg6FlR2H1w3L9sGfzeWzirJ8ER2SAK?=
 =?us-ascii?Q?FHEgi8WE10/t66pu95JDTKPtS/KAG9F7Kqh1T1BEWDgqahh4nyDmb+y9sjma?=
 =?us-ascii?Q?fRtN2Kt1wYCjBFqXyV0D6xyEAF0w/SrDT4xSY3IfYluJsT3FacPc/kT+oYah?=
 =?us-ascii?Q?A5KX17YeJkmR7k+24cMCx0LDL/mCdNzLqYSqGRrfm2EvtNlucHkybKukHz4v?=
 =?us-ascii?Q?oGfMe1XE6hldKo27Mex18TF7n0Ae+5/1OXmPX48Bc43bJNl2qhL5frwwVa4Z?=
 =?us-ascii?Q?sHnfZqgmHHqZk1KFj7R5GXg3TcBFn2tF71H2r6ErBnViXe17oCYcAPTrDJTH?=
 =?us-ascii?Q?hwfj/KJsC5d0DaSmtoRfmMawC7WMl7jRk134pWOm1j1r3+CZCEwMVzyRgUc8?=
 =?us-ascii?Q?j7DBAm8BGsYKQAJsGrne5ZxweKeOiHAOopfRD7YlPV3jyCyrjDJaTJbMxK2j?=
 =?us-ascii?Q?3yhrDa7QN3cfQDQ521i7DAMvjkCYDsTVjemvU4vHDa7g98Wwanuiej3Avhvg?=
 =?us-ascii?Q?H4IpJ7fJNYDpgvd5qICStXc2ITY9pv6YaEcptuNs6WVWJ5NqP1jsVbdqkZLl?=
 =?us-ascii?Q?6nRuCu7x9gZb3W52UBeKedyZp04LvX1lbGtksDTqqudgRoWfxcvpISmbuaMh?=
 =?us-ascii?Q?YUevulX77dw4WFgD2elDsLMEgouNcksIGz6zFBEKG2yf8qVVkoDGrTfCAwZN?=
 =?us-ascii?Q?AOypIFKLphsN5yrGVs0BlSUZQmgrkphjcmNaAPGeYo+QY7Fhnp64WBTSaEhP?=
 =?us-ascii?Q?rUpfWC41hEB+qGAv32fTTdRqjLWu8MlzHXkOUcrJ9JaljB+0hEfliY/27WCg?=
 =?us-ascii?Q?fi/J+lTsupXu3Z0xC9nqaDsMvzmt2h1SCGMW7lsSbS3TA5Wn6qNPJl6tGnoY?=
 =?us-ascii?Q?0wxJl9DDxiY3dD1gfR91uzohpfBeyji8qp9BIo6JbuKBWKilqfRfsyGXHLia?=
 =?us-ascii?Q?KfZuEBdCy+SfZd8MkgeRqMipwK6NwbufOW/PdOOJETiPwwnwBJtjPhWs+pOz?=
 =?us-ascii?Q?2e/L6sumeZTTg8gkDl8/wFd4xAhCq+OhdCzABNvONvyC2BnZbkJHQtYl1vGh?=
 =?us-ascii?Q?tt92KKFzGKjoNSCMXwynt1OajSHqPJ1Q5McK1j3pASbVwCpoaaUhCu4n7omv?=
 =?us-ascii?Q?AMFOFNWPJS5O+P2sE+h1uL5Jj9u0+Hnb7N/uMCoAcfkR44b4C2BHROu1YPnB?=
 =?us-ascii?Q?UUMuCT2IdMTnJ5eL45pskckhuZ1FVEc/8810iPoIbfx1+nO3Tp+uzgBlp2Wl?=
 =?us-ascii?Q?vqwUXsPERSMdB4dkc94QXqwtWNKEQ/qwZsw1R/4dyl9Lp0gzH2Yn3JAEKHmB?=
 =?us-ascii?Q?mP/qYKx3A=3D=3D?=
X-Microsoft-Antispam-Message-Info: PizQujzStaPU7/OJnDFdGJcQWeZVciyWP29CnJpGurAQ63URKs8v0tEO+XeHETpwy4o05hyK3eKHFFUfIairmo5lwnguUXA8Lw/OcFrzhpSePU34knXnN8pQzqgYHJSFBxG3OaASZ95SaZFsvyj+AJ7Hh1ZyqSpCb4f3B4mX6wy3OykYmZ+zwpXcYeA53m98juK5j7p/hQkVYPlquDvohobB/HsrDVPptAfbxEQKLa9DnB3ypYtoSIC1m8v18Q0Pr5YHqagpvPFeMkDRmoCWdiC0kfiMI4WWTnoHxcSEuaF7IR4BN853sgpbeKnpcoixCLDs3BKJkarf/55FJH1rIsvdMCOGLNpH3W6gJ++GrW4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:MTynhJh8sGQa0c6az+cEWhWLzSAWnbuJlt0OocmZwDP4cF9lTC+fxBaBc1a9DZUujnlVKbuTxWSy5AogCNlvoq2nGFekBkW8ZJSZ1cg2MQHepCGcgVabzsq1IxfcRWpoqWaHB8KX8HjiSzSoNkT9G3eQzAOeVyVjQATCK0jjjOQr8FCEyXAT0wB/+7BHZLcjArffxTrJK46wdB33SuDOUKAwnYeJpVYDC+gJIvmD8Q/HlQojknTMm9B06cEa4INbCjGa7AYjYtal00Dj5N/TrpCo/Y/FYQ2BA6lwPK+Jk24SjsRXAhOi+biN0chVU+F13fLTVlVQwxk8ZfhJkRWlBsm7WemRQg7/XawCVs0hf+ZyrvruXwqra+sqadOI/zgZJUI/FQGmMCMPVSXJpgZn8oQ/Y5EN0CIRJeJqMOcH3EsF+WFlawl9lsAyseYjy79S+SwH9VL7yFMKHu/vg10g/Q==;5:0VAsQfmHAq7QhZHgqUTdYuF4Pa4JUdYZP2jD6sPWYCvzPsE9pCpqXcIsvQnaGu47q883egeEtD0Ix9ylhR1ZFPoMrC75pu/C5dCxjzc0ywaVrZq9VFDaHTXMtk5tYruzcXVxM7fXDHjj4PkCW+E4Ls6N5ZBCzCcrZko50ibaa84=;24:YgwrseEd5ou6WYZNImKJvXOkbwujsZ1k16Nj89icgLw5+MCYFkjn3Db+jPo9wA1g4qWBRd0XB9mZ275YGvXi31c35/Unq5G8AOaL3rF7fEY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:ZxkpiT4/zg9P2IiJMGltbR55+anP6voK3blu/Q+ksgrCNSITJLBcKUowUZtotQWp/tPWNjYt6GSEIZqq/DophgijiUJiSeYoRVABca1hfwXi+07Int0+pB2fRhGD/kW5saK/htyupSgukdst+IiybfK8kaGvr8WVfAm38HVpyKXSGSTNZJKSA5sfUWkOvPwZZ8nCDQA2QQuC9lF+GYy1hhaXoS83vvUWREvDBKwK1i4W/QMjmp8UomxiHLzrSHoT;20:p6mV6a9gTxde7WEZQNSxgBmyJGxf/csy2G5AjeNdhTukOAPtsVvIEJf+gztionLVXjWjRRkWUnDixVgKuUD8Fxb+vfrIuFApXQ8rrW/fz1f5t9IXW5vGjJrCgmwKCVeCm0GFZ01OkRwgQxHaqzTIqxT/sqyJP0o7/ssgjjQ8Kyg=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:13.0281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a2ffa1-0937-4530-d3d7-08d5e2b92f76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
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
index 31a94a842449..577fc6cd830e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -154,6 +154,7 @@ enum bpf_arg_type {
 enum bpf_return_type {
 	RET_INTEGER,			/* function returns integer */
 	RET_VOID,			/* function doesn't return anything */
+	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
 	RET_PTR_TO_MAP_VALUE_OR_NULL,	/* returns a pointer to map elem value or NULL */
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de097a642c3f..cc0c7990f849 100644
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

