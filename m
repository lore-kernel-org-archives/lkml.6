Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6DBC26649
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B589820880
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5PQREepA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfATRju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:39:50 -0500
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:3058
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbfATRjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej6GZbuwZ+xhXXi2eN25Wn+IptfFQxd76cEuCrgitso=;
 b=5PQREepAo6D+e2isaktVEVGDEnau2CbgUETEIzaMKuI7tvvMt8bm6/bqPuxsMngC5IuTOaOp+XJZ5XkwQ9g9KIr9HdiAmRe4EXwSZ+q7yDQBxi17SGG6J95X302GD9hp9RBO8pEp/QKBpvY1fQSyxyfaI8jQNP0RwVPrwRlzGzw=
Received: from BYAPR02CA0058.namprd02.prod.outlook.com (2603:10b6:a03:54::35)
 by SN6PR02MB4462.namprd02.prod.outlook.com (2603:10b6:805:a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26; Sun, 20 Jan
 2019 17:39:44 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BYAPR02CA0058.outlook.office365.com
 (2603:10b6:a03:54::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Sun, 20 Jan 2019 17:39:44 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:39:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4Q-0005Xv-TG; Sun, 20 Jan 2019 09:39:42 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4L-0002uF-PV; Sun, 20 Jan 2019 09:39:37 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHdYxH022672;
        Sun, 20 Jan 2019 09:39:34 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glH4I-0002tH-8e; Sun, 20 Jan 2019 09:39:34 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>,
        <robh+dt@kernel.org>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 1/6] dt-bindings: power: Add ZynqMP power domain bindings
Date:   Mon, 21 Jan 2019 23:08:30 +0530
Message-ID: <20190121173835.21173-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121173835.21173-1-nava.manne@xilinx.com>
References: <20190121173835.21173-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39830400003)(2980300002)(199004)(189003)(39060400002)(4326008)(107886003)(2201001)(305945005)(50226002)(50466002)(48376002)(81156014)(81166006)(36386004)(8676002)(8936002)(63266004)(106466001)(47776003)(186003)(77096007)(336012)(54906003)(106002)(110136005)(26005)(16586007)(6346003)(316002)(2616005)(36756003)(476003)(11346002)(446003)(126002)(426003)(7696005)(2906002)(76176011)(51416003)(6666004)(356004)(486006)(478600001)(1076003)(9786002)(42866002)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4462;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT057;1:C4JUDHitaUakKP42OoIqi5SH81Giga5L0F6WHmdBwboi56FjLY7KFA6sgAh7Z98sCmFmI2pBsrVe9Fg+2fOFxlBMMH3n/DOlJ9uoPjAgCkuiAAr0Di6ajeZIQKAp2cACX9XJF9ehWtJC6CWEiwnBhp1fEoktWZUJ164aEAfBEHc=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e9dfc3c-3504-41e8-c109-08d67efe4363
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN6PR02MB4462;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4462;3:qvIvjDcUBTgONJT8QZfkJay3Y1xX70FFQWatnQQPbbWJWDqHdJ7cjXGfnxnS/CsLAi/wqHT/Z5MHCKRSTr33I8Q1bYZiOB+ih207H+U5HaVJkjuI8r6K2vViewJZYkVa2a8lstfsq+Olwe36zyePUb7XsKmp3WN9HazeGGVFfqEPmLDCgIxIyXGg/p4NUqjwdSwc+bT+PoiCngpwmilwXhJt4sM/EdcjdLGxNvqxyPQdxFtyGmCCbrfKZavBZdmwFBdUKFDK92cv2agHmvSam2mSA4X6F82SbNXGRqoWpFU0qMyMhyad8aMC/OeOmGiMLErTQlgi/1B1CCPMhK5DzTCXRIWOCmTP/mzAPz4MJn/4Vp0mg6bJIhx8AHQdcbp3;25:jqdPk/ZuILYSuzSMH9Rmr3qzBDU3hNETsnfmYZG4PPSZAmSAyldQJeOICavvmJsXJqmjkcSUTPSqVi8adMC1VMa9+n6G4wgTzr+tLoEyvw9oeOP4+DsG+gPmqEAb/dVIFFukYGy+FQ0NjLkvFQEuG1tOvxcFKFyJfDTisfW4bkY2Oz9LLCKvkBoiT4qlcUF+uRpz+f7XPL3f5BFNEmrEmA/Hl+2TvHHBMKXw59JqmtfdMnIGk5HU1ysiqlZTaaNsrhvh2n2okQetUMNcQTwLuH/reMT0r061A1lFDn8kvZvRiMmohtpepgL8QHZYxIhE90XvxQvSu0WV4pdQX+5xwQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4462:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4462;31:pakQKSyFgND9pHiHM9rS9HoD80N59n96CJt/uGJCfEpWOFK8fW8pQOJptSRLGHN30SHf40fv4D5Xw/OZyFXfAmYIa3BbrECNVhAPaDLaK56cqjpKYOWhK2E0Q+bgZTceunON3mcNFLFMe5IX/qCVXjDd6bnJqcbvlkBxzHokAzocE9zHSxEpu6k2n3pf0FX/ww1ijUWPL2pfXLktSgJalMnudpSbkvXGFM4itNVsjuA=;20:IYt2f7RQiWLp8lVOSer8xmTas11XZi1x8aRJn/XqYMB2v8RupJRzpCITTH5JVZ4q1TYgJdE3T7WEGumNYY4q9wSmnmwuLcOoFpsEJUyJs/S24pe7rdPKzz0ncEqYLoVyOzPTXFCUAKzaIwsjwRz4L2WIgg69ONmDHJAHei/BkHQH6BpsBRFiic5WuIrDFHo+Aocw8fAZmh2XWePag1WZt4VR60+xzeD9Yh0XqPncWo/Dvt2GgT0Bp64rzgZZ6FT03uHYp+AQUHUwvDBY4JMYT97Fg1LTPTHqpY/HoLmcDkIPUS3LjZtJ5RsivvzGjB/bnAltsOL48L+IeYqU2GGTgzG1yGrYv/sJDbFV+EcSVP6prOcFFaYviLmtV+UhxxfdSeSWioS9chERyoNJ+26fE8ZXNMJ6++wgCLewwASlr5atL7t9FRatccZhi9+g58/+LE/9iMJ7VhYtXzCWB1uXsgfp/rpC0J/FbfNPlJV7O525kzLOTPvb/DlRRib1I1OU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB446262409E4E73554AC09E0CC29E0@SN6PR02MB4462.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4462;4:oKGVck+Hl/abRgUTpPfLFfIqBnvWIklF73F0ZzpzCUqgVDpdboei5Vm38rbhgF1RJs+Pnf5lq+CcJCIKs+/fsltPHg7qndEHoJuo6ktIga+NvrfSbNSuQGGUGpQFox2kIQjP4mBlgbsqi2swbeDpKIiCMeZgkCp5A2/IYvF96MBxa1q8ugSwy/omBIvD4+eVPlXtXECvAC5ohp2y8iqW5MpLL4lg1Z6rUPdvYDgkvcYurXjiCC39iiOLGWHoCQslzDYdoRofPq78tktboR9Oq3VAI74Fxxi9t7cXWiciI7w=
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4462;23:2RnulcjdYp9mb7PufW1Tf3nJA1uiYXRh9F0Z72YD2?=
 =?us-ascii?Q?kHhuJOmhHnfjYFnj+OkN5eilfFz7SPnz5yaxvQ/qtluc1LJ/vdXlc+Bkm6i8?=
 =?us-ascii?Q?8HGqIeDYs9XlhU2yLuYsn3na+QWQx1LFFpnXWqQsB0wGD3zbkqMZd3a3uIgm?=
 =?us-ascii?Q?ofw1Z1H68DqV4sMiNH+YTO8vB2onhlyztmH9jqvhOgxLXsa9GRK4K2i1hspk?=
 =?us-ascii?Q?5HJa2JxloLmDxE/vzFr9FiHSJVNi3eWZrw6j0Qv7HvWTnb0Wu9hvIs25zSPt?=
 =?us-ascii?Q?LAvv9RpEbHs/oAQwiYUHT4102ZofKr9d5fGOttwMOr4Id9aPNnTg/ndJpwTQ?=
 =?us-ascii?Q?jmaJwaBwIvoXmcml9HGapTxoew66bpjKwz144Kpy6n91GM+DgLx+rEEnRqlx?=
 =?us-ascii?Q?ft4saaL4YjQG7PfZslckKYAolCK0nwQtEDJGgLA7iybU3KNA2Gshpsj/JPZ5?=
 =?us-ascii?Q?cAMMuNmmW9PKfMbSv2qUqz2hadxFBS2Zrod3jeXeDW6I9pEvIcdwWk4zdDBG?=
 =?us-ascii?Q?KHfDgdPTNcWGcrKZ/QGh4Sj7RzehVc0vJlULLLmy8UMHErtf81F7LsNCK3Ph?=
 =?us-ascii?Q?jlbtZJUfO9cQ3KhhvCUK5rakkFlGIykbNkMoPegnGhHUpQDY/VDk7JPJA0sW?=
 =?us-ascii?Q?kBgjIU/8yMcPLh3okOPc6guS66cT+AXeFavKwKeAdIlsFwsHlmvIMW0xmKPZ?=
 =?us-ascii?Q?SFlJLlOMZinhOKzILyO8IjxKjrD4Uks2YKBEMVGD3Lf8k2FcxPWfd+J4J8Qw?=
 =?us-ascii?Q?gYFls0yZuLhycVxAQdoSahM33ODx/iIoEV38Ja7hdVOMGnbJ7eKwdcpE6NK6?=
 =?us-ascii?Q?s/URjT57d1yKT5iVQiT2B0VzBJvPCU9f0PnnDvxeYRHHJxDG7uXT2qpLKRM4?=
 =?us-ascii?Q?kUTisFtDDIeZevWNSzCAi1EXtSh/sxGgW/y0X5qTF/Z8ILe2ePaP86AJOdeH?=
 =?us-ascii?Q?IWI19EFoYHfpnFUJ5nsxSatXMEMIiZKO6MVhn9eaTvtLpE1WVIDZlfVSqDD0?=
 =?us-ascii?Q?QvmeMTmcmSdKgD8BLSm6dhhrSlazFKzu85nyLOh2lgd/xT4ISGZFBL26U1Xx?=
 =?us-ascii?Q?c+rRnRsdJd7J6ow3CrtidibWcbFViC6rpAhzBp96sQz1LqVLaJaGG9X/UNsw?=
 =?us-ascii?Q?Qhsu6g5KYbIZrhirk2lWbVrlGLwE3m8jK8vEabuE5bBkGl1RGBSu6TgLAL83?=
 =?us-ascii?Q?Rkj7JPkS6DxVbU=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uoCF/XEBVxyrXlTTyb+NO9py3y/xyARZeRwQajn0qiR3Y9o/NNtUfYGzWykpil2fZSccssMcjB89GwhUFGg3iWZo/FAwpLhwKHsdwDj+Y3tWd6ken7gNfjHkEnH+sgg7WLymyMmpIBGuJutPZmjK5tU4gRNs+PmDSWRmTaPG6x5/osVebHfQTfTkoVZrBIlUP68mLpmDP+4+FI+F50jrPOsIRQaDc1D81Z8e2+vOB4xAEDM6PZjTC+euOYV9aGfpLNHBKokn0VvZdhjpQ+CLfseff9HoAyd8AHqL2ZtxxVatZVMg9hu9eyi6QIFrb6uZXR+7I/yhfcWUlHsFZ3QJUyjN6Ir9TZDU6CS+GKLnpn9g5+qHNvAu6aFj9F111knYI16Ca5WFlrtPakucSRtmaTDWJV86E38+bsbuXf4ZCPo=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4462;6:SBFHUU7ATH2SDRxajPSl/EjL1qMq+pXXE7lTLee/Goelzqc+stF3EJdvUSrFaSQi+hyBSOM32ubUo7E5f5MK8886qodMZMguh5oG2+YvV2pjQ1TOZAYDcwPfGk+W/NZLQgSkY5S9XaVRG7Qm6w60YIMG4voT4R8rGGA+cxQrE6CF09MkCkhq4ep7sC73jkHK6DRjz+u5VeTX5Ylu4xPX9ZjNeVFEkYgWiYwwvONGgJ1C2TcrdpLG3SCwdVpQdcb0Xcjb/SAwGSNc9sbOl6sV4eM+sNmT/DMVod+4kcqmw4Qy/mtg1VrpM3q2paGBBqxENMhZlH2QyXhjq0/1clcbMjPoMA4km8bcM/r0rHlIrXMI978yi/99Wiviqxkv+er6ShX6YnVhmHpwsRVTzmzCJ7J6OLhwQ3bPYjUuILVUT3iA+/Hr+YiT9Da8jUZdFXatIwEGUY8xgiXJ58a3ulqRJg==;5:sbGXJpmOy7s4NfaXP4/4Fs6hMwkQbjBMi1LB5/f2FfO0BtSqUcuCu1Ivjjta2WdcoaLtn+WvzXYt2qSIXgM9+bROqHclWu0KDHGlk0Kxq2NAYWLkEVKBstDnD/BYb3dfVu2GwV6qbRho6e2QvC518Cxt5Wpdh2xbVlStL++Z/O2wb8Mc5J5zMsQpJfneRjCtgAX6pLyV2URLZNO/TIkgOA==;7:9K4XU421O0h/4wJ1iK4W6HIHykIuvHX4NyEvkVS8IF/fkFFGUUnmc/APIN7Uv7HYVGgH6E0fyOEXCt81JXW2WXATFk4sR4cxnxYctH7m1rKqFiaTquSPZkASZLNRTEKlKXqFlTFM/BU59xDvS4X5FA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:39:43.4564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9dfc3c-3504-41e8-c109-08d67efe4363
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe ZynqMP power domain bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
		-None.

 .../bindings/power/xlnx,zynqmp-genpd.txt      | 34 ++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h | 39 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

