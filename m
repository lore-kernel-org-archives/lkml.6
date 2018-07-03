Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43867C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A823021888
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VoHbJ2nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A823021888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeGCT6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:58:13 -0400
Received: from mail-eopbgr690066.outbound.protection.outlook.com ([40.107.69.66]:43808
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752326AbeGCT6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD/ImaLzSa9GoFRBOZypBzVoOXMIVbjQsmgYx23AMRI=;
 b=VoHbJ2nm+AfngRpQItrtN4xxWaT5pLeFCfq+aZoqqG3QUsRDA1SCrDfUpZprk0ShzL790/ZJj5ZIoO/JjYbGQaDNNJbCE93ypW479aksloXOnWhC0+RYWAEskgTdjb80gMfv9eo2SAqSJB720O+gHF3v8uthWTg/kPoHjHAyRbw=
Received: from DM5PR07CA0038.namprd07.prod.outlook.com (2603:10b6:3:16::24) by
 BYAPR07MB4712.namprd07.prod.outlook.com (2603:10b6:a02:f0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Tue, 3 Jul 2018 19:58:08 +0000
Received: from CO1NAM05FT020.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by DM5PR07CA0038.outlook.office365.com
 (2603:10b6:3:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.19 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:08 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT020.mail.protection.outlook.com (10.152.96.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63Jw511007874
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 12:58:07 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:21 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:21 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63Jw5YA011464;
        Tue, 3 Jul 2018 20:58:05 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63Jw4ZN011399;
        Tue, 3 Jul 2018 20:58:04 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: Introduced new Cadence USBSSP DRD Driver
Date:   Tue, 3 Jul 2018 20:57:44 +0100
Message-ID: <1530647879-10007-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(36092001)(199004)(189003)(4326008)(246002)(5660300001)(8936002)(7636002)(26005)(305945005)(8676002)(2906002)(2616005)(105596002)(126002)(51416003)(86362001)(336012)(106466001)(36756003)(186003)(356003)(476003)(6666003)(4720700003)(486006)(316002)(42186006)(16586007)(110136005)(14444005)(54906003)(107886003)(426003)(26826003)(50466002)(47776003)(48376002)(50226002)(87636003)(478600001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4712;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT020;1:QFHjcloydETsTn+wnJNCqdIiQG9a8VR733989qwDKeIVAEsIDxAWP3Fuc4xkt5ghxA37Ezal8xqRP1q0MuEfiZhIzTD2y1h1PpUwD+CpZQphr8dGTPqV6zEkNGYFcpbo
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4283291a-ed06-4074-7562-08d5e11f4c5a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;3:lRnlAlNFrGW7+jQS3MrnWx9IiQi2Gtb8fAUMy3oPgOudz2ORNl8hoKlj3n3OX5Naf+q6xZeIEosPxQD/896uqlaKGxRMeFCm5SzSqTegkZUpf/BuwYjkkZ5geM7TuSojeyCtncni5fnEaVHTqtJebhiRKm9uPBrzLW74++OgES58+xg8oriqfyWBaVXt+OA2cprnYc3LyS86qapnn6WHOhwJxCFZbPsbdlKm7icDMH/WprjKJujgVWb6PLCiv6TXN1LERgGZEd9MZnl9n/CBRt6QeBi+2rrqEVjNAGSZ1yt8uoAX+gVgE+F0V3GigBkPPmHLOvbifIC0NNahwRHbxH5a5BFcnA4g40QJacetXp4=;25:EQak2VtHbdhrxUptX81DrSvqQ7Yg64t46xpovtgo0DJx7WV0Voth8axFhJTwHbJIG3MJ8XMNXxbDA5BwlYtxG6xZoBD7dnka7ShKRDMIccTakctp66IsaSpb5igl0Tth9iJ6RXpkMKKmlSDEL3cPKBXKYvp0VGosVdRl+R4J4mANAc+JfxrIeDA+jHKAgSm5+VYtiIrvpWIJfxMoTEq0/QPmU3LlZ6hfJofkS8lpYk2xsLFhPvj/G3C6/4RqIjSTzX6CvHvWWemXiZeLPAfi+0IpDSNqu1bB/vPN12AFaVFyjieeRtbLP+kMOJdR0ajmWuCVjAWbQ4/SGPyOgb96Cw==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4712:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;31:Qy0jcbZklkHuNvkWwEEIL8wBb36SWCS5+OFArztbvNC+O7gEXr30L8ZJyodjf1RnHtObR9pDqxJI5moQ10wQ17Vg0mCtsC+i9YRJiTxFVyev5hEkwXC+zX/a53HpM/IUZKH64Q1ZX4VfLTGT0B3qvWuL2ohpNumSJAaME9ZxKxvxt+AnBtk4l7yznKOb8ynL8u5aIy3ZNmXHHjtqu7TvVpvfWD0PO8cq4S0rLLl1UNM=;20:65BATApNPogWMEmeX64D5qtKQjyyboW85xNSByjjIWDfLPyTYUZrTaExQAtKCU+Vj0459BA2LAi3Ras0LvQL9LljmQo4TZA1qTaHdqLwo5sioKU7Li9R5kQ9pAM6bMLt14eWQZtJ/FO2eoLzKwDbmHKzVw0hfGurTHYCmO5BddoBAoBhvKnvWMKDk7GXhynBfRFxh2jV/AetS50b69MrX+JXsKt0UimZ4eRF4NdorTNBIFU8F2FR+OKb3cd7yFFsYRwDBFRqjXALsPw6daDrep0JF7x7H4F5GYsKZQhJ9rUmmdOQwOte7groeSWP50tiFDkNjeZ/rFhFNZJbys6cblv3FfLvrGP1hZLshdhYTBMk/hk/w3Vp4VSpBgtmCYJw7F3hXJrPAlYf5fd/HgDmwUp+W40Dpq0Ibd22eQ2vgXd40Ee8mB4XiqoYh08pzKPv3+QgP2IAkwipLpFIPeIc92DdRckIiGT8eSQhzdQheartAPx7gMVUvbcdGuRi2wlk
X-Microsoft-Antispam-PRVS: <BYAPR07MB47127BFA43F23891C2D2A694DD420@BYAPR07MB4712.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93003095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4712;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;4:OVU7sl9R97vBKYERRcFOBXaiBC14Aki6ajl4/EEKC5FkHabasmPfv/oHW154ptNxRC9suCXFSXTjEa/garF0QHA7bsjyFkooeqxZVHCG5DvZFDdXQlf/c8Dg13ClelYGJJzOlZmi76l2liMAk2Fjmg3Qd3RcPISCgBnWEmL4gc+ZjhhpyIaG/g8uZEp5OYxP9mETUIBJB+YQZX9jJ2wfKDv+NofCzlQjlvbeuTGlEzrnwLBTx1Tu8p78eVCN3gUlzSZwZfX0r3cg8ODEhM/BWHYxR6H2cRHrbRF8bBKc/y4hyv1CwBTZ3ScA7eD7BtOw
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4712;23:AvMo0VFRcAe5RV/MqL8y7pnLaBvOHbC7gysEYECVb?=
 =?us-ascii?Q?lehDE1PDBckCAYJL05ussaz0aJK/JVdq41SgPZrnZJdwe5MF42b6PaTQzwI4?=
 =?us-ascii?Q?L8nSKWhWu57Q4Fg2drqqDscJAcm8eYKsKlp3+grC/KcBf9r6yfPCzVopcLQl?=
 =?us-ascii?Q?CJKgGGWkdQAYZ8jhX0biTM534Qkpp5dGuqHOHirJLtYffuyY5bjGtbm9viSt?=
 =?us-ascii?Q?1v66oz8cPqn+HmnNbwx8pvNvi+Fa34MYNt+dgru1kQHN0YcT38A6IwDYRBIR?=
 =?us-ascii?Q?BhP0lgrKi/3nxh5/eqzvF2YpnSwYiHY/sFVyN15wykW+GQfFaQL1uQe/5+tp?=
 =?us-ascii?Q?QxUNPtNs8rIn66Q7tmCDcT2Ats5byJEc4P3KltS9cD8wtwY1keavoakUBAIV?=
 =?us-ascii?Q?tuoUKy/xIPneA/YS+vNZOv1qIJZGlJ01v9ZBF3JChzulF8abdERIe5+OQ/JP?=
 =?us-ascii?Q?vWj4kBjWnnjTu/XtFCqdQFkgmBPsja/y8/Jz/sXwV4WMALfHMHVC+H9Gszgz?=
 =?us-ascii?Q?64Yt05GjSd4nrgMUMjY47GrxmPbwnR1RJ9iBpBgJDwZ5FhVgKXiu4yh8cyXw?=
 =?us-ascii?Q?tBywnV3nWyufWEbuCM2q2e3MFUH3EIWS9SmNEND/nQtZSugz8q6y1mVO96Y/?=
 =?us-ascii?Q?aB/kzFdwc2UeJpAsssf0qIaiyQ/N6hVGPdk53duyDKjKu2cqSVMg/NbSibmA?=
 =?us-ascii?Q?Sl13Irq5HjQ9qsOlmGpV/5X2jHSmwmSttZAeAotzVTEJoN9XSzkWmmo2qNHK?=
 =?us-ascii?Q?sw5Cp6U7swF/d4iW7OvAB3/LKu7VzeFdMyQ70G8LZK3R1ixVPbvqahQ9zEkL?=
 =?us-ascii?Q?Z5tNP2urDxPNtU7Aci/fF7TA0F6KQqKPHWlTc4hg2DEb2nTqmxV3wfJIhSRc?=
 =?us-ascii?Q?oG1E1f2XlAdmtrqGW3v3vQlCrswrrkLi3I+5fzM9REkLpavALFZFHPZqmXCP?=
 =?us-ascii?Q?e9KFtt/6MIvkubknulccBvkjs+GjNLZhxoh7e7lq//O4Qacl/LkbbV02JNv7?=
 =?us-ascii?Q?wRutahbEM/5OBXNv6JH8oc/lTSuvn7i3wChjJowbaOnplERk0RBzRIKfJ/Nv?=
 =?us-ascii?Q?rJBz8gozmeywUO+V0ELe2UBMKZa?=
X-Microsoft-Antispam-Message-Info: 1T14uRg0kujU9shkCInRCnzFEPcyoN0+Hkre+qZvBpftOMEyTPlQGYU/4bEJh8Ncs3UI22oaSMuQEKwiPJZV7p0+4CZeQie+JmF8WqNuuUnb65krH/Sk2NP79fR1A0HAIYojUKqRc295HFgs3onwTtRgdsQdB9rQIEjnbr/B/PFD33YxyrUecAtzvCHkExxryM3PIcrMdLWblOLRIA29lxJ2r6XxUyoWr45+6aKhvIl6RF1hYKN3MvXMUjOMSl3D2C/3s/LBR/Qp9N34GCvFhoB2B4YiTmdraZYIh8ExKnl8THuwmWuB7sKo2JcBugcGohzT7VEyD3Q7Wp0ty4JOSqrHJGQUeTukoMJGbr9MMpIpNbNPhtkmBusUF3jCvdWYSKr4U7yr6G4/7N6T0FbZdg==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;6:SY8wrpBFaeqtTsGQulTb6by1p1yBQTwujHNgZyQVY2eBcoA/TdnP+L5IzX9xcdPfmC4PwhUtc0mckEDgtmpZuiUXsz94iR5KtD5vQGa/KLLGt/Mov1zwBnN8/LFWClBqw0WpiYlxbWObCn9Eu5kqr+jgDgeP6Esy8nrVXZiluzWGlZl4yvNRlwmM+P2gHnYuSlWRkj3gabfwix5xg3RTeNIH+zHgh7gofajZ8M0wlZEYkNZclwDmJKiTdbXji3NtwNqY4DKin7yeCPeRX7ia2T5NDKvFAVilPGokmHdoWZI6E327U1C80gOGINkiVHbUFyE/2sI92HdmMDewuMptGlOFnh1d9nRxrr6vzoFs7cudlUKz5otxuEZl7NawsavJL5w6R9InUGgWhHM1o6dBbpHKVi3VjH5JX9PWf8P5EMHpohtvFCfg7JlvBjGhtb9kRfS4V9EXS1g/XeNeh3JAHA==;5:HFwIYLV3bGmtp0TchJCuU/0dL4vwkLyu+83L8JMXbOdTaIAQfq83RMYwsbaxD0d+UYeqisHOKANADqK0oFRO57lM73Z1IiwfRvCQixy+hy45G1/ZET3J+c+lVV03of0RHnm8DzhWIV0yL4o/ZRBSmmMAC/oyh5+N1CSA1OCiXW4=;24:eFc0777iXRTA0LoVi/9ZX59jLlE/h0N1lxI2rI/DoRzp3Gi3QecW5RchHjE+JYjmsSu+/s225039y+gI/kE7WaUXK5Dzp7uv7zEzR++6TdM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;7:uLKaX32rUbGnvI6b4v/GJrOV5RgtVJmwPVx0A3KJLxQNZ2gyprNvMe3n6LcLtAiCXx88krJXE6soH00pErDEX8auc9AphF5R6pq3w3pziua6ShmAQB0G6xQSGzTdreJiWEJlN3mBA+vkNlhmKN1D4zJlWhpVjq2pr9NhlDQoSQnavp8Zl5JXKNRmD88MkoslY5YzbJpyZsloVYn2s4CxY803xLBz9XkwEGHZ2s4lCOss/Z/TmfsO5cn9UJlfep/C;20:YU987wQYAWxnS3Mi2ZObIL7L0gINwue8mhumkdrnT1EVlTuwEoYpaOTbW9WaS4XflQUuujKtlgY/KaaDJO09bmJiZ6RHDGiuKFT4Cvs72g9rnBGC//yIGFIlLJzWzAWV90QPphs4Ou4kiUTYdydPnuDSTReXlz6DeFjauofB+4RYxtqJ2OKb3duf/TEolOlhu8gjMSxNt1Zk6xVQavEKe16bqG1jNcFnmpY+6iXiiXu5b7BObmIVQfQGKbR7yumZ
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:08.2463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4283291a-ed06-4074-7562-08d5e11f4c5a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laszczak Pawel <pawell@cadence.com>

This patchset introduce new Cadence USBSSP DRD driver
to linux kernel.

The Cadence USBSSP DRD Driver s a highly
configurable IP Core which can be
instantiated as Dual-Role Device (DRD),
Peripheral Only and Host Only (XHCI)
configurations.

The current driver has been validated with
FPGA burned. We have support for PCIe
bus, which is used on FPGA prototyping.

The host site of USBSSP controller is compliance
with XHCI specification, so it works with
standard XHCI linux driver.

Also device side of USBSSP controller was designed
in such the way that it looks likes XHCI. It means that
most of logic of USBSSP controller is also compliance
with XHCI specification.

As a consequence, the USBSSP driver for peripheral mode
is very similar to XHCI driver.

This version of driver supports only Device mode but
DRD and Host mode will be added in next versions.

---

Laszczak Pawel (2):
  Introduce Cadence USBSSP DRD Driver - added gadget.c file.
  Introduce Cadence USBSSP DRD Driver - added USBSSP in Makefile and
    Kconfig files

Pawel Laszczak (13):
  Introduce Cadence USBSSP DRD driver - added gadget-mem.c
  Introduce Cadence USBSSP DRD Driver - added gadget-ring.c file
  Introduce Cadence USBSSP DRD Driver - added gadget.h file
  Introduce Cadence USBSSP DRD Driver - added gadget-port.c file.
  Introduce Cadence USBSSP DRD Driver - added gadget-ep0 file.
  Introduce Cadence USBSSP DRD Driver - added gadget-if.c Driver
    implements interface between gadget drivers and USBSSP device
    driver.
  Introduce Cadence USBSSP DRD driver - added gadget-ext-caps.h
  Introduce Cadence USBSSP DRD Driver - added debugfs files.
  Introduce Cadence USBSSP DRD Driver - added trace files.
  Introduce Cadence USBSSP DRD driver - added gadget-dbg.c file
  Introduce Cadence USBSSP DRD Driver - added usbssp-plat.c file
  Introduce Cadence USBSSP DRD Driver - added usbssp-pci-of-wrap.c file
    This file implements wrapper between PCI adn platform driver.
  Introduce Cadence USBSSP DRD Driver - added Kconfig and Makefile
    files.

 drivers/usb/Kconfig                     |    2 +
 drivers/usb/Makefile                    |    2 +
 drivers/usb/usbssp/Kconfig              |   29 +
 drivers/usb/usbssp/Makefile             |   17 +
 drivers/usb/usbssp/gadget-dbg.c         |  613 ++++
 drivers/usb/usbssp/gadget-debugfs.c     |  514 +++
 drivers/usb/usbssp/gadget-debugfs.h     |  137 +
 drivers/usb/usbssp/gadget-ep0.c         |  565 ++++
 drivers/usb/usbssp/gadget-ext-caps.h    |   99 +
 drivers/usb/usbssp/gadget-if.c          |  572 ++++
 drivers/usb/usbssp/gadget-mem.c         | 2275 +++++++++++++
 drivers/usb/usbssp/gadget-port.c        |  284 ++
 drivers/usb/usbssp/gadget-ring.c        | 3925 +++++++++++++++++++++++
 drivers/usb/usbssp/gadget-trace.c       |   12 +
 drivers/usb/usbssp/gadget-trace.h       |  505 +++
 drivers/usb/usbssp/gadget.c             | 2082 ++++++++++++
 drivers/usb/usbssp/gadget.h             | 2422 ++++++++++++++
 drivers/usb/usbssp/usbssp-pci-of-wrap.c |  229 ++
 drivers/usb/usbssp/usbssp-plat.c        |  186 ++
 19 files changed, 14470 insertions(+)
 create mode 100644 drivers/usb/usbssp/Kconfig
 create mode 100644 drivers/usb/usbssp/Makefile
 create mode 100644 drivers/usb/usbssp/gadget-dbg.c
 create mode 100644 drivers/usb/usbssp/gadget-debugfs.c
 create mode 100644 drivers/usb/usbssp/gadget-debugfs.h
 create mode 100644 drivers/usb/usbssp/gadget-ep0.c
 create mode 100644 drivers/usb/usbssp/gadget-ext-caps.h
 create mode 100644 drivers/usb/usbssp/gadget-if.c
 create mode 100644 drivers/usb/usbssp/gadget-mem.c
 create mode 100644 drivers/usb/usbssp/gadget-port.c
 create mode 100644 drivers/usb/usbssp/gadget-ring.c
 create mode 100644 drivers/usb/usbssp/gadget-trace.c
 create mode 100644 drivers/usb/usbssp/gadget-trace.h
 create mode 100644 drivers/usb/usbssp/gadget.c
 create mode 100644 drivers/usb/usbssp/gadget.h
 create mode 100644 drivers/usb/usbssp/usbssp-pci-of-wrap.c
 create mode 100644 drivers/usb/usbssp/usbssp-plat.c

-- 
2.17.1

