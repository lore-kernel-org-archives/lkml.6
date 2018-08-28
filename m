Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641ADC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23D720842
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="CyU075je"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23D720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeH1ORG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:17:06 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:40496
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbeH1ORG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4xH2LKW6XBp4drkPfpojDkjDzALI3QVzJU11Tg88dc=;
 b=CyU075jei0IiYjsuQ4ucDDOycBkSLgVDKRYOXUViCsilN3Ms2HmyMWYVCSbL8qeDRmanRmWiiuEm843wv6EPwpgEw+yxwmduC5Ay460Qywx5Cb4aGQaNB1YdgUdbtc5kY0rJhZZWsWkQkeWsnvuhF/PS3CrVmb292INV8gCTG4w=
Received: from CY1PR07CA0021.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::31) by DM5PR07MB2953.namprd07.prod.outlook.com
 (2603:10b6:3:a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Tue, 28 Aug
 2018 10:26:00 +0000
Received: from DM3NAM05FT014.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by CY1PR07CA0021.outlook.office365.com
 (2a01:111:e400:c60a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1080.13 via Frontend
 Transport; Tue, 28 Aug 2018 10:25:59 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT014.mail.protection.outlook.com (10.152.98.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1122.2 via Frontend Transport; Tue, 28 Aug 2018 10:25:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w7SAPsBV018582
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 28 Aug 2018 03:25:55 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Aug 2018 12:25:45 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 28 Aug 2018 12:25:44 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w7SAPVik003716;
        Tue, 28 Aug 2018 11:25:31 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w7SAPO59003551;
        Tue, 28 Aug 2018 11:25:24 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <stelford@cadence.com>,
        <jartur@cadence.com>, <piotrs@cadence.com>
Subject: [PATCH v3 0/5] drm: add support for Cadence MHDP DPI/DP bridge.
Date:   Tue, 28 Aug 2018 11:24:43 +0100
Message-ID: <1535451894-2518-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(199004)(189003)(36092001)(305945005)(336012)(50226002)(86362001)(4326008)(105596002)(106466001)(356003)(186003)(47776003)(8676002)(14444005)(2906002)(107886003)(7636002)(36756003)(246002)(2201001)(8936002)(26005)(48376002)(54906003)(51416003)(486006)(42186006)(316002)(87636003)(478600001)(26826003)(5660300001)(16586007)(50466002)(7416002)(6666003)(476003)(110136005)(426003)(126002)(2616005)(21314002)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2953;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT014;1:EKhyjrgb11wEYCuAy5hTgSUF1C8jnjEkcIKE/VQx9Z2yrWLUz9tjjFMymwsbl7AqIMiy/ql/hWR0s1CZnCnn+o6PHOqqnarK5plEGmEWQ+/Tqkses1/k7mZTlXWWi2lO
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194b2b19-4579-4909-4ad3-08d60cd0a5ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:DM5PR07MB2953;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2953;3:lMG4EwXIijF/tSDmQoq3vpQBZUoYTSz1B0n7kiFoBJp1rGi/DIohDi0PooR6BpBvoTAyXzWO8pvNrqvBQdjsvqBkXlIgTURBUPf/sy+sKyzz3Us3z2+d0iXFhUybzu20VwAnzp0pb3xRTw6VKJ5owZ+ufZwNx2IrCCDIiKbEKW0FH1EeCTxF9OWL7BDyO04WSEJWSdO2eDuQ4a6gB7i2b5bbjDwtrH5xeeBwgK/yWt+kdmWLUgxB8YMnvakl9ARa7BYX+ftovFiX4IKAZJUeejyKsh+Bj4YPw9LtzUng6OEUPVSnJH3N6+ihz6DPK1yZ6vWeiBZ2eyURLGT/ym0j/A==;25:XopZDoUePAllE78LBfUXvyv/poeL6YgiwaMDX8MFJzSgOA4xRyHFSaorSRJc/+ZVq/xNkstthtbqElcX5McBzQnX4f6FzpDW92u1htNPwlgpdgi9rMViMdTg14iqJgTma7geeNXiqrXlpM36ShWeT0bcHHJAkU1VtnP/jINWhP/4wiwbRWOl/LwVTMsw53CoYiyTbe9dHJyBcX9Iqf1MNcx6Qyv9igbfZbPwjcOWs94AgrBllvsKw/AaS3fbasJSwwzcXCJImck5vqBzSN2tVArLNNpdLzXooEVskcMM6U/dAPOYVbSuxAwzlyn9eI+Y1i6DpDO9RN3bkuN3OYfDxg==;31:/BcOPEloGgA4PHFYmbE2nz5pJ14q3xas2FHA/RaNzfKkPx/+LEkUlAuC+3Rln+G+hPyxj/LAQjGsnfxYxsmc7J4s3OrIQ1ou1ZPOQKAdotM0EUEy3kT82qKW4BWBZIrT/BZqYDiLtCUMq+MImWpCeJ1wgwFUVWvqSA6snrxZD8BoMlsUIEmW6xUOXCnhrTczTt5KIk5T4+0NW83uburA5UT/U/ikdmnDglqcvFGoOIA=
X-MS-TrafficTypeDiagnostic: DM5PR07MB2953:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2953;20:ZApg5hZLAqVWOjkhkp0DD11SAjXtLerheXqhD4if/ndu46weiSXFZHsHYcre88GJXycgz5sC/XrKrpXcfoVVB64uEXd0BOEaDG8HYWnxU0drjvgGzNElFV+5TIPvyop96f41NYM8Pq9ZKbx+AMomPN2sO0UATPwqvWw6FZhz72CXnlUs7IS3xsV1TMhTIl9bE3AD+o/qn3JJTWPmvvJUFONhsZi3X/o/vQeJxURhZ+4Hq+yuBM40k3bJgA/nWSnn4RksNQfcaijsPZWAXJo3p7vD8lzrm+YGealEOIqMtNkxM/sJ8kEZKc14YpXL94zP5g4A4AyLbLZ7wQf4gmtuV86pkQx3vvL6gWemdK0plSHz+ahBzSJn9DV4UEkgwoMOnZA290ywGPC+N2OZk/DcDHMVO285Dh40UC/EeQ28ww0FnDcuqcztwikVYCA5TL/P75tFLz+GEEfsR5sr7TNzhsQ6IdObLKM6eNWXNMPRLQWfKpXkPEFgqct49ig1WY21;4:qRcNQACYVhf+49g9XY2t2Of6vUWuH8/zZvDz9DMjAAX9pdtRm3KO9Ucg7jAivl3BigE4HhNlfcaTkBvnX8ghqtSLnT8TwN1styETCEOZAYtOma5fozqHB2IebVlj6wivPIcC4Pcp3OYc7bchc+1s4vPWVAkA9+rWfPOCVv+MU8VW1FtD05nm6c1Yj+XwOPfxsswrqcm2vJTsKkeM6tge44NOWorz/ciNzsgJ2o1BYXcQPZo90rumLTM2ZVtj+PSVi2lnKlE8XyYRWPO05FD0YQ==
X-Microsoft-Antispam-PRVS: <DM5PR07MB295342C74F18498E1603FF1BCD0A0@DM5PR07MB2953.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM5PR07MB2953;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2953;
X-Forefront-PRVS: 077884B8B5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2953;23:uonroncZXU9QWo/9bUsbW5hgeudXnf2fy4EAZ915a?=
 =?us-ascii?Q?75az3RZJmx2V/OmS4Q5LJbiUQl9W1ZcFwqCLO3MXizPphMe1D9DskQfBg3fz?=
 =?us-ascii?Q?kRLq/KoW9ZWItIffeXWuWARyMXgD+lDLIfQYU0T7Pc4XXpi70GS+in2aVEWy?=
 =?us-ascii?Q?tZ0xNcUyp8aau+n0p4JkBiUg1QDGf730CgAohuOzlWSg6+E2S2+zY85q+jlF?=
 =?us-ascii?Q?WBtZ2BGJgbwztqvKapsvOYd/f4VgsoYEmotW/zKHwQHzF7w8NcaVmhavVun9?=
 =?us-ascii?Q?8ow5Rw2y0XgamA9eF009zEUGQVgG6eYg34Tys2OMgTOIyLsf72UXYCufSWOG?=
 =?us-ascii?Q?P7KZnaIMtDSNBwtIFnz4lboXNk0lgQCY5xA/MB4dLvKbxMeLFtBTvHg0d/eA?=
 =?us-ascii?Q?jnElrkuPw+0aC8/Y+dzaHewHf9aIK5lfpmAs/mpVqDE4ehuC4yMDIzxqy5xx?=
 =?us-ascii?Q?mOeQ5Cus4dB/ltdpRqnoXR4AFAFc/8Y51Asy57bpA/vbrmCgwHqCpebbtIFt?=
 =?us-ascii?Q?BB3te7fy1aGl5QBCKMD9AG6x5qsCWvUFxWF+D8h9QPKBeCZo2KyU/AkUImbh?=
 =?us-ascii?Q?lBCvUNIBiV92Bzo6JuWeILCr26N0OTO9umWQYZsR1/kKrGCA/8ih0UdGwxTN?=
 =?us-ascii?Q?FY6ILJ5+nlSyeYtGIwg6yv2Krsmk5Tp5bf7pN4wgYZVWuDyBhRRDZC8NeLlu?=
 =?us-ascii?Q?n13wV20a7i3DQw4nNceu80VVzYNnzhqzhrDJu/8ympdtnWCNSxLD6dc5ksr4?=
 =?us-ascii?Q?utBLmCpCj9lu1uVA00t8EH3LdwEtcHZhvigbXozgsvdMCX6lqEHHc+1BBQvJ?=
 =?us-ascii?Q?iN67SftETv9HBIt35ryJXKtSV61Z3NdEDNRKWLqI2PhZnAhzQKQ6661QJxtE?=
 =?us-ascii?Q?q40QGZIQvde558U/wwZ90Pi8wSPWesw+nvsqTgmIoZolxNF8rp56rmj4L0u/?=
 =?us-ascii?Q?VObQi69CgJSZGvUPJJAF4PsLw/Sh72HJ9ReF1wMxke5XiGU3mnlT+RaBkmEI?=
 =?us-ascii?Q?U9cDg5syMU0hr18uD9XrYdlrhakd2wEIBXYPI5tWVKW0vMomwKHNCLTb/sqj?=
 =?us-ascii?Q?8pqSMkQDhJUNEZZWooiG24RvuO21gRPNaeyYIhENTou/EIhPoOD8sEgXIq4E?=
 =?us-ascii?Q?HBWNNGobdkFbUdHYIgq0KQFaKGS0tFPQlkFSahYQSSRTF4HLpylIQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: mkwHTOKXsxN1RyT0n3uuFbDuNlPub3kpezA4H2dZHfqC6Woz88a8rNj3jx79U2Z0tig8Yk7UpFRQ8Imh8cavJJCH3ihg9hTE6HXiC33J0vTBXYF2Mpo/8kfH9e2h+uBT9dbjgZ+hI8ek+xnOHBPofpXg6CJ/E9gjaIvt3Kk7M6TuFqjvKr7UqB5lhnU0dUdlogGtHdO+ajmLgbNllqdB2iWI5OL9Ppa2BlaoOhPMfJ+aP/JtWRcww56cINXZNxVuw00kLuss/1AHpRPE3UfDiJcIuB2aGk37O4HlZMnDpxI+04YCy+z16yYkR+nQ5emoNI7bAm0n/C/DOX7KHeSIEgHbqaRFKh5vaJyTfX90WT5DPsXLQRKlDQCPCfi/E4h11+WxjCTe0irGtUS+ZQTgTA==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2953;6:AlNoAZ8TGdSwYAum6ufVwWV9J3RDbBJkNPM0187UU54XNeDUPaWcFwFT+JT25UieDcaxj7BlYLWsKbQJME0LGX1eKOLUuEtLgu/fzF0yMDZyzegvsOomovazvpQzj0p8bfILhOvRcZeTnKx5zqJsMnbcD1DdQXLAlv57zyEuT9EjaDPLhiNP4HDYbr6Rgq/Y36nE5gDxaTH6SBwpNEjI7bIOEMlNb8MYOQ3txjaAGBQ4aia03bj/lBQWuCHQ4Gd88pqfd8D84lYOPkP1COVZsB3ZDCNduK9GioTZ0sNuuS32ODiLjzPBPzlJOrLBBuI2gF0qu2fwdXZfII0oHyjsq4dJ5oerX85BL7gMU4sbhyT/q2rao1EiaJCO1pwk+9QDoqPeMa4sHv9t5lyWpk2opNeaVcI9ls1vu6k6rsRYolvKi5sEZvFR6VjBJMBK4SH8wxpHC50TsAICzsUJhIez2w==;5:DvCSaHQRdyuvzqcH7c35rKvtSDlO91a9pbl4ndhXiK7ha9eDb5pDxcLvk54zvYIbLv69en8yL7+LDZ8OslcdcHqhvh0/JreWcBtYEjXcBTwgq2lPxRWx1RfxksUyTN1D+jjH390oSjpGDZHs0AvQboYNmURxqdKgAE/5+dDTeLc=;7:v5oyfHwkaA1iOVBrTyaq1TQt4eNqczBSLnJ6I43AJUTqMFyH9wsf13ZRjGkog21X16cNkjKuygshT6qDw3py+HPSI7VKe+UsENNQx5QnnVRhcyC3X8OcXJ01lSKTOeH4v7uVrj46z+vFsLPiF78IGgHI8WCmMUFq+uwxlrEfmeUKCm4ONhbMC2id3B+ndcykC6bOnOq8XCOyvfFCi1FLgfPaXXnNkMrE/cPQ8O2L1kczHj5yi2lYYIeDWvfyd/Mq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2953;20:Gj7C5SGpd/M/0U5E5UIXIJM2TVYq3Au/4Gr5VHQAyX7eicluOH9CVo/quEQoojGnbv+Wtn9nEe8gbdTXAvTllaiuPR778jXf7F7Fi/+U84qP145PlBry0eDCgD34SQU4+qPhweDZo7OvTkxisIcXunP3IP0pHHa9dWunPisqBmWdD5h6VmcijzvA/FYWcbxyxmrWmCjRckg3hP6xB5Pr7qSncCSRNaPPu8O0VR76kPuRuET1tZjyOyCc4tWjwfDt
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 10:25:58.6338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 194b2b19-4579-4909-4ad3-08d60cd0a5ce
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2953
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is the series of patches that will add support for the Cadence's DPI/DP
bridge. Please note that this is a preliminary version of the driver and there
will be more patches in the future with updates, fixes and improvements.
Please keep that in mind when looking at FIXME/TODO/XXX comments.

Initially, MHDP driver was developed as a DRM bridge driver and was planed to
be placed in drivers/gpu/drm/bridge/mhdp.c.  However, there was already
a driver for Cadence's DP controller developed by RockChip, but that driver
uses the different DRM framework and looks like a part of a bigger system.
Both controllers (including firmware) are quite different internally
(MST/FEC/DSC support, link training done by driver, additional commands, IRQ's
etc.) but they have similar register map, except for Framer/Streamer (which is
noticeably different), so they appear similar.

The following patches contain:
- Moving common code to drivers/gpu/drm/bridge/cdns-mhdp-common.* and
  modifying it a bit (mostly new prefixes for functions and data types) so it
  can be used by two, higher level, drivers.
- Modifying existing RockChip's DP driver to use the common code after changes
  made to it (use the new cdns_mhdp_device structure and new function names).
- Modifying DRM helpers a bit. Some are required for new driver, some are
  updates from DP 1.2 to 1.3 or 1.4.
- Adding documentation for device tree bindings.
- Adding preliminary Cadence DPI/DP bridge driver.

Some of the things that will be added later on include (but are not limited
to):
- Support for Cadence SD0801 PHY (PHY's driver should be on the way by now)
- MST support
- DSC support
- FEC support
- HDCP support

Changes in v2:
- Added actual description of what the patch contains, what is it for and
  what's going on here in general.
- New structure. Now we have one common low level driver + two high level
  drivers - one for RockChip with minimum changes and one, more general, for
  Cadence.
- Dropped some changes made to DRM helpers.
- Updated the device tree bindings document.

Changes in v3:
- Corrected dt-bindings document
- Enabled some clocks at startup (since FW doesn't do that anymore).
- Changed Firmware file name to match the file on Linux Firmware repo.
- Added SST audio support
- Made common functions (in cdns-mhdp-common.*) public.

Damian Kos (1):
  drm/rockchip: prepare common code for cdns and rk dpi/dp driver

Quentin Schulz (4):
  drm/dp: fix link probing for devices supporting DP 1.4+
  drm/dp: make dp_link_status and dp_get_lane_status usable from outside
    of the core
  dt-bindings: drm/bridge Document Cadence MHDP DPI/DP bridge bindings
  drm/bridge: add preliminary driver for cadence dpi/dp bridge

 .../bindings/display/bridge/cdns,mhdp.txt     |   43 +
 drivers/gpu/drm/bridge/Kconfig                |    9 +
 drivers/gpu/drm/bridge/Makefile               |    3 +
 drivers/gpu/drm/bridge/cdns-mhdp-common.c     | 1108 ++++++++++++++
 .../cdns-mhdp-common.h}                       |  135 +-
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1308 +++++++++++++++++
 drivers/gpu/drm/drm_dp_helper.c               |   50 +-
 drivers/gpu/drm/rockchip/Kconfig              |    1 +
 drivers/gpu/drm/rockchip/Makefile             |    4 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |  234 +--
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |   42 +-
 drivers/gpu/drm/rockchip/cdn-dp-reg.c         |  969 ------------
 include/drm/drm_dp_helper.h                   |    5 +-
 13 files changed, 2756 insertions(+), 1155 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-common.c
 rename drivers/gpu/drm/{rockchip/cdn-dp-reg.h => bridge/cdns-mhdp-common.h} (81%)
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
 delete mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c

-- 
2.17.1

