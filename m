Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4D9C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E5C204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="LbozfbTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E5C204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeGLGQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:16:15 -0400
Received: from mail-by2nam03on0064.outbound.protection.outlook.com ([104.47.42.64]:35584
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbeGLGQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aSZfBpKqyIJAOodhgEmVd/63mlUc9it2Z3QdOfXwE0=;
 b=LbozfbTOJgP0XvCwP8YZe9mzAUHMAsVinqtYCOKL8HK9Mx0+Bo15IMax7OKicf/PN+ASC/oB+2tgSYVlKp/gVE4cLZb6ICE71WehamAhxkvuSiuAYN6l5sRR24MVMRS5S3hfRN4JnFFx2DckDIXYOAEz6ZKys1E/pASjSe6m9N0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from sbr2s-28.caveonetworks.com (50.233.148.155) by
 BL0PR07MB4913.namprd07.prod.outlook.com (2603:10b6:208:43::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 06:08:09 +0000
From:   George Cherian <george.cherian@cavium.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        pprakash@codeaurora.org, George Cherian <george.cherian@cavium.com>
Subject: [PATCH v4] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date:   Wed, 11 Jul 2018 23:07:55 -0700
Message-Id: <1531375675-52623-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: MWHPR2001CA0010.namprd20.prod.outlook.com
 (2603:10b6:301:15::20) To BL0PR07MB4913.namprd07.prod.outlook.com
 (2603:10b6:208:43::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c046cb-188a-4355-74f2-08d5e7bdd7e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BL0PR07MB4913;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4913;3:RpDf/csJP0VO2nhvjDed3v0XUzSjCaua3LORtHlFZV/mfdWCDQ5QLXZrMa96BNWjDTcT+rC/6citMdvADvMG5Wj0hacenhBKudbge8z6vs5pT6Wm8XN6l3CGB9gM6zljCdJCR0OE0yEpxFvhCXFZVzS8l8AA8J/a/X7oZqPxJHIMLTZ1X5ZRZVjKK1ehgCJ9cnqH4p+HidDiXb77sw0MGS7lBHzBoCu2QzFEnarw+XkTsqUTxZuMHNQD/S4/d9xk;25:c5+qdEEq+i20m5RtDpxL1C2aLq+sJOsR+iYpFXjylbgVCdm1yYPPgmmtgEbztK4QF5jffbXUNXw+M/yJ7FKhTsOPhGeId5x4Uj9FbdcNyIjR7Mtx9f90dWIzIMe9zTTRGYECNezzVIIi+4jOJyrGqM44FIM3oGcwmVFh8Z5wNLbf8QKTSNWd4b9JxJde0S5GVJVRIJ4ByzWgKSgv+s2AhNBcDmANyHnNH/BwGTtE0cWrNaP9wX2VeiaEItp+bjchN5VTzFtSz6Nlr2qa/zDV9TEIfqUKhonOtQdpON6SyIbdt0mYZDnUWowf0FusVq4+yM4yxbCX9HdzI/zrW+k63A==;31:pODdl6LmOmCAsmpVedDC++wewDk4f4bNlcsEidT4k6S5ztmUc1Gufb3BXrFHo6hk6LFMkL7/QMnqDra03sZOm1xHruuoEygFd8SvdheCT3VUGiZokx9szmumBuSdiR2yL5/vjjocaRWtFjqTnVdZWVZJf8AskUqwt7rbvLhisMbAMPEurCYY8WAoqzuP6UWKyERGoqhlVTXFevOpM7dPFh5/FODy0Vxj9iHJmu/fiZU=
X-MS-TrafficTypeDiagnostic: BL0PR07MB4913:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4913;20:YkQeSAElIcwk7zfJr9M1xtmY8yJ7QvIHQS5yqKesXx8C4sgV4+wOjqDsCyNGf4eFL5S9uyisF+z9YoYD7+vXDyJ7TaEmpKNwnHFRlyfAyWTeP8GuT1+BljsRcYOmRrIyRvOuCbkAZvZRel2LNGPzWExOsXaxQrWHOnNFo2Q72aXrgHEP5D9xzI3KA0UbFPDK6dpff+5Bz+ayf/UGfkK2+nfBkX3uzm39OHLaLd9PCH4H+HvDG3a153r+eqMn4QylnkIqWYz7g+DzPnjqvcpIsBReL3UUzkKWjC83HMJPA1/6Zqc6nRNbr/qCRH0gv8YPzPCQysRf/ZtlZBiF74rBlbe3qCUbfu4uUPiQG+LReXi9oZN9bgX0o7OI6fao9CtBPnO5vlq7lsK1aczkzGiBG1LMOo+MIriKfeWEGb07cNqiC0VSsXTGYn9jJmF+ekkrQIpUOCzXVbFX8Yi6s54e0/cI3HaE0/FF480lBLa3kHSMstN+XuUp437B7ZvcnLeS;4:l78n4qPeh+LMwGwyiHO9piqv8dntyHUWkcmNQQifz3Y2l6Ku2Y2Ngh3L7CpF0MEbFignjWAeA+Mq/k2zAXuqaUyihUMPsMO4GxYGzqooYfIuihHfKAvoY/CKQPf1EDnyre+Kw3Z5xuesqm0Pb6s+Rb2akG86HoIg26317A9poQnzDdxhLutnRgSi+OgHC7Z69wnownUwSmpQ7SKeDGHhQt6CPXeFpNtQObZhc3G0o5Ki/8NmsbYLepgG8v5g2gWtdgrZLSh/K3zBYIvddKMnMw==
X-Microsoft-Antispam-PRVS: <BL0PR07MB4913E48FA68F5C076A1C8F0FF9590@BL0PR07MB4913.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR07MB4913;BCL:0;PCL:0;RULEID:;SRVR:BL0PR07MB4913;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(14444005)(68736007)(86362001)(478600001)(97736004)(25786009)(6486002)(106356001)(105586002)(53416004)(50226002)(47776003)(16586007)(72206003)(53936002)(316002)(6116002)(3846002)(6506007)(81166006)(186003)(44832011)(8936002)(51416003)(52116002)(956004)(48376002)(81156014)(50466002)(16526019)(8676002)(486006)(2616005)(476003)(386003)(66066001)(6512007)(107886003)(69596002)(4326008)(2906002)(5660300001)(7736002)(6666003)(26005)(305945005)(4720700003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB4913;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR07MB4913;23:Ms0p9qOL5b5+79SFuz3bqJtxWzpWOsuBNlswv84Pc?=
 =?us-ascii?Q?c46DYmYne7B1VO1+76AAURy9Ho/MmBGNGBdHO6Hjn5DqepWfEqKENWA1DEHC?=
 =?us-ascii?Q?TE8O0J1jef08ctLD30ES4QSegz0IvSccO5yOvbQIk5hGHRTFVC4RgGDWL7sO?=
 =?us-ascii?Q?uD/Rdo3GnVI84dM9pma5rksI6PeXIlD980reiXEWv2DXiLa/YwRtfFfLPbiR?=
 =?us-ascii?Q?txtSl7dYBaTL8ZGkqOnw4rnqQ2kJzgiqSoN8Tt3CSbiYEu2RzdtZrAgGefL/?=
 =?us-ascii?Q?iaIEs2IcVDVJPXQ7V7pbjs0h9sJggl0IVMHiun0UaRWiN3wA5NucRENHqUEC?=
 =?us-ascii?Q?W+4JiYJ47cL8Y1/C8CWzj9wC4Yjc3ER07sjLPR4WL6jQZeJ4C0kOP4J//aVy?=
 =?us-ascii?Q?ejACJcZG1N9/VXd59w8YaceIIGxVKWc+H0vLvCUrfM5CESEbVh353521Lx5R?=
 =?us-ascii?Q?TVHTbXAy3NvMgczO+PEubjp3NCWvVGxbPnOIxDqFSKwkUTbxqmE5MpuZj9e3?=
 =?us-ascii?Q?r8xnag0W3wOkjOc/QISaNrTSAhKbxtGRFVNMcJ3Oqwoui6PhlwKvRPPRBLnB?=
 =?us-ascii?Q?jvtj5jP/EedqZc/wSGVfPDu+9n6zSPZO11z0CaWL9ENRNXBYQtGCJUI8GYj+?=
 =?us-ascii?Q?BLqtHa21jgTlsYPTh0gyBXyndJAEUrQYZYFf4mXS5oIZJ3fJP3DiR4tz3e0I?=
 =?us-ascii?Q?I+tUfNpWsm1zNiGXIA8Q96Hx6wJ29FPySIci193sxFuKkrvAgMI1WxJL7w7x?=
 =?us-ascii?Q?9PLbig5uSxtL7UcDIiTTw59f1llIBjEcIPHStLh93RSuPkGa9Y1KAChB4Dwj?=
 =?us-ascii?Q?memaNSwjNdK6VIsZC+IhwRO6ngsqu4R/A/a3X/nuWuBJc+/VXiC7pdSChUvb?=
 =?us-ascii?Q?+R/Z1H/b3c+TZZ52i3zEjflgxvTdFFlLW6jDAgJ2R0hj7ra/MOBsZ19p1JdP?=
 =?us-ascii?Q?J/oe88P7Dy8PFX0pWBPwgycgKj9rdzeUBanyxsbWTavdQsQtPo5KhuX4T5um?=
 =?us-ascii?Q?4v3VRT4pg+H/lLr/wVKhzNlFTvsq+xWNhrUC8n8jXOovPFFA74kP6K7oW5Zv?=
 =?us-ascii?Q?FBud6BUcLd2FR+8nt/zXzVRfAkyyLXNwPB3d2544V+xFiqY4LT4KLgtvO5Qa?=
 =?us-ascii?Q?pkbVHlYse0U47zcXvx9KIDJBGhsh/xH4085LrOu9YI7hDbGIYQcmBYMFsJxf?=
 =?us-ascii?Q?VwURIRoyDAK86vkA/Phkne8ea28bbllSONd0e49hibQIaRG/NHzbMo5UamkL?=
 =?us-ascii?Q?XBWQ6O7GNFkqkMjuEg=3D?=
X-Microsoft-Antispam-Message-Info: zmgNwh21+w7Yj+Fs50b6wIQJvkT4TMBjsgv7DpNDxcoXHx7MTT1wzTx+7Sg/OA5rHxqRcpin47I2usMlk7mhqF4XJ6AJXjneMI+Qux7eLY6QqZ0RyV1V3ru5Ak6wxVe2mzfiUqTzexLNGfrIAB9oyR+HxhDMOhaNhEJxu3lQLhLdbM//Ea8OoRHAnJYO7G4O6CX1rZFq/Xe4HjRz40oVDM4nOoJh3lfimtGxJfopr1mKorSZOf5/oHuu9O7v0b83H9g7SAB1ceXrNh5r2eJ1QcbTuiuzo7+WW/vyjrGEYppFheKSzAW3ANXxZabBnYkbVwS/UO3gfYT18S95iKgRACEII/R4uUS/zzf9hriPsDw=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4913;6:IWFmQyDX72Gazdvjs1i5H0WDLIs3IuJwAJ05WTD4UG/v943Yeb0a3nDRl3nCLCTK1ZFRjjM5AMPl2rdnyJSxL9q8V9HTg6KEMeoo/n/dfz89nDO5F5H+Wr55QUdYdjuxejj8CbDPKW2ed8T2++WTelm2+GVUpOQD2z0lv3Ikz70/N6BqyQXGSYvPku2CuUkZRy8bmrxk9yKrtyAQrxNwLmB2FepK8OztJc6w8hjxU5TWmYvFxV/Z50b/ASWWKkFCMkb3g4BqRt/1g0Zfj2BOtPZQNkD4WstyUJ23XWAW4pbXgPWXIi3O2Pt6oq2+o7REwiQBP1Dd7uHKDOpYlaWvwu0jUapVFxmE0LF2TLfudF7FJ/AcuSnkwUzUR01/4aSwXFhrg4QgXNgZ0M+Uw0Kp4wNx1zycrgYxOrsHf3ugXYVlE3OF6FB5G2D/c/Tf/6bxRLSz5gEN9a+hR3l6vv6Zhg==;5:JhxO6TDzGqdHxGN26sB7AVf0Uw3cg4brCvx1Xl8ozZoY+FeWeP7cp4Nz6r0l5EATmn5bHmlKFEp+IXskUsI3sgaK7E5Rp2iwih8ubDV6XQaClfq4Qgwa+7rrgBLzsDtUMBHHAAKQRXUFK+fViz0SNIl6ZzjskPu1SK1EV7nZS00=;24:nA9WIC6epYACd5Kws9m5RSYuP3Xy54dUbGUfwE5R0k3OCpntZsKbPQY9coX0jzWSANkwpFNVMXHAgKyRIIlFtaQ4LflFZCFH51cLHkSMa1U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4913;7:DSSQ6X/nGWzBJurjV4jY7A39E8v4srN7tPoQhj3l3XuijLZeBSgTd+xgyDGbpexQNeRwZp3krQ276g9BqtkkWoi8BdsjuNroim6eVw6Au5gsJu9tjuO+DIQhscssImK/kXICE+vOtrJBM7lo1fKR0Trwt+STBPMiRZkYKeBb2tnP+hGZjFYoIDShiAYS3vOotq+xyyDhkrhkGz58CJj8kQ9xaUdF6QkjHlVpS68Qbedkb+qAu8Q10N5g1EeSXYR2
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 06:08:09.1955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c046cb-188a-4355-74f2-08d5e7bdd7e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4913
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
 drivers/cpufreq/cppc_cpufreq.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a9d3eec..30f3021 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -296,10 +296,62 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static inline u64 get_delta(u64 t1, u64 t0)
+{
+	if (t1 > t0 || t0 > ~(u32)0)
+		return t1 - t0;
+
+	return (u32)t1 - (u32)t0;
+}
+
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{
+	u64 delta_reference, delta_delivered;
+	u64 reference_perf, delivered_perf;
+
+	reference_perf = fb_ctrs_t0.reference_perf;
+
+	delta_reference = get_delta(fb_ctrs_t1.reference,
+				    fb_ctrs_t0.reference);
+	delta_delivered = get_delta(fb_ctrs_t1.delivered,
+				    fb_ctrs_t0.delivered);
+
+	/* Check to avoid divide-by zero */
+	if (delta_reference || delta_delivered)
+		delivered_perf = (reference_perf * delta_delivered) /
+					delta_reference;
+	else
+		delivered_perf = cpu->perf_ctrls.desired_perf;
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
1.8.3.1

