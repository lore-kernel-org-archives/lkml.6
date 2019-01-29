Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54BDC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B37920870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vM8vmZI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfA2Ju1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:50:27 -0500
Received: from mail-eopbgr750057.outbound.protection.outlook.com ([40.107.75.57]:24415
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfA2Ju1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asM3I4So3L3Sy28OZZTKIpByPNk2YNP3Jeifg4I//Ks=;
 b=vM8vmZI4gqF5fS4BIy77WS9D0ljBqDr6pYwCWBvs5/yTr99cLzRDe3RzxfRgZ6J8o2t8ZUQcBAVRxhcR7HyCsI55tiCzLWYD5YRtFSoVmJugwOkoAABlvGsxoA9FlIhDW8GcImteV/unZkwbCwmxnCGAinabOAX81MCkL/xTaPc=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by BYAPR02MB5015.namprd02.prod.outlook.com (2603:10b6:a03:71::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Tue, 29 Jan
 2019 09:50:22 +0000
Received: from CY1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.18 via Frontend
 Transport; Tue, 29 Jan 2019 09:50:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT022.mail.protection.outlook.com (10.152.75.185) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 29 Jan 2019 09:50:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1goQ28-0001to-De; Tue, 29 Jan 2019 01:50:20 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1goQ23-0005Iv-9q; Tue, 29 Jan 2019 01:50:15 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1goQ1v-00054I-U1; Tue, 29 Jan 2019 01:50:08 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>, <brandon.streiff@ni.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>
Subject: [PATCH v2] net: macb: Apply RXUBR workaround only to versions with errata
Date:   Tue, 29 Jan 2019 15:20:03 +0530
Message-ID: <1548755403-361-1-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(2980300002)(189003)(199004)(8936002)(478600001)(63266004)(2906002)(81166006)(81156014)(107886003)(39060400002)(316002)(106466001)(16586007)(2616005)(8676002)(110136005)(4326008)(476003)(50226002)(486006)(36756003)(126002)(44832011)(305945005)(26005)(77096007)(336012)(186003)(9786002)(50466002)(54906003)(6666004)(356004)(36386004)(14444005)(426003)(106002)(48376002)(51416003)(7696005)(2201001)(47776003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5015;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT022;1:+JQ3DPTZH0l6gxuq0+Zojc8E0PbbhkCthUHasMBHb59OhKet8ugbJOQpH5ld+JYvKUEdRFyaPxOHMKWpQqNZlll7/Yw9E3gcWpphw0ZTdwlw+mRd6jtIXMmPcUdMTOMe1iq+GqcqG9Rdrejny1gOvIyC1HllxTzAQaaq300cqxA=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eed0e3c4-0374-4f51-cc7f-08d685cf2f0f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR02MB5015;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;3:M9il1jyG3+hR1s+mg4N/rXTpq8Yl8g0Zzrf/uU+i6JgkKzrWkgIPmXX/M8FKYOnC315ipQYQZUyZ/pXXGgUnxudCyl+hWS3GtkNJi+RVU0qXJoIkkA4mzYNQKBTnF9fexFVuf3G5vDWkgmmq9muLzadTkj+5yChqt3ya3Lgmqp4cN9RBhHK+cR0YLGoC45z7TmJCr7SgkT95UZMDKj+vEBG1gZ4TfWiHRLpYvap4ttxt3UG7mwig2JuBH5nLh/qoYPctVSlvY7e6sn3oxcx2AIVfK5pnJO4KIlrdWWtM7V1Pui9ovnQGQV0sJ87O61tF32cOJQ/Dzd6s0cDtbnnQZDuLf/QtlW9zLHfR5nYI7mRCcMw7YpuKfcmzHZQL+VCT;25:1wvlijKFDDoPEmRzQfB3mEjcUIbG1ukfJlyGeJVeFH3CdD4hJi8rrpeYy9luQbYnO1+ZZOOSvudk0CigC/Nietr7T9W59k5RrkCzLV8W5krtgzcyoYE74bdkqIYNdDEGKL71XggofEhDreDnC7jM6GVscCS+qbl1IK/TQm8+H8siFFLHi6Vl2wYP5c4D9dshYoAgyQGKvFyqr+VD4fHIvdgA/IdHgzqCOLKFfGiyjQbLZQ9IaoRqbT8AkELsXsS5p2tIPByNy9iceneYrXaRAiJhMQZZ1Kt0DxitUQ0ll5IKFkDFaEF5RZfkzVcC+5ftTqX/rrH8fgAmzBuRQ7+aJQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5015:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;31:6mi+miOnIU4ii3HSpkI5trIXPqr6mn/VANK83rtfUFJBtF5wEbJ9MkFNnxSFlsx6q5n/4tV6WcEm4RFzq83ekpeW6ltEoXY/FU+sK5sNlH08ryCL96sTUwHfRnq5lys4nGo31nEzWhauHne0sVdjCfcva3QRnHZiSQIjM4UeAAapDMwrqxa/d3OjNPquJxps9tTZm+Z88hUjOyalfP3xgvXXeQ1WLaNMwMREQ5XJhMM=;20:Uzlw2aLEmkWDygyEc/oWVlHXDH9rzuBU1koaX8fpsZ6pLiNXU40v0yg0pSMF5lkglownXESeLrWdPAXt0zEXCK9i6ZpzGWKq1BGgKxsDt839egKbFq5hqW9DU/aDXUOUC9l6aIzbisDKe22dFRqRu3IuWB+0nOiW3uNSQTDCvSiwE/uLdMHp3TnIat5EhYseUogBB244gZe4AjaxFPwxnFUXSZCMl0OR/1UMwFj/rRs+7Awli0Oj6nIvFeRLLoNskWUGYx3x2IcvKGbWlS07ALhmLNCEje5+oCwDCv8vC3OrGi2YTMdXKJ/NmUdMBG8+rpHXFUeyB4FqelHcZ9GR8RIpvIrAWWwlQiZODSrquZKZEu0xM7mENJ/qNgtZuHuZo7T1O/aR5fdEimihSQBI9J3eoNuh+YJlRd/bvCYzNTLir3Rn5qeB5sZs6rS9+Bt9xCVd0NOummASZW5Xw6YLD6VGToTHBkcxxHd+JdmTlCCjldWqdWW2t2t0gOTYM+qc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB501528AE81B376637CC8C462C9970@BYAPR02MB5015.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;4:NSnKr/E8mmFwINcg1GDP6ieGVONyLdIYq9vIbE5GeDJNkfspbPjvlEsQLn3tNh6Q8WmvPNSkeMmSzUJRoRBpS3a/c6HLOIcl4qMn5MFCDLW7UsaJr8mQLY79FUxbxyo9QIeL5rVDDq+myz4WwkHBVAwkx7M62T25FYwDidYNOhVXFmQJFCojevs22S+Yu3cRkVB6917jeqI36cqL5ersQ43rXfGF1JXNsKnzoQ2n8y1Gi2+k5c3N4sVhuABR0kJ+/DsFTD747L5AldJkksju6RvfWqScQLXs0nQTAtGK8JA+EamC21gyV4aEJ8ubo82C
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5015;23:MU9xmo0ujzGDGcGRbKPePS8nsCxsgJKNoYvK5t4EA?=
 =?us-ascii?Q?S26wi3nczWDxo/pFWdHXJgW3sd8DLNpLFhi+Y/srpQ+2P3q25tNO39rWFFUn?=
 =?us-ascii?Q?JT9S8TuJeVjKb1eyx/+ERSRW5Ytk0bD32MXlh4TDnTovzl9PiST3y5S8zP4O?=
 =?us-ascii?Q?IRjkbCGQ+7IYZMbcAR7bAewTXXF9t1CQg/sK7UY7Pj2JnVQRihA+gSyqfcyR?=
 =?us-ascii?Q?UBf/iSJJRfEw7wlwFawNdjnA1ocCH1zdrf3+w2XmOa5RWprq5wmm/PWcxiLc?=
 =?us-ascii?Q?9gzN5O6DzyHmQR2zB0VA2mxWDHLuRfE+9qfKjdApw6HJpiIR5DFPKie4a9k0?=
 =?us-ascii?Q?WUs/4Fhq8mzQsf5ebYPlswkgPDgfEqZHxInUAfAKDBK9WxGl/DTnmmyMMNI7?=
 =?us-ascii?Q?d46Z+X6tGOdxkiBTaV6pBhc11lWCT3yV/tfLYQr0pe8L8KvJCnPNLHUwQHm5?=
 =?us-ascii?Q?+pM3KxzOLcjk4hUBt896AWrJmw9PvLwoJFngDYt2ByZy/x1Y0aWPn171bD4R?=
 =?us-ascii?Q?KGAfRuX0inhzcGFO19Svih5bcZm5gPV3IaTiTG9/yZLgpRG0LIIFfK0V5d2I?=
 =?us-ascii?Q?YyZU/14uwAgIndHjwwQdwiI/6IOAxz0ksJiDelllzxnZZbYsrdmgBAqhqN5l?=
 =?us-ascii?Q?C25WdPPHdR/L66hEC7jXMC6W4SlUVHdoXPWgojNWFJR7IKoz/BBbqebXToOW?=
 =?us-ascii?Q?sdWFbTiLDC7N3FFSQEUs8fUGJ2wxmCXi1aS3ssf+GNe0vTaq5XvYb2yV5tWw?=
 =?us-ascii?Q?ZKchmyz49Ys46uE19EEtEu4+4/FF+WVyIsrlo0wu6PT/bDTBkMzmHwGEaBaI?=
 =?us-ascii?Q?EzxIQPyTAHK7+JyUU4VIg22W7kNihRL+BNx1A/wIIIb9PF7g4mKzvXdJYHqp?=
 =?us-ascii?Q?KqgwDVyzlI8IBJTxN4TD+SMsfkjvdBPOGP307zLQVIWUg2tJIP/+/D2mXih7?=
 =?us-ascii?Q?v2X1zh3WujX/3wVa3Q70aE+gJvopc8zK64r+Ms8vq/E3vnwsSmNL8LDkWkHv?=
 =?us-ascii?Q?F6oMwQRPzOH14yHQZ0AbObojyAsxZHnweeY+96MuJtB382NtyN5r/Ib9brT+?=
 =?us-ascii?Q?Gqr7afyOnngLiJsUihAKfT/lGCZA4wdCrzPDZkUgbW1wEqwPQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0MDsZuuM6BHtSJIIoBQnU+ACTkiG9/mFmOCmpRHnaAuXxa/vuL+3GJ1VrSwsVL00vhuygiynwKM9kHHEMWQZtG5Cp3Eea1u5NEDYN/AbTqwhL7uT1+bWeQWrYpKJD4AM8ZjDwGSX5HlplQ0PCdV3JgYxsgPhD1PXV4nLdg4DNtOQ1hSjD6QfACGgeK79CgsG8iKRefs3d51hUEv23QR5jvCVbyYENjt7mc0TkCZCUcQtdCM+nCFDPZT7FrJfnvsDCsse4Un2wz3zVGIll67CcSFlnRsqwq9WNoDHopRpArec0uj3jRm82i5dtQoJDBR1DeeEd7gvH8/b8u533DsS56ch14KWySSONeTVMZjlKZ+O0QjeUieUhZ63I2/w2nhFT2VyLfBUx+oNnNPsBGAUbbg/fu8BP8hpDY9+3KkSIkc=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5015;6:ql9vmvF/+3uE62WthDdFt1+bUGmy/PNKi/n2mVarzp5gNJ95Znp99kv2HqKcwijBOpatxMTIAQF0GgxodC12zbt0OPgbEvBjqZ/Nf/HVcs8Hcoo9gCc3jP/EEnmqZKVvlzu1eAiFXBzeAibo88UUPtYQJAF3imCGubNBnG9AX5Mud9z4z2v/Q4KGN+DPiTGsGP838tUxUMVP4ZM1gPizaAWXzOZTXB45nHN7WpVfxNErNeZ7YUaP7kPEWeSx5Si8vlU4OL5U/kyjPPZpqj4TMSM8xlWTIOQ2Pj9Bc84YBk4UsBdsdIRp3AbMPZMSmvIYgvxM+mTJuUf83PZPQycn6Ib3ib8Wot+XbrBfZpRTqbZc2cYXRcDsASHLBMsz+zDztZI8Zowe3OpbXdV+oW7OCBDczIq0d2Kx3Z8slXVGIwJba00QBuLf0RXW3Ps+VQci2KD0L4AZsKfmdxvxOsS/gg==;5:Q+ffSV6yEah+XwkxGYB8U5OSggyhySz4whtzNwVWdqGsdxWAMpjoAYhJ8wfrMfi8fue7FdnCxQhteG5TEpx6LGcS0TuNIfXAXXWdu1eWY6gCgpw4f5shAt+hi5Tqal+Ps/xlKuRvMdoPsAoz13wvosxbtDfDZUqtm325Uw/HHLubd1j9TJlbLmqck1s/yF49n2A2wp+syPZeEX8p3p1X0g==;7:J8e9OHV7DY9UIsXAQDDnFbs9ks70Z0ZG2EXpnEFEiiWpVmRNq862upFh8a35cdOPygFNrYBPAY3tjTuShl9M2+N7LVMWNiZkRVTng8c9viCQYMiCSV7iEgGXgh0kKxkatce2P/sa8QOHQKAdIimASA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 09:50:20.9109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed0e3c4-0374-4f51-cc7f-08d685cf2f0f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt handler contains a workaround for RX hang applicable
to Zynq and AT91RM9200 only. Subsequent versions do not need this
workaround. This workaround unnecessarily resets RX whenever RX used
bit read is observed, which can be often under heavy traffic. There
is no other action performed on RX UBR interrupt. Hence introduce a
CAPS mask; enable this interrupt and workaround only on affected
versions.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
---
v2 changes:
- Added caps mask in correct AT91RM9200 config
- Disabled RXUBR for devices other than AT91RM9200 and Zynq and
kept the interrupt and reset workaround for these two.
- Updated comment in interrupt handler.

Changes from RFC:
- Use CAPS mask instead introducing and errata field.
- Use check only on RX reset part; ISR should still be cleared.

 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 28 +++++++++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 3d45f4c..9bbaad9 100644
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
@@ -1214,6 +1215,8 @@ struct macb {
 
 	int	rx_bd_rd_prefetch;
 	int	tx_bd_rd_prefetch;
+
+	u32	rx_intr_mask;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 66cc792..2b28826 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -56,8 +56,7 @@
 /* level of occupied TX descriptors under which we wake up TX process */
 #define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
 
-#define MACB_RX_INT_FLAGS	(MACB_BIT(RCOMP) | MACB_BIT(RXUBR)	\
-				 | MACB_BIT(ISR_ROVR))
+#define MACB_RX_INT_FLAGS	(MACB_BIT(RCOMP) | MACB_BIT(ISR_ROVR))
 #define MACB_TX_ERR_FLAGS	(MACB_BIT(ISR_TUND)			\
 					| MACB_BIT(ISR_RLE)		\
 					| MACB_BIT(TXERR))
@@ -1270,7 +1269,7 @@ static int macb_poll(struct napi_struct *napi, int budget)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 			napi_reschedule(napi);
 		} else {
-			queue_writel(queue, IER, MACB_RX_INT_FLAGS);
+			queue_writel(queue, IER, bp->rx_intr_mask);
 		}
 	}
 
