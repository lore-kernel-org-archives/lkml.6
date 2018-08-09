Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A7CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDCA21C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Cuat25u+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDCA21C16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeHIM5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:57:36 -0400
Received: from mail-eopbgr720084.outbound.protection.outlook.com ([40.107.72.84]:55232
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730090AbeHIM5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCeilz670x3/2Z+K9L5HwvTVpItQCU0PhlGPDL0hV3c=;
 b=Cuat25u+lbJjMaGid4nk8ltkRb228RhyXGmPlbc91NrM8qa90UA0oQMZkM0zFEcpbG1ufY9INtn8/Oi84t+rWHUwS+11+cR4YRPWCmU1YFrJhbSflXoUtOZmpqglUMdUcOGGmqaZyJD/xCq4mLJ6/xe8acAkIKlIYklRIOZdAmw=
Received: from SN4PR0701CA0012.namprd07.prod.outlook.com
 (2603:10b6:803:28::22) by DM6PR07MB4716.namprd07.prod.outlook.com
 (2603:10b6:5:a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Thu, 9 Aug
 2018 10:31:13 +0000
Received: from BY2NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::201) by SN4PR0701CA0012.outlook.office365.com
 (2603:10b6:803:28::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.19 via Frontend
 Transport; Thu, 9 Aug 2018 10:31:13 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT006.mail.protection.outlook.com (10.152.100.143) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1059.4 via
 Frontend Transport; Thu, 9 Aug 2018 10:31:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w79AV6VI029442
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 9 Aug 2018 03:31:09 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 9 Aug 2018 12:31:09 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 9 Aug 2018 12:31:09 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w79AUsJc025588;
        Thu, 9 Aug 2018 11:30:54 +0100
Received: (from stelford@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w79AUsmA025587;
        Thu, 9 Aug 2018 11:30:54 +0100
From:   Scott Telford <stelford@cadence.com>
To:     <dkos@cadence.com>, <adouglas@cadence.com>, <kishon@ti.com>,
        <jbergsagel@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Scott Telford <stelford@cadence.com>
Subject: [PATCH v4 2/2] phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY
Date:   Thu, 9 Aug 2018 11:30:30 +0100
Message-ID: <1533810630-17673-3-git-send-email-stelford@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1533810630-17673-1-git-send-email-stelford@cadence.com>
References: <1533810630-17673-1-git-send-email-stelford@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(199004)(189003)(36092001)(316002)(16586007)(5660300001)(42186006)(11346002)(86362001)(575784001)(50226002)(26005)(446003)(36756003)(105596002)(2906002)(107886003)(2201001)(6666003)(486006)(106466001)(4326008)(336012)(426003)(7636002)(8936002)(126002)(478600001)(2616005)(47776003)(87636003)(26826003)(14444005)(8676002)(246002)(356003)(76176011)(51416003)(110136005)(48376002)(50466002)(186003)(305945005)(476003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4716;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT006;1:g/F+iKdxpkcVO3fXSDLkMOWH2WYkLC7TvUQvcABNMceffwLctEv83WJQ/tyLutwVRN0YGAAZZDduUu2QQk9DLlj6gHbjqtljTXnpZSRfCqty+fFh1VvGdGJQfboUNnwE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05ec62ef-79d5-4bc8-e0e9-08d5fde33a8b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;3:lLkTftiLmW5yjG7eZeZpOWre582S1aGuWUfTeWtIXQ0kmJ4G4zXS4gQBYWoyAhF/XCwCQVs9MR4b7uYN9JTYDVI+AhBvwNjJY2vhH55xu49n9SOP5BIEsoxf3lDQpd40wJjxbkKtbSr7EI4JW0tT5vbDOYemsz6XQdynyx+OqCcRIh2o6afLC3oGFOqvk1U508tG+QbxrOxW8KogMWUSwhrqzI7FZSgGHQzWuPIgIjVhPR5ks3r7LeGcWzC/pgInIhjYdaKJ20wGxaGvJIcVbneX72xUfDmpsrueC7+lrZSfZeof6tnyy6RjotIEV55uNIO1B6pi7IXuBj+BAgGnEiAry0eIFVfIucJwGS0o3IY=;25:a6z7Ba00IB8ehqVqhYAfD5xmx3jF3gVi8Hr4+GSkNJUQXW0ya8rAAIQ97nWYTrUs4piWSglDE1nxUWpNrRODrV3oSxWusLajNOu5Uk59XgaUFLZQBs6VhXS9rOWbtSnHbU74gIVU7jS1qY2yDDjdAjBGwboXb0O/M2XNu/t1xfnxyfbbpnaTdDyeQDvu4rSoOKdGpjJxQZlr1aRBL+rViUr31suGmsOQngO84osrSr0YpfLxRDmDxl3itXu8XnatiAcYAb0THKhYww7LDSX1x8vcFJ46JJP4KAaSorrc8z/aqloBxXkDuCKeyeXmhBmC7EkYKFi9FKuIOhxEQGtxMQ==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4716:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;31:/kfpn8peln2p0X1kMuGxAFQwWmRvpxaADkUNaqkgmJ1/mJ5DkkEfRL4iZK+9I2WRE+sbiIOluvFYVWI2xqMKre48fv3jkEkmQ78XEYj4DcIdtkuYUSb2vu87CwXrJjVhp1CFNIa4EiVnl+OY6MI8SFdXq7/6Y4flFtD40AxtZOyrEtWCr7YxluU5yYBqUwoTvR1kGkO/TJ/5BtXi2I2quy11KWgnXOxuTFp7l1y7Q5w=;20:jjMrqE7dTjW0nC2QXX3pS7RL/QvgejrXjiNuS3eUTGm68nRtusHQZZ0Wdi9mxBgFWhKb06+cyn8mhnos3cOAdd70qkGWKD7ITdPUsAon2xmYzgqgHH+0mlS15LIDM5bEda5UB03AAFTWhPwrV7nvvdDTQMLRMQonNe66Xi4hSRdIW7i2Fm7gx+bTis0/Z3UsRzkKEaCSptekoY6sdmzPygkY1WfdLY/3/6zuHowNq7/hQZMhZG504Q8D7pU9tqMU1fMIfPa6xzmM0yzpafNhClRRczXibI7Yh7oA3HsY+HsWSppU/m/ha3bUtSFoe1y68XaPY9syzwbkEIRpuMvve5PSbo7gXRDumn2KmMUpIaiL5BtT1g+j+tVnYuR7RDxCV5SwH09fDqB6ifrPhuzbq6L8AD8+7rUl3ZGfT2JERmraYPiZsqNEAZck68hKP5Q6CceCK9CnpGALBaLdd0dMmDvKQjQZQk7YN5hfCEBylfdx9NxuaeyUFiXbeiwbpYJ8
X-Microsoft-Antispam-PRVS: <DM6PR07MB4716145AE17518FDF4365060CF250@DM6PR07MB4716.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4716;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4716;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;4:D8cQAeQQKq7pYOhdBQvrv4EnQee5zZtIe3U3eYG3+/SQjMolq49VEwcj7mCkHOTx5rpt07ny8W+u/wldcBxW3VyzalX1cnznNljX50w2kfBTAa7lBhXugpjDprT6Y+fk7wxIOxcMIPhQGyKeKOVScdyakfWu+z2pgckuUy1BEcKoMs37FI1mTAQK1DBvIJZYailNKxuWiaA87YFQ7IZ1V3XjEAhNLhx4yxi6MEpkhP7NgWP7Bwvun7/iYEE1OVdMJGpqZLC8Joqw+qUDCH23plojTIQVBQbSaLb/1iScVW8/ZCPl5e7OzFtGZ+0zSjot
X-Forefront-PRVS: 0759F7A50A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4716;23:YlnfrIdAQ7Yk7ZFA58GgguMM0w9y1hqziTAkduFcz?=
 =?us-ascii?Q?1ojxy/piLY/5ewKOb20zDcZZ7cLs5QeuFiaLAekdeKNqMpc7q66qZiJYppj5?=
 =?us-ascii?Q?hHxfBloGYLjpL2d3ulZFJP/SzI3SNDnYjeGRSNWtncpUgtt/PKXpm56OvYuA?=
 =?us-ascii?Q?uRjHqLz+sm96PNLA6KuymmEYQFeHuRAPu2vAffKSCpAs+LUit1llB/u1P3eM?=
 =?us-ascii?Q?LSExwUXCc11cFGli1taFOP6FpMsitX9USyPJpcewaGbOR/xQTplPwMd1Vuof?=
 =?us-ascii?Q?V61njxwPEBzu1ViF/QlnmtrQehofC12zGY996FwzPhGSegE6zqMYxtmMhEUi?=
 =?us-ascii?Q?nVGTYJXCCzJ27Fw2KQ0NnnZnjg4lQnHvA8Ekr2ocA1NgceKH/qUqTm1JCasY?=
 =?us-ascii?Q?ZmwVnFW519eEdbl0jgAtghtUg/FnQVezwhtx0Sb4oqdQ5hJJKnaINL9VpazO?=
 =?us-ascii?Q?uwX0jK4NtYLuCyWIkn6K4GZT96DVAcv0pjBO8uEpx28QZL4Nymt2Bm+3n67b?=
 =?us-ascii?Q?VTgs3d8C+VziXc6lMpHhXOggqW8va7ucYdnkPnLiTpZufum0GK9tgAI119Jh?=
 =?us-ascii?Q?F5AOWrjq0hXKYDsS0SSm1KNirqEfSAUtjLpNrQHtcvWfMSkwR6lq8BhdZ+uD?=
 =?us-ascii?Q?48KL4frUCpqNsnJXETIxS1lgVKvHa1ZwE6yAQG1C89gf2xdnPSi8ZTNZdGyH?=
 =?us-ascii?Q?1YPeGeJfUV1fQfHsV12NVq9DQG6/weVixZTG0xHNSX1bEm0SnMrVOYfqzDNp?=
 =?us-ascii?Q?hab31Oc3kI2wNg+2zlT0O47RdnLtnVOhEc3BuDuGmzOHRYNrNVtzBMq5zv2F?=
 =?us-ascii?Q?gkAOtNygR9d1ceFAbHu2KYgGYz6zuy/kZ6GKdyRkgELUQMwlgL7nrtpqK7qM?=
 =?us-ascii?Q?2VjpYWLJwqRepCyqN//mCLs5c5+1yoqM8hkTkVy7MZh+/HvrAInGrzViPRw4?=
 =?us-ascii?Q?Bu7Mi/fUoWrm98IjryxJDYOPBFk0FkbcKP0GvkrfxlKs5genuC8A4HYBoBTW?=
 =?us-ascii?Q?4ZnrZ8Rt7p+UL4R8X0gIhXF7VPzLFs+WyqCdhEuVGEw2RCQKOi0ltQeOLSSp?=
 =?us-ascii?Q?3I/LwzyUAju8UJsRd60d9RYettc0I54zH8IDeGRG0XwBUYcv2hJp36a2VOgZ?=
 =?us-ascii?Q?eSYF86KZtIIqVGzU1Qufv7izgfdNuhv?=
X-Microsoft-Antispam-Message-Info: trKJyNvT3rGOr7PYxVMo5b4Pjm5IhhnD9iKuKHUJCPPgOXTYK/xncNEzgPwpue+5IE9TInkQgpH552v2ns9UIWI59tjvs7LoUfN46YakNCHt2c7oMn9pUgicJUyEOYGmkPVMBTZZMFkWIlZAOgOG77y2+h/ipIYHyPB28v0IWGN2FqBRPIn4R/Y7bQo6bxqTenAWHZaP1HcXdo+s3t+95GwM5hLRgcTEmOjrQH4wQ7htZz0JB9ZImsT6wRD8Hg8DY9MyGFp/GQ9FeclgHzF3n0z5v3j6xVDeyXTyESczyA5l76/Fg8Ojj92r1Qt5LDS2PbS34yEt2j9N7gMD5uI7PIc3BwIsdlNBOHQVGUweSkGx6hdE9NPJXlEUn/ExPMbEU2qukOjiempNRxvI5lV/Fw==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;6:CYECNI6rrNtCSQSM6spj8L6PCPXe76t1CjxQ556U8cvafJlS5HVLm51DFcS2+P2ZCbwLRqjvNZRrBzq7b5s+vZBFsGJ3zQWyVqsbuHcLYrgYq8gPngUlcRoz3BYa5vlRxRuexEV7zncp557DENwwGMkRddvVBAbp0lRGDqYZSCpTZ2o+bKa9leb2ip/Hi5YYTwcDeqSOVLBi2NfIIgW1DtqlTg+egkIA9zLA2urZNdzukszGMguLAqIK1s+Q/mtSNFZ+X7nmzf5A8ubTfozFnhJyMnszNMafGsmzSQDGxcSqIsSrhE6p6H3rm8uH8ELxZHTNIAQey4tL+IwCGlU9exZeaNcxspK2kC3TCGkngoWzn/O+SlBOxBGke9BIsFT2voIv0lSNc2iG4p8AfBQR49haKjKLqMj2HO6mN36ORF/IC5lJ/RqS78I+qPzebTkeeyjTS8nxtYrQAibNXafxsQ==;5:3n3xIFEuAyb/6magf+8kp2t+UYv9xoWIYzof2RB02/NAt6Sat5rMk1UFdmLj4vIv97Ydq3qxMVQt/IOXacnIvpqmrR2ugXIEggzXP86aj/4S/g26yRFlfdsQLTYbzJYMd3XAVx/FFki9CvGlcP4vmB7VkphfVuntuA3gKLhpm/0=;7:Hhc4f4qCvbHMLOKijhaWkRVUq5PIZvzjLxgGFSMTlkIN96ZW07vJYHCZEiFxIkPmnMAASiANK3ypADUBTZgsD7uzWKoxJ7fDyP3qDsakTn9/W9M7ztCPGJpB3DLOBfn9Z/Uwrz6o5hq4zxTJCvN43GxYx8bZ+jIDmb3jyTdjA0MA+KmTxlxZxl80XdKI9vhZu3VaEYUwwihO99QSEt2EaSLgP8SOq7c0A7YUHXdWvMqmkWlRnnGlmFwG7/Haj0gz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4716;20:97w17NqFAPctGjUR79h1EWXfs73vLpjxOvRhvBXHeEtdVZ33ijjyC08GejQk26eGIWaMHFB0SS5u3L0FYW8z3cY6wfgfPF4i0vN++PoOeF2CWV2QttgrhplSurR6hnO4X6oMiUp4/q0uDarCj6lNeh+3tr6yWoQY+nwA48R8J/h+jyhuc22oQZd69B9eyd3SzzakeM3dgHLqI2s7y9jvO5iKgekCU4jhEwkg0El3OTAM9prMegZcU4y974fZv0zc
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 10:31:11.0067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ec62ef-79d5-4bc8-e0e9-08d5fde33a8b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the Cadence SD0801 "Torrent" PHY used with the Cadence MHDP
DisplayPort Tx controller.

Integration with the MHDP driver will be the subject of another commit.

Signed-off-by: Scott Telford <stelford@cadence.com>
---
 drivers/phy/Kconfig                  |   1 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/cadence/Kconfig          |  10 +
 drivers/phy/cadence/Makefile         |   1 +
 drivers/phy/cadence/phy-cadence-dp.c | 541 +++++++++++++++++++++++++++++++++++
 5 files changed, 554 insertions(+)
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.c

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
index 0000000..57fff7d
--- /dev/null
+++ b/drivers/phy/cadence/Kconfig
@@ -0,0 +1,10 @@
+#
+# Phy driver for Cadence MHDP DisplayPort controller
+#
+config PHY_CADENCE_DP
+	tristate "Cadence MHDP DisplayPort PHY driver"
+	depends on OF
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Support for Cadence MHDP DisplayPort PHY.
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
new file mode 100644
index 0000000..e5b0a11
--- /dev/null
+++ b/drivers/phy/cadence/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PHY_CADENCE_DP)	+= phy-cadence-dp.o
diff --git a/drivers/phy/cadence/phy-cadence-dp.c b/drivers/phy/cadence/phy-cadence-dp.c
new file mode 100644
index 0000000..bc10cb2
--- /dev/null
+++ b/drivers/phy/cadence/phy-cadence-dp.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Cadence MHDP DisplayPort SD0801 PHY driver.
+ *
+ * Copyright 2018 Cadence Design Systems, Inc.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define DEFAULT_NUM_LANES	2
+#define MAX_NUM_LANES		4
+#define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
+
+#define POLL_TIMEOUT_US		2000
+#define LANE_MASK		0x7
+
+/*
+ * register offsets from DPTX PHY register block base (i.e MHDP
+ * register base + 0x30a00)
+ */
+#define PHY_AUX_CONFIG			0x00
+#define PHY_AUX_CTRL			0x04
+#define PHY_RESET			0x20
+#define PHY_PMA_XCVR_PLLCLK_EN		0x24
+#define PHY_PMA_XCVR_PLLCLK_EN_ACK	0x28
+#define PHY_PMA_XCVR_POWER_STATE_REQ	0x2c
+#define PHY_POWER_STATE_LN_0	0x0000
+#define PHY_POWER_STATE_LN_1	0x0008
+#define PHY_POWER_STATE_LN_2	0x0010
+#define PHY_POWER_STATE_LN_3	0x0018
+#define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
+#define PHY_PMA_CMN_READY		0x34
+#define PHY_PMA_XCVR_TX_VMARGIN		0x38
+#define PHY_PMA_XCVR_TX_DEEMPH		0x3c
+
+/*
+ * register offsets from SD0801 PHY register block base (i.e MHDP
+ * register base + 0x500000)
+ */
+#define CMN_SSM_BANDGAP_TMR		0x00084
+#define CMN_SSM_BIAS_TMR		0x00088
+#define CMN_PLLSM0_PLLPRE_TMR		0x000a8
+#define CMN_PLLSM0_PLLLOCK_TMR		0x000b0
+#define CMN_PLLSM1_PLLPRE_TMR		0x000c8
+#define CMN_PLLSM1_PLLLOCK_TMR		0x000d0
+#define CMN_BGCAL_INIT_TMR		0x00190
+#define CMN_BGCAL_ITER_TMR		0x00194
+#define CMN_IBCAL_INIT_TMR		0x001d0
+#define CMN_PLL0_VCOCAL_INIT_TMR	0x00210
+#define CMN_PLL0_VCOCAL_ITER_TMR	0x00214
+#define CMN_PLL0_VCOCAL_REFTIM_START	0x00218
+#define CMN_PLL0_VCOCAL_PLLCNT_START	0x00220
+#define CMN_PLL0_INTDIV_M0		0x00240
+#define CMN_PLL0_FRACDIVL_M0		0x00244
+#define CMN_PLL0_FRACDIVH_M0		0x00248
+#define CMN_PLL0_HIGH_THR_M0		0x0024c
+#define CMN_PLL0_DSM_DIAG_M0		0x00250
+#define CMN_PLL0_LOCK_PLLCNT_START	0x00278
+#define CMN_PLL1_VCOCAL_INIT_TMR	0x00310
+#define CMN_PLL1_VCOCAL_ITER_TMR	0x00314
+#define CMN_PLL1_DSM_DIAG_M0		0x00350
+#define CMN_TXPUCAL_INIT_TMR		0x00410
+#define CMN_TXPUCAL_ITER_TMR		0x00414
+#define CMN_TXPDCAL_INIT_TMR		0x00430
+#define CMN_TXPDCAL_ITER_TMR		0x00434
+#define CMN_RXCAL_INIT_TMR		0x00450
+#define CMN_RXCAL_ITER_TMR		0x00454
+#define CMN_SD_CAL_INIT_TMR		0x00490
+#define CMN_SD_CAL_ITER_TMR		0x00494
+#define CMN_SD_CAL_REFTIM_START		0x00498
+#define CMN_SD_CAL_PLLCNT_START		0x004a0
+#define CMN_PDIAG_PLL0_CTRL_M0		0x00680
+#define CMN_PDIAG_PLL0_CLK_SEL_M0	0x00684
+#define CMN_PDIAG_PLL0_CP_PADJ_M0	0x00690
+#define CMN_PDIAG_PLL0_CP_IADJ_M0	0x00694
+#define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x00698
+#define CMN_PDIAG_PLL0_CP_PADJ_M1	0x006d0
+#define CMN_PDIAG_PLL0_CP_IADJ_M1	0x006d4
+#define CMN_PDIAG_PLL1_CLK_SEL_M0	0x00704
+#define XCVR_DIAG_PLLDRC_CTRL		0x10394
+#define XCVR_DIAG_HSCLK_SEL		0x10398
+#define XCVR_DIAG_HSCLK_DIV		0x1039c
+#define TX_PSC_A0			0x10400
+#define TX_PSC_A1			0x10404
+#define TX_PSC_A2			0x10408
+#define TX_PSC_A3			0x1040c
+#define RX_PSC_A0			0x20000
+#define RX_PSC_A1			0x20004
+#define RX_PSC_A2			0x20008
+#define RX_PSC_A3			0x2000c
+#define PHY_PLL_CFG			0x30038
+
+struct cdns_dp_phy {
+	void __iomem *base;	/* DPTX registers base */
+	void __iomem *sd_base; /* SD0801 registers base */
+	u32 num_lanes; /* Number of lanes to use */
+	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
+	struct device *dev;
+};
+
+static int cdns_dp_phy_init(struct phy *phy);
+static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
+					 unsigned int lane);
+static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
+					unsigned int offset,
+					unsigned char start_bit,
+					unsigned char num_bits,
+					unsigned int val);
+
+static const struct phy_ops cdns_dp_phy_ops = {
+	.init		= cdns_dp_phy_init,
+	.owner		= THIS_MODULE,
+};
+
+static int cdns_dp_phy_init(struct phy *phy)
+{
+	unsigned char lane_bits;
+
+	struct cdns_dp_phy *cdns_phy = phy_get_drvdata(phy);
+
+	writel(0x0003, cdns_phy->base + PHY_AUX_CTRL); /* enable AUX */
+
+	/* PHY PMA registers configuration function */
+	cdns_dp_phy_pma_cfg(cdns_phy);
+
+	/*
+	 * Set lines power state to A0
+	 * Set lines pll clk enable to 0
+	 */
+
+	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ,
+				PHY_POWER_STATE_LN_0, 6, 0x0000);
+
+	if (cdns_phy->num_lanes >= 2) {
+		cdns_dp_phy_write_field(cdns_phy,
+					PHY_PMA_XCVR_POWER_STATE_REQ,
+					PHY_POWER_STATE_LN_1, 6, 0x0000);
+
+		if (cdns_phy->num_lanes == 4) {
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_REQ,
+						PHY_POWER_STATE_LN_2, 6, 0);
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_REQ,
+						PHY_POWER_STATE_LN_3, 6, 0);
+		}
+	}
+
+	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
+				0, 1, 0x0000);
+
+	if (cdns_phy->num_lanes >= 2) {
+		cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
+					1, 1, 0x0000);
+		if (cdns_phy->num_lanes == 4) {
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN,
+						2, 1, 0x0000);
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN,
+						3, 1, 0x0000);
+		}
+	}
+
+	/*
+	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
+	 * used lanes
+	 */
+	lane_bits = (1 << cdns_phy->num_lanes) - 1;
+	writel(((0xF & ~lane_bits) << 4) | (0xF & lane_bits),
+		   cdns_phy->base + PHY_RESET);
+
+	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
+	writel(0x0001, cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN);
+
+	/* PHY PMA registers configuration functions */
+	cdns_dp_phy_pma_cmn_vco_cfg_25mhz(cdns_phy);
+	cdns_dp_phy_pma_cmn_rate(cdns_phy);
+
+	/* take out of reset */
+	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
+	cdns_dp_phy_wait_pma_cmn_ready(cdns_phy);
+	cdns_dp_phy_run(cdns_phy);
+
+	return 0;
+}
+
+static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_CMN_READY, reg,
+				 reg & 1, 0, 500);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for PMA common ready\n");
+}
+
+static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int i;
+
+	/* PMA common configuration */
+	cdns_dp_phy_pma_cmn_cfg_25mhz(cdns_phy);
+
+	/* PMA lane configuration to deal with multi-link operation */
+	for (i = 0; i < cdns_phy->num_lanes; i++)
+		cdns_dp_phy_pma_lane_cfg(cdns_phy, i);
+}
+
+static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+{
+	/* refclock registers - assumes 25 MHz refclock */
+	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
+	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM0_PLLPRE_TMR);
+	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM0_PLLLOCK_TMR);
+	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM1_PLLPRE_TMR);
+	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM1_PLLLOCK_TMR);
+	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_INIT_TMR);
+	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_ITER_TMR);
+	writel(0x0019, cdns_phy->sd_base + CMN_IBCAL_INIT_TMR);
+	writel(0x001E, cdns_phy->sd_base + CMN_TXPUCAL_INIT_TMR);
+	writel(0x0006, cdns_phy->sd_base + CMN_TXPUCAL_ITER_TMR);
+	writel(0x001E, cdns_phy->sd_base + CMN_TXPDCAL_INIT_TMR);
+	writel(0x0006, cdns_phy->sd_base + CMN_TXPDCAL_ITER_TMR);
+	writel(0x02EE, cdns_phy->sd_base + CMN_RXCAL_INIT_TMR);
+	writel(0x0006, cdns_phy->sd_base + CMN_RXCAL_ITER_TMR);
+	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_INIT_TMR);
+	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_ITER_TMR);
+	writel(0x000E, cdns_phy->sd_base + CMN_SD_CAL_REFTIM_START);
+	writel(0x012B, cdns_phy->sd_base + CMN_SD_CAL_PLLCNT_START);
+	/* PLL registers */
+	writel(0x0409, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_PADJ_M0);
+	writel(0x1001, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_IADJ_M0);
+	writel(0x0F08, cdns_phy->sd_base + CMN_PDIAG_PLL0_FILT_PADJ_M0);
+	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_DSM_DIAG_M0);
+	writel(0x00FA, cdns_phy->sd_base + CMN_PLL0_VCOCAL_INIT_TMR);
+	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_VCOCAL_ITER_TMR);
+	writel(0x00FA, cdns_phy->sd_base + CMN_PLL1_VCOCAL_INIT_TMR);
+	writel(0x0004, cdns_phy->sd_base + CMN_PLL1_VCOCAL_ITER_TMR);
+	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_REFTIM_START);
+}
+
+static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+{
+	/* Assumes 25 MHz refclock */
+	switch (cdns_phy->max_bit_rate) {
+		/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
+		writel(0x01B0, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x0120, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+		/* Setting VCO for 9.72GHz */
+	case 2430:
+	case 3240:
+		writel(0x0184, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0xCCCD, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x0104, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+		/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
+		writel(0x0159, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0x999A, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x00E7, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+		/* Setting VCO for 8.1GHz */
+	case 8100:
+		writel(0x0144, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x00D8, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+	}
+
+	writel(0x0002, cdns_phy->sd_base + CMN_PDIAG_PLL0_CTRL_M0);
+	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_PLLCNT_START);
+}
+
+static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int clk_sel_val = 0;
+	unsigned int hsclk_div_val = 0;
+	unsigned int i;
+
+	/* 16'h0000 for single DP link configuration */
+	writel(0x0000, cdns_phy->sd_base + PHY_PLL_CFG);
+
+	switch (cdns_phy->max_bit_rate) {
+	case 1620:
+		clk_sel_val = 0x0f01;
+		hsclk_div_val = 2;
+		break;
+	case 2160:
+	case 2430:
+	case 2700:
+		clk_sel_val = 0x0701;
+		 hsclk_div_val = 1;
+		break;
+	case 3240:
+		clk_sel_val = 0x0b00;
+		hsclk_div_val = 2;
+		break;
+	case 4320:
+	case 5400:
+		clk_sel_val = 0x0301;
+		hsclk_div_val = 0;
+		break;
+	case 8100:
+		clk_sel_val = 0x0200;
+		hsclk_div_val = 0;
+		break;
+	}
+
+	writel(clk_sel_val, cdns_phy->sd_base + CMN_PDIAG_PLL0_CLK_SEL_M0);
+
+	/* PMA lane configuration to deal with multi-link operation */
+	for (i = 0; i < cdns_phy->num_lanes; i++) {
+		writel(hsclk_div_val,
+		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i<<11)));
+	}
+}
+
+static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
+				     unsigned int lane)
+{
+	unsigned int lane_bits = (lane & LANE_MASK) << 11;
+
+	/* Writing Tx/Rx Power State Controllers registers */
+	writel(0x00FB, cdns_phy->sd_base + (TX_PSC_A0 | lane_bits));
+	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A2 | lane_bits));
+	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A3 | lane_bits));
+	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A0 | lane_bits));
+	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A2 | lane_bits));
+	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A3 | lane_bits));
+
+	writel(0x0001, cdns_phy->sd_base + (XCVR_DIAG_PLLDRC_CTRL | lane_bits));
+	writel(0x0000, cdns_phy->sd_base + (XCVR_DIAG_HSCLK_SEL | lane_bits));
+}
+
+static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int read_val;
+	u32 write_val1 = 0;
+	u32 write_val2 = 0;
+	u32 mask = 0;
+	int ret;
+
+	/*
+	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
+	 * master lane
+	 */
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN_ACK,
+				 read_val, read_val & 1, 0, POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link PLL clock enable ack\n");
+
+	ndelay(100);
+
+	switch (cdns_phy->num_lanes) {
+
+	case 1:	/* lane 0 */
+		write_val1 = 0x00000004;
+		write_val2 = 0x00000001;
+		mask = 0x0000003f;
+		break;
+	case 2: /* lane 0-1 */
+		write_val1 = 0x00000404;
+		write_val2 = 0x00000101;
+		mask = 0x00003f3f;
+		break;
+	case 4: /* lane 0-3 */
+		write_val1 = 0x04040404;
+		write_val2 = 0x01010101;
+		mask = 0x3f3f3f3f;
+		break;
+	}
+
+	writel(write_val1, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
+				 read_val, (read_val & mask) == write_val1, 0,
+				 POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link power state ack\n");
+
+	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	ndelay(100);
+
+	writel(write_val2, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
+				 read_val, (read_val & mask) == write_val2, 0,
+				 POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link power state ack\n");
+
+	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	ndelay(100);
+}
+
+static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
+				    unsigned int offset,
+				    unsigned char start_bit,
+				    unsigned char num_bits,
+				    unsigned int val)
+{
+	unsigned int read_val;
+
+	read_val = readl(cdns_phy->base + offset);
+	writel(((val << start_bit) | (read_val & ~(((1 << num_bits) - 1) <<
+		start_bit))), cdns_phy->base + offset);
+}
+
+static int cdns_dp_phy_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct cdns_dp_phy *cdns_phy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct phy *phy;
+	int err;
+
+	cdns_phy = devm_kzalloc(dev, sizeof(*cdns_phy), GFP_KERNEL);
+	if (!cdns_phy)
+		return -ENOMEM;
+
+	cdns_phy->dev = &pdev->dev;
+
+	phy = devm_phy_create(dev, NULL, &cdns_dp_phy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "failed to create DisplayPort PHY\n");
+		return PTR_ERR(phy);
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cdns_phy->base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(cdns_phy->base))
+		return PTR_ERR(cdns_phy->base);
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cdns_phy->sd_base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(cdns_phy->sd_base))
+		return PTR_ERR(cdns_phy->sd_base);
+
+	err = device_property_read_u32(dev, "num_lanes",
+				       &(cdns_phy->num_lanes));
+	if (err)
+		cdns_phy->num_lanes = DEFAULT_NUM_LANES;
+
+	switch (cdns_phy->num_lanes) {
+	case 1:
+	case 2:
+	case 4:
+		/* valid number of lanes */
+		break;
+	default:
+		dev_err(dev, "unsupported number of lanes: %d\n",
+			cdns_phy->num_lanes);
+		return -EINVAL;
+	}
+
+	err = device_property_read_u32(dev, "max_bit_rate",
+		   &(cdns_phy->max_bit_rate));
+	if (err)
+		cdns_phy->max_bit_rate = DEFAULT_MAX_BIT_RATE;
+
+	switch (cdns_phy->max_bit_rate) {
+	case 2160:
+	case 2430:
+	case 2700:
+	case 3240:
+	case 4320:
+	case 5400:
+	case 8100:
+		/* valid bit rate */
+		break;
+	default:
+		dev_err(dev, "unsupported max bit rate: %dMbps\n",
+			cdns_phy->max_bit_rate);
+		return -EINVAL;
+	}
+
+	phy_set_drvdata(phy, cdns_phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
+		 cdns_phy->num_lanes,
+		 cdns_phy->max_bit_rate / 1000,
+		 cdns_phy->max_bit_rate % 1000);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id cdns_dp_phy_of_match[] = {
+	{
+		.compatible = "cdns,dp-phy"
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cdns_dp_phy_of_match);
+
+static struct platform_driver cdns_dp_phy_driver = {
+	.probe	= cdns_dp_phy_probe,
+	.driver = {
+		.name	= "cdns-dp-phy",
+		.of_match_table	= cdns_dp_phy_of_match,
+	}
+};
+module_platform_driver(cdns_dp_phy_driver);
+
+MODULE_AUTHOR("Cadence Design Systems, Inc.");
+MODULE_DESCRIPTION("Cadence MHDP PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.2.2

