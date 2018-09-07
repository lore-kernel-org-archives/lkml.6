Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1037C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420482083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RSBXlDy+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YhpWIYBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420482083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbeIHCR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:17:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45088 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728060AbeIHCRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:17:55 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87LYmWZ020102;
        Fri, 7 Sep 2018 14:35:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=9gr3Rbo11zoyW0Xs3bAyGP8QsHlFdH6LdNsN1G9NhRM=;
 b=RSBXlDy+s2ICqJD//aqnVRzmIDB8NNboZAgHlRY9r1uCcL87MCjq/e0BzAaspQf5vZhC
 yOW5VBw5uzuMfumi/o1QZVbJbefof68Zu/kPN/8ex1S9g856IiunuYt1AAjHoUxggoRD
 g5SWXOjoykxeQObq/YNiQ6SJR/M/QVFr8DA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mc1b3g072-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 14:35:00 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 7 Sep 2018 17:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gr3Rbo11zoyW0Xs3bAyGP8QsHlFdH6LdNsN1G9NhRM=;
 b=YhpWIYBt5zJ5bVkanhwivdSN2qOTagXkmBm0ePMy7C5sJfuSdwZSEgISJiShcl9/hJ3+RWJdTcWWEyDF81obRuR6gMoLOZ2MI3QXtjc9uOsRwldnkj+GM7j1R+ORv4GfxdtUmgUtNRIhkVxDDScgFJiNns2JmpudFmuMB8Kz6uY=
Received: from vall.thefacebook.com (2620:10d:c090:200::7:36ec) by
 MWHPR15MB1230.namprd15.prod.outlook.com (2603:10b6:320:23::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 7 Sep 2018 21:34:55 +0000
From:   <jgkamat@fb.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>,
        <jgkamat@fb.com>
Subject: [PATCH v3 1/2] Fix cg_read_strcmp()
Date:   Fri, 7 Sep 2018 14:34:04 -0700
Message-ID: <20180907213405.31574-2-jgkamat@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907213405.31574-1-jgkamat@fb.com>
References: <20180907164924.13789-1-jgkamat@fb.com>
 <20180907213405.31574-1-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::7:36ec]
