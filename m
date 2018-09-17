Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED925ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5291B2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="omgzMJdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5291B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeIQTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:12:23 -0400
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:54621
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbeIQTMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRFLOamB5d6g6J5tbeFJ04z+czbe6CyCzCs/jWCyjFI=;
 b=omgzMJdLtvNFU0EcZczyw+EKzq8acxtUBfHCqZrzxcomeqfpSTmoZoV7JaCdY0tde5mGH0xLrfjgw7n7xTDDf0+XiUAex4c6rh/FexScwpZP5M8G2QapHHRAVrjR53dwmvVnBs0LTmxxXMOIlYp6gT+WvszjsiIk4GHrLZHP1R0=
Received: from BN6PR02CA0047.namprd02.prod.outlook.com (2603:10b6:404:5f::33)
 by DM6PR02MB4762.namprd02.prod.outlook.com (2603:10b6:5:18::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 13:44:53 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN6PR02CA0047.outlook.office365.com
 (2603:10b6:404:5f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.18 via Frontend
 Transport; Mon, 17 Sep 2018 13:44:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 13:44:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpc-0004jh-Io; Mon, 17 Sep 2018 06:44:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpX-00056M-F5; Mon, 17 Sep 2018 06:44:47 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HDikmi024381;
        Mon, 17 Sep 2018 06:44:46 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1tpV-00055g-Ne; Mon, 17 Sep 2018 06:44:46 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id E6EC912142C; Mon, 17 Sep 2018 19:14:44 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 2/6] edac: synps: Add platform specific structures for ddrc controller
Date:   Mon, 17 Sep 2018 19:14:29 +0530
Message-ID: <1537191873-6582-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
References: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(136003)(376002)(2980300002)(438002)(199004)(189003)(478600001)(44832011)(81166006)(42186006)(336012)(72206003)(5660300001)(106466001)(126002)(90966002)(6666003)(51416003)(50226002)(16586007)(8936002)(50466002)(81156014)(48376002)(36386004)(446003)(76176011)(316002)(2201001)(103686004)(110136005)(8676002)(36756003)(106002)(7049001)(2906002)(486006)(47776003)(186003)(6266002)(4326008)(2616005)(356003)(54906003)(426003)(305945005)(63266004)(476003)(52956003)(14444005)(11346002)(26005)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4762;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT050;1:6naEEJuOZr72JdJ2yiEToj0rEPQytwxGYYl2mrXWwzJkEiogVw26pmkqoQs/n9xNPrIWZM53ECTDYrs+UYBDBeNDSp1PqwTZwCfPAYNR7WLeePEnovMzsCXHcKYPuyQS
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 790c20ce-8458-49a9-5e55-08d61ca3bf5d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4762;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4762;3:GdcKIUDJjHG0VDKPEnet8aDNbF/GafOdMeSVyO46wEneR2+QBomQwMqb13JIu45sWWSgj4I3IbBQyTwCGnkpD+iBbSd4m1S29VikiE8gMZhco3oJIUwTxhqO2fA97EbzMpkpP8mq4z3SDQy6zt6WW8Tcmx6oosZ0XpZIhv5k6iF1fQmU/VL1IU8zlZfCNGxHti+rSv2FscIXkUv+MsiyK1abxERnlKwJNPFlXyeg5uLiekJ6YYJMYr4a/FHdZLSLHmCnSBghjqSAfY60IEkKiRzMYB3E29b4sSay2ewAbyZaZmKWhtyai0bja6CCDr/wal0atvSctBKnoKziwK7VLEd9MBatf130g6w9/eCJJkc=;25:fPW/ZHvA2jmCTZlcKOm95HIy2jB4wS1rkPV0mjgQB4KD70pqXSlkc5c6Ot1A8/skztDSaUGv/j7ge8ppf2EQOrlTXb3y8KB0IBneCFZG7R6shWOyu/HxtX/xf+EsVYr4kqTjhdxnl65b0VpHQ3Iy0xq1oVDN5fzGDXiQmDJrideOUkqBzritbBTx7rd6W11W0Pf7bvTGhfBzIm7W+7/Z8Dr7H7PmwGCO2JAFNvkii1Ca61liBnFL6NaiL8djeU1n6vAtHYY+l2z3wWpVUJjql0cg33VrXR1cr3E5jhPe6vwY5Wu8K9LdkaHFVOV2ljDfqwZTX7KMK9OwLfwKo5Rk3A==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4762:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4762;31:29/iljB4sZlgsozuegr2zlKpnRXssvKKU7x/amfYOgJYcURq9hSHo4GX5mKHn3JYBlGuI24PHi6lkZHQ8d5YWxyx8Wg7s15RFMJGn+mzqGVA6LsPL3gzTDDX4Cb8yguOlNtvXWaxx3zCO79QaZn+b0SRCsvHV/G2Uwd92BT4BrTB/ANIFDHudfrSzhQU3+YMkMecQ3yLZRmacMH58rFkenY2AkhNSw/UCg/uUO8ifC8=;20:VeT3D+swLy+YR86N1+5mlQYCE0D8yJ35wKVQmbJC9zJLtokMI+oe2gli95JVjF32ikwAQtXjBOsl3cHaCR4FkUfWE1Nes5Xv3qTJ2R8xofPVvGu5AZCGjTSktq1HKAc7qBxOstsV4avGXbOjWfhu3TQ89TeoMXAp70jIp6S/f7pyJyvECDEIz5htB7lhqRP9Pc/5tO6J7DqhbW8+1QfbRQyed30ofsD39u1lVY5s9ta73WaNnS3oGSOCvVEgoTM31KWgGhe2pDZKXtyCZHe+0KtB1yVcK7QHHmj2p5B5nvaxJ758fkZrdtT3bTOtPvISQEjI9jtgsygChtuE16DJKhItGZDknqtoEhP2U8WXbNYRjEOhM2lMVmlZ5Bkss9MaTE9mBL8hUPEpe/EeJvRXXpiasVGqnwTSckJJgRWZXqGW0CTS3Nn/1p9CRX73x2RqNONwANkXslzg9xUkf7TdftkWLYZLS9ws1aQEUtRuDU/7A4tb6/od8QEUBBG2RrNp
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB476257A031020FC4E7B04334C11E0@DM6PR02MB4762.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:DM6PR02MB4762;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4762;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4762;4:CckrqeEM0+MnIoRqU75SvI0Zap1lmAG0QJcM1YyIZkJu9QVCttT7w4StbvsZP8Y//oPcnYQmupxoG5gzmwuvZIcSpPpHpUMjqT2OYEf8n3tYJSXLmB0R4ts/WgOtAhiWQTBqyvOiJwDaCFeSnHFB0nWAFhGyhpq0uSoFTPSh1TJA06NIK7+FFRe2dsTDGBwexN6DX2ve5N2NdUdJYGiYJk6qoD7MyfTRT8ipYe7US+FKczYCTloLQw+v6A90o/3dCfMC0fE5sYlZFR4Hiqay7xf1sE4D205bO0RuyXp55vnHhOdbZ+4P+H6KzADEHjDH5N75kgbiu1sOzcWiu+RNt2XmTpJAmi8983UYSP+IpiM=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4762;23:4dUBCmzAM9OCR1tikJYJtDktiexDOdn0Btg8301jL?=
 =?us-ascii?Q?7bRfmUCQDx7apFhad6/8npMqCQBcWLvCEPubjwch4s5U3MO2b6PrXUSq6EFq?=
 =?us-ascii?Q?+uBUaKtWU6FC00T0mQSoCC7rV9L4PLutCl2OBGDCMw97Imil8TWZEtaVuvvP?=
 =?us-ascii?Q?8Ghz3qHF0vQ5dSNUZenfoaoJqcGu0FBs9aWsn9CO8wIHhN/gFS1nfF0vGzay?=
 =?us-ascii?Q?MSPDPsD5Ld7x5IrRmcIH4pOsj8zlTVFvOpqm+fpKIgVTi+StCOoz+WQaYI+z?=
 =?us-ascii?Q?DYaqctxlH3QPPBqhdJon9LpdS7oVBOLaCVnFOt4bHg9z4zjDUjGYtY5EQMpn?=
 =?us-ascii?Q?HD4oHYp/vw//ks/GITdod2FFPFCMKkTybMw5U57Xtv6PKfBR+ebA4w42LhN7?=
 =?us-ascii?Q?bZctLm0+DEUWhwugAcmmCcJoE1e3TlU/gPMKXRwOUE1edMX3OXIqgs4nunYM?=
 =?us-ascii?Q?c0N/RR4lu5MddkprW8Q68Z5rGLmqROH6GlMNk2OmixWPcruUadDhTOwBnqNl?=
 =?us-ascii?Q?CH16zJU2RsWWbhsloTARgaDPYF0+EivXQccSaNo8kCujl0OQOzlJxg7I7VN8?=
 =?us-ascii?Q?1bBj8Ab/9/UzykvIwwj5RPwVnYvd6OLjw0sRnnom5IAg1Knw4OKnQnKDLwB0?=
 =?us-ascii?Q?PhvVbWc5oMhFQRPJmM33SbTpuxZ6kJcTEE3cGFlbwzc5roT2UzE5afjRuN/K?=
 =?us-ascii?Q?tUKBxS+oRh5TELbIgqM2wDUAtw5RveZ3S15mIK/It7A5ThlBwwF2hjcHYmMI?=
 =?us-ascii?Q?6JpTi+Vyp2GKA43lxxLK2zmECjUR+JyECMIhqjsBtkfIe8ZJwqlpc7l2S25O?=
 =?us-ascii?Q?UnT4WEDFHrS1jBcwQo8cdTypHFqxQL1JpYVQ/VqD8ZFrLKbDcWNGQcpmYlRW?=
 =?us-ascii?Q?cd1read7gR/y6h2NLP95AVkb6dWlWmA/317fV58xVD6EBLwmmhieMoz0iScb?=
 =?us-ascii?Q?ejo2Xx1gEkKISYMtn6KH4yIMr1/SZKbDJzsMwgL+xup/U79EaMJEXoJO/EIi?=
 =?us-ascii?Q?u5i5nXJZ7dEGlNRpuF5aGSih7eSTDFQok2jAnoIFLo/BZ8dXv+xhwKGxBaFh?=
 =?us-ascii?Q?BSQpprMTxfMNPDhR0lzG9GvAnJWTfvS1GiS3xYY81zFEYr0B3ClSW1Dz0meY?=
 =?us-ascii?Q?SldI/qFysm+ZZ+5mwYVfF4gZhANCc4nzzQUsZ9NLQDe7ql1ewa19awgcWQrz?=
 =?us-ascii?Q?N75xgcMUytKdthlXCU0Hhve7X974SrKO7yPCUTwYNyPOnGuF0W9x4WeQFKjU?=
 =?us-ascii?Q?xfbWiCRm8B/lI59fak=3D?=
X-Microsoft-Antispam-Message-Info: MhrJ0lWfmcBD32xsMSB4XAdoORc+x73I2eWtIHE8kL90gspMXJE87Oh2+qyH6weEsKSp/Lcxu1XCYYQetvK+pBb55MRuZly13sAoOK/gfgrVK1rD9Qo9iyMJdQL3X5YnmaGGbK5Zi+8I04hwLZMOsoZFJe5OpfFG+ThETgGAhrxMy79YeSsnDND3gPjKZp0nqqKhjdmT3h4Lqfd803CkbNDSoOl8ZizhUhHtvPLx/sVK2QqzyJTLEhAyL7ecrHhWHf0vC9GffxtzgX9XKwLbYR42fvjAki7g8Z5Nn0TP9eaqUszaTEThMIN+2cIiDNGkySiP1rM0fqquvOomEb7gi1cdXXAwliDlgFHNBHoh7kw=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4762;6:ho3rUqi5TvoJu+vmAzbtBraanFABBMnehANZUP+fU6JmfuPOJtkSGjmH/s37SSrqw6kxXV8nbmyr8kLu/FuUxWyFzPe7ct1PABw8KbBCgmOMmaL/GYwnGHZ7p29A1WywztA4QkuPHbL5Q3XCq5X5i569iRbvVxNI/j1NrJTwWwhIBn5aajZB785FXnJUA8xInvVdbtK59UvDtwPsZtjp4tIanI7ozoBEpAv44WC2yr0nHMyH2z12dbAjDQhDfVsIHEMb0ZW0CUD99PzBm3toN5dIeVGAuQtU3ynphorwpec+z4n+a51kd5dc0OeEE/PHsFgHZxhwCjZvTkn1//e15ka1fP9PBeEvX9npUkdQWRMwlvjv82GDh2L9cZrw+Lqqw2JY8xbJWvhqNXQuLBH2Fh48kSW1B0TooBuMjMDYesxiMPYD8a2mLXE/4wLXf7Qg9GdawnWl3NfPU2WYt6U/Cw==;5:QrC0stp7VvzvQkLY4hCxL7kLFfflu5JK65jD1htRm3l38M9eNwiDdGZOULzDOPtFsk3TDg8KlpkHXn3bWeIV+VMS2XT0kZmVwJcBNVfEDkYFijXCA3/KoT0/LDoKgoYLybD9ojRyMjvgAY/TfxHlCLk2lH0GpEV/yTi50dTt25w=;7:Y/081JAtkE1RUfhAxcx5NIoJlQipi44NYq1HIpmmGlPRSpDcmzhjA6VwNZitiMWJSIw1rA6KT/uXoByDg6ZrV3x4OzEzZTmm1F7JF4N7+U2Sorx/ighdtdM7izNwmGdLpQlLJJP99ViVbfzcN4J/9YDkHOY0k56UYxDu89U9luMWEGJ/j+nhzdoJjvYImxF8/yb9Gt17PxLWczX+5eepvElJAK/5G0846KsHeaLlBayUxNamPH35Jb+n4Cc8xsA0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:44:52.9849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790c20ce-8458-49a9-5e55-08d61ca3bf5d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform specific structures, so that we can add different IP
support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 91 +++++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 4963930..eb458e5 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,8 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "edac_module.h"
 
@@ -130,6 +132,7 @@ struct synps_ecc_status {
  * @baseaddr:	Base address of the DDR controller.
  * @message:	Buffer for framing the event specific info.
  * @stat:	ECC status information.
+ * @p_data:	Platform data
  * @ce_cnt:	Correctable Error count.
  * @ue_cnt:	Uncorrectable Error count.
  */
@@ -137,21 +140,41 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
- * edac_geterror_info - Get the current ECC error info.
- * @base:	Base address of the DDR memory controller.
- * @p:		Synopsys ECC status structure.
+ * struct synps_platform_data -  synps platform data structure.
+ * @geterror_info:	Get error info.
+ * @get_mtype:		Get mtype.
+ * @get_dtype:		Get dtype.
+ * @get_eccstate:	Get eccstate.
+ * @quirks:		To differentiate IPs.
+ */
+struct synps_platform_data {
+	int (*geterror_info)(struct synps_edac_priv *priv);
+	enum mem_type (*get_mtype)(const void __iomem *base);
+	enum dev_type (*get_dtype)(const void __iomem *base);
+	bool (*get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
+ * zynq_geterror_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
  *
  * Return: one if there is no error otherwise returns zero.
  */
-static int edac_geterror_info(void __iomem *base,
-				    struct synps_ecc_status *p)
+static int zynq_geterror_info(struct synps_edac_priv *priv)
 {
+	struct synps_ecc_status *p;
 	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
 
 	regval = readl(base + STAT_OFST);
 	if (!regval)
@@ -230,17 +253,18 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * edac_check - Check controller for ECC errors.
+ * edac_error_check - Check controller for ECC errors.
  * @mci:	EDAC memory controller instance.
  *
  * Used to check and post ECC errors. Called by the polling thread.
  */
-static void edac_check(struct mem_ctl_info *mci)
+static void edac_error_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	int status;
 
-	status = edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = p_data->geterror_info(priv);
 	if (status)
 		return;
 
@@ -253,7 +277,7 @@ static void edac_check(struct mem_ctl_info *mci)
 }
 
 /**
- * edac_get_dtype - Return the controller memory width.
+ * zynq_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -261,7 +285,7 @@ static void edac_check(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type edac_get_dtype(const void __iomem *base)
+static enum dev_type zynq_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -284,20 +308,20 @@ static enum dev_type edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * edac_get_eccstate - Return the controller ECC enable/disable status.
+ * zynq_get_eccstate - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
  * Get the ECC enable/disable status for the controller.
  *
  * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool edac_get_eccstate(void __iomem *base)
+static bool zynq_get_eccstate(void __iomem *base)
 {
 	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
-	dt = edac_get_dtype(base);
+	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -323,7 +347,7 @@ static u32 edac_get_memsize(void)
 }
 
 /**
- * edac_get_mtype - Returns controller memory type.
+ * zynq_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -331,7 +355,7 @@ static u32 edac_get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type edac_get_mtype(const void __iomem *base)
+static enum mem_type zynq_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -356,11 +380,14 @@ static enum mem_type edac_get_mtype(const void __iomem *base)
 static void edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	u32 size, row;
 	int j;
 
+	p_data = priv->p_data;
+
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = edac_get_memsize();
@@ -368,10 +395,10 @@ static void edac_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_FLAG_SECDED;
-			dimm->mtype	= edac_get_mtype(priv->baseaddr);
+			dimm->mtype	= p_data->get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= edac_get_dtype(priv->baseaddr);
+			dimm->dtype	= p_data->get_dtype(priv->baseaddr);
 		}
 	}
 }
@@ -406,12 +433,27 @@ static void edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = edac_check;
+	mci->edac_check = edac_error_check;
 	mci->ctl_page_to_phys = NULL;
 
 	edac_init_csrows(mci);
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.geterror_info	= zynq_geterror_info,
+	.get_mtype	= zynq_get_mtype,
+	.get_dtype	= zynq_get_dtype,
+	.get_eccstate	= zynq_get_eccstate,
+	.quirks		= 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver.
  * @pdev:	platform_device struct.
@@ -423,6 +465,7 @@ static void edac_mc_init(struct mem_ctl_info *mci,
  */
 static int synps_edac_mc_probe(struct platform_device *pdev)
 {
+	const struct synps_platform_data *p_data;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
 	struct mem_ctl_info *mci;
@@ -435,7 +478,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!edac_get_eccstate(baseaddr)) {
+	p_data = of_device_get_match_data(&pdev->dev);
+	if (!(p_data->get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -457,6 +501,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = p_data;
+
 	edac_mc_init(mci, pdev);
 
 	rc = edac_mc_add_mc(mci);
@@ -495,13 +541,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", },
-	{ /* end of table */ }
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.1.1

