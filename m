Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4FEC282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6352083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AZAy4MDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfBELHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:07:18 -0500
Received: from mail-eopbgr700073.outbound.protection.outlook.com ([40.107.70.73]:40640
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbfBELHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VPpJWatAVauEfGM00K/2YJ8HXVAzPLhnhrytnyCSx0=;
 b=AZAy4MDOJMvYXbI9a4+/ZUIDEjDKkChYE/aQ5oGSFvWnSMSgsxnD/XLicIwy8JM43gi0Kcg0vHLXHI/pLe/iQ3HBPgI8YxxFLw22wY+y+QJwPKVOYw+yVrPYjUzthIbAzYU+mz8AlHXXAcV05XSO+jhRztP1RQVp6ybWr5f/8Y4=
Received: from SN4PR0201CA0065.namprd02.prod.outlook.com
 (2603:10b6:803:20::27) by MWHPR02MB2656.namprd02.prod.outlook.com
 (2603:10b6:300:44::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Tue, 5 Feb
 2019 11:07:13 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN4PR0201CA0065.outlook.office365.com
 (2603:10b6:803:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1601.17 via Frontend
 Transport; Tue, 5 Feb 2019 11:07:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 5 Feb 2019 11:07:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZM-0001Rt-MB; Tue, 05 Feb 2019 03:07:12 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZH-0001Mi-Hi; Tue, 05 Feb 2019 03:07:07 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x15B72YF020378;
        Tue, 5 Feb 2019 03:07:02 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZC-0001EM-0m; Tue, 05 Feb 2019 03:07:02 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
Date:   Wed, 6 Feb 2019 16:37:20 +0530
Message-ID: <20190206110721.27765-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206110721.27765-1-nava.manne@xilinx.com>
References: <20190206110721.27765-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(2980300002)(199004)(189003)(106466001)(186003)(36386004)(9786002)(6666004)(356004)(336012)(2201001)(8676002)(47776003)(76176011)(48376002)(26005)(36756003)(63266004)(51416003)(77096007)(106002)(7696005)(478600001)(110136005)(305945005)(50466002)(8936002)(50226002)(316002)(16586007)(14444005)(81156014)(126002)(2616005)(476003)(486006)(81166006)(1076003)(426003)(11346002)(2906002)(446003)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2656;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT016;1:dd8WdtNAzHsGIx8ptrWW5+iqRcKgNobGdy/8YFq6BqzfiCXFVsq3tg4Ms1MEtWz9CJw6T0f7ssE/Z2Ce6RfWOTRTbE7j7ux+Pfb/SVH8/QjlPEGyYsuLUYomxM22B3xNDq3dHDFNgk27jfrVhjiuR9YDsgpwj3NWr8v5GA927Yw=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71f9e050-54f3-4290-fa3a-08d68b5a14eb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:MWHPR02MB2656;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2656;3:sXEDTQLKfqhBAYFAA91UEQEHU2JvIWRBQRHHfUmzRgH0Xa0XWaXiMohffJnKkQFpYUGGuWwZO7/cn1RDJpnqcBNc1Xy2j7dTtXkwZCW+a7xw0O+DWwVhx6U0SylNGko53vjUi7sCFIOn8O3ZqycnE34Q85XkzFKFU1oTXgU80cQrlTAVsDPtFOteGPa0OEsZUwoUgJM7Wk/EAw0s5S0DWhz+0ety0eJUL68B0IQkvqY0P2YX/nqha1XGJblNbWgUOIkwfOObPuSPNSyDS2CvTldeypdzPlVTtPK28pVfxYepSGVkbMliTfBhXRve6nRKHcEL6QQGIMnrP3d7iEDGlhGBX4zJATq6WOP3/wacWFGIaUR0uJybQjAEBsrosPGM;25:GE+1mAkDMQYqijM16AMU5OcMNNBAsEzLDZ3IJH5sa1P14wHAg+jHfrATXl8LWZJvWdLfdfJABpwDAqT3DwakWj8r9oVSHga1xSH+vmrRYLNiixekBjPvU9Viu8PGaH9vBkomhCuh3CxLs9CchHE64bdwhLrwQnZp2irES97AnMsGm8G/LFvs1NoFyrIdK2aLToTn5SlkDRh8ygSVnfT/We7tQJx5TNwLyzrDxPV7vgD2E73v8/CcJpVv6DFhUhU9E5cqMOsmFWwWq9MdSvME9ZFqlpN+m1vprOXr8zPGKRKiRZ4e4p+V5AYgavY5ph5bOVCOfIIW//LXFZj+mAy/hQ==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2656:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2656;31:3q0aCohfj+CJcrtOJlxd1J36Y4dN7yGRzX6YIifgn4agG2dx7vZ+76usmbgoVuG6eziWqEGpOqx1dwppSQVBvGrXbn5bE5E05ZD/CO0VVT/w1nK/uLKPn+vE/mSdykepfaoiim0HPErHE9Jy4c+U4ocHsN+/qUlBf+m7B2xYikSs7DUHBuAHQ8A0DAlT1IgeUR4DzYCcp8bjCOVe7PCb/ZTZOFtIsCKYDr0gNF4ZM2k=;20:HJuirIjqhFJBQpDKJV/qdJ4rxeQ5HNg5NIVByoD/IKeCoU5ADmzS1VyTjub+EyDlXtfifneh2CQ44fUe9mlMMGLBYXIAfKR2xYdcg9HtICrCPXxoPpThPbm7caJOSl2+tAnGx+GcDKgZuCK/HuC7cMwy5RbdbwLGBNTltqEs1geIYp9cwpxcHR9Gs7hux7c84wbq/oGnLu8FDVtY3kLVDkdojXXefENkkveahEzL8df+B+MQkJ5GUDMCPgXgxMoMwFgVhybI5Se2wO/zgrsEcA8ZfS5mGwAbYasvsdCqUQ62GUvLDh1q3QIRqFlyvYWt81Qg2QmKrLwcQbOYsVY0wDoGVz+J9PYYKYvpt3r40buOAF+zlJFGbaQI7hcyLfzg4j6c5UE84zsZatVIG05miIXr0Om5Q+GI790De5vo07ndYQQH/cpt7E819zyA3mKRCd2oCOBply1sqRB9dXtQP0h1Nv5vukvz6iUBRCkXgNqlmoy6XDlRLLh9Miuun2aB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB265612A9B0ECF2FF268CFB89C26E0@MWHPR02MB2656.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2656;4:jY3tdZSB7O8tjZwweP5MpD2qh6TAgML1jNxg1FqfXUemY6nNcikLFPhzo+OzUdLi3fuf9Te+NvF28K109ix9wHlolX+qZ33p3fxw9tJAdMHOJMkbiVJNvjPIkImF+8hppylCq4uYi1h6p9NQhWO2ml6YmJbRaVyEgwj7Hb6FH/ogUJ1juLzUXEKKGMspQX8+YaEdhmrWlBLoTDWDsnmCaVcCCjIqrX3u4+P2qChEisUDxYtB/wC696u8mE8SwOIJQjh6AdKakL/Uv6f2B0pi94K+KtM30zcHnw4cScoh9a444FM2/80jfVuTfL1hd+T1
X-Forefront-PRVS: 0939529DE2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2656;23:IOk6aajPoEUEe9KPpdHCI4EyflXPu8Km0/YJabb8p?=
 =?us-ascii?Q?4jHIo7nMvAzJNRYRVDcuQJ10J+RkCfOGMfJ1I1UBcfCmC6GMjb7XC23xBalm?=
 =?us-ascii?Q?Kz4WxQHvgpUcFGznYjptmOCkjlimR0JIegYHksdfl+eyXxlUdpLBOh2Wdvze?=
 =?us-ascii?Q?PCWzR071tBKFKmTmOU7OdHXISAkVMjiwWxrII3oKi8PnOayEahX948D8TYGa?=
 =?us-ascii?Q?h2UhgqkOgkJZf83k+5XdI2LeDTW14t//p64SFGnoEgb7Wpc2Py7HAVwqVrOz?=
 =?us-ascii?Q?VEpv3xku5PjJ/OOC0ORJZOkmGbnGJhYMOajLrqt+RICa+z9gCunnt4Rnd3Oh?=
 =?us-ascii?Q?20QGp8ym2MkHcfjQ/E6hr8EbskpLn8cN50WB8esWi+KpQJrpblHI92yj57MO?=
 =?us-ascii?Q?EuJLjlVLmCGpGQ9JegAHJGCrKt+zYLUGBZdz96i/alUiswUuYrQWb8eo91tA?=
 =?us-ascii?Q?umzWxOpBKDAiOzPJeK5DrKnYN/Cikv7fPVMza0THDrjwdv7OpffVacFyP8Hh?=
 =?us-ascii?Q?aoJnfip4L1AFFgeP4ESL12ZsDcygNbrmDc1oS0TMJ3t20nIiAQnr9Hx8T7jM?=
 =?us-ascii?Q?Ltl1E+TJlkNEiwSUg2pJEVTQyAXyUqYHcgT3oIbpZkWMSw37kj415uvFoaln?=
 =?us-ascii?Q?BkgXUc8anQ+tBohE//TH4eQ4Xc2Sx/ExJJreOddpAiaeEwgL9Qro1nF2gmyj?=
 =?us-ascii?Q?fWOxu/uTMmFKTEwEdgpT/HCWIJusJuBA+rTIZ578jBSQUbzFBtSiQAosMNpf?=
 =?us-ascii?Q?G9oVMljMdAWznW+KrQvFYkrzPAdLmcvAmtlOrmAj6/ugzno/EouobuX58+I3?=
 =?us-ascii?Q?cdmWCyNChXTBrh0hRst7hbnslEQkeu5/8kQVr2wQMo6pyPo7GanQo01zGCsh?=
 =?us-ascii?Q?8ny6ZJAUI/EkG78TZt+KjeZqO2qOSMxoe5vNAmebqBTMkQYBiBNM41xpxcf8?=
 =?us-ascii?Q?UoqDXlOJ/IMOltKxE1GlGIHmXWvpzFXJoy6wnSVg2L4kZYiI23WNuhenLtrq?=
 =?us-ascii?Q?1PtdF1LAXnpAb3jhi9hMT5SvpZ7svAjS7m98CoTV+ZZ9KVJ+RbGUzyy2A6sM?=
 =?us-ascii?Q?5L+KSZsRBZTb8YmCFe+SbjkxY3TH83kLoylvTIZRWCvCjKE836qzmnEg9XZq?=
 =?us-ascii?Q?LByXVE9+ghEaaaD4hALxy7p/ZKHVoXm?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: aPeRj5GgV8+kBm1yGEtbzdnGo9FeuKNkY2Z2Po67GX1OBHqkaP0/scdrTn9pxUwI/5WllRyFZSaNnhbAGON7AsucGU8UdxvOlexbgOMkFOOfRQQKbDLxlAST6MEwMTDmLfuBV8luDc33iM5pM9CYVpO8T8VKkK28jut7z4Yh/mfj247fCbZKMiy2tnVHDFcVxxvflC0Lfrh/vNkXbavJe8FeYT45EQCvqMs4O8BWmYccctbMtFqCsLy3Tf0/i0J+/4UY9bofVWncMbzz9CEuAj+MEuft6gh7KwwdEpuDrWQXbGqV2iXwBrxEOkHX0zWFeh9jym/RHZNdfsGHa/pDoHmRH9r11cNCb/q5YJ0UtxZKj2Dmncnf4d22i/Ai/Rdq07gtqhBXKBGG8dgpSJEU2XvC1b+81YPBGVEchhvKEiQ=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2656;6:FPZ+Ef+MTeg6G4miMUgKBM9eNnrIxsjW5ZIVBslt6QT4U3BGy2qZH0NDs1MQfhAAslvwKLlPy5BQOwQABQPfUMUClEH6rresnuy/jFMLehtXVufPG6cwK9BxpY0GGwoDSLgYNKGiFPVHED1hcZg3z0DwjX57ZGYAe2YOa4d/Hhu8ADZTipu/ZmAas+qQcOMPe8B4WGeFQfGoKSM/baanBmhjwox5yWywbDGV+5d6Qg/fUhrQZaragD9/v76vplGSkGxPOrV6oN0EdgvRxBA32R9pped4PNpDUfwmhOocNNg9luCQ5k88NAJMY6neN+NYhwwRKqsasMMi+zy3e8FwUl8PYlEdsBYhr5FhaJBFZa7ic4VPOXZZTsJcjHEDD0ddzflH7zLS2Ek5equu/RUkHP4THtB9S8VZ8yr7tj0XWh2gZsgNy2//aBgAlmthjyEaSRcvGsve4CoO3TgaGDDyWw==;5:kLyo5LM7/ZbkRKJMjA1Cm0+rQUN0PzGChTPAS1rTUGrl2mWRyJlwi7SmcBR1yx8wx6jpXb1IoONTMCAd/zyD4mVFBbb+9nrFwxL4HJEemBfaKS7dn57UUMTLIPjq5LvXLsBSSd/+ZCOR8uwtkDU6nyXh2PtX8sL83ds9HxR6QnPPutXrmN8ks7p0nzsOCfZZfaeIsRMomW9TJX9BvBrcyQ==;7:FQ/7C8ALuadG+mfE3xhBm+kwhe5LvNKHkvfdS6WdiSIjMedhQKTFzjG/jjDJ+VM+aIEWCxAgktgjMtKH5jpsk0GpVq8Rc01d3iyRLfzFi0NNIQtH7qvYXLlPL3ewLUj4+oOCXL1oeERdlgv0omWzJg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2019 11:07:13.0998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f9e050-54f3-4290-fa3a-08d68b5a14eb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/nvmem/xlnx,zynqmp-nvmem.txt      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
new file mode 100644
index 000000000000..2043c8284f8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt
@@ -0,0 +1,47 @@
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+-------
+ Example
+-------
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+
+		nvmem_firmware {
+			compatible = "xlnx,zynqmp-nvmem-fw";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Data cells */
+			soc_revision: soc_revision {
+				reg = <0x0 0x4>;
+			};
+		};
+	};
+};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+	pcap {
+		...
+
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+
+		...
+	};
+
-- 
2.18.0

