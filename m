Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4B8ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000C720831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pQZLBn3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000C720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeJYU6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:58:47 -0400
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:37694
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727432AbeJYU6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5uIp3TA12a6Rxf+bgFP0x5VnAjwua2yCit9SQRfDQM=;
 b=pQZLBn3VmJSj39HwcKtHU0MdAOCuUEcyRLy9TwLz42CRYL1zaW00Y3SNxMx+7JHZ0SJLfgpthoLZq/HIZa9Sv1no+FFQ05TTPWVG9IYbGInM5vnqsqNhk+Nluo8zqo+P51Xam1HfqKou50bFYrbOFhBQBqrAsa+Nr944edFFYIg=
Received: from MWHPR0201CA0019.namprd02.prod.outlook.com
 (2603:10b6:301:74::32) by MWHPR0201MB3514.namprd02.prod.outlook.com
 (2603:10b6:301:77::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Thu, 25 Oct
 2018 12:26:07 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR0201CA0019.outlook.office365.com
 (2603:10b6:301:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18 via Frontend
 Transport; Thu, 25 Oct 2018 12:26:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 12:26:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40860 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFeiD-0000Oh-PX; Thu, 25 Oct 2018 05:26:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFei8-00057l-Lk; Thu, 25 Oct 2018 05:26:00 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9PCPrmo021496;
        Thu, 25 Oct 2018 05:25:53 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFei0-0004vY-Tl; Thu, 25 Oct 2018 05:25:53 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v2 1/3] firmware: xilinx: Add reset API's
Date:   Fri, 26 Oct 2018 17:54:22 +0530
Message-ID: <20181026122424.30831-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181026122424.30831-1-nava.manne@xilinx.com>
References: <20181026122424.30831-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(1076002)(5660300001)(8936002)(36756003)(50226002)(106466001)(8676002)(63266004)(47776003)(81156014)(316002)(2906002)(76176011)(51416003)(7696005)(2616005)(476003)(110136005)(9786002)(486006)(106002)(26005)(77096007)(126002)(446003)(478600001)(426003)(16586007)(81166006)(11346002)(186003)(336012)(14444005)(305945005)(6666004)(356004)(48376002)(2201001)(50466002)(39060400002)(36386004)(921003)(107986001)(1121003)(83996005)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3514;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT019;1:SI0Oepq2HHGRz3xqJSPsntNFbQvlSmFVlrzhR+W+8wiPCYzmrkofyUW1VRFpbz8ayZndpVqiOYGC8sIoDAChJwfB+yPbQbmwOoI8pdyYBzeG4k5Om9yiPkpsKBqtXYST
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70d4f992-07fe-45ca-8456-08d63a750988
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;3:kpJaElSvvnelXzNXHH/+OiMGmFxOBXBZMV3jGVceMSYz7C7m1Ybsns4A0cfpVRtYtIGx7eZ+jZviqxhGpuFNGwMS2MlbrtPv3QXVtiWcWR5Z+/pCMhfxObE9I+9FHMKQ8VK9YIFfJOAT0aqaxbR10ov/0jXgx+yNJmtH+ZrQh5a13pTgo/Se2O/9CKICGm7+YfBDeb5paGskHiyfTlpYzi8W06+Ump4XlI77cKGPxPdlOThlU5GkC1Pc3aef3CEv5Me7zb5hSXvVyLMz9qeXCMDlM9LUX8jM2MyGDyZNPpsSNAZM5Oxn2qcEUkc/d+1UvDBjHu33Jkme2K0tSCTFeetpb5cQe4jybR5ir0vubys=;25:MV+hB40AgEjEz+BhgFynErwBdq4aUMZgXSJ1+BEjCulHN0lGkpU2eTOx8UUT87PLNgXFAUmt7skdc7VJXvCFt6cstnB1E49jLYHZD1c+6+ZKlzSMf6HCt2iizZtP1JwxfFHpI11Mykng3dTCgfdYJlajyu7lYf2Kld6g1VfIyMv7NGtkY+aa2t+T1GnpqA+Taeil/ImRR3XPZFxKulUY4mlnhNrcJuA5hdFdu1JD+OhCpiMF/uVKdGJQu3B1KvDbLGqRbNhh2VOToYKoGJbl3BWJRA161TwBsaB0VcMp2NvUhCZgKRYn+4L0xO9c1iJZTkyp196c/pWqXHXw0A+rkQ==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3514:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;31:xApJ5kF+5Rpha8UKBOl7DEuUYQn2D5c1BJJR6tyMKYcWqz1eJewXTtWBrlMJSBwhNHAq1cT2Z2RR8l3DhpwOS4bkKnD/AI2LDudNUu2BDtzeXxtM2XdzHuzkqwcPdxiBx/Q37gtYROf4Uw8i4EL5ENPEx1ZQ5Yk8xhCO25nqGXwj9XJXWepxNv7mRFyrZi9yw8H+7NFNCxIF7z39sNRvmpO36O2KORLs98syL6FgO8c=;20:S9MKyPPfS9pXsE42lB3pLDx/uAkuvOxmeKFErVZedA1aR+Xn/HlseXDbsIGjRl5Ww4Bm8tnOVbsHVRrUygHVQWPOU5MEWoLfBSX5LJ5dT0LKrsiTvwHQBtY7Qz6WVtsIdYf44aMhrkpHLkXzFUx174C42+sSqPFQxC77YMJN+iAtmE8MPn9n5kdyt7WVgMrJbT+HLhUAtr3qOFgHZP37i4cHb0TP6hjjB/XYZE6rUSbEQz8MYUNmxm43TsW2+U/puTYJUq2ws+Df4qFBvpRegiY9Zl98cLb4vsYEvLW9HaZZeFH5+2up1OicU7CYT17HE8kWGoxiPYWAgdJtfMGG3lRRsLT47SsnrBTKlPtcqIHywihJez9DZgUubfV+Lx2QmdYQVfSnn1kRlrCPWN+npKps5wVY3pkIuwjC2QEizNaG9L83c7Fo/JIoXLr2VzaXW1H031f/s62Z0Zq82Atd641CJzKXnWuvRC9YhTi7llBvkgb7cxHoDhQf5XI3zB4v
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3514390DE8A5735806D23129C2F70@MWHPR0201MB3514.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3514;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3514;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;4:j56g67xwu2GcHllGrmttGPg+8e/8zqrdeczcvOI9T0TtzeJvyvKEuxFGZ1nl6zyvIRB/gXgRUzVlW3eIaCzovShp9EGuSCYPvU09nRkXh0iQ8NFnRPU5akrKh6Ey4RG9MFD2KLrrJxq2n3/tqamEx1nWE1dIjVq+t8HelGEyUAFciA9Dh+6FzQx5bzjCUNzMN1uZnmfW/5l3x4Nwnd0HdUwW2+z1H7knjy6jC4hYfom3rYDTi+luvgxAONYxdDPoMX3eDslcRwpE5zfj7g0XNbsKFaXl2SuAUSyyckqb3BMRzF7CTfBLZkGD6Eykl3OB
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3514;23:OBLi1/qOyvBqeHa3Iz1f2ThaehoLFY+PtqjpeGs?=
 =?us-ascii?Q?X9MQkHWmfpT2A3LOS8HoBgg3uFN+CVQBuX4DADeS0YI5YxBe6eg2F7vy8pKt?=
 =?us-ascii?Q?VBvXYkE9aLgpgbUMPn7c14+V9Y8LjPh+yNAaYjCVU1IyzQ0/iszXVvUJsm/L?=
 =?us-ascii?Q?kvfIvp2t4+T3vv5j4k3HGsIgvMrBPZpXQOFaEKYx4PSToa61xSjb3InzVJyX?=
 =?us-ascii?Q?CvtXTVtTwjX8QrDF1L18myJ7Y53Br0mI8VWVa2kBRAhth30CY8QBLGTyzyux?=
 =?us-ascii?Q?l06oK1dTeGcnfAINswo6Nzkx4yNm9ILuUTfLsSyBM+p4M2RYs4WNihe1i4Dw?=
 =?us-ascii?Q?8yR3UDVI48BdKzn0otY9xPiM5KBS8Ke8+z4Er8O+jcbuke9IzbvbTXe7Zvu6?=
 =?us-ascii?Q?sATvhkqdwlsk1e2jduX7nH1xk98s5HlMzPx5ar4p938rVSF/09KwHnAWdTL/?=
 =?us-ascii?Q?bl7zqUMlPzIBQ7KMQe1KPq6ROMKjxsFapQj/3UxFTlKkIs6VuITOF2ZT3JEt?=
 =?us-ascii?Q?AXz6M74SRtFExZOpburOGVCWsG9QIAXLImrelgU56u1U1TcrX89kHPKXUynK?=
 =?us-ascii?Q?r5GXf2RSGV9snMjuDzS7h6xqtlxqIwotkdW3kcesOzIoR6KPBIYqaprGl4BK?=
 =?us-ascii?Q?hbHxC+g9dZGjJuxzLEYcEopQkayEicPjnrSgIz8Ne/MDaUTQWcf9jsc9M20n?=
 =?us-ascii?Q?x+1ZEGrT0BTIT+kHydNU3NACZvsh3lFTDOazIaKJBatsgvSBGPWioc4zUKDj?=
 =?us-ascii?Q?G3lN4mcDXjFBESTPGi3W5mrpFcAVFVX9iZwUQmaZTtWUXKyDSCJRy7urhRBY?=
 =?us-ascii?Q?n05mflyEgJzsbtc3Ht6B86C3M/XetABMRDE3GpQq6VAezjRET2eonEkyn78b?=
 =?us-ascii?Q?+4oLiiAYvlhdVEcjwBqt6p8WAfvJk03utXeJsNGTOOdslRaRw0AJUdO/IZ++?=
 =?us-ascii?Q?yDekgKWPKRi1LpFzndn2oxQZPT5OR0QSoeaVdecbHekPT4uhfqzAkBwdeyHM?=
 =?us-ascii?Q?9mfG+VTvuBQ559lMSBULNtIeDMlEk1kJUDEzYWKkGliLaPIXj4A0Hz12aTpb?=
 =?us-ascii?Q?vpxgxD+5PHQbyiK/7bnDFZKB80IEXxr09X7h/0mIB1khABj8e4pJrKGtYolR?=
 =?us-ascii?Q?KRK1qgAXJEzVF9HKz+cUAfz9rhJTqwDN7W1um3lUX7NoZ8ObUdZH8I2dvzh3?=
 =?us-ascii?Q?d7ZfEPKcGViKTHsdbekLlSy6WrzwT31C2RNZ6ORLAOCcpLmB+NBG1ss8GEA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: o4UfXXvKDTnMqFvDmsNn752bvE9uMs4a+0Va7AOM+yTGOLUPzmhac0dJXRIPjiH7nlAlegYBbipVT6m69XDMDf+ovKVW6h6qrKP65PhkjBfoYcBc8xswvo0FlViq0sK4BWjYB4At3E6le3MrHy//eUj2q1G4/EZXh+Oi7dkOgktsJMtbyuLgrVsb838IJsTqVfcUpPIMA/RZt2Knb0QkZ/x9e+bsLji+QWyxRGe7rBmuEsyLb5e56hqCyGbkCd3TBIFanDbGUTYjAaTd4lUuVkPDSexqOD1ydU6pqTA7A+qTfaq36qWDCpKOM8tugQp9nrFeM3Jvc2lPsfb4P1hh1Q8o8mGQu2isIMys4wu4+94=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3514;6:AauwBtbttoNyUj/QzKFci25mn7hB2ll/rXU8c7vg3F1gw8px5/B2MR2elKV5Fv1LpaJsmugfdzWafpVJMEYqUQ4jcbaQNI2/SdYCLDOgNSPjWGrqjsKt+rX2HzM7b4L/TCZlkXWtKcHH3uECE7bO5ZtDgJOgcR+lRzDM05czSSkcsU5WxwXYnYy64bcNqO9Nsscta9jujTu6itYetHx2Hu8QEg9uDBAl5Q/g7YlzZov8dsTV/dODpzqRlKKSCNGCizQ0gQQ4wpGGzgOnksu1gkTTaK/XjwXIl25D7lgTFkSAnalLzDOS2BnJA7FG8Q60ln+ppm/GiUaK0BokKhdvHIUKRUN305RZbS0onuvA+Dj/HdXgtzHXPNxJdjxkPGgw2gkJ+eTq5dS1wf+Rqszyd7ixZWdaow9LQJYqflT+A3aM0UG+mphzdcfXO0FGU9hV7pwkL19cGt2tlse1qxG/AA==;5:guO0wsUtfr/AmDYWHdyimycCXUbGbRVVWKo8AY44o/6X2atA5ECUklhvpBHjgHIQYXe77G96JZmL8mcpKle/fRRFODoUgpFJMDjbVbL2pdfdQdWxXZEld/DgexEOz8RJrsyDc6MEHZNil8NV4pvIkMvM98io/XDNgLU/2KvDLPg=;7:O3xOBCMr2XXnVz9OwWPTewSN2ZclZdl3jpXadcMxcUJsP9eMv2agFq3oDD6gT7fKIe5QXaqCGgXi7gTNnFBgtQOnWKt+x6Y/40BgcR3vY7muHVt4aFYmQYImwjrdF1jSQ2ZuNoKBhsJ3j+RsTP5FvMGAu46qnsxZvF9otMkWVlceN5q1yL+/chb/qVqvLo3tpooeAdROR7Uok1WyJBlpaEwOzHSJKSOIgDITzyFAG2IuuxEbSSK/fzjC/boKiUzx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 12:26:06.2530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d4f992-07fe-45ca-8456-08d63a750988
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3514
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds reset API's to support release, assert
and status functionalities by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-None.

Changes for v1:
		-None.

Changes for RFC-V3:
		-None.

Changes for RFC-V2:
		-New patch.

 drivers/firmware/xilinx/zynqmp.c     |  40 +++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 136 +++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2..cd13b06 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,44 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
+ * @reset:		Reset to be configured
+ * @assert_flag:	Flag stating should reset be asserted (1) or
+ *			released (0)
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+				  const enum zynqmp_pm_reset_action assert_flag)
+{
+	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_reset_get_status - Get status of the reset
+ * @reset:      Reset whose status should be returned
+ * @status:     Returned status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
+				      u32 *status)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!status)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
+				  0, 0, ret_payload);
+	*status = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +478,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.reset_assert = zynqmp_pm_reset_assert,
+	.reset_get_status = zynqmp_pm_reset_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130..29d83ca 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_RESET_ASSERT = 17,
+	PM_RESET_GET_STATUS,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -73,6 +75,137 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
+enum zynqmp_pm_reset_action {
+	PM_RESET_ACTION_RELEASE,
+	PM_RESET_ACTION_ASSERT,
+	PM_RESET_ACTION_PULSE,
+};
+
+enum zynqmp_pm_reset {
+	ZYNQMP_PM_RESET_START = 999,
+	ZYNQMP_PM_RESET_PCIE_CFG,
+	ZYNQMP_PM_RESET_PCIE_BRIDGE,
+	ZYNQMP_PM_RESET_PCIE_CTRL,
+	ZYNQMP_PM_RESET_DP,
+	ZYNQMP_PM_RESET_SWDT_CRF,
+	ZYNQMP_PM_RESET_AFI_FM5,
+	ZYNQMP_PM_RESET_AFI_FM4,
+	ZYNQMP_PM_RESET_AFI_FM3,
+	ZYNQMP_PM_RESET_AFI_FM2,
+	ZYNQMP_PM_RESET_AFI_FM1,
+	ZYNQMP_PM_RESET_AFI_FM0,
+	ZYNQMP_PM_RESET_GDMA,
+	ZYNQMP_PM_RESET_GPU_PP1,
+	ZYNQMP_PM_RESET_GPU_PP0,
+	ZYNQMP_PM_RESET_GPU,
+	ZYNQMP_PM_RESET_GT,
+	ZYNQMP_PM_RESET_SATA,
+	ZYNQMP_PM_RESET_ACPU3_PWRON,
+	ZYNQMP_PM_RESET_ACPU2_PWRON,
+	ZYNQMP_PM_RESET_ACPU1_PWRON,
+	ZYNQMP_PM_RESET_ACPU0_PWRON,
+	ZYNQMP_PM_RESET_APU_L2,
+	ZYNQMP_PM_RESET_ACPU3,
+	ZYNQMP_PM_RESET_ACPU2,
+	ZYNQMP_PM_RESET_ACPU1,
+	ZYNQMP_PM_RESET_ACPU0,
+	ZYNQMP_PM_RESET_DDR,
+	ZYNQMP_PM_RESET_APM_FPD,
+	ZYNQMP_PM_RESET_SOFT,
+	ZYNQMP_PM_RESET_GEM0,
+	ZYNQMP_PM_RESET_GEM1,
+	ZYNQMP_PM_RESET_GEM2,
+	ZYNQMP_PM_RESET_GEM3,
+	ZYNQMP_PM_RESET_QSPI,
+	ZYNQMP_PM_RESET_UART0,
+	ZYNQMP_PM_RESET_UART1,
+	ZYNQMP_PM_RESET_SPI0,
+	ZYNQMP_PM_RESET_SPI1,
+	ZYNQMP_PM_RESET_SDIO0,
+	ZYNQMP_PM_RESET_SDIO1,
+	ZYNQMP_PM_RESET_CAN0,
+	ZYNQMP_PM_RESET_CAN1,
+	ZYNQMP_PM_RESET_I2C0,
+	ZYNQMP_PM_RESET_I2C1,
+	ZYNQMP_PM_RESET_TTC0,
+	ZYNQMP_PM_RESET_TTC1,
+	ZYNQMP_PM_RESET_TTC2,
+	ZYNQMP_PM_RESET_TTC3,
+	ZYNQMP_PM_RESET_SWDT_CRL,
+	ZYNQMP_PM_RESET_NAND,
+	ZYNQMP_PM_RESET_ADMA,
+	ZYNQMP_PM_RESET_GPIO,
+	ZYNQMP_PM_RESET_IOU_CC,
+	ZYNQMP_PM_RESET_TIMESTAMP,
+	ZYNQMP_PM_RESET_RPU_R50,
+	ZYNQMP_PM_RESET_RPU_R51,
+	ZYNQMP_PM_RESET_RPU_AMBA,
+	ZYNQMP_PM_RESET_OCM,
+	ZYNQMP_PM_RESET_RPU_PGE,
+	ZYNQMP_PM_RESET_USB0_CORERESET,
+	ZYNQMP_PM_RESET_USB1_CORERESET,
+	ZYNQMP_PM_RESET_USB0_HIBERRESET,
+	ZYNQMP_PM_RESET_USB1_HIBERRESET,
+	ZYNQMP_PM_RESET_USB0_APB,
+	ZYNQMP_PM_RESET_USB1_APB,
+	ZYNQMP_PM_RESET_IPI,
+	ZYNQMP_PM_RESET_APM_LPD,
+	ZYNQMP_PM_RESET_RTC,
+	ZYNQMP_PM_RESET_SYSMON,
+	ZYNQMP_PM_RESET_AFI_FM6,
+	ZYNQMP_PM_RESET_LPD_SWDT,
+	ZYNQMP_PM_RESET_FPD,
+	ZYNQMP_PM_RESET_RPU_DBG1,
+	ZYNQMP_PM_RESET_RPU_DBG0,
+	ZYNQMP_PM_RESET_DBG_LPD,
+	ZYNQMP_PM_RESET_DBG_FPD,
+	ZYNQMP_PM_RESET_APLL,
+	ZYNQMP_PM_RESET_DPLL,
+	ZYNQMP_PM_RESET_VPLL,
+	ZYNQMP_PM_RESET_IOPLL,
+	ZYNQMP_PM_RESET_RPLL,
+	ZYNQMP_PM_RESET_GPO3_PL_0,
+	ZYNQMP_PM_RESET_GPO3_PL_1,
+	ZYNQMP_PM_RESET_GPO3_PL_2,
+	ZYNQMP_PM_RESET_GPO3_PL_3,
+	ZYNQMP_PM_RESET_GPO3_PL_4,
+	ZYNQMP_PM_RESET_GPO3_PL_5,
+	ZYNQMP_PM_RESET_GPO3_PL_6,
+	ZYNQMP_PM_RESET_GPO3_PL_7,
+	ZYNQMP_PM_RESET_GPO3_PL_8,
+	ZYNQMP_PM_RESET_GPO3_PL_9,
+	ZYNQMP_PM_RESET_GPO3_PL_10,
+	ZYNQMP_PM_RESET_GPO3_PL_11,
+	ZYNQMP_PM_RESET_GPO3_PL_12,
+	ZYNQMP_PM_RESET_GPO3_PL_13,
+	ZYNQMP_PM_RESET_GPO3_PL_14,
+	ZYNQMP_PM_RESET_GPO3_PL_15,
+	ZYNQMP_PM_RESET_GPO3_PL_16,
+	ZYNQMP_PM_RESET_GPO3_PL_17,
+	ZYNQMP_PM_RESET_GPO3_PL_18,
+	ZYNQMP_PM_RESET_GPO3_PL_19,
+	ZNQMP_PM_RESET_GPO3_PL_20,
+	ZYNQMP_PM_RESET_GPO3_PL_21,
+	ZYNQMP_PM_RESET_GPO3_PL_22,
+	ZYNQMP_PM_RESET_GPO3_PL_23,
+	ZYNQMP_PM_RESET_GPO3_PL_24,
+	ZYNQMP_PM_RESET_GPO3_PL_25,
+	ZYNQMP_PM_RESET_GPO3_PL_26,
+	ZYNQMP_PM_RESET_GPO3_PL_27,
+	ZYNQMP_PM_RESET_GPO3_PL_28,
+	ZYNQMP_PM_RESET_GPO3_PL_29,
+	ZYNQMP_PM_RESET_GPO3_PL_30,
+	ZYNQMP_PM_RESET_GPO3_PL_31,
+	ZYNQMP_PM_RESET_RPU_LS,
+	ZYNQMP_PM_RESET_PS_ONLY,
+	ZYNQMP_PM_RESET_PL,
+	ZYNQMP_PM_RESET_PS_PL0,
+	ZYNQMP_PM_RESET_PS_PL1,
+	ZYNQMP_PM_RESET_PS_PL2,
+	ZYNQMP_PM_RESET_PS_PL3,
+	ZYNQMP_PM_RESET_END
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -99,6 +232,9 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*reset_assert)(const enum zynqmp_pm_reset reset,
+			    const enum zynqmp_pm_reset_action assert_flag);
+	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

