Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19921C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A564320875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rwVxsACo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A564320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeGLFz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:55:56 -0400
Received: from mail-eopbgr720086.outbound.protection.outlook.com ([40.107.72.86]:52128
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726852AbeGLFzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+716KDScWYox4QRnDAYrjiR+6U11C7gyL/m1XSjXuuQ=;
 b=rwVxsACoQTk7WshX21X4nebhwiYf/lcsLt7CJJeDTj7gy1jmWtIQJu4J1GjMlR4bMDFp9faT02hxE+VV+c8NekYK+zMQrzfaF58bDxkMK3DVPZvpnqtphttp+k8cTsHajvhMFZugL3GCum6dhYR4X/L5w/VKsHC7P1qMkqiWI1k=
Received: from SN4PR0701CA0023.namprd07.prod.outlook.com
 (2603:10b6:803:28::33) by BYAPR07MB4712.namprd07.prod.outlook.com
 (2603:10b6:a02:f0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:47:53 +0000
Received: from BY2NAM05FT034.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::208) by SN4PR0701CA0023.outlook.office365.com
 (2603:10b6:803:28::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:53 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT034.mail.protection.outlook.com (10.152.100.171) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.9 via
 Frontend Transport; Thu, 12 Jul 2018 05:47:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw0032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:52 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:03 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:03 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5ll5V029542;
        Thu, 12 Jul 2018 06:47:47 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5llNo029535;
        Thu, 12 Jul 2018 06:47:47 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 06/31] usb: usbssp: added template functions used by upper layer.
Date:   Thu, 12 Jul 2018 06:47:03 +0100
Message-ID: <1531374448-26532-7-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(36092001)(76176011)(7636002)(42186006)(86362001)(575784001)(316002)(305945005)(16586007)(54906003)(426003)(186003)(246002)(8936002)(8676002)(336012)(50226002)(47776003)(109986005)(356003)(26005)(2906002)(486006)(476003)(126002)(107886003)(446003)(2616005)(11346002)(478600001)(5660300001)(4326008)(14444005)(4720700003)(1671002)(26826003)(87636003)(6666003)(106466001)(105596002)(48376002)(50466002)(36756003)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4712;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT034;1:FA65nU7pdj73GqWqnIYGJjOYFduaQYkfASp2RrO95cGzmDyS3K4CsWn9sZrlnJAGDJeax7gCUp4PAD+6wGd/8ZrlO5FHdGs4uF1vx5xO5za7PamghNL/sLIXNMjfqzjJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8da62c59-a6a9-4c91-3059-08d5e7bb02cc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;3:xCn72cj6xrDfBun5s+LYJfLbHegURFcWf0kpWhvyyeTkZ6m9PXzRMgfjrkUVG0Uq+0PYPjosVsaAkAiZHixKVtSp26gnR4zTDj3aaeuknnIohzMrwQnMOt1mTSL6Q+qKtDsgXRsUINaMErvmsa98Hg7A8G1pEacM4HtIHFisi5dsKPTr8CgNRIkw+m+LdnJMvoWvmntCKTUAERJyAtaodRgo2DZjdRuCCwmQ6E9sas2AAg7fmSE5i/h3hhUU/Txq8TBjHTVKan9PKunwLldT9kzchHRMN9/qF/1e1juQ8OMcWXaRtexMrzycKllSndJHL2K/1E+QxnYUl0Ib8RKlg9aKQeqsyA9/tz3KyUaYJ6A=;25:/ueg0/AmvrcK1tuFUeRxqSZpV5DDw2zUigiIe2CDuaVZ9a5pb9gZGlJuSh9eoFWa5/xoGYCltxHCeYRs72oJ2e2TYbRMu7oZPkdBMvCnI5mfJiUbM8mVEjzkH+17uEWCTS2NIlRn8+IYGB1jjG9PvmL6cVkFElVPPf7o+JZ43qlOJKdBfgh6G03J9c5JHGABnU44FVI6SeOFG3YRPmKk4Vtx7HetnHjQffmJkb/t+Vk4HNlOYJo7HOJUuIxJuNhCtUHZ1FuX7RP9BB0SZJ94kOuHM9rC6TYz1e/RcCjDZAhu3qKcMyGv9Y5OhQT9hbP4yjhQsSzyruYO/B0wTtXR5Q==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4712:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;31:N+3+dP2eAwgMYL7Bv0lvZv9cq1cZUOs1jJFUQtUDDRtGqXxBWtdbF1CYOpYSz9t0xn8XrPmHUmTL4yoc5BS8gxEIxDfHyl6wOjzzYbKn4eWohEcXaREZI2V4XNfv/mYbg4pi89v+5xpMHcXi+Dhoz2G1y2pEMj2JMVIv8HUGykBP1rMldAlR6gX4+90lBedI7lPj20UoYBOb7S8/LVfCOFyLNOJTe7E9HScQ1FTM0uY=;20:+nX7bqsn6dz0bNJcD2zSg8MnFA4pIesj2eK2RZq68DgDc17bVuvc2H0KenPMUXbjqklLq2HaRgGbeyzSfJ7VEe3zv2YnBrlUpbzfDuelwXCK9ecvEmutxjF3QYF/g9F2HvtHXMgcxahKGVQdUIrjPXXcjGC5GY4YG0K88rSezLMw5vSDni1QsVqOxedRqhiX4yvmbT9ATNlrwI0FcXkO99O+XeOXYcDk2zfuoXnsiM6GhFbLXoJB1YhjyJ/VCpn0rzHtu8n1ZxS+eigCVZup6F0PHt6WuRKc1eBsTII3hezHgy1CNg89hgzyycmEfJGRI8VYLS/gfo8cGmluZO5iCEt98m62Q5c4Mi5SU0txNSSvXamiKkkQeMypmggIRqcSdd2f1T7dIdsAxrqyGGo3hURnofetxmgv2IKIMatChPsXMuS2ZH07bjzJqYOS+d7nfq9kJAFAYDSG6S3E+K5xRpWNYx9wT+OCWB/j8uHO7mnESg63fqbbPWkD6FEFayVE
X-Microsoft-Antispam-PRVS: <BYAPR07MB4712BD1E8A7F93BA9C18E38DDD590@BYAPR07MB4712.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4712;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;4:N6+6yLWPX8GiFPlorzcOVpAEahsnOXXBeonymaz4vqMO5Y7gboCBRabCV7/p2j2YvJ6ABmeL3adD6v8GkxtRs7SDTXR53UW+WDgae3EHOuppp23L6brk6TDYg+KOE0bvTrTdIi5C0wRJ/k21URQlkUvLgq4pHv9J2/g2yGTEzFkFPoRJgj1pJz3OCrLoKJbWjB4JshWaDAiyjBlWqIbhdLFEltDAI1OLPiH76a7SH01s/CpXr7jpBnUfyoXjOoN/uJM4pXCWkmuFE+IhpGYhpmgUSa3/hNvHH940nzMw3ZQuYFxotrQ93RWpbWnEYdP/Y7ZL3rnnpT2zX3b+TG0zVyGlBqfvKKxBTKFPAMr798g=
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4712;23:RvvxJNZ41n8GnIcY6azXhgqsj4PQ15g1whvlrJ7YW?=
 =?us-ascii?Q?D2p5l2YFBg/4tdRotx2sfj0G1E6Np8TBaHrvKGtyEk3JXTn2smVKJHNBMgnv?=
 =?us-ascii?Q?6bDzBPPU6L8rZVN8EkE5G1zywCNDIAdEREI8qTKQ5YeYo0Y6CnMvNbCOLpZ4?=
 =?us-ascii?Q?O6g2Y3ZsuxaPvoFoznyJiIDYxQEJyJGp5rOH13BYEEV102xuBrF/Ir8ELQ4D?=
 =?us-ascii?Q?QdixZDpoVg7fqxELvjF1EvOEF4g/WApupRNjZiVTEB1q3ochTs4T1lDU9/fj?=
 =?us-ascii?Q?T/TVrpKOnVPiL2SkHaEms2I0D9UzHafSCwufH0VzsSF78ZGq9y+D4O0T87+Q?=
 =?us-ascii?Q?7vh43j1BOmAr1bvj8DzcvREImrUNTUqSorPm+W286rL4QfnHyccKwxHBoSxT?=
 =?us-ascii?Q?ZbvNRZibu3gcMGXLZs0aVH2J2a2zOsy//U6bUSRghOhIp8vxnW56ORgXx78r?=
 =?us-ascii?Q?q2I3Ehys9+i1rFgk9iX64vlPAr0p13yS0a6+YTNWU5oGEwFi17J0tc5WQwhQ?=
 =?us-ascii?Q?il4UzWDGl/ONUAIjmWTppeVyGx4QiaLVq9SAjS9lDppJJUgf9lA5vf88Za15?=
 =?us-ascii?Q?3/Jg2K8FsdUIwbM9lpW0m/d34FUllR5cTWjtf0atjPdPHgQHAJBHcjNCqhQP?=
 =?us-ascii?Q?vgkf0Pd0x87SVgbTHJrdXQZophbOjcBx0w+kbrDXDAchIcW4lg0vhRs9N9bl?=
 =?us-ascii?Q?DB7/KOx/2ETijY1c6LKcyzjgjTNE/KVumdYIVaCquqcscjN08KBUGadwCYmj?=
 =?us-ascii?Q?PVW3nktNWfxcUv9KKmVrLzLoXcowA7EFZ/3rA31l9kN6kJ8OgDu/RbCBHhMo?=
 =?us-ascii?Q?ELtriy0LHaHgQJiMf6+vpcHb4V4bn6Y62hlGQ8VplJv4IQQw2Hu/IpXzZbu/?=
 =?us-ascii?Q?Dhf8d1Yd78WnAaXNXoMRiQ800/Jchy1rSvlvYkCzx2Tp4uwDOVJq9I1lB3vK?=
 =?us-ascii?Q?LV168oMqAES852K0ykYhlzyVAIoleyVlaybXQ/Sx/9DiqZamHiM8njVM9iBm?=
 =?us-ascii?Q?kC8izOrAs7I5FbUXSiPKC8bby7XeeObIoX1VYXxf6s4V4fUJLZyLAljmFFst?=
 =?us-ascii?Q?Mln5mMzlq1MIGEe3QfVY6Ck735rTjz+1AmvvrJlWkXuMQcfOcivboXbSd6tn?=
 =?us-ascii?Q?qADPVmzIj8FkwVspq86ZsIghhQg2dbHzxgQMDauqMux0+moT/ayNYwa/6Oc3?=
 =?us-ascii?Q?jJ9LRYWd+4BvaM=3D?=
X-Microsoft-Antispam-Message-Info: 7vmeRSq+WqvfdXlDuhrp4NOKXo3k7UXoj76Hr/pKXoKMIF4JDqu4lJSSgfomIfjwOF6hvhmMHRKXbvBANr2GP16hzUIOHRkCMaIqvuOzB1qUM17NVknDyX+qO7Gf3AnMGRA17Ei9Tc4auZYc637XXhpuK0zc11PO39JDnp4jjbRBwjyNIeoA7r5cr2DX8IaO7r38DzvAn/oo1hE/xlC5y6vNLhzlm8a8DftxqveKGCKk1FHTww58hN9EsQcjGspGSZI0FqX7qj2d9F2oXO70XMq9+O1bXRO0/4AndpRRwi+k2pg7dBEaaeHs/xqKEx8DyDNn6VoAb77vPPEYTrS6vf0gMt/NJ8FGhewydMhDq7uoq2jtZafviYK6cCqtNpI3CMsboTqFYptekxbdS85RKQ==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;6:uNQ0Ta1klNTldsE7/eTPvpN4QMdngw+K3wtSZp6XJtQB+5qyJf+fRtkPG503G6HF+g3+iGe8k9XbV0PqOzdeR+loJSnB271JblpHENXcE1YEckKC9lx1hC1jFCbbADgBvYW7wxPUOp3+6Dxx7RqQgiRECxJFsmgMn9vIAIPrqpGPoVH3FuVULurbyP9xGpA3dbvY7yQ2YpatzRDSw9pIhb7y7hCjwwTuYulBGhyX1aXBcs3taI7nPvgQwHoFL/72t7mggH/LSwf2Jw0T48P6duv6oppGeF7hsrk8FRAp/yWjl4R+Y8bq3RgS8nK13f2ObpnYdneTg/XywoUN3nyo6IVRwYluC6N5RyOvHeMqfTTPCy2DwvdH4NWDpyth/AafsapovCtRwhc8AUfUKzHxxXXNKxpUvHBG3QrwQwXRGH7IkqE0i+pWLkwa6f7c5OSpBI7wNdLFyjs1h33NfYf7Ag==;5:6wAaT3muIiB6thPSqQIC7BaaRk3r582aDV6B0zY9nKc9ao7qDNg0dc+UnDooSwiktxGBQUeZ2J/7eASUj3YgS8Zn9ZgzMszVMMfC1ru25LkMX6CkHM4Td23src1BgE48oWh1ylH555WwoUY7LvaIlZTNABJ4zG6CRPBA+RkH7Y8=;24:hM0V8aJ5/QhXNinF2HK1+yRhoP136h0uJTy9lAW9D77iZatW5a47zhIFWQ6hab/0HjRxhukm+jtjhPlMeb4pcyI++HdpYxD+cfZz0pQpLEE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;7:AhNDL9xz419N8uXCq4mZGlmRN+ZKQb2gOAq/BWCRRwLIWOSOqNnOmMC/c65MlLWfLp+BGumOLrjCgTx17wmeaFBcVM9mc/37SPLSTR8tTmXAsQ99WuKUwVr0dlttvs/9M1SijZalRpFg3cPxxSUjVhxp4laB+IsMl1o71NRmxH5GX/4KEsEysI5jt0vA9JLr2H0hdh/tUJ0QODSGQ187k1PRvkp0MjiJ9iN1loF7zS50ji4b5LdqGFAu7/N1h3tY;20:n2OJr+OmytDPDRciFUbs/arE6pIxEJmrOMnRkI0aWD7qxaIL1iWLJG/WyjXMPJd+rrKWFXgS0JHhuNLVty3seHRu8/H2SX56bInpBn4IaenNIrUPlBizqcMS79J7nYy4hYqTVrT6gzM0t1owvS5730iTvSPEOIFCKU/U3qENP2gjbHkoNniY+3bXQhv0V5KccGF+d5+OF8FGrFR1e7j/l10JAaNuJIxc+CGULXWk3pqkst0B+rv+MEVkqnwWBHfD
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:53.4004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da62c59-a6a9-4c91-3059-08d5e7bb02cc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4712
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds some functionality for initialization process.
It adds to driver usbssp_reset and usbssp_start function.

Next elements added are objects usbssp_gadget_ep0_ops,
usbssp_gadget_ep_ops and usbssp_gadget_ops. These objects
constitute the interface used by gadget subsystem.
At this moment functions related to these objects are empty
and do nothing.

This patch also implements usbssp_gadget_init_endpoint and
usbssp_gadget_free_endpoint used during initialization.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ext-caps.h |   3 +
 drivers/usb/usbssp/gadget-if.c       | 268 ++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.c          |  86 ++++++++-
 3 files changed, 349 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ext-caps.h b/drivers/usb/usbssp/gadget-ext-caps.h
index 0107bc18ad7d..2cadb5e0d15f 100644
--- a/drivers/usb/usbssp/gadget-ext-caps.h
+++ b/drivers/usb/usbssp/gadget-ext-caps.h
@@ -51,3 +51,6 @@
 #define USBSSP_CMD_EWE			(1 << 10)
 
 #define USBSSP_IRQS	(USBSSP_CMD_EIE | USBSSP_CMD_HSEIE | USBSSP_CMD_EWE)
+
+/* true: Controller Not Ready to accept doorbell or op reg writes after reset */
+#define USBSSP_STS_CNR			(1 << 11)
diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index d53e0fb65299..c3fa3be7d494 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -12,13 +12,277 @@
 #include <linux/usb/composite.h>
 #include "gadget.h"
 
+static int usbssp_gadget_ep_enable(struct usb_ep *ep,
+		const struct usb_endpoint_descriptor *desc)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+int usbssp_gadget_ep_disable(struct usb_ep *ep)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static struct usb_request *usbssp_gadget_ep_alloc_request(struct usb_ep *ep,
+							  gfp_t gfp_flags)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+
+	if (!ep_priv)
+		return NULL;
+
+	/*TODO: implements this function*/
+	return NULL;
+}
+
+static void usbssp_gadget_ep_free_request(struct usb_ep *ep,
+		struct usb_request *request)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+
+	if (!ep_priv)
+		return;
+
+	/*TODO: implements this function*/
+}
+
+static int  usbssp_gadget_ep_queue(struct usb_ep *ep,
+				   struct usb_request *request,
+				   gfp_t gfp_flags)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static int usbssp_gadget_ep_dequeue(struct usb_ep *ep,
+				    struct usb_request *request)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static int usbssp_gadget_ep_set_halt(struct usb_ep *ep, int value)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static int usbssp_gadget_ep_set_wedge(struct usb_ep *ep)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static const struct usb_ep_ops usbssp_gadget_ep0_ops = {
+	.enable		= usbssp_gadget_ep_enable,
+	.disable	= usbssp_gadget_ep_disable,
+	.alloc_request	= usbssp_gadget_ep_alloc_request,
+	.free_request	= usbssp_gadget_ep_free_request,
+	.queue		= usbssp_gadget_ep_queue,
+	.dequeue	= usbssp_gadget_ep_dequeue,
+	.set_halt	= usbssp_gadget_ep_set_halt,
+	.set_wedge	= usbssp_gadget_ep_set_wedge,
+};
+
+static const struct usb_ep_ops usbssp_gadget_ep_ops = {
+	.enable		= usbssp_gadget_ep_enable,
+	.disable	= usbssp_gadget_ep_disable,
+	.alloc_request	= usbssp_gadget_ep_alloc_request,
+	.free_request	= usbssp_gadget_ep_free_request,
+	.queue		= usbssp_gadget_ep_queue,
+	.dequeue	= usbssp_gadget_ep_dequeue,
+	.set_halt	= usbssp_gadget_ep_set_halt,
+	.set_wedge	= usbssp_gadget_ep_set_wedge,
+};
+
+static struct usb_endpoint_descriptor usbssp_gadget_ep0_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bmAttributes =		USB_ENDPOINT_XFER_CONTROL,
+};
+
+static int usbssp_gadget_start(struct usb_gadget *g,
+			       struct usb_gadget_driver *driver)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+	int ret = 0;
+
+	if (usbssp_data->gadget_driver) {
+		usbssp_err(usbssp_data, "%s is already bound to %s\n",
+				usbssp_data->gadget.name,
+				usbssp_data->gadget_driver->driver.name);
+		ret = -EBUSY;
+	}
+
+	/*TODO: add implementation*/
+	return ret;
+}
+
+static int usbssp_gadget_stop(struct usb_gadget *g)
+{
+	struct usbssp_udc *usbssp_data  = gadget_to_usbssp(g);
+
+	if (!usbssp_data)
+		return -EINVAL;
+	/*TODO: add implementation*/
+	return 0;
+}
+
+static int usbssp_gadget_get_frame(struct usb_gadget *g)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+
+	if (!usbssp_data)
+		return -EINVAL;
+
+	/*TODO: add implementation*/
+	return 0;
+}
+
+static int usbssp_gadget_wakeup(struct usb_gadget *g)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+
+	if (!usbssp_data)
+		return -EINVAL;
+
+	/*TODO: add implementation*/
+	return 0;
+}
+
+static int usbssp_gadget_set_selfpowered(struct usb_gadget *g,
+		int is_selfpowered)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+
+	if (!usbssp_data)
+		return -EINVAL;
+
+	/*TODO: add implementation*/
+	return 0;
+}
+
+static const struct usb_gadget_ops usbssp_gadget_ops = {
+	.get_frame		= usbssp_gadget_get_frame,
+	.wakeup			= usbssp_gadget_wakeup,
+	.set_selfpowered	= usbssp_gadget_set_selfpowered,
+	.udc_start		= usbssp_gadget_start,
+	.udc_stop		= usbssp_gadget_stop,
+};
+
 int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data)
 {
-	/*TODO: it has to be implemented*/
+	int i = 0;
+	struct usbssp_ep *ep_priv;
+
+	usbssp_data->num_endpoints = USBSSP_ENDPOINTS_NUM;
+	INIT_LIST_HEAD(&usbssp_data->gadget.ep_list);
+
+	for (i = 1; i < usbssp_data->num_endpoints; i++) {
+		bool direction = i & 1;  /*start from OUT endpoint*/
+		u8 epnum = (i >>  1);
+
+		ep_priv = &usbssp_data->devs.eps[i-1];
+		ep_priv->usbssp_data = usbssp_data;
+		ep_priv->number = epnum;
+		ep_priv->direction = direction;  /*0 for OUT, 1 for IN*/
+
+		snprintf(ep_priv->name, sizeof(ep_priv->name), "ep%d%s", epnum,
+				(ep_priv->direction) ? "in"  : "out");
+
+		ep_priv->endpoint.name = ep_priv->name;
+
+		if (ep_priv->number < 2) {
+			ep_priv->endpoint.desc = &usbssp_gadget_ep0_desc;
+			ep_priv->endpoint.comp_desc = NULL;
+		}
+
+		if (epnum == 0) {  //EP0 is  bidirectional endpoint
+			usb_ep_set_maxpacket_limit(&ep_priv->endpoint, 512);
+			usbssp_dbg(usbssp_data,
+				"Initializing %s, MaxPack: %04x Type: Ctrl\n",
+				ep_priv->name, 512);
+			ep_priv->endpoint.maxburst = 1;
+			ep_priv->endpoint.ops = &usbssp_gadget_ep0_ops;
+			ep_priv->endpoint.caps.type_control = true;
+
+			usbssp_data->usb_req_ep0_in.epnum = ep_priv->number;
+			usbssp_data->usb_req_ep0_in.dep  = ep_priv;
+
+			if (!epnum)
+				usbssp_data->gadget.ep0 = &ep_priv->endpoint;
+		} else {
+			usb_ep_set_maxpacket_limit(&ep_priv->endpoint, 1024);
+			ep_priv->endpoint.maxburst = 15;
+			ep_priv->endpoint.ops = &usbssp_gadget_ep_ops;
+			list_add_tail(&ep_priv->endpoint.ep_list,
+					&usbssp_data->gadget.ep_list);
+			ep_priv->endpoint.caps.type_iso = true;
+			ep_priv->endpoint.caps.type_bulk = true;
+			ep_priv->endpoint.caps.type_int = true;
+
+		}
+
+		ep_priv->endpoint.caps.dir_in = direction;
+		ep_priv->endpoint.caps.dir_out = !direction;
+
+		usbssp_dbg(usbssp_data, "Init %s, MaxPack: %04x SupType:"
+				" INT/BULK/ISOC , SupDir %s\n",
+				ep_priv->name, 1024,
+				(ep_priv->endpoint.caps.dir_in) ? "IN" : "OUT");
+
+		INIT_LIST_HEAD(&ep_priv->pending_list);
+	}
 	return 0;
 }
 
 void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
 {
-	/*TODO: it has to be implemented*/
+	int i;
+	struct usbssp_ep *ep_priv;
+
+	for (i = 0; i < usbssp_data->num_endpoints; i++) {
+		ep_priv = &usbssp_data->devs.eps[i];
+
+		if (ep_priv->number != 0)
+			list_del(&ep_priv->endpoint.ep_list);
+	}
 }
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 75272dd2447a..67845e8368bc 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -103,6 +103,83 @@ int usbssp_halt(struct usbssp_udc *usbssp_data)
 	return ret;
 }
 
