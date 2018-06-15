Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4B22EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D688E20863
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Y53Ixv36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D688E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936254AbeFOKDm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:03:42 -0400
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com ([104.47.41.76]:31980
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934900AbeFOKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihHNYgPb5bTp029n70Lx1C+VhXqQHlbPNgGJ1UTHq/A=;
 b=Y53Ixv363APsTQz6gAMz/leFT9wz9COLfp9a3jR11o/KCHiV9A5xeI/N49EKs8fr3cIPNQloeAPXIJw31xnnGTNQVxoOwO/56YPaC+leR+RPMfnhZpocRL0N/OEaio/fxE168ut2Q3Cw9Ok1INFUqYeTh/qCXTrxaLTDJTE6gEE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from sbr2s-28.caveonetworks.com (50.233.148.156) by
 SN6PR07MB4926.namprd07.prod.outlook.com (2603:10b6:805:a5::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Fri, 15 Jun 2018 10:03:33 +0000
From:   George Cherian <george.cherian@cavium.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        pprakash@codeaurora.org, George Cherian <george.cherian@cavium.com>
Subject: [PATCH v2] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date:   Fri, 15 Jun 2018 03:03:15 -0700
Message-Id: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0137.namprd04.prod.outlook.com (2603:10b6:104::15)
 To SN6PR07MB4926.namprd07.prod.outlook.com (2603:10b6:805:a5::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11cd22c7-f39e-44fa-9efd-08d5d2a741a0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4926;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;3:nHk/g7QBMHm2oD4NroLJFgf3ScPeKTyWl0yz0Dxfp48YwEy8ifeD6U8VJ79euZr6WkKgaxCQvzQhymmrH9on7ZjZf3Or9xrh5Xbl3bShuuVQqOOixWNrW8CamHb5JS/2LMi1DxTsI3S5otdnNZ7osZ7wl2mwBOYhR8eZuVBWgFHApn+UsCYSo9qcM6h43DsA2Ie6Tg+QBjoRQ48F8k+N6ghZm16sGKL2GhnhJdQ8JpmQeei+0nlkS/hVAXl5C5R6;25:R9PuXs/41oRZnYvefumr0xA+uVjz9YvKoCv46AuTXwEHg/0AG3TPVzqiNrg/hmmepkBcoOj+MNKG3IxFDAv7LVjfcv105ggxJ4HMXZO5NefysPZ9T4lqZRatgLonMYXn3GcRvorhaTr8NjECqOI59GBJAWDVIEf0JkDDxKGkh4x3WTQ7UbDeNJjjRay0ofcWmRXLFQ/zHMQ1EvhS+b23C5MbncbjACvyn+AZM0iS1vsbLLu6QY5/D+vPbWzdaddu36grOqYoRuR21ICsF5mybU54+xIKLAMpIkBmJawmlhzDPLiEviZsOaHN+ZwC/pi2L3P0lG3vNMx8vC5Q622iAg==;31:NLgy2HiO16PNr5q4agaW/EunS+05dtHTM0QFvlclRv5fvQpPE/NL5i6+2hjiqBHRcg+ntMnphIRqmDiNFvsA5o22D01G2BDziRG5l9Ag40Rkyl1UauvmvvAug7AKURJ36XR1J7D7jDeX98+I0a7DThNqM5bUDAtjYdPdN/gZaeJ3JBKi2GKs7JRLpQIBuseNlrPYwP8E+2XKAZIPUg0KJroJXV1ls82bUCkNIkE4taQ=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4926:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;20:DyFKa+cZ8xUohB+l+dvi5+h4w26ISBo0cwrFm9A2QcXQkveZgrbcimMUYKsuqIwELXwBmfV6GL20++RRU38W3UgozMeFp3mXHXnPvEm/uWjkQEn/8WaikCUaebtxyANPa5c3MQYwV+unSCBFsuHpkhTMHH+99SzhSHnDYKPKwIuUd9eMppTBR8vwtyxJZHahy8BwNMcba999OD3860oIA5J7UUDTusfxxu0bxzDvQugHUrF2BoX+yc9QwoJH/wva8lBGnHmmKSMTvIcWC2dghkTHUAbcDlmo7Fu1tAQPvf8E2aot309GOHdh8mQV0P0H+aWhfQ5dNY4aOTyojahJlLcGpTXZRiiVTIk/LDxu1WZWt4Rtz7tcpa62Y6RzIn03TEuPjnhpKsmh++6q9tJsdYORnFHvBge0bsQlHiMvXWtmDZWGezvIK/9/ZltgjsH5HVH2qBf/ZGJd0j5u9IBU+Eo+8MCKPSnd+0ACW8ntia5LhQpLgo4fIQwrzj531QZZ;4:CaMHjaihQukaH6s8cFkudqbSn2Ir9ZVKjipyVlaM8B8f53mYPYq/+Fw1ez4O5ZCKQSeMoH7l+7iviQsURL8pkDyg/fdlNxTG4GM2QmkroifCTzjJW1g4YP6DiBHBMlDJ4hieuW+0VP+lyVA18SnQIAICebuIM7tLUCeD6chtZLpILPufq3l2+RVx7GBFad6ge8UZ9EzhTQKSqcGOFf1gL1hdP1nv7UWa7Sf8sFvlnWJoI/5b+t1yAU2xFSWs8PvDhBHiVX86Fe4txXc+OlVNRQ==
X-Microsoft-Antispam-PRVS: <SN6PR07MB4926AF2E43104265F3E2C298F97C0@SN6PR07MB4926.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4926;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4926;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(199004)(189003)(3846002)(8676002)(6116002)(97736004)(53416004)(50226002)(81156014)(81166006)(25786009)(8936002)(72206003)(478600001)(4720700003)(6666003)(7736002)(5660300001)(305945005)(48376002)(69596002)(2906002)(36756003)(50466002)(107886003)(105586002)(4326008)(106356001)(6486002)(53936002)(6512007)(476003)(2616005)(956004)(86362001)(186003)(16526019)(6506007)(386003)(59450400001)(51416003)(26005)(52116002)(47776003)(486006)(68736007)(66066001)(16586007)(316002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4926;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4926;23:rxv26aSMoV/0Dt89r/SnpI13OA/K+vxOagKgNZyCV?=
 =?us-ascii?Q?dt3brAKyIh2HtO2BJoZVna1M5rL1EmLIP7asgZHyVdWK7c0D9uq6MWDRb/p9?=
 =?us-ascii?Q?Zjt+/GMQTb4Nvv4y1nzKZSlV59ytEbXGclpt3wTH1VFxsU7gYYsR8cR8P9bc?=
 =?us-ascii?Q?lp+zayvPJRzVx7+CftxZNtIxRQHIZlM7jA227uv2s3g0tfOXrxF70lylXGia?=
 =?us-ascii?Q?czdlDGpkAqI2/2NPX1RC6d3S3tqdG6RlE78Pf2Jt/XG6l8ZKZ+vA390WUY88?=
 =?us-ascii?Q?RctpNzhbR3XHCbOs6x6Vx5lXptlJ3yBW0cF8sRdP33sDFGiI36xJAzhMvGcd?=
 =?us-ascii?Q?XJu8FdOtTSQ8UyQr74xBvqGIqZaJ72rOzMe1Mf1qRJIXlQ6Cde2Z1B+wbXpS?=
 =?us-ascii?Q?THGogv/wy7axetFUk8iYzU4Rsn5QkHVgpSJ1T461ZTVMzcKQ8YYucTuBCeGt?=
 =?us-ascii?Q?ODYHH0I3DAQ43rd51NgzcGCzlBBlxAZZQ8WIM34ORcXTyxCbmL46T+lUwalI?=
 =?us-ascii?Q?w2bDMcRmEoBHK6cDQmL84ygMrYBUWmF3KDC9wNi90+mqcILnHG8YzX34MHE3?=
 =?us-ascii?Q?tDDDPvx16UxW4d2i5WEv2XjvAJGd9BbG6b/Wd/LZFTyk/r83co7Y5D3fXSOM?=
 =?us-ascii?Q?g7iM5C/YFQKy+W6vLKmoohCAQHa19vojlKYTtjFN4C4zUOKJKOLWIUjQmsM2?=
 =?us-ascii?Q?CesTuxeXwULWQ1aNM5dagvrxNFHJeE13mwDCDJKVnE0WQ20XvEFNcDbHwTxN?=
 =?us-ascii?Q?wo1C8chfmZhWgW7/fB96AuDvXm0kUSacPojdplmE9tH5A+qfh3OoofKxQSnM?=
 =?us-ascii?Q?NYPITNM7FrU1kpAB25Y8XiYm5IdjttjqTIbcdOkbstHeDWiEt/+vTNRrsp9o?=
 =?us-ascii?Q?KxO3noY0h6AB4SYcTxY4KGE+CCSd/xnTM9pjicyC2HDD74L/pJWskA/vIQgH?=
 =?us-ascii?Q?BzsHxNTJiB5OsVZXDVg+ET5X8eSZTK6xbyychqH6ElXtSKIYG7w/VmhBH7pg?=
 =?us-ascii?Q?LsjbSiLzfFUaZliT3hG6r4s98LXu7R0SOp4Il4UG12wlIbPC0EAKfrEgrDdK?=
 =?us-ascii?Q?fiq/HS8owjaBYg7Rpsvm4+cQFNxwS7SQLkRkn4Gpt052Wn2htlbOXn/2k1b9?=
 =?us-ascii?Q?Tgxl/13uTX46sRPtU+YfNqosgWKwddPqHVWzaZhpIN6AAW6vquqNS9J8Qdli?=
 =?us-ascii?Q?o5p3lgysYdjeMycXiqdj9m4cdu6TGFM8NIBGP8YjXPbHWm69tbQSf5A0135k?=
 =?us-ascii?Q?mObiTGh1gdiuCu2Mewk44tuOoqDtkMC0sliL6PS?=
X-Microsoft-Antispam-Message-Info: pEyPmT9Fsz5Ac53TzCUllqGUNa6DtGDahuh1zCxtOYALZIes2nj9dqQMEJRdR8kO1LeC6rVKQivw3cYgFw768liD8HAm5HFiMQ46XB4TlLZXdBuryhVXHTOqpyyzcJSx9mB9lDnTjfYXigcd+3eQeQdB76yJqIYrvmmT+BjXdAWMY/Fshmrv2nrU3mM05yS3
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;6:FYlK+Im5aqfrRXUEr5DZgcrtBVHfHRUDnmXxrCF5iE1+w9Jjv4MePVpc2FBrCSwb1Q8CLZRZ40f811QB1dmjcdOBsgjqqc3/ih43MOv70cBJiG/VvGG2OJcbOj9JoMcniuI2KTmSYAkiiw+1fHCA4kwFj4UA+zbd4ECXKdnf1n7+LER3buRh7x5pCDghJRGtrPzGu0d5gB1VrE1ObsFUni0tWGrHGx75N9xsHC1lNU6mb+8qySl4bOFY9IbArqrqU7aInrDNvi4htUHc8bGp56sd975AEPnnufZqYpsDVf6xbBTQS4g9w4j2MjysywGSzxxxQIXe1k4MKTbKfenvA317mibiqdRhWB2RiFsJvVfZEhlrOq59AIVeaigxABat8ylDnN2G0dyi+A6G5aFqS8qV3UI965cQx2L9vBYYcqwfc9m02r56OtkIlGjoZ2B/Pw8BfTj/+EWlGz6j1s+GAQ==;5:Sf5xhd1g5DTAzm6EsrK6x3X9bbhSVgrsJoCG0oTGMgXgwE6mUD7tZvG4kb0PNJUe29UAon72Y6qPP+sd9shKMt7yN7ru1YHWClyEz1aRJyfW6twdQ1EIDFMg8S8Z1aAPcXnNASprjPC1CX8tE6mBWAi61YcrOc95uv35eTnlrIQ=;24:2G5vpwRudjsAJfNnywcLFszdXAX8DYVdjDSTqahCupy+tr6ja3d7IegQfUx1mi/ydrhAHIigsT6zRqzmKCo8HXm+/YplicQuXSE1uk1hX7A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;7:R/Ktj6ecZ6bIoA/mvt5S13RfNAcXmcwJuOoUU3Oj2TeEu0WFLsnTabOr8O7LwTV8gxiK9jIwAN6GvruAM171A1GByHCTLtGUnKhC7NHffnEjKYuhQr88UtHT9+wBzFq24naIoCrA16/hGodCrl1Ro1kmROhvAouni3mkNSVuUfQe0HforMNYSz3akCSYzDUFr+zYKRrJKKbRdyGpriYwzMt/Bx+zHb8YFa2OFzWgOFRpk1TinIv3ZwXU2PJFDFom
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:03:33.9576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cd22c7-f39e-44fa-9efd-08d5d2a741a0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4926
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
feedback via set of performance counters. To determine the actual
performance level delivered over time, OSPM may read a set of
performance counters from the Reference Performance Counter Register
and the Delivered Performance Counter Register.

OSPM calculates the delivered performance over a given time period by
taking a beginning and ending snapshot of both the reference and
delivered performance counters, and calculating:

delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).

Implement the above and hook this to the cpufreq->get method.

Signed-off-by: George Cherian <george.cherian@cavium.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 71 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3464580..3fe7625 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -296,10 +296,81 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{
+	u64 delta_reference, delta_delivered;
+	u64 reference_perf, delivered_perf;
+
+	reference_perf = fb_ctrs_t0.reference_perf;
+	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference) {
+		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
+	} else {
+		/*
+		 * Counters would have wrapped-around
+		 * We also need to find whether the low level fw
+		 * maintains 32 bit or 64 bit counters, to calculate
+		 * the correct delta.
+		 */
+		if (fb_ctrs_t0.reference > (~(u32)0))
+			delta_reference  = (~((u64)0) - fb_ctrs_t0.reference) +
+					fb_ctrs_t1.reference;
+		else
+			delta_reference  = (~((u32)0) - fb_ctrs_t0.reference) +
+					fb_ctrs_t1.reference;
+	}
+
+	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered) {
+		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
+	} else {
+		/*
+		 * Counters would have wrapped-around
+		 * We also need to find whether the low level fw
+		 * maintains 32 bit or 64 bit counters, to calculate
+		 * the correct delta.
+		 */
+		if (fb_ctrs_t0.delivered > (~(u32)0))
+			delta_delivered  = (~((u64)0) - fb_ctrs_t0.delivered) +
+					fb_ctrs_t1.delivered;
+		else
+			delta_delivered  = (~((u32)0) - fb_ctrs_t0.delivered) +
+					fb_ctrs_t1.delivered;
+	}
+
+	if (delta_reference)  /* Check to avoid divide-by zero */
+		delivered_perf = (reference_perf * delta_delivered) /
+					delta_reference;
+	else
+		delivered_perf = reference_perf;
+
+	return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
+}
+
+static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
+{
+	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
+	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
+	int ret;
+
+	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
+	if (ret)
+		return ret;
+
+	udelay(2); /* 2usec delay between sampling */
+
+	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
+	if (ret)
+		return ret;
+
+	return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
+}
+
 static struct cpufreq_driver cppc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
+	.get = cppc_cpufreq_get_rate,
 	.init = cppc_cpufreq_cpu_init,
 	.stop_cpu = cppc_cpufreq_stop_cpu,
 	.name = "cppc_cpufreq",
-- 
2.7.4

