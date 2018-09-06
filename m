Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BADC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ABE204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hSCHFSvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4ABE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeIFTTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:19:12 -0400
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:48048
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729183AbeIFTTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNM3EhQSOAeLTSdOfJbQg637Svy0vHODfBmP6kOof0w=;
 b=hSCHFSvONaEdHsoBKQnoMWeCUfMOPwsizjeZtG5lBC2WO+AtX5g8rI0yqSgUhZoXncfirnCVizsbhohjF4LdSbF2AeLcpaOtKtS7bkNLCTzIzwoRRIkqLWf/jHc7VsSRKMEkCX1WPWNbdSozC9z3JJMIXJLuqoYHfar78eO1J9U=
Received: from BYAPR07CA0032.namprd07.prod.outlook.com (2603:10b6:a02:bc::45)
 by SN1PR07MB2175.namprd07.prod.outlook.com (2a01:111:e400:c455::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Thu, 6 Sep
 2018 14:42:57 +0000
Received: from BY2NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::204) by BYAPR07CA0032.outlook.office365.com
 (2603:10b6:a02:bc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.16 via Frontend
 Transport; Thu, 6 Sep 2018 14:42:56 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT045.mail.protection.outlook.com (10.152.100.182) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1143.1 via
 Frontend Transport; Thu, 6 Sep 2018 14:42:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w86Egrxc013012
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 6 Sep 2018 07:42:55 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Sep 2018 16:43:02 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 6 Sep 2018 16:43:02 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w86EgrGg026937;
        Thu, 6 Sep 2018 15:42:53 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w86EgrOG026929;
        Thu, 6 Sep 2018 15:42:53 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [RFC PATCH v2 2/2] phy: cadence: Add driver for Sierra PHY
Date:   Thu, 6 Sep 2018 15:42:51 +0100
Message-ID: <1536244971-26714-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(2980300002)(189003)(199004)(36092001)(50466002)(14444005)(2906002)(217873002)(36756003)(7636002)(305945005)(246002)(356003)(8676002)(51416003)(110136005)(42186006)(16586007)(316002)(48376002)(336012)(426003)(186003)(26826003)(26005)(478600001)(486006)(87636003)(8936002)(106466001)(50226002)(5660300001)(126002)(4326008)(2616005)(476003)(105596002)(107886003)(575784001)(47776003)(2201001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2175;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT045;1:TwLTmaLAvF50LnAXK+e37Wllef1X2fBn4PQkhTtPrzKBLfqMbYUfpgOZivCobdhTPP6G/QZauTIWaVK0aHyJ7xJlJl+Wzbw3nujBxfnX9EAPQX8//o9JGbJHMhaV/6WS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a418e3aa-8c6c-466b-69e6-08d6140708ff
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR07MB2175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;3:zA9Hp05t9/VeK2WLSL04DsSMsTto9rDEfuei9li2BIAn5i0V7MHSsjR6Liznr6p8yuJkm0l95xAyHcMKQV9ZzIBIUmFOd1h6+WlMadzZXkVCCicgiwaJFmu/LUtgFKeosRxYAEs12Tful6ml+Altb/Xm1mJiaaQ5IkkAEO03kTrSqt2NVtgaZPmCIknekdKyri768bq8jpWIkFvc8tPIfdx5ZnU7Zc+zT6iVopoyzOLXQzj3SIrWBNQddCRy8SacmqfkQCyZEK7vWCCetkGXQNy8MTIeBhpoV0Oit/qjTRGXVMtuNg9FduPMNHFHpK+f3i2BhXcANmNy8kBP105WVLwe6M1WUU/4MulMk4awW2U=;25:SSoQlCLPvhyiEThNyTAuW0Bm/oKmw3HijL02JWbDKRn8dHrdjOaGqMGq9Gq9R70tr2jn3LjWG5jnPRkp/5wimB0dYU8xlKE7pHDql3pbLUF7c1ILV2Kzzqv98ohZEpYmgcBk/iFCTvULa3utx6olNXpG0JatjEta/qFpMKNIljMrOnU6o9buxA0em6AE6WwRRk+/gPe5T+2VDk4InRZLyj6xXXzeB86fN5DK1FCjT45/MpC1gPosJCjdEht+7zFE4/bNdEiuls3ouCAWQqwL5vVcuymZVe4xYttLC3PdKtbKvczAV6MPmAWsfEGPoE7+XHKFn3FNld8XsHnxLDy2Fg==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;31:63hxUEJbxLQuiLBeXYFbVAVdv4wV+Jo67GQWasj3eEzoXLctIgtAePMss25JLV2rSDzPCU3v1guN8h+ojFLSUpHe6HbiyB1VxY8sCaYcLFE/YW2NQZBqlWs2iKspNgg3SAbn8QvRDZOERBKjTci6QLSWa7o71zpRZGqxBqHiAy2eSYsMdDjwGrFSqMYRMdhmrbCWqORcT+TyQk++kksoNNgp0yGg9ikTD2CvVNmXeUw=;20:cWRqT8J3yHaUOWt91bFC1Ojr1zpsFUgaq/QWs8aJhDsBpjFWftGQk/T8i3zQ7qkR9huMImYpmsk6o7l0Ads/6Kbcqt3h5FLBrkWWJpwTmvM32iW1gabFYYu/KHV3LFtLT1/Rxeu63R+TXCpx2Tx79eCHWDbTQNVgOlhBVozwAcR2LWNPR358Jvz42I9C0j1Df2iV4UXDIE9y3ofKhoqfIOWM1ZBYCkHzbMv63eQh6F9I70oiY0kGyvYPEZwUj9JmnsDwpBw9mqMhacmDne9ChzcysZgDcI+W4l4g69bwMyU3QmHExsptOMbh3HswUdsS8Y8meSwUqmksLGaMuNLHfqtfMbzsEGBprqexzfJcKya1vFZ/d7jY6NNfekJgQzYEfoGZBb9frgHctcEbkvIB4TTAFEQrTDRUvwRg1mWBQXj87OEE0Jmuz9X7LPjwbdeyMc3JO88JK8mta9W2Hudfps7YmkhXLIsznt7KjHf9d6gDQ0nCREM9uIotv1z3/ITi
X-Microsoft-Antispam-PRVS: <SN1PR07MB2175AAF8FD01D3E86384B7ABD8010@SN1PR07MB2175.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93003095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN1PR07MB2175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;4:2wXclb+ZwzS2cv/AH5KdR5L+64NNzsxKxyElh6gS57mloKgmMxTXDZ8s5qrKmpyWhSfVeu3SMT3ShYvFY9yad0jeVls04S0qAMfkZv6wRV1ssHyW3MAf4/jgPVGZeZtFEy3ZkzyfEeYDo2j0SkDhNgomw7MO7+euypProMdyWZddOskaoM0ZlRK8l2SY4Gk/yahARgSL0yFdEu+i6yPxmjsAFZGqZdMn1SjhdJ/d4duJUp9Wmr2gWShPVQ/S+M65CjWF6Yp8nYR1MwRb9BqZghQ6xCKEEcfqVEk6B4Yfgpwo5Cuhl1EHrGgMCjPzfNVd
X-Forefront-PRVS: 0787459938
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2175;23:OszSkHkPqNt1GRO+gHiUbyovjVaIl+y6UWXy7SzGt?=
 =?us-ascii?Q?QCVEWVC93BvOL+LGzyUa5YbA44kxW0vCVTqlxRPo1YiWYzVp2HlEpJz7GmAz?=
 =?us-ascii?Q?OeuLL0yz/oDI6RVLG2k4DCGUR9cNsHN0lkX3oS3CgHocV3tjsKgbxvMaBzWu?=
 =?us-ascii?Q?f/5td5jFGB40Eko5+MbukmtUZsI31FvYAToj3Md7nH5rL2WOSOnYrs+KbdDT?=
 =?us-ascii?Q?OjmoIp2i8BgDhcEYojF4tTrPCWZaaFS3JCHOebWwl1XdB0B+2siWEyz9c6/1?=
 =?us-ascii?Q?70GOD2ESbwyWidUl8VlS3i79E17n72KYvq+sJjP8tpjLnDTY0hBMpIyx7kr+?=
 =?us-ascii?Q?hNKQtbNdYwc46aKOxFqJFL8JrPq8sDwipB+r0dzLt8Hohv233PIBvTVQ0rPJ?=
 =?us-ascii?Q?mZFGlKq28DszuYedK8B7Z2HRiqVfRhUMtvyqHKwpmr+TiRdH+Bonp0bkegu8?=
 =?us-ascii?Q?ze10vYknl1TW35742s83KhqDkxpZBehEwZliFOJqsdJFjFuAsoR3w0tKhq0I?=
 =?us-ascii?Q?Dtglv3Uz7PoMlu+vb6vYGVPWq8OY+nIpSgXfLL35AgjZik/WdX479eGKV8EP?=
 =?us-ascii?Q?vqa0lzhwEqloUchF40lXWAWvnDRHUa6FQLYulZ2JH3bDMAwSf5bbn/iP/Q84?=
 =?us-ascii?Q?zsP0Da97WLz3VQKZGvs+k0BxuH2PO0AlnlJVwZ7FUH6nEkd2yVLYVTNAEiF/?=
 =?us-ascii?Q?h0ZE1pUSq+KXb2vSfmbFbH6ca+HgGbODAWA3tEMiBH2Gp4qBNfwNgZliSuZN?=
 =?us-ascii?Q?Q5qnSuwXFBxXNq2wL6q5QJn+sBXs3xDMsgO6qxcTOrvem+G7jY24dMFEbAKT?=
 =?us-ascii?Q?q8byefK8mIntA43tq0EVfu1FnZCwHSqocxU52c/nV/9bTiLLPlf/VgEMamAf?=
 =?us-ascii?Q?B0soxm6/KCrIHn+m6RS2bx99mRMyuwhXo9OlGlrKwN6Blye8n9bawUxD0hjS?=
 =?us-ascii?Q?NYnVqynYHr7ndhrWIGwtdQZwM6krDpvQVfbf40gPLuKPXJXix1FltA+BA399?=
 =?us-ascii?Q?QN+QAWPXj+ucryTVZcMjNJEmcCdhxIN1cfQFn7R7FC5Zs+z7lF6aCOpFru/H?=
 =?us-ascii?Q?GFRS/0=3D?=
X-Microsoft-Antispam-Message-Info: e0m2Hn5zh3+Zu4Nz5hpcI9gT9joAznaC+8oFbH4atEbCfKQM3sSk60vF+ZILX5SOimSLEg0VoWnimdHyRsldMToZE+83QHcfAuTrnBiV/9CBfEF0f2VLRetKAu8xxvixFCQYuFIoO1qoxRZMqbCdatFs4S/aI5tG9bSKhOeXmPIK0VfnoygOLHIyunsLRHzjJFlgT7r5blSgwGN9FPdr3Opv/jg44wIdt/Ssz0Xk9YHzUNNO4+eftMcZtBEGkwFCI2tz+nKjnckN4soEGr9qjn7i0RVYq03v6EGY2VDtXyVSYq/jUj8sebHnyVcWJ8RzKoponmBAG6073F9Tj0uKOPoY4l7A6EcLaVYWq6yra0CCcE7Qp3oWghaEHprCIw39magEIY07s/+CBD+JjL6nEA==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;6:yncNOg8xVw8vRXsM7rUbpUGyX+dOSH+Utr6gouSN5cxXWCEn1p9hid3hlZbtX0ww6m/sZEpvysuhSJv6JYVOyAiW7Wsx0xnnQP/v0ksGALpfuyO8emCAMQ0SA5G3B54vLyuvjpH7cKnTZWuYryJ8CFpAfRrG866RoOewZkuJ5p6yKzvFtDmzOiX0FR/oK+Bp4umnPPMGI6fDrbfitk8AVyRiKupUxU66sBlz8m0aCUYtvPqkIIZXAIXfz/4hh3xJD4NwvwBX6btgEXbKyBI/ejqSVHJBQ8ca+GwDGLYJhswCR7jNDSudoGO5I5uC1my9zkG9yoav00j80SDIfJbb4uJJFCAnubbZglJQLqOOG2fj+wwyUWyl/kZs4ToaBI/YpFhUmUr98bW+Ttjp2Iw/s9Ns8HG4Y4EooU7W7fXU1qo9tIsJDqc9gFluByhJ8opAJSUUCInRsl/FwqkG2MMsDQ==;5:NfHkF2x++XaZPWWarcsHBM9pFjOHq430tfNNZhx2XJGpN6ohjQc2kbgs6+NbNi0GXwvY6jk6gbCOBJeHd/0TbXsLh0UJ/0rLppinseeUT6CTup8iWFeFQ5lPWaVYLVdSqBlD4gi+tLEHxWt5gBLx0N704loQWNHuFpMO2MfCNtg=;7:9ClyG3164edntzM0uSCgF/sMMk7hEvPiogeBmdlQq0U2Ryu12nDyx+p3sjsC9NFgsts6a1fvu599qrPRDAjer4JIZ0OHqsRvjKFgQkCBcwckHdu9/G0KQxxspFVS1O1BGhj2zv9ZTyRuWk5OHqCiyxepLgs4SjSfFicWwfsXXR2krBTqNrPFA8yPJl1hZeFTtklRvu2NbCzt/Ip1g0a1F5QpZNMeyV689zDSSnOxbFQCfXmal6qxvhvgzUNQ4ob6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2175;20:hLXCY5kmcn1LZjKhHkKeuMvZOi8AzFVKcYwZ+rq41yRKHDOfxJsaoEg1TAWt9p/nVfiZo32J5AYUji1rM9TDdl8Mh7kjTX3TakwwnhjP0TsXcKqtEEH8WJAeMPo3lehYZY5qyGH1JqP9fdMrYQ+GrZJNtYNczut7ZZiyfuqcUw2rPdKzASWlcApS3tMj1OlpHP8/gv9WfIqVeUDDGzYbJlRisb3ae2bUiWGJS8zX/uuQpifHmtiZintrrZTL2b1B
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 14:42:56.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a418e3aa-8c6c-466b-69e6-08d6140708ff
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Sierra PHY driver with PCIe and USB support.

The PHY has multiple lanes, which can be configured into
groups, and a generic PHY device is created for each group.

There are two resets controlling the overall PHY block, one
to enable the APB interface for programming registers, and
another to enable the PHY itself.  Additionally there are
resets for each PHY lane.

The PHY can be configured in hardware to read register
settings from ROM, or they can be written by the driver.

The sequence of operation on startup is to enable the APB
bus, write the PHY registers (if required)  for each lane
group, and then enable the PHY.  Each group of lanes
can then be individually controlled using the power_on()/
power_off() function for that generic PHY

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/phy/Kconfig               |   1 +
 drivers/phy/Makefile              |   1 +
 drivers/phy/cadence/Kconfig       |   9 +
 drivers/phy/cadence/Makefile      |   2 +
 drivers/phy/cadence/cdns-sierra.c | 385 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 398 insertions(+)
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/cdns-sierra.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8d452..cc47f85 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -43,6 +43,7 @@ config PHY_XGENE
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
+source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 84e3bd9..ba48acd 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= broadcom/	\
+					   cadence/	\
 					   hisilicon/	\
 					   marvell/	\
 					   motorola/	\
diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
new file mode 100644
index 0000000..098df0f
--- /dev/null
+++ b/drivers/phy/cadence/Kconfig
@@ -0,0 +1,9 @@
+#
+# Phy drivers for Cadence PHYs
+#
+config CDNS_SIERRA_PHY
+	tristate "Cadence Sierra PHY Driver"
+	depends on OF && HAS_IOMEM && RESET_CONTROLLER
+	select GENERIC_PHY
+	help
+	  Enable this to support the Cadence Sierra PHY driver
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
new file mode 100644
index 0000000..c396c69
--- /dev/null
+++ b/drivers/phy/cadence/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CDNS_SIERRA_PHY)		+= cdns-sierra.o
diff --git a/drivers/phy/cadence/cdns-sierra.c b/drivers/phy/cadence/cdns-sierra.c
new file mode 100644
index 0000000..83568b4
--- /dev/null
+++ b/drivers/phy/cadence/cdns-sierra.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence Sierra PHY Driver
+ *
+ * Copyright (c) 2018 Cadence Design Systems
+ * Author: Alan Douglas <adouglas@cadence.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/phy/phy.h>
+
+/* PHY register offsets */
+#define SIERRA_PHY_PLL_CFG		(0xc00e << 2)
+#define SIERRA_DET_STANDEC_A		(0x4000 << 2)
+#define SIERRA_DET_STANDEC_B		(0x4001 << 2)
+#define SIERRA_DET_STANDEC_C		(0x4002 << 2)
+#define SIERRA_DET_STANDEC_D		(0x4003 << 2)
+#define SIERRA_DET_STANDEC_E		(0x4004 << 2)
+#define SIERRA_PSM_LANECAL		(0x4008 << 2)
+#define SIERRA_PSM_DIAG			(0x4015 << 2)
+#define SIERRA_PSC_TX_A0		(0x4028 << 2)
+#define SIERRA_PSC_TX_A1		(0x4029 << 2)
+#define SIERRA_PSC_TX_A2		(0x402A << 2)
+#define SIERRA_PSC_TX_A3		(0x402B << 2)
+#define SIERRA_PSC_RX_A0		(0x4030 << 2)
+#define SIERRA_PSC_RX_A1		(0x4031 << 2)
+#define SIERRA_PSC_RX_A2		(0x4032 << 2)
+#define SIERRA_PSC_RX_A3		(0x4033 << 2)
+#define SIERRA_PLLCTRL_SUBRATE		(0x403A << 2)
+#define SIERRA_PLLCTRL_GEN_D		(0x403E << 2)
+#define SIERRA_DRVCTRL_ATTEN		(0x406A << 2)
+#define SIERRA_CLKPATHCTRL_TMR		(0x4081 << 2)
+#define SIERRA_RX_CREQ_FLTR_A_MODE1	(0x4087 << 2)
+#define SIERRA_RX_CREQ_FLTR_A_MODE0	(0x4088 << 2)
+#define SIERRA_CREQ_CCLKDET_MODE01	(0x408E << 2)
+#define SIERRA_RX_CTLE_MAINTENANCE	(0x4091 << 2)
+#define SIERRA_CREQ_FSMCLK_SEL		(0x4092 << 2)
+#define SIERRA_CTLELUT_CTRL		(0x4098 << 2)
+#define SIERRA_DFE_ECMP_RATESEL		(0x40C0 << 2)
+#define SIERRA_DFE_SMP_RATESEL		(0x40C1 << 2)
+#define SIERRA_DEQ_VGATUNE_CTRL		(0x40E1 << 2)
+#define SIERRA_TMRVAL_MODE3		(0x416E << 2)
+#define SIERRA_TMRVAL_MODE2		(0x416F << 2)
+#define SIERRA_TMRVAL_MODE1		(0x4170 << 2)
+#define SIERRA_TMRVAL_MODE0		(0x4171 << 2)
+#define SIERRA_PICNT_MODE1		(0x4174 << 2)
+#define SIERRA_CPI_OUTBUF_RATESEL	(0x417C << 2)
+#define SIERRA_LFPSFILT_NS		(0x418A << 2)
+#define SIERRA_LFPSFILT_RD		(0x418B << 2)
+#define SIERRA_LFPSFILT_MP		(0x418C << 2)
+#define SIERRA_SDFILT_H2L_A		(0x4191 << 2)
+
+#define SIERRA_MACRO_ID			0x00007364
+#define SIERRA_MAX_LANES		4
+
+struct cdns_sierra_inst {
+	struct phy *phy;
+	u32 phy_type;
+	u32 num_lanes;
+	u32 mlane;
+	struct reset_control *lnk_rst;
+};
+
+struct cdns_reg_pairs {
+	u16 val;
+	u32 off;
+};
+
+struct cdns_sierra_data {
+		u32 id_value;
+		u32 pcie_regs;
+		u32 usb_regs;
+		struct cdns_reg_pairs *pcie_vals;
+		struct cdns_reg_pairs  *usb_vals;
+};
+
+struct cdns_sierra_phy {
+	struct device *dev;
+	void __iomem *base;
+	struct cdns_sierra_data *init_data;
+	struct cdns_sierra_inst phys[SIERRA_MAX_LANES];
+	struct reset_control *phy_rst;
+	struct reset_control *apb_rst;
+	struct clk *clk;
+	struct phy *pcie_phy;
+	bool autoconf;
+};
+
+static void cdns_sierra_phy_init(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
+	int i, j;
+	struct cdns_reg_pairs *vals;
+	u32 num_regs;
+
+	if (ins->phy_type == PHY_TYPE_PCIE) {
+		num_regs = phy->init_data->pcie_regs;
+		vals = phy->init_data->pcie_vals;
+	} else if (ins->phy_type == PHY_TYPE_USB3) {
+		num_regs = phy->init_data->usb_regs;
+		vals = phy->init_data->usb_vals;
+	} else {
+		return;
+	}
+	for (i = 0; i < ins->num_lanes; i++)
+		for (j = 0; j < num_regs ; j++)
+			writel(vals[j].val, phy->base +
+				vals[j].off + (i + ins->mlane) * 0x800);
+}
+
+static int cdns_sierra_phy_on(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+	int ret;
+
+	/* Take the PHY out of reset */
+	ret = reset_control_deassert(ins->lnk_rst);
+
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int cdns_sierra_phy_off(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+
+	reset_control_assert(ins->lnk_rst);
+
+	return 0;
+}
+
+static const struct phy_ops ops = {
+	.power_on	= cdns_sierra_phy_on,
+	.power_off	= cdns_sierra_phy_off,
+	.owner		= THIS_MODULE,
+};
+
+static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
+				    struct device_node *child)
+{
+	if (of_property_read_u32(child, "reg", &inst->mlane))
+		return -EINVAL;
+
+	if (of_property_read_u32(child, "cdns,num-lanes", &inst->num_lanes))
+		return -EINVAL;
+
+	if (of_property_read_u32(child, "cdns,phy-type", &inst->phy_type))
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct of_device_id cdns_sierra_id_table[];
+
+static int cdns_sierra_phy_probe(struct platform_device *pdev)
+{
+	struct cdns_sierra_phy *sp;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct resource *res;
+	int ret, node = 0;
+	struct device_node *dn = dev->of_node, *child;
+
+	if (of_get_child_count(dn) == 0)
+		return -ENODEV;
+
+	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
+	if (!sp)
+		return -ENOMEM;
+	dev_set_drvdata(dev, sp);
+	sp->dev = dev;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
+	sp->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(sp->base)) {
+		dev_err(dev, "missing \"reg\"\n");
+		return PTR_ERR(sp->base);
+	}
+
+	/* Get init data for this PHY */
+	match = of_match_device(cdns_sierra_id_table, dev);
+	if (!match)
+		return -EINVAL;
+	sp->init_data = (struct cdns_sierra_data *)match->data;
+
+	platform_set_drvdata(pdev, sp);
+
+	sp->clk = devm_clk_get(dev, "phy_clk");
+	if (IS_ERR(sp->clk)) {
+		dev_err(dev, "failed to get clock phy_clk\n");
+		return PTR_ERR(sp->clk);
+	}
+
+	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
+	if (IS_ERR(sp->phy_rst)) {
+		dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(sp->phy_rst);
+	}
+
+	sp->apb_rst = devm_reset_control_get(dev, "sierra_apb");
+	if (IS_ERR(sp->apb_rst)) {
+		dev_err(dev, "failed to get apb reset\n");
+		return PTR_ERR(sp->apb_rst);
+	}
+
+	ret = clk_prepare_enable(sp->clk);
+	if (ret)
+		return ret;
+
+	/* Enable APB */
+	reset_control_deassert(sp->apb_rst);
+
+	/* Check that PHY is present */
+	if  (sp->init_data->id_value != readl(sp->base)) {
+		goto clk_disable;
+		return -EINVAL;
+	}
+
+	sp->autoconf = of_property_read_bool(dn, "cdns,autoconf");
+
+	for_each_available_child_of_node(dn, child) {
+		struct phy *gphy;
+
+		if (IS_ERR(sp->phys[node].lnk_rst)) {
+			dev_err(dev, "failed to get reset %s\n", child->name);
+			return PTR_ERR(sp->phys[node].lnk_rst);
+		}
+		sp->phys[node].lnk_rst =
+				devm_reset_control_get(dev, child->name);
+
+		if (!sp->autoconf) {
+			ret = cdns_sierra_get_optional(&sp->phys[node], child);
+			if (ret) {
+				dev_err(dev, "missing property in node %s\n",
+					child->name);
+				goto put_child;
+			}
+		}
+
+		gphy = devm_phy_create(dev, child, &ops);
+
+		if (IS_ERR(gphy)) {
+			ret = PTR_ERR(gphy);
+			goto put_child;
+		}
+		sp->phys[node].phy = gphy;
+		phy_set_drvdata(gphy, &sp->phys[node]);
+
+		/* Initialise the PHY registers, unless auto configured */
+		if (!sp->autoconf)
+			cdns_sierra_phy_init(gphy);
+
+		node++;
+	}
+
+	/* If more than one subnode, configure the PHY as multilink */
+	if (!sp->autoconf && of_get_child_count(dn) > 1)
+		writel(2, sp->base + SIERRA_PHY_PLL_CFG);
+
+	pm_runtime_enable(dev);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	reset_control_deassert(sp->phy_rst);
+	return PTR_ERR_OR_ZERO(phy_provider);
+put_child:
+	of_node_put(child);
+clk_disable:
+	clk_disable_unprepare(sp->clk);
+	reset_control_assert(sp->apb_rst);
+	return ret;
+}
+
+static int cdns_sierra_phy_remove(struct platform_device *pdev)
+{
+	struct cdns_sierra_phy *phy = dev_get_drvdata(pdev->dev.parent);
+
+	reset_control_assert(phy->phy_rst);
+	reset_control_assert(phy->apb_rst);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static struct cdns_reg_pairs cdns_usb_regs[] = {
+	/*
+	 * Write USB configuration parameters to the PHY.
+	 * These values are specific to this specific hardware
+	 * configuration.
+	 */
+	{0xFE0A, SIERRA_DET_STANDEC_A},
+	{0x000F, SIERRA_DET_STANDEC_B},
+	{0x55A5, SIERRA_DET_STANDEC_C},
+	{0x69AD, SIERRA_DET_STANDEC_D},
+	{0x0241, SIERRA_DET_STANDEC_E},
+	{0x0110, SIERRA_PSM_LANECAL},
+	{0xCF00, SIERRA_PSM_DIAG},
+	{0x001F, SIERRA_PSC_TX_A0},
+	{0x0007, SIERRA_PSC_TX_A1},
+	{0x0003, SIERRA_PSC_TX_A2},
+	{0x0003, SIERRA_PSC_TX_A3},
+	{0x0FFF, SIERRA_PSC_RX_A0},
+	{0x0003, SIERRA_PSC_RX_A1},
+	{0x0003, SIERRA_PSC_RX_A2},
+	{0x0001, SIERRA_PSC_RX_A3},
+	{0x0001, SIERRA_PLLCTRL_SUBRATE},
+	{0x0406, SIERRA_PLLCTRL_GEN_D},
+	{0x0000, SIERRA_DRVCTRL_ATTEN},
+	{0x823E, SIERRA_CLKPATHCTRL_TMR},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0},
+	{0x7B3C, SIERRA_CREQ_CCLKDET_MODE01},
+	{0x023C, SIERRA_RX_CTLE_MAINTENANCE},
+	{0x3232, SIERRA_CREQ_FSMCLK_SEL},
+	{0x8452, SIERRA_CTLELUT_CTRL},
+	{0x4121, SIERRA_DFE_ECMP_RATESEL},
+	{0x4121, SIERRA_DFE_SMP_RATESEL},
+	{0x9999, SIERRA_DEQ_VGATUNE_CTRL},
+	{0x0330, SIERRA_TMRVAL_MODE0},
+	{0x01FF, SIERRA_PICNT_MODE1},
+	{0x0009, SIERRA_CPI_OUTBUF_RATESEL},
+	{0x000F, SIERRA_LFPSFILT_NS},
+	{0x0009, SIERRA_LFPSFILT_RD},
+	{0x0001, SIERRA_LFPSFILT_MP},
+	{0x8013, SIERRA_SDFILT_H2L_A},
+	{0x0400, SIERRA_TMRVAL_MODE1},
+};
+
+static struct cdns_reg_pairs cdns_pcie_regs[] = {
+	/*
+	 * Write PCIe configuration parameters to the PHY.
+	 * These values are specific to this specific hardware
+	 * configuration.
+	 */
+	{0x891f, SIERRA_DET_STANDEC_D},
+	{0x0053, SIERRA_DET_STANDEC_E},
+	{0x0400, SIERRA_TMRVAL_MODE2},
+	{0x0200, SIERRA_TMRVAL_MODE3},
+};
+
+static const struct cdns_sierra_data cdns_map_sierra = {
+	SIERRA_MACRO_ID,
+	ARRAY_SIZE(cdns_pcie_regs),
+	ARRAY_SIZE(cdns_usb_regs),
+	cdns_pcie_regs,
+	cdns_usb_regs
+};
+
+static const struct of_device_id cdns_sierra_id_table[] = {
+	{
+		.compatible = "cdns,sierra-phy-t0",
+		.data = &cdns_map_sierra,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cdns_sierra_id_table);
+
+static struct platform_driver cdns_sierra_driver = {
+	.probe		= cdns_sierra_phy_probe,
+	.remove		= cdns_sierra_phy_remove,
+	.driver		= {
+		.name	= "cdns-sierra-phy",
+		.of_match_table = cdns_sierra_id_table,
+	},
+};
+module_platform_driver(cdns_sierra_driver);
+
+MODULE_ALIAS("platform:cdns_sierra");
+MODULE_AUTHOR("Cadence Design Systems");
+MODULE_DESCRIPTION("CDNS sierra phy driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.0