diff --git a/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
new file mode 100644
index 000000000000..3c7f2378e146
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
@@ -0,0 +1,34 @@
+-----------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
+-----------------------------------------------------------
+The binding for zynqmp-power-controller follow the common
+generic PM domain binding[1].
+
+[1] Documentation/devicetree/bindings/power/power_domain.txt
+
+== Zynq MPSoC Generic PM Domain Node ==
+
+Required property:
+ - Below property should be in zynqmp-firmware node.
+ - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 1.
+
+Power domain ID indexes are mentioned in
+include/dt-bindings/power/xlnx-zynqmp-power.h.
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		...
+		#power-domain-cells = <1>;
+		...
+	};
+};
+
+sata {
+	...
+	power-domains = <&zynqmp_firmware 2>;
+	...
+};
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
new file mode 100644
index 000000000000..1bc9636098ca
--- /dev/null
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#ifndef _DT_BINDINGS_ZYNQMP_POWER_H
+#define _DT_BINDINGS_ZYNQMP_POWER_H
+
+#define		PD_USB_0	0
+#define		PD_USB_1	1
+#define		PD_SATA		2
+#define		PD_SPI_0	3
+#define		PD_SPI_1	4
+#define		PD_UART_0	5
+#define		PD_UART_1	6
+#define		PD_ETH_0	7
+#define		PD_ETH_1	8
+#define		PD_ETH_2	9
+#define		PD_ETH_3	10
+#define		PD_I2C_0	11
+#define		PD_I2C_1	12
+#define		PD_DP		13
+#define		PD_GDMA		14
+#define		PD_ADMA		15
+#define		PD_TTC_0	16
+#define		PD_TTC_1	17
+#define		PD_TTC_2	18
+#define		PD_TTC_3	19
+#define		PD_SD_0		20
+#define		PD_SD_1		21
+#define		PD_NAND		22
+#define		PD_QSPI		23
+#define		PD_GPIO		24
+#define		PD_CAN_0	25
+#define		PD_CAN_1	26
+#define		PD_PCIE		27
+#define		PD_GPU		28
+
+#endif
-- 
2.18.0

