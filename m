Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EF2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2C92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CNNaPLTf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QGK3RfU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2C92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeIGVgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:36:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56150 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbeIGVgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:36:02 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87GmCJW001033;
        Fri, 7 Sep 2018 09:54:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=IHd+o/y27bcNh11PbhX79Xxdw+65wKbS+IufV3cHfkU=;
 b=CNNaPLTfhUdKIHpfRVQzh7PaJbWys5wh910MqeEgDbuCMNA5CFYpJv6RllLm5MsAiLxS
 9Cph48TSZ2p8IN/eos2Q0s4HZtycOuuE8dXcu/XRab/yARW/cwonCiR/VWPlEStCqUVf
 M2iYlSudqq7f/rVMhzqncJ/lHWvJtvYMaoA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mbv1wg7y0-11
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 09:54:12 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 7 Sep 2018 12:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHd+o/y27bcNh11PbhX79Xxdw+65wKbS+IufV3cHfkU=;
 b=QGK3RfU1/ftfHTzyp5EN59paj/Trj9IUfAxdRrBdszz+hu1WO2Lp4oIWSPFUo2fsMn4s0YF0JN9ZL1gK54PNhKIOgFS7u9PB/oEtbX0ANF2upCxHYPY3vidoXFrR6JhDvFwg3eHP1RwOREXmhZZW2ikfxbnpbQVFSNUkOGCh8qY=
Received: from vall.thefacebook.com (2620:10d:c090:200::4:cd5) by
 CY4PR15MB1223.namprd15.prod.outlook.com (2603:10b6:903:10a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Fri, 7 Sep
 2018 16:52:44 +0000
From:   <jgkamat@fb.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>,
        <jgkamat@fb.com>
Subject: [PATCH 1/2] Fix cg_read_strcmp()
Date:   Fri, 7 Sep 2018 09:49:23 -0700
Message-ID: <20180907164924.13789-2-jgkamat@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907164924.13789-1-jgkamat@fb.com>
References: <20180905010827.27743-1-jgkamat@fb.com>
 <20180907164924.13789-1-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:cd5]
