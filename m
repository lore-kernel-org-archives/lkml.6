Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2DBECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3532120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oCPh9uAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3532120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeJaMhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:37:07 -0400
Received: from mail-eopbgr820051.outbound.protection.outlook.com ([40.107.82.51]:7591
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbeJaMhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3PUMHG5FYtjHM6O173oZ50GcLu1gvxqzt5CJSXUO3Q=;
 b=oCPh9uAHWXBkR1EO3jr6+DzPDpyFMKEQ2CtWo19B78VwQRc5RTUyIjt1ySpZSS/3gRSxzo+mSHuzeAVTSeu2pGiNRqp0EU0o2JA9n7IK2uGeaKN3Cq2jCIjKUJrmWc/Efv9s6DJw8BmFWndfwaPuAjdxddG2K54XbPw+mfyU97E=
Received: from MWHPR0201CA0008.namprd02.prod.outlook.com
 (2603:10b6:301:74::21) by MWHPR0201MB3513.namprd02.prod.outlook.com
 (2603:10b6:301:77::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20; Wed, 31 Oct
 2018 03:40:46 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MWHPR0201CA0008.outlook.office365.com
 (2603:10b6:301:74::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.21 via Frontend
 Transport; Wed, 31 Oct 2018 03:40:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Wed, 31 Oct 2018 03:40:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhN7-00012A-7s; Tue, 30 Oct 2018 20:40:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhN2-00039p-4U; Tue, 30 Oct 2018 20:40:40 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9V3eZEu028451;
        Tue, 30 Oct 2018 20:40:35 -0700
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gHhMw-00036w-M5; Tue, 30 Oct 2018 20:40:35 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>, Harini Katakam <harinik@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: [PATCH 1/4] net: macb: Check MDIO state before read/write and use timeouts
Date:   Wed, 31 Oct 2018 09:10:20 +0530
Message-ID: <1540957223-30984-2-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(47776003)(356004)(106002)(77096007)(9786002)(36386004)(76176011)(478600001)(106466001)(5660300001)(2201001)(6666004)(36756003)(305945005)(44832011)(54906003)(2616005)(8676002)(446003)(50466002)(110136005)(11346002)(81156014)(81166006)(50226002)(51416003)(426003)(186003)(476003)(48376002)(336012)(7696005)(486006)(63266004)(16586007)(2906002)(26005)(4326008)(8936002)(39060400002)(316002)(126002)(107886003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3513;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT003;1:eEHVrGYe3cqekci7b6jdL+66Nq0v3eDvGad9zGuptRHcRZ9dLFKqJo3xpdT1ghCGNtOZqPssM9TWNAeGsT5uuNoruRFBLsnpaa4qL8NX01DPeN/2CctzkpuFcjzHgnQz
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4b5891a-01dd-45df-22f0-08d63ee2a45f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;3:VYAlopdb03H3kmmJuQymrapFM7kJWqu+iNlfIXHn9rZ40DCE/0kKMfVmJvuQldYyCmJkYDG1qkCpGMzS86zSVvcpmqXFrnw0sSZqEif9dTVHuJ0muIg3G0xM4Ly7vykO3REFz4kSRSAy5RqRtu+yAGV4y4e6YxjJTstTYewvVFLtsoYzO1qZcx3fIitP9JAopNhSesZdlva25n+6zsohYTzazN2ukVcxqpAe5eha7DDZ//gfaU+PAGwTt5ZsmD5QJK5OoxVl/mRijdjgdIGRGWydrQeVNAQd9Z+72+X+OuoOah/LHT1aluN1Bk+vAur5l53RroAt1jpjp1tj1FbNL/SDSKfNYe+AOgVudMOGblg=;25:n2HpC5vgxDiLnXF82uSMOE737HLQVHcyenlssVykB7bEb8xG47hiwr1PjhXmZ+wnvrtxGTBGa8ehOyzxwhqZEmjUr6U2XYqlaPza4ek5JSUDYtimwPhfHg+NNe30uDed5wYKZ+lSCNxhbZEOKuxQCcV+mLBcAkKW557R/S+uKwfj53UjsqZy/VOPEgaIEeb8V8yLwabAOKoS6FCk4a96s08znDLTHAZTrmmPL2PdGfK1GEA58a3pv7cK6ziuObfMGtRZtAElKBTuo5naTgLkZW9xylnbwxmjB60XriE4b/K+kExQd4cEBeai3gmzJFubM3l/xw9iUA1nS60cDMbhfg==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3513:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;31:/AcUHFcVsTa2cl55hDDrSma1FnGkdeg+HW1UDleaL+rRKvqwkWr55UdPcpP7bfGPmEKxPwcwgkBAuIL4A3DYzxrNuFv1cVSC68w3N4rJRdVIenMVF5aAFiU8jJhgoTVqTJj3TLv3CsQXPkqAYatCWijGuLs6D8xHYo/QsFtp4S4evPMNZ/h9guo5TqF5q++mOZ81ftgLoWFJkuD8XNTX/t7i6XLvfJalejngQmSk9KQ=;20:2cVYmlJK+frAvE5sf20WqXBmlL4Po0AzAHOfdreANwhQDZij4cvq4vlPlIsIP6kyfC4Cb9XyHi2yzc4si6Hy8oh0ybPxYa0cr+Vqg5H9RJPc18Dejgd/RtjHMX45tOeMELdpbVUcYOFPDsiAkU4LvJS0F30OCctxJtzwe6L9jDdMOYPuBMAL16plkem+e/oO5FAtIjSuMWkEvGAl5SOq6kUQOjd58rY8Mpd5bRpodjMWeUxQKrHjg6Z8NuJFXUHB89n4QJbAdt0BVrpRn3jNXYyTKmh5+yXv9TjrwugH6hUnZgRNatpqP7T19cyeUdVN5pVzBZTL9u4ZRRz/Hl77L0Uaz0cE3wbxAv1kUtwL3r0EPxIPUYqF49hlHBwGc+ku8aNth9t3MW1A7hnIK8BhqaAnNVO00O+QkILE2VLfsGM70/1CZYLPRzIAlrfXPSt+ges5k8tdDS+bfUOfIyP8lJm3aJQfnzPsBGA0HG1dR7sFcK6PdeFiLOJNdQp0e0kX
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35136177F737B1AB6FBF67E7C9CD0@MWHPR0201MB3513.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3513;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;4:vsHzixtjy8PNh8njYLpLo96sqG10wtYjKUnasqjkTXoaBTHISgoCl7HjBkLzpmpKdQ3IpRstT8QCly2W939MT5N+uUUiq9RwpjIb+8rZ76UCbVBKPlVLi//Zy6j+CiQg2Umx50PBiYw+5JIXnfK8zZkqdcruhDCTldFgqEHSOG6jFS179MzGn2vRIpPegs1Gl+8Of93R9yh54qOLuyxjrbaclfdA1C4GrMpe/6tTQ+o9D/TdCOsGAVs3bALXh6RDTGQKAznRsaAOqatGpqmEyF1nV02pMcrO7yhTS7cHNPI7fWaHG5wXiJRhlPSqa6DZkqG06JK+jehTNg8nhjaFEw==
X-Forefront-PRVS: 084285FC5C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3513;23:K0cUTD2b7RH6CItiR2PiTzmM+z4F5MyOx7eXZGL?=
 =?us-ascii?Q?+vZwvj19mQsA83RcHljveQD7ljblHe2ZV5a2tdGXHRbPOEyaYrViVxL8T7h0?=
 =?us-ascii?Q?olxky46Aqrp7IuZRqHiQaLAtMLvJCPRiJP3wcUTTEJEhS9ilYbIqXjJ3nfT0?=
 =?us-ascii?Q?XAAz9vc0ZlPF+iq24pNXmD7EwsYHQrOSUaj1kRmPlrO6pDSYRJWdlNRujNL+?=
 =?us-ascii?Q?kNA4iaepTat/JTpQJsY3C/Sl5CvUCrZ543w8L3eOJH37Rx1I3k0cJ1V352Is?=
 =?us-ascii?Q?md0zhnCNv9KaZYfMEBtXOwI2NuH32iV08dLnXY0EVMo9gGe/M6D45dclG3lj?=
 =?us-ascii?Q?92x+emdrRvlhpD25+wTOnF6wyvsRZGilSAO5oENkh2E4AmAAtJ8Hy9HiDd7f?=
 =?us-ascii?Q?vBT0zzNe1NVNQnS19xCzDUc4HuYCEIfJawqsacv4LOrN3+hcJRjV+9vTbFN9?=
 =?us-ascii?Q?uxmFON4TW0+mOdy5+1DsQo8sd+Z014BnqyMPA5hK4njSRYmTQVdq0IVPxES9?=
 =?us-ascii?Q?Geb8wdO6FO9QaCulx2fXuaG0zj/rgAMTNNvlmEKF/jq6MVJidgWkkjIuMJ0Q?=
 =?us-ascii?Q?LB0at+phBtXoXzy1f65sJZKw4p/IqqkpNRqT2+YwAmO6T25qhOla4SCD+UdE?=
 =?us-ascii?Q?7Gxjo7C9Lud0YRykvucU2EesfPnAsIlW0DFjGkSE7h/FeYEMdmTo9700oUmA?=
 =?us-ascii?Q?nORjI0BPE3al/V8kHi5onyY+vDJImYi1pjsoSgsPJPx8uyeGVngGL78YYW2P?=
 =?us-ascii?Q?c34uzHfeJKHDXDuEnuDMyUYmNtxkmLDdfyidilx4GL99TjrWeE82fpbaO2xF?=
 =?us-ascii?Q?pP2vxlRd4cZYII8sLYyB5XWR4rfKe2E3q5ZnGDJcA7zMr7U+TxsCsfK1KpYm?=
 =?us-ascii?Q?UtLROyprX9mVfrTlzafI/ZMWM1GWkdJBku7QJZIpP0MAdsd5pZaOVXSIa5KF?=
 =?us-ascii?Q?7j4A8pHHn7+7ZVYhEDCiz46z209ddo7BmTsm5YESni1YjmnUkJfjdPqiGSVa?=
 =?us-ascii?Q?Q4iGjs1jPevJhNX9C6swIzTwS8e8ireS9/HK/YLikW5V/TDntjVzbtMKOhUU?=
 =?us-ascii?Q?OIlDqou3cmTw+Upcb4FiMxwi25jpjrR08oXTTmtzJ7J51QBjNepHy2S+EPyk?=
 =?us-ascii?Q?H1JBwnRzCtin1hUQgSKhUYXz8yPtJT4hmtVwQZRapO+FbRJsblj5f6g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: v2I+sNRIZQbHNz0znADj1+9ZowqzYxFLWl+NWYK7WaclRNQEoi0AAmFOkX16Dzq0KcW3GTm1p/2xKIe6+hbp0TXQNt0PXe3XG9kIug2LQw07Nqmewi6S78+QRouUoMSihaPylRK3ZkZ/hOYDB/yOoH/QW5jGLh7OEMVeP3ZZdHR8ns76KhtqC1DLY5+C6WFnjPCwGMZlkfkr1Oly8tkpWTNFe0LHoAa4qmUdRYM4xiBk0QXJ8H96+Sc5POvCfPQuDLDB3kAzsWNF5wCkN2iRnHWv/IQtK6b2GwRgPa5bW2/gClsvz9R7y/98XG9BIEXLRTvcHgxvRq4IQxrLweGclrHSBmAEGqKefr2l+0CknTA=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;6:F96uhwvXxan/lDtwMLaFNpR+wnTI5osbM3kOkhQzocK9AZPtgKqqSxw0VVN9fozcbqGMcxvKtxzDKdxHF0tv9/TIZCx3K/47ztMg4QyEQJPLhPRfFpIRrlQs/JSV6KCt6fN7bVmVDJom4lQhA/I9RgMnADENM+l8Wf3M3MnFFRuFmot3oey9hAmue1K3gUUSPJmdsdQz67mc2E0jmDr8hdKyN0mVuT/YHYwHI7gnRJMK8dgONB6pW7C0Tjj6DrbRQKclasmifEpwMg7uJanA7AjdQ9DFQ9llsro/DOjSEGSV9eLO1dKE+GbR5EdJoEIdfa/Sl1jGDIxNPBrsmkQXEeoprZqnfNk4BX5UBHOfEMGwWkMANUKKYHVVwSQuqP/lDWXH8wV+LJX08QEt0/k74EbpYtRsT9S9KueYF6t86JZPSkjydk8I6ZHcTY7CcyzFQFe++aTRWv6Nl/DJpGIVMA==;5:Fe0fIIKwMH7eaZzIthR8wW6OqzU+8wPY2ijT18o5Zb6JeyshgAkO/ZxX4XK9rvRhjVAcHGLnoWoIRCGFdM8JfAYoLDX0ESkZXre2O4XVRffA+vb6Se0L0FnC1B3LpfyUW6IMbQQntI87gJRd4iyn/UhU6E+iXHHAcapU8ZssyPE=;7:dWEVxYEYNB1n+xwioGpX/b4VVbWg1KHPImfZ7kHwrRbF60pHgDOtFGIps0O9y0MzQh9+aAz1W5gCPyQ1IJ1zOCw8DTmrdm1ZQPIrKgrXDwUdVBDcXrdFtugS8b5SnP4BS2CypH3r8eIlE31RXZsb1Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2018 03:40:45.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b5891a-01dd-45df-22f0-08d63ee2a45f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

Replace the while loop in MDIO read/write functions with a timeout.
In addition, add a check for MDIO bus busy before initiating a new
operation as well to make sure there is no ongoing MDIO operation.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
Changes form RFC:
Cleaned up timeout implementation and moved it to a helper.

 drivers/net/ethernet/cadence/macb_main.c | 44 +++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 0acaef3..b4e26c1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -318,10 +318,36 @@ static void macb_get_hwaddr(struct macb *bp)
 	eth_hw_addr_random(bp->dev);
 }
 
+static int macb_mdio_wait_for_idle(struct macb *bp)
+{
+	ulong timeout;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	/* wait for end of transfer */
+	while (1) {
+		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
+			break;
+
+		if (time_after_eq(jiffies, timeout)) {
+			netdev_err(bp->dev, "wait for end of transfer timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		cpu_relax();
+	}
+
+	return 0;
+}
+
 static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
 	struct macb *bp = bus->priv;
 	int value;
+	int err;
+
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_READ)
@@ -329,9 +355,9 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 			      | MACB_BF(REGA, regnum)
 			      | MACB_BF(CODE, MACB_MAN_CODE)));
 
-	/* wait for end of transfer */
-	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
-		cpu_relax();
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	value = MACB_BFEXT(DATA, macb_readl(bp, MAN));
 
@@ -342,6 +368,12 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			   u16 value)
 {
 	struct macb *bp = bus->priv;
+	int err;
+
+
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_WRITE)
@@ -350,9 +382,9 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			      | MACB_BF(CODE, MACB_MAN_CODE)
 			      | MACB_BF(DATA, value)));
 
-	/* wait for end of transfer */
-	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
-		cpu_relax();
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
-- 
2.7.4

