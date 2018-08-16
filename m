Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EC5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D612152B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="o9LSYQdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D612152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbeHPKDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:03:30 -0400
Received: from mail-dm3nam03on0044.outbound.protection.outlook.com ([104.47.41.44]:61036
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389124AbeHPKD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzaMtsiYm6GcH5cczvdYtG1Os9UG29mMMxSqhQyL9hw=;
 b=o9LSYQdqwiWjMIUqp/HhS0uL1H7s8VLDW7W2gQ3QsAHHbOZTOwgLI/+ENJcsZxGukOKR9kypdRACtI1O5OHJXkd2QgusYLaJumNQ49qwEwJpth02iexCWCxQZ8K6JgPSz316SCqSn0Gti4s3tx2ccnmvYKZ9wG7Sm4L5f6Gn+64=
Received: from CY4PR02CA0045.namprd02.prod.outlook.com (2603:10b6:903:117::31)
 by BYAPR02MB4326.namprd02.prod.outlook.com (2603:10b6:a03:56::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Thu, 16 Aug
 2018 07:07:03 +0000
Received: from CY1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by CY4PR02CA0045.outlook.office365.com
 (2603:10b6:903:117::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 07:07:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT058.mail.protection.outlook.com (10.152.74.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 07:07:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:50220 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCN3-0007Ho-KK; Thu, 16 Aug 2018 00:07:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1fqCMy-0000y9-FK; Thu, 16 Aug 2018 00:06:56 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7G76jCc005161;
        Thu, 16 Aug 2018 00:06:46 -0700
Received: from [172.19.2.167] (helo=xsjjliang50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jliang@xilinx.com>)
        id 1fqCMn-0000pj-K2; Thu, 16 Aug 2018 00:06:45 -0700
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <rajan.vaja@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Subject: [PATCH 3/7] firmware: xilinx-zynqmp: Add request access capability macro
Date:   Thu, 16 Aug 2018 00:06:26 -0700
Message-ID: <1534403190-28523-4-git-send-email-jliang@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(50226002)(16586007)(36756003)(54906003)(4326008)(26005)(106002)(110136005)(316002)(63266004)(186003)(77096007)(8936002)(336012)(126002)(2616005)(11346002)(426003)(14444005)(7696005)(47776003)(9786002)(476003)(107886003)(486006)(76176011)(446003)(51416003)(44832011)(2201001)(6636002)(2906002)(8676002)(36386004)(81166006)(356003)(5660300001)(106466001)(6666003)(305945005)(50466002)(478600001)(48376002)(81156014)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4326;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT058;1:DvqM2wrQ/yW7UlhygmBlAd6Rb4h8sQHNwTxzeietTMjBtj6pBdHDxnng7x/XL/ux8zYz/UudHpJDsSJxPayiBmzd9bvz3jJet8/N9qSJCSkvVtaaiRJiTAaeIRLGZcqE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfd32b5d-9228-420c-64a4-08d60346dded
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;3:+qkfq80Vcc+Q7Itw5dfSVXYHIweLBIfjxbsDQKJ1f3TBidOeiUXbwozLtFL8Cr+ujS9Mhsu6o6HTF3k7vZSTkuvHdJGTa4HG/AKnVWrtrtp44NBLcP84xFj1RaOo76jblNi/35GUiCnvDtReKqHbKM8grCOJUVhGZEY8H4E3JIuUo60wtaf0tuTBiABpkB0kklWgI/0m1nhKW/0Xvtm6TD4sPntBV2BkUyctNgc51zjQ7F6P0Ny6N8LSzulsJZima/ZpmgdBJNUCUYkw4MUwcAvggpMnPojT1Avs4T/I3RDqxQikS0LqKdSl+r80yu437BdS3/GC3bg2W9fj3Kpevmbfd4CERMeaM959eNkpF7M=;25:czxDmSJ2kxpSZcyyWCMk0lNvPRXp+LmGYw7nGkeXZbHKJ9A0nazNJQA5cCfumcYpkRX/6vxOohhiM8E0aTS9BNA5emDstsVG4WEt2lDcN7RuoqBCYjzNsSQIGUxUl3PefC1z4xVR/VFbaOC0RJ6RKr5JtavLTmrYV1bKg/xkMCw9JWCjIcrLQI0S7LcmIZheT+JRemup0L4oND7KDtC21INXhYvakcsZGzikPp+hm/48Sz68vTZBUhOgkBv1cXW1y2VdBI0PKuQnsMoi3+5BtEGMt+oQRe9YUz6tns/IqVgYMnQ0HhUxX7STEB1sULws5llZXsxmkW9q3uByHbCiZQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4326:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;31:RFZivNCScT+7nM5e5uMiVVjP/w2k3KEwIOYCIIidcBOT6o9Cda7E53fGYInnU2w/6KY5pBe46m0kMMUAopzQmMHzPqyxiyt0+QcPngrpkyHie6ik5yviFmwC2C5Xjgfk3rS8jcb98H/3qnBrvpDIcjN9peKh05JMS5cdhgxwKIo5k8MQ9ZwEZ9gJFGrRbywnGGFEK00MxQgvxexeUQixKamUM+WtIhgUPgejbQLB7hY=;20:x+KPgcHd72gumQYpDp7xN6ic7e8ITWK8v39mtGF/GmPdbHq2mbw0A0ok0rDFOBAE1iAJSBqWCyIMD2bikT8TKy60qGz9TKPcdjcrMDmqxnHdCkvAycFdgC3OuUeXmMUsM5pZWHOpSg2G/So9yJTg8IgQLaIJLpY1wHJA/2IFdNl2s25Ol9fVUkUvmZIis20QgBjy+ZrOr9rwOflKL99pzf//7LXj97VeyU+mpxbQsRiLj8NVVYXvx6muANiFpGc4TrqMPKQqMXilB7hRf8e7M9Cc8gf27dKuIvz8vV95AeXXvmpmZRS7jisQi9SerND/UxAWYBWbyjqe+jadgls2fvJqg5EW7cTDBcmh0OmdRsuxtBvIGfNVcjuEn2GZSdOijEXXApXz7GSCP93YYJdkmfZo6qOQqn9r3cyMgAElNnvJ+2kMQgmCbwbWzwpXIjXYKX1QBAlYlSOuxCAT7kmpldSv/eipuiUqutCUXHVKemcv1pdclBNfLYEGiSu9l4Wc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB432684E1EFD194C2613099B0B03E0@BYAPR02MB4326.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR02MB4326;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;4:S9oS1mQnV1aNsPYHZy58S6UOYoGI9i97d+3+wjBBbltpzqho+ivune/SzkoWbcB8SU2OWuF7Sz5UsLIQZksB15LVW8CE4ZVtwdjikqK5asY0pM0/GMPYzFCznmg7+N2qzuf6bYhoemXd+vMYPnT8c07kR0/SOH5hO611TazoQNHRRukGXZ4hniYvJllfLb+Ym5Crdkfv3kqars0ImuZvj8UydX4TprglT+tPhuwTydz43CAPWTJXqCGphqJGderEFtnIo577TJNSrn2EXqsDyVKvr7cSJcfL/EXaD099zeeuooIwaJNaB186lTA28ua7
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4326;23:uMBsn6KpsnMu+YUFm+iczc/Hji3j6XOguREnbsPZl?=
 =?us-ascii?Q?yBeYazoDjGuRH3dgvVko27p04xUMZS4VawFX5rnizV/2RXnBdqWfhA1U7jqn?=
 =?us-ascii?Q?xDHmC5i2dQr+tu0KWPatiYeFJr90NPSeL4iXMviOIpQT+29cPKGBVwayv/vr?=
 =?us-ascii?Q?SOYydD/asaOcpq7GG+nBBarapyhMaKr2IJqYIdkI9pf78QfGZy/NCxcWI8KC?=
 =?us-ascii?Q?BFH0Q1pkNif6i0VO3MOhv4WhklyZcz85KzJyvpdNZ/WwWt48Hu/pppV9UtAk?=
 =?us-ascii?Q?vnq7l7Djx5bSw465xf0qkTQbCEJaxxcuQSH4LFRN9gGQbh3e/gSHR/kd5aKs?=
 =?us-ascii?Q?RzfI/kAmpYr3E3ir3szkqH7L2E5Jus+qXbHpSO9/IY2nTGdjNVD820OT+PVq?=
 =?us-ascii?Q?MBKi3XFu9LGs06pcv5EQyVGjKDLhokl7gKIb0r5HMteN2nW/Yq5LXPmJa88S?=
 =?us-ascii?Q?JvfruemLsfvtXFzaksFX3LXvqP4vG3vTLjAJhyk8DA8yDHFN5kS4+q/D5Lxo?=
 =?us-ascii?Q?LtwS4b/NYKCsBH33zQoIe/kDWG/UzLZa+XsjCJ+hV7J7HT8fwvWZLuVffLr6?=
 =?us-ascii?Q?og6FkRnwb8FA4ErgkFaY2jabmebWxIIOivVMbu+5SB3gSlseY4UbKco2bY3u?=
 =?us-ascii?Q?01o/8P4asRORgMT4ovuAxnqQPwJ2ORzqq8fqoMmwNXkbO4eW8Wfkb2aeLAzl?=
 =?us-ascii?Q?ZifVINA1jMAWQMqG9J79kFdqGwKUpKGRwXRVbBYzXO3dV1xSx8kAVTq1kLDl?=
 =?us-ascii?Q?7Lj8kjp56OGEXYaK4WMgyIy/sJcnFPQsFKTk4cSQYeY/2Zg6oaUk+RTgoRnq?=
 =?us-ascii?Q?8ByGbxIO7vNSTbWq+fryrfnQ654/WtJHTW7LV9cTP7nw8QITRYFRM7+8JOA/?=
 =?us-ascii?Q?yE3+aRrSUVhMTLYhT254bNBcttQrIYf4a/7Pgy0pyi8zbrtahRfUUDzDTRgn?=
 =?us-ascii?Q?KMtO0CSiNi/I1jAQCMlh47WqB2+sgPjoTeFlJdB489A6ncBFeTbf60WAwNqA?=
 =?us-ascii?Q?ul5mD+JuGQ5W0MclgCgucpgNhtiCJ7/4CzRrBCh1XXLJr4JwMHJf/huXp502?=
 =?us-ascii?Q?w7XYGOyt7uU8YfWo5jYm+wfN4vTAibUabmIaxAqYsxXh5HgMQUOWVNr0YBjq?=
 =?us-ascii?Q?m1trUGOLjdl+WjbFJbvJbFlb03yPFTcjdcn1I0F+3cOtLrg1nTCtFhWiQeIc?=
 =?us-ascii?Q?wb33lr1fRiBG9L5CSui+q22TXlzAC46eZAg?=
X-Microsoft-Antispam-Message-Info: NSo1nkcEY1S9sVgMsrFPtYkZlyZkAlJS2MbtcQRinhEn1NtnZPsOCQGqaZ2vYtYMQmJa/8EDUOFIXH1geKXy+o059HXAQbH+PoY32QysTevKjyUzKSdd4iEPaxsc6DOL1aTjdomAj7EjbSc1Y1HzPamngbpSbphN0iD+IaDbOe4wxsJ2rRMXOZZg6GeIbyr7WQPjG/injjacg69hyN7izSUvU4A5eGM5Oalt+ISzv3nLpDku+qrSqmDZYi18CItp3MQUr/R5WZ3BytL9puH1tzw39Ighjh1NGfInVUITESYi0vhcQ9+XkFnKTXjKmh+4p5RoUuOV1K0kcbQs5smNP6iW7SmM+SHMf+efpQNlqlQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;6:o/T3okDGMp/g0NzHou/2EM9cgFYiuRVWjYF+EUrag59tHj7cYy/Q+50ZmI/r868GcFuVxh85Jnk2a9Ss+2IsjmjLEkpn49mSdk6bjDT7Jkm3ZcqjqvpY6PmimfJUkzr+i0TM6h15II6oq/7/0cAl/sII2YVJ3Ybl+U1A7w16cYPoLLSoPcD/Od8JP0756KBvAwtBqT1birK0JjRKWqhbYABQFLhVlXm+/Ar9g83Fhr1GycA2WXSuen4iLjl7BRHpRpdhIKTyCQ1YsphmhuD05pTwhYmdfe6LX8fej0WqWd8QOKt0SJ2wK6nMmDN7ojpnMrTf6GqPucq7db/k1q0CG92VZd4Ol2BvMtaIvbC1yfzEqrM/fqQgAA3qI3+IVNN112H/GgkSD7f95LXNzqbnloissP/nZIdnhDIvluAfjdPWfKdcJKI3Nopma+SoEcN/AxPD82hMX1q/jw1M3JJqPA==;5:JSXTds63L3/y8Kycgr3+3lOWUZUwAHsn9xrEejFEn8TirVeuI9iN5DAcJDqh1EjpCKC7pnKno3FV7MKGMMLhhxLWUsfb/DWitfEwoKeSk3hKYIuXffCbG0066NMouc0pfqiB3NvqzR+oISg3ivWsi4V/yqlyMYIiIIag4+KkzVs=;7:XQQOCAWxqHgfdDSqadyhBfdHcd+Ucz2CwpBWhisG0lnB4pDIWvmEZIY80PeEY1C3APjgkr/ajtkTxXn9hky9t4aH/qc6p6B+6cOEMIwMs9Q0QF8JzF2priUqUppAfN2twl0RGH5j4sJSOCddsJAwneDXgupV/KEKWGLHyhRi2Fnhuo8D3phcnyKgKfX1VTFNTHfV0exEmtErOnK4IE27Pw30a50fXWrEAnKNcKGUoZiStLh4p7PfdZJXWoVwA2M5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 07:07:02.0889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd32b5d-9228-420c-64a4-08d60346dded
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add request access capability macro which will be used to
request access to a device node from Xilinx firmware.

Signed-off-by: Wendy Liang <jliang@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index e3b7292..83ebadf 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,6 +32,9 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/* Request capability of a device node */
+#define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
+
 enum zynqmp_pm_request_ack {
 	ZYNQMP_PM_REQUEST_ACK_NO = 1,
 	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
-- 
2.7.4

