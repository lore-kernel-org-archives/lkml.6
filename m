Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4E9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5A420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="WbL0oR2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfBDL3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:29:09 -0500
Received: from mailout.micron.com ([137.201.242.129]:21752 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfBDL3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:29:09 -0500
X-Greylist: delayed 645 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2019 06:29:08 EST
Received: from mail.micron.com (bowex17f.micron.com [137.201.21.111])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x14BHjNK015958;
        Mon, 4 Feb 2019 04:17:45 -0700
Received: from BOWEX36F.micron.com (137.201.84.51) by BOWEX17F.micron.com
 (137.201.21.111) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Mon, 4 Feb
 2019 04:17:45 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (137.201.84.23)
 by BOWEX36F.micron.com (137.201.84.51) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Mon, 4 Feb 2019 04:17:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BFuszUq6QCgYAF5L3++M/Z2NGzpLxpWmByVdVII/pw=;
 b=WbL0oR2j8zVkfp6FaWDislrYb9V0AB6CjbBjMPOzh2rJU5oTNHExDHKbfxMENoLIKI7nLc18HFv5sFdsaKKG6TXV/2YxTLkxermm3yUHGqLx3wH842HHf2MMQB/gPqfbs4lQY1qdSjqiAyN2zz0z21VScN8AYouk8MEWiRgsQLc=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.98.155) by
 MN2PR08MB5789.namprd08.prod.outlook.com (20.179.86.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.23; Mon, 4 Feb 2019 11:17:38 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::8cda:e314:bfb0:41fe]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::8cda:e314:bfb0:41fe%5]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 11:17:38 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 0/2] Support parameter page and Redesign Micron SPI NAND
Thread-Topic: [PATCH 0/2] Support parameter page and Redesign Micron SPI NAND
Thread-Index: AdS8ehhwnTWZU3dFTAeM6H0r3MwoZA==
Date:   Mon, 4 Feb 2019 11:17:38 +0000
Message-ID: <MN2PR08MB59511A3423EA99DFAFF4628DB86D0@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.44]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR08MB5789;6:P5vSXiO4b7hK+jGftCqfaOXsBC3d6XDaPHro40I64zXZeb1EWcTrkuNl2H6Akgz+fBXQ9CkyeJXN/6KKRBNv5phThRPbtexE1/y/JywGGTM5PFYJ5+JrxE7fLNcgdemc8Lzj/tIkCg+ohG4A82ec1r3wOeo/sV2yexciTWCNTAMWqH3gMBrc5RCxXCeY2Q97lKBhYD0lsxjCOxnZ5viLOzjIDNRuNMiNBlRhf1NLQAvhr5fqGXg9icjwSvjqVhLMQmLJXjryGLHjiHo2iTJB8n5AjiFHDjjq3PZYsFYAZd78sspqgYOWhJLkxv8z86+WdUZsve1LSMa/19NloQtFoWLWE+Quv/I5B8hd/H3FC+TtDu5mNmGedaomnvSYPtGMrPziSXbZpPUnYxKzVpwwpGFv9lQ6GIpQRXp1HP19ZDPs8LBA5bryyNZI+I/zBTTacXiEsuX0GlU3FNx4jzkOjA==;5:xoP/bOvtExEylPKMcU5O8yK7DauvfD/TKgWsqqt/9JfZb5Xx3iPfKIrvFVyh6Sqg5HI+rzbWOHgNeodxm5AP7GIHcf0g6VvEXdeHd6wHCwns86VLI5gcumVb88wzocwvSFHDym9ZNrK9coSJxeiKkBJYovFDyZ8b82ybXyxr9fT8CYSx4htqzMPP41nGOnIvXJdhT+Zh9fdsq7zo8H1gZg==;7:1ObM6hrcVjYMwehrzR+4SQE5f/4CsGRo+NO5LhKwMxPcDeOimWPyU99oKOqydQHf9EJ0Ln9vGcje7NDgy7MnkHgSZIZtzeFwU7AloM4xO3cKR+An3M7nLo5MDPmFUvIOBmwkZa/4ZcWDFFxZUc8PTA==
x-ms-office365-filtering-correlation-id: 881c2019-2c6c-4b0b-016c-08d68a925f1d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MN2PR08MB5789;
x-ms-traffictypediagnostic: MN2PR08MB5789:|MN2PR08MB5789:
x-microsoft-antispam-prvs: <MN2PR08MB57892F2D0BDAE71099862C28B86D0@MN2PR08MB5789.namprd08.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(478600001)(81166006)(8676002)(476003)(25786009)(4326008)(39060400002)(8936002)(14454004)(81156014)(7736002)(186003)(53936002)(26005)(102836004)(55236004)(6506007)(74316002)(305945005)(97736004)(105586002)(106356001)(2201001)(71190400001)(71200400001)(68736007)(9686003)(55016002)(86362001)(110136005)(6436002)(316002)(99286004)(14444005)(256004)(7696005)(33656002)(66066001)(7416002)(2501003)(2906002)(486006)(6116002)(3846002)(4744005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5789;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NGX9iD4BV6vEvRe354I+KyvoBLVVpBs2cVfKDhQ/Fm5jJyrep92Hug5r2migIVErRvukXNIWtD8A9T5+iD8OekG7cfN7NB2/eBlii3YOToJtlwcaGdBI0rYWfL8QPywAZkangiS199FpwquA0otXgAikjos4MbWLhJsuXL6i0bO6tzu1v5IL3k09SwEa7kW0FsrrR2P0flZNUKEJgvcoysDXe2PqgZD5VxiAjivW8/9r8WlCdM4Dmni2H1jxRXOKigRbZzVf5J6ksn2LK0BFqNpax/AAcPSLDp+9Rxe8UcKSO/o/VsWNCAN1vS4Wp8g6Oj9ddqBQkwO5EwMo/4JmxEI2e7iusM8uTMo4pJ0y/AG2bGLYvK+bDIvhEWZnSVBPiUXaNj7nOrvUH0nL1xLe9590Krs6Gf/jN8wm2Xy3bq8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 881c2019-2c6c-4b0b-016c-08d68a925f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 11:17:38.4017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5789
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24408.005
X-TM-AS-Result: No--4.244000-0.000000-31
X-TM-AS-MatchedID: 700038-700057-780016-702358-707451-702762-709908-706719-7
        04156-701604-704421-708797-700648-700016-703529-148004-148007-148020-148050
        -41000-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parameter page is supported by some of the manufacturers and instead of
maintaining spinand_info structure for each flash it is better to use
the parameter page to get the flash info. As I have seen the different
datasheets, command required to access parameter page is same across the
manufacturers.

Micron SPI NAND flashes support parameter page, instead of adding 8
devices I thought it is better to re-design the code using parameter
page.

Shivamurthy Shastri (2):
  mtd: spinand: Add function to read parameter page
  mtd: spinand: micron: Support for all Micron SPI NAND flashes

 drivers/mtd/nand/spi/core.c   |  62 ++++++++++++
 drivers/mtd/nand/spi/micron.c | 172 +++++++++++++++++++++++++++-------
 drivers/mtd/nand/spi/micron.h |  83 ++++++++++++++++
 include/linux/mtd/spinand.h   |   3 +
 4 files changed, 286 insertions(+), 34 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/micron.h

--=20
2.17.1
