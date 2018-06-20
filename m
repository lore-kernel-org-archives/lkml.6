Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF7AC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B4F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NgLtmXw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B4F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbeFTRlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:41:20 -0400
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:9361
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754739AbeFTRlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umXgkwo3YImcmjHdIgJj8RToiirjb6ylWV4Av4vCAeo=;
 b=NgLtmXw90Enoy/ffP7S1UZgzHedl/ltQ1JZmKB99WVwJw2SUs7g9H3Y1QyS2DG+4CBi32ktzo7hbLz8n/VbseAa0KDTx/Fx6n/YhM707RsP4YKIZF+983SqvoD+S0s0hLZGOYpCQywS5LEMBNwQb2d73ZL5LBzyQPh2ezidk1b4=
Received: from BYAPR02CA0016.namprd02.prod.outlook.com (2603:10b6:a02:ee::29)
 by BN1PR02MB167.namprd02.prod.outlook.com (2a01:111:e400:20::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.863.19; Wed, 20
 Jun 2018 17:40:57 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BYAPR02CA0016.outlook.office365.com
 (2603:10b6:a02:ee::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6G-0002P5-4P; Wed, 20 Jun 2018 10:40:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6B-0004lu-0z; Wed, 20 Jun 2018 10:40:51 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHegQV027145;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh62-0004hY-12; Wed, 20 Jun 2018 10:40:42 -0700
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
Subject: [PATCH v9 06/10] firmware: xilinx: Add debugfs interface
Date:   Wed, 20 Jun 2018 10:40:31 -0700
Message-ID: <1529516435-7315-7-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39380400002)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(126002)(54906003)(107886003)(50466002)(186003)(8936002)(26005)(106002)(9786002)(6306002)(48376002)(36756003)(2201001)(446003)(77096007)(356003)(16586007)(110136005)(5660300001)(336012)(11346002)(44832011)(486006)(476003)(2616005)(36386004)(51416003)(426003)(305945005)(316002)(478600001)(72206003)(966005)(106466001)(7416002)(7696005)(6666003)(50226002)(47776003)(4326008)(63266004)(2906002)(81156014)(76176011)(39060400002)(81166006)(8676002)(59450400001)(107986001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR02MB167;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT060;1:R8ngo9d0XSqVizko0Z8sVo15Fp/2yCXEx+mIY720ztS4srOKLEAwPITc1eN96/S2+GQtTESZk9y411qCHCY7JTZ1u4fUchekMah6UxSP3cJULZmkCvO5zmmqa2WbeT8u
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4863ce9-b2ec-4d3d-b370-08d5d6d4fabb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BN1PR02MB167;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB167;3:Rf9H3Ef8q5jcGgL2tFG7ZVQUnYStEPV8VwrRGN8fZKDvrUwlKQBTjNi8pReP5Zy0t8NN/yw0HCnyb62F7cozs6004JtUa2Eu5UMH51OVPtucGcuUsikT4SOAw9YH2Wb9H1d2xF1WHuCuH+/nJZwFm/UeTM5BCxEaHbTyj88ksg/xxngdNyx7OvHM7xcZTfAvAJSZIua3Alpuzt2AHc4YjRSQK4tlSMqPdK6cqZREz1CdOtgvBPmC+l6l/NCwSr5pVjS9YhE7UToO+V2vPp/Y7+NCqswOtUBsZnOt6qnPJZPOG/SHKzUAK/rZ5+5bQ3NR5l/VyH25JDynhOo7G6ZUBUlF7trDWBAFp7MVH7Ps7go=;25:Se9ejQkQBYyY7ciL3svPIykhmrFdE5i6PdCYYI5DVSDk7ANJS+Sn9zkVflDvvbh4pi/dvaJn7SmYTcjHADjI4JshgkpWIBwwsZkfstxSFbcABjIK+VMmWHiYmOmIimHClinl1xM47adIi/WIuCktSPrJKTRF3lsv9sTSOhSYL92oLCnY/Xp0qORukbcuyduL8+zMD6HhZwU71VKZL0AJf0J8bzHqQS7GDIGvhJtf4bEfQ5wrdLfuw4bBvmcnLZRsL1CrCZbxE04N5bWjMLF7lHvvx4CWKnuBcI3OW1uH+4j5nkC1ui9BC5PKdgj0X3+SfnGa7007He8V0NFKsDo0Sw==
X-MS-TrafficTypeDiagnostic: BN1PR02MB167:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB167;31:bz3IJQQN3DDGRaM7o4mqUhIz2HXagA0Qwg8vALZ9VRnrnF50j9igh0E1EMxCIl14BruCJ9kFbCc4d0V7GIH1c0RuxcSpak0/M6CwJXd948BUbN0Tb77yvvdU+CY1AZbZpwikPS41yPkg+JoAwrGTeDNYHv2bJun1awaNivFZmAKtisNFQR7bNf3ACMRubIrvFLGyV9hXv58vKIZtUqj53v1HYq1Gp2MGwNkNzPWytnA=;20:Rce6bYv9RMq/DUZEa39MEZdV9+tX7my+NAKCIOs7LONPpXTMgCoSOMPyG3SOMhCzmMcg86iKVHK+fhZQnNborKOyZFDRsOpp5mQFCtGu8s5Ri8pgNaXyL/q+G3nkztYheNEf/Uuhco/Z8476qxn2L0ON1XbWIFMNcB5HZNuT1q1NDdW1Og7oagVSOxt5h08QH+YOpKZZwQGfMnRpzVYNXhLKJkl7BYKckgDh2jp9Do+X9rEcMydCivqt6DcgQp01y1klxj3einB5cpSIeKJ+p0FUwozQzMr8bwbROtVmHFhVI+GjYOFHJ5usbG/ATeLVW8rcRFYLCxfmy7TeKoOBOeCvPFxeBF5iagYuFkfF9WNNWZyEqSXWl/ILf7KLkeS3psaOdiaue4WbtHKnsYK1kQMmOxM4yee1D0tD27/amiIPo7iX3UEsSJTQ+jjyy627G5DrBqBnED3vfe19oVSsn+2IHOHyVRIpig/DfX7Qsyjxx37jRmTcfsjOIQuBv2ri
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN1PR02MB167C999378A6AA4C87C702AB8770@BN1PR02MB167.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN1PR02MB167;BCL:0;PCL:0;RULEID:;SRVR:BN1PR02MB167;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB167;4:ZGKXMJXdUuOfM8JEthWQhXKdlS+NFahdIqeDYWBywGOCQPq7z8Yc+4Q+OdW/hElkz/QVF1eJYXqXpJBd8PanqdFpbIsFD0OTQwzE6u2dVgYKqpFRNlWHEF6Hd5KI2PwmgijGje4vDSqKwxyIJDLW+K//O4dc1ucHFpFoEGE5FQhb8m546GWiyqVWTPsEVbGVymrtHrhK8qqoYt/D8qibgVxBUBO2z+IiZ9hrKoW1UNbaYVqHQ2LyRKTK3dDdhFLix6rVbD3CE11taFHkpEVBz0ep8yfWISNfR+NFtUgtxqDHyDQ1/pavKsfEMmOkB3dyE+mRHHIJTy+s/dYKXHODqQ==
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR02MB167;23:BSNlsY4xBdaa0/KW5hO/MKlhkCfR50NPv5n/88lYzB?=
 =?us-ascii?Q?iFFYFYFTpF24znLQ7ho5ywtyZ5vXeivNRAauaKeLcUSlZKe7xxXeNFz/Q6NT?=
 =?us-ascii?Q?sylafycWYGpfEkNLiu9KXcnvS4/C5uZbVXzaLYmXEwLj+3ScLRCFSdzAkn7j?=
 =?us-ascii?Q?VpBbtt1WcjDaa5ucwQUPRauM0ew++6sAqazcrC8CmsQUuh+tGciLz6bLpaKk?=
 =?us-ascii?Q?FiNrP42HsMoF7xveLx8ty22giqGOUoEXNQxXOCkmqsDtZODB/nYKmQD/DvPf?=
 =?us-ascii?Q?t6Z0Q6cctGHjkyJu60YuialBsFVSo7UsdifeWAM9eKIV0L1KCUCvVQt68TGh?=
 =?us-ascii?Q?XhVBUaVhfvqa0Z0t7SrPQ45rR0h19WkarSSbvhb4iBjaxa9HWqGBH26xZSNx?=
 =?us-ascii?Q?MeESCjZJBuEXWsHJzHnD20Mk9Mjntw9XIRU2QWQKitsEWWrCEBhBanv3ZsSk?=
 =?us-ascii?Q?mDdMNDb2n4tBPUv0I8uJfyGO0cpDB2gc2n19QZ5WD5ARpwemlj7CdGOg+GOF?=
 =?us-ascii?Q?fmr/HQSLzwZfsI8zQ8w6XOA/oRtaoN36KwCnRjaJvuZbEv4BYf8UqavHO2q7?=
 =?us-ascii?Q?tU+5s+P0u9Ztg2k8sG5AVqyPLixlhIPIGV371vOoWxUsx+CGP3/QtZUkEAev?=
 =?us-ascii?Q?czI7Hf+FURMH1UicXx9HDPH9NsBBeax2Mgops+oTm2jxmUZx8h/YaRFqwgNH?=
 =?us-ascii?Q?NbJwFrcJkLHkaGR599TiFN8SKzLo6jx/4X2IXxQpVX+kK/zDrkj6m6Re8xRd?=
 =?us-ascii?Q?samNmf2bM0JDnEhICIocLLKj1S+3ZdKy+jhmutzDQORFeUFfhvm2nTnJamGV?=
 =?us-ascii?Q?kPYrzf1UHZ+EN7Y7PbC6SvM9QRsngyM0wQ/G4QYr9KSYn7gb9/oV9tR5Xqpx?=
 =?us-ascii?Q?Z8y6e+3/4Yw9rSpYaRqNq302sp5wb65SLCW0poTObHxSuwES5nRLxZPImExf?=
 =?us-ascii?Q?ZSI9hayUt82EbAPmeZMMo51hsiigjvS3ZIp3p3AAucTPrrI2EwATsKDVu8jG?=
 =?us-ascii?Q?nkcgt7ess8gZl4iHne1doEEErH11JGSIwUJnJuodRUTEMwEXkwvHSeHTOyMw?=
 =?us-ascii?Q?GexlhS4ny1f+WRtlHV0DeRSYRow+92TSgYYUcplkYXvF5PhgHbOIrLWJAn7L?=
 =?us-ascii?Q?0lQx/Hpp3X0rD2fKSimL6wk5Xq1E+saS7fadmQ0zwkoOi/lLMs6aSrmBfMXX?=
 =?us-ascii?Q?mWdRl6vKhtYb2dp2OI8Ah240J/0d6fr9xTrfgZi+6FeX3eAzPQQ5/Pqmc/4S?=
 =?us-ascii?Q?Ju6BRk/NN/9O3LlfTLjgGKLGcbdwBYu3MWvuCjXvUbbQcLD7iXZl1XCp81YQ?=
 =?us-ascii?Q?QYmFgeLPMEJeha4m+ar+VBRdLAtBynCi8XRamhcpbBYZH02JziGa8x0y+/wC?=
 =?us-ascii?Q?28Sg0yFi5qL4+uiUl6/FX1B8136vzheDf24dt0nnSSWDPBdPhVH3rUbjCrca?=
 =?us-ascii?Q?rGdo+okg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 1iGQ2WGRn7uj7n7at2U90W+RTRB6+Jf4DDGKzmK3mVK7slncWXasq3BSaLRPeh5+mU//oQuewQA2sLweyPjRFlRBM76Eh4qOWtCxiWVE40KToa80ANIzk7G4uFl3GGdDyDDKwCmJNYuvVsqZJoUyJB52q4U9UxvtDGxJl5h9nGauOmlSoXM+/YlIzzRjHUrk7K20oDVsuiRCJHolPIXF0cNMcaGfTNOdjVzyEMAnMXX7oqxO0hPWXB2Swk+rd/M/8rw3eBLllyN2j+euXP36nHYNnjTUdJcg+w2rkTZiwKb8T7VWaHigbWEmjH/BdTM5
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB167;6:cbj8sXkiSd6KroBl2zxNT4aE8U4mqLwQTq7Y6mYtvue89tmaXaj1kLpApQvDct5y45UZ8wac8FC+UcFq1B545wKwsnltwSHa4oB12FgScn3UkiwmMa9cE+GzfnM8dAMxuIJ6RfSF2HwIKebWCYeDuoiQjVFlXM40O3JZ97422V7Xxwjo5gg2Ab16JSgF7LVexMmKxlPZc0CBEVxAA9S/dmXn+ozhOuGVlCyW5x0QDgFdxNVCMsGTKqFtftJJTRTtdYKelLr8p6EX6m3OSbcq7urbRv4cXpD/Q5zvkzxL/R3iE98DVWBgbXNY+SdmLqQ62aMRdu/fJe//P9Y+TpP4yqfu4EHTwfvDf1vIJhz8Iexy1us6ares8k6xvY5tS8fYLKBNqCieaQmzQWwHFGb23u69vkBVvFErIwfmOxmzPyqJ1mWWky7XVIMck9sjqmqEyAyI+pz2vaydKvmyOgbGGA==;5:uATarSXQu4eVh+6hcjtbf5KvK9Shu0GuTUO7dkebuyvqrsUFaSt3wwu7Gv8VGxuWCEwO7K5HXZBrA8U9ImiOmRoCnERMuCevN7BQ9oT4d0ziCKIsivwHOGIEaXQapaM87hiRuYZ6+SKBMe7BkfIRtPA56jbBuY2OhvAdiOd8kpU=;24:z/UDPUBgOTgeppdFSQn8vA6xw6d/WcuxgkCegQu0YloeYS3vnaYmvBt9Q6NXDJb34El1HiKPb1C1rO+vVD7d6wzO2+CU7N0l9xJulQONSzk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN1PR02MB167;7:fgjO16S8xeG9t9nqZFfbZEJeVfuWcrwxDPN2odwgvo+TuTZyHwjtFcB3VMBSGLKIEfbbkIkpCZtxMd0Ex6vHEWOB7gSO/7lXWAzRAuNzp3f42xvBO++YDh3j8SLcZ2cOqKHelaJLP/iqDQwylhj//dCh2ZT9H053m6pzslebZi5xA0X/n0JOK7c5EXbJ6ezvDqJ30ddS8S/2XOlzDV2UzQ00WFHEHO3K8a2LTpJOezU9LDu9zshUQuEar02+hdtC
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:56.7996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4863ce9-b2ec-4d3d-b370-08d5d6d4fabb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR02MB167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Firmware-debug provides debugfs interface to all APIs.
Debugfs can be used to call firmware APIs with required
parameters.

Usage:
* Calling firmware API through debugfs:
  # echo "<api-name> <arg1> .. <argn>" > /sys/.../zynqmp-firmware/pm

* Read output of last called firmware API:
  # cat /sys/.../zynqmp-firmware/pm

Refer ug1200 for more information on these APIs:
  * https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

Add basic debugfs file to get API version.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/Kconfig        |   7 ++
 drivers/firmware/xilinx/Makefile       |   1 +
 drivers/firmware/xilinx/zynqmp-debug.c | 212 +++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h |  22 ++++
 drivers/firmware/xilinx/zynqmp.c       |   9 ++
 5 files changed, 251 insertions(+)
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h

diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
index 64d976e..8f44b9c 100644
--- a/drivers/firmware/xilinx/Kconfig
+++ b/drivers/firmware/xilinx/Kconfig
@@ -13,4 +13,11 @@ config ZYNQMP_FIRMWARE
 	  Say yes to enable ZynqMP firmware interface driver.
 	  If in doubt, say N.
 
+config ZYNQMP_FIRMWARE_DEBUG
+	bool "Enable Xilinx Zynq MPSoC firmware debug APIs"
+	depends on ZYNQMP_FIRMWARE && DEBUG_FS
+	help
+	  Say yes to enable ZynqMP firmware interface debug APIs.
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
index 29f7bf2..875a537 100644
--- a/drivers/firmware/xilinx/Makefile
+++ b/drivers/firmware/xilinx/Makefile
@@ -2,3 +2,4 @@
 # Makefile for Xilinx firmwares
 
 obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE_DEBUG) += zynqmp-debug.o
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
new file mode 100644
index 0000000..4800366
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer for debugfs APIs
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
+
+#define PM_API_NAME_LEN			50
+
+struct pm_api_info {
+	u32 api_id;
+	char api_name[PM_API_NAME_LEN];
+	char api_name_len;
+};
+
+static char debugfs_buf[PAGE_SIZE];
+
+#define PM_API(id)		 {id, #id, strlen(#id)}
+static struct pm_api_info pm_api_list[] = {
+	PM_API(PM_GET_API_VERSION),
+};
+
+/**
+ * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
+ * @arg:	Entered PM-API argument in string format
+ *
+ * Return: Argument value in unsigned integer format on success
+ *	   0 otherwise
+ */
+static u64 zynqmp_pm_argument_value(char *arg)
+{
+	u64 value;
+
+	if (!arg)
+		return 0;
+
+	if (!kstrtou64(arg, 0, &value))
+		return value;
+
+	return 0;
+}
+
+/**
+ * get_pm_api_id() - Extract API-ID from a PM-API request
+ * @pm_api_req:		Entered PM-API argument in string format
+ * @pm_id:		API-ID
+ *
+ * Return: 0 on success else error code
+ */
+static int get_pm_api_id(char *pm_api_req, u32 *pm_id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pm_api_list) ; i++) {
+		if (!strncasecmp(pm_api_req, pm_api_list[i].api_name,
+				 pm_api_list[i].api_name_len)) {
+			*pm_id = pm_api_list[i].api_id;
+			break;
+		}
+	}
+
+	/* If no name was entered look for PM-API ID instead */
+	if (i == ARRAY_SIZE(pm_api_list) && kstrtouint(pm_api_req, 10, pm_id))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+	u32 pm_api_version;
+	int ret;
+
+	if (!eemi_ops)
+		return -ENXIO;
+
+	switch (pm_id) {
+	case PM_GET_API_VERSION:
+		ret = eemi_ops->get_api_version(&pm_api_version);
+		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
+			pm_api_version >> 16, pm_api_version & 0xffff);
+		break;
+	default:
+		sprintf(debugfs_buf, "Unsupported PM-API request\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_write() - debugfs write function
+ * @file:	User file structure
+ * @ptr:	User entered PM-API string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Used for triggering pm api functions by writing
+ * echo <pm_api_id>	> /sys/kernel/debug/zynqmp_pm/power or
+ * echo <pm_api_name>	> /sys/kernel/debug/zynqmp_pm/power
+ *
+ * Return: Number of bytes copied if PM-API request succeeds,
+ *	   the corresponding error code otherwise
+ */
+static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
+					   const char __user *ptr, size_t len,
+					   loff_t *off)
+{
+	char *kern_buff, *tmp_buff;
+	char *pm_api_req;
+	u32 pm_id = 0;
+	u64 pm_api_arg[4] = {0, 0, 0, 0};
+	/* Return values from PM APIs calls */
+	u32 pm_api_ret[4] = {0, 0, 0, 0};
+
+	int ret;
+	int i = 0;
+
+	strcpy(debugfs_buf, "");
+
+	if (*off != 0 || len == 0)
+		return -EINVAL;
+
+	kern_buff = kzalloc(len, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	tmp_buff = kern_buff;
+
+	ret = strncpy_from_user(kern_buff, ptr, len);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read the API name from a user request */
+	pm_api_req = strsep(&kern_buff, " ");
+
+	ret = get_pm_api_id(pm_api_req, &pm_id);
+	if (ret < 0)
+		goto err;
+
+	/* Read node_id and arguments from the PM-API request */
+	pm_api_req = strsep(&kern_buff, " ");
+	while ((i < ARRAY_SIZE(pm_api_arg)) && pm_api_req) {
+		pm_api_arg[i++] = zynqmp_pm_argument_value(pm_api_req);
+		pm_api_req = strsep(&kern_buff, " ");
+	}
+
+	ret = process_api_request(pm_id, pm_api_arg, pm_api_ret);
+
+err:
+	kfree(tmp_buff);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+/**
+ * zynqmp_pm_debugfs_api_read() - debugfs read function
+ * @file:	User file structure
+ * @ptr:	Requested pm_api_version string
+ * @len:	Length of the userspace buffer
+ * @off:	Offset within the file
+ *
+ * Return: Length of the version string on success
+ *	   else error code
+ */
+static ssize_t zynqmp_pm_debugfs_api_read(struct file *file, char __user *ptr,
+					  size_t len, loff_t *off)
+{
+	return simple_read_from_buffer(ptr, len, off, debugfs_buf,
+				       strlen(debugfs_buf));
+}
+
+/* Setup debugfs fops */
+static const struct file_operations fops_zynqmp_pm_dbgfs = {
+	.owner = THIS_MODULE,
+	.write = zynqmp_pm_debugfs_api_write,
+	.read = zynqmp_pm_debugfs_api_read,
+};
+
+/**
+ * zynqmp_pm_api_debugfs_init - Initialize debugfs interface
+ *
+ * Return:	None
+ */
+void zynqmp_pm_api_debugfs_init(void)
+{
+	struct dentry *root_dir;
+
+	/* Initialize debugfs interface */
+	root_dir = debugfs_create_dir("zynqmp-firmware", NULL);
+	debugfs_create_file("pm", 0660, root_dir, NULL,
+			    &fops_zynqmp_pm_dbgfs);
+}
diff --git a/drivers/firmware/xilinx/zynqmp-debug.h b/drivers/firmware/xilinx/zynqmp-debug.h
new file mode 100644
index 0000000..3303b37
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp-debug.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_DEBUG_H__
+#define __FIRMWARE_ZYNQMP_DEBUG_H__
+
+#if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE_DEBUG)
+void zynqmp_pm_api_debugfs_init(void);
+#else
+static inline void zynqmp_pm_api_debugfs_init(void) { }
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_DEBUG_H__ */
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index c764d6e..83d2699 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
+#include "zynqmp-debug.h"
 
 /**
  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
@@ -551,3 +552,11 @@ static int __init zynqmp_plat_init(void)
 	return ret;
 }
 early_initcall(zynqmp_plat_init);
+
+static int zynqmp_firmware_init(void)
+{
+	zynqmp_pm_api_debugfs_init();
+
+	return 0;
+}
+device_initcall(zynqmp_firmware_init);
-- 
2.7.4

