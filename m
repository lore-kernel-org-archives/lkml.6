Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F777C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E733A218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OnenwN0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfAXNlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:41:45 -0500
Received: from mail-eopbgr820041.outbound.protection.outlook.com ([40.107.82.41]:27039
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfAXNlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqSy0gTSbPVSTkKe6HvUJnZMLyK2ESXIhL57sTTsDgI=;
 b=OnenwN0z2401uGmoBSGPBblZwat7mfV4WdcgIzeuW+RJf0+MROUGi6Vz8BDBRUVsWdYfWMAQwqLO3rM8R7LeGKCwRlUE/IvUgsktw9h/CSSa9T0kr4ov3KhZx88t1K7+RW9p4y3gHNqcGbGBtz+q2bQ7gQueEeNOFICH8M7i8ag=
Received: from CY4PR02CA0035.namprd02.prod.outlook.com (2603:10b6:903:117::21)
 by BL0PR02MB4323.namprd02.prod.outlook.com (2603:10b6:208:40::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.29; Thu, 24 Jan
 2019 13:38:49 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR02CA0035.outlook.office365.com
 (2603:10b6:903:117::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.18 via Frontend
 Transport; Thu, 24 Jan 2019 13:38:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Thu, 24 Jan 2019 13:38:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gmfDT-0000Bb-Ie; Thu, 24 Jan 2019 05:38:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gmfDO-0005qk-EW; Thu, 24 Jan 2019 05:38:42 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0ODcb4U007304;
        Thu, 24 Jan 2019 05:38:37 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gmfDJ-0005qW-5H; Thu, 24 Jan 2019 05:38:37 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>, <brandon.streiff@ni.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH] net: macb: Apply RXUBR workaround only to versions with errata
Date:   Thu, 24 Jan 2019 19:08:31 +0530
Message-ID: <1548337111-31184-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39850400004)(136003)(396003)(346002)(376002)(2980300002)(199004)(189003)(336012)(7696005)(50226002)(186003)(316002)(50466002)(486006)(6666004)(356004)(110136005)(47776003)(16586007)(51416003)(44832011)(2201001)(9786002)(107886003)(48376002)(36756003)(39060400002)(54906003)(478600001)(14444005)(305945005)(36386004)(106466001)(2906002)(2616005)(426003)(26005)(81156014)(81166006)(126002)(8936002)(77096007)(8676002)(106002)(4326008)(63266004)(476003)(107986001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4323;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT021;1:bW8ieCdKmSmgTIuugKoLOuRsD4qp8X4ar6GQId7qConU4mP734nxyvzPDGhkosnhqKyU5I/V4RNr+4l3nfbdOgwnQPLV2orq2RhKjzoUHmyLjsX47pd+7mpJZnMGXomJwlOsqGDORaZC7CQuDNloXnN+t1G3YwPovXhPI0FrrQ0=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8093bf69-6b1e-4daf-6641-08d682014520
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BL0PR02MB4323;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;3:/TcBSUczaLsADUPMkF5bcXyNbWnhTF+zgTeH7nfmMATWeflJ3ichH+ZrER/8HrpMpFqh+pnqTM+hqykUv96ovN+fqxS6cSJqvbfqAUnGG1xwFuod2bTcVdnV7EmKH308dHNLIwr11cLzAJMVSkbRkj1MTKygFNQn8nyFbSL9fEsUCieIPZILSPan0nUldT5Cxiq/Dl1/jOWQ0KeyHM6z63QlcbY+VTsY9perk83I4E8uEo+WO+k9UwePtPRIHANQGK6md8YsSSeBJeLGwWhiCyLntMqm3edAdb7jzWvoJESjh84fb1ejD/nSDR0uns3vTRrJKk3ou+XM5iuJpEYhQPJCe2KZ/SEf59WY9UIcC4Ha0xWZe5lm5WGIoYMafFRt;25:ReblPvRnmES74hkrwOpeBpNbSyuUP9ckS86B/qcd4gE4Xj2QVcluyQBElFpV+VbSKNAxZRvgA0Ikjt7xpf3KXSeeOmXSwna+bp5p7qxJebtXlxeeQ4+mwkqD45IYsKP60gNFlWSNyQq1V08JzbwOtnZUhsyVuDOngxjKbMPRp29mpOWbaMVyZK3244qd/jfUb1L5fEMoxAqQmr3j/XtK87tWeTDxAhnjoTSo6NNIgTZmZTo7IZIHVoNZsjampDnm2S4aBw4cD+aNDs/bLCDGUTSR7n16LIOiCgIuG1Mvm/AmJoLsMHsRDDua6PpfXzxRP5wdbKtg1iJtBGNimDX3nA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4323:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;31:ljKamC/rS9zsQQFeIKei16qAYLMAeQQ64Fh62JBZnISttZPVUpj5F/dcJK3/WbyTK3cQH7etWTzm8Byqoh16aqdXH82mnkmfd4tM3iIIj3hjWyLLwuwjf3XuK4gt9eEAHGUjU/UeOpLNQOPmvuRSzAYTEvZguO0Ha0EZuf1ttCbe0OaIQ4byrErYKIABZusUPOJy26RKg9BvGeX/BPzcEC6+ieXeR5SZEcwp6HXWVlw=;20:AfsR3O7e4d+EG/LmbHRSUsUYN5H/3AxK6oRMNmHSXdYl2oq1iQ6aJ0qjkyRGijLuMmSqh0tJ1XIswLRYQ6syXA6KgEgYVhjhRdXHinUq6e4PzLCi9CI+iNaXnozqCNZuaWilNp9xbuFScIh18gGB5CKexF5fXrrQGR4KXqpST++nbpMAIUJVyo/WXbLMz2oKktT6A3nqrmyC5xuSSeeKYwsUVuO2P8CX89S/YX7agF7IggVUS6wVRBbYbvqoTGfgrZ+Y12kS+wCe+1dkmGR+4DoqgQHJ2qlwpGVvNnXN1vWADokTTX3jkcOW8vMVFvw/0CFxPEWEjm7AqOwQbIIa6CenDuIDVplNUFc2fweOqs42gl2FBQsMzzZ6PYpC6H4k4WzFIQ8YOdNtaQHPxv4jU622wABQwGl1SHaxAo1OD3LFknaP4NuOU61dTpH+P5UdscYttuJx8XOX0lOXH8hsdb/22tMTgXsQeR2n6AlupwNBwruV0szBGveG1MmMskNT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB43232B0B69720FC57DF54676C99A0@BL0PR02MB4323.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;4:jCtMgENWoOLpUP1PxhpXjXD4q/H/Q+K7of+LSvg2CHkzWar6wEyp7vOp9UUeKNMewY2BLuWXyxc++G+hST5e3omFfTb6oFsDyAN7NW5tPUuRAJ7W8uqUNWPqB8AfowR90KBJHgFFk/DBeNiaGokDRyGPs2eDnimVIR1uqx/HDY1IwV9T+MZW8kdAcAEuv9yX9X3J+kcbYSC4xEoauGNlrgLdmNjbLekLsjrCTlIPwN5RkSoGx8rsuGrNoOaSzX7lxQJNmJFkHmH7gNPDZIf0i435D6vRJgps42roT7MeZqL5WMPbIzJqvvj8hGhbWvUo
X-Forefront-PRVS: 0927AA37C7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4323;23:HE/6SBIZFhIJcSas15puL+vFjTcwheVLbfNF6f/v3?=
 =?us-ascii?Q?v/PZpZIgsOYiH439VSEnfNn01F80HZS7TJGpomzGdxag6nxKDVmkGGjIMjN8?=
 =?us-ascii?Q?qgIZ60I6xdSaV3C4GfYkKfy9ve5wIolXyc16M5eL65Xq4pc7W8gP0NBBW7UC?=
 =?us-ascii?Q?uQPlybwHZKgFpUPUGUxrknP50NquKsCnlS+S7CcBWdekYwWX+vLtL3qsXNm9?=
 =?us-ascii?Q?mfaBsYRsJ5rF7Rc7gLE2UjI8XCz6FOXj/w4WqDvwYyj/ukJTNe8ol3PP2YxV?=
 =?us-ascii?Q?qGXklCQw6kb8U7f3h3h3nlluqof5gcqANcIGhLguNgUYKPplC6c6mBFKHEyr?=
 =?us-ascii?Q?vxORPa8g7J8fevAMyIOZA+MxotisDvFZFcvjRgL6ONcErZRSN1kA+X31V9CG?=
 =?us-ascii?Q?LbzgUJ0rURuiz+LmR8Xp3ZCd1Cg0GTpRSi+Q0Cj3odCwERDKKNJP6Apo+kcX?=
 =?us-ascii?Q?Oyw/XgDX9nEQj2UDxmaVAC1Fi/dLUCGAIZjdlH+7Hf+HOHWsIOS0NYyNwtVP?=
 =?us-ascii?Q?SQFSsCjbJKIUt+MAZ59lU6UPt1RgB99ksYtrdcUvePZEZhTDa6uo9mbzy1e3?=
 =?us-ascii?Q?34tYm0JwKN4BvmW848bZ9xFpc5xtsymX4gieJ9HQJ/yiNbzNWi2DxmzcJxcB?=
 =?us-ascii?Q?uuycEruVvD+Vx1l28Z058BVocWalw4bLfBYaDhOqBFatFADrfQ4zVpMlntAm?=
 =?us-ascii?Q?XBK9uDvKrN76+KRp1IVp9RA1/ogOzbUrtqaMW5y5J7mJxes0xYH1ra7mNvZI?=
 =?us-ascii?Q?+vsKw8USoVJpztklqDgz3ydsWLyJ6gTfbhi8v4Rs7+qdLqD83TvUNaqWEKa9?=
 =?us-ascii?Q?syxEiqCXqduK2MXUUPeafKJVXBvbagvqHf++ASoBU7EqOqQUZDiKJDLarfEa?=
 =?us-ascii?Q?P/+Nvj7naIweZhgrMFVdQd5sqAj+GnEZCdX/qm5UOn+gT5htk1zAAszhgEOn?=
 =?us-ascii?Q?FStTqc4ArfzgyCX5m4K2q1YqlKWOhL0APhxwkJihffIAWUmQBbJZecdRTqrV?=
 =?us-ascii?Q?0Te+nq0AGLwdbul8LRYNw1aA47F8voOx3aZz3cJcm1kpLmVD+7RdOSlaNBPw?=
 =?us-ascii?Q?SUfe9tHkxeF8llLRaMlrEmSzJh0H0ttuH0JWjSzC9xKeZVpbeaAt7ax42HxD?=
 =?us-ascii?Q?ympu4Ctfpg20YvOeLrpgRLEaXRlvOZbx38edC89F7SvtH672Kv/ngf3wOGVE?=
 =?us-ascii?Q?tuLYAUD3PF5NYk=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yw7DuuEpujv0PULDRhkZ7gfvqgwW3vdIIUOocm0V4Fuh+rdkapOSGE/CvQgcY7KR+NIiUO36K2Fj6kIBXqYXPfxjgtv81k/ZXzmX44i0gdczKrqD3RYFQd1PDNThS//lCUnE+ndH/uY2NT6aYTJQdgH6x838bibNRQMWTDyYNalF4pooPUGiX6XEU7qaYiNUjmN01qogd9c0+TMbYy8pQuInhRMo9AVqsf7slQ1BUi9ytRhMhKe+glbFx77ONVbO0Ksv/Clz/AMMaSVwub3IGekqlI4WHcwq5n5QhFzfVG3sFsDKUYzG0Ul5OE4V9TnRKNR7Vr6Wspm5k90tvJM8o80oYY33h8DBGvU8XXOdQOEddC4VKdJO0Ptc4uYGONLCBL6Cnr69EZoJPLytiBmiedW2hXt3xOo0zKr2o7Vs3Ws=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;6:PaI/biRXQj6n+r3wUW662oM72TLR3zRjGJhoIEsY7nnoqRKFhpAnjw2mio5CrnswYRDUZJe8v+GN0at6nNq9jvE3ZJlikqS8o/NpmAloNujiBgXYrZveb9BHxw/i18iSYb9GdEqMQDFHrbiAyGyxz14owPPOCOVD6tyIranO+OVnzFV35n/U+KJeV01Fi5wejEZzMpKwhfr4zyGHRjnqIDzTQnz3JT+I+gJRF1/ooVXhCmwq2n+mRzJOVYwz04PII4PGbmWd1t1fCV8pk49BHmKcC72gcFrltYk9lqVeBNytY0+Up6u3SYn2YeWjqWdCbggFvTTw1c0H6ezsg10K2ZcqHgQyy5/lpn85IP3ymO9QMmOTKkppi0EU0DMK8oMGFygD2glycpbuLW+YIwdeQToTcOsWilDZujctgugVif/NlTpYW2OHLwgjOuWoVpQUCHkkxdAZMz/pSker1TpLtw==;5:3PqHS1NSab8/qFUu6f+/Rr8GkjK3fXHtbWK2QqaNT88vNmXuAcOH4nATq+dNcA+9hr0guJlvf8iEwp9HDNvqNOeUJmN0Qw1VWcl50w9JfQ3nHSKzWsMf+h4OZzBZS0vyTSkYWsJ+w9oNMVOceTYdckXMYgQQPf3wZJDcKj0yLz2uPKbkza5Gr6Ze7wigeUOj7uuX019JG/j26hdCcO646w==;7:fmcHPgGJO5iHTuU6rmcpCVxecGS0QJIzwnVVhKV3PPFBRSI/H1ZvYrhjMUdsST3DkxDsIz5SBOgSqicRmIL32u/FJXZw4wt3HWPuYnSCLM/5u0BptQ7HOPvt4YvlGlQK+i9CF6N0rO7HZwb1sWEoHw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2019 13:38:48.3329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8093bf69-6b1e-4daf-6641-08d682014520
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt handler contains a workaround for RX hang applicable
to Zynq and AT91 only. Subsequent versions do not need this
workaround. This workaround unecessarily resets RX whenever RX used
bit read is observed, which can be often under heavy traffic. Hence
introduce an CAPS mask and a check to enable this workaround.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
Changes from RFC:
- Use CAPS mask instead introducing and errata field.
- Use check only on RX reset part; ISR should still be cleared.

 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 3d45f4c..2b412fa 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -643,6 +643,7 @@
 #define MACB_CAPS_JUMBO				0x00000020
 #define MACB_CAPS_GEM_HAS_PTP			0x00000040
 #define MACB_CAPS_BD_RD_PREFETCH		0x00000080
+#define MACB_CAPS_NEEDS_RSTONUBR		0x00000100
 #define MACB_CAPS_FIFO_MODE			0x10000000
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
 #define MACB_CAPS_SG_DISABLED			0x40000000
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 66cc792..0bda1cd 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1416,10 +1416,12 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		 * section 16.7.4 for details.
 		 */
 		if (status & MACB_BIT(RXUBR)) {
-			ctrl = macb_readl(bp, NCR);
-			macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
-			wmb();
-			macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
+			if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR) {
+				ctrl = macb_readl(bp, NCR);
+				macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
+				wmb();
+				macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
+			}
 
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(RXUBR));
@@ -3864,7 +3866,8 @@ static int at91ether_init(struct platform_device *pdev)
 }
 
 static const struct macb_config at91sam9260_config = {
-	.caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
+	.caps = MACB_CAPS_USRIO_HAS_CLKEN |
+		MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII | MACB_CAPS_NEEDS_RSTONUBR,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
 };
@@ -3928,7 +3931,8 @@ static const struct macb_config zynqmp_config = {
 };
 
 static const struct macb_config zynq_config = {
-	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF,
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
+		MACB_CAPS_NEEDS_RSTONUBR,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
-- 
2.7.4

