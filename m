Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88A0C26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A461A20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MLebC2eK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfATR0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:26:33 -0500
Received: from mail-eopbgr750081.outbound.protection.outlook.com ([40.107.75.81]:18914
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbfATR0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF81Ebz/i1HNTI9kWeRGPVYV6q5ca1KtBsKg68aXIyg=;
 b=MLebC2eKzqqywK0NKNaOQjV/UnpaznUH+uidTRaz4u5dQaQ2lRBMzTqc1+/Usgbq3kOspkptZXeqtkenVpropevLQW/QK+gUgUQDeV0IWUOlJB6V8Vz0JY/b/yiJgJ3szwL5IuxHwTclKJZuWJwaJFEp/4ulcbYuEAzmOXmiQUY=
Received: from SN6PR02CA0032.namprd02.prod.outlook.com (2603:10b6:805:a2::45)
 by BL0PR02MB4323.namprd02.prod.outlook.com (2603:10b6:208:40::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.29; Sun, 20 Jan
 2019 17:26:02 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by SN6PR02CA0032.outlook.office365.com
 (2603:10b6:805:a2::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Sun, 20 Jan 2019 17:26:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:26:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47793 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGrA-0001he-Mw; Sun, 20 Jan 2019 09:26:00 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGr5-0000vL-J0; Sun, 20 Jan 2019 09:25:55 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHPior024221;
        Sun, 20 Jan 2019 09:25:44 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqu-0000sm-0f; Sun, 20 Jan 2019 09:25:44 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 4/6] dt-bindings: pinctrl: Add ZynqMP pin controller bindings
Date:   Mon, 21 Jan 2019 22:54:25 +0530
Message-ID: <20190121172427.20446-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121172427.20446-1-nava.manne@xilinx.com>
References: <20190121172427.20446-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39850400004)(346002)(396003)(2980300002)(189003)(199004)(47776003)(39060400002)(14444005)(9786002)(106466001)(8676002)(2906002)(356004)(6666004)(107886003)(36756003)(4326008)(478600001)(316002)(50466002)(426003)(110136005)(106002)(50226002)(26005)(305945005)(1076003)(8936002)(76176011)(7696005)(51416003)(2616005)(54906003)(11346002)(2201001)(81156014)(81166006)(126002)(476003)(186003)(36386004)(30864003)(486006)(63266004)(77096007)(336012)(446003)(16586007)(48376002)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4323;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT014;1:4mAgxXH8lo63UxMWPeBn2uwKpRYbOi/1PgumcDBihwXhauRJxPvn7glEYHsinBS/dnqZ+nC3IGT4dZHTbeiEk80NQBI4TRYycyMm5DRPODSs7T8sJzGoZJDGlza6zeAJbdRxAhIjPwUuhmjEuEgFGyjR6yOeDZIx5S6dTc4fklM=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26f57f87-86e1-46e4-ad7f-08d67efc5961
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BL0PR02MB4323;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;3:oE1dp4oMsIw2Y6+0WqkU0y1WijkEsHaZ2C4bTqWvLuuSECYgfj1JIt3hknWmCKB5CDBRBYAZoJpKa+2nQVW5c2MY0FSfNcR26IFUll/yGFkMpUQ3ySJSLgx9Kz6zgac9MjgMT4wbmncKRqWcAKoHA+pDOcxQdqMlHXzFEJ/TUsztV24k/uzbvFt3Tir8pS3DnUXIBod/imp9YRMfYHhBU6V3p+kRHc+8vlCJRFMHDxdoboQTNJiFwmgUAtqp5uFqvS2vCWja1LIiu+clkM7dqyKUrOxHeSCnejArF0e9Hr1PZwsIRdfA8fRkwmHm6ch5x9yOLEXSHAPQbCJn3V3UcWRCcciSk07aM7Hfmkw63ZUGZbh/sSGzKebGhA7aB1kL;25:0H1ai1I/3kdEo/XmlHhJ9y7tohDsM7m/M4Zu+OMJUVuoaxsOyfTpqJe9w6w6SF1qH8d05J6ruPbiwNWWiUJNxdzmC88o9lHyCo7kcOcng6UsM8fa49nG+jSUptFDr1NHHt38rckmolRRVG9fCISfX7M6hNgtEXfVSTgdqQlZmlpC7FS1aAvk/TyUJ8HUxc+fO6NxxpucnDKaVkY6HCRAFQTHSgLCHCW8t5QKHwHfEdpZ6kCY2eNCIzk+JoS1oDCA9++vVn4Gh9LBpOF+qyyOD4IXVyi2ueAuqYdOjwbSnJ9de9K43AMpWvcgaZnmMqXJwAh+pfO27Inrlxrgjr324g==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4323:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;31:Y3RFgVSxCsbnqOjpv7a4VG+5tDNENjvc7T9yPfYZN8GB84zqm2o9GrMDHBJlEntMU7vPeaozWYmILq6YiIEkERVSLficdFVlfUiqlAMerWmack5BzOQf6TcDy8/lRrZu5kllfV3f/j6cK4i1kvBGfYT0jXIz3uc+ZvMXQoKcadXOUdWs65D9amn2vu4Wrtt0CXH/O98A3NrdF82uViMImuMrubt0yEUT5yE/nvnQK5g=;20:4ywozs+Jxt3bXw2oC4cXM6nLEIeij3FDUBQUHnZV6Rv20cFIZnSxcbKkJSDh3XTz2tI88MT/uFI7E1aPK8IqUuPOe6x0rPeD5m1Oia88hhegshCtzPOa999+iZtEBdxmEvmK/Gy5Mb8146UPDtLEaOylnGtnKZDa5xMrHuwFU4J70dz2VrfWBzVd1TAhu+8rRh3n4rOp6iGDdFcpM/BNqUDUmSmV8XfzVFR1YS261vfkzcgvpwPJS95cehquz9agQE1j9GBOMk/FMIxaEpELvrmvV7/AiDljVC3LhwbjhwNYsY1nyX8wGm7w5sT61PM+arG0+oN3UVKxYOdOGf1IUIWIMoqxHN4GS/SuullJfavY3jy8XKTnXOnmnBVcFtAmjnt8SqQOvWpz/MZ3nb+2/R8jT5bTYRxhyn0AfPU0weUgCftvbDcH7VbE7NV8YcQ4sMRnpJzPlIoXsre/I7lLs6e67XNJJx2lMVTCBR1lOvQeQtISUP2xmn56o4mAWjLj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4323715CFB618B8069E45427C29E0@BL0PR02MB4323.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;4:Khm3sHm6Bi1U4vEG3t2n9aiblwQPxLG+7s0e57OxgSeLrXvCnMfegrckz2dyegNrbJJ5iVDNF44MseWYeMGq+eQ0+M6WQDrd+lPKpFmeS74zd/K9Sv7Euj8uFLS5yxASdUoq59sMWs97dQV2I6US7Ugpl3rs+GCPNP+n/Ihto07YjQryZG/s7L/rKCFAFS1EfDiWdTD2wAjF6bozKuknBQQstQ1yBnzYnAqrypHYDLgoL1n3thGI6ETA6bgFdpi0jKTonrdhC/JlhHcKA7yS9DIjLSesW9BOPPO+2c/ffzg=
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4323;23:1WFoDFyipDOjrWTp+mNKz9OvwQqnWfaVhWfC4hyY5?=
 =?us-ascii?Q?lK0tJJ7fjwo3sp120ykCPNHzQdb960aKgr/Vrj5b6UwDUqcKALmYUQGv3zSL?=
 =?us-ascii?Q?R0f5eTw35LTw2ibeOPB5eIUdrrjqf4EA1RUbnbK55LAHI6jQhC2j54Vcmtjt?=
 =?us-ascii?Q?0jYrQhQvJzhsrl5cxdAsIjX90MUdzHIJegwxIsm1ZC8XCVlUTbYpNcmhHAL8?=
 =?us-ascii?Q?f8c6oL0hTyVu22JYc1VIooZam9BykZ8cfrrg44hGdswFXH0ua/ZQmv5UYdkw?=
 =?us-ascii?Q?HqnhaMnVrdC1tf4Eq/pghDqA2sAT3/rsJnEf7epyOgoKc0SkcpBpZAMHdqf1?=
 =?us-ascii?Q?+oI+SxTzAIuvnYCfQuCt++XbJu2+xpS64OS7ZydYOueRVyogFTgHcHPmUC08?=
 =?us-ascii?Q?iLhn0XVP6x6C5Jcq4RigFmJKSXxHc6bzQQben2xmQdQquOGihL7C4L8PwCBK?=
 =?us-ascii?Q?o/WIIXV4UHpw2yRC1ClJRJ8HOsZBZREJsp5PtVW9PGPrqZXaCWINuyB3sZNS?=
 =?us-ascii?Q?/D86JXCwznCdkB02esbAndBzZ169yRa1KyJC6yOLAU7ts/gZYGH5xUHgJtT8?=
 =?us-ascii?Q?8rtWWEG7yx0w2OVUYl6kyW33RJEKS8WG1nANBTBpTXajFfu+WAO1Za1nr133?=
 =?us-ascii?Q?uy9QTj50D9dW7ZB6vPGMJAPl+FefwpKBYLIQAwMIK8OMIK8bZoKDt1oHb7qV?=
 =?us-ascii?Q?40clvXoCPtwtDKfR6jidMunID9eJaasGhSHQgs/VZb3ZnW5jQkdOKl7aJR91?=
 =?us-ascii?Q?+pUybLLPirKYu4ratH7pbM/4fWDFd4dZ068kXIjGS0429Nk2jeYeuaSNdeGY?=
 =?us-ascii?Q?Uke3AWyEGtWy/W/gsLilQxrLwx//XPMPHAqeZbansIiICpUoEhGD5uDBKR+b?=
 =?us-ascii?Q?kEbytyJhZ5gQWZnJvQJ8xb9NRObOuOZFw5XdvWQ3lw9YuYMeH6JGn1KUkAwf?=
 =?us-ascii?Q?xnXOxNmmEOZvRyTLqY7F841wCzGLJgz6dV/CZoa9uYWVHZSbXGwL3tIwJd0b?=
 =?us-ascii?Q?6RPncjNz0lDWL4BLG2O58x9VfZJCbWuGQVFpqpB7lFztCYpH73PHqwXKbMnE?=
 =?us-ascii?Q?e6vVd8LQX7Y/HqP8WQovwRO/jtAjVu75CmchRiY+/jabcEleIgenwIfRnQbW?=
 =?us-ascii?Q?33cNAD5+3WpHi8S6sf2phPbwsSriNvt7s99KTDDYyVOLOmQOHHQXPqKkI8Xp?=
 =?us-ascii?Q?LtWGLG69+tC6cwWVzIWYTI9K6LO/hgvzIbyF6MHYHJ6+52fuJrzW7Na+A=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qiHdy901UTgfy3rLfodVwaI5D4hk6Utr4gpZ6lvrPKqYUDtB1ekWE56uBXscGLox7Wpcd654mV63W4xiLBd0P7sLiFkriwDsMBmIUc7ofXfYRWednDluKN9ytPyM6+JnY7/heoXVj6CEY1eA15ZBXOF4r929vonOfIpbo7zVHAdwFb5wNmFpWXEzZq82amtgswzEHAUqgFQqJ6fQ2NgrltkiObXaqZlcmTPkOtEMpZh0S6VQm2YzQ1QlSkht7Soa1TtgquwDjF6QbnjlvxfdEMMQJLvgEyZdTGpc0y9CfVddDM4stFQfo1YZFg75OwytJWYfX/TQ/fF3baAfZQEa/HC7WIlIYTZlQRuv8cG/zzx+8vib7gYkKB8Hmk/TCpmQodC9dZlT/+/oKzFNRODXYdqP8HyDXjIgEICQ4j0EIn8=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;6:30Bvt5TPG8/ExIyLMj5jEZYx/WZzy1VRjv7n8/9LoVKg27W2US3/jYjMCiTlay+edpqwqPk0GgaOdFp7N1rxKZgZb96HguZ7iMKwRhBJbnJ3thYmbP24mMGE9xYJDDbWXfHZlEEW2ocxgZgURLp94NcaKdwbVJKrensfcTbSPXCfiTzpGPfqDCF1ZEvoeyPwmwuvJJC7w2z9U4cboSwJ5+wKpvYzxuFvxLG93Jn6w3Sd5QSXZQx120fpyyxzD8ZXopbtC6Bkjqu6XlcCkL/7/cZ/z/N5o0CWGfhCURgLxzLJzhf9xiDbLGDpT4IIo7QQSTzYp9Vo9CR4ri3OWWF0qdG/0oLhK/4ifGh2GEREFZI+OwS1pZgPWGvuYhIz/uwv1tALqzQZxJG6aYqJKNh3IAOAhKqYa5lotVDvb26D9NKQxV26+O7CyYzQJgIqpMFQLCUPpZ/zV4f4L6OC8BADRw==;5:JHU6VySkfdSObkUMj8BGV1cPdLiYHG3pCRVlAI0jeaKpxmrLnD34eP8UHr7LYQxWQm6/iCHcbJB/V+QQuKn0aAx69XF6L4n4i+5vFpjV18u8M7BuXe/qlPXiFTXW3Btgahg9RIdl6tChPBRIiNPU7ZuOUdIXKAy2t4k34fi59z9OHaQfjRs2JsykIyi6I2WWvBw3wiB6tTHyHGnHCPm12w==;7:HmnHB4+ddpcpRFYQEt0kP+nLN8QCbrFeczTQ9+1WHgBtA+5b5AMVxFjn9QM0xo1YCTu5ONxiH7BITFPcNE40/6WlXbwneoiDjFjBpo6KeJMerhX39hMKNaHiNRrVWSqQguNpKkF3F4TGJNo7auw0gw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:26:01.2185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f57f87-86e1-46e4-ad7f-08d67efc5961
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP pin controller
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v3:
		-None.

 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.txt  | 275 ++++++++++++++++++
 1 file changed, 275 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
new file mode 100644
index 000000000000..acf44a5d3778
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.txt
@@ -0,0 +1,275 @@
+	Binding for Xilinx ZynqMP Pinctrl
+
+Required properties:
+- compatible: "xlnx,zynqmp-pinctrl"
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+ZynqMP's pin configuration nodes act as a container for an arbitrary number of
+subnodes. Each of these subnodes represents some desired configuration for a
+pin, a group, or a list of pins or groups. This configuration can include the
+mux function to select on those pin(s)/group(s), and various pin configuration
+parameters, such as pull-up, slew rate, etc.
+
+Each configuration node can consist of multiple nodes describing the pinmux and
+pinconf options. Those nodes can be pinmux nodes or pinconf nodes.
+
+The name of each subnode is not important; all subnodes should be enumerated
+and processed purely based on their content.
+
+Required properties for pinmux nodes are:
+ - groups: A list of pinmux groups.
+ - function: The name of a pinmux function to activate for the specified set
+   of groups.
+
+Required properties for configuration nodes:
+One of:
+ - pins: A list of pin names
+ - groups: A list of pinmux groups.
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pinmux subnode:
+ groups, function
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pinconf subnode:
+ groups, pins, bias-disable, bias-pull-up, bias-pull-down, slew-rate
+
+ Valid arguments for 'slew-rate' are 'SLEW_RATE_SLOW' and 'SLEW_RATE_FAST' to
+ select between slow and fast respectively.
+
+ Valid values for groups are:
+ ethernet0_0_grp, ethernet1_0_grp, ethernet2_0_grp,
+ ethernet3_0_grp, gemtsu0_0_grp, gemtsu0_1_grp,
+ gemtsu0_2_grp, mdio0_0_grp, mdio1_0_grp,
+ mdio1_1_grp, mdio2_0_grp, mdio3_0_grp,
+ qspi0_0_grp, qspi_ss_0_grp, qspi_fbclk_0_grp,
+ spi0_0_grp, spi0_ss_0_grp, spi0_ss_1_grp,
+ spi0_ss_2_grp, spi0_1_grp, spi0_ss_3_grp,
+ spi0_ss_4_grp, spi0_ss_5_grp, spi0_2_grp,
+ spi0_ss_6_grp, spi0_ss_7_grp, spi0_ss_8_grp,
+ spi0_3_grp, spi0_ss_9_grp, spi0_ss_10_grp,
+ spi0_ss_11_grp, spi0_4_grp, spi0_ss_12_grp,
+ spi0_ss_13_grp, spi0_ss_14_grp, spi0_5_grp,
+ spi0_ss_15_grp, spi0_ss_16_grp, spi0_ss_17_grp,
+ spi1_0_grp, spi1_ss_0_grp, spi1_ss_1_grp,
+ spi1_ss_2_grp, spi1_1_grp, spi1_ss_3_grp,
+ spi1_ss_4_grp, spi1_ss_5_grp, spi1_2_grp,
+ spi1_ss_6_grp, spi1_ss_7_grp, spi1_ss_8_grp,
+ spi1_3_grp, spi1_ss_9_grp, spi1_ss_10_grp,
+ spi1_ss_11_grp, spi1_4_grp, spi1_ss_12_grp,
+ spi1_ss_13_grp, spi1_ss_14_grp, spi1_5_grp,
+ spi1_ss_15_grp, spi1_ss_16_grp, spi1_ss_17_grp,
+ sdio0_0_grp, sdio0_1_grp, sdio0_2_grp,
+ sdio0_3_grp, sdio0_4_grp, sdio0_5_grp,
+ sdio0_6_grp, sdio0_7_grp, sdio0_8_grp,
+ sdio0_9_grp, sdio0_10_grp, sdio0_11_grp,
+ sdio0_12_grp, sdio0_13_grp, sdio0_14_grp,
+ sdio0_15_grp, sdio0_16_grp, sdio0_17_grp,
+ sdio0_18_grp, sdio0_19_grp, sdio0_20_grp,
+ sdio0_21_grp, sdio0_22_grp, sdio0_23_grp,
+ sdio0_24_grp, sdio0_25_grp, sdio0_26_grp,
+ sdio0_27_grp, sdio0_28_grp, sdio0_29_grp,
+ sdio0_30_grp, sdio0_31_grp, sdio0_32_grp,
+ sdio0_pc_0_grp, sdio0_cd_0_grp, sdio0_wp_0_grp,
+ sdio0_pc_1_grp, sdio0_cd_1_grp, sdio0_wp_1_grp,
+ sdio0_pc_2_grp, sdio0_cd_2_grp, sdio0_wp_2_grp,
+ sdio1_0_grp, sdio1_1_grp, sdio1_2_grp,
+ sdio1_3_grp, sdio1_4_grp, sdio1_5_grp,
+ sdio1_6_grp, sdio1_7_grp, sdio1_8_grp,
+ sdio1_9_grp, sdio1_10_grp, sdio1_11_grp,
+ sdio1_12_grp, sdio1_13_grp, sdio1_14_grp,
+ sdio1_15_grp, sdio1_pc_0_grp, sdio1_cd_0_grp,
+ sdio1_wp_0_grp, sdio1_pc_1_grp, sdio1_cd_1_grp,
+ sdio1_wp_1_grp, nand0_0_grp, nand0_ce_0_grp,
+ nand0_rb_0_grp, nand0_dqs_0_grp, nand0_ce_1_grp,
+ nand0_rb_1_grp, nand0_dqs_1_grp, can0_0_grp,
+ can0_1_grp, can0_2_grp, can0_3_grp,
+ can0_4_grp, can0_5_grp, can0_6_grp,
+ can0_7_grp, can0_8_grp, can0_9_grp,
+ can0_10_grp, can0_11_grp, can0_12_grp,
+ can0_13_grp, can0_14_grp, can0_15_grp,
+ can0_16_grp, can0_17_grp, can0_18_grp,
+ can1_0_grp, can1_1_grp, can1_2_grp,
+ can1_3_grp, can1_4_grp, can1_5_grp,
+ can1_6_grp, can1_7_grp, can1_8_grp,
+ can1_9_grp, can1_10_grp, can1_11_grp,
+ can1_12_grp, can1_13_grp, can1_14_grp,
+ can1_15_grp, can1_16_grp, can1_17_grp,
+ can1_18_grp, can1_19_grp, uart0_0_grp,
+ uart0_1_grp, uart0_2_grp, uart0_3_grp,
+ uart0_4_grp, uart0_5_grp, uart0_6_grp,
+ uart0_7_grp, uart0_8_grp, uart0_9_grp,
+ uart0_10_grp, uart0_11_grp, uart0_12_grp,
+ uart0_13_grp, uart0_14_grp, uart0_15_grp,
+ uart0_16_grp, uart0_17_grp, uart0_18_grp,
+ uart1_0_grp, uart1_1_grp, uart1_2_grp,
+ uart1_3_grp, uart1_4_grp, uart1_5_grp,
+ uart1_6_grp, uart1_7_grp, uart1_8_grp,
+ uart1_9_grp, uart1_10_grp, uart1_11_grp,
+ uart1_12_grp, uart1_13_grp, uart1_14_grp,
+ uart1_15_grp, uart1_16_grp, uart1_17_grp,
+ uart1_18_grp, i2c0_0_grp, i2c0_1_grp,
+ i2c0_2_grp, i2c0_3_grp, i2c0_4_grp,
+ i2c0_5_grp, i2c0_6_grp, i2c0_7_grp,
+ i2c0_8_grp, i2c0_9_grp, i2c0_10_grp,
+ i2c0_11_grp, i2c0_12_grp, i2c0_13_grp,
+ i2c0_14_grp, i2c0_15_grp, i2c0_16_grp,
+ i2c0_17_grp, i2c0_18_grp, i2c1_0_grp,
+ i2c1_1_grp, i2c1_2_grp, i2c1_3_grp,
+ i2c1_4_grp, i2c1_5_grp, i2c1_6_grp,
+ i2c1_7_grp, i2c1_8_grp, i2c1_9_grp,
+ i2c1_10_grp, i2c1_11_grp, i2c1_12_grp,
+ i2c1_13_grp, i2c1_14_grp, i2c1_15_grp,
+ i2c1_16_grp, i2c1_17_grp, i2c1_18_grp,
+ i2c1_19_grp, ttc0_clk_0_grp, ttc0_wav_0_grp,
+ ttc0_clk_1_grp, ttc0_wav_1_grp, ttc0_clk_2_grp,
+ ttc0_wav_2_grp, ttc0_clk_3_grp, ttc0_wav_3_grp,
+ ttc0_clk_4_grp, ttc0_wav_4_grp, ttc0_clk_5_grp,
+ ttc0_wav_5_grp, ttc0_clk_6_grp, ttc0_wav_6_grp,
+ ttc0_clk_7_grp, ttc0_wav_7_grp, ttc0_clk_8_grp,
+ ttc0_wav_8_grp, ttc1_clk_0_grp, ttc1_wav_0_grp,
+ ttc1_clk_1_grp, ttc1_wav_1_grp, ttc1_clk_2_grp,
+ ttc1_wav_2_grp, ttc1_clk_3_grp, ttc1_wav_3_grp,
+ ttc1_clk_4_grp, ttc1_wav_4_grp, ttc1_clk_5_grp,
+ ttc1_wav_5_grp, ttc1_clk_6_grp, ttc1_wav_6_grp,
+ ttc1_clk_7_grp, ttc1_wav_7_grp, ttc1_clk_8_grp,
+ ttc1_wav_8_grp, ttc2_clk_0_grp, ttc2_wav_0_grp,
+ ttc2_clk_1_grp, ttc2_wav_1_grp, ttc2_clk_2_grp,
+ ttc2_wav_2_grp, ttc2_clk_3_grp, ttc2_wav_3_grp,
+ ttc2_clk_4_grp, ttc2_wav_4_grp, ttc2_clk_5_grp,
+ ttc2_wav_5_grp, ttc2_clk_6_grp, ttc2_wav_6_grp,
+ ttc2_clk_7_grp, ttc2_wav_7_grp, ttc2_clk_8_grp,
+ ttc2_wav_8_grp, ttc3_clk_0_grp, ttc3_wav_0_grp,
+ ttc3_clk_1_grp, ttc3_wav_1_grp, ttc3_clk_2_grp,
+ ttc3_wav_2_grp, ttc3_clk_3_grp, ttc3_wav_3_grp,
+ ttc3_clk_4_grp, ttc3_wav_4_grp, ttc3_clk_5_grp,
+ ttc3_wav_5_grp, ttc3_clk_6_grp, ttc3_wav_6_grp,
+ ttc3_clk_7_grp, ttc3_wav_7_grp, ttc3_clk_8_grp,
+ ttc3_wav_8_grp, swdt0_clk_0_grp, swdt0_rst_0_grp,
+ swdt0_clk_1_grp, swdt0_rst_1_grp, swdt0_clk_2_grp,
+ swdt0_rst_2_grp, swdt0_clk_3_grp, swdt0_rst_3_grp,
+ swdt0_clk_4_grp, swdt0_rst_4_grp, swdt0_clk_5_grp,
+ swdt0_rst_5_grp, swdt0_clk_6_grp, swdt0_rst_6_grp,
+ swdt0_clk_7_grp, swdt0_rst_7_grp, swdt0_clk_8_grp,
+ swdt0_rst_8_grp, swdt0_clk_9_grp, swdt0_rst_9_grp,
+ swdt0_clk_10_grp, swdt0_rst_10_grp, swdt0_clk_11_grp,
+ swdt0_rst_11_grp, swdt0_clk_12_grp, swdt0_rst_12_grp,
+ swdt1_clk_0_grp, swdt1_rst_0_grp, swdt1_clk_1_grp,
+ swdt1_rst_1_grp, swdt1_clk_2_grp, swdt1_rst_2_grp,
+ swdt1_clk_3_grp, swdt1_rst_3_grp, swdt1_clk_4_grp,
+ swdt1_rst_4_grp, swdt1_clk_5_grp, swdt1_rst_5_grp,
+ swdt1_clk_6_grp, swdt1_rst_6_grp, swdt1_clk_7_grp,
+ swdt1_rst_7_grp, swdt1_clk_8_grp, swdt1_rst_8_grp,
+ swdt1_clk_9_grp, swdt1_rst_9_grp, swdt1_clk_10_grp,
+ swdt1_rst_10_grp, swdt1_clk_11_grp, swdt1_rst_11_grp,
+ swdt1_clk_12_grp, swdt1_rst_12_grp, gpio0_0_grp,
+ gpio0_1_grp, gpio0_2_grp, gpio0_3_grp,
+ gpio0_4_grp, gpio0_5_grp, gpio0_6_grp,
+ gpio0_7_grp, gpio0_8_grp, gpio0_9_grp,
+ gpio0_10_grp, gpio0_11_grp, gpio0_12_grp,
+ gpio0_13_grp, gpio0_14_grp, gpio0_15_grp,
+ gpio0_16_grp, gpio0_17_grp, gpio0_18_grp,
+ gpio0_19_grp, gpio0_20_grp, gpio0_21_grp,
+ gpio0_22_grp, gpio0_23_grp, gpio0_24_grp,
+ gpio0_25_grp, gpio0_26_grp, gpio0_27_grp,
+ gpio0_28_grp, gpio0_29_grp, gpio0_30_grp,
+ gpio0_31_grp, gpio0_32_grp, gpio0_33_grp,
+ gpio0_34_grp, gpio0_35_grp, gpio0_36_grp,
+ gpio0_37_grp, gpio0_38_grp, gpio0_39_grp,
+ gpio0_40_grp, gpio0_41_grp, gpio0_42_grp,
+ gpio0_43_grp, gpio0_44_grp, gpio0_45_grp,
+ gpio0_46_grp, gpio0_47_grp, gpio0_48_grp,
+ gpio0_49_grp, gpio0_50_grp, gpio0_51_grp,
+ gpio0_52_grp, gpio0_53_grp, gpio0_54_grp,
+ gpio0_55_grp, gpio0_56_grp, gpio0_57_grp,
+ gpio0_58_grp, gpio0_59_grp, gpio0_60_grp,
+ gpio0_61_grp, gpio0_62_grp, gpio0_63_grp,
+ gpio0_64_grp, gpio0_65_grp, gpio0_66_grp,
+ gpio0_67_grp, gpio0_68_grp, gpio0_69_grp,
+ gpio0_70_grp, gpio0_71_grp, gpio0_72_grp,
+ gpio0_73_grp, gpio0_74_grp, gpio0_75_grp,
+ gpio0_76_grp, gpio0_77_grp, usb0_0_grp,
+ usb1_0_grp, pmu0_0_grp, pmu0_1_grp,
+ pmu0_2_grp, pmu0_3_grp, pmu0_4_grp,
+ pmu0_5_grp, pmu0_6_grp, pmu0_7_grp,
+ pmu0_8_grp, pmu0_9_grp, pmu0_10_grp,
+ pmu0_11_grp, pcie0_0_grp, pcie0_1_grp,
+ pcie0_2_grp, pcie0_3_grp, pcie0_4_grp,
+ pcie0_5_grp, pcie0_6_grp, pcie0_7_grp,
+ csu0_0_grp, csu0_1_grp, csu0_2_grp,
+ csu0_3_grp, csu0_4_grp, csu0_5_grp,
+ csu0_6_grp, csu0_7_grp, csu0_8_grp,
+ csu0_9_grp, csu0_10_grp, csu0_11_grp,
+ dpaux0_0_grp, dpaux0_1_grp, dpaux0_2_grp,
+ dpaux0_3_grp, pjtag0_0_grp, pjtag0_1_grp,
+ pjtag0_2_grp, pjtag0_3_grp, pjtag0_4_grp,
+ pjtag0_5_grp, trace0_0_grp, trace0_clk_0_grp,
+ trace0_1_grp, trace0_clk_1_grp, trace0_2_grp,
+ trace0_clk_2_grp, testscan0_0_grp
+
+ Valid values for pins are:
+   MIO0 - MIO77
+
+ Valid values for function are:
+   ethernet0, ethernet1, ethernet2, ethernet3, gemtsu0, usb0, usb1, mdio0,
+   mdio1, mdio2, mdio3, qspi0, qspi_fbclk, qspi_ss, spi0, spi1, spi0_ss,
+   spi1_ss, sdio0, sdio0_pc, sdio0_wp, sdio0_cd, sdio1, sdio1_pc, sdio1_wp,
+   sdio1_cd, nand0, nand0_ce, nand0_rb, nand0_dqs, can0, can1, uart0, uart1,
+   i2c0, i2c1, ttc0_clk, ttc0_wav, ttc1_clk, ttc1_wav, ttc2_clk, ttc2_wav,
+   ttc3_clk, ttc3_wav, swdt0_clk, swdt0_rst, swdt1_clk, swdt1_rst, gpio0, pmu0,
+   pcie0, csu0, dpaux0, pjtag0, trace0, trace0_clk, testscan0
+
+The following driver-specific properties as defined here are valid to specify in
+a pin configuration subnode:
+ - io-standard: Configure the pin to use the selected IO standard. Valid
+   arguments are 'IO_STANDARD_LVCMOS33' and 'IO_STANDARD_LVCMOS18'.
+ - schmitt-cmos: Selects either Schmitt or CMOS input for MIO pins. Valid
+   arguments are 'PIN_INPUT_TYPE_SCHMITT' and 'PIN_INPUT_TYPE_CMOS'.
+
+Example:
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		pinctrl0: pinctrl@ff180000 {
+			compatible = "xlnx,zynqmp-pinctrl";
+
+			pinctrl_uart1_default: uart1-default {
+				mux {
+					groups = "uart0_4_grp";
+					function = "uart0";
+				};
+
+				conf {
+					groups = "uart0_4_grp";
+					slew-rate = <SLEW_RATE_SLOW>;
+					io-standard = <IO_STANDARD_LVCMOS18>;
+				};
+
+				conf-rx {
+					pins = "MIO18";
+					bias-high-impedance;
+				};
+
+				conf-tx {
+					pins = "MIO19";
+					bias-disable;
+					schmitt-cmos = <PIN_INPUT_TYPE_CMOS>;
+				};
+			};
+		};
+	};
+};
+
+uart1 {
+	...
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_uart1_default>;
+	...
+
+};
-- 
2.18.0

