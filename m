Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFC7ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF462080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="NTQ+9tsn";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="mxJq06iX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF462080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbeKABdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:33:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54248 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726720AbeKABdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:33:13 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9VGT2dS001121;
        Wed, 31 Oct 2018 09:34:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=g9RRrDBUVFPtdijrsTlCWUg2ntKiArz2FRIOXqGNnaY=;
 b=NTQ+9tsnX2xmt1rqt8jVbIDoKjBeQcDfRVR6zjdIvrbAIWU94vYE+z+mAfHie0GER+A7
 6qmKl7/m9/CX0LiHvvsNVFqKbwpveJ5Tr2IpGGZonM8CjOBDrEX/I86nlxMWkVtUaj2M
 g2ktgCtc1dOIjMDDrWumuTNAbMYjK0LkBI/0xu5GD8+4DI/EZbGkNcdi1gcGB3tZXLGI
 kfs5MB4t7sK3DVhQOy8yN2gxJTd1g1+Leh63MI1srgDHTw2Buypv6Gk8crZyUMkxuSFP
 ftDVT5SE4iJh7TGxii6naPqFvOWX3gb09DLF+4eDk6BPxWhIjJf3SnqbrP+s5/1o2Y8Z gg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0176.outbound.protection.outlook.com [216.32.181.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nckkxm6f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 31 Oct 2018 09:34:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9RRrDBUVFPtdijrsTlCWUg2ntKiArz2FRIOXqGNnaY=;
 b=mxJq06iXeluz0EKotVoXRfKRD/J1v6GtjPTrzYnrtB3WbaHqqiVE0Z6NtvAzM1D53/2cXEJos1pxarr+OaINgWXW3kOc+tEJ27u5WZ5rVTAqDlNu6RXT8b+v3Bu73g8aXXiSYeTUghJKe4R54Bzi9DDFjl82foo35r6fiDxZLxA=
Received: from DM5PR07CA0104.namprd07.prod.outlook.com (2603:10b6:4:ae::33) by
 BY1PR0701MB1864.namprd07.prod.outlook.com (2a01:111:e400:51ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.20; Wed, 31 Oct
 2018 16:34:16 +0000
Received: from DM3NAM05FT057.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by DM5PR07CA0104.outlook.office365.com
 (2603:10b6:4:ae::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.22 via Frontend
 Transport; Wed, 31 Oct 2018 16:34:16 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT057.mail.protection.outlook.com (10.152.98.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Wed, 31 Oct 2018 16:34:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w9VGYCRZ026392
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 31 Oct 2018 09:34:14 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 31 Oct 2018 17:34:16 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 31 Oct 2018 17:34:16 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w9VGYACE026750;
        Wed, 31 Oct 2018 16:34:10 GMT
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w9VGYALN026746;
        Wed, 31 Oct 2018 16:34:10 GMT
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: Document cadence Sierra PHY bindings
Date:   Wed, 31 Oct 2018 16:34:06 +0000
Message-ID: <1541003646-26637-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(189003)(199004)(36092001)(26826003)(5660300001)(478600001)(426003)(105596002)(51416003)(316002)(110136005)(26005)(50226002)(7636002)(16586007)(2906002)(87636003)(86362001)(8676002)(476003)(50466002)(48376002)(2201001)(126002)(106466001)(486006)(2616005)(4326008)(246002)(356004)(6666004)(305945005)(8936002)(36756003)(336012)(186003)(42186006)(107886003)(14444005)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1864;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT057;1:VvdEH3c9RFlZSuZJ6rqds1fcj73z6kuGUXBCodBs3WPelx46s27XKPhi9s1lUnTaJpjcEwL/3p8jGzCUK26Oj/Im35AUl5uw0vNP+cJ6le4+dxDzYKoZ2ZR3BuKY/l37
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98eea538-329d-45b5-b505-08d63f4eb2c7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BY1PR0701MB1864;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;3:ts9jloLOjMG25jP1ZDbd8jWnDHvGzpbLaAptdpGPEc7yB179fZotVytuttDhJiX9Cq4I5cj3AtlzGEfXgV0SypyZhUwedkiUGw1d/egNnFC2aR0r6IYjmU4ccNP8krli6XPam7ImC6eXPLKiTUVQQSPifYdnyEJWyAukEroXjfg2aulDDvGZMW+HP1kSobSPRWMVrZjLu0tMiyYuVVlo9smMVQK34+yzD8DZGK1WKyJzLktOisGhJU6o1L8bO1W+4e3CEYPi1rynEkibgP0C0rHWLS8ToqcSMofmaIACdVFTaKt398HFuw5HExyL3Rd+WRgZGpr4mGw9uzGao/z0U35CiYUmCuND7B19nbvHnGQ=;25:hisTXmbCYYsOeHooilc5p8T4iXf8+FUnI4zxdKkVEmIIguNT2R36VsV+umPZnUiv9dKn5p6TrUKcimBpIcGXnaD2PcYONiOdPoz4dj5/f/hopNEWBNRr1RxG2Du9NwJaDUZeVrVTyP1tIAv7AUBpfjr4zj/StG7XQI6oEZsPmEfvi0nBTMIELFt1u+u5jXPWZ9+vvBzSQdWIV7FkVqXQc2Ewbx61r1ahD9HhfpHTEvlPLaQ0H1B06PwLfftfqkR14rqCE5Yabio6OdI18ujspgwpKX+LoP5DsOt6/0tq31PeEkBDYpw0+XpGtSXkOZQcPo6rwur468QZT8Y5Qheerw==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1864:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;31:xtqowz/N5uGLOrsjsZvfMVQ7LZMEB0LY1WODd0e0LLzjR+at8+69WJ58gUVzxAn+WWL4MdokVJMEUf8A4zhHMTOBQWsPzyD8LGTkTggw7VxHW/dsQ0H9g8aL6MxdTYK9TBYaPskEb+KS7wthD4S8kqKV3TBzU8Ed6aisHqz2CMT+D3eYWUTL08PRdIOmGSlwS25BmOGJfkNIZwuJzE1M0MvRsAyP0CqNFFs+O/0IkVo=;20:kbca7jnYazklZBvVzQdlVC9+/21cEq/5lu5TdYtVnsUyKTbaMLwfIeXr+Cp8fjdPdIcVUcxny8QMutdtdjqziRcjzoQaz8VNG128qJfxgecWNeXZkRYMbMMGq/q7dB7w0FFit/8WA9IuOSFTLv8T8sogCqHacUARHQmwom7bLfafTNzR5qbtTAGzPjalvH3L+8DBMA4NYI2rKxVro1atmCkee1aQMZV4rAUYVnUCc87Bvk46/zdQXS+gpBMMg0+mXMrKpyaZ0pMCU9AwMVgvIYwG7/M8DBV6kcAhblpIA+3QVWv0XCVi2TPiDoTOEvUzkKCaf05JxwrEv7zPDdLflS/yY/iCHGnQJEwdCfV++oqhy4RgSAeCP59XgRvOg0nv8AcbWrt6W92od3yliHtazgmKZMQCt6RmR7YGMnmIWy0BRk4i0bYjdB8pb7TjhIs/SVPXbP4qJ2B5wD31qSP5uRFIwUo064QtLexc6s4Ev2gVbfXSn6G/KOI+YsjilsfC
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1864A7C6BA42C4EA8DF3759ED8CD0@BY1PR0701MB1864.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY1PR0701MB1864;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1864;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;4:q8ILNMGiL79kHQpfxEdL5ok+SqJxy5SsmdEFB4yD0W9xJO4FtZIbuWbZ7M6AIpB2+dQrOlzIaSdt5pMHXyobTddt8Ys3p3wAGgihTCaQLGycOQpNhooSDeJvYi0DJPmBV6v4dUfD0Yu0H1aoxOaBQQB++me1sv0j+Fdmp8t64yzqslsT2dc5OGzjm9wGfIxVOJ3tWeIelJ+ZpH4Sro7u0Z+9eWCD6Emv1UXMmQK4r163WhDrSAIEdv43h4fdtVjcs7cAtSwZwOqJL+nl6C0htYQff+VRpvmiHRMbSGvYG2DSygNkhxglgdUvqwHcY5DI
X-Forefront-PRVS: 084285FC5C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1864;23:Ybf9kGMBU0DIaJhqg4vEt2TMwvsZftnzzWAf5DX?=
 =?us-ascii?Q?PucQZ9bLFaXcy+Hu1+xHy0iCFa1f+igZxBC3B3pi0YJfkVnin6Gdvtkng7me?=
 =?us-ascii?Q?fDAksFmFZMywha9yo+FFwj9iilufux8lfJZ6mvTZndyrR9Dreqcxf3spo2RO?=
 =?us-ascii?Q?zn9ohnXctKijKl8rIfAB2wnCi+i3u4DBVojxUbIxX6VNCz8ZryqXz30Fl3ee?=
 =?us-ascii?Q?5V8rZd0uu6sFGLzNkeARDbGhtz1HnEigmnPpy9v8wiam+s+Rot0KGQipah6T?=
 =?us-ascii?Q?SZ3L50kRju+UA3DyZM+/EQJgeQqCQRF1zXSX3euE+Vf/9czzOFUNOBKuUwPr?=
 =?us-ascii?Q?vrjvMr2OyjCLd0Ejnilj9f5LZvsYCbNmlFTjjIEsheuaR2jRzm2e6Qs4zw1D?=
 =?us-ascii?Q?jvFksuAOHvECiZX78dw9ZO2pW61bOS+deG70Sh+WkYQ9gCbxymsa1zHp86wH?=
 =?us-ascii?Q?/rmzoZCwxmQX2pLM+fHIrEAnZEVzEbur48HpBplwrAvS29up9SFwvxjJm45v?=
 =?us-ascii?Q?DX4LfdZYfANb9dtQkfTJCtc+0z6BpfptqQdQ8hkm8lqBUnHmkg3uk+J/WyJR?=
 =?us-ascii?Q?efPiFA4Z4Gr2AzAXKprROSKEulFno2TWJidkMksEefa/Ipa/JJt1Dd/KYWaj?=
 =?us-ascii?Q?0FS0vCvHz6XDz8NfYL2DSinAfmPkg0wXBJUKyZ0058S+wChnkpxGzHYMTnl8?=
 =?us-ascii?Q?uTcLFHUenZKPpBAsARmOD+LD/ulpT5NCuUPZNYKLb7cnIG8YNfoI0A2L2Rfx?=
 =?us-ascii?Q?rcipDJbZqYkE01MQL5ITDl/FYrPqYleJeONWVCNiLwzjUukBoQMQN4fcLzFs?=
 =?us-ascii?Q?w7Eu1ys9wvsz1+XElPpmr07q6TnI+jsxGIIpvz1QZu96c57SlWZwhO1ObH6b?=
 =?us-ascii?Q?JVNpt4/jsBe+ZBw0GKODn8cLfNqMxkGpEbJESrzq58PH///9OimCTXFIwT9V?=
 =?us-ascii?Q?MKRYo+AcSFXSTNyvZVVxe0GH0kdkA4tZ5dRtlfhQ7AEZHxCwqof2F1BWgGfD?=
 =?us-ascii?Q?J3xI8VK+DdYn+Xz1BWjf85Zqj/jwFNy1srt1czOXVHE3sMg=3D=3D?=
X-Microsoft-Antispam-Message-Info: J8KMnG6iWtLdEHh6PAVSsYkZP/+KXE6S0aFN2zMBhlBb/309h3fbPKD11LSOwBHNmpM9gI7a9VJ0JBOJpHVM/pm1saXexx5fhqh9a5dWuyGqo3ic/ZP/H/RxERCLkS4J6751+r3QB6PtjRRcDPHED0fS1rO3N0OeAKmkKzT/gGqU9x36IoKE+0w3ZoPwdR5NPYZjpJhFuigTsnKreLozqHbNlhYeF2VyNrl+UsKuruIANUxOCdrZ+0YwLttfNJpfD5bPutRK7vJ1IciI6BK7oyP4MQf26JfciTI6r5MWKrlCckkWpNOZmlhbqz4Pz4GMeV4kiJKi+3Y2aeUZfhi38IUWBBu/d8cxqx0O0u2zhqc=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;6:lGJtyZYL9l1XCQBbKAlFCuBL+HxmbFZmWKBIXChsHZL6Hn+9NtgkNj26yoGraAKgVFeUDms2YCDIacD4dvZIkL+Rp+rYVDeeDIr+ZPBjSwdwArk8PjwDPY2RVwv/6jeDUw9PjmMXfASf/ydvm2uBnzJA16QTHjRNGDDrvdthdp4zsUhU0H5CmrrYe7BDATG+urK5242rFOC68tGPOkQtx5hGKfkboYw/dPXNUBgVDBbLRklnGdMYjK66akLczANT7cW1/EwCs7M0iALfkx6NVhBT1SAIIwZYcQJfiNEA3dUmkAWGO3Iq6V5vS2sYum/eRO8zkSsHFVqMCe5MA/pueFEwUeOwTtjIOL9nynTZ7CuqRo9t/A1NX6z7ld7JvOBPntSY/qnYsVa2+b/4JlzOeZP0wKDebccJ/AM076GAojyWhOUvWihgKUBaHAKa96X3CZ07uzF9eIYNYTGhjoZwYw==;5:m+evZkD9YfrCErYJYKdylerVHF/YpZaOBrnZ+e4I5fTV7YcYfQc0l7cdTv6z+T496Juame/qv5N4SVDt750Mjm+433+NMSXqqg8yUt42EWd6gwXn0Gg09QhCaF6zxZyybddjfLN1AMHSeL03aP3gGA3FklWl+KyG9ZazNlb6yZk=;7:Ix1V5/CUgIuzMxDFLp9/o4VjtSx619kFhD7Z5RWufzLp+8gFte3mRus6XbcdISWoHhiyoDWXMKl5jyqmItSmOZBa+tiHRziJPaXM38CS+ro73QebewloJT+rSooI7dQg3YcigFEnvZxIjPpagoopKw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1864;20:sPOAAWjeYa5k5iaFqdwkTMntTIdMoGJoBfBRjsqho4sfV+6uAoel0N9kQgZghe/5stoUH+BiWkXKA7AqZHGjJ7sqBPO/3lXxLRZQ4CYZyN/MixOabELTjhVwG+S/Je3uD1SCb6Jsl3wmgYuQjkx6jJ1maWpoOCZ6Mzaukxr/Pc1p38Dga5sOu2pdi0MCGpNZKxTqYkVoaspLRrTGHdm+KTk46e6VvsyWpv0pMdjmSlynU7B+tfWIH8B8pY8pZhgk
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2018 16:34:15.5341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eea538-329d-45b5-b505-08d63f4eb2c7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1864
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for Sierra PHY.  The PHY supports
a number of different protocols, including PCIe and USB.

The PHY lanes may be configured as single or multi-lane links.
Each link is treated as a separate sub-node.  For example, if
there are 4 lanes in total the first 2 might be configured as
a multi-lane PCIe link while the other two are single lane
USB links, and in this case there would be 3 sub-nodes.

There are two resets for the PHY block (one for APB register
access, one for the PHY link) and separate resets for each
link.  For multi-lane links, the reset corresponds to the
reset line on the master lane, the resets on other lanes
have no effect.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 .../devicetree/bindings/phy/cdns-sierra-phy.txt    | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
new file mode 100644
index 0000000..67efdb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
@@ -0,0 +1,68 @@
+Cadence Sierra PHY
+-----------------------
+
+Required properties:
+- compatible:	cdns,sierra-phy-t0
+- clocks:	Must contain an entry in clock-names.
+		See ../clocks/clock-bindings.txt for details.
+- clock-names:	Must be "phy_clk"
+- resets:	Must contain an entry for each in reset-names.
+		See ../reset/reset.txt for details.
+- reset-names:	Must include "sierra_reset" and "sierra_apb".
+		"sierra_reset" must control the reset line to the PHY.
+		"sierra_apb" must control the reset line to the APB PHY
+		interface.
+- reg:		register range for the PHY.
+- #address-cells: Must be 1
+- #size-cells:	Must be 0
+
+Optional properties:
+- cdns,autoconf:	A boolean property whose presence indicates that the
+			PHY registers will be configured by hardware. If not
+			present, all sub-node optional properties must be
+			provided.
+
+Sub-nodes:
+  Each group of PHY lanes with a single master lane should be represented as
+  a sub-node. Note that the actual configuration of each lane is determined by
+  hardware strapping, and must match the configuration specified here.
+
+Sub-node required properties:
+- #phy-cells:	Generic PHY binding; must be 0.
+- reg:		The master lane number.  This is the lowest numbered lane
+		in the lane group.
+- resets:	Must contain one entry which controls the reset line for the
+		master lane of the sub-node.
+		See ../reset/reset.txt for details.
+
+Sub-node optional properties:
+- cdns,num-lanes:	Number of lanes in this group.  From 1 to 4.  The
+			group is made up of consecutive lanes.
+- cdns,phy-type:	Can be PHY_TYPE_PCIE or PHY_TYPE_USB3, depending on
+			configuration of lanes.
+
+Example:
+	pcie_phy4: pcie-phy@fd240000 {
+		compatible = "cdns,sierra-phy-t0";
+		reg = <0x0 0xfd240000 0x0 0x40000>;
+		resets = <&phyrst 0>, <&phyrst 1>;
+		reset-names = "sierra_reset", "sierra_apb";
+		clocks = <&phyclock>;
+		clock-names = "phy_clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pcie0_phy0: pcie-phy@0 {
+				reg = <0>;
+				resets = <&phyrst 2>;
+				cdns,num-lanes = <2>;
+				#phy-cells = <0>;
+				cdns,phy-type = <PHY_TYPE_PCIE>;
+		};
+		pcie0_phy1: pcie-phy@2 {
+				reg = <2>;
+				resets = <&phyrst 4>;
+				cdns,num-lanes = <1>;
+				#phy-cells = <0>;
+				cdns,phy-type = <PHY_TYPE_PCIE>;
+		};
+
-- 
1.9.0

