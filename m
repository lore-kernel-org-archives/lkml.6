Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1553C26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDE420880
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 17:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="veI2aNtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfATR0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 12:26:11 -0500
Received: from mail-eopbgr710074.outbound.protection.outlook.com ([40.107.71.74]:6068
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbfATR0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 12:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGwiChZSBt3VDOUuOnlru6ZyMEODZspcO1aaDfIMCvA=;
 b=veI2aNtxhtDPGqEz8ZyRz8UcOVr9kuyfi+FgZV10cU+F7J2Q1/AUY/sdcKUYqjKPLxY1gdnLWsnpxo560wCdO9guzksGx737M5lgriXYoUM89I8DfqXDAi4KQby7ZEPQAhe9Khfu+r06SuC4jj1oyfSjPKohemwAYFjl1TPV3dk=
Received: from BN6PR02CA0105.namprd02.prod.outlook.com (2603:10b6:405:60::46)
 by SN6PR02MB4333.namprd02.prod.outlook.com (2603:10b6:805:a4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26; Sun, 20 Jan
 2019 17:26:01 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN6PR02CA0105.outlook.office365.com
 (2603:10b6:405:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Sun, 20 Jan 2019 17:26:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1558.11
 via Frontend Transport; Sun, 20 Jan 2019 17:26:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGrA-0005Va-LM; Sun, 20 Jan 2019 09:26:00 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGr5-0000vL-HJ; Sun, 20 Jan 2019 09:25:55 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0KHPnVR019849;
        Sun, 20 Jan 2019 09:25:50 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1glGqz-0000sm-EB; Sun, 20 Jan 2019 09:25:49 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mark.rutland@arm.com>, <michals@xilinx.com>, <RAJANV@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <JOLLYS@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 5/6] dt-bindings: nvmem: Add bindings for ZynqMP nvmem driver
Date:   Mon, 21 Jan 2019 22:54:26 +0530
Message-ID: <20190121172427.20446-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190121172427.20446-1-nava.manne@xilinx.com>
References: <20190121172427.20446-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39830400003)(376002)(396003)(2980300002)(189003)(199004)(126002)(186003)(50226002)(508600001)(77096007)(36386004)(8936002)(426003)(336012)(9786002)(446003)(1076003)(11346002)(81166006)(106466001)(476003)(36756003)(81156014)(26005)(2616005)(8676002)(486006)(2906002)(356004)(48376002)(14444005)(107886003)(106002)(2201001)(305945005)(47776003)(6666004)(63266004)(110136005)(39060400002)(16586007)(7696005)(50466002)(76176011)(4326008)(51416003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4333;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT044;1:rHQKw5kakmYRM0Wr1zOdTZeoyxwaTj6dZg1tHowiC+s5+O30/SAZUJC/rmnC/Dec90+UIMDDzKe+Dcxgl93cY1gQFRu833J+yCVdbD5LiRAuam4UT+El/FJ7pyN85lcAN1s53G4nW3DyHR1OLybdvv/abtri73U+lMLZb16qHj4=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd57561e-b38a-470c-058f-08d67efc593a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR02MB4333;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4333;3:rhlLc2Vd5UOs6cbQlTtc2P4DgAvDRjgFVNta+r7vjp1TY3T1VFbWb8gl3HoI98ip6ybZsD5oQUGetqtjm4Su91kMgo9S3pRiNGuQ6+FfJiZgz1A5yGQVDZrhI5SjuEtp40cubkHbVjaH1yWjpqzz4iZkNX1TEMselNUo2I42eAzDx5o/2eDEQLs/dyiIrcvtWH9U4DtvqqbWZcTJB81/DxozxO/B52z+vBn/p2EOAk0BulmAwwSBGWllxUmtNg90dSxLQNq5ch1lALVqIOf/MiObYpnT/sBOUlJ3meMgvjVFKZXlit47Xr5YHFteQQW64Bnq0T6OF20iqaPKzkNE/l1ToSfiOgsuIUe4P7Z8soL0lPPOmXRbsla6yiR31FwF;25:n1WRs2LFEU6TC3w4jFSyEl3ADGZJ5SW1dk7sb0tEj21OS/SuSVaX1fxia0q2xxOpyWN4nJi+lorMxmF9P6MJi6F+6tuTNbNcPlly50W2anIp6qcm/DSWCpCUSlu1GQrQHp1reQ76/7iYUkR0D1oKv3+nA0u327n3V0SWVnZN1F7bWRrL5+tkZQUp2vTUU5kzSZ2M6anMdD1k1xByFYFGj3tKLPR0Ah9G/OKL1HYmGJKP6WoCanQ2RlwWXwsVHcA6UYP6Hiv4f9HMPtUjQwwHCHG3YcsJyKYxnEE9U+QSeS29UHfdp7+tTOEaPUwoLCdjSlfqVku7r+7DMLDfSSj9Ug==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4333:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4333;31:DuCyXxTt24GhCQP5UcRCEohQTr8rtUJtHldsMlNtOnFjsor1y/9gfxoHXvciv7hieBh9rPffN6b++xV6CpvDvavYJaWJMmIhCi4oykYmDDah/jEXFbiPHWGoHMG5rZNXvBgxsvDmbxaNUFsieKB90nS932owlcUFCPHRlQkMXZ6W/pKzcit7c64/1YJo1B9LpWl9rNIg4o0nnQ/2vNG36s3EWJAyKjlX4k5ZQnJNwIg=;20:x4y1b2PqV88SHlt5DXxgR8EIAXrpYtYIkibSDD5BeiVyeCpE2X+s8nrtaLlyYykHw8+r7SCH6ZS6t/qR/n3hBjT7kpAu71n9zxKRMHXDvpMmQExpMGUDI/bknYJwC9bjLbZCxgjpv4nqgkkIcGz2xt15fscEIkzIIZcFzDVeqJRxjITYozV3x4r6gSeToniatTs3gYQ9hIIfjxLAMbDTI1pcRJptzraQerKsoe4O8oE+43GRZmTKqxATorexylAkrI9yFG5YGOVGJNGLDcTIFMnZkbcPu0ED3apJ1Q26rKmdAYXtF99Hh/V/TCfSTqvjm4wJ0WPdd16jfpv7tFCqxg1Uso9biRdqFwd/hAAlKjCFw476VWOX+CzGu+WiAD9WJ11dKLE3hQTom8xsurxHoj1XWYL4QuYAb3JxKiAvCG9qsaPS8KaniqzBJML/9tKLo3OY5D+MBDfc5URzPHeb8ahVYekWwQvsCeewrqrAy9v4tcn6idFsEP16HqCqXPFF
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB43338B39002D7BE4715D8373C29E0@SN6PR02MB4333.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4333;4:yrHAD5ASOY6yCdT1E+lfniJB5CDXqiC8c+HEOuau4Md9rNqMIAkIlydLmTZLqf+aPXTgXP5ltNeq2U59QDeRYH31ZCql43E/C79aiE2T0riCS9bs/DlPu/fLNjusvA5eJ2NZqDKhdxYkQ4WrqHre61Qr3PRtF9QGVFAIJrUPBr7sUFZSsahmaYce4SGP9pV7YbV/G19ThAd0gz63f1vqnYOW8uHfShgGMnXHnjlHvxAqBj1CmPMjBbp1OWmbacu3OSb6el4nLbrF/EPg7YNvJ0TvpaAxWyeOcTGCqPrMe4/IUxW3JDfSP/j2qGPzHe4e
X-Forefront-PRVS: 0923977CCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4333;23:Vve+v8IXp44mptCPd9qLocC7Rv/nllbbIBq/qGkY7?=
 =?us-ascii?Q?VkaPu4js3zqdmwfIK8HouK4iKlCNMlqYuo6hsK8EvDqbh2gnsSU4oSz1Dalf?=
 =?us-ascii?Q?sbwg3nWcNsGxSsPauoAXUo/Diibg+sKh/q2FfhNkmQVjSGzys0/JobbHL4tc?=
 =?us-ascii?Q?OXpWIotJXC1X7OsyOBfGLBPJrfFc7L7UmKX5fKXbqiNH6+EP6KM/fXKwqnI8?=
 =?us-ascii?Q?ZbEmXUl/7zjVlZr53yYoC8wIFL8aqrDar6qnyxp5ykSYo4TbklTHIlIfhARt?=
 =?us-ascii?Q?6fBt4y3xsGCshB99JX0+l9j/BBj1yXhMz0nnPjM3R4y8fWfa1uvEh7QJVFDP?=
 =?us-ascii?Q?6XADd4ieRxo50At/pOpKjTRX9qgPoFyunMAfgoZsGtGsF1mI3FvauIAJ/GZB?=
 =?us-ascii?Q?7urcLg3oFo2tnKSwd8osGhR7oNIozkRY32UoVv6+TV3SlRBCY6R0m6VorAPg?=
 =?us-ascii?Q?pLO6OyKEmLqZ2cxmGFCr/Qsel21SXfIgR2LOS5A7WRh9tixV0iGrM5+Cp+Np?=
 =?us-ascii?Q?zM3kktDd8iBZbg4wS03IL4xoq6pCbLUl/J0of7bNlQcxoj8NiraEl2YwInUE?=
 =?us-ascii?Q?QwJJvxQhjaAu5ZPP79N1MqwvUrY+Kx0IOset8SSL8yHGyTydKf2loKzcbmIJ?=
 =?us-ascii?Q?govesQGWoG3+9vqu8UkykxAeHnhNhK2T6NUA3KjnjL4G7cQAv4yfNlETssBA?=
 =?us-ascii?Q?mBfY6NS6H4BF7UUY6ItvWjvP7dnN3zMzvDgshez3A6KOwQdLjsLUTluDrhkX?=
 =?us-ascii?Q?PHdmZlzUFBFREbhL9PHJ+JjzyHf7ivzD4+yZQ2AHsBxxAGLK3cMslp1/HZ3E?=
 =?us-ascii?Q?GVIESmR+kGfCtmfDRVaevJs3gw7duCX207HtMtHGdaCTf3FcZgKnFjo6iF/9?=
 =?us-ascii?Q?pJUj4M+U0rZ9m4YyzdRPNeDnkjSfgMMkCgG0m74OLe7xcHDbd7pQanETtDNR?=
 =?us-ascii?Q?cyNKi+XUsHCTPu13Q82X50+26aUPT08taFBNG9Gx6siXN/eTt4yn85j6rJxh?=
 =?us-ascii?Q?XrOO6iTHnkw6aEfr7Kntem4SmcynKqZ3YHqXs4YVNGTvUDpWgfVPRQ2UrH5c?=
 =?us-ascii?Q?2K6no1u5SwY4zbAC44lwn7K2wb5cvwxaWE7SL0kFr2G7xrOfKTwwHrdaEEfp?=
 =?us-ascii?Q?wCd6ffNF3g=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bez/O3/mR6QtpqHT/ZK951NTIWY3gDiJUg3qNGylu8tsjBWpiPEQOE5ZzfzOO+mqtdrA+acBcOLHBZq3HtoAIh4XvKQEeoD7xGc5l3psqBVrfvbmQThj+7F5lam2s5zVskPZwLExQjR09BXQJ4mTmYV1UKWIJ7NU/mX4R1ejHBoC80RzTIFbJDfhBghPX/hR17DFYRrUm7No/tFdsagKW7bEZ+898kBUQi0EftWcNAbTPFSKTSdKD7ktSTHm0HiMS8oCMB+jo4hUzQA9Q/JIAtt+pyhAD7j0hg8IPECAqNEk9VugvCkvwgnp4K9XLWoxlperOxOk2QjNznQqj/9RQByU/IGuvfFVpwIM3JX0bpV619cAFh91Y626EasWSkBZH58uzGYwc26iuz+d0vfPjrZ62FZwb36pkVOo89520es=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4333;6:ULfd3D0cjp4Naocs9Xdv8sKAPauz/oq0jF7AsTfMYsMsk6Y9GLBcU7MqiBsPcF1udKiyNf88Cd3uVAz0XeBMc80KPWoffQRr44bpYOy7B3YHEK8+UjVqI7PXP2LWLcYU6v1wSkLvorDI68m9Q69O6VUtUwGVtOWosH9tImIHXUAErhZiqAvlu1C8v693oKzt0HuKPtgCtXSf0+V0klOPi4SiQHldzXk7Nc9JCF9HQxuYqSl15UhqkW719/eLOe+Hre6AExh9QVNM31XtrzNY6b87iRs2XVpwM2LTTQoYVeRedL1Yd8OtbA5nXkznCLyXVsIQjnY8iDT5NKwizQWvrauF8OacqkLDvrXvlSreK6UthbfN6wf/a66iEypBmkAwiSPbBh5snClvZrRlKOXcGbZtEWKdB3ExWFP5UBBSmrL1fVzN2+4FM0BzpJ8QcDKzasXEzlufAPpigHvCphDEBA==;5:RMJ6dX5VOIe+9saMPPlWPmMAqAKK70XzYGPuTtiWzsdqA4Zii0ETAOaVemeBAH+xKweS4UU4C5TsWyFMPtnrpOcvW6bK/+UfTKETiixXGzT+btXiQembk7pdvkc/YEkwC9qecXHe9OnF1hrLRbXdIsSKn4OFggqJ+NEyvh7dpTQ0nu++edhED50Vg2Fk0CdAt1/iYSnV5SJeqvBDgwtGpw==;7:nhqzGegq5I0zg77nAKnO7fLGUzagaGjIk3Dzbl5WdYU6T++vHv/qYq8sifyb98WgchQxqwC5IpNqybz115pbI1IIvIsXlPX43H9CO7oIlS8Bmn2vwnb/dqWMRXq6UPZBpUf4yJVKfckZ21RdwNaLsw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2019 17:26:01.0203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd57561e-b38a-470c-058f-08d67efc593a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-Added nvmem node as child of FW. Since nvmem driver is a provider.
  
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

