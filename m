Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DBDDDC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E66208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hFjM1++f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E66208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964935AbeFNS3p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:29:45 -0400
Received: from mail-eopbgr690046.outbound.protection.outlook.com ([40.107.69.46]:7168
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755323AbeFNS2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XedcTPD808pHUpIO3MrfgUDaIqwgzyn7xAyBqGwkJNY=;
 b=hFjM1++fTYL4rQLQj36bLWtDOm9D//JvJK+AonGmMTvYeQtAT3wip33sssoYXIOXpSbcvyTqOxtnryGXszIdi7OJtiyPG3h0bF87qc2pEufPWrWzDxSZtxhyqAxsJ9T6JkKFxU0I42cnAvOmciGTHtYyhYzYQAl/bfM6aaDpyM0=
Received: from BY2PR02CA0010.namprd02.prod.outlook.com
 (2a01:111:e400:5261::20) by SN6PR02MB4957.namprd02.prod.outlook.com
 (2603:10b6:805:99::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Thu, 14 Jun
 2018 18:28:12 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BY2PR02CA0010.outlook.office365.com
 (2a01:111:e400:5261::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyh-000216-03; Thu, 14 Jun 2018 11:28:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-T4; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRtSZ022833;
        Thu, 14 Jun 2018 11:27:56 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyR-0006F7-Rt; Thu, 14 Jun 2018 11:27:55 -0700
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
Subject: [PATCH v8 05/10] firmware: xilinx: Add clock APIs
Date:   Thu, 14 Jun 2018 11:27:37 -0700
Message-ID: <1529000862-11510-6-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(346002)(376002)(2980300002)(438002)(199004)(189003)(26005)(51416003)(47776003)(77096007)(76176011)(59450400001)(63266004)(39060400002)(4326008)(7696005)(186003)(106466001)(2906002)(107886003)(5660300001)(486006)(478600001)(356003)(8936002)(426003)(106002)(2201001)(48376002)(50226002)(54906003)(72206003)(6666003)(81166006)(81156014)(2616005)(305945005)(336012)(476003)(36756003)(11346002)(9786002)(110136005)(316002)(50466002)(44832011)(36386004)(446003)(16586007)(7416002)(126002)(8676002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4957;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT052;1:JNugxTWlZjE6irKe01l77m/PdLEW61C2MBHm/QV0W6W0UXa9m0dhaTnDZRwf5evQxF9kM1yMCDr2X3fwZOsMKgM/ZeBVolPohf0Md3rGE5qCRNfzpJsh/jma7RYr1eY+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eeddad4-494e-4a8d-1e65-08d5d224960c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN6PR02MB4957;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;3:zr9iiCCXZFp23Ay5EqfTkNUTetxcs18F+JlKNW5Abhx0UG2FIPhKjnEKmBasmZae2n89fgU9eGcJqUspjCOPnbMarnCLgsVIMg81KPWbhMcAzzCC8t3Au6pJHh2HJxFK5ai2kPZPuFZ6M2sliS7z0K9CORjjVPdaSzl6zHdJAke7gmWyAz95siz97EBud37Dul8ZG/gOomUGK8+oYZjJ09GpBW1sGNCKYQd4IHj+t/7Lqyu6u1MhnUXgVlnJ060mrO2biH7Qp0X941GxXEbxf6DMBiclmIQxHcZVYK0dvcc3YDRSoj26b+QANVqHvY1nCAVEY6Y7qdkUyqp3LqqZjWUo6AG91FcEAIkZU87+NfM=;25:yxpNptfgvl3cPBhP3oRutXtHv3x2r0HgMOuht5LUD9Lpw5BxSvLCNgP6ErjjYtGq/BDH/J51YY6I35+jCrIhQZtwgKlkOyrzUI+6pf+t12wxsdVpyBHCaTdU6R02R8E7npoC64hmCE0f+iD2OJs/Ac5XJfemLdGhWv+Fc8iTq32eKRbE/Al8aYkIjEwMl10JUqnNGWzdQl6HVIie1CFZMdP/hRlJ4wslNZtg4pO2EYyro6J5wO7k3ZzdzRQfZ8JXqvz3lgoGWQU9bY4YZuIh8yYwXDHIcEe6+lIBo62sPuPDQceCyXErt+MqukG+io3gsltZc5XN/8yRGzj1DddIVA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4957:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;31:netd4s0g8OOx3+u332QopNc2ADM3x5s8JSIwOj1+pSgOWzWdvalk6BMtSDH2eJK0HlwM2iyelQzrSogbb8lTULuqyALeAOapIt55+DUhnEqg6RXLsCeC0W/OIcmyM9M+IRGU0HixbavfsYIYlXXdMEVcj98sHzB29beqIuv+jIiaivtoOeEjDgYeEeV4KMMkFKkR1j5GuVb713GVeZ1/E04eZlpZT0Fh6EbeAqzeT2Y=;20:bVBOqOl6RIbWuHzEgYcB21t1UXclV6XmKPJUAs+SPVGDde9Mq3oDlul4ZShzlgrH/GMdkgix9f5wwXzeAyA+Swbsaa18PpRZ8KyiqDOKdhqne8LWa01GsrPnI0P7yguV8ykYzneLQaC9+0JxGue3L5KDzf8zbtMoR7xxX/2j6foKzBZg/GzTaK+OF4k80KTG6PPL9LXKTuwxfystgjN3FE4iOPeg4ytZAPVJD6CP6rVYPt8mMzQBzImDV4UHZ/PNk5Ix4+TQrJn2rUMHQ8oEiL1/OylSjoLs/PYrP0eTefCTPf8YwVure5P8hjistXv5939aZrbbFSkM9oDMCHetaHWf2vSa5rd3B0H+PXP+TzXD+eDh/X2Z1DXX43aOJ1sDucqLFBqE0/41xYOu3md/1ogG6En/3FXvQ+BHYZDIHdWsn4m5qIywZqFw49Gy1Ao6FEXpzJGh6zcB4yRaHw2G9saqq5BTpbfKppPDi/dFGnj+abhc51D7on9SAzUymo9d
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4957EA776F9571DC5F7A6856B87D0@SN6PR02MB4957.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4957;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4957;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;4:bQ4R0jeqp/YiIh8m/pnQ76WGMiPxOxQwdwSZTuCY5yhCL96NoTqTVk5DYNOA8Gx4RbBqIHjCjHyzw+34GkHnxkHAu6lniz3mPRi9kV3zZBsyLgIAfx811im5LSv2+0vBPCCts6CizY8Drr90CIg0QIW0c/A6Rq7BmLJLDUJUTB5feAjAdZLksjTzPqlhH1n8z5eN4nWQ8aGyA+cdtabBc4+h7hy9p3qKbCtnbf5ht0ficsS/sAZlz9pFWjF5Depdw7/css83pojZazGE7OuhHkEfbZDRr+Un1n7TmAA+2LBxzXybVZSKU2ii4d4BmeTP
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4957;23:APqKb2aWiXyq8nJkVrEfeUaMcdAhv+wGl29HZWCsa?=
 =?us-ascii?Q?cJvFcpR/Fx9HGHyIS5sZjK8SJgrEIw/I+5fVtEArC+AzCuP9+tfPwl/j9sVQ?=
 =?us-ascii?Q?ZTJYIeDxDPN51EDyYQpwVPCEUHNPKVPzSDCMMwW0bgc/UAINAIf9ou57dCAK?=
 =?us-ascii?Q?I6USp7+yAxNO120J/JBPvBZN0Itw+0TqD2FI1QN/1Z+eUk5ICbwyV3fYlpVH?=
 =?us-ascii?Q?15im+oCpOubyYBIj2xIh/DhE4l8gFrOxA5DXVLZikLkq3LHB/E8c9iCANkee?=
 =?us-ascii?Q?xTqUmNE6cmDIT06ZT9Fdk4EhHDBDJ0gr1wHaSn95VfXARvZeBRhF+pL0Bg2o?=
 =?us-ascii?Q?Slca+ranlBKEchtq2fZQxxVsBhQ6+ugRonfME+Q/+bLG0wIFqysF+1xqV5zx?=
 =?us-ascii?Q?r5dXbqvSb0PGZ4/QIU0Ldz6TVKhOktsHmv/ZIvAycfFlk2QAg0dMcnZ3cTAP?=
 =?us-ascii?Q?cztSaVEMHfCoCFvECCTdz2EoLhPNKyw11J6xWFsFqiZh2U53Q9UKf3R+AqG/?=
 =?us-ascii?Q?QxN30hiMkgD00rZHWkaQYxKtOXjW5e0umPpz5eho99UDwulcsccwcgZlxsgo?=
 =?us-ascii?Q?520rMxK59sJlLWXJoLR+Ch88krz0tlGfScsXroZua5+5nrsPoW0NqklOelXi?=
 =?us-ascii?Q?cqN98z0ttMvQaY/9zMtGpmd4dvTR/5mAV4S7BlVZVj+YGoOJOX3kpOBsnrKc?=
 =?us-ascii?Q?TmlmQBQC+jwVvzQjXQ5HW0tEj986aFnOOpaG9xkZ4GnmQxOMp1AB92r/lSl+?=
 =?us-ascii?Q?1JnVERFTJkx19Hv0bA5gsA4vXltIwzsWw9UEHmcLfbnLOtcqbet+fZDYkoI7?=
 =?us-ascii?Q?jRTuULbfB/Ydg10c7/TyFnrySvUdZpHGeLGRLelCys5DVpkv2A0hQ/q6eFpe?=
 =?us-ascii?Q?d6b70fSrHUbd3X9R1BrXhwvN4ZAA3PDanSQft6jkxsXiKhSqjpUEd55ZfR81?=
 =?us-ascii?Q?PEGVZ2Cvb5B5Av+RDNhkqFnAzYNFIuf9QGKzr5G2KW7A4zfZMq0mDGUxcm2z?=
 =?us-ascii?Q?vCeMOpXdctz+DSUq2q1uRfJjXbQzGRx4tMb3qQV6rcP5/dE3xrRf1b3RYmxO?=
 =?us-ascii?Q?Duv8YEeBeFM0BZsYFqOj08iSiGOtWpjazIqDnTCaw+06btvR0ebmkXwB8scT?=
 =?us-ascii?Q?AOxjiJ/RHU2qbS9OQL9R22kl748fu8lYcH5s867XTQsaHAsF95prVczMggCI?=
 =?us-ascii?Q?O2wgodNlGAzKdVlcIIRCBFbIPO+q/ypj3PofdI5EGP8ur1FL9mT2yXfJLrq0?=
 =?us-ascii?Q?6itBar7wXMnVbYzK+FJ0vsqA/wbaljpaNV11wzl9pA+5nOwr+t/605Z0gEMw?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: XqKBlA2gZnJo0/gYFZLkZGPEJGT1dHtYoqveoCdPFYihJGDe9S/wzLyveyedDq/3gqn7/OnslibJj9FlrE7u/98GfXhhkxfyrQcbNRBywk35RO6nd5OeOKWIWRgCWjTsYU08AzqcIbrQ+6CPEimq9wwQSNcZ2o085EdgwTIq8b2jGssZCSklZI/2EJX5nJ8C
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;6:iqH3R8QfKmcVjASqkDZ126EkST6f59erygyxFg+SJ8bCT1uLiumE0i2swJNkODPMnlhEtKjLAY8XIFSEliD1u+F3VuPY+C80T4gdp0Q0e2uHAPl96OF1WBmEsLIcS4ctTqD0eYIN+7gdsdIaAQNrDglRfLdH4XvkvyUvdIp8Xf2c8M8c01aSQcOk70VriQymDQxd8UEIrzq6R4NdadAxMdeEIKAgbl10NGz1r8+pJUw2oeklkjkMCUHEgM0db09/9oVA5B6G+AFLLeSjC815NUXL7SVSl0nDNzh30aZNQWBNDmGz38XXIA2hIqHMuVV2K+MjmfsE3Rkk1pJZOo1zuyrwbiU2t5+EH3oPQX8PxF5I/hdHGHeNJ0S0i5rwCFbowrZkkV8U0RNjlZcp4HVmH97yGZpiYFJztaU7qgLPtzRRKgp5vAwzIh7R0Qe+jRVCTZ/wvjOGayzWRBSrWV7HgA==;5:R8TmBCgg+58Q1DLIq6AGUjydjo7FPM8tENbeEn+kX/kO3q3Huy04JiHiJXZIbuYitZBNmVUq2D/ekYEIwuIzHH83rmnWlNB+WuUmADzBkzXkN4lJTgF4z8BJYf8a2e8WZAzSL10PIJSObKSygpkwanauwT+l2fbX4ba10Mli0Ys=;24:loJjl95q7RBA2yMLB+5GsMC7uC0M0TTXfFAyy/tjuK087DxOdR2orcWitVoHvN5WgQZdgDPpFPobUql2hFfPeUTbupOzGjHCZ2KgddbnMNk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4957;7:5WEgUmXiMaxk4cDECC16CkoKuTJJCgvJraV84S9MVMoprHhNA2dYkdek2M/3XFsS0HsORHlolD0cYK3lnNce9j1Ac7+/KLgPpMSJc7t4oMe8+QcWgMn6fAUEZysIhoJ5/FxAGe/mTkxod2khoy6z7p4hvjA1MxW32EdpAm02gT4o4h6cGWvq5eMhBpMd1bE3qmLPgVrgURg39le5zUHsCtsBl8uM3xc6KfFZ+fo8/kGkRoH+pWdzqXAjmQRkymQI
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:11.4262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eeddad4-494e-4a8d-1e65-08d5d224960c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add clock APIs to control clocks through firmware
interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 186 ++++++++++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h |  30 ++++++
 2 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 86d9bb8..c764d6e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -269,14 +269,196 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
  */
 static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
-	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
-				   qdata.arg2, qdata.arg3, out);
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				  qdata.arg2, qdata.arg3, out);
+
+	/*
+	 * For clock name query, all bytes in SMC response are clock name
+	 * characters and return code is always success. For invalid clocks,
+	 * clock name bytes would be 0s.
+	 */
+	return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
+}
+
+/**
+ * zynqmp_pm_clock_enable() - Enable the clock for given id
+ * @clock_id:	ID of the clock to be enabled
+ *
+ * This function is used by master to enable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_enable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_disable() - Disable the clock for given id
+ * @clock_id:	ID of the clock to be disable
+ *
+ * This function is used by master to disable the clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_disable(u32 clock_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getstate() - Get the clock state for given id
+ * @clock_id:	ID of the clock to be queried
+ * @state:	1/0 (Enabled/Disabled)
+ *
+ * This function is used by master to get the state of clock
+ * including peripherals and PLL clocks.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*state = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setdivider() - Set the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to set divider for any clock
+ * to achieve desired rate.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getdivider() - Get the clock divider for given id
+ * @clock_id:	ID of the clock
+ * @divider:	divider value
+ *
+ * This function is used by master to get divider values
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
+				  0, 0, ret_payload);
+	*divider = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setrate() - Set the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to set rate for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
+				   rate & 0xFFFFFFFF,
+				   (rate >> 32) & 0xFFFFFFFF,
+				   0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getrate() - Get the clock rate for given id
+ * @clock_id:	ID of the clock
+ * @rate:	rate value in hz
+ *
+ * This function is used by master to get rate
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
+				  0, 0, ret_payload);
+	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_clock_setparent() - Set the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to set parent for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+{
+	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
+				   parent_id, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_clock_getparent() - Get the clock parent for given id
+ * @clock_id:	ID of the clock
+ * @parent_id:	parent id
+ *
+ * This function is used by master to get parent index
+ * for any clock.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
+				  0, 0, ret_payload);
+	*parent_id = ret_payload[1];
+
+	return ret;
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
 	.query_data = zynqmp_pm_query_data,
+	.clock_enable = zynqmp_pm_clock_enable,
+	.clock_disable = zynqmp_pm_clock_disable,
+	.clock_getstate = zynqmp_pm_clock_getstate,
+	.clock_setdivider = zynqmp_pm_clock_setdivider,
+	.clock_getdivider = zynqmp_pm_clock_getdivider,
+	.clock_setrate = zynqmp_pm_clock_setrate,
+	.clock_getrate = zynqmp_pm_clock_getrate,
+	.clock_setparent = zynqmp_pm_clock_setparent,
+	.clock_getparent = zynqmp_pm_clock_getparent,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 354385d..29fb352 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -36,6 +36,15 @@ enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
+	PM_CLOCK_ENABLE,
+	PM_CLOCK_DISABLE,
+	PM_CLOCK_GETSTATE,
+	PM_CLOCK_SETDIVIDER,
+	PM_CLOCK_GETDIVIDER,
+	PM_CLOCK_SETRATE,
+	PM_CLOCK_GETRATE,
+	PM_CLOCK_SETPARENT,
+	PM_CLOCK_GETPARENT,
 };
 
 /* PMU-FW return status codes */
@@ -49,8 +58,20 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_ioctl_id {
+	IOCTL_SET_PLL_FRAC_MODE = 8,
+	IOCTL_GET_PLL_FRAC_MODE,
+	IOCTL_SET_PLL_FRAC_DATA,
+	IOCTL_GET_PLL_FRAC_DATA,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID,
+	PM_QID_CLOCK_GET_NAME,
+	PM_QID_CLOCK_GET_TOPOLOGY,
+	PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
+	PM_QID_CLOCK_GET_PARENTS,
+	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
 /**
@@ -71,6 +92,15 @@ struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
+	int (*clock_enable)(u32 clock_id);
+	int (*clock_disable)(u32 clock_id);
+	int (*clock_getstate)(u32 clock_id, u32 *state);
+	int (*clock_setdivider)(u32 clock_id, u32 divider);
+	int (*clock_getdivider)(u32 clock_id, u32 *divider);
+	int (*clock_setrate)(u32 clock_id, u64 rate);
+	int (*clock_getrate)(u32 clock_id, u64 *rate);
+	int (*clock_setparent)(u32 clock_id, u32 parent_id);
+	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

