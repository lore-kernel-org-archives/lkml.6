Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D86C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C03620875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SL+7rkPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C03620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbeGLGAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:00:03 -0400
Received: from mail-eopbgr700049.outbound.protection.outlook.com ([40.107.70.49]:61663
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726754AbeGLFzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O56zEB4vGY4xG8bOCO3CzWEfFpmFGw12fDSu/1zHtlw=;
 b=SL+7rkPYUkHqQLVEjkn3RMQV9oZMnSFjBh0Bu3itdsGRruv+dc5wa6tkZ2qBREJ3blBJTbDV34d3eT+wE3xlpFCQLOC7x7BFaeBoaMohr+AItov1dt0K6Rugk5CCkIyhQhEMRZpvYKXitvfFh9s424NQ6At0qvbIp8VW/tQanmM=
Received: from DM6PR07CA0006.namprd07.prod.outlook.com (2603:10b6:5:94::19) by
 CY1PR07MB2298.namprd07.prod.outlook.com (2a01:111:e400:c5b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 05:47:52 +0000
Received: from DM3NAM05FT022.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by DM6PR07CA0006.outlook.office365.com
 (2603:10b6:5:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.19 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:52 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT022.mail.protection.outlook.com (10.152.98.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkvv032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:50 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:02 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:02 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkRn029494;
        Thu, 12 Jul 2018 06:47:46 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lkrL029493;
        Thu, 12 Jul 2018 06:47:46 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 03/31] usb: usbssp: Add trace events used in driver
Date:   Thu, 12 Jul 2018 06:47:00 +0100
Message-ID: <1531374448-26532-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(36092001)(199004)(189003)(1671002)(8936002)(8676002)(76176011)(316002)(54906003)(478600001)(42186006)(26826003)(16586007)(87636003)(5660300001)(7636002)(47776003)(305945005)(51416003)(246002)(4720700003)(11346002)(36756003)(126002)(356003)(4326008)(476003)(6666003)(336012)(2616005)(486006)(106466001)(109986005)(186003)(446003)(50466002)(86362001)(50226002)(107886003)(26005)(14444005)(2906002)(48376002)(105596002)(426003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2298;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT022;1:N9CVlAs9Q5FBXYgIL1Gum1/tF5PmTc7sauAgS6Yo5IY324bO/JxcImwN1LfRvtCRp27Izg7mO6H1BcOhShEyhWBuTN6DZY45wByoVwExqS5DZupM5mD6SPhIMj8HRWV5
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23df7cdc-ab50-48ee-fcbc-08d5e7bb01e0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR07MB2298;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2298;3:kKp450cQtevWRCTiJpKY0l7Gbjexy6dNgUzd+NaPWmCaGAmqUAG7pf42pWZExF3RU2fRsv3hiqKOL7fayE83McSMLuljlTendK0U5kcUeP6gEEqRgtQ8/68WFvEYl6B503FcWgjjrfeNqOGorq2cTha3W6n6Egj2e4QhhyjsrCnNkxsizMQ49wt77WnHDM/0L9PSFIztTgkRZEEsqcVj6LrDVrUp4Z1Ec8o/EKZrCxFd96A877yh2+PPcMXFTU0i9MQFrCChGB3qwSoJOJoQhi6uKoanfo5gkSFyQvKXIE7/JwDmqlAIuhtJu1J7ShEB3t5UdZiKTBnN4oCVwVvRTH3dNkmeRZeICk68MyrcQTU=;25:isvyfG++I/XjM+L5Ure7zGa6QfBmpsqDONCm92KMyaDOjfPA45mbgArILW1J3jUDPMnFfDO/vzXy5tE1MSJVbV0ZCzJZbm9zkqD3ZN+8iJ6VEZz1f240QenDAwGabJ+3TVfyOqeMcTqrfBiN+PE+AXvo7S60rP+00WBXqGnz7yfFbk2lU/E2xPEmCNwgquOtb6p/s7WghaGudz6ZtqeDbAquvqihr9oqaaLqZ0NGLZlecjGBu+jcq6RpbNMFS7imhfgPbEOGkniNfBTrRJg8bvnlG/A1+rYCHeTfhzTueOkpgWdUh7EZWNGrs397D5oEZhH/uE1il/dNvZxNWeXTgg==
X-MS-TrafficTypeDiagnostic: CY1PR07MB2298:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2298;31:J/tRrn2ONSxOmm+kglytdXhuhttDRA7I9oYsNZJWoJ39K4AIFeL7lRLVfxCuo+NFBGkIJaH61cWT80WgB6WVhdoBK+rUoc0lWC97AFXSVXf1UyOZ4DWZTZ/IG4dBY6dyE4TNahyvWVW06buAyxoF4y8oIrvdt0p55gv3FhcJNs/xNBoeVUxIEgGsjSsaL36ZDImlxNYnGcoZkGPVJJNuc64RDln9aU3sOgW+oHvxix8=;20:cqev6DDms8S7btHAuYdphgp+CPVNrcGmsb5UpGGMSI8Aa0doagIhD8/plB6U72vg1NBLTu2u+4Q4easrBie83LpxT5R51uSRtC7ce6iffa4b/1lvypVZpQQ638T728DH2ZBNblYxRQOL20a+lD84NF4cWqfoPU7xdEXSaaI8/rfrcTiAN0v9+p/VQpMdp6sBFdPghsNZAnO2gCb7rUwGUBccya+fsfWK+awqEJIsXp5yVS0B0o8R0hzrFFwqg+G4+TMOoqOyVyLYm0AHGe8v/Cscfo0NCYuRv73wUE/AIyMd/r61Ui+ESdm4jyHoUH+lZl7rAXRzpABzOxAApc+QCpJSAochZJqZVvQh8yCRad0K3axAjj78oBMfhufPSW8AvhwZqmnBawUzSNSKIe75WuIdKVKqJUT9EGA2yZCr8/p9J4DzebXdkMgGlH5Bm4Ibd0FKtI8UMbPLw7eWFDSWQOi2ZhDCVtOOruU+I7f0MjRIyNgf+xc/9iHr0b+DEcrS
X-Microsoft-Antispam-PRVS: <CY1PR07MB2298908E1CD8467A4A8FB8C2DD590@CY1PR07MB2298.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(155532106045638)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR07MB2298;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2298;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2298;4:w8YOC9R01RyuKZC09+E6KY/u1B4Brb4VY0GVLwjkepBfvc133SgJ5Fs8B5gsxB0jon9VM6KhdPfB4kaBxJiJmv0/GM/h3u7qfCxLByvZrcTu+C3LB3rj9gHTuB+hZDoA0m9fwXL8DarEM6cBKz/nx3ILGQlKLn/WCTe9Pftpr7BoXGbNn8pAeFSB4CJ+oV3alFW310Eq0WsaLSKCVmwU2S5OSS6eM2EcsU8Pr1S2xF3RBCyy6C0YIkh0UtBn0VIMpqryNBndBm85m2DH2pS6/k9qy/dN0VT4lI2YmU3cyN4uK1hcKftECVulRwJhuSZAoaegBEhTsb8wcsh3j7Ko6JahFOkDkjW2u3ZFVc/1LAw=
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2298;23:GnseTKz7byI2AJba5JXItkxeYguVxVep2SGA6pCC+?=
 =?us-ascii?Q?0umMrFenOgu8ldrF7qmNoZui6V/KldukT0jb4vo0pIHD3KODYrv1WAoWZAYF?=
 =?us-ascii?Q?AzRWy1bscvC7NSVb40DeaTUbTyHwCRmJ8Rmd8F9dvfxd01mUcH/d1DuDwUnp?=
 =?us-ascii?Q?jLeBEOKVaFuPIS/Xi2ehvDccltNFMTO58fGi49g+cCcpIhYS8uge5Y/PdhEp?=
 =?us-ascii?Q?l/JIP/sSK42Bi9UwtfNQJeRzmMHfhL++BGa+mcfIDP9bD6vo2Q3PVsxcBBmo?=
 =?us-ascii?Q?POmA2O+aZpI9NgJZw2tW239FEz2crvAScYAEwjs6xUuNWJ2F/QGYgeycfxh3?=
 =?us-ascii?Q?EML8X9ocQ+H6+eqNdmI1V4t680RwyEXRvryy1Cefav9Kf4J5qxNWd3AK7TEJ?=
 =?us-ascii?Q?g7D/tcSUj4YsHIaG3P3FMuUmRfIWxasazTU18w4jb/1Cd8EDuheAmf5u5ygc?=
 =?us-ascii?Q?TXuEK/k2FaHbok+tbTSk/F+M+6Qi8F+QrXLBklQl5yWg5/1BdVUdNENoAU+H?=
 =?us-ascii?Q?2HfUf0cD0uoEon71yFJ6CiC6haN7wgVst4yfqOfwO/AvP5vgPIrU1dFm/H/v?=
 =?us-ascii?Q?EC7BBrXpXrcJsQo9kdHrXst0YQc8M0tml2Y6xX/PU21/BFwQT6AF7BQRdT4k?=
 =?us-ascii?Q?yauuYgez4HnaKHh0zAVHQT72ZNJxfs7i0t6CysmXLdgPYYOS5uoc1wm7ZxL+?=
 =?us-ascii?Q?bCHlQvjBZlInTOgm4KeJgWdWXxqxqD3FUJfbodmvxqMOqDhP2wLv0rELFguQ?=
 =?us-ascii?Q?KS1SLTqTPy/v6fXRomYHchgJQQ62NslA0WWLOs2Cp55f/Y7KqGn+pwbSp1a9?=
 =?us-ascii?Q?3lDBdeb9zNSCpVUglyU+zGS6UDo+KWQpNBaYlTEG2e7l7HjU7V6QmbQp3lG+?=
 =?us-ascii?Q?WLiUDmsjp0OXYUHGbqqYgbVR+fL6dKdyZwJIslZO74pksCCIeG8oLiMXnL4F?=
 =?us-ascii?Q?4FVRGeNKXTz7XTBb+NDJennVZn4vW5g4AZ5ttUyJqrDezzsgWzNjgTSjquIe?=
 =?us-ascii?Q?Nz0TXFpfYTWHOmJ2/TNSnS3OJQjVrBwWX+3ZZ91x8leJNbz4smWSIKSvb7SU?=
 =?us-ascii?Q?5koNtwxQz8vQ5Y8PHUcl0UpoPInDL0JPhPFJlZiLckZRrBZI4kJ5lVdFKel7?=
 =?us-ascii?Q?IsGUznIxubP/6Rv5H7luvf7cRUVBj0Yag+pLEigq8cRodkOeSpeJw=3D=3D?=
X-Microsoft-Antispam-Message-Info: dHE/j157DSSzVb1zAYonsz25Fz9qB//cziD2k1I0O7WzAdZv8VoDptJSuJpaY6fBeBiJem/3uPlHeXPJXDXD1axeZZGWdzTfdjTnz7a9G9agu7gPtf1JYO849OpyFjKYS7FIszeYd/I1sGMdUGaRhLpqZAXw/jOq/Nk2iClh+k7/BfNGCReWEKm+lV1Jxjom/mfCLKDT1qXZycr6fXbYnAZU4Bv19U+NFElHYNIqr9eB8+Tg8RfrlPKrzPvPDPwvtXkB2yl0ET2drq2ev7S3jhlI6SJnsYOwFEFMX75khIlmnWf9TqcojOEepK2+75E67FWTx+emrwcUxX3/+Y2l69NhkRE3Asrvihn2HtMJuNx5f/hBlBdcTl+4iMt9WHMsM2o+tc2ajX9GBTRB9RERsw==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2298;6:8GAA0q/RzmuEMadGKVFoMl36a8lYa5RLKAyxG6ccVc201i8odRf3/e62svGBaRku3TLO8pH0/mJY77UXdzcjW540xKpcV0VsYupKl1BCasR5H3FLU8wu7rXxY7Zqk7QGlFJ0Q5TDEXom8Bxt1tLnsxobTcl4tMpP36+cksOH7beFTGfftN24dTC6zuLsfHXpk9CO4cukgT9SRbocUBy5j2TdByOCUNZWroVHIt+uBdlrDyugMKAo1A47YZPkMcu1cMR97BX1CS1aXK9vQk1cuFKEgqQFHYAUIXPmd3mR/LOqTGdaIWzI6ExjtC8yKJGwVDNSHO0FCZM1xQx10ixwVv82LlNd5PqPxuExb0y0mMNE1wSOAlLysjPkDJzz4Kads7JusZpYGblmyJZoXt9POT0RnVcOGNgxHPhjEBr1CjyxxzfeDICgMqvjPVcNSqq3Ber3USoJtqYlRRdS2nwkwg==;5:uEK0mugK4vjIjH80h+NWP+CUKIyEjgj3hSUp1znV/jHrA++Ov9+RUJkhfBr5d1uyhFhrBXKhpz54tFVy+x4JLAMbtMpybHFQzFS/MZ3mSlsmty+fxT4bY6a9tl+Q9M+zOrQP3qsPht/ZysoJIxpeBlgzoIXTY5j1ewSZ4CjTSqw=;24:JeORyRxnzF4xJcSOFJGaGc2hwh1ZBnfwLu9strAh/X81Z6T3phoaxLUHzzYutwKb2BRUUO+g/lY3H9s2XYF8fKeYWMuSjshAOrAy3ujxC+E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2298;7:xISkYwVlT2w/0BvAX1EiwvVpYQTmwi/X33EjXRijPRVUqm+7IM+vzlpF790m/9Ht1+R6I7hW5chl6hs2WQ07j+goGHv1eQ6Uv2O0WALqZXE7xEWrLwUMMNPdOUm9qjMGBGEIr+8jyT8qTtSs+23HqrwGyPDA02pBRVjv+69ynGZEULDy0cP51diibSv8abviPnCtu0P66KNpqRZBp45FLuwEiriU5VIsmfoJFPHyjg4qU7E25Dx0zfYFLcgjxcqd;20:fd906Ep50HIUwDvmqbUVgpCLC5RTsd67uHAlgUYAgSTt4e8TZk3DNu0ErMPO2er/IF5JMFVTRsv9SXg5OFshC9K2W7qMTw/3EP/jsM8gbW9rixpJVKEjnJ44n93tEhVFTiZeM1BpQitnsQuJKMlha775b4ms8BU2czSVsjIUrmow1VcZ2t3iB4g7FLMumYjskleyiDShPnkk8/8L2cCLaKzTdh7hxxiDCJqdn0BC+qvCJtAwTlyIiLuZkDoNytJT
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:51.6715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23df7cdc-ab50-48ee-fcbc-08d5e7bb01e0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2298
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a set of event class. For each event class this patch
defines some trace events.

1. event class: usbssp_log_msg
    - usbssp_dbg_address - debug message used in function handling
	Address Device Command.
    - usbssp_dbg_context_change - debug messages related to contexti
	 updates performed with Configure Endpoint and Evaluate Contexti
	 command.
    - usbssp_dbg_reset_ep - debug messages associated with resetting i
	an endpoint.
    - usbssp_dbg_cancel_request - debug messages related to the removal
	 of a cancelled Request.
    - usbssp_dbg_init - debug messages related to the initialization
	and unload.
    - usbssp_dbg_ring_expansion - debug messages related to ring
	expansion.

2. event class: usbssp_log_ctx
    usbssp_address_ctx - debug message related to address Device command,
    that can be used to display the context data filed.

3. event class: usbssp_log_trb
    - usbssp_handle_event - debug message related to handling Events TRB.
    - usbssp_handle_command - debug message related to handling C
	ommand TRB.
    - usbssp_handle_transfer - debug message related to handling
	Transfer TRB.
    - usbssp_queue_trb - debug message related to queuing TRB.

4. event class: usbssp_log_priv_dev
    This class event  tracing at least part of an usbssp_device lifetime,
    and for now it already exposes quite a bit of valuable information.

    - usbssp_alloc_priv_device - debug message related to allocating
	 device.
    - usbssp_free_priv_device - debug message related to the freeing
	 device.
    - usbssp_setup_addressable_priv_device - debug message related to the
    	initialization of usbssp_device object.
    - usbssp_setup_device - debug message related to Address Device
	command.
    - usbssp_stop_device - debug message related to stooping device.

5. event class: usbssp_log_request
    This will help us figuring out information related to usb_request
    object.

    - usbssp_request_enqueue - debug message used during enqueuing new
	request.
    - usbssp_request_giveback -  debug message related to
	usbssp_request_giveback function
    - usbssp_request_dequeue - debug message related to dequeuing request.
    - usbssp_alloc_request - debug message related to allocation
	new request.
    - usbssp_free_request - debug message related to freeing request.

6. event class: usbssp_log_ep_ctx
    With these event class, we can track what's happening with the
    HW while executing each and every command. It will give us visibility
    into how the endpoint contexts are being modified by controller
    which can bring insight into problems while debugging.

    - usbssp_remove_request - debug message related to removing request.
    - usbssp_handle_cmd_stop_ep - debug message related to Stop Endpointi
	command.
    - usbssp_handle_cmd_set_deq_ep - debug message releted to Set Dequeue
	 Endpoint command,
    - usbssp_handle_cmd_reset_ep - debug message related to Reset Endpoint
	 command.
    - usbssp_handle_cmd_config_ep - debug message related to Endpoint
	Configure command.

7. event class: usbssp_log_slot_ctx
    With these event class, we can track what's happening with the HW
    while executing each and every command. It will give us visibility
    into how the slot contexts are being modified by controller which
    can bring insight into problems while debugging.

    - usbssp_alloc_dev - debug message related to allocating device.
    - usbssp_free_dev - debug message related to freeing device.
    - usbssp_handle_cmd_disable_slot - debug message related to
	Disable Slot command.
    - usbssp_reset_device - debug message related to resetting device.
    - usbssp_setup_device_slot - debug message related to c
	onfiguring slot.
    - usbssp_handle_cmd_addr_dev - debug message related to Address Device
	command.
    - usbssp_handle_cmd_reset_dev - debug message related to Reset Device
	command.
    - usbssp_handle_cmd_set_deq - debug message related to
	Set Dequeue command.
    - usbssp_configure_endpoint - debug message used during configuring
	endpoints.

8. event class: usbssp_log_ring
    This event class defines the events used for tracing the change
    of all kinds of rings used by an usbssp device. An usbssp ring
    is basically a memory block shared between software and hardware.
    By tracing changes of rings, it makes the life easier for.

    - debugging hardware or software problems.
    - usbssp_ring_alloc - debug message related to allocation ring.
    - usbssp_ring_free - debug message related to freeing ring.
    - usbssp_ring_expansion - debug message related with expansion ring.
    - usbssp_inc_enq - debug message related with incrementing
	dequeue pointer.
    - usbssp_inc_deq - debug message related with decrementing
	dequeue pointer.

9. event class: usbssp_log_portsc
    Track the port status each time we get a port status change event.

     - usbssp_handle_port_status - debug message used in
	handle_port_status function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-trace.c |  13 +
 drivers/usb/usbssp/gadget-trace.h | 482 ++++++++++++++++++++++++++++++
 2 files changed, 495 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-trace.c
 create mode 100644 drivers/usb/usbssp/gadget-trace.h

diff --git a/drivers/usb/usbssp/gadget-trace.c b/drivers/usb/usbssp/gadget-trace.c
new file mode 100644
index 000000000000..9994ad09eb4d
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-trace.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp.
+ */
+
+#define CREATE_TRACE_POINTS
+#include "gadget-trace.h"
diff --git a/drivers/usb/usbssp/gadget-trace.h b/drivers/usb/usbssp/gadget-trace.h
new file mode 100644
index 000000000000..07a781534f6c
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-trace.h
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM usbssp-dev
+
+/*
+ * The TRACE_SYSTEM_VAR defaults to TRACE_SYSTEM, but must be a
+ * legitimate C variable. It is not exported to user space.
+ */
+#undef TRACE_SYSTEM_VAR
+#define TRACE_SYSTEM_VAR usbssp_dev
+
+#if !defined(__USBSSP_DEV_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __USBSSP_DEV_TRACE_H
+
+#include <linux/tracepoint.h>
+#include "gadget.h"
+
+#define USBSSP_DEV_MSG_MAX	500
+
+DECLARE_EVENT_CLASS(usbssp_log_msg,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf),
+	TP_STRUCT__entry(__dynamic_array(char, msg, USBSSP_DEV_MSG_MAX)),
+	TP_fast_assign(
+		vsnprintf(__get_str(msg), USBSSP_DEV_MSG_MAX, vaf->fmt, *vaf->va);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_address,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_context_change,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_reset_ep,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_cancel_request,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_init,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DEFINE_EVENT(usbssp_log_msg, usbssp_dbg_ring_expansion,
+	TP_PROTO(struct va_format *vaf),
+	TP_ARGS(vaf)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_ctx,
+	TP_PROTO(struct usbssp_udc *usbssp_data, struct usbssp_container_ctx *ctx,
+		 unsigned int ep_num),
+	TP_ARGS(usbssp_data, ctx, ep_num),
+	TP_STRUCT__entry(
+		__field(int, ctx_64)
+		__field(unsigned int, ctx_type)
+		__field(dma_addr_t, ctx_dma)
+		__field(u8 *, ctx_va)
+		__field(unsigned int, ctx_ep_num)
+		__field(int, slot_id)
+		__dynamic_array(u32, ctx_data,
+			((HCC_64BYTE_CONTEXT(usbssp_data->hcc_params) + 1) * 8) *
+			((ctx->type == USBSSP_CTX_TYPE_INPUT) + ep_num + 1))
+	),
+	TP_fast_assign(
+		__entry->ctx_64 = HCC_64BYTE_CONTEXT(usbssp_data->hcc_params);
+		__entry->ctx_type = ctx->type;
+		__entry->ctx_dma = ctx->dma;
+		__entry->ctx_va = ctx->bytes;
+		__entry->slot_id = usbssp_data->slot_id;
+		__entry->ctx_ep_num = ep_num;
+		memcpy(__get_dynamic_array(ctx_data), ctx->bytes,
+			((HCC_64BYTE_CONTEXT(usbssp_data->hcc_params) + 1) * 32) *
+			((ctx->type == USBSSP_CTX_TYPE_INPUT) + ep_num + 1));
+	),
+	TP_printk("\nctx_64=%d, ctx_type=%u, ctx_dma=@%llx, ctx_va=@%p",
+			__entry->ctx_64, __entry->ctx_type,
+			(unsigned long long) __entry->ctx_dma, __entry->ctx_va
+	)
+);
+
+DEFINE_EVENT(usbssp_log_ctx, usbssp_address_ctx,
+	TP_PROTO(struct usbssp_udc *usbssp_data, struct usbssp_container_ctx *ctx,
+		 unsigned int ep_num),
+	TP_ARGS(usbssp_data, ctx, ep_num)
+);
+
+
+DECLARE_EVENT_CLASS(usbssp_log_trb,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb),
+	TP_STRUCT__entry(
+		__field(u32, type)
+		__field(u32, field0)
+		__field(u32, field1)
+		__field(u32, field2)
+		__field(u32, field3)
+	),
+	TP_fast_assign(
+		__entry->type = ring->type;
+		__entry->field0 = le32_to_cpu(trb->field[0]);
+		__entry->field1 = le32_to_cpu(trb->field[1]);
+		__entry->field2 = le32_to_cpu(trb->field[2]);
+		__entry->field3 = le32_to_cpu(trb->field[3]);
+	),
+	TP_printk("%s: %s", usbssp_ring_type_string(__entry->type),
+			usbssp_decode_trb(__entry->field0, __entry->field1,
+					__entry->field2, __entry->field3)
+	)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_handle_event,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_handle_command,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_handle_transfer,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DEFINE_EVENT(usbssp_log_trb, usbssp_queue_trb,
+	TP_PROTO(struct usbssp_ring *ring, struct usbssp_generic_trb *trb),
+	TP_ARGS(ring, trb)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_priv_dev,
+	TP_PROTO(struct usbssp_device *priv_dev),
+	TP_ARGS(priv_dev),
+	TP_STRUCT__entry(
+		__field(struct usbssp_device *, priv_dev)
+		__field(struct usb_gadget *, gadget)
+		__field(unsigned long long, out_ctx)
+		__field(unsigned long long, in_ctx)
+		__field(u8, port_num)
+	),
+	TP_fast_assign(
+		__entry->priv_dev = priv_dev;
+		__entry->gadget = priv_dev->gadget;
+		__entry->in_ctx = (unsigned long long) priv_dev->in_ctx->dma;
+		__entry->out_ctx = (unsigned long long) priv_dev->out_ctx->dma;
+		__entry->port_num = priv_dev->port_num;
+	),
+	TP_printk("priv_dev %p gadget %p ctx %llx | %llx, port %d ",
+		__entry->priv_dev, __entry->gadget, __entry->in_ctx, __entry->out_ctx,
+		__entry->port_num
+	)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_alloc_priv_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_free_priv_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_setup_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_setup_addressable_priv_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DEFINE_EVENT(usbssp_log_priv_dev, usbssp_stop_device,
+	TP_PROTO(struct usbssp_device *vdev),
+	TP_ARGS(vdev)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_request,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request),
+	TP_STRUCT__entry(
+		__field(struct usb_request *, request)
+		__field(void *, buf)
+		__field(unsigned int, length)
+		__field(dma_addr_t, dma)
+		__field(struct scatterlist*, sg)
+		__field(unsigned int, num_sgs)
+		__field(unsigned int, num_mapped_sgs)
+		__field(unsigned int, stream_id)
+		__field(unsigned int, no_interrupt)
+		__field(unsigned int, zero)
+		__field(unsigned int, short_not_ok)
+		__field(unsigned int, dma_mapped)
+		__field(int, status)
+		__field(unsigned int, actual)
+	),
+	TP_fast_assign(
+		__entry->request = request;
+		__entry->buf = request->buf;
+		__entry->length = request->length;
+		__entry->dma = request->dma;
+		__entry->sg = request->sg;
+		__entry->num_sgs = request->num_sgs;
+		__entry->num_mapped_sgs = request->num_mapped_sgs;
+		__entry->stream_id = request->stream_id;
+		__entry->no_interrupt = request->no_interrupt;
+		__entry->zero = request->zero;
+		__entry->short_not_ok = request->short_not_ok;
+		__entry->dma_mapped = 0 /*request->dma_mapped*/;
+		__entry->status = request->status;
+		__entry->actual = request->actual;
+	),
+
+	TP_printk("req %p;  buf %p, len %d, dma %llx, sg %p, num_sg %d, num_m_sg %d,"
+			"stream_id %d, no_int %x, zero %x, short_not_ok %x, dma_mapped %x, "
+			"status %d, actual %d",
+			__entry->request,
+			__entry->buf, __entry->length, __entry->dma, __entry->sg,
+			__entry->num_sgs, __entry->num_mapped_sgs, __entry->stream_id,
+			__entry->no_interrupt, __entry->zero, __entry->short_not_ok,
+			__entry->dma_mapped, __entry->status, __entry->actual
+		)
+
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_request_enqueue,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_request_giveback,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_request_dequeue,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_alloc_request,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DEFINE_EVENT(usbssp_log_request, usbssp_free_request,
+	TP_PROTO(struct usb_request *request),
+	TP_ARGS(request)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_ep_ctx,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx),
+	TP_STRUCT__entry(
+		__field(u32, info)
+		__field(u32, info2)
+		__field(u64, deq)
+		__field(u32, tx_info)
+	),
+	TP_fast_assign(
+		__entry->info = le32_to_cpu(ctx->ep_info);
+		__entry->info2 = le32_to_cpu(ctx->ep_info2);
+		__entry->deq = le64_to_cpu(ctx->deq);
+		__entry->tx_info = le32_to_cpu(ctx->tx_info);
+	),
+	TP_printk("%s",  usbssp_decode_ep_context(__entry->info,
+		__entry->info2, __entry->deq, __entry->tx_info)
+	)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_remove_request,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_stop_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_set_deq_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_reset_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_ep_ctx, usbssp_handle_cmd_config_ep,
+	TP_PROTO(struct usbssp_ep_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_slot_ctx,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx),
+	TP_STRUCT__entry(
+		__field(u32, info)
+		__field(u32, info2)
+		__field(u32, int_target)
+		__field(u32, state)
+	),
+	TP_fast_assign(
+		__entry->info = le32_to_cpu(ctx->dev_info);
+		__entry->info2 = le32_to_cpu(ctx->dev_info2);
+		__entry->int_target = le64_to_cpu(ctx->int_target);
+		__entry->state = le32_to_cpu(ctx->dev_state);
+	),
+	TP_printk("%s", usbssp_decode_slot_context(__entry->info,
+			__entry->info2, __entry->int_target,
+			__entry->state)
+	)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_alloc_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_free_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_disable_slot,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_reset_device,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_setup_device_slot,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_addr_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_reset_dev,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_handle_cmd_set_deq,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DEFINE_EVENT(usbssp_log_slot_ctx, usbssp_configure_endpoint,
+	TP_PROTO(struct usbssp_slot_ctx *ctx),
+	TP_ARGS(ctx)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_ring,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring),
+	TP_STRUCT__entry(
+		__field(u32, type)
+		__field(void *, ring)
+		__field(dma_addr_t, enq)
+		__field(dma_addr_t, deq)
+		__field(dma_addr_t, enq_seg)
+		__field(dma_addr_t, deq_seg)
+		__field(unsigned int, num_segs)
+		__field(unsigned int, stream_id)
+		__field(unsigned int, cycle_state)
+		__field(unsigned int, num_trbs_free)
+		__field(unsigned int, bounce_buf_len)
+	),
+	TP_fast_assign(
+		__entry->ring = ring;
+		__entry->type = ring->type;
+		__entry->num_segs = ring->num_segs;
+		__entry->stream_id = ring->stream_id;
+		__entry->enq_seg = ring->enq_seg->dma;
+		__entry->deq_seg = ring->deq_seg->dma;
+		__entry->cycle_state = ring->cycle_state;
+		__entry->num_trbs_free = ring->num_trbs_free;
+		__entry->bounce_buf_len = ring->bounce_buf_len;
+		__entry->enq = usbssp_trb_virt_to_dma(ring->enq_seg, ring->enqueue);
+		__entry->deq = usbssp_trb_virt_to_dma(ring->deq_seg, ring->dequeue);
+	),
+	TP_printk("%s %p: enq %pad(%pad) deq %pad(%pad) segs %d stream %d free_trbs %d bounce %d cycle %d",
+			usbssp_ring_type_string(__entry->type), __entry->ring,
+			&__entry->enq, &__entry->enq_seg,
+			&__entry->deq, &__entry->deq_seg,
+			__entry->num_segs,
+			__entry->stream_id,
+			__entry->num_trbs_free,
+			__entry->bounce_buf_len,
+			__entry->cycle_state
+		)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_ring_alloc,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_ring_free,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_ring_expansion,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_inc_enq,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DEFINE_EVENT(usbssp_log_ring, usbssp_inc_deq,
+	TP_PROTO(struct usbssp_ring *ring),
+	TP_ARGS(ring)
+);
+
+DECLARE_EVENT_CLASS(usbssp_log_portsc,
+		TP_PROTO(u32 portnum, u32 portsc),
+		TP_ARGS(portnum, portsc),
+		TP_STRUCT__entry(
+				__field(u32, portnum)
+				__field(u32, portsc)
+				),
+		TP_fast_assign(
+				__entry->portnum = portnum;
+				__entry->portsc = portsc;
+				),
+		TP_printk("port-%d: %s",
+			__entry->portnum,
+			usbssp_decode_portsc(__entry->portsc)
+			)
+);
+
+DEFINE_EVENT(usbssp_log_portsc, usbssp_handle_port_status,
+		TP_PROTO(u32 portnum, u32 portsc),
+		TP_ARGS(portnum, portsc)
+);
+
+#endif /* __USBSSP_TRACE_H */
+/* this part must be outside header guard */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE gadget-trace
+
+#include <trace/define_trace.h>
-- 
2.17.1

