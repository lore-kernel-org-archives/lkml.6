Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DC3ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052FA20838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="zLu7b60v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052FA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeJYOiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:38:46 -0400
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:64096
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbeJYOip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWrBHj5E/kiM/5o3MS/ShoMSIk219+sRT1yXPTUQHCw=;
 b=zLu7b60v2CWc927jp/LnbbRh0n2KZLyy2fF8VEemLZze2TDFhVbMh8/idS5LY1WHT8URSFTmy3STIQFnKYclNYCFrSPXLw2SkTjCyEmuYTv0O46tG49G5k55BdB1rKjWUh/sUIGFqqx5wryVJsgbEZhQqu3qXhfDFZFjnG1+1EI=
Received: from BL0PR02CA0091.namprd02.prod.outlook.com (2603:10b6:208:51::32)
 by MWHPR0201MB3516.namprd02.prod.outlook.com (2603:10b6:301:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Thu, 25 Oct
 2018 06:07:28 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BL0PR02CA0091.outlook.office365.com
 (2603:10b6:208:51::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.21 via Frontend
 Transport; Thu, 25 Oct 2018 06:07:28 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 06:07:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYnn-0001Hd-Ov; Wed, 24 Oct 2018 23:07:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYni-0007wD-Lh; Wed, 24 Oct 2018 23:07:22 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9P67HRA030577;
        Wed, 24 Oct 2018 23:07:17 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gFYnd-0007sO-5S; Wed, 24 Oct 2018 23:07:17 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 48B311216D2; Thu, 25 Oct 2018 11:37:16 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v10 1/6] edac: synopsys: Add error handling for NULL in probe()
Date:   Thu, 25 Oct 2018 11:36:56 +0530
Message-ID: <1540447621-22870-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(438002)(199004)(189003)(2616005)(106002)(2906002)(48376002)(50226002)(106466001)(36756003)(50466002)(8676002)(81156014)(81166006)(8936002)(7416002)(72206003)(6266002)(26005)(11346002)(305945005)(36386004)(356004)(47776003)(6666004)(478600001)(5660300001)(52956003)(110136005)(476003)(126002)(54906003)(51416003)(42186006)(2201001)(63266004)(16586007)(316002)(186003)(76176011)(4326008)(44832011)(336012)(446003)(426003)(103686004)(90966002)(486006)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3516;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT027;1:byMssyTHPQmfRj5LeFje//L/eu7d/yrQ7Yp4nNJVRDEGZXKbZO++gDiD7VB69/QzxB8VUEA3T+STNw9ypCgWAXCylxlCXb9FOfXo4vPoppWtUN5RjuNPYUtHUxWMktYk
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88394f85-d50d-4bc3-8726-08d63a40248b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR0201MB3516;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;3:y3pJkAIHDYMFA4OeolbJxnJwXd2jEKqKkDsaDxu1PJVyOfRXGcfPO4G3tHVeiqA1o5JjJZbAoO7blJurF3WTusf2L7szcCxQFQsNjpuqnknWxc4gCQTLOBQIkZ+BkcqmEHF5BueW59B2uwJ1invnT9AUKNs6F1XK7vGlSwuhw7HZGE9LusA8whdPD4aRTXN4n1lJ00wS5WPT6q4ekfEnCAzNJ2vhpZcQKkRb1Nek0NcR1/WMABTqWiXeBBGyFa260MSnNQr2NQr9nfx1HApI+/8eF4yMhFAjjvtaKDbfzSKpphbxGFVggQ2/ZtKYJ3960wnyjIFXANWbdaXTm7RGoDMzTzeTfDtGFC6ukUrtsU8=;25:HflvybMaEPLefX2Y5RR4LF7/XvKxHI3TouyyBG74DwA111i4qrWQL4JSbAQXwk+A3mcsyV3nDQ1Vl3FENBJoH4H9QcXy+TAIRlwNOprmcVl5Bq/Q7E2gySdlCcGhMFLYxQ2C8QxWxiLOhjXVfYO0oYgAFy8Jb1z1C/7CpvQNj4FhhO6RooxbdsOROf4Myl0OARTfHil1m5j1pDI7Uvu/ZXvwC0xlM1S6jP9mH9l7FMC+p1bvZ+5HhVziCLuEZzRa1+N0YvUDTT73RH9BBPYl9Mf2Fqsu6oNkQue3UDVr+9lA6Mhx5jTGqNxCk4jWfOfSEAhedr8WHrfbSY8FchtrWQ==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3516:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;31:YvPrl+lQ2IGM7H9pOko3n60nPeOiiFrsMRhE+rj9y+t9jLIXRw78RK92ZuriS4HlHTABgW5amerl5FnIzLLnJN8q3ubnGz3GAPl6iVWE7ao7s6lLLPuyMrDqGIO1pxQQ2bbclqXvGNknXVZH5p2wqu/bpUdAPab/ZC8UNheFd6jtPxhF1cC7HvjK18LEIAdYkPyU8XePRcqx5OrCOR7fKG573+UzwQ6JbyEw0O4Mhps=;20:GZ9/0Q3wdEv1KS1tkAjPL/olFtJ7h6KhOISRvKxgeOsQPI9/VMMzbjpd9aOiI9WHZgKqyX7k3/Vg4JP9qhjrgOWZeAkvM4HsJtZbH/hUVC2iD9nV1rnwg+0My5QVbfE+/5gxRk0fKNVZfWcG3PTgk4IeJykw+JATJpp7iROcwEsl7tbRqXrAnKVbE1cdBZWHdn8hQVOCkMkP6vyp1VSMpGREYPq621G3QcRoZjEyGEoaLj/8vSoHER4L427wLyYOHCut/1sOcgLcFz9KBg7wJgmRbWZURQL45o3xw14VrpY1HZd5rCpCU3TwWCl2rrjyBxlflILoEHyN4QruBDdYqLXzlZXOyF50bZE+9+kbltslMh/YicXG7KNA3ABa2sEf1+oyDQqrJJ4uDgo6tDIau8ktLGdOq6IJuIVEwTZbSruWn7BC/QEPXfUf13oXrec2TitNHsi9+i/qy+8CJBdmN2dexrHuwEeCbf3aOUWE8fXRIqAdfgQ/8+i86YPgEqK1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3516961A99841C2E1A82E06CC1F70@MWHPR0201MB3516.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3516;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3516;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;4:4WIJqV5kaoQhQrB13mViuPhYjorGx6eml1BXTx8qVIpbCFeusRea0qb95IOQs/Aa8bsmZ85kZGiudbExqaBlkZnAk5Oc74n1JVr3E5yotGThRAHPdY/OGyQDe6p813heyL0FgAG6HZBUhQkboo+mcZnbu0gmqchFp7Crk56sZyUdfGybBI5ibpw3dx+WqO4dYt2+bhoswrygxB5FQT1wquKZ/cXf6x5MCDnzz7Ufs51BOo87zcbrAz80RCbDrltDa1CjUCqhQwdME6npCk7EwFfXL0l+BPgxTcqCHAY/lTd5IYU5Pf2xRDbEBhgVmFbd
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3516;23:g4i3dG+2qcsJYIqHqcnTUog0v4glpBiz9W4qxpN?=
 =?us-ascii?Q?bds/XwU0NkpmJ4O1/NQKIoIEFkLL91MjY4cWbgEQwxTmlHTqUdUIPXWbXlBE?=
 =?us-ascii?Q?EEVFdoqCSz+HsHjTOxs/S91UntlK52Z/Uino//UQhEDsN89yB1x4dvPHBN6Z?=
 =?us-ascii?Q?EOMr3a1VHMetiyV+wJPKJlStaFFzGclqQOvIU9x84MOz07DMw+/lTGcERzQE?=
 =?us-ascii?Q?/tviD1p2p3kUNzkOI+aehDQZS6lpGRIZOwSQ68vG+PP/OQzYORGarxtlC88F?=
 =?us-ascii?Q?f1VeWN92i7RwvP0QjWgz50f/rqYFvoUdrW5Q1DHyL+kQ7bDaphWKYyfEt0Hy?=
 =?us-ascii?Q?FYQS3wCQz9p+r7/e1AFNWVePf/UxWbK0QEmpLatk++v02zOSojDVMgh8dmJz?=
 =?us-ascii?Q?ZAADwSh3Pr3NCle0K4XO60YDDgln7iKB1ENTqOKEJ/1X7VWshRqwKueB1GzG?=
 =?us-ascii?Q?VsnlFaD536u92bDQI1MGzDmf+5kQTXZC+Zq0fPMNok9wiMYuWisqzWnVQfbg?=
 =?us-ascii?Q?nFO7OS1AkAd7Xi8G9vjwdMdxiZiiE4hOA0J9BWH5u0OJp1AQevs8O5ZSTt4x?=
 =?us-ascii?Q?uk/bZ2mEz/Vx7dLMHMgxiCSrC617AGrntrpId5euJ3zHVC7tx59MtzAb03MT?=
 =?us-ascii?Q?MpWbBVoikTqVi4y0JDKrVH5JpTG61OOQHvEbFExtIexFziBHt1sATeg5rK9A?=
 =?us-ascii?Q?2YEcvxyUw5oqIKNss4rGqLEkMLqic2/rYSrx7rzgtR5Wrju8OehPKCufDdxj?=
 =?us-ascii?Q?xPiiv6mMStYdpIzPQYxb5eaXy03jvR8XUs2W5xDxNGOKnBH1voNY1/cDiMHa?=
 =?us-ascii?Q?6N5NolkV+iPz5IhPTgTaeWSfJ4m2fRKGDwsvLEC4a/58nNsgfllbN8BcydWx?=
 =?us-ascii?Q?snVWMwhWk/2lpiXuFDtwerbLZgbvQJr+juf/wbSVm/VvF4B9DOKERbx5ceIn?=
 =?us-ascii?Q?N+ZGVhlpD/ZV2hQfIdfzPKgpC+ImfpE03RkCu7oKZNeHJz795EIc7472iyi7?=
 =?us-ascii?Q?aR5MoW6etYBEC59hI6ADRel8pNqV0Ai6Hvd0/6GY5GV4XI7BN/DauBe+sZ4j?=
 =?us-ascii?Q?CA+ZVP4AcKbZycv0XdYR2d9pFK997zEVhYaEtWz4BXiGyaLmeuFp5vgoBURf?=
 =?us-ascii?Q?r2y8WJEvVfgmj/3eKpb6b6QM91v9yuyx3J8PYx8ZTh3BiS17T5u+duis8Mb0?=
 =?us-ascii?Q?ScHIQFCvI2Zaq/1Wv3tOIcL65ZaIGZ7iDW4lmZOlHiTapPOgYxN1HC0r9Gg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: qGZnE9Pxhe611FHSKAjFBiT1Pgo9EfsxV0rytAsB4mcWuQgyjkDc06Nn8ALNAJhKpwPDcOYWBUPrxcgDOhCV93eJ+0bVSa0qz7N32gpRqYeguVGKGFKocI2aBkGKnBm7YzxWbq/7papLLDmBwuFEmrhRf9BLxcte8EB+tAERBmCcRLaOsMYduAKORFv4+yNJbZh74zsWy1Lm11ggW2m1TdjViSnoAzUlaX0383QoDHPv2/p/rEZcHWGKgSM/QuFhq/GJ46bh+8XDR8XQ03NlwVxTgJPIvQ357s0ezdqoOwJtMRuZZxWng+IjKdc3SSQgFTl7nsFhUb1LSukJh4Ot2kgZP+YeCuXAv6ov8vW+MFI=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;6:DqKUVnovYnDCez+IaTyVM+QsB10hhOU743ExK2CkTMGcpGVwG4G/byvsLmUjPpDbqFwTq7uH9x8GfMiKOI7U6YMP46/nPtrEi2ukhkgOKgfkOumAl3JyhqGbsi9fcpa+OPdhRuBGRcZQ+SPGikH/3TmMj1Zxebm6sVulf6cbr3fvX/X5LfsxhqlzPFXoc1xvZ7dTfq0MjSb/l7OVjU95zcrkJgTZKwe04tCf1geRY1b57N7tYheFnoeD/psWWRjbMbSORD25nY8k3lPtvI98cBjR00x0YY4qoRENT9/+wDgyu0XN8udISmHGax8S4i6KZWhmX8vS6PPUmOl9pfWLCNqbBvuDEN0buoxVEj7TXMcDne11/9zpObINIsd620cnnyR9m08F6Oe17D43z0qRlsRWn/0oPawby1FR9s36CU7YqkTFZ8pWQtpF1n877zcDH2gCsSmcD0MVdHx1bxPOIg==;5:y8gQb83zE4pLTS2hjsL4ORjnY2HuA9rzz3v8reu6fxeEibl6KLW/p85JTOA+Ewtrj3z+CrlkSsfSrIjKCiU9udWvlxj9zCGgKQ25G4FJcWgzzS2uvPat95eCOXO8phx33pMeusDsIDCOnUA6ddaAU1wfMjv9+efV3PRK/JPbbI4=;7:/Y+vVQ4Ge5jDVK15HmWs/vFdGrASmjMkfQTzgWtIznAcofvRNghr2Hu8w+9RcjZ99U9vjqK0NSf7A4TrczwtWcUkgcHHJ3d78tYqjN2H4HpNCP6rKq1gxu5XZ2zrINtarg//Ht5ujX7hkEd6hOLsVlHUYOp17ulhTQGybSZRDgElDt7meSccVM5xCBdaDk+ZO/Vyy+jS8SWq4IKY0shsL4pHj/OUQMKkTLX6eSAazayYECEQaV2nmD17frE4+Aa3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 06:07:28.3226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88394f85-d50d-4bc3-8726-08d63a40248b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function of_device_get_match_data() can return NULL in case of
error. Add error handling for the same in probe().

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1c3795d..0005ef3 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -477,6 +477,9 @@ static int mc_probe(struct platform_device *pdev)
 		return PTR_ERR(baseaddr);
 
 	p_data = of_device_get_match_data(&pdev->dev);
+	if (!p_data)
+		return -ENODEV;
+
 	if (!p_data->get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
-- 
2.1.1

