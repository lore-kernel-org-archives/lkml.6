Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7847EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFFF204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="r3PKapIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFFF204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbeIFTSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:18:04 -0400
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:51808
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729183AbeIFTSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5HVenKnsNniGUTNgXL0GMWkqQ4Zwn2vgKup2m4wIYI=;
 b=r3PKapIgR0EZ9qyPh1ovecRMXzjYypbMFy6n66LclQrC9UIVuIZ7XZRXhfO8064nGTWoAESmaT7GcT/bNyjOvZEcFzqsv0dAcM3R/YErxeoCtwW+dDmOG23nnR6jFMyJokihgRu9/X6SPi19erSFIlXeOiP7gTTEiVTAleUKI+Q=
Received: from SN4PR0701CA0017.namprd07.prod.outlook.com
 (2603:10b6:803:28::27) by CY1PR07MB2167.namprd07.prod.outlook.com
 (2a01:111:e400:59d7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Thu, 6 Sep
 2018 14:42:09 +0000
Received: from BY2NAM05FT004.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::202) by SN4PR0701CA0017.outlook.office365.com
 (2603:10b6:803:28::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.17 via Frontend
 Transport; Thu, 6 Sep 2018 14:42:08 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT004.mail.protection.outlook.com (10.152.100.141) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1143.1 via
 Frontend Transport; Thu, 6 Sep 2018 14:42:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w86Eg5Hr019151
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 6 Sep 2018 07:42:07 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Sep 2018 16:42:14 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 6 Sep 2018 16:42:13 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w86Eg4jx025075;
        Thu, 6 Sep 2018 15:42:04 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w86Eg3ea024907;
        Thu, 6 Sep 2018 15:42:03 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [RFC PATCH v2 0/2] phy: cadence: Add driver and dt-bindings for Sierra PHY
Date:   Thu, 6 Sep 2018 15:41:10 +0100
Message-ID: <1536244870-23149-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(36092001)(199004)(189003)(87636003)(51416003)(2201001)(86362001)(105596002)(48376002)(2906002)(106466001)(50466002)(6666003)(110136005)(478600001)(7636002)(316002)(42186006)(5660300001)(16586007)(217873002)(8936002)(186003)(426003)(2616005)(126002)(476003)(486006)(107886003)(26826003)(356003)(47776003)(36756003)(246002)(50226002)(336012)(4326008)(305945005)(26005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2167;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT004;1:XoaWj0exBUpl4dgP09ItzWiE244jo8OvzoeOw7mqx0XF0IrucBDqI6pNSz3oFYBNdQ4R1kQ6sxmJ0T+N9eceUNiL1ZD7zTQJKE2ww9OnU4XpevopRqBSKZ0UluipLLad
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d4fbac5-9d89-467e-47e2-08d61406ec2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2167;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;3:H6n0fiYT0E3gl0udED+QbvUauSWRts9VGv+kK014h45nb0ioseerB6v/lAO+Vilo9IXLno97meivpg8c1STPQyWvpgd14KTIPKs44maewkf9D6b5g9+A4nHZxfwj0s0BiP3vbx2R4u1WmsdLatC9j5H10R2c4W0s4kHdGZPdrilrxktrVgyt/NO6EkOdiIzebYKglwX6l4SaOIsH8Fmc99j21DG9RW2lfBRn8jBg9E3g/ZIMupLIpU1N051a77s8Mmosgy6rMmTPG205XoDbpkn2Hbj6UaggwQmhaix9L50whMimzZo65nIo13G4/6T3lpK7LAiwEnMF6nh3x9ExOxQ+I8/YRVIwfffrIuA/guU=;25:S8XW1ZHiJmjQRlHWTahO98tDY0XO477DeGbdwe3Nw3loW9tx6wzORdu+hiKQHVQX5PjtIhuc0LG4h3upG8f+/kpzbuFT8MwOxnygQc9jzAJDkQmfNqgtXV0SDG+K7c+NXttywmH0bPBoLVwO8m6GQHPayS6a/NoAtmrYAx757RKpi/hghC7zu8CtNxi8cLbJIrN3d+c4PkhUQsWOJGZGh49AheQu1hI1iRTQvQ+Mid/ZX556YKrlKh6KPL/p/4nCmB2rhXjib7OQ08XMuFPj8A8G+/hiajYTysAmOvH4MaGxh6goACLJia1UhK6rwG7tIVIoSzTdysFHccdHuUn8xA==
X-MS-TrafficTypeDiagnostic: CY1PR07MB2167:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;31:GXO8bM3s14cU3bFyvFIErAy09cegj7Iq2BiGI/SV2cGEcMLOfXTvDXbYokFW59vlP2Ahx8PQXyiss9cc4bgl5kPbHQsRlC77uQ1a0YBF0wBKcSDlPSqOXo5ce5s/VmYjUugkfpD8K+DXebHWyUXbyTuAwbyY0BU45/4469ahy9vm8qL433Zuq5jtntjqlmx7+ThocZnEyCIIosQTgkdGQYuTUl9ML6CI/yEtCnms8nI=;20:t2Om9rAjde5rr6xSSXU9Jnvz+SQdDe1eqVciVq4WCr8JvrRQjiCG2krjXqzW41IoyszN5m9ym7lEDMFn+uSzpRQCviZaSp4UinolfM+hXCAlLv71MFARmmsU0GGJ/oq1WzoOjocCKVk290nYwqn9M0a9Q4fJlLwqwGwd+sJ1uDltYhXLgCiktzTuOCekS9xowSACnRNATyTvheuGJVJakbw1q6nLEAb1mjXrG5VDZVjYTkCoYOW/44UYnCJ9argbgyBmyxdz8QdtypL20fudNp/uhrzTcnuAiHMInZdIU+lVXjYSKSGXU7ppiOimAvNCP3aPRcBQQuUZqI/l4pH58HdFn59RzJcrMpbH7fc+DhGK76zWW9wInrd5H3Cs4GRmsTGYCTlcQLwmpHwVdyrUsYPkAWNbH09rlcGsCb8Ur48YX4dTCTzrfCwS4QJSAweEIE2HWXL0bCMn7GgOcJTfp0ZSeDk4qOIIiTcOERpM7R6evvdKvbhlB1dK0LIifil1
X-Microsoft-Antispam-PRVS: <CY1PR07MB2167EBDD7C12C7597977305BD8010@CY1PR07MB2167.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93003095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR07MB2167;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2167;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;4:zh3/E+9C7MCFSz5ja85WP7no3zs1EzzgD7SF1Cn8lnbB+jpK8jNQGHnRgbHUdaLdalZmKGjDr2p5HbCFr3jG5znKNjkLr8hmwXK1xJfTEJvS9/uVyBBeEHrYcFUIhm7hXSZQw2UyQX1wvCRV+rjKcGpmiAwn0Ypd/TGYyGSeh/UZW34cKEVu7el+UbAStottCcs3EiI3zFMcZ4MnxVdMEM1bZBmGzb+15yb3+7cZG3mz76VTyPgEZknFQO54fAENAGVL4O1krokINk7E44zm7w==
X-Forefront-PRVS: 0787459938
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2167;23:RfB1b9vNtMa+iTfJJynFfOAGQmL/RrpMQAQAmTVxe?=
 =?us-ascii?Q?p6OLvZy9UbIJ/9MjrhAZL6AnrkEFEPAOwIifx7y6PdQIY8djCLggZIjzAo5J?=
 =?us-ascii?Q?KoVmAtwjrlV/eYAcytoxKlbrJg0ciqwxgZ8ye/DYV62DBuOfkNxjuTuQ0GcE?=
 =?us-ascii?Q?ILaRfWKFMhOiMPoIfM5u46LRv6s+F9K+E/q2Xju2IQm576rTvZbTwKugCAxw?=
 =?us-ascii?Q?hIf0FvWaXcuYmMhiM4W27/30c6eF4YSkQ+1PSgNhYHhEpxnpsScU5g9mMgXx?=
 =?us-ascii?Q?ctVje1zc8HrBENwyVxP3EwMV7YW3oYgHf1FsIRXLmhs/PKzrIoFo/1UWXMbF?=
 =?us-ascii?Q?vdJYNAOF0o13MrWaq3sdEWDZOqbPVQC90k5PG3T0OMiLycdQ77JttdAKEkJG?=
 =?us-ascii?Q?NJqfRwZBfXaCd91xhSFQFlUkDkFSBkSb6J1qgO9IazMRpMZSsNvZxCy+Wjmy?=
 =?us-ascii?Q?5UVG0eZjvC50O5HIN2CLIFJZi6TrKLsTvnIMVd3EV+MFyAyVPWOSUqDuluog?=
 =?us-ascii?Q?w2n20lE0gTODEga1hmMuN7DkKnVK7fu9iaH108KU2Q/ld2SiCxWwuyBXCia9?=
 =?us-ascii?Q?Bbz6TQyRXInSgLjxttISy6NqR8wxwLgFqiPxtkP7LZCPGyrGDilQlDubJpfc?=
 =?us-ascii?Q?7ywlW8YAyq78ZS/mFIf/xLTJ4nJoRJKtHvhe7RWMuJ88rXRrHWrDuUxNDeh7?=
 =?us-ascii?Q?ALgnSLpADxoK2FVy0rqVXaQk34LFkaPidWx1sJCcYR9mm3XuPpqPnUt52ulj?=
 =?us-ascii?Q?33eb+NgammGzW0p+FZq/eibnku8xqiDqtetJeSd9dpvpw8pw5ig6sl7NNIyL?=
 =?us-ascii?Q?K6BtywntN6dkqiLXSiUfYQ7EEbt6rz4mF5p8AkpcDfWupuEh3E9khRIXsCCW?=
 =?us-ascii?Q?/AmFTTH9sjjpmr4SjtXDDX1Z6/GsWiVmjb2NIBLedx+XkpC4lhVHB4kpNyrY?=
 =?us-ascii?Q?DzyHncEdDi5w+8K1ZmpmVnAbKkKKvEvrvZBEVem+gqVeKeYoaDkdGPwgjJeC?=
 =?us-ascii?Q?bVAEgkCHMR7dfqpBjTX8qWM+Pndyo7klnKnXupRum/w/w=3D=3D?=
X-Microsoft-Antispam-Message-Info: IcdGabq+tjnkz+DyLqRY7Eym9Iyphyd+0rb5UsBw5NoWmDuPKXbJWhu1N6CJA6POLKjEEFRjErRiFoHoD6d4sCmiL4VSdc8OrKSicUzTbKF+UdkAaK/bQwO/N2p7lobrlSGEM1SNEnGOAQEMKVprlPT1X+4NWVP9wpFxtPsTrHcviOu6g8JKec/nbFkRb9MBitFPipjLBxZEhdAVQim/eDvhVadXG5AbwGVJkByx9bLBhoy3UXEIGsw52gFeaV2Rwy8eo1KWLFbkzWEAtZGD4oJwEN3/liU/2ahpQii7crLGWgGXLKKxuOG+v4tCJiIyGW14AVIBy2eeuwtmz1U/6dOA7FNFXyjryxSxx8XkXe25+aUh3I6JIjO+0Zi9gzCZzD5rjOAb6yjBcJDZsqfrxA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;6:MvNewgF/hLbbt2u1hbtNDiZio+Fai+iVPvTTF9k+FQtY8Q1/r2i7uXSMcvDjh8y/+R3Xi8Nbuk8EYsup2nUEFTzWiFK9vziJILhpmqnZeUYNxzCNQOLzRIYo5WSikCkBwMiVqm90N4CNQFMVb1YWN+leJgo/xqEbX8adKobHeKinytRYcU8Zxs9CJWk/Mv3cM5+0sLbjX9tf4NMYfRqGV4Ei/yWHh/7AlujtgXE2Jc78QnVGK7eMcuZjYPwF9ANj2TAsfqB5BckjyCC8XYBD2pWxB8lIT7psgg/RpMD9TCTPxtMKMrnV+4d6c5SMMjT/73bUwSRHkP+BU8oIxTNr28/k9z/A8nyNLagJ72ZR5o7fV4r4aL0b6O6CYFqXSzwVOkvaKB3FwT2CTt+28oz8gGnqj1qWnrzCww35cdZWOaJ93HtNNyS8Y95njXuB2tL8LFq32GXGt6vFpHq+HWiSbw==;5:UpUgNWC7qGPRqmUVJgEiMjm8PxtSp3NgPmWdRnptfNG/ZozmL5C89L4RKLSfAebTIJ4w7yLEn59qQydmHUWLd7NpaInX7VdW/v9EkepAxK9qkQc2l3bzs5s6iZ3LZaGIX1WEa8lZ16ekbIXIglx4jhL6j9/G0GgBFB1qiTU6i7c=;7:dIGXITpLiYtlb5wa7AOQs8Snlv4oGhZevZrnPhWitID+S4/DDoXQr6PIbPy6Mo3edfpq7em8PzWBTw+kD4ApdkduOtBXmOADydz0OhWB9KAklQREMoFQagz8taAvRtWN1CwDMN7D05EUVTOMO8ZrJNmd1i1PXe4VcZXmvuim+F0ds8sClVXOS6vnTVsG27NWB38BqdlZKAzPa2wJe1AV/mOFwbxo+wpB1afC90JUyY89wKK+8GmEK81wzRTDFmNY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;20:T6dGOO0uX0gH5YMkhjxgtQ50fPArpsgztcTp+CyF4XMkYRdYxWuUt8LOTxaRuvuvFS4F8W1evfkblVFVcaok1IiZ7FFUGECsFblX7QomspulxIASH3pw6YmJcLaajX7XC1eYAf7uXMlPvCTXZoIhmrudjjORsppACY+Yxz26zWpvGugG9U5BEroW6QZdna5HfnhZLmWNnTuXPXD6BKZ1Z7MSJPuo/lPNCQTg4FkanYaQL8ZhptPh0TcLnmc708Jn
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 14:42:08.3563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4fbac5-9d89-467e-47e2-08d61406ec2c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cadence Sierra PHY supports a number of different protocols.  This
series adds a driver with support for USB3 and PCIe modes.

Only one clock frequency is currently supported, so the value of clock
provided in device tree is ignored.

Changes from v1:
* Each group of lanes is now treated as a subnode, and a generic PHY
  device is created for each group.
* General cleanup based on comments
* A reset is now required for each subnode.  The complete PHY block
  is taken out of reset at initial probe, and remains out of reset.
* Added a binding to allow for hardware configuration of PHY registers


Alan Douglas (2):
  dt-bindings: phy: Document cadence Sierra PHY bindings
  phy: cadence: Add driver for Sierra PHY

 .../devicetree/bindings/phy/cdns-sierra-phy.txt    |  65 ++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/cadence/Kconfig                        |   9 +
 drivers/phy/cadence/Makefile                       |   2 +
 drivers/phy/cadence/cdns-sierra.c                  | 385 +++++++++++++++++++++
 6 files changed, 463 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/cdns-sierra.c

-- 
1.9.0

