Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9045AC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D7920882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="MviMoSBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D7920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbeGIKLF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:11:05 -0400
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:26701
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932427AbeGIKLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoF27DPDGOhLxtqHt/Iw+B05KVYyhxROoRK7uzMuljQ=;
 b=MviMoSBUyNYuEQleBAg5kb1r5zGzhe8ganjyMBICkbfhJYqEwTEkxvGsjBttaxiCCIS7browdTOp4ILU5E0W0DCCeXzyLB8Bab8p7lK9xEMfW7oUAx3+FyT1BU3ilExHy7sE1XCGvAfgo65C4XPiRu4Y8UDEUPrGdowkye1NIec=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from sbr2s-28.caveonetworks.com (50.233.148.155) by
 DM6PR07MB4922.namprd07.prod.outlook.com (2603:10b6:5:2b::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Mon, 9 Jul 2018 10:11:00 +0000
From:   George Cherian <george.cherian@cavium.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        pprakash@codeaurora.org, George Cherian <george.cherian@cavium.com>
Subject: [PATCH v3] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date:   Mon,  9 Jul 2018 03:10:48 -0700
Message-Id: <1531131048-60762-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: MWHPR1201CA0018.namprd12.prod.outlook.com
 (2603:10b6:301:4a::28) To DM6PR07MB4922.namprd07.prod.outlook.com
 (2603:10b6:5:2b::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce6bf50-8427-4465-b038-08d5e5844573
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4922;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4922;3:toyRikxwFamCj+XhGs1pgkWNQjPml69VKGhtw0FU1XmsJC9eJv8YFtrTHkVoZITeuEfb8lJDeMl/TncWsx1yDkuLQE5KuTyAhU7e5p1a0DeuOY0K3w7D+XUu0w5L34W83+vG6n3F16pwyLYVTlbgcsazBRebUSoY2GzSXXNkR1FUzXVR/yd+Bf18bwzFcl1xjdowggj3kvvgo0TOEmLf4M4XMeD9c9+8ztpAbjK6e3LwxhhwEay6ZhgmQFjoJdVe;25:czhIY8uhFTUUTmPo3+EgzVfPvDeQTI/aSJAD/S+Af0ARhOgvBQplieW8ojujepXMFkKDV5BWTjZwIT6sLp03oOpqXtjnoCJFtAnc3KyHj7NrXOzEObVA9dsT1FrsmnOX3RrhInb7WIy8KKT5OzsJ7kNED3Bfwx0e/KxTnBazx9poLhu1WFsLi5e0H2p5s/lQP1d/dHn+7BA/JTyUc0FmzzQiGgs7lpwayRAIUd9VvFiv6Ci+nKpo3vYVnrRvJK+TMfn6J/6Zwrqw7ZqYemPX7CVBSpeVvGj6zr75IchnGkzj0PDSyvOzurjgfzdPFI7RnjO8/+zIhuQz16vIPbSE0w==;31:Lx/W1wCCt04oikUidXpAbdLe1+xwN9PLO19xJO45PVu+kFXwZ/ARjoiBeJ2OU40OjFiXKMgKiqK0F9etZBzZPwgwDqrlNeIFk8phgARR279mw31M9k0Ok91/dvBLZ7o1Jl0WK4Npx0gw3kuRVHBe6FytcfalpGOa6Sv2LTBtH+Mir/OycAt3uOjaLBmWVo7+ym+Walz3O+EZHH4z8k+l3jIwwvad0MCW4/kHiNCvrSM=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4922:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4922;20:Jq0Wpq1kupIJxRXFLyhVdCb+z8tbCqpCstqDwfMzdu2AqcqnuBBUJiR+ZuNCnr6qqbHLyc3ceItXN7Wc5Jy48KymUJ34l3VqRXZE8zD8C9vUbxdiiILbDRC+fwRcZk08cGW7rV7ayA2XaPa9UYXqhW+Em4qU74sdnZp0c/xMaKw7Trehq60KETn3Imm821I/qmw96BhVbAWIMEcrlHDGKyep8RkzAhR4Tqba04CgSTXeJXnwbfEGgG0BorSlDLBGCQld+pxMUXHK9d5T3BFbXw7tZ7RkPgqCXcDotb04aTM4nJXopsNVjefrlyChOzIXJmQLVjJRqzSA9c56iBVpoe90qKSWCPuMhjztNjFwiaUBrlCQxZpWRAj0nR5rzOSew2qUoppQr/PB2saXCHnpJCk/mmM8GNpv0V5h9wuMnAPnHou8Jirx/a7aYvHzZ6ICJTUDEPgqeKo3g3end4bH0jN9eVWFGuwHP/QTM/nZMbRG+9+m55ndg6OY7Yl3l5dq;4:eDzL5HlVx8BpKz6RGpOc2tFfOIYjRKEWeeWuBcpjdGWy6H6qI/YkU9HcmpSjtPxikW2qaBHHiegf1ee5Z4kmlyELZB4RJKaSVlhr7ov3ysSzFHg1bNC6fzOmGIX7xorzHVb2yUnR3drxIN0GKtNOH2y3suWXsOYD7ozjPY8BBA5HQWsWfds+U/3qMaGbOLRwSFOTO6noc5hviCK4WJv9KIQz+AILG2N5U4bu/YJAQWAyKZhDs3URmgpHHLOGhXOnnB37Wf3AdCue/67fjDL7Bg==
X-Microsoft-Antispam-PRVS: <DM6PR07MB4922778863E5E753C3369953F9440@DM6PR07MB4922.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4922;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4922;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(346002)(376002)(366004)(189003)(199004)(386003)(6506007)(26005)(81166006)(6512007)(4720700003)(3846002)(6116002)(8676002)(8936002)(81156014)(36756003)(52116002)(6666003)(305945005)(51416003)(53416004)(106356001)(105586002)(25786009)(53936002)(7736002)(2906002)(14444005)(50226002)(68736007)(5660300001)(16526019)(50466002)(107886003)(6486002)(476003)(2616005)(956004)(72206003)(48376002)(478600001)(86362001)(486006)(44832011)(69596002)(16586007)(97736004)(316002)(47776003)(66066001)(4326008)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4922;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4922;23:mM5EonxxkMBv171ed1jTpX6xWeB/RM/pQFQFUYz0K?=
 =?us-ascii?Q?3S8DyrlL9mcC68HFC/IqgiiUETFfA0LbcFNT8R8RrW21MMFKZXRkaIlBtYMr?=
 =?us-ascii?Q?xvHSgp+TSutrzbyTSH7JREhr40o8JtbUz4XLiuVgQfHCF0zxmvshvQPLArgO?=
 =?us-ascii?Q?R+UpeExEuiYSsijX9O96ivka32JPOKsvzMmxqEgbl/FrM/YdDEVBs9Tpu9J8?=
 =?us-ascii?Q?HGwND7T8bcYr3tfiHt3d9c+9xVZw8F7KhU86np4f+uW7kWiLOO6lUaHM6Otj?=
 =?us-ascii?Q?bZJGq/cRRY0giMjzw2CYf4BJsyQoRd1S53OmUZyzHRwT3pA36KG8C9I/6zr1?=
 =?us-ascii?Q?a7+gM0AdiupODKKYUs4zOlG+8GY/Mg45r2TR9DhYwYnA3TrAUJ752U7N04Q+?=
 =?us-ascii?Q?+paUdXX8hc0Jxay8pJEf0/ptMHze2WW3hPzLfIPZuakiyFDp5vS7CxZ1Jav5?=
 =?us-ascii?Q?bzGIkmEsiwyQNTj2EOU4RJc7ZMiLvtmh4t0ORzgxMb5o+zDY6vtnuZB4HXC4?=
 =?us-ascii?Q?Akf3xTGWWwpk8WzIlf/gDaBIBh1m52KVGOubcVnKmvUzc6cacbjTORlPERa/?=
 =?us-ascii?Q?EyuN7oAdxUeA3sNSua0/jEDZw5vMXjV+NW3/AoP6sdh3x3yt57QmnDFgc8N6?=
 =?us-ascii?Q?RYaDbBPMbj2DV7Sh6cjYm+FHAkvAw8uRmtqlquCfW1e2TF390/UBN1rSShlF?=
 =?us-ascii?Q?4QZFXh0HmHVqPnheqTMOyqaOAL/hCfRtFxvRY/VwiODjfERR+BIo6voIz6an?=
 =?us-ascii?Q?H4AG4yQiT9Ezp66yiVPz+pHViEI12o7+06qYwr+6LhSKwQDgjkPyjSKDubcV?=
 =?us-ascii?Q?8hMQ0tOfFo7RpfrH9IK9OyZpUf+Od17FnFp/QI9XyEP3zZZzmhL9PCSVIbdG?=
 =?us-ascii?Q?IxJpr+VwhnEtDXQsr7NF5TQFbQX4eU3xMpnZDzcsJXDc6avuuMATDYlZRcR1?=
 =?us-ascii?Q?p9KQcdISqfeIb6CcJEKZUCLUIpZabt2M0JxFuRd62XedyIEz/5HlYAx7c3xX?=
 =?us-ascii?Q?iv8OTPTCUGbwEOxmdBrVXM1AIKrlD7Rl7VuxzBOxsxZxhTJAG0r4Gga8XdZ+?=
 =?us-ascii?Q?Vf7jyN7DhAdKbiSi+Ssaex/5AsxBHpuDI/fk62eSMaNFwRy5CHYFxaDTHiFV?=
 =?us-ascii?Q?PoN9yb1KdlLwsIN22hhiqWsXdgSzmE3OulESpBULonvioF3jiQuYbXB7X8L9?=
 =?us-ascii?Q?cCMiMDikb8wQShMs5KP2f65pdDY+vq8DAZRb9IOfwrXRLzpLHAV1DM16btEd?=
 =?us-ascii?Q?YEYSzpdqnln2Z8P2rs=3D?=
X-Microsoft-Antispam-Message-Info: CsS+b87DY+tz+P7eF2t+rZMcx14oc3YGsrr3ct1c69aQVuaW7aw0akXv7wi12MIYpf+uPEPfTr7Enj/3NpMwVnOl7UtiRglt+g6b2aD8wDSHXMqhQGeVU9wIFPLCaj9VhknmJw7PlQluxLMEMH0ZCH+7PcoNctEeujHO8aq1Eood5jm2VxHMfL10RpVkIkGBUFoquJ+ExkNr5BisnRjjm766J12rQs1lPM8YjUiTVL/m3iK1+Dyhye37onrb53HKRIkwLY9O1pkBL9XkYCFDJXZsjdpGGdn4vgUAvDJtlMtuZwFh1vS2jSnEbEZ+KWhryo2j/bnRBnjwPesty0IFucHO9QlDWVZ88jsOliKPQbc=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4922;6:7YZkJ0QeqyMnw4DUF9B9UxpeEBSaKVmoMTOAu0OxRgniiqlCfwFSyAog4CKRbo1PBNaNG+H0s5RcWtKE7E5BvVMaP1OhtePhURCYcV5OyNcxJ6/12hPicEHvJcr2HV40xXlc7L7EwSnVGuap0jJmqyyJS0zRDoOGjpxAYysDJ1swGnkF8ePlE3WoXLzI8lW9JM/R9xqOL34e5C6MSt4I4jOdvvfeKjI+S+4po/J5kELFJnj1TgB1foExcZCZrwb5Y0TlV99c/Jrg4bHj4NH0VPTOl+eVhvzetBbNh2KMi7FJ37JkMI274Y7mKEZybTXa7Nf6U4FxoQzeLpx5rr9f3p4xcEZcJ329jxE4OsaH6Pfkl54R60CfF5X5+E3Cu5NpQYJknEYURb3FGMKJ+ag5PGyjf/FLp7Ldq7FTfyiabbWu9opESsqJYGQRV+ZFs3yp9bCQ8YhkHNaFIZpVE05ViQ==;5:8LmF2PLSTRIcgaZuPEqmwTKHURok8/ed9vtvWT3FPs2KXmH4/lOc/uxVItY22yWYGSDDKAPA4UFVwsrsmkJecZrG5Oztj6JuI9yz/zpLAXJ3Sceq/jYAnniPgNQuuIqwMQGtDRQkd2+CZMAYxGhJD62kGq4G9pClQznNzxFctKo=;24:MCqatGHqDDpt8Y6t/bQn//jepxsf6NVMSKriIEqKhD7xuSQlMGa5gUsb1lDKeeDLba6Nb96fmtWJMAmEKPyXYWVwvm7ee9edix9v3BR3vOA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4922;7:ZXmCi9gJ4iXG1VKuqAxCW2Je5L/bzWdhzNYx9xWo2SvhQE1LgYSOPSPJh4j2JgjHqanC1SScRgqVRbrzBds9TjiX81DBh6mywXgMxZkKCU8ZgVEUOjbMC2HoOvkc0c/m9wo0JM8ppxJDguo1CY2G+3hidKLvAR2iF+ge4Zvt7L6w6NaacmQP8aVSzhKYGoaairuMwQtHUK19ZnWLbKzI/NcuV1ryozY8uPQlfpH49gPdbKCyVe4VTYaC5bMBJ6Kd
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 10:11:00.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce6bf50-8427-4465-b038-08d5e5844573
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4922
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
 drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a9d3eec..61132e8 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -296,10 +296,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
+
+	delta_reference = (u32)fb_ctrs_t1.reference -
+				(u32)fb_ctrs_t0.reference;
+	delta_delivered = (u32)fb_ctrs_t1.delivered -
+				(u32)fb_ctrs_t0.delivered;
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