X-ClientProxiedBy: AM6PR06CA0004.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::17) To CY4PR15MB1223.namprd15.prod.outlook.com
 (2603:10b6:903:10a::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0bc7ee-e6b5-4173-519b-08d614e2573f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1223;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;3:oasVOySsYLxO7EJUkV4bIkztA0g584GqOpFgTob/MNqPojmIgQgZiurCCW3x977Ht3Cte5TZLmQWkTYXJh4bnnH3bd8xu0/erXsysn1CFBGO7N4SZyXPyv7KKIiFr3CbRDTZzZEAnT+UNjITDXcCK2x+VkwwJf4Kc8S1+eA2k14zpRBphhFD7v/2JH6NHB3AsOeU1WLKQX4/ofZeKLRX22L+D0q4IWQnRclUtMlY10BiiF2qWpOiTaNwFjMR+o+j;25:HLA5K1x07ztjjmzTxrh2N4zVT6PhEaOdTSXGymPMLEn396Nk5Z08DukUwETt2ArJbhU6vMTB2ZUQg77mlaG6fsc37UCm1OnA0hjiqW6leUWz8MRk++XmcBVuXtt+jCho+5tq/2ahiKDO8HMtmxvXhgkXNv6WNnPGWgMxDukDAdpXOVczoJ7OWnOjIMYgkk/kCV07274vCDqBJXYaCLhsdkKFDxNZGvi78MzPY98Zyl0cNiVjgCzATzbn7AG2SlwzBortbz3T6mx/BFA3E7xRtloHnpTKm+GHpqKmOPLuz6lXA6Z2vFs+yj9KkbI3bVsnuq7peMxnR/LHOCoi2BbsJg==;31:vRIAZH7FifaUQD7tFHeKmRMIpnKnN6c2eNbSDKIHBzBOe6J1Ng+u5kX4EyKKbmX6jaQn+WHGk91xR7KyDmMfapGtPOw81PPoMZQPg0MMtEnI5kw1pDFUQsH2Or3fuVpjNJ/uECQcjZ9WJYECkT0E7SbQSNxf7/nYqP1dYk32lF59nLBB3PV8km29pksNo3rm4lTPRSAXWckInA1ZfHzjoFadkK5qLCXpVnMcYHZeg6M=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1223:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;20:NqESAdPgi0q6JF3eXJOkj0SqZSG4xjF4hOXSAUILrkAg3WCk+yBlOwy+AYAycUQsVuQZgf2mkGU9VjCPtTuJKc5sbxyw3eDP3KE5f4AzUxjdQN42VinP1a8aT9OLdw49+StJ7nVylQ/adzM6HMQdWsW+zPztRT7FP4UkLPqhT7+54ohrPsSRicXxBdmu/54jEiFACZfwQyMWCouuMMupQmgpwIRfgxrKaYDSqb8Juv4Fcu4fUUlF1n7BMZyOAOATRezj7wzEu9f+mNHpUWxQLjzk+pEBj9dxjDQhw5loysf0dksBKAgZLF2iGxEYC0udCqp9GkOkF8l45d2z3sNaJ6iIcuJL5rKpn/U+u0WBZ891Ew4HxDXrGbWr9G3j7eLclS3RXB1tY6D/EaPobdqX+LbLUOTmtLdNnvdW13TzpxEe7wY6Cw+bCYQ8JdYwcmSaDPEhEUa25TqvWparVI9Um8KDL8Ko1FbzTG76FOyiDXm1sEXzdM+6dJI+umHI0O1S;4:LkBlgaVFyHj+whXbgDX+VUuQJ1Dzc2zkohbVyDKUjfR+bVHO/DZSQQ8TIWk+C7gPxoZk0hLcsXOAA8h+/2HB94MMG6eRwbm+XlEg05fnmsk8jAkzNlg5N9dX2lLeuV5dOHdJgjcEERE8GkI4fBBFKbwdhBqg3GCv5Z9FpQnk4yrVKm8OLFZx7G5dA3dvuezhWiO7D5RGUsSClL1ay/4EsEjSvEyczO/rbfDUWoBhklZhfnZimRlK6SuKsn+3BQNJipUqTPluUqAQtMXjDlj4ZJG9GdgbGHqDPQXYRLMC8XPimxuCiYgkRhbSAYAr/P/y
X-Microsoft-Antispam-PRVS: <CY4PR15MB1223F6670E6E38A707C5FDD5CE000@CY4PR15MB1223.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:CY4PR15MB1223;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1223;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(46003)(11346002)(97736004)(446003)(53416004)(5660300001)(6486002)(7736002)(85782001)(6512007)(9686003)(52396003)(105586002)(305945005)(106356001)(8676002)(476003)(186003)(86362001)(52116002)(53936002)(16526019)(1076002)(6116002)(2616005)(51416003)(36756003)(69596002)(386003)(6506007)(48376002)(33896004)(2351001)(25786009)(47776003)(316002)(50226002)(76176011)(68736007)(50466002)(54906003)(4326008)(16586007)(2906002)(2361001)(486006)(8936002)(39060400002)(478600001)(81156014)(6666003)(81166006)(6916009)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1223;H:vall.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1223;23:/SPP/RJ+y73eGTled43z8kj7QNlQivIDizx3KR9OG?=
 =?us-ascii?Q?+CRXl0PeGhdAB5QxixKtxgb5Tw473oTj6sBMb0RVzNPaJmKKj/RJ/vM52FpH?=
 =?us-ascii?Q?44chrEk4Apb5ySzt4VzColCNpBREXvHzv+eCESUHLBzcoCIe+ZiIVNQmSSNw?=
 =?us-ascii?Q?CV4LFmgJzIULJ+ofy+q/jAbsyraAzruSLGhAs49Ju9687LggObT6xyt2mH3z?=
 =?us-ascii?Q?HzJuXS4Q4iJsJDO9l7tAk5T0Lwh8fGdgCQgYVrCJTFxFXQVeDa00ZVrCKiVx?=
 =?us-ascii?Q?xXyT6uOoHUsTkEmm/gklTpVA5fyDICcjH47o+JUcHJQNsMziTflzuHb52rcp?=
 =?us-ascii?Q?Unphm6zIFEKRThoji65LxMhwKfHcn1NT/Hw4BkkYBVB1kxkvIPQ8ra/pFo85?=
 =?us-ascii?Q?SmU+Qn4xId1ov/3b1EEOUKBy0LOMuTlCZB+ukV/XiVJSxddNkrUK5QbVjPiO?=
 =?us-ascii?Q?Bz2i6hAoYuxEivqo8RFRjlSFvgYjhmXASZLIp7OE5Cc+MN6XV0M5YNc0gbSB?=
 =?us-ascii?Q?f5meZQcoF7Ow0+httxyfV84aBarYBxUnPjvC64LMkTbJA0NzqvIbkILG0rPh?=
 =?us-ascii?Q?7kUTAtmSojMjyam/fzfHapo3tY7+zURPOUi6j3DnC6S01R5ZB4NikMSsQMW0?=
 =?us-ascii?Q?GrZy87WmhvucLtCCGCg1Np5u/mzoTA4vsALPGsKDrb6oM9qcYVFvJF46fO1h?=
 =?us-ascii?Q?D20JUujUENaHM1CuUuIyJNYp/yNQsFyTNiI8EFyFR0hunkC50RUkJSNem0rw?=
 =?us-ascii?Q?gVd7CD15MyPz0wCXN7UNfYZqeqXPyZhILCBenycpifo8VK9H6spQiRFjD5gR?=
 =?us-ascii?Q?2MCaPtqGMsFYS4eWCZ59JpMsH914rnImaY5zM2a4BYWae6OUoNX1yFygdI0m?=
 =?us-ascii?Q?Bdso3SbU9dSCu3EHrlZJ3BrjmI6pLK7XcDnwcjh8uq673Tcnf+a5Z3dUojXN?=
 =?us-ascii?Q?CFLhCXnkSo+xTz0ElZPlm4YUjadvTI/PJNTXrxHd+dU+DSdXIIM0wnagcoi+?=
 =?us-ascii?Q?Hw2kwkcsD5o054ZZaVrOGecfSYty5j0hnUOYhcqLenkRZ8F8sjez0xniqdHG?=
 =?us-ascii?Q?V2Ztx5wXvXFkNlAYT/As31EOw3TuVh9T/GHsgIUJhy7DoMZdTHAYe3Q48/5o?=
 =?us-ascii?Q?tpy+mwqVkd6fm2ucpoMtRQ0FAarzv4eFc87Px+oVri49NOedEPxF72Z0yzaH?=
 =?us-ascii?Q?v1MZCWU3+RCKPfTESC/gNdR7+9MlymcGKlf9sU/zUoOCu+8gKmSxO3u69cm2?=
 =?us-ascii?Q?zX3iyKAjqggQliOCAc2wjYDuMgvdgfNujQvAz9JJJIGFHsLp4MtHyufMiXTe?=
 =?us-ascii?Q?ZdeM9c9116yoFt2iC/0r2zC2/7IkSps/p6DGdWKduYsS8Pv0y3FmbtWLhpLo?=
 =?us-ascii?Q?BX7UQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5oNCrpFSuAPuPmF9OndzOy6cJFGp3D/D6EoX9i/7NWE2agQAH+kZpHlKM4j80kuoukeRCyI59OLeeeGJlPZiSnWQfKJ07avvHshtZOQ292ypmyJd5NKZefmkqkoaB4f1IP0OUXI//w51WROxRgGOFOj/FDX/T277k7TKMUnpm5cv5jWD4J/bLTLgz3b36D9+s1IxMLFA0zTGkL7gbCJoaxqdD+QK282GXxhFVQASrC6r2P9RNaT9Ai0u3n2g9OXTAzREEv1tCDcozurOZcl+t8/TD/Ksvq3vF/2TFPH4k+PI/M0uaBpqEdWVxJgMtVCd7mzZYu/slyoEijYkEElvPfrRgQNu98P+apAaUDdXZqI=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;6:Yt2fgCfwVGABdH33raiNgxGZ7VNYhuKYflrm58nqqvIt6YN7uZvBJuF/H3BkmVvve7HQ+W07l4fEhZquShV3cMsL71/C1eY0fP7te1tGEVYDij+b0z+95megYhDkAaA3Ec6zr42ze1MASZPlCjjwq+Pr6jrWrAArtKzft0b7sph/DfcmurklVz0+ULtjKi7FI3GgZIDV8aOsGUNj/ogwkMRZ9OpEuNqNCwS4NAuoT4ASVaq86npYLUPDDzfpCKmNrS3vqBLQGsRIHTYY4xu98xovd8Tu+fNhj5WTXkyQgaDj3bKblXrvHk/ofGq3Ab3w3yA+giDdiAc6svNPEDZUo3G+dBM0zNsDIr7BD0Uj2fn/4Jbjs67JICkZAFU8hdINzbg0WskS/iE8DQS4jHYzKYJXJml24qMDpX5cZCrhzoWwWKSthl2KVh+VFBk4gQa/ve5GWBDg8rjSlTkyG8+Y4w==;5:jKhAieDN0O2yyguT2yARfhj1NfEikzRQOA9cJuKlovcHVGwI+eDXP3ObEMhuQJiZl79tHTrdLhbuGwkmOknaI6OjUvDUE28Vp0B91a1EX8nvOXsKb1pxB6Ng/Uh4ScKwAm/nuIt0SzzKgzJac6kwym+LmKdC3gJaYMb3X2/bt8A=;7:2m655iS+o99K6GAmMcoXluCadpDNMBWH5TT6BkrQUwsmcm2Mt1qPdDQxq1sQuDVLGL3HYJeBQwKEHs/mpsruTINa2hpGX+FqBseg5mo1egmo3mqk4Dw2FClio4Z7EyNJTzjXnLiRaxPBBOdQv3mu0djNbCNNbaoY6OkjJkqUsF0v7WC8wXW+8zjOIv8x7bggSy/26JoXYiOD01ZSK+oLrJ8vg6AY4JBxRsunTdyRgcf7Je3ccmitFFIfqR3LdGs0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;20:7t1e3VYZlHZZ2sCf3I7K3kfEuSSr70jjpUOLJzYO/XJkEVJBWcXKSSMaRsXLUTgms/v9L69ANO01CSnAMpPSQMcbfuyGg5KtYZm60hz1vGPXbUJatsRrfa8du2dakzVToRlAVcBzeZ63jEf68YC5DlcB6XIwlIGKGXflBLZcd7Q=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 16:52:44.8931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0bc7ee-e6b5-4173-519b-08d614e2573f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1223
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Kamat <jgkamat@fb.com>

Fix a couple issues with cg_read_strcmp(), to improve correctness of
cgroup tests
- Fix cg_read_strcmp() always returning 0 for empty "needle" strings
- Fix a memory leak in cg_read_strcmp()

Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")

Signed-off-by: Jay Kamat <jgkamat@fb.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 1e9e3c470561..8b644ea39725 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -89,17 +89,28 @@ int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
 int cg_read_strcmp(const char *cgroup, const char *control,
 		   const char *expected)
 {
-	size_t size = strlen(expected) + 1;
+	size_t size;
 	char *buf;
+	int ret;
+
+	/* Handle the case of comparing against empty string */
+	if (!expected)
+		size = 32;
+	else
+		size = strlen(expected) + 1;
 
 	buf = malloc(size);
 	if (!buf)
 		return -1;
 
-	if (cg_read(cgroup, control, buf, size))
+	if (cg_read(cgroup, control, buf, size)) {
+		free(buf);
 		return -1;
+	}
 
-	return strcmp(expected, buf);
+	ret = strcmp(expected, buf);
+	free(buf);
+	return ret;
 }
 
 int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
-- 
2.17.1

