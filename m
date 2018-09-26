Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13433ECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BC4214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RGmIWkNx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IssDZjo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BC4214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeIZRqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:46:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54110 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728107AbeIZRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:46:50 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QBXBJQ007547;
        Wed, 26 Sep 2018 04:33:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=8HM73OJsbhoG+rNfuP2GxVbF7TnXVY65G1oSsuOTvo4=;
 b=RGmIWkNxmhbi6O9GPNr6GGZ4a1DBU8wCenHSkkHTeFdUeB0D+Kc8dt2//iq+Mo6WnLe0
 +ZtKQaLsyV/DVMixZZpZm7V+eQv/9biKwidgi6MnkmiZx8XPoJHbK/HOrzE6PJGpErgu
 00FYrlM/h5fkhsHpOmOD/TKkSUOuFymTiIU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mr5j2rjt9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 04:33:58 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 07:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HM73OJsbhoG+rNfuP2GxVbF7TnXVY65G1oSsuOTvo4=;
 b=IssDZjo+TOYWBCTDWQavq/rM+HgxJCnufrIYfxkOiv6PyqIYEYkeeExIhGq8t7wHPmYUEu/60M7oadeA4YPhe+KqiUkmImJhdg5ARoQ4CkDzFEaSXr5GB4RO+JN5s+akgnexzbIcjZHsAZjnOa85oFiNcIjODHZ0WUrCDhEZp+c=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:15cb) by
 BLUPR15MB0162.namprd15.prod.outlook.com (2a01:111:e400:5249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.20; Wed, 26 Sep
 2018 11:33:54 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 05/10] bpf: sync include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h