+/*
+ * Set the run bit and wait for the device to be running.
+ */
+int usbssp_start(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+	int ret;
+
+	temp = readl(&usbssp_data->op_regs->command);
+	temp |= (CMD_RUN | CMD_DEVEN);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Turn on USBSSP, cmd = 0x%x.", temp);
+	writel(temp, &usbssp_data->op_regs->command);
+
+	/*
+	 * Wait for the HCHalted Staus bit to be 0 to indicate the device is
+	 * running.
+	 */
+	ret = usbssp_handshake(&usbssp_data->op_regs->status,
+			STS_HALT, 0, USBSSP_MAX_HALT_USEC);
+
+	if (ret == -ETIMEDOUT)
+		usbssp_err(usbssp_data, "Device took too long to start, waited %u microseconds.\n",
+			USBSSP_MAX_HALT_USEC);
+	if (!ret)
+		/* clear state flags. Including dying, halted or removing */
+		usbssp_data->usbssp_state = 0;
+
+	return ret;
+}
+
+/*
+ * Reset a halted DC.
+ *
+ * This resets pipelines, timers, counters, state machines, etc.
+ * Transactions will be terminated immediately, and operational registers
+ * will be set to their defaults.
+ */
+int usbssp_reset(struct usbssp_udc *usbssp_data)
+{
+	u32 command;
+	u32 state;
+	int ret;
+
+	state = readl(&usbssp_data->op_regs->status);
+
+	if (state == ~(u32)0) {
+		usbssp_warn(usbssp_data, "Device not accessible, reset failed.\n");
+		return -ENODEV;
+	}
+
+	if ((state & STS_HALT) == 0) {
+		usbssp_warn(usbssp_data, "DC not halted, aborting reset.\n");
+		return 0;
+	}
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init, "// Reset the DC");
+	command = readl(&usbssp_data->op_regs->command);
+	command |= CMD_RESET;
+	writel(command, &usbssp_data->op_regs->command);
+
+	ret = usbssp_handshake(&usbssp_data->op_regs->command,
+			CMD_RESET, 0, 10 * 1000 * 1000);
+
+	if (ret)
+		return ret;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"Wait for controller to be ready for doorbell rings");
+	/*
+	 * USBSSP cannot write to any doorbells or operational registers other
+	 * than status until the "Controller Not Ready" flag is cleared.
+	 */
+	ret = usbssp_handshake(&usbssp_data->op_regs->status,
+			STS_CNR, 0, 10 * 1000 * 1000);
+
+	return ret;
+}
 
 /*
  * Initialize memory for gadget driver and USBSSP (one-time init).
@@ -183,8 +260,7 @@ int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 
 	usbssp_dbg(usbssp_data, "Resetting Device Controller\n");
 	/* Reset the internal DC memory state and registers. */