@@ -1288,7 +1287,7 @@ static void macb_hresp_error_task(unsigned long data)
 	u32 ctrl;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue_writel(queue, IDR, MACB_RX_INT_FLAGS |
+		queue_writel(queue, IDR, bp->rx_intr_mask |
 					 MACB_TX_INT_FLAGS |
 					 MACB_BIT(HRESP));
 	}
@@ -1318,7 +1317,7 @@ static void macb_hresp_error_task(unsigned long data)
 
 		/* Enable interrupts */
 		queue_writel(queue, IER,
-			     MACB_RX_INT_FLAGS |
+			     bp->rx_intr_mask |
 			     MACB_TX_INT_FLAGS |
 			     MACB_BIT(HRESP));
 	}
@@ -1372,14 +1371,14 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 			    (unsigned int)(queue - bp->queues),
 			    (unsigned long)status);
 
-		if (status & MACB_RX_INT_FLAGS) {
+		if (status & bp->rx_intr_mask) {
 			/* There's no point taking any more interrupts
 			 * until we have processed the buffers. The
 			 * scheduling call may fail if the poll routine
 			 * is already scheduled, so disable interrupts
 			 * now.
 			 */
-			queue_writel(queue, IDR, MACB_RX_INT_FLAGS);
+			queue_writel(queue, IDR, bp->rx_intr_mask);
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(RCOMP));
 
@@ -1412,8 +1411,9 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 		/* There is a hardware issue under heavy load where DMA can
 		 * stop, this causes endless "used buffer descriptor read"
 		 * interrupts but it can be cleared by re-enabling RX. See
-		 * the at91 manual, section 41.3.1 or the Zynq manual
-		 * section 16.7.4 for details.
+		 * the at91rm9200 manual, section 41.3.1 or the Zynq manual
+		 * section 16.7.4 for details. RXUBR is only enabled for
+		 * these two versions.
 		 */
 		if (status & MACB_BIT(RXUBR)) {
 			ctrl = macb_readl(bp, NCR);
@@ -2259,7 +2259,7 @@ static void macb_init_hw(struct macb *bp)
 
 		/* Enable interrupts */
 		queue_writel(queue, IER,
-			     MACB_RX_INT_FLAGS |
+			     bp->rx_intr_mask |
 			     MACB_TX_INT_FLAGS |
 			     MACB_BIT(HRESP));
 	}
@@ -3907,6 +3907,7 @@ static const struct macb_config sama5d4_config = {
 };
 
 static const struct macb_config emac_config = {
+	.caps = MACB_CAPS_NEEDS_RSTONUBR,
 	.clk_init = at91ether_clk_init,
 	.init = at91ether_init,
 };
@@ -3928,7 +3929,8 @@ static const struct macb_config zynqmp_config = {
 };
 
 static const struct macb_config zynq_config = {
-	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF,
+	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_NO_GIGABIT_HALF |
+		MACB_CAPS_NEEDS_RSTONUBR,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = macb_init,
@@ -4083,6 +4085,10 @@ static int macb_probe(struct platform_device *pdev)
 						macb_dma_desc_get_size(bp);
 	}
 
+	bp->rx_intr_mask = MACB_RX_INT_FLAGS;
+	if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR)
+		bp->rx_intr_mask |= MACB_BIT(RXUBR);
+
 	mac = of_get_mac_address(np);
 	if (mac) {
 		ether_addr_copy(bp->dev->dev_addr, mac);
-- 
2.7.4

