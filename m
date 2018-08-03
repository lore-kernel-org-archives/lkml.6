Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973BEC46467
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BDD21782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="t0MYowi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BDD21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeHCTvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:51:20 -0400
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:15968
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727377AbeHCTvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfW+TeHXf25KA6qOupiMQV9tPEEtp8syyNbbmMvNliw=;
 b=t0MYowi7lPBK6x2+g6Mdq8oGFmSACBNuqqmQAzWbQU9URrT8WULaxtOB+C0uR1P5oa6yxSmofIYryB3wJlV8Ee0exwgNMHgfY6X6u0KY00QfXNknDo7x1rkg3z3+DUgkHe68Ih2eDlMeE2Fodhjjho1kREWii951WIOjELL1zdg=
Received: from SN6PR02CA0013.namprd02.prod.outlook.com (2603:10b6:805:a2::26)
 by DM6PR02MB4332.namprd02.prod.outlook.com (2603:10b6:5:2a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Fri, 3 Aug
 2018 17:53:53 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by SN6PR02CA0013.outlook.office365.com
 (2603:10b6:805:a2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50942 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0003jx-3y; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGp-0007cn-0U; Fri, 03 Aug 2018 10:53:47 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-JC; Fri, 03 Aug 2018 10:53:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 07/11] firmware: xilinx: Add debugfs for IOCTL API
Date:   Fri, 3 Aug 2018 10:53:24 -0700
Message-ID: <1533318808-10781-8-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(126002)(36756003)(2616005)(476003)(110136005)(48376002)(106002)(426003)(51416003)(7696005)(336012)(44832011)(54906003)(478600001)(186003)(446003)(11346002)(16586007)(26005)(36386004)(50466002)(76176011)(77096007)(39060400002)(486006)(4326008)(107886003)(8676002)(5660300001)(81166006)(72206003)(316002)(81156014)(305945005)(50226002)(356003)(47776003)(2906002)(9786002)(14444005)(2201001)(8936002)(106466001)(63266004)(6666003)(7416002)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4332;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT020;1:zasqvSYhsWAhFR8BsQqznPhHZWutS5L27pZRAjx7WftXVjIUELTIoOJpSsSUD+f4Oswo5TGe0mt80EAOljtkOPkYcNn1HyH7b8CbpIqpyOSsOFvajgMgeslMpJUI8FCC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d82c6346-76fc-439b-9dcf-08d5f96a1370
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;3:rqNZDnzIT5q+FET8pFU3tZhPuEQSRuq3R66uNM3S/YQeizIkJUv1TzWFY/cnr16gynASpVkaHVu+NgEqmV99BWHuleFqGU/UausrCgPe5E5iSh6WWpHLt1u/DNN5il1GhmQdvq7PxWaFV/bQBkE4GlFBsxzfBd4N3FbTarL3iPWhYa9vbozJ0M/Nnml87GSgMAapIihLkI2bXcc3ZpBpNl8A9xUekGpdRbs+LqCkiHvyompxXT7o8r8n/FBCgp2mw70SpIe65sNlJFhRnpOdk4Lq+jgv2dAqVTM4/2U5vttyQ6+r2OOUmbtiyk0wYB+kVa6VBJnGimyXT0lhAQ9K5tR5Bi/6J/Kg5JwOaVPCGKk=;25:bB6qzDqu9+vrR++q12i4He5KMFbdkOATwFddZzgEEFaemA3sUuUP/09hiJ5tRK5TVTkFPvdrQA8BMeA/lfr7zfLMSQZxJFcMA/bQ3iHDkOanuBsL+0T+Bjl4msOkUyZgwUND/zZyvOqds/cBKHyASeWm+5bHLnQYAB41FIQR9xdzV0WHJn3kI/rmqpH6gHXCQ/ItMAJF2sjSoIKk7lD44cYZ+DN4EMs8+yvpVx5HJoy4uGe7SeilyHewvq0GYKJvdQAW2wA/NV/g7iqjkoao8nOXmyzngN/IpOyeQ4tOU5994VjHiI8GX/GJekbZhRa4qQqDW2/36ztKwOSMb47qeQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;31:qIs/qh8ANOYqDxK++Xh+tDxbNjl7bMZ/TxTYtgX8za/VfJ2Cufud4gdaHkzWzDj4vwEqjT4AxbNNxBGFMVryjkwPnjS7pPLnxv8DQPnwpMSaP3n1GeWzrbe1HlOtzVY91LHyKBaiLOkkHD145GrLYEJ1TuygVgK1mpYYbwPlJhPPBRW5kwWagNoR9qBuRwdUvoYyBDm2Y4QrYiWbY/siOAq4VsOKBeSDDpgCqN9zk20=;20:lD7XRVhyJr//IUUVdzyMpO05/HTB8vi75mkal0CDU77BsCQUX6q1zxJrrL1ia5oy58X5YW8ZSkr1TvSCIKuIdsvjh1Czgkwcd8S3TC+gfeNM8LAURdI4kvsKPdjMhNENp/fgHtZSf0GLg8jC9Z72RjSB4Oi9XiZs3kEABq61d2D1RWxrGxVGDoH/6K9jVNELXZ07EDb3K/mwu3PFJe+SYIgxAi+eVkiMqnkGOyW4tzFlYJM4laYuBIe7hIog00zDrofIBJV+bCTzxgpmOK08FoRoeIcwoNJF1n3D7wmnkeQWYf3/amxjspYW9badjBxnG4UpevdTjCJmbAcAlov2AHODAWwdrCx/Rsiaakn5vRe5eQIs6lrQHFbvG3yadfFv2ZguoGXKjknbiElxMscOIXgPzdEUanEUf4qcLsqvvaAYslAYERDIhsUzxQzsTbpPlWFpqKr4/RYZlhGwWelPGEBI0cMpuQCOG/39//ShWspUfdWuIMBuKU/WoRHVR8Wp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB433255E3ED6901B2BF41F17FB8230@DM6PR02MB4332.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4332;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4332;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;4:r1bivONgYPOKb/p6qXDOPJBHzyosgdDYXJiNAopmRrSrT+J9jeJgDUCPVVVO3fO1iRcru7EsKw20JNH/de4DnwjPcaERa5BBQ5s+21hoQX1WUdtOAwRBXYVpHtIxcAl+q1Wqdy1wXQnOKyTFmYAfRvARB+ARy9E/xxPv0Ag6YBh86vBVKaLeTgzsrY326j9wAZO+5zfCmLZ/X29Jr6YrDQCIHE87NWE3DIePvOuWpfX+3ViMI9ij10zO17PA/d5Az3XsyJpJQCTByP1CwJYIjgJWu+oBxzOyQRa/Ukk4vtXWZ6CTxQG38q/Ih825CaKx
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4332;23:yjJEuHL1Zlm2Y6bhlYxp/+bQoRoza31Xn8Id0UIf+?=
 =?us-ascii?Q?xZsru2y24PXjkYY9CFICMmincmPADnRcL4CBEQShGlwX3yCgMn6NHhjoJFab?=
 =?us-ascii?Q?w5umqJ/+t4A360PUPD4WN1wi0cBe/V+rF4HT4jdfdqA/+cDFPqmQiuWiDeZb?=
 =?us-ascii?Q?B0d6Mh8fmqAxB3cITyC9KSTTHHe5A/upmPSISNPpLA40ORXQhO2l6CZf813Y?=
 =?us-ascii?Q?OirXjIk9FxF0jfhmKQa9fI88iYgbpJQ7cMkQHGDwlNi0RQ5xQFjPc5QXSeUY?=
 =?us-ascii?Q?KuUnpO3oF94rnTPJ7zT52IRbiXNWX0LRu0Q7Ykzth7tVt4gKRdTNN7bjUjep?=
 =?us-ascii?Q?Uw0fHFX55O/3fYmOOGnlyAZmhEbve2Lb1MV/p0FSw5hbBNM60a9OLNKviClE?=
 =?us-ascii?Q?H/iFOHCGD+ciOxYrLlmTrx3oJPZEOaeDtgKwzHBrredkK/0tCQEu0yhTIe+L?=
 =?us-ascii?Q?b8WkJWgathN+CGAy5tWxxv6GbUADwUdN5AWUowbMKqihFwEnIWjRD4M1kqMV?=
 =?us-ascii?Q?dsmqSqlHhVxIRpdS6q05pDifsSRel3Yvb+Bm3eU9m/M6mOastWBb0OU8Lk8r?=
 =?us-ascii?Q?NdCVWZdy/QARCw6MyeQ/GM1bxXWdv9tMPXKa2EoR6jZpAysbXAe83Y5sjWUN?=
 =?us-ascii?Q?zVgs78kYl2SmvAbCDr48ZhA1v/bsUprAt+NUt8VLRRyGFSRNv249eo56gHRT?=
 =?us-ascii?Q?HpEere1YLI07gMYikh9LY78CAI+Sa84+HCAsrWiWG/XdpSvobIPWvBAyXlPP?=
 =?us-ascii?Q?R9xby1SsKTs9BoYHmjfKWFdrEOzqL16r4lXnVAQObrPZCAP++85QmzybVXyx?=
 =?us-ascii?Q?Ppwx82Br6cAnqDjuZY6V8sNA/Uf3Rj1VwYrDDm3xypL0LbtG3Uv0KQvudB4r?=
 =?us-ascii?Q?eQLMzdGes3LA4GFusfTYW4SKalgceN1gIaguJGtEyiV5FhBzMd39eMZJAPXh?=
 =?us-ascii?Q?yGLO7d9HgJQOPo3z4mbnPstgZ/iskMQn+67t3b9nwFgN2UD8GfK4wh8FWLZX?=
 =?us-ascii?Q?8zQpiWXYBfqmGl2aM3QA2PMNWGHkcH4AE+kYGqZYKhjm1c+h2G+z4s9B1bZ7?=
 =?us-ascii?Q?LHgMZMdOdySH2zSj0g1yLuQDCrXbe7/C1ImlxA/6PqKNVWH6rrd7a4Wonupw?=
 =?us-ascii?Q?EyRSAbfBAUaOqx3AdQpXmU+DRc/SLMWCROE+FU+cUfSYedtB42F2mPvqnkPU?=
 =?us-ascii?Q?KngtU4+UCz9n1/JBzsSZURyxuB2Qi6Zy+Os2WXtgrZAd3jTMqUe9hM1b5Xo0?=
 =?us-ascii?Q?AWD4UOefosuplFdXPWwqogC3VME2Y6ryIpcXn+up70NrmSq/+I+8BFRbYglX?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: /fuy1xjv0KizJcWOwWWZKio21Tm0OWKUGQGYM/8rp0e4X0CVVy6xxnGAExzuV5Ox/u6T7W2CH8b1B5DZEvckCAv1Z1Po/ilmVBuPE1MfJRSlPf7zSMXffjjCj3/71x6yNrHYNSiy2z7KkZRtpdxAmQm4BiJVkkQWNBFOqM00ckNQT2aGdFK1C7Z4lyPANgMxt3xoPbN57diSw7VpggC0Nj5GqhEK+FpdoIDbC4u6nbCs19dpH+IK4frIxymx6vNFhK0oKmAy9Kd05gpzY2UzpZiYn5+nuE/EKZKAr+uIp2bSfYM3n9+/ZZL7sWzqpn+uC/1sjitMN8gTzQ9ipYgwFAPHxIlZfuKGiCwd37mxbjs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4332;6:ldRuO3opcFvbG4gguWdYEfcII4ioht9Jq4+Bt0NfCSGBikgqa22rwhueSkRb6jXQjM2SkHd18v5uFuTCqJE+AgYpiRwGDYRcT9W6B4skznIt/SKyUWC0joGdRWZHilqr6QnyrbRyqMjAR+LEXs/ZMfocn0LnJ2OQeL6mCxiLiwCnoeYyj4S1Jr+lF1WiAaToSpbG8FfOmNnVBhSVPmGaWqXlUIdLKJqmrnkvS/U8buuvywlpypaRhLrosJaLNRSau70JdDksbRONCzPHcNws3APTtbe7/LpoLnq/LdwAnbhPdZt6kYCt9v5jnWKfKUzvvHIUUv45A8HcqdNlKaPSacNVDUtmma+Cr2jfxjyA71E7Ncs7zb4SvnN5P6SGUdEPqKoXVkm6+7YWVgp9fwKBhuHn478RGmVnqCdxv/TIP6HyYN3lp9HENL4Padlf1Umd7LOVbCub0BiCZUhsK1fKgQ==;5:1sqAvkAhnYfJ5v1apPS8BF1oQ4YpqHoYEnpQfpTlHlBgs2/ktnmZAhcQpjGzONI7xcz6Qq7HhjOTbC+aGnGBRZdM+yjI9trZoZmlqRLZmcMfVNwm1TCfvQi2oQkPXtxPdleJ+QBL5pCxPHxZwcyanLNCKtyoRLrxujHM/d6zYFY=;7:f9RyK35JKVZOsu7cmScJStlBTe6BxR+0PzA1lrDxkMco4LpPC29tj17zbwET/LyzsMFpBb2dZJI+aSWg2fR31gB/Oblo9ltnzHHGRUqDU1A4gIptr13dRvPRVJNsg+gi7Uz2F7UJX/LnadCerbKbTaPwOQi7HXaLmHKhCRkWu6VOVf5ty6cNOyGEAdbcTwIDW/xC4M8pdjTVeXICN0fo3YoY3E6jwAdBAqq4hMGQRPoIs1FWoPoC0Kdxm3xdgshw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:52.5165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82c6346-76fc-439b-9dcf-08d5f96a1370
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to set/get IOCTL using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index fcbdd6e..fc11db9 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -32,6 +32,7 @@ static char debugfs_buf[PAGE_SIZE];
 #define PM_API(id)		 {id, #id, strlen(#id)}
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_IOCTL),
 };
 
 /**
@@ -95,6 +96,15 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
+	case PM_IOCTL:
+		ret = eemi_ops->ioctl(pm_api_arg[0], pm_api_arg[1],
+				      pm_api_arg[2], pm_api_arg[3],
+				      &pm_api_ret[0]);
+		if (!ret && (pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA))
+			sprintf(debugfs_buf, "IOCTL return value: %u\n",
+				pm_api_ret[1]);
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4