Date:   Wed, 26 Sep 2018 12:33:21 +0100
Message-ID: <20180926113326.29069-6-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926113326.29069-1-guro@fb.com>
References: <20180926113326.29069-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:15cb]
X-ClientProxiedBy: AM6P193CA0005.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::18) To BLUPR15MB0162.namprd15.prod.outlook.com
 (2a01:111:e400:5249::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 040bc351-62f1-41f7-cdac-08d623a3f15e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0162;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;3:47z+G9v31kPfgCF2bidYDpWeZHcoNhfSY4ITUuYWZXBXzDsfZfhh3VJsa7tpc25PGM00mbTCGW3OMWx0FEFRuVf9tho0REOw9cyRbvAcGIfEHZa0fr1lqxzOUWXNVaUEy92f2IQv/Md8hUhZ1crllyHGLBt/40LAeNNwxflfGUnQk0w7hZGJ8rXdB8IZtEfOUV2/EoGzGKjCMcNdNjXGi+n7E5svO1tkqAHT91ypSOtn1eCZYE/UkI5cRMdQyQtt;25:zAw+V9sXThELlcyRBZ5fqtk7ABD99gks5BAyZ4o9uIqbXg7AAop/BhykL1DP2UUF5Jlwy7R179co9hIbeqOM3xqzNl2fSmE5UP47D1jMWXTJi/tHSg7+bV/tJFbNPqEB9j8l7rF68zv2nvVkAYS+18wZ3Pta+yDBJGbCdYvoNBT0f/r73QThgkKbPQeby9yur7AG4zDGeuckV88F8KZWhuE+jyDi17xN6esyguibcE8uqcOGqWszw+OXKDbrPGCsdLNHsESoIwkQjkmpWNaiLA7SYoBePGL2geVOIHoHOL9FZWF06BunLx7AFMSszZAGSEYoQvMfgZriXkAAJmqcyetfukqX5TqFG5bxS8rgTjk=;31:5p6+CU/m/pKdXQs4GDNq+/Yu8Id/AbQa4eJeIRQ46Efn1PZ0O4IJWSFJiwMu+/tCgkAy2++6HARpwJWA0zHgV4VknY2AACuoF8YREhZDg3J0KuJdj1wbuIOa0ywxEFa8WVPLI22hIBiIOsP7sUdZRScqrPg2WF/Xvtkyj+a+PJZAB+Rgi3AFqciRJulprmwffQCauzkPkPfOPXAJUheD0mBF+kkZtS0Rg6fOPo6c3ZQ=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0162:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:T94NJWwIKRkJazzUu7gxVxFGwV5NDK/te67U3OJkTqTmf2maBESr3cGa66zTx7Kgl5ORcM+2mIa6Ja7C8UhnqIVv7fg+3NMTrX7c3Jn6M35Y/HOs54f2W8i5IvLm2p5vUHVLjAaoQ2q0Pnn8Vk18aoGg2+YxHDt1QTFbJK6utCsg7KbzghbavheBp300tC6Ipabqa8DpSY245qOx7xC6TqjvyH2NzfnwV5TZ0mTnULwXi2NZ0Oa5zGKFNkzHosB7Nr1E7tDYoQroFP4DY6Z4gkJ/afwjwf90je/OQD9yV2at+Ad1SYPNUTyjgfjCXsANwfkuJpQhqVLJmX48gwKtUoh7Xd+OGFb+yAwolbBAGppqGg31ntYbXxdkCNztorIIlKQ3WSy0BCnCfSr9D0SBPTmuSwx+FrnB8JyJP3WvpM1gE+w1DE9euoB9UvkD05UnTkgTvfIMjEBg0xRQfkATk1ZXbJW254pUCeE1DEKVyYmaNCze2oGthulFtRQ9+oTZ;4:XCZpzeHOnQ+jHYNnoeQNpfjACP0KI3eH1cgfdy5V5UjAMrngxsvxA/74QrJRhXneve2il15kwqvOWm5tiJSlVmwrlnzJeEWjeTWsfuCixV/QldJDCM/yX+0mXyLzcqsBGc1Ry6xqCO4YoZIP11Y1gLfaPaD4WXSWTQ1hWkgjYG4/Bed+ASw3LDsvpVCbQ5/j+g9q1emw9DdNnXFfg36uYv+CtBfsRBXler3DPi9+wy5bslzYEeuaWV7Qs6pwefhezX4R3OCZm6omHmxHN4X1hnFoORkZc0yGd/1bTugUz5+uAtS/mDvHYf72ljl2P3Mf
X-Microsoft-Antispam-PRVS: <BLUPR15MB0162A0994D06B1177E3FE116BE150@BLUPR15MB0162.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302057)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:BLUPR15MB0162;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0162;
X-Forefront-PRVS: 08076ABC99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(446003)(16526019)(478600001)(8936002)(46003)(186003)(11346002)(36756003)(52116002)(51416003)(52396003)(76176011)(97736004)(2616005)(4326008)(7736002)(50226002)(305945005)(476003)(2906002)(486006)(106356001)(6512007)(2351001)(48376002)(69596002)(6116002)(50466002)(1076002)(53416004)(47776003)(105586002)(53936002)(6506007)(8676002)(16586007)(386003)(54906003)(25786009)(6486002)(2361001)(81166006)(316002)(81156014)(86362001)(14444005)(5660300001)(6916009)(6666003)(34290500001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0162;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0162;23:qsPzqjCMef5YSOzLvPNlD7dRrD8wOsdvZEtPqU+0a?=
 =?us-ascii?Q?1T4tNgGNkjD/0Q1ahssU5iSvGJB3wjM/tPZ1Ll0IDqM/4BIQIAgYf7I4JZjM?=
 =?us-ascii?Q?n4LXtjOCD3USN6wBtaiaAtJaG0r4e2JivosGhwBUg3oh82KcC/2K7vzQFP0f?=
 =?us-ascii?Q?6nIcPKbQvfvaO9nZDpq+uc2q2lAtvzKYlxOAV9/j2Q9whRUcW2TRfIJfBhmp?=
 =?us-ascii?Q?54nrjV8eCIX9SDEaqeZ+HZLPJmz5k467FLWCMpvkdxBRW36Dht9SvCs+3G67?=
 =?us-ascii?Q?4mXEvgSkHn8kWfIcQB+BA95NqB/dQuerOHVqLDsYYMSUXpFc/cUY7ZeLJeUE?=
 =?us-ascii?Q?/7VMWHpGKSlRl4gLULyU10gcoLkOh47TqpgO33SdDuZaZNn0SaSckFwdzTzm?=
 =?us-ascii?Q?6YLehnR12HV5GTBf8gYvw67oq8UomGC30Bji4FYSqLLfSGEnhhRCCf+CCtFE?=
 =?us-ascii?Q?6garpEEI72RfPSestdDQ1/b5Cwmj83yIuThCIkJ0etTI8mNQGALLrQr9cifV?=
 =?us-ascii?Q?dI9r00V1FJIQfow2KxzmTWECib6QLCKS/TMXvcvebe2pwsr9Ol5Z95AVOCHh?=
 =?us-ascii?Q?Da80wW/sjAFYDe3krGq13uUVxqY8CjO53SKkcp42pt3yLpXZpjDRXr5rkkuG?=
 =?us-ascii?Q?JLHsKGzfMC/6P59Y0BIznLLWta/1A9NdMLfO3nd2bHt/6h304zvi6OTaclFG?=
 =?us-ascii?Q?aEEipZ+QZ0rkmro4CRuWPpb5DIftsFg8klrAXBrDYSs2Lep+W0Jmjt/QOlJ7?=
 =?us-ascii?Q?wxukuBzuk3gjHZVXjdJkiK4FJVi+Rpzz31f95VzcOsQMli+e9qKXjgQ0U7tj?=
 =?us-ascii?Q?CmsiQZBDBA8FS6zpHU7GuZlU6eF8hlbeHOGaRzYp7aItxOmVkHdEHiNDfmGt?=
 =?us-ascii?Q?Fvjiw31z5OwnvORvKxj8K/lz40BaXXuvGuzLdzrApfHYlG38575iUHc5dvPl?=
 =?us-ascii?Q?l1E3MWwxRoRcsaOL9OkiUy2lWbuDHZayparkWsVcaxCFct+czrB+43NoxXoC?=
 =?us-ascii?Q?3zgpSipHw99FOglRgYWOApyQz7ZuH0dOcKXaAoKg1Tk1vEnJQrVcDVsT6GHC?=
 =?us-ascii?Q?Mw708q+nrSZCZzsOiH7Ftdm/y0ZpcNss9BXfZ1K/IiE8TYwRAOzCFlouXW8c?=
 =?us-ascii?Q?W+SDleLAwzqCYgBlbCh/fr8UFKHDoZRnX1Xy3d9sXXkxTSgWrcsdo4cmIf7K?=
 =?us-ascii?Q?ryDRbTTodYJxAUaMdjiLQkmSEN1oCkGqMeEPhTuC1GeaJfDFzuONdHdRVhPW?=
 =?us-ascii?Q?jdmb5gEnq8TPDh75GTkFkto9FguBx71Rl8oFWyhhvraayWQiWyLetOkTKsww?=
 =?us-ascii?Q?hvqI8xHib7HwLez4IR9q0g=3D?=
X-Microsoft-Antispam-Message-Info: uGLKlWdmoQMJzjocpl/s3SXwYCDEASycib5v2s2jGYmP7NmAeNwyLC6BU5If6VdSzqmkSfatSMKMKf3VNKiQ0G+v1cMZjVEic48zJRnTVVuqvRRm0VTOPpKbT/J/ee0NOwcP8K5IpMRf63MfNJ/cYlMfGd3wAzX5Hp31gUVAkgl08lEYGEbxV03jqMKir3HD00SFM+gBW17MGYnhV3UfKmopgoL9ccOc9SP2tKZpftRRwpbTauZ01fXwTecm4CqGICvvAXE8fV8nfDbLPbCiq++DKr3/3j1slltMEKdYHA8B9H97Qxwxg10ypvLs+BCVIsenZAaIFuzb5Dd2cLfemQwY5A40FS6o4lNJnPkQRhE=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;6:KlXCGO3LSmUNFOq5BYHg/XSN7OedLLQIqh530TrwwAFEZy/QCae9ATKKSz/93m+5wGhbdPkWQIJlWUE1GIGa+Y8htxlKjdkNUanjgSsaSBsCwM4SxD3+VJ2LjMVbnlWZ2m/Dlhvxx05FqDjsYMv0W3WeOcY2WQC4T6hHPpREQ4GSmSXVy6TSqSliU+GdmqTojmkQFFrR3/l9Q7V6T63VYoAGSqaJAeoJYVVXQOvMeOtICpOIH5KXB8VUFGssBXUjFM5E/ePIGG9+8wxpdEjZTycowBkWOOrZlvHrKbg+VPaYtdDPgoCZAxjmIvqbmmucmBw6o2j6tDX3+9C31vrXZIWSWU9eXSbF3f5nHK36P/896dBo+up0nkqwVk/70WoXb5bOUMWCQQpnERRlcy+Si3WBGK8EjK231a6Tbt8J+Exj6bSPFnX49eGVqP4zFkb8iiLYGOA4AEvWV2FDGjZTSQ==;5:Wodi+lssoDAcB2U59RUji8OlA2RRQ+wj4/q/R/xyTV/neEuGknVETOCByog10UFiMK98tq7wMwrA/XSzxdPWfp1OWXv/Pf96BtCDZL/milNX8S2lSaP/cRonIsPdAZkB1heVe9Hay1Js+MhpVIjc9a9x38GVkKY8T3p4WRENiC0=;7:7T2RGEiCqKxLBvGkDakwQid4o6GVU47WA+i8qrdZDFMGlBu4ZzrgdYN0Cn3yAI7e+B0qrDaPPA4LYXi5un8hGxH/XoWZ9cr0UDJMAcAYTWebavXjnRLE5fNxfUJueCTK4T8tQ4LTWHskG4fheapCOD2VVGRLwcAkCXBJ0j5WKLsn/cI1lR8k44scELvkWN7blAcuC5c339RdUGdwPFPaUbW81UOBOF+TS+t77N88z3iWpwl76bYAZJ4n1kA4hrNg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0162;20:J/cAEMw3ToD52Tx2Ir7iiw8ON78U5LOAz6C8ExfiaDJWPxpAwsQCPlA0OxfnSFdGJfXlORs/lF6EgsyEsf4348RmlM4tchuHlApRzl1SKwZ9hFpKK9CpX1Y4PUjcWO9dK0IeDP+2gkD8wtx5CxercI23FM5IFq2souWZsYwr3uM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 11:33:54.6920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040bc351-62f1-41f7-cdac-08d623a3f15e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0162
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync is required due to the appearance of a new map type:
BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, which implements per-cpu
cgroup local storage.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index aa5ccd2385ed..e2070d819e04 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -127,6 +127,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SOCKHASH,
 	BPF_MAP_TYPE_CGROUP_STORAGE,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
-- 
2.17.1

