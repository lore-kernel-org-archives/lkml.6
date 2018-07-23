Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695ECECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39E820856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nd9fNPuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39E820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbeGWQEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:04:10 -0400
Received: from mail-sn1nam01on0083.outbound.protection.outlook.com ([104.47.32.83]:58400
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388406AbeGWQEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g19W8PQ68DIBTNKR/Ck3+nnZEpSZ+O0mEgpiFVptDO0=;
 b=nd9fNPuw7+dnzEZvwKh137Qw6ityNLj8oRggcHS5EF1d9Z4AuNadvLuyb6Lhww5tuOQRWMIsqmFYp2T6oDp59tmUdqb6uLI8rZDUpIWcA8KobYwqWGY2m0NXozys1pOiqkRvanXXqVO3jYczSJ8z5xM/kOxr3F/YNn2tF0ZCPq8=
Received: from MWHPR0201CA0103.namprd02.prod.outlook.com
 (2603:10b6:301:75::44) by SN1PR02MB1631.namprd02.prod.outlook.com
 (2a01:111:e400:519f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 15:02:28 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR0201CA0103.outlook.office365.com
 (2603:10b6:301:75::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.20 via Frontend
 Transport; Mon, 23 Jul 2018 15:02:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Mon, 23 Jul 2018 15:02:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcLy-0001B9-9e; Mon, 23 Jul 2018 08:02:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcLt-0008VL-67; Mon, 23 Jul 2018 08:02:21 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6NF2IEc013273;
        Mon, 23 Jul 2018 08:02:18 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fhcLq-0008UV-CO; Mon, 23 Jul 2018 08:02:18 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 82E01121473; Mon, 23 Jul 2018 20:32:17 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <manish.narani@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <jic23@kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 1/4] iio: adc: xilinx: Check for return values in clk related functions
Date:   Mon, 23 Jul 2018 20:32:00 +0530
Message-ID: <1532358123-23485-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(106466001)(2616005)(486006)(16586007)(476003)(42186006)(4326008)(103686004)(11346002)(106002)(316002)(5660300001)(48376002)(14444005)(63266004)(81156014)(8936002)(44832011)(51416003)(81166006)(6266002)(54906003)(52956003)(36756003)(2906002)(186003)(356003)(90966002)(305945005)(47776003)(426003)(478600001)(2201001)(36386004)(446003)(50226002)(76176011)(26005)(72206003)(50466002)(110136005)(8676002)(126002)(6666003)(336012)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1631;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT042;1:nkoAttzkloz9ixfib3sypRo0Y2GlDHhMtxAZCw0pp/e772ukG9kHiMR/DOjp94jULki/ibQyu+7LsO3UHHoBPakjFbJ1fnn5m6kyYU6nlIXrBTN/cijvRAMj7EfiIods
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f803ba1-93c3-4ea3-931d-08d5f0ad4dfd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR02MB1631;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1631;3:DztnGpKVakLq2x59SRKtFlZVK6mf+SizZ0rCZQgSBGe6fMdOp/5inCtLqdpE8L3ATroGV5PtKvr3rWWFjkWfqWfEcArhOFHOHPyITzHVzfk2otSfY7UaY7Ex6k5gSS6/A9+VJpCK4dIEM6nvyTQ3aUPBIYcgbbeMtXLWB275PcMjEEeO17NFUDDFh0K6hnXGLEyFX8TMDuDMRgcO8OrBCpZnElhGIfPYLRiDsYC+OcT9S45ijlm1LJQwFF/CQCHvdQP5kxDn+jaa3/B/19egwk9aI54RnPDSYkTPn9rcPg9pbj2JRmaiZ/8A8fR6iuDVNVDyYeF2vTmn+FfPkMMa2XuBbDylvO7tug7KR/TTZ78=;25:y3BulFPr1Wj2UiUzIcQErZoxZrBS2JCAA41F739BiH6AkWEbhrVOlcclEtHChNLo7GCNNiZTWAwyPflNsrdqeIZ2fgTQYbgxR7y8h6pc0/oCHoI5144DHOiYLtbh35at7shWS9L6PKWue6RWiexEaaa+MI6l1OzNKTV1oJDtCA1D32++Yu0vir0ZmMVJXsR1/Hsh2qdv4yQCJPcKSFANQkJIsJc6hpZ2g8HfWoYLsK5vH9VMW+ajHT9NCmctGVErSUK9u+r2MVKBs8aZW57/CU5Gu7x/nThEs32YnUDmNTVPowLvCjj872D/zMASvIDKDoIrEegK80Jwf3G2LtqJgw==
X-MS-TrafficTypeDiagnostic: SN1PR02MB1631:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1631;31:hVADJLpYA+euj5IMpWkY1KfaYv2pwO1mAwJSOU/CtGTmBeWHS2LqVD0epfQJ8fO6p5KE+ZKdRyND8AgDqVbrLOwoQFTOzfLLhFBKWmeZ+PTUbdzWPxlO6qK73TkPxCBLMEMH/z864N5q+A2C5cRtduGwRfUi4ke/Y9BF5sQoscb4e1jfGASI0kUf3l1AnNDSoLZofgz9mZSTpnDKNXwpAszh22gq22pWNlkWlX4K60c=;20:D4grhq0wQTcJWz3QQxopKWR2Rg9HVlmmyaREns0lGpRBA/vHIiR4Igw2k1HcEWOrSd+0OktXyq8hnJGDgv46X77Ma7FwB6NL73lnWE207q/ieShATTQUalYlQInJHviCWKtYWRDbjSghi4qRQuqRQpD7+MtssTzfzulS7OeUBTQr5Q8YNr+kVlTy2cH4YDgcJsXKmDR8AtLqiS4ZxbadeGbUNIgOS1yuGg8ApT9ueF5C4WN92D71+Ujr8SOBp6xS+Md/EE+EDZ0J4WKIpxwQ8D/6Z1jabzFb3sBU1TeE7OaS+TIt6ldJ2QfeVT78957opTi7Y0FreesJleJlDtoPh4gIAqBu7oLhoLDA7ealVaz+myTUbS6VM3yN3KrXqrrMteutBDh05RUo+2NZPNWmOFGTxJ6DlfndzLcb3BFi8MNkaKEaIDG+i4mm6I/B450OciwwWRjdt8hupdys9zZEkLJkOTkUw3H4ajY9c9bo0VyfSg2A9HIq9PBkJ/5uMnNX
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB1631495CC62007EF6E9FBAE5C1560@SN1PR02MB1631.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB1631;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1631;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1631;4:NRdXs9RsDNNJ9W5y0K4esFjt9dyNZykUnc5LBPDIwl8/tDk/BTdCaazdEIbVYH/6LFU0bIOMKT4MifE3Y3n5RQPIBcer2g9zBLD1DFztvqtshDIW2qOwzpCQE4r5a1ctYMC9AGECr+fz4LG8hFwkXnrTi63xuLqBstaFSWItctS1MLmFwF41+5PvFFRJVeIpb8HASuFzSP20DiNwynxrwenr8bvPn7sT4JV+p34LvjgfdQZsSqNNrN01JdByP1zYYzFZpllsYaS1gOE8HHfcx5sLF6yeZ3vlxLgBVv5wDLgfon8N6CL6BLbnf2BsrC1P
X-Forefront-PRVS: 0742443479
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1631;23:qydPEjWLfFzkuXf4xzTotuLtnSnf8KyBkUShqSuX7?=
 =?us-ascii?Q?zp4SRMAx4pywzKW5ZRhkbQT9CiIS7WQsQo/gzho5UFuUscEESTsm3JPhSpNX?=
 =?us-ascii?Q?5bPq5y7tiilGS1Mf2F1Tte3xWB1NdgMegLXB0hTtgvnKACHpRjKsEtSi1rPt?=
 =?us-ascii?Q?d0q2D7dlheDNJgYkRuMKTRdTYX94tPFWOzC8Fnt+ECbfnaxi39EG1bUa/l6o?=
 =?us-ascii?Q?tr2Z7SF9z7owKszfCCMSiVtPBJhhy3oDfCQsApPyE/t0OOHNIruRiqHJJdC+?=
 =?us-ascii?Q?YoT+lJ7LmAAkJ2ru0EvMuKFdUj0Z5mcsvwev77lqxjnpiu2ZOT8LlJRNDDnx?=
 =?us-ascii?Q?VouepHmr9DiLhtFGHJGfNKoYrFOLBP7EKQCjClSjxJS2EKalHvI3s5aoMcD9?=
 =?us-ascii?Q?W1gQSoPcJmGfeAghfSBS2oQl42lTzr3fYc9d25KAVsNEnVdvmpdGoAa/rYYk?=
 =?us-ascii?Q?FQmPsXtM01tdk/Myj4wZ6C6rrHOh5O3niOCp1zAjNRJ+ew1sSDSqd9SD93yi?=
 =?us-ascii?Q?KxkLm/trHoFKahl1wfRbtMPtd6CaYa4PpVTa3YatLMDbytrnM2YwkdFhLc6l?=
 =?us-ascii?Q?2besvFTiv4OaZpbRPNyJR6emXLgZoZ2o12ETEeUl2VWoLbFVzj51H66xkoxP?=
 =?us-ascii?Q?c1RZ5ST8mLioxHPIMMWvbDosT+TUvaelqYa/A86Ycu61YV3gsPmTCvxyWJv3?=
 =?us-ascii?Q?6Os+p/kLaM6ss4OD8PKppJ3Dr88rYMBFU+NDJl/EEDJ59WNGXjWeYNXBd/YM?=
 =?us-ascii?Q?DwDZaOIfJS6r9JiIzXyMzanoXDsBf3wszXY7xRYVBUGUM3Zy8MfPnlgAQKUZ?=
 =?us-ascii?Q?ZcGgGLlL+H2ApU1fBCagpc0FQ1zYAkOKxugzaLDe1vKBJcwGSbg6WvZR7SjU?=
 =?us-ascii?Q?2YoltLeTYM+P7/t/jVtMAXET1w7YPJJKKDHaYUo/EI/oN96VrgQ+uT0NtkYR?=
 =?us-ascii?Q?FrIbEH66G9k63RX/U/Mref2hcNiLC7NCS/1QSSnytjOQDMRTRrM+S+JyIjvR?=
 =?us-ascii?Q?khMPkV4LiPi8mFDDSFj0pldHYbiJOeneIWxoA7x4/ix+uoRI4Gvas8ZJMU1x?=
 =?us-ascii?Q?8Q4ymQSY+7neNXEs+8zhLKtB4hxIHyyHJWSbgfemnFJY1v8alR18FPlTSfFF?=
 =?us-ascii?Q?tC4yX+G58KpAjDzoWeVeOP013TIXtnnNSylD4lWHVvmHWvpwpC3pbsat3P5S?=
 =?us-ascii?Q?5kKgHigtRdW+tQgu+yVcjQyJQ6GXlmDYpGV?=
X-Microsoft-Antispam-Message-Info: a2pNyqNx9hjxh5bj2S+YTvxtgJlwoPc7uJY6u0Ki+Wa9KUIkk92ANjVOjOh4RIYBwJiSCt4OJH1kGIZJNVFUAf1Lg6wZ0dUzHAlEBbX0gkbrN9d3nbH9fjO7VCNj4n0VVekai6ytzO06zibc3CZUttSmDGWcuWTj/+hMQeWyhxMoGKqCWcMVtYU4PWBkq4pFrNQ7P7bwQn190JUKUy1EOIvFjIbaNnJX3B813WY2Vv9JxLuDfvAuhOd7aOuM3YSWFiCEh7BfzERkDIYJ5E1Ua1NgcLM24Q0ef5dwzdTavQTN0J5S5G7lupKFCVKsbWRhtd4+bp1hQC98N4d3feoKtYJl/GkMto3rRY9T1M1kn4I=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1631;6:e65lko5p6K8DggW7+aEiZzwDEIoeiw+6POIT4mvnqUwSIaZdZt+NdO9vQMHPprieTLzFuBHfyGWCvcHe+ooTlCKFhputXG8sZ0OdNtNSiPkebf6jUZYI+QSIYeePQ4ZGaNYPHxtgDsn+g+Ld6YpCh6JCFip1qDeCePiOy9wCx+VjigqbbNRBhVHcaRfahDyaJsgOSujaERArkG+sVeptcn8459MtfBujrmRhwVH27PO5bJX4InwJ7Qvyqe+Z3BzDWXAa7XAUzd0YGlFE4I0MqXKvWlZuBbm9IoAHvhn5gf13D/2HRkIQb7Vs37a9jBdNaWSktFyMFj/ccmcCqpoY71GqRUJAZn0M1Hk1NQxptMx/kP4kjq7HTCm8JALfJC9uor8ymLF90pUdQxy4G7o2Oq23uNBK5iqsCUJrvNQCMQzm5jziZs+9rL1zTAfmmQZtvAsgYO6vTpI3lx8G9hmnkg==;5:auPwziewCN55Oc0v6MVPOl9YoHtHVpxYSzteMyXUvDf+bDLASb37eUGsYWWFwi0wzMcpQXmgfSqv34vju52ibWfvMfLkNiRe2GiA1PhNfcwbpw/P8YkcDosQ1Kcm3KQX5+nslAoEmJ7awCJBIVhZjv+6civI0Vz1NrK3cyyZ8iU=;7:qx37gLIpS/Q8MtWCImZGBVfHbYx7ZybNUubqSLn0R26Lzn6URGsLckdPgZjK7wm0sauwMuaWkZulNZTiWjKKDjsRkDmacc7W9lWIoDjRKHkPKllR9iExq9pisZXWVPXluwsfxcftoFZX6Mwbt0/0j7+P4jtake3Hd4bU4JFPW1hliUF4i+nCmcY5bgrilUzLTFVBSX+Vsh6KfwnO0/h8StThq7kuwYVUxZNM+vyDCa2M4u3NIfnyu5gIC8IK9hef
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:02:26.9390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f803ba1-93c3-4ea3-931d-08d5f0ad4dfd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds check for return values from clock related functions.
This was reported by static code analysis tool.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0127e85..23395fc 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -340,6 +340,8 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	xadc->zynq_intmask = ~0;
 
 	pcap_rate = clk_get_rate(xadc->clk);
+	if (!pcap_rate)
+		return -EINVAL;
 
 	if (tck_rate > pcap_rate / 2) {
 		div = 2;
@@ -887,6 +889,9 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
 	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
 	unsigned int div;
 
+	if (!clk_rate)
+		return -EINVAL;
+
 	if (info != IIO_CHAN_INFO_SAMP_FREQ)
 		return -EINVAL;
 
@@ -1237,8 +1242,10 @@ static int xadc_probe(struct platform_device *pdev)
 		goto err_free_irq;
 
 	/* Disable all alarms */
-	xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
-		XADC_CONF1_ALARM_MASK);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
+				  XADC_CONF1_ALARM_MASK);
+	if (ret)
+		goto err_free_irq;
 
 	/* Set thresholds to min/max */
 	for (i = 0; i < 16; i++) {
-- 
2.1.1

