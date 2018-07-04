Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F3C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC92524575
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qgYQTKWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC92524575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932898AbeGDGAZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:00:25 -0400
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:35228
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932204AbeGDGAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBaLTR3XQXPnturRXf5pArtGCicOlcotGdQ2KbZmgPw=;
 b=qgYQTKWLvSPSIyCZkqFdafQ5aoM7QzWYl6h9/PXQ1Q2n9J5VopkxOGDnHzhs4vZKK6Tk4cVZZIDA7oo2TSZidFfgLkiPKUsT21RrcAqUuhhc1LQ5yQZsLNlIv8REUk0EHbLqmC6esFST++rc/Q5N7barUs27zuNXf94+et8nOxE=
Received: from BL0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:207:3c::17)
 by DM6PR02MB4329.namprd02.prod.outlook.com (2603:10b6:5:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Wed, 4 Jul
 2018 06:00:20 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BL0PR02CA0004.outlook.office365.com
 (2603:10b6:207:3c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Wed, 4 Jul 2018 06:00:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Wed, 4 Jul 2018 06:00:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47186 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faapu-0002OB-IB; Tue, 03 Jul 2018 23:00:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faapm-00022L-9Y; Tue, 03 Jul 2018 23:00:13 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w645xwV9018775;
        Tue, 3 Jul 2018 22:59:58 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faapa-0001sw-1a; Tue, 03 Jul 2018 22:59:58 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <michal.simek@xilinx.com>,
        <navam@xilinx.com>
CC:     <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kedare06@gmail.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [RFC PATCH v2 1/2] fpga: fpga-mgr: Add readback support
Date:   Wed, 4 Jul 2018 11:29:53 +0530
Message-ID: <1530683993-27179-1-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(438002)(189003)(199004)(110136005)(54906003)(6666003)(316002)(6636002)(63266004)(16586007)(36756003)(9786002)(47776003)(106002)(356003)(4326008)(305945005)(2906002)(8936002)(81166006)(48376002)(81156014)(8676002)(50226002)(107886003)(50466002)(5660300001)(186003)(478600001)(106466001)(39060400002)(126002)(486006)(36386004)(2201001)(476003)(426003)(2616005)(7696005)(14444005)(26005)(77096007)(51416003)(336012)(107986001)(217873001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4329;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT064;1:57PFaq3WLmOCnDiz/YdfCAgR1bH3vYRcEh7GGeJ9yMA7d7anflgfNvxO4J658ZnR1SnrGZs4mH5RhLbUwNAlic7sh6FU2/p9I/Vdm11yAC6kG6hu0QlRM5COtWh9X8L5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f180fd80-0654-4f8e-0d9c-08d5e1736c3e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4329;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;3:U4iOf4SYgp/xqbHrNB7GB4kUvCWsfjo0XQTdGoGYbV1yYHYe33W9S8htepVOG56N85mKqTW4AWlsV10zWoaxj3d6PKKBemU5pWFjYgdTTpcOih8EJuTe6lcxS7fOHJkDwVlDluiY17mi6x8URa+PqduKJE2kmQ3c6w/Hf8klfJ8mLYvlLy0sW1oBwo+sjhUntwjM3LkRT/c1Msib21NewRvrQfE4wvUpRtHixEEBB6mujSsz0hS7YiIfluGtXHKYCrzh8kYtobdF7tgAvH2k3v774/Vho7b3LUD2y1gZMt9Y6oZbyYWH1yXYqShfSotBRIApNU9sXHeIJgAYDAdbOpA4p7cpS6oLZoocmm10Fy0=;25:CxPwKafL/cV2up9K0TfUPJmWt4BPeGA3srZoHv1SpE+3FN7kMP0+Lly4OjQ+qxy20/Xy11J6huNcaC9nh1hJaYzklojXcJm0pY/+aCoQwSwjZzdC45TwGYpsCAeBEP4nqAX0gxDcH4NwNXWm/bq1J/bkPmsaIeaW362t+aoueac+7rAEpRkWoZkDH/dS4wzlp5gtcYok7+ewT+nxtGT1icEtUbwSC34lv85hdSjx/z/CczAB0jg2HAXnyz/6WS0YBhHz2j2iCo980NayjBy3zdHIQW8cgie7qF7LHvSgGJSOgw7JqV6jk8MDboQQ02dwxDW68eUeZjAjFpBjz+WlOQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4329:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;31:WZ7DMo3Lp0ReeHO2ylcOvqIdwizEycMa/4/Z+9kAcneWdZlqrk8XpH8UCiQRwC7r1d60vHS5yqZ3wy23jvCMpaVJdOhrIrtiq2idNfGP0Ycvp+ljhYdfP6uGaAvH6qg1nkaXENLKm8q4sJQ7S4gzgo6tDzCtZD5YDOoTJrI5jLa1ly2Jc/m02i+7VvGjrFeL20LJ1CkQOa05+2KaPryeXUIJHzGbzu6xeXlZzj5GerE=;20:jucW+3wYrex9gnMrjkWTP1Pv+9I8i+KV2d61hvowjo3RCIgUvQj/V9SclA4h6L913OlQY0Ps1D9p5j+s1nWUQy8LY3mKv0bSaTPbYz64XqMXQFwEz4qgbMiXWou6VgVVmXI+H8n8gVIYsFSJ+i7+lnIWHAIsV9ewAMHp8+sdDmwy4N+AMGky+3i2WF7NrQFFfQRCWvtsT1aZQb8yvi0yvlzYbqfxHp0J4Fk0hPAmQdCTwfcdPBNDZOD4sMm/H7HB8PhOMpzNbltzfyst9S/G9s8cXRFCJmMwimj157xzDJ6k3I54L9oxVJvsqmHUN+/OI2xRLXJX2ClvRtMpd7zcy/gKJsh9djvtmxcAUydJPUHJGlZm7ENGvqu5SAyf2Ns3lJZf+2bcydvviL+x7MbzSOjfjRk9z0LA4UAUZTjKpDtenPNt2OMkTN1azcpRaeLbuNw0lUMgjslXKZExcB1r+kWtRCFvd2Xv011IrmI8P20cSigimDdJ4tFMVtr0jJEh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43293B25B0D0498ACACD03D9DC410@DM6PR02MB4329.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4329;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4329;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;4:0Uar+wcEx3f1XARs8J3jRgizl4Xr+rDRBsy092wqNU/yl1lMDIKt1zO2joQ2X4rduY93VhgwaWisbVAZv4/uulQkzYkdJc6gHlCDaAJdoqjq0yzdvvQgqF+lx2b8ZJ3WWZO2EHIZw6vK4Hz1o5Ljf7JDbE04vOL5foxOdWd4SbelyRQIEhfFZy3Plwo8/S6pEd6kRwDCkdXlMTg4cFZmBeXeffWJjSuZ8nIaDQIYNctPJm6ug52KtybVpjtwiTm8sYB0qQvH02VAAT4JXi9VE8ZNTAFvFpsgztBUTO2pzrRzTBzWJ3ZeMxEcmn/HK2Fc
X-Forefront-PRVS: 0723A02764
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4329;23:1U4jV+L+Cg0Vgb5KmLLizziTRsLnWCpoVQygqG7Uq?=
 =?us-ascii?Q?7iUJvRdjTQmulrUG+CfK3UQafBwMEmNbKHSB1/kcP5FTlEB0NnLItYakuphC?=
 =?us-ascii?Q?0AHQ8bDHwC2eFaQx42wu6ZCWFNIfyNQO68n3x1knhGdCeW3Si5hF3U5R2TNe?=
 =?us-ascii?Q?r5pDIiAbyrHri2ixjdHfOueHMSa4lLX01FZpHjqzlp0dPbtRDpozgO6GcSB6?=
 =?us-ascii?Q?06GL7aHi0sA9l5KblcuZgWM37pB3Y2H3hviPKtT9AzUuGEvpxj9Hi5wfTIpn?=
 =?us-ascii?Q?5GoiRJDHBiDFVG8Ik2LmsqYPE6HygbjYYqvHp7tmB4bOSv6yFM0z93mXx29F?=
 =?us-ascii?Q?p4WoPqRvSmfQiPgkE+n/UG+bs+VLxbqFVstkWz9OYWg/lDokEHEN0zqxIIof?=
 =?us-ascii?Q?on/RxuiYT7oCRXHwyBaQd0U6ePQZg96va/d4gNxMNLckqakgzPvn+eA2gSYv?=
 =?us-ascii?Q?UYWnuR+m9wC/2kXcyKf7k34uL3jvNYIUbEZpkjKfFjSEp44ye0itKMMS9UER?=
 =?us-ascii?Q?lpr7YD2mDfmI58YEOZcKotbGAhnJiugrPU7bmMJA1mNZoZKrXKlOMuhVWwb9?=
 =?us-ascii?Q?HzRkDzctQkQYhsD7JSdgbWdElu0Gno7H1l+Zkuh0f5Y8LIrPfSfVbHE5dIJV?=
 =?us-ascii?Q?ycYrKly8AjBlhKRFwk34QInniVrX1viXoSCPSETqyrMx+KHpagdOiJE1CieW?=
 =?us-ascii?Q?AFpGkhepfT3sr3IZ3Wghy4xHCmaovAGIQp+QhVAxlhUMktQERQ5B8gqNE4yd?=
 =?us-ascii?Q?jR9gOQn2xVmejzmj5paNJ+Jsh2XGXIriOXMDH/KxfMJ+bLZGsJ23T/mTo+ns?=
 =?us-ascii?Q?qw+hQgTiPYRnVfy9USvxdRoIukAUNBaeDg0SdzLx/h77PdhcSAyGoRWL1hxg?=
 =?us-ascii?Q?O3x6F8FkQimt+bpnXnPn+fwrlrIMJC6QbZOAikXkIcuIauwc50XDKQksFYWm?=
 =?us-ascii?Q?rIji6tBiLyTAELzrTGEkSo+r9KzUK5xTyOvOzj7jIN1r7szWxM1IJhsFeVHp?=
 =?us-ascii?Q?118gG/9z7kgbX72xZ/KJQYe0cqSLF9LvF9dCqY3K3dUnTVRAobCDK1cQruJx?=
 =?us-ascii?Q?6De9oFHIuWXmmrjnLbOfLtA/YslqIBLuCJ1GaQtILQ9GeDOIWaYKhlRugajx?=
 =?us-ascii?Q?uLEbBdf9uh1Di4yc4950PiPZGdL31ESo4JwO/uj8UgXwfOazOAq//4upC40o?=
 =?us-ascii?Q?+fIsEVahUN2/4gZBxEHCKoUPejU5CLzN2yS?=
X-Microsoft-Antispam-Message-Info: daikLp9sXrWOevjPmi/wFjzP2HBHm4aV5nMkndSlhyl3NXdHV6zZOLzSqjoRAvyFj0ZXuG6sYFhLawdGDs8cNelxS1p5vIW9Z1EQCQ0d0KnRAKRm2Urb1iIiPT9z6YyfxhwKWqU8AyxlJNzlTpLmB6HcIRe30X+Ljoqq+5N8RSWF3sOYoqB2DH5vd/NYxcLWCLfozUnHUQOP0hoTrXay/FssI58ZlVlFFBCYa0J9LcAOB8HaeaaSfjCyp9erNjzSEVz6SE+/mRJLAjxCG9964kHgmmNC9TH980vNn+SiV7fV4aA7Sdbl15sFtnpEZrYVk0fniXnF4dj1T7NuOs9eU7yQQUnM7I1JYsSz72fwL6g=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;6:T/oJWnjlgLoXtlKa0NxGTTs7aZ23dUSk7cKy5rtF1IVmsd1IVbw4ULuH3N9I2M6R60Dzy34cFiDB5d8M4xKZt5iVQRS3E0ObOjmNuyme3E47t2Fnw8Tz5Hl95TISw/PDx5uuH1fe5M78lhVAV97RqpbOSW32cW3tj1zEQZXOkbSKYdbQrefkMIEYdwQzuS2WoC+ndjDQHmmrvoI9fgRvpVXKjsbNI2mwma+LNd8Si7w8ATKDBPqdflFmB/rLHHtDxJdo+/VDG965VfLEo40+Qnnfkuiw1sYlhTrP1YROa051WdbuQL/Q8Y8DvgEr+EKUQe3rCzGNW//thFh1/QiSMPx9QXZQf5oD4KosawbUGNWNnrd+BqgRMd1y6NKTdw0+EGS2Dn6MZnsZQQbBym5zdVLNzhl1I8QIooxooVCvEOCuA9dGvUQQg+k7bMKRvqSX7F68jdKxgIo1rGIFahKH1w==;5:HlvgSeHXRuIeLBvw5C7l3yYVmze/qB5+0XJdqeuF5ETyOhyOYw8ipPe72Xyz+QkRZzfbpVpSn3bQTkX4NJIP6DBGGQ3CNwGOXdkNGkZtkMyRkJSMWEo4Y8y9MK3cqlpIHW5SJdj3y+p3tbwimaODQtzF9/g0NczRky8pw36ZI0E=;24:xx4YeyVV3btG+oCTfo4YNj4SuAa4vh/hPPHDM1MnxJqICmzz6Sr+coetky5fiT6eBQG4+0ll/E4gsnDVCMJrOnJkw9ATCANqhgRRqD1yyT8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4329;7:FU38UyqFwvhbF8JjQnYi1To7J9c1MfPDfamLbshmNK53HfQa5ceKPvN7TTG9GFSoxAwLXu+1yHCfiyw74aa85KlhILyjOaa4QBfcO3VuqzpwODKCCpTKQENzvPPpmIEIkTevLuatGKiD+RqxvWsfCtQKLwjcu3D9hsZqAibDTH1OptjEqGy7ykmKJW36F5jAMAyJGfYebCavVER3sD93f0NaDeC1Udd/N2DUNfZQTW31ikFfAwECHn+K9Drn9bVL
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 06:00:19.2225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f180fd80-0654-4f8e-0d9c-08d5e1736c3e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inorder to debug issues with fpga's users would
like to read the fpga configuration information.
This patch adds readback support for fpga configuration data
in the framework through debugfs interface.

Usage:
        cat /sys/kernel/debug/fpga/fpga0/image

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v2:
--> Fixed debug attribute path and name
as suggested by Alan
--> Add config entry for DEBUG as suggested by Alan
--> Fixed trival coding style issues.

 drivers/fpga/Kconfig          |  7 +++++
 drivers/fpga/fpga-mgr.c       | 68 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fpga/fpga-mgr.h |  5 ++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 53d3f55..838ad4e 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -11,6 +11,13 @@ menuconfig FPGA
 
 if FPGA
 
+config FPGA_MGR_DEBUG_FS
+	tristate "FPGA Debug fs"
+	select DEBUG_FS
+	help
+	  FPGA manager debug provides support for reading fpga configuration
+	  information.
+
 config FPGA_MGR_SOCFPGA
 	tristate "Altera SOCFPGA FPGA Manager"
 	depends on ARCH_SOCFPGA || COMPILE_TEST
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 9939d2c..4bea860 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -484,6 +484,48 @@ void fpga_mgr_put(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+#include <linux/debugfs.h>
+
+static int fpga_mgr_read(struct seq_file *s, void *data)
+{
+	struct fpga_manager *mgr = (struct fpga_manager *)s->private;
+	int ret = 0;
+
+	if (!mgr->mops->read)
+		return -ENOENT;
+
+	if (!mutex_trylock(&mgr->ref_mutex))
+		return -EBUSY;
+
+	if (mgr->state != FPGA_MGR_STATE_OPERATING) {
+		ret = -EPERM;
+		goto err_unlock;
+	}
+
+	/* Read the FPGA configuration data from the fabric */
+	ret = mgr->mops->read(mgr, s);
+	if (ret)
+		dev_err(&mgr->dev, "Error while reading configuration data from FPGA\n");
+
+err_unlock:
+	mutex_unlock(&mgr->ref_mutex);
+
+	return ret;
+}
+
+static int fpga_mgr_read_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, fpga_mgr_read, inode->i_private);
+}
+
+static const struct file_operations fpga_mgr_ops_image = {
+	.owner = THIS_MODULE,
+	.open = fpga_mgr_read_open,
+	.read = seq_read,
+};
+#endif
+
 /**
  * fpga_mgr_lock - Lock FPGA manager for exclusive use
  * @mgr:	fpga manager
@@ -581,6 +623,29 @@ int fpga_mgr_register(struct device *dev, const char *name,
 	if (ret)
 		goto error_device;
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct dentry *d, *parent;
+
+	mgr->dir = debugfs_create_dir("fpga", NULL);
+	if (!mgr->dir)
+		goto error_device;
+
+	parent = mgr->dir;
+	d = debugfs_create_dir(mgr->dev.kobj.name, parent);
+	if (!d) {
+		debugfs_remove_recursive(parent);
+		goto error_device;
+	}
+
+	parent = d;
+	d = debugfs_create_file("image", 0644, parent, mgr,
+				&fpga_mgr_ops_image);
+	if (!d) {
+		debugfs_remove_recursive(mgr->dir);
+		goto error_device;
+	}
+#endif
+
 	dev_info(&mgr->dev, "%s registered\n", mgr->name);
 
 	return 0;
@@ -604,6 +669,9 @@ void fpga_mgr_unregister(struct device *dev)
 
 	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
 
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	debugfs_remove_recursive(mgr->dir);
+#endif
 	/*
 	 * If the low level driver provides a method for putting fpga into
 	 * a desired state upon unregister, do it.
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 3c6de23..e9e17a9 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -114,6 +114,7 @@ struct fpga_image_info {
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
+ * @read: optional: read FPGA configuration information
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
  * @groups: optional attribute groups.
  *
@@ -131,6 +132,7 @@ struct fpga_manager_ops {
 	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
 	int (*write_complete)(struct fpga_manager *mgr,
 			      struct fpga_image_info *info);
+	int (*read)(struct fpga_manager *mgr, struct seq_file *s);
 	void (*fpga_remove)(struct fpga_manager *mgr);
 	const struct attribute_group **groups;
 };
@@ -151,6 +153,9 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	const struct fpga_manager_ops *mops;
 	void *priv;
+#ifdef CONFIG_FPGA_MGR_DEBUG_FS
+	struct dentry *dir;
+#endif
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
-- 
2.7.4

