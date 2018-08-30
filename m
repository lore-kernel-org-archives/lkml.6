Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9661AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BF02054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KpqHGXU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BF02054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeH3OY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:24:28 -0400
Received: from mail-eopbgr730042.outbound.protection.outlook.com ([40.107.73.42]:13872
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727496AbeH3OY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLQzl7iCPDNVVdXg/8Qd0k6LL7AENjWKMu5NBvbEKX0=;
 b=KpqHGXU4W0ygMMwe9aD/yWOhC6kdYlg1hmmBsLTMANlOQqlEu1Iqaz22edlyzsAOrKK2z8ol5ZPk8LuDfYtjm3yzemBuO0OBASa/rG1CcoMtUKWBywbW7KyHy7ebwqWSJQtpaOPLJt70jA9Yj86zanFPVIj35FKpW8zIYlZMfHM=
Received: from MWHPR02CA0049.namprd02.prod.outlook.com (2603:10b6:301:60::38)
 by CY4PR02MB2680.namprd02.prod.outlook.com (2603:10b6:903:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Thu, 30 Aug
 2018 10:22:58 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR02CA0049.outlook.office365.com
 (2603:10b6:301:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.13 via Frontend
 Transport; Thu, 30 Aug 2018 10:22:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Thu, 30 Aug 2018 10:22:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:57378 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvK6A-0000WI-QD; Thu, 30 Aug 2018 03:22:46 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvK65-0002P7-Lp; Thu, 30 Aug 2018 03:22:41 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7UAMUrE003945;
        Thu, 30 Aug 2018 03:22:30 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fvK5u-0002Mo-9e; Thu, 30 Aug 2018 03:22:30 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 6D83F121447; Thu, 30 Aug 2018 15:52:29 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <leoyang.li@nxp.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <broonie@kernel.org>,
        <arnaud.pouliquen@st.com>, <geert@linux-m68k.org>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <lukas@wunner.de>, <freeman.liu@spreadtrum.com>,
        <vilhelm.gray@gmail.com>, <tglx@linutronix.de>,
        <baolin.wang@linaro.org>, <gregkh@linuxfoundation.org>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add Xilinx AMS Driver
Date:   Thu, 30 Aug 2018 15:52:16 +0530
Message-ID: <1535624539-7839-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(7416002)(47776003)(186003)(51416003)(2906002)(72206003)(478600001)(106002)(2201001)(36756003)(63266004)(336012)(316002)(36386004)(52956003)(305945005)(81156014)(8676002)(4326008)(126002)(6666003)(356003)(81166006)(26005)(6266002)(103686004)(486006)(48376002)(50466002)(110136005)(476003)(2616005)(5660300001)(106466001)(16586007)(8936002)(426003)(44832011)(50226002)(90966002)(54906003)(42186006)(39060400002)(921003)(107986001)(83996005)(5001870100001)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2680;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT007;1:DFfEmYUenSrU/XOL5qhrMb28XB3DUBNtJeLOzpAoiZiXb4UDFz80iShUIy3UoTGULXAUdm1S7rnKwZJyYPcssvLekcIKlH3J/tQPfeCp791ls9Tt4vATSdWyPA2p1Axe
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23b26689-d10a-4808-3e5e-08d60e628dba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR02MB2680;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;3:Z6ZPNKl4R14IM/3w/xNZlWCrADtVXlh5sHDveBNscvjCjMjNqea3z8qxuWb/Rnhireo+plhJwH+KAkEKKQs2Sl3KZS1GtFX2aEwBvgA5XEdlFy7SfxVWUXcl143+61mQbnb0KBbjX72s/rmJouVgyH3+dSie2KnA5bTJkrHji4KPIK5ALXK8pebSwkCeEXcHmonaZdWSA2z2AEjQ/7P+vjcXv33bVlHbWJHsif3DMAaTey6mHhH/mTEPyfF/K7qRaNU0cQWrCFCFV8cZ5EZM/FG3B8oFf5/gCIxiwUP3S9yU8US2HwZU5mWYnS91XlR0LPlzKFfG0GMQ1gfKvIHw9BJjGU29yC7fWVFyTQvFTUY=;25:E+QMlc6asRrzI1IDyOdjBzYzXhujDStWyGJayxsm1Cz+ydPUvYga+mIaQvjEC0CcYp0NQXtCZEuh/XJLnUeYB78IJ5CvHgUj35aQwNhnm3qEb6x9p3n0z2ZZn6f6q7Hm8f/IQ030eyTxvBDHVAbFDMPe3RvF2y6zvV1SkLC8I4VNdovb9RW55P7ZWfO8GjhobTchsRTeddUO9bat6Ttm+8u/cJzi7koDoz9Yefo0xNtQj44N/+2Zat+6zVIDLsukiDSmvdDwACOP0t62KF2vX78K1vptZNnrDWiJG4P4L9P1LynqOsI75aB/DesNcQGviFpRn4fAm/q9Nwth304ZCA==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2680:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;31:6bIeM/dSWdZigP1bjJ3zsllerNCfv2v+fi+U0x1EMYS/lHBbPB+XG95e4pcno95iKThOb6vhU0aXQHJ4nkIwnvriH+oE3KK/BYajh9tCqxQOv7ftkshvtB453mmCmJJWmJ+NBSfKvnFn6cP/Di5jLZHpSHarL87YzCmx5IyRySc2PsRxj1PVDy8zjwTrkkl0hXa5sHXeQ6rwzsQ6X7kCgvfU+knLv4VxBDol1ykl7Cs=;20:WZ3gNQTw82+5RzutyIvmYWWklsUrZalOaRRI9gZWF+cHrAG6aGt+Sar6DgpE5+28VHPQpB5TxwjXKj5nnQd/ueXzUNmjndASSXMo5nt8NQr9owRTnGLSzeTM+BBXPBrtv4opQ+guSA5LrCzvg7+Sl3HK66KKQjfWX5zbjcv81IYFDrYFxJgi8vM1A5q99Khge2eHx/TMWZKaHNACe3849Xnpwwyd5QF8bO0/krPlanqw6tKNO0/HuhpfjN3C7aenplZiKKr+/6OWiBT0PikoDhj2L1emC9WahPYe98y/TdaLB5onuiLEif8t15kXElxOkRR5M0lVzQS7bL5K3dJ3SPZh61E0fu1w+/sTM923n7dI8ene0jMuvGtXu2/KcUi/jfGPgYLV+uiFotI0IEHERu1MSFB3arlnM/t6Be/MNqeD8EmWIpYwxWvFOsNq9A9jcTJHVGZmB2+wZ6Zl34wWe73rsK8rt0OCmukxyGPXRQy3BB3gR0+VmNTDkb4IyADu
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB26801AA546D7B64186F00A4BC1080@CY4PR02MB2680.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:CY4PR02MB2680;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2680;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;4:E/G2MNMz3B7NXIfGww3iIZINe1pwkyEwd2MFoRH3F+vJCF4xD2e4pjHglhTg7RPFrkUJ/c58Wi/KxVZPIVkyRShDd9Kxc+UC+lUzgWPbpPU0U1TKB8nltrjf7+p4qR9EV77MjKybpRb17fS4QNAVJrHEGvp55i50Y2b6z3O1zXgHTPz8raeeBJ4eFE6KA8Vy3Wg5B692OInDCo4sKXCXkgU08cFWoo8WMfoPjWj5MQWgOunVgGWvqsNLFfAVGeY5wiGhWroF5N3lmc6TrjMBKg==
X-Forefront-PRVS: 07807C55DC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2680;23:7T0uMmkmxpNgj3euzQxxA56ocd1AYEajqt25UOtNT?=
 =?us-ascii?Q?MTpbmJlXa5HroJjd4fjX/abjxM+t4WhWp5MJRdyf96TDfdddoBHvCAMEcSnf?=
 =?us-ascii?Q?FKMpw2Yd1RboDB/V09Sa6FXlV3lzVrgp0RdR82GLjecpHOBXdJwSDqXSj1kF?=
 =?us-ascii?Q?4z4bdb8b94fa5taRrhdGcFiEmEuPPXpEN67wrCtB0NGkwe9S8uI7bf/2ldn5?=
 =?us-ascii?Q?2IaDPnfHsfKDeGP8ceIlPS6jn0eXuoLNKqMvMyYLTUJszQXsGYjnv0mfZ4PL?=
 =?us-ascii?Q?ddM8jjeblgpgxuoVlhDPdxavUYxIfMrHJZwp3rTqd5+UDQnTvRBcbKVOMOpB?=
 =?us-ascii?Q?irIAvmJ64ftEc3OxXAZqohU9aiwSiqceAfuIb0OD9RuGsyWhZOCdyF/RNQCJ?=
 =?us-ascii?Q?qXlMjoqPQUBG8shlwxpAdE32jy6F+JEToBz+q5pVX8cDqnKtwl1TV7xFJwhk?=
 =?us-ascii?Q?S2QhNeAX+aR1sVfvVxiXQEvMWUp/63aDasTH/lBObmjQdCZh5MGodbbaL/kf?=
 =?us-ascii?Q?RdNqzgxSGyXXCwXumRSJiSm61WA572b97FW/rkgdqBFqkC+fXOTApUdyH53J?=
 =?us-ascii?Q?Ib4JeGXL8fesgvAqfTGplKclwiNt1uUx5fBYnwgp3o8OQ2XLM7AHZlK8FSzL?=
 =?us-ascii?Q?KdRIU/xvHmsFreh/6jg4uUF0QbBejq7wm6InaskEUjs5bzxk3/6BUlBjQwhw?=
 =?us-ascii?Q?gIRi/RHrderQHrXPgHmEbAL1XCga7mYg6pRthL58UbIXuZ9ZaO0Nzt47QTxw?=
 =?us-ascii?Q?a6r3OeLMEAH7UdCQZ7PZyNPuS3xkhWtxjIO554eRk/DeVHrtT0Lrpnq1yfMA?=
 =?us-ascii?Q?cqb5TkGbAAFBtCkD0ubVTao48XPW1770DsB7ICPqcgtpnATQeMbN41h6s6Xe?=
 =?us-ascii?Q?wILU0BYwOHTKBayyDsxLFdVdaWQ787C0+kN/Tcn9aX8cVYO9mMND4SbluLWk?=
 =?us-ascii?Q?AGj5YEUvAdmeUTGcHZLn+ZYnu2E6cl+ePXFRu2ii5KV7OnPLp91hbjploYxC?=
 =?us-ascii?Q?sugQqyThWO5bqafxtAZpNVevtlR1Th2f0loF1llgsaNi6dJIKuyZm/OBgd0O?=
 =?us-ascii?Q?Uz3MVb/VvlOmwUYyLnUg/a6h+M8ghHdpJc6dmOE7A5JmYw0xhchtgW3JUd9n?=
 =?us-ascii?Q?lEz5oLUqqbNGQZSybxBNEv7PQgQyIEo05gSPekNc2jhxOUFrSe8WQJuZQtaG?=
 =?us-ascii?Q?JADnRz5/bqfgLLP6hSNamfu+YZXcsyrl+T86294j58ucAB1KUfVk5uYwLigb?=
 =?us-ascii?Q?DTvSQnkzpNLz/mpxAO9lFRawFXAYafEOJVGHfyF98bB91uiANdNwPpPjkis2?=
 =?us-ascii?Q?uUHRgVBvHNKX6x3T+ffbsU=3D?=
X-Microsoft-Antispam-Message-Info: Anm6B0oprs0gCPLNuIz3ONJC26GpySmtQU6tBBaG4JgsXJcvlfk1EHfsrlkV7nmEj5xJW0qZUmbsLy8ans2Z6v+oTgPzgJI1/g+gJsKyCBViiyNethb0peaC7BTCjSSyL/WX3qfpniN68L5yVGekps5E5glug0/SrrmUkYfSte1HCC0Qco3iUXgLTKehf8FpYdYy1imQS+Ktky/lYcwkM3UXHlsMF1+XPjsa7joJ5xXzTjr/3KZNiBxEd9BqNo1wQHqMs4H0yUqz3bvMTqRrvPuLU8Z5JIRgPUpZiOOcfBtn0T/b1w4CdmpLk98fOD1HmEQCCXB3IPhi7mQEAnNZ8BFcnjDZwMimXjPyYR3JV6U=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2680;6:4tNGMNyWNyL7p5E14pUccswnB0QB5WkKZW3RD5FMS7MbjL09lcCJHoPqpOexJVOzyHbztW8tamuVLWOMeC3NFjNId7VA2buwIEd8ax36S954ljjQhVYb15W0unsjZJBRO4GSjqFgTpz//+fMcmhOdyi6f5ronpOX8HV5TPRoydEpTDMsL13/7GYeUi3tkC6azu6tKFwuAz04dAnNxpJUMFKtvOMzdLHY4r1ERVx8Wm4Wr4M2mh/icLhOQ5TuHS83kc4bgoiXY/J3wxW0jPw+eyZq6g6TXJC9DOwD+OTwov59qOiR7Oaf8Fp7y5aZH/DhPVDF0kSab7E3eLg4koOZKbb7J1cAzMTxPuo/JTk4nMolbXG/nNd/jUHOi4/BcKvDpy7vs4xsIBGXcmY8+Ifm5973EnIe7Gun6CaxXnoiZbXP7atYQvzVbTSJ3aw1kGveVI2urLKXbDX4qkmCP+vjQw==;5:2DOZJkW1i5sks8jUmUbNDmZkdFgmgrACH2V99B6MNTMLFRPq9vvr3k9DxvXnqoGsRoMxNE8ZG8+Jk6yPA4cs3cRxaLXhkTEPvggUG+XG7ChrkZKyiiEwh5xWPklXdmxyf4hZ2K1n04vHh5W7kg1iXZmdXo0Ovob03oI5MCt41hI=;7:SZAVl2JRZT8mX/vKjabocZt98jvum4is93m2kGQQm+Ja7uPXqcvCWvaeqPX1o0wdl+Pj4P2kvybbOz/SuQ8ynEqqLTvsFcKZpcbazQwBU72DEbMKctRpFFPsx+VFpwh46eirl9+1KFvFARCgQAoIaigCzhRSj2RssepbR03HJSRHmXe2wPBMPXv4gYKXl/9/MELhI4kIjCMLsqayEL9A1oH+MRE1GoznbwuT1i8WjthAG73N4SQtECOxfVuY/hJw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 10:22:47.9222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b26689-d10a-4808-3e5e-08d60e628dba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Xilinx AMS driver which is used for Xilinx's ZynqMP AMS controller.
This AMS driver is used to report various interface voltages and
temperatures across the system.
This driver handles AMS module including PS-Sysmon & PL-Sysmon. The
binding documentation is added for understanding of AMS, PS, PL Sysmon
Channels.

Manish Narani (3):
  dt-bindings: iio: adc: Add Xilinx AMS binding documentation
  iio: adc: Add Xilinx AMS driver
  arm64: zynqmp: DT: Add Xilinx AMS node

 .../devicetree/bindings/iio/adc/xilinx-ams.txt     |  159 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   26 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/xilinx-ams.c                       | 1081 ++++++++++++++++++++
 drivers/iio/adc/xilinx-ams.h                       |  281 +++++
 6 files changed, 1558 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
 create mode 100644 drivers/iio/adc/xilinx-ams.c
 create mode 100644 drivers/iio/adc/xilinx-ams.h

-- 
2.1.1