-	/*TODO: add implementation of usbssp_reset function*/
-	//retval = usbssp_reset(usbssp_data);
+	retval = usbssp_reset(usbssp_data);
 	if (retval)
 		return retval;
 	usbssp_dbg(usbssp_data, "Reset complete\n");
@@ -250,8 +326,7 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
 	BUILD_BUG_ON(sizeof(struct usbssp_run_regs) != (8+8*128)*32/8);
 
 	/* fill gadget fields */
-	/*TODO: implements usbssp_gadget_ops object*/
-	//usbssp_data->gadget.ops = &usbssp_gadget_ops;
+	usbssp_data->gadget.ops = &usbssp_gadget_ops;
 	usbssp_data->gadget.name = "usbssp-gadget";
 	usbssp_data->gadget.max_speed = USB_SPEED_SUPER_PLUS;
 	usbssp_data->gadget.speed = USB_SPEED_UNKNOWN;
@@ -292,8 +367,7 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
 	usbssp_gadget_free_endpoint(usbssp_data);
 err1:
 	usbssp_halt(usbssp_data);
-	/*TODO add implementation of usbssp_reset function*/
-	//usbssp_reset(usbssp_data);
+	usbssp_reset(usbssp_data);
 	//TODO freeing memory
 	//usbssp_mem_cleanup(usbssp_data);
 err3:
-- 
2.17.1