X-ClientProxiedBy: BN6PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:404:121::27) To MWHPR15MB1230.namprd15.prod.outlook.com
 (2603:10b6:320:23::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2037575-4b80-451c-3940-08d61509c1a9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1230;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;3:kP8DpJipedoPsY5lciG6SJ+OleGQfV3KZ4PyhOFlshk/OeQ4vU7kW7Ztq8ZW25fCHh7QFKWZVCR7rIxQr4McY2PIJoCR1AKZ+O2GKPM3lqgQurcSOIEbRNmxQpb2yrVouo5THQtxCiI1FP9nO/7YtlXcfsMmC8GQ/RIPia0xWu20bI5DwMkjLlOJeDWcVDY7wHR27cZVOLuNKuQJGvPs9WaMYgpSE2KSr8XHCmv0n38yDA61+HeiV0l2jBIy5aUF;25:Sm0qvhG94vw+7+v7ATJhJmJPMczitdTs66cOm3fmAah/jA9IuzTGWPH6UPgMqli8sEYGqsGmsMuxxIWe0mThsbFBhVypyN/X7VzoMuh+ks70hHGC+iWIs8yrCJVLoZ05Uzs/A83XGuXuJQzbOZtTmN5tsTdt9ZE/qNF/dukWtEg6tE6JoIt2pyhYc+YzVLNmtmWlyRtqsP++LhGfsXfcpR4dH/Hn3ps3q4CLPRpZnJkpDExIQp7fnc/nDjlp9DBo6oWU9yvkxeOgzkmvxVBjqDubqovk7O0zMODp5rUWuzI+G6UiJis81owo/sIbgyqLuCd2OGGIHVSvL+c6xOVUwQ==;31:YMmrcZ87zR+fjlPAD4aBkpS5RYMCW7HwAXsJ3jKhaRFSO02IqmMCP3oBwfPP20rwZK4BIkx/TTKxP6dUof52HjmXqJMbAArZfpkJhvu8NzqhvboZQFYFAR146/1Xiz/xGdlRq3/T+0y/d9nJIDwWIiytSzQ8P/tYCCIwGlGflEqfhCo1sAgrFGUmpqEF2hYvOPn3xNLh00bGc7XdmKD+lUrQ8/blK44RsLvrFs+0F2Q=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1230:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;20:+wRRYWr2WcFPv00aBKtgOE8JLdPIhpDtKUa82y5AULDNS3QJ4qru9PTWXAb6D7tinQ8/tAeDGiEQ8H6mfskuV+oRNS6pR/kdxPmli7JmP+bQlI7WILayBlsJIgagQfYPMo5xgh86jAyJ/8xRpeK1GAhjeOKABe5g3CMFOdu1FVtjSL+/2Ynm2F9N4YE5l6pZs7HmtRymSLoELmLm4uQGU/2mTJwAxMiClnToLAsj3dn/2pZO1fN3s+zJ1HvjENEIqXEhLa4fYW3MwKJBv1/i5H5Tg1OtNX8YfSsFBeF7yiWrUiqVa00mBDkW7DwulJScY9ZX3bCQkF3JTizlNdycMsoLxYQeUcaaQIrx0Bp2i0kMqAYdA58ZDYkeHGTzHVf1l2Shx5IigkBkpxwW3hqSsL/FFLmpq4ZzzL3K6vbZlyEK7bvsCVBQR1gOOIMLnmKTA1viziAZMndfqgwPQhULCWbhqQuEELOwIaGQ+BzzYP3okyDw8/44a7ZDdiFuA8TH;4:9k9y/PgZLWdIF18UpOSJN9NG9W8t8y9484294I3GPLTScJMd8RERczghspIolZFgHgOXXDQGjEp7QdWc78qLt27TiGP22Uh27p6oRUTCJb8gbrOGIDiHvzoCwj1+s9V02kljrGsgye7RxIN9biBmvdCtjuw8JoxqLYhMnGJ4gDq+o631mTbaPZAKhD1mNaqiXDoTq3X7SEGMwzTw1BDF2L4VXqwZ+zecO8h4BQIq15gfjPXKKPitU6N0wIuCtDZzbgzYxWv18gVWtewuPWuzIhfyBx7zQAmFwjp7ENX39r9DOuUobwz7RlhmF3q/WR3d
X-Microsoft-Antispam-PRVS: <MWHPR15MB1230E510A6DBDB26A1EBB3D7CE000@MWHPR15MB1230.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:MWHPR15MB1230;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1230;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(446003)(105586002)(11346002)(53416004)(25786009)(69596002)(52396003)(76176011)(97736004)(52116002)(16526019)(51416003)(85782001)(186003)(486006)(4326008)(47776003)(478600001)(54906003)(1076002)(16586007)(6506007)(316002)(386003)(6116002)(2351001)(39060400002)(106356001)(50226002)(476003)(6486002)(2616005)(5660300001)(36756003)(81156014)(7736002)(305945005)(9686003)(6512007)(2361001)(50466002)(53936002)(81166006)(8676002)(33896004)(6666003)(48376002)(46003)(86362001)(6916009)(2906002)(68736007)(8936002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1230;H:vall.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1230;23:ncA5r26CIsTXz8y0qEKvGTV6RJ4xgshtTF176Bg8J?=
 =?us-ascii?Q?4gTV7MMQZZblNBsp9NZ5CHRFUtv4X/mGkMBpbfFgouF4a0PqwVlyo/6HceCg?=
 =?us-ascii?Q?vwyfEnnCIC2A6aPzX4sSJ6CQa7Hz6SU5MWLM4QPSWSX6VbBJ73c1JC2o9nrE?=
 =?us-ascii?Q?G82slNvWbzJhsykMixyk9byCwa6vj1PCqpw4GT4OsMWAAakkZb0LvwHHqd9L?=
 =?us-ascii?Q?5yRAcuo6KzENAzR5KfVBeSnH7wvAZbI8fYTYiX1ErhPdxpouRacUlIsPmCZ8?=
 =?us-ascii?Q?ktARNPxgODoeA6FX0uv1vygQvf/8FMTa8XluA3nNNUKJCeefzU/l+RTEELSg?=
 =?us-ascii?Q?VoRoLjuPq9x++2/haVQSHGOkOHhCE0q8gLJ0iQ52qN8v2NnQk5P0PBdaFi4K?=
 =?us-ascii?Q?pm3C1vV8YUhxL6apVEsRcKwQuZoZdMc78ii6JhuUbqTS0Wq0+N0VOSkE3Yq6?=
 =?us-ascii?Q?Qv+WwYz9qt9tyWgXSW2ptqMNoJZ1O0Hi5mA/B93zbZP+wxyXk5Q6+vp3OthS?=
 =?us-ascii?Q?X5WDbrhHcNaA25BmFuob+iZENACQWjIxC1QerulwYkVxPHx3yN2wFxbWS2kK?=
 =?us-ascii?Q?3cAK0RgCwHqg/10WPGfTTXA+lRKnQJKGY+jsWYA+gNUF6sFmENA4D1v9vHLt?=
 =?us-ascii?Q?tPE44sGP41PVtcxgSfudPlyuUM1yYFGBgSYN0B0lM1WA6s2US8cdKlDshHTZ?=
 =?us-ascii?Q?8t4crodo5wuJwNUEmSMxqCk0Gp8t56ZksoZDfFV4He65XdHxduHtbUJE0gSQ?=
 =?us-ascii?Q?7/eBvfF9cDMfoyqOfdZF5mywLeUEAXs539XRbDm74qaKsdcvrdJpkEt0ylBk?=
 =?us-ascii?Q?GAF2Yi9i7dO1lCD9Zm5dkpxQJHW1N/Z9EF0V5SXaA5AfrWc1rcddw4rHZXm1?=
 =?us-ascii?Q?azK3eUIdGGj1AnjxKbx//8/UvsR6QhQqNK4l/TuALhoBwuKMEbbJj0/dVr+k?=
 =?us-ascii?Q?xQjJUgzN4awkC2t/xPQav28IJimDnLvKOFRiFbBpn8gAOiGoMVCvlwUBQ8oI?=
 =?us-ascii?Q?BuksvYe7TpCOXsSy3e27cQy2RMtn5XxIG2Foz+DIiCJWxbkE0L4VGHOOVTIQ?=
 =?us-ascii?Q?XUF6pC2ybPljfO3ab3wBUmrx8/u8inpc7T1bD8fbY76SLhdCQl8P4p9xRB6e?=
 =?us-ascii?Q?0c438G4Gd/IrRc6BwVtMZKLkYgEvRhrZxnrWyF6L/ER2/yC5ZmAAsp4c0HfF?=
 =?us-ascii?Q?Lhdgyb8CBlZ6KOyGuZQUMVgqiRI0uJZyYxuC2LfEDG6gbYs3bCHjFrupBagz?=
 =?us-ascii?Q?0puhQ0pYF14XkEDbQguH7Ftkf5bi03Gg++FFvWbXnsIADhbHNSOLBg8CpoMj?=
 =?us-ascii?Q?1Ly9LD6VAqf471n0ffezxpdmsUi+Mb4YHxCD9aR0sSG2Zz/TGaA+65SjAq6k?=
 =?us-ascii?Q?3xjBA=3D=3D?=
X-Microsoft-Antispam-Message-Info: ZowAXFAJ8wBHsMODbaqEte2BxGDosoqnKoSVY+mAMOrsLgf76jZ5DPkpzJnTosYisx70AGKPspZxJgEqzsP6l3K38+OVMdJzdL30lhyAxyXpBPJvxtvH88PICtD0AVjv4Ju3FgLoEP4wrpxvfjdrRA73UrwTG/FyazjZVUWd29OiP1MqRAAekOyk/Ly/dlVV2Kc9lCOB8W8+nHhaMhc7vk6piEzEZGB3tfEjUp60t+aNqQdhbg21+OgqYRbIEwHOh+hdffYM/56OnEVz3fPnyM6UGT64Zdgpi6QnllWingA/t/gLdb/S0ME8vEI53K14lEwtWUeSa0u0TCBXl7BjHaDm+O0l6tIItAkjA/rHi6s=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;6:lj2dJbjCK8qSMhCSZ+yhwWMEnGu74KMEzFoLqEMVYBxHbxPN6I4Qy2q6n6uDscZKF0Mj3Zi5F/8QqkeP83nWS8Zq227IQvzEu9+Ac3s5cr5eUKJDsdYzXnSEFeBZf28lvVwyvWQ17wnaSkCypT4+/d+wY0Rnvw7+4C5tJgPAumn79MrApXXHGKVN/1pGuUUegY/gw6cmWdfObPd3QQp5vROgu/29kE/pCOxnwad6XGunwNhetLauXF4+9sB7C0ONDEHma5X2p/Syy2c0IuuWE7pqpZtb47ip5JynEML1stjydasI+6nP3pFWoT7yQIOvtyKECZdF9hkOoeP1TUC90ZNHYV7ejjbFIjveC9uiGGP9v/28I9PiwewBpq0OhRwtOyf+cI6tswdEjVmvR+ctIPNjDhbvEe6CbQlgq8zFqTd0ZaBPDxqEAQthetJmJq+3zj9tBZld2zonXe3Kf6+ShA==;5:yiRc66T/Qqyu+o/4/P8IbBzl6laKujSFV3Kbggqpe1l0e0EQpPew8ufZqImLwj4fstvIJfRZ4FmYXCwhy5RlSY2PUgSW5h1+Co1mgZb/TIqD1tTdU1R+vTLoNvTUtVGq5BMOJcsLhnlsxdraQLImPK6ggjurMkTM3OOp5oxF0oo=;7:e8KvatPm60adHGSHXANXp0Wo3BlcmKCjh3q5+iVdpeJrUbBJ+PoJhfOI7+TvpJ7vz1tb4HWZDbulRQZ1uos8zakTJyQLljSH6mft16K+tPHzkXkx+ZQwRcyJ6nsC/N02aYuZFJhiSOuVJwzA81PUFudniLCKBs9TvQlFVSJECRoabh+op1ag2LODfy2XJa6oJhez61lR79a/1DgMjUjc8ZAkBtGTYwtzAie5D3NwX6Kj6g6T1hIY68XJUO9Pw5Im
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1230;20:PygjbWEmXt2C4aU4zcKbtlC7hvesncytTyNuo8y9UMWUMgqv61aVX7O1PW9aBl/4jtmxaSGpFwHdR9Y7cRJFv3JZjVXgJTk418XCgzCn/99m6586OeJvude46KOaUHKvZURhuyDudhdOoAoKEA6YvSanwSExrfmnTTcienXXkd4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 21:34:55.0881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2037575-4b80-451c-3940-08d61509c1a9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1230
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_11:,,
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
- Fix cg_read_strcmp() always returning 0 for empty "needle" strings.
Previously, this function read to a size = 1 buffer when comparing
against empty strings, which would lead to cg_read_strcmp() comparing
two empty strings.
- Fix a memory leak in cg_read_strcmp()

Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")

Signed-off-by: Jay Kamat <jgkamat@fb.com>
Acked-by: Roman Gushchin <guro@fb.com>
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

