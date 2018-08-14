Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF0FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D72621711
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="uyH+pN2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D72621711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeHNORb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:17:31 -0400
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:34832
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731978AbeHNORa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsHJul4FmphMfPNH8og5mdAFBE9qqnR29du/LK5gudU=;
 b=uyH+pN2/OtOz5FYdJ2A41G/psR//Jcu7LB4G3aEEKNEkmdkEMOqsyo71K0Dvg41uSv0Lgh3A/0+faAJHjt1KkeueqaJley0IzYoLlBtLOfB5fSnNmzNgBQro2zHHLMV7sCxiEF9c8l+QV9tR0DbDgdUBR3s3dMBM1pUFwYdUOjI=
Received: from CY4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:903:33::22)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Tue, 14 Aug
 2018 11:28:03 +0000
Received: from BN1BFFO11FD020.protection.gbl (2a01:111:f400:7c10::1:196) by
 CY4PR03CA0012.outlook.office365.com (2603:10b6:903:33::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.21 via Frontend Transport; Tue, 14 Aug 2018 11:28:02 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD020.mail.protection.outlook.com (10.58.144.83) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Tue, 14 Aug 2018 11:28:02 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w7EBS2Ft016470
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 14 Aug 2018 04:28:02 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.301.0; Tue, 14 Aug 2018
 07:28:02 -0400
Received: from localhost.localdomain ([10.44.3.40])     by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id w7EBS0AB019679;  Tue, 14 Aug 2018 07:28:00 -0400
From:   <michael.hennerich@analog.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 7/7] drivers: mfd: adp5520: Update MODULE AUTHOR email address
Date:   Tue, 14 Aug 2018 13:31:59 +0200
Message-ID: <1534246319-1113-1-git-send-email-michael.hennerich@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(2906002)(246002)(14444005)(2351001)(106466001)(107886003)(8676002)(478600001)(356003)(305945005)(47776003)(7636002)(36756003)(86362001)(86152003)(50466002)(426003)(5660300001)(336012)(77096007)(186003)(486006)(6916009)(8936002)(26005)(50226002)(316002)(217873002)(106002)(54906003)(16586007)(51416003)(49486002)(72206003)(4326008)(126002)(2876002)(476003)(2616005)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD020;1:FdOKN12+mMvNJ8lV/oDWX8fDL+JPv8duSiDrV3Ug8eR9zdsRhJuPJyboe5gbxlezb7JvE659yHRvEMpGW8HEvP5btrAjf3Imltbdoa08T1nx6DQJRs1xM7JO3bBM5hYP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f54a49b5-07c9-45af-85f4-08d601d8ff47
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;3:eFGcXKY5XkaiH2G5TP2aVhkmmQ/QucXUkyRC9/CNOE0PUtobaQi+qD320NNXzzDzagudcA09ioridXrxK/i5jfAI9Ku4jMbIkysglsuz0XEPToHWZ0gyysTRmKOpuSbVwag/a8UYMMPc9No2Td7uS6AN6XRawElu8HGRhtmnRFQe7pT4o5lnmnXgbjovzmIGswBxF+A2mQVn6SGnEkyHEZ8jfV0dQ5Lt2rOOdM/02Z2cXzYMajJLqSllzLwhOWnzSNzvhW2NVC1BKLscUVz/3e4KiNMc5atBvb+mRl7LEl8EEBU9xia4i/a4xwk1F9QB52H7+9GjC5BPhAxJMCt4qhK5Q25QnJFVhSV1AP91orU=;25:eDIqu0z5abj5Vk/TLPTMcAjEdNOQlCUoTK9sLxtptn2MRFJIXAYZYK03luPNmK4XUiXEkR+AmC3oAM0Z+ziAwfM+p68e0hmqgY9U7KsT7NFyn25yfV/sYp5nf2yfsNyywjKxEmrVCNBry5/GNi2cWOnVdS8W9hmHOOih1XtEgZmdeGs+dF5Gd0IUyt9ZJ/nIvLDIHfzQiI1MqfT/BCF42oKMbmkM66zAIjiU/dDhk83Upf2WEvKIbIrhmuuizwn4R7JmWMaNTZzs8xOMe7zqobm8YEH80ytafrWK3e3JMchCnx1E1m/6R/93TZlwvgk0P9b1OEFuHPEY/gL12+dR78zRo9ipkJTTC4JVXMsvC8E=
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;31:YjwFjhuG3QX28mECsBV3N4PFcPk3EWhN+xcvxEki7dDBxDd4D/K+gR/zXDj35LNpUlYeAGFkKu7mZMSxfSevQBPoLgqc30k3uzYM+jvg+EtIeUVn+itjMpeHIJpINcILbyx0IXC+/Mw8bthJRnOI7Pmj/ac+0VzxC5m2pPtEw1Kz4+waAH8pNV+cZgkvOXRhFQcRwcRBUkc1j/1A9NvXndq8+I1fpE4dVduYRJkX4/Y=;20:9QCAZrwSwmIilmJriPTqyIiUayqVSW4mR6XhiG0B4kn6Qy92y1s1uYx1+LUKWhIp2UrAMlVox0Y3VCbJLD4NpBIhJCneVk5z1P9ry+/FoGnMOcn0Xio9Gox3Vep2FfzwSyusPcGQVRfYnX/IWxRCAmX4kcI4789ozWWoavZMFFPDdIvslY2lXUCshq5vjtcZMfVr9AQkGg4cp0Az8eKwjKMUKRL67oKjtiwVKJUDVH0yaTiUT5/moLBEGlVGGAryzMLpCudVD3pmcdhjSoWYSlmQxsWRlAdaHdc3ce8i4HPs0vIYxcvwPQaRn5o8XH7iXhUBtyYD3rtNhx3OtNqnPasPJcGeIZ6+f5yeB6l/rBbcTAXus5zKc6i3neW1lZ/TCjhdAizuHjHwLaWKoxiN3Ds4b8Zf4EsksC9VdwRalItRnr2yewypuh8mb1yWNoYMFNsjQpw8a1vfbffZzPjAogioS175KZWafy5ptS7kImG4KY+yqidEvR35itIA1Hbu
X-Microsoft-Antispam-PRVS: <BL2PR03MB545CF5E82FCBB877863F4088E380@BL2PR03MB545.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL2PR03MB545;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;4:HJ4TD0I2pWsfDyTfU+TM2M+oD2pi1XHx9WBXPtOgXzV5IEeim5r9Q1N5qAynzGgCMWYiLHENZleSFOl6fI/ji8vBls9tdBzApAh27aAQwGWwg2QGFgGnKV8AvzmReq0EDEhXZuuhXfqMC8xLwAxEX9PEOfbSat8qzzbdbxSHhpj0+ydKzURi53O6SJAHhpXeyyv6ab/CKSog9Dq1w+v/RkjPKJ1pqx3k9EeYftioD3a+rpwtSjP90AGJVYwj3shXpA+5lX5+ea+TJ1uctM0h/Hnn5Z9+UEs0nvp+AX5OQdU8FnYzVuGTMazHoBmoHuN+
X-Forefront-PRVS: 0764C4A8CD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB545;23:WWbFcKNllg5aWpTuXTxi/R9sdhh9Bt6K4NDr/QpxXL?=
 =?us-ascii?Q?P4QpHQgrqrNQ4FQctKk8EmWsY5CB7QAy7M5fEqJLNS+hXzO+jiZfoJR6VEgq?=
 =?us-ascii?Q?A0vaKd0eW+eBOOwNZtmge6H4YOk2VL7cerb/7BEXT+TJ64eYkagPqEED4n5q?=
 =?us-ascii?Q?G3TjN2u5FKHbT1Y760NnfFKn7q3wmDkbNlOEBpHscJwSwQsP2NDgb5YDEuNS?=
 =?us-ascii?Q?BuE7ZuAETCcdLYmAPz5A31pqMh21vaG++23Op8KPoe3ac383UcYgKnzY66Sh?=
 =?us-ascii?Q?a3Qp/yHiWnjMag0NNzG/ncq2y0AdbjepF4em8KdwNC4/qX40Np6EE8whGwGn?=
 =?us-ascii?Q?lnZsPKsmnatyG/vd8OxOWeEIwjNBzrq3qyA5zA1cDsh2MWC+5U8+frGYSO3a?=
 =?us-ascii?Q?AOZsRaXqt3UGqDlvErSO17KGImJ2yNbGXZGwAxdRh8wWoVVlhaAcIMG3O1zi?=
 =?us-ascii?Q?rZRi2mY6mbK0u9sj0Keb6EXWH2c/tYd8y3eUacFYvY6/xtbcxWtU5uJKWI3j?=
 =?us-ascii?Q?Y8fbxDziyn9ILskJCXmYK6LNXvgxKZ6dbkm9hL+bea2rg0+YKtlTveMGkcam?=
 =?us-ascii?Q?5tlsKjK7mtGB6DAdh1cuIrKMxrv2Wl3GPWZ/oDLTF4wsLrN4uTAjI9URkyjZ?=
 =?us-ascii?Q?WmMjJkJBzTzN/MNMyF9qkS+sMnDogrMYZgifxXO/CeVm1O+5JEnOttISGyuH?=
 =?us-ascii?Q?mjB/FCHRtnjhGdFtcIeffR3HcDctWZYYgWQqiuzkWOvsFT4F9uFo9HiiO5KU?=
 =?us-ascii?Q?EyAM5I8Wq0U2+esuyRs4i2aTNngsAgGCIrNKrsYUc+CQOwWQvg3c1ewkAwyA?=
 =?us-ascii?Q?5CWgykG8mF3mOTk+RK4ReWq2vEgGUz+GLN96DTfaKWjv8qjaVwis6s14hALB?=
 =?us-ascii?Q?6fW20qGjfEJEmXBUAuS0Qo/hlBiYvsV7ECvv94dMN8yHnbyQMTV+dxEnV9Q9?=
 =?us-ascii?Q?bF+FgM24395QANIhVyeOhsWxb2VhS0DgAQF3fSLGqJDU0YNes/GgmNsb+CJ2?=
 =?us-ascii?Q?9wQAUWzmujOYcnowGP+CXEbyDjXyiD/PukCnGU4Nr/uPfbEUPFWv/t1ecUn6?=
 =?us-ascii?Q?EUkedw8gAp+idPvRgwD18XVAIJ?=
X-Microsoft-Antispam-Message-Info: 1GHtC0DFmha9qsvRWvuNbAkSjwI9hIEoenp+SiarXOj+f6phuJoXTaQGWgbJ6MDrDlNeRKBbEDN0e/uvz5m21NP2/JZ6O5frbEXNdNz6FX9Pz7FlEBCpbZmUeeXGtZspU4Y/X0QMfkLbVc3twA+tfm+341rDrxnQ9ZM4318u9KpVoQsbsJ/1SktLR7w26iQbTo1heiq9qk61Lq7sqXq9NsI8/mUwMkKXDmMXOXLX+Zp7Gpd96ozgDOnfCA5lyTFJrqqbG0SRgljGKE1B9j4EdZZbrZA2GFPau3HqPS/QKA0/635n3irZLcbCO5LcrR/NQ02LlnhRmSGmhORVWJPW9NPByxazjAAi5re1RV98V9E=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;6:4daqGXp8uCvmAjMdnO/U/13onyBLpoMS00YkIythp6SFehHjWmbEHzwnMkBDFQUtsmF6VjoRNr86JjlKzMpPNZQ6VbY4UPtRVNl6rvIJ5T6+NkoUgv153UT+qm3TuDniYpIxSdyaSYADQD1i1mS4UPbpKMgB9xqbmw0l0P+Py48GWgBe94G+PDpz0KdEFboTHKWqe/jOnO9V6GutwvY3dsUwxdwnj2r9bQWpt7kjxbK4yYuKURbkqoxZ8B+AdCa9LI6zq4wvrI/FjfbatkNANMx315uEnsrdvFmBN//a+aC2MSwBHizMzmpqYXJBacFJw64iTfJibQigjq6WiGtvDnTw6KwKwul6muOUHEKGHoahb7Co7cumLszT8Tiyu5XdNhKaXrUyScPHVmxt5TaKuXSJVyq6VZYADixKr15WNdWvxfxbPNrDFZ0bdVvPYM5d1DwaohDxUJ3RGcTp8zkHUQ==;5:VwIWc6nt1uiFyy0LyyINMa0AVV5Z5mpwjAWYysWfb3b+JEXvt6J1ce3nskbThijeOko/eR+cW6/d8Ma78DzeMHOsisMb40VwfnX2kW7nNUg3VpM3c2M/+FzeNQXnCCHg+TdqzGx66dUWi8BIG4CfBWpT/GcdFBx40pFe2UYqfzQ=;7:hIFfqXe/sfRL+dQBjCyn0TEFnRK/akQ4qgqk8tpurhIM7pdVw8OG1u7B/DT52/xNeIjsj36fJqgGNcuu+Lkgkh+OgXCi8RhRUptkMlKCKMTHUsqtO6XPNsDAPixG5VjJ3xm2w0UP6ngkPacmYE73BIrIhMjZiT6rBpsLqmqJr/MkXwifwAhMXeCTmLr9/wB00txYAFVk15qaair+WMd8jGmUN5QfvK+wWXTPK83iv6hWE19Dk7IM2xM/NlKuZJgj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 11:28:02.5695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f54a49b5-07c9-45af-85f4-08d601d8ff47
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

no functional changes

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/mfd/adp5520.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index d817f20..be0497b 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -360,6 +360,6 @@ static struct i2c_driver adp5520_driver = {
 
 module_i2c_driver(adp5520_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADP5520(01) PMIC-MFD Driver");
 MODULE_LICENSE("GPL");
-- 
2.7.4

