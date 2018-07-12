Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2250C468C7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5890920875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lOgwPt9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5890920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbeGLF7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:59:38 -0400
Received: from mail-eopbgr720086.outbound.protection.outlook.com ([40.107.72.86]:52128
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbeGLFzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w6v6jxUVsfnlEVaDue7RMpiwDugk92RGsz7TMkAax0=;
 b=lOgwPt9cNkJ7oZuqbP0N0qh6qsOTzx3lK2p3FPFxqLulr/KAjE5qxQYVFs10AA7G/rWTfzhVytg0xrPH96u58pB6KecdoJ38wV3XWCW/1yrN2IdUhySWBb8bVg/KdC5KtpZrAo1Um4wu6HRTpSERZy228O2IMsdZ9zlQsIRvZK0=
Received: from DM5PR07CA0084.namprd07.prod.outlook.com (2603:10b6:4:ad::49) by
 BYAPR07MB4712.namprd07.prod.outlook.com (2603:10b6:a02:f0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 05:47:51 +0000
Received: from BY2NAM05FT036.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by DM5PR07CA0084.outlook.office365.com
 (2603:10b6:4:ad::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:51 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT036.mail.protection.outlook.com (10.152.100.173) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.973.9 via
 Frontend Transport; Thu, 12 Jul 2018 05:47:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkvu032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:49 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:02 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:02 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5ljOh029483;
        Thu, 12 Jul 2018 06:47:46 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5ljMi029476;
        Thu, 12 Jul 2018 06:47:45 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Date:   Thu, 12 Jul 2018 06:46:59 +0100
Message-ID: <1531374448-26532-3-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(36092001)(43544003)(76176011)(7636002)(42186006)(86362001)(316002)(305945005)(16586007)(54906003)(426003)(186003)(246002)(8936002)(8676002)(336012)(50226002)(47776003)(109986005)(356003)(26005)(2906002)(486006)(476003)(126002)(107886003)(446003)(2616005)(11346002)(478600001)(5660300001)(4326008)(14444005)(4720700003)(1671002)(26826003)(87636003)(6666003)(106466001)(551934003)(105596002)(48376002)(50466002)(36756003)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4712;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT036;1:RqatsX6vL52B2/bEr2HLkQ4GQPSc6ii/Stn3KSsD7gw2joYhQafcj14+xsWcdfGmE4nLR2tAcGjXAnme9Cy0FtsqU9t09D597x7WMfBYnQFU4RWBJidEjsy+387NbZsp
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bda3ec8-93d5-4539-3b39-08d5e7bb0112
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;3:LNsT8GeydekJe635Jht4dFOjVT4oE4A+irHrfKc0+LU44kro0127gRQiSR+4vQRHvX3F4vt4Rjc2q72qGyfOnZ716o4NyTwevUnvQ2+fl5EgE9UsDcnjx/DjlcKwJpwtrPMn52DzAoLFdwuVnuchrqvzd9aaiq/jqlfANplX7pWDGOgybk37o7zigsJUodrvcfCQQ7bw/cWXueK294Iienw5g0olk53VN4xONKWd47virShKXUhHt1WK+pJ+vDBXQyHzckWOOUWbyrExCYcxWQFo/ocbNHsgyMtBeP77x2RpLzvqvSKF/zOW2QLx1tTx7cbENsO2fJSzdDnDXSTI1dsvkC59H1cdRxXiYQ8sH5M=;25:8x395qp3lOXoK/IyRolt/q1+0DuMFyKVb6YWJ076d93AxHTPsvnmnWTLcerWKsIF5bHXrFvPj4ZzbSebxY1ONcaipUBostxInIA7WNjbG/EJJoMHLCixZPP0s3r49U68bNymuwnMwV20tkS+QNMWMKPvYTUJcSdtvTEIYaYM8LERIvvEpd3y2XWa9jxlv9XSMJR0Dy/ECDGiX7Pwg48nzPBf0AXJZ10o9/vBglMsQjUJFkVpSRZzPog5sOVcTJOcPGUr8LmT5GkZBABpdCPix2mVkFZw6zCv8F+turxyZWA/mFmB813dCL+bLJvT+snqt09qkVQGYFaGWeV56TyUTw==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4712:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;31:sABkoLoj98zuzmfi2ZFiMj3hC5hbAR2cujO2BetgjGldsWNk6ocaTwk9yYaJaK04PH0PNgKUldHDnTjvmYAFRaG5wD/jiAK7Ou0OBwR/E2LQEfje80Y4jz/EcM9s+C2UgGHQZ9gowvrOt9Lc3Q4fhHsRpxqwEkeOXyqm+qnLLEyFziXIzHOGzK97KlTB0C6vAL4Zs38JgucaColO6ZrOG5KoRxuAfq//in+8CRNeeL4=;20:fZFeCXzNRDn6XdE6DkpUjq4sjbGruJJO88NRuXCz+Zdp/aMthAEjzJfSBqlJcRAt0Azm7X3njctVF6YjTNkIgkMv7nqUD1fg+VowQR1VjEoKgRMa3zqwIClGl2lHb1ZvFiN71eV35Wvo7sUWKQR7o0eg/Y2ONt+YNfxlrwbdi+f+VjUaw43B+bL4cORszRbnIhHli+mDtSFphqSQgtxYTUrDPoxJdHEuDitnR1JVmy6p8T5nlcmV8S8775I8o8TVS9wxi4+pGw2GGqMow7t4HTHykYWIJv1+MV1xrSOkpdCZ9aCEmXDovjdg5hYf4lTtgiLjyUjhUtHDelRV6K2AM0eiufiGMO7hlochHpSPp6RuyTcVTX+EbQL0KueKlqZRvpqGiii1Em+8u1EZmET77MgM2cvNObQxk0ZSKLE2CACg/Fxx50KNGn15c/QydJHFtOVArIICRtfm2kCkJNaWIAzivodhvT30AJw6ZkvnwUNdX/ycxqNShv6dlEkl+kxE
X-Microsoft-Antispam-PRVS: <BYAPR07MB4712C4BD4D9285386F1CA15EDD590@BYAPR07MB4712.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4712;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;4:UPIM9yZ3ai5TahVx18Wxq8jFy0VF8KNJMNiMg4xIFnLXTkUcQU9wTGmaB2ixdHFijhfc5kIuUA76H0ogjjNLda36BWPSjPQH7CacttAzjAJR1N5GCJQhMbxewVR8UUF7dwv8/SKGce50ZWPU0QUkAfaaZLhf4+QGVO7lgiGd2IlfNx9yrAHZJL/b3SsUl4B0dG65SfMu70tqyfbzPT8P7SvcwBO0/oGECiSNrPwypeNlWzKRRqz9FYBiLnkeuQ4SuIIMPRHWP+nsFq5CUndjfhqS8qSqBF4nKwV/7KhnuX6ZiqMKaZ83Unv3jFWAFRjO
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4712;23:Jhezjo/HgwlRaPnNo4n/3P2uJrYyEWITA4OxemY1D?=
 =?us-ascii?Q?HscgLrTxpe7Y5/hUGxwOSEWvgM8D5/eOM9vfCKPIkirJOjvIG879muy5mD6R?=
 =?us-ascii?Q?sQVdqDsjjUsQNjlQIu+EClVIUOIn+yJ0wWhRQARP2/hThFQmrmwkTZVx8ldn?=
 =?us-ascii?Q?ciIeUv/D22gnz8P84+1TgdHJqkmIh28PSDHiKEggHsfgG7VzDqW/GJBDYlEX?=
 =?us-ascii?Q?KhFmCKEcW9Zx/3zrA61tZFrQcBR/vn7hD/81rs3cA0WeqVtaTNuaXXDYtVlX?=
 =?us-ascii?Q?r9auJvTc5r+OGksyapgUU5hXtLqGKBHweA75Mo0WbHSN11lgfyTHIsPr3icq?=
 =?us-ascii?Q?0ljMj+OZj6jbg/uW1f0bXBB4GrXKbPYF8ZPkl8G1r+PB2WacJQ3nbI8myugz?=
 =?us-ascii?Q?cbnrVbYMnUzjXS9bmNFd7voHuUWtswioS3yeg9N/vfaFaX5ZSejCq3+RC4fF?=
 =?us-ascii?Q?t0E/r0lClMgdb26HHcUtDcC0CnKDuHcksCTE+TS3YsMWbDI4kPSZfc8Fn5mI?=
 =?us-ascii?Q?AlaSE2eTCP9I+1cOXHL7Esib8XTDOEkjbyWBZibDK+oS87rnaKtzxcZROt5S?=
 =?us-ascii?Q?6MkrFHv3SbmVU7IUJqlE6pXU1VEqs2LBtBkQVtUrdyJVCQEgOfrtFQKVcliv?=
 =?us-ascii?Q?mOGbwtlOvKLv+7EmCd288ro9l7iTDrzX+s+vLSu+dT4Fds/Kn/riFmi1xWNd?=
 =?us-ascii?Q?akbb18+sRTjabDaPP9qCyyyBKr1l2bNixCTbQGRaAIu5dzReFvop5+8pJ6R7?=
 =?us-ascii?Q?G05bdzhlsKJZiYo7ytNfkd2Kq5NEg/R6d8OCaWhiHAtind9Du7vDn/WaA1FI?=
 =?us-ascii?Q?d7ywDA7dGJU5prOUe/LvHnFl8qQF9M+cz4gjSTnjEo+6HRFEHXvWutC9NYkf?=
 =?us-ascii?Q?5lRln4gRyS96CyF6Vd3OX0oOJ3/cpU6NfL6BOmQGToUrmcwuy3iQMw7lk0ey?=
 =?us-ascii?Q?iwLmLO16+71lu2Kge5s5+ozfDycui3I6hzXQ+IM0Mr688Dhw+EwfNURqoRIA?=
 =?us-ascii?Q?T1gcG97XP8mxK3sQ54Kl/O7JnMNzk9fXhIJtXV0v91QAvb4Xx+cn3UxAnvf+?=
 =?us-ascii?Q?k8FcmqtHe59mgSyQXTO89ZhPQQXeaWYULzbR9HPP6mAfHscI9CCxYHVRDQ0S?=
 =?us-ascii?Q?wjPiClCt8EDJoGdFqSHbefRamyN3hRnBThdGRheyIOTP8cz9MmXE6KpJWf++?=
 =?us-ascii?Q?numtw4ox63mGEFvnLOXPKMmY+W8gxMv/YBA?=
X-Microsoft-Antispam-Message-Info: vnuubc9QNf7e5+VOrd3vYkjHn2nfJ+DeHb6dZgsVvCbHIXDcXULLAFQBHR9tGzAr6+bWmXXT0BpcWFRxC09rXPbol6IxhTHHDinHrM29xv81YLfcefE5u4MiDPFmIXVbl4D1zhV+xI4GLyF4pXFADwuRsqtb2wbxkb4YnBhvMp+0Z1KMMPy9bN9XQI7Rq2rsEmxWUsetT0zB62pseLJ8wdMfO9KhynVgxn6FMLNm56OOxU8mawf/x62MF0vfmf+f6i2r41FllX/XCuxOJuZ3fuATtfTCj/okOTzrUsKQN8khn4hhUjhQdjvp/+dyw71DuQeAsE0NLD5SrFxl1kVENMcEgP5hBvq4zOjBypspGLIe9859COYGYH92ha1fnoeK/cAdOTj7qLj1cVIuymw7QA==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;6:raYUlKxFmeQYJw95F+AvPkn2+35ut1gUQTVW84LF7cN9miME5K2sSZ2v7ygk03x1WWoTpML+/9ebr8PxgzwMG5wFJjMrWlTYk0C1t2gwQp61iNo4o09FvqiXSP7iFNH59wOM4hKz7HJOmTCYY/QAuXGau9yh+83YwPw8yNQChKVi4SAup3NSXMnHwcwD1TmId9AWD2xkBS4PTLdd4Hm21/JLgxYMD6n7kYpChXITwSPlufCN67uTohAJo2fxhBlZ84FbCphFGTwGJzajhlD07aT74qBuCH6WP9PP7JYRdsqbxao3mFWV15cvANg6XbhkpHrgTOQ19dI9fIAY1D4dR2iw74051fSplFInxWmlZbVfR98CWy3MIKExurvtgxykwOoXdxo9wImxb2PJ6JWcHB519uETdX9qdOXqxuFQxS66vIBWemG/FJoSFZt832spgLQ2BIjuo69n8NLqSnCEaA==;5:DRuOjwWGWElUF5T6BMfopDpwNM06cTyiOzqY5o7f4hhOcyRmcfQBRGYJCFyLvTU3mkYrRAJ7YhySCOj0d+iqdpTCyfPdaS2jH1SWtgNEGlOj0pSKrchDDeT3DbU2UsRws3UMpVG4TqBgVj9rl/isbEMhuvn1es36+Dt6n5F+PHQ=;24:q8JjU4jO/xdUuPKTrm54l0CRsB1hf+lSoifFCGR8qmldrdH9qXY+OjH2cj2qs6f0p5trV2cYhn6gN1h9eRcHBdTdl6dD2RJZEw0l28hpc7U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;7:K7Cq1rT63nVLi1Uf5mtXCNyM0VdTEZobBK1No4ZBmKpHWdOZUKbCXWcl4wyy3KcSbdzZigfmzL9kBbQHyBH5dAzQTGKRjH2ZzqrNoJXxjlQ64V9/MvYBEwfxV/O5ZXlvCQmiIr0qgS2lrBGK4iezbhAS2orTaKz4l5fVTXugGVfHFvi1cLoCCMLgpbEO1HvD1tuZqIPBzpuZyzkOBua9sh77erirMRDsRfyFGLGDTW9TSo8RHywGFDei60aiX5w0;20:mawlj/IkaFvp119ahDgq39v481P9VziZX8ZBW+LQkiNYVS45IRX1SONa5clxOLrlMf4nitCwTth9QiwRNwmBADhD4i8p0QY8ZT6EZAwZW7/nidwhoEoaaUfbRRW/dSqD+CVScJaSkLODSLds2WkC9lIccXHttega+QFROQmPUWBzOxjYQRg9svjbfSrQP2P8Z74l1GdO97rMVRxA69/NExOEnBpE+wNPP13xFkU8PR8Ihj5015zc5IVPZw2HSmnu
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:50.5040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bda3ec8-93d5-4539-3b39-08d5e7bb0112
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4712
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add additional functions that converts some fields to string.

For example function usbssp_trb_comp_code_string take completion c
ode value and return string describing completion code.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget.h | 572 ++++++++++++++++++++++++++++++++++++
 1 file changed, 572 insertions(+)

diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 486e868068b7..6b634dc63d9e 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -922,6 +922,73 @@ struct usbssp_transfer_event {
 #define COMP_UNDEFINED_ERROR		33
 #define COMP_INVALID_STREAM_ID_ERROR	34
 
+static inline const char *usbssp_trb_comp_code_string(u8 status)
+{
+	switch (status) {
+	case COMP_INVALID:
+		return "Invalid";
+	case COMP_SUCCESS:
+		return "Success";
+	case COMP_DATA_BUFFER_ERROR:
+		return "Data Buffer Error";
+	case COMP_BABBLE_DETECTED_ERROR:
+		return "Babble Detected";
+	case COMP_USB_TRANSACTION_ERROR:
+		return "USB Transaction Error";
+	case COMP_TRB_ERROR:
+		return "TRB Error";
+	case COMP_RESOURCE_ERROR:
+		return "Resource Error";
+	case COMP_NO_SLOTS_AVAILABLE_ERROR:
+		return "No Slots Available Error";
+	case COMP_INVALID_STREAM_TYPE_ERROR:
+		return "Invalid Stream Type Error";
+	case COMP_SLOT_NOT_ENABLED_ERROR:
+		return "Slot Not Enabled Error";
+	case COMP_ENDPOINT_NOT_ENABLED_ERROR:
+		return "Endpoint Not Enabled Error";
+	case COMP_SHORT_PACKET:
+		return "Short Packet";
+	case COMP_RING_UNDERRUN:
+		return "Ring Underrun";
+	case COMP_RING_OVERRUN:
+		return "Ring Overrun";
+	case COMP_VF_EVENT_RING_FULL_ERROR:
+		return "VF Event Ring Full Error";
+	case COMP_PARAMETER_ERROR:
+		return "Parameter Error";
+	case COMP_CONTEXT_STATE_ERROR:
+		return "Context State Error";
+	case COMP_EVENT_RING_FULL_ERROR:
+		return "Event Ring Full Error";
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		return "Incompatible Device Error";
+	case COMP_MISSED_SERVICE_ERROR:
+		return "Missed Service Error";
+	case COMP_COMMAND_RING_STOPPED:
+		return "Command Ring Stopped";
+	case COMP_COMMAND_ABORTED:
+		return "Command Aborted";
+	case COMP_STOPPED:
+		return "Stopped";
+	case COMP_STOPPED_LENGTH_INVALID:
+		return "Stopped - Length Invalid";
+	case COMP_STOPPED_SHORT_PACKET:
+		return "Stopped - Short Packet";
+	case COMP_MAX_EXIT_LATENCY_TOO_LARGE_ERROR:
+		return "Max Exit Latency Too Large Error";
+	case COMP_ISOCH_BUFFER_OVERRUN:
+		return "Isoch Buffer Overrun";
+	case COMP_EVENT_LOST_ERROR:
+		return "Event Lost Error";
+	case COMP_UNDEFINED_ERROR:
+		return "Undefined Error";
+	case COMP_INVALID_STREAM_ID_ERROR:
+		return "Invalid Stream ID Error";
+	default:
+		return "Unknown!!";
+	}
+}
 struct usbssp_link_trb {
 	/* 64-bit segment pointer*/
 	__le64 segment_ptr;
@@ -1274,6 +1341,27 @@ enum usbssp_ring_type {
 	TYPE_EVENT,
 };
 
+static inline const char *usbssp_ring_type_string(enum usbssp_ring_type type)
+{
+	switch (type) {
+	case TYPE_CTRL:
+		return "CTRL";
+	case TYPE_ISOC:
+		return "ISOC";
+	case TYPE_BULK:
+		return "BULK";
+	case TYPE_INTR:
+		return "INTR";
+	case TYPE_STREAM:
+		return "STREAM";
+	case TYPE_COMMAND:
+		return "CMD";
+	case TYPE_EVENT:
+		return "EVENT";
+	}
+
+	return "UNKNOWN";
+}
 struct usbssp_ring {
 	struct usbssp_segment	*first_seg;
 	struct usbssp_segment	*last_seg;
@@ -1564,4 +1652,488 @@ struct usbssp_udc {
 #define usbssp_info(usbssp_data, fmt, args...) \
 	dev_info(usbssp_data->dev, fmt, ## args)
 
+/*
+ * Registers should always be accessed with double word or quad word accesses.
+ *
+ * Registers with 64-bit address pointers should be written to with
+ * dword accesses by writing the low dword first (ptr[0]), then the high dword
+ * (ptr[1]) second. DC implementations that do not support 64-bit address
+ * pointers will ignore the high dword, and write order is irrelevant.
+ */
+static inline u64 usbssp_read_64(const struct usbssp_udc *usbssp_data,
+		__le64 __iomem *regs)
+{
+	return lo_hi_readq(regs);
+}
+
+static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
+				 const u64 val, __le64 __iomem *regs)
+{
+	lo_hi_writeq(val, regs);
+}
+static inline char *usbssp_slot_state_string(u32 state)
+{
+	switch (state) {
+	case SLOT_STATE_ENABLED:
+		return "enabled/disabled";
+	case SLOT_STATE_DEFAULT:
+		return "default";
+	case SLOT_STATE_ADDRESSED:
+		return "addressed";
+	case SLOT_STATE_CONFIGURED:
+		return "configured";
+	default:
+		return "reserved";
+	}
+}
+
+static inline const char *usbssp_decode_trb(u32 field0, u32 field1, u32 field2,
+		u32 field3)
+{
+	static char str[256];
+	int type = TRB_FIELD_TO_TYPE(field3);
+
+	switch (type) {
+	case TRB_LINK:
+		sprintf(str,
+			"LINK %08x%08x intr %d type '%s' flags %c:%c:%c:%c",
+			field1, field0, GET_INTR_TARGET(field2),
+			usbssp_trb_type_string(type),
+			field3 & TRB_IOC ? 'I' : 'i',
+			field3 & TRB_CHAIN ? 'C' : 'c',
+			field3 & TRB_TC ? 'T' : 't',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_TRANSFER:
+	case TRB_COMPLETION:
+	case TRB_PORT_STATUS:
+	case TRB_DOORBELL:
+	case TRB_HC_EVENT:
+	case TRB_DEV_NOTE:
+	case TRB_MFINDEX_WRAP:
+		sprintf(str,
+			"TRB %08x%08x status '%s' len %d slot %d ep %d:=:"
+			"type '%s' flags %c:%c",
+			field1, field0,
+			usbssp_trb_comp_code_string(GET_COMP_CODE(field2)),
+			EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
+			/* Macro decrements 1, maybe it shouldn't?!? */
+			TRB_TO_EP_INDEX(field3) + 1,
+			usbssp_trb_type_string(type),
+			field3 & EVENT_DATA ? 'E' : 'e',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+
+		break;
+	case TRB_SETUP:
+		sprintf(str, "bRequestType %02x bRequest %02x wValue %02x%02x "
+				"wIndex %02x%02x wLength %d length %d "
+				"TD size %d intr %d type '%s' flags %c:%c:%c",
+				field0 & 0xff,
+				(field0 & 0xff00) >> 8,
+				(field0 & 0xff000000) >> 24,
+				(field0 & 0xff0000) >> 16,
+				(field1 & 0xff00) >> 8,
+				field1 & 0xff,
+				(field1 & 0xff000000) >> 16 |
+				(field1 & 0xff0000) >> 16,
+				TRB_LEN(field2), GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				usbssp_trb_type_string(type),
+				field3 & TRB_IDT ? 'I' : 'i',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_DATA:
+		sprintf(str, "Buffer %08x%08x length %d TD size %d intr %d "
+				"type '%s' flags %c:%c:%c:%c:%c:%c:%c",
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				usbssp_trb_type_string(type),
+				field3 & TRB_IDT ? 'I' : 'i',
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_NO_SNOOP ? 'S' : 's',
+				field3 & TRB_ISP ? 'I' : 'i',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_STATUS:
+		sprintf(str, "Buffer %08x%08x length %d TD size %d intr"
+				"%d type '%s' flags %c:%c:%c:%c",
+				field1, field0, TRB_LEN(field2),
+				GET_TD_SIZE(field2),
+				GET_INTR_TARGET(field2),
+				usbssp_trb_type_string(type),
+				field3 & TRB_IOC ? 'I' : 'i',
+				field3 & TRB_CHAIN ? 'C' : 'c',
+				field3 & TRB_ENT ? 'E' : 'e',
+				field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_NORMAL:
+	case TRB_ISOC:
+	case TRB_EVENT_DATA:
+	case TRB_TR_NOOP:
+		sprintf(str,
+			"Buffer %08x%08x length %d TD size %d intr %d "
+			"type '%s' flags %c:%c:%c:%c:%c:%c:%c:%c",
+			field1, field0, TRB_LEN(field2), GET_TD_SIZE(field2),
+			GET_INTR_TARGET(field2),
+			usbssp_trb_type_string(type),
+			field3 & TRB_BEI ? 'B' : 'b',
+			field3 & TRB_IDT ? 'I' : 'i',
+			field3 & TRB_IOC ? 'I' : 'i',
+			field3 & TRB_CHAIN ? 'C' : 'c',
+			field3 & TRB_NO_SNOOP ? 'S' : 's',
+			field3 & TRB_ISP ? 'I' : 'i',
+			field3 & TRB_ENT ? 'E' : 'e',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+
+	case TRB_CMD_NOOP:
+	case TRB_ENABLE_SLOT:
+		sprintf(str,
+			"%s: flags %c",
+			usbssp_trb_type_string(type),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_DISABLE_SLOT:
+		sprintf(str,
+			"%s: slot %d flags %c",
+			usbssp_trb_type_string(type),
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_ADDR_DEV:
+		sprintf(str,
+			"%s: ctx %08x%08x slot %d flags %c:%c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_BSR ? 'B' : 'b',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_CONFIG_EP:
+		sprintf(str,
+			"%s: ctx %08x%08x slot %d flags %c:%c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_DC ? 'D' : 'd',
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_EVAL_CONTEXT:
+		sprintf(str,
+			"%s: ctx %08x%08x slot %d flags %c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_RESET_EP:
+		sprintf(str,
+			"%s: ctx %08x%08x slot %d ep %d flags %c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_SLOT_ID(field3),
+			/* Macro decrements 1, maybe it shouldn't?!? */
+			TRB_TO_EP_INDEX(field3) + 1,
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_STOP_RING:
+		sprintf(str,
+			"%s: slot %d sp %d ep %d flags %c",
+			usbssp_trb_type_string(type),
+			TRB_TO_SLOT_ID(field3),
+			TRB_TO_SUSPEND_PORT(field3),
+			/* Macro decrements 1, maybe it shouldn't?!? */
+			TRB_TO_EP_INDEX(field3) + 1,
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_SET_DEQ:
+		sprintf(str,
+			"%s: deq %08x%08x stream %d slot %d ep %d flags %c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_STREAM_ID(field2),
+			TRB_TO_SLOT_ID(field3),
+			/* Macro decrements 1, maybe it shouldn't?!? */
+			TRB_TO_EP_INDEX(field3) + 1,
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_RESET_DEV:
+		sprintf(str,
+			"%s: slot %d flags %c",
+			usbssp_trb_type_string(type),
+			TRB_TO_SLOT_ID(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_FORCE_EVENT:
+		sprintf(str,
+			"%s: event %08x%08x vf intr %d vf id %d flags %c",
+			usbssp_trb_type_string(type),
+			field1, field0,
+			TRB_TO_VF_INTR_TARGET(field2),
+			TRB_TO_VF_ID(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_SET_LT:
+		sprintf(str,
+			"%s: belt %d flags %c",
+			usbssp_trb_type_string(type),
+			TRB_TO_BELT(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	case TRB_FORCE_HEADER:
+		sprintf(str,
+			"%s: info %08x%08x%08x pkt type %d roothub port %d flags %c",
+			usbssp_trb_type_string(type),
+			field2, field1, field0 & 0xffffffe0,
+			TRB_TO_PACKET_TYPE(field0),
+			TRB_TO_DEV_PORT(field3),
+			field3 & TRB_CYCLE ? 'C' : 'c');
+		break;
+	default:
+		sprintf(str,
+			"type '%s' -> raw %08x %08x %08x %08x",
+			usbssp_trb_type_string(type),
+			field0, field1, field2, field3);
+	}
+
+	return str;
+}
+
+static inline const char *usbssp_decode_slot_context(u32 info, u32 info2,
+		u32 int_target, u32 state)
+{
+	static char str[1024];
+	u32 speed;
+	int ret = 0;
+
+	speed = info & DEV_SPEED;
+
+	ret = sprintf(str, "%s Ctx Entries %d MEL %d us",
+			({ char *s;
+			switch (speed) {
+			case SLOT_SPEED_FS:
+				s = "full-speed";
+				break;
+			case SLOT_SPEED_LS:
+				s = "low-speed";
+				break;
+			case SLOT_SPEED_HS:
+				s = "high-speed";
+				break;
+			case SLOT_SPEED_SS:
+				s = "super-speed";
+				break;
+			case SLOT_SPEED_SSP:
+				s = "super-speed plus";
+				break;
+			default:
+				s = "UNKNOWN speed";
+			} s; }),
+			(info & LAST_CTX_MASK) >> 27,
+			info2 & MAX_EXIT);
+
+	ret += sprintf(str + ret, " [Intr %d] Addr %d State %s",
+			GET_INTR_TARGET(int_target),
+			state & DEV_ADDR_MASK,
+			usbssp_slot_state_string(GET_SLOT_STATE(state)));
+
+	return str;
+}
+
+
+static inline const char *usbssp_portsc_link_state_string(u32 portsc)
+{
+	switch (portsc & PORT_PLS_MASK) {
+	case XDEV_U0:
+		return "U0";
+	case XDEV_U1:
+		return "U1";
+	case XDEV_U2:
+		return "U2";
+	case XDEV_U3:
+		return "U3";
+	case XDEV_DISABLED:
+		return "Disabled";
+	case XDEV_RXDETECT:
+		return "RxDetect";
+	case XDEV_INACTIVE:
+		return "Inactive";
+	case XDEV_POLLING:
+		return "Polling";
+	case XDEV_RECOVERY:
+		return "Recovery";
+	case XDEV_HOT_RESET:
+		return "Hot Reset";
+	case XDEV_COMP_MODE:
+		return "Compliance mode";
+	case XDEV_TEST_MODE:
+		return "Test mode";
+	case XDEV_RESUME:
+		return "Resume";
+	default:
+		break;
+	}
+	return "Unknown";
+}
+
+static inline const char *usbssp_decode_portsc(u32 portsc)
+{
+	static char str[256];
+	int ret;
+
+	ret = sprintf(str, "%s %s %s Link:%s PortSpeed:%d ",
+			portsc & PORT_POWER	? "Powered" : "Powered-off",
+			portsc & PORT_CONNECT	? "Connected" : "Not-connected",
+			portsc & PORT_PE	? "Enabled" : "Disabled",
+			usbssp_portsc_link_state_string(portsc),
+			DEV_PORT_SPEED(portsc));
+
+	if (portsc & PORT_OC)
+		ret += sprintf(str + ret, "OverCurrent ");
+	if (portsc & PORT_RESET)
+		ret += sprintf(str + ret, "In-Reset ");
+
+	ret += sprintf(str + ret, "Change: ");
+	if (portsc & PORT_CSC)
+		ret += sprintf(str + ret, "CSC ");
+	if (portsc & PORT_PEC)
+		ret += sprintf(str + ret, "PEC ");
+	if (portsc & PORT_WRC)
+		ret += sprintf(str + ret, "WRC ");
+	if (portsc & PORT_OCC)
+		ret += sprintf(str + ret, "OCC ");
+	if (portsc & PORT_RC)
+		ret += sprintf(str + ret, "PRC ");
+	if (portsc & PORT_PLC)
+		ret += sprintf(str + ret, "PLC ");
+	if (portsc & PORT_CEC)
+		ret += sprintf(str + ret, "CEC ");
+	ret += sprintf(str + ret, "Wake: ");
+	if (portsc & PORT_WKCONN_E)
+		ret += sprintf(str + ret, "WCE ");
+	if (portsc & PORT_WKDISC_E)
+		ret += sprintf(str + ret, "WDE ");
+	if (portsc & PORT_WKOC_E)
+		ret += sprintf(str + ret, "WOE ");
+
+	return str;
+}
+
+static inline const char *usbssp_ep_state_string(u8 state)
+{
+	switch (state) {
+	case EP_STATE_DISABLED:
+		return "disabled";
+	case EP_STATE_RUNNING:
+		return "running";
+	case EP_STATE_HALTED:
+		return "halted";
+	case EP_STATE_STOPPED:
+		return "stopped";
+	case EP_STATE_ERROR:
+		return "error";
+	default:
+		return "INVALID";
+	}
+}
+
+static inline const char *usbssp_ep_type_string(u8 type)
+{
+	switch (type) {
+	case ISOC_OUT_EP:
+		return "Isoc OUT";
+	case BULK_OUT_EP:
+		return "Bulk OUT";
+	case INT_OUT_EP:
+		return "Int OUT";
+	case CTRL_EP:
+		return "Ctrl";
+	case ISOC_IN_EP:
+		return "Isoc IN";
+	case BULK_IN_EP:
+		return "Bulk IN";
+	case INT_IN_EP:
+		return "Int IN";
+	default:
+		return "INVALID";
+	}
+}
+
+static inline const char *usbssp_decode_ep_context(u32 info, u32 info2, u64 deq,
+		u32 tx_info)
+{
+	static char str[1024];
+	int ret;
+
+	u32 esit;
+	u16 maxp;
+	u16 avg;
+
+	u8 max_pstr;
+	u8 ep_state;
+	u8 interval;
+	u8 ep_type;
+	u8 burst;
+	u8 cerr;
+	u8 mult;
+
+	bool lsa;
+	bool hid;
+
+	esit = CTX_TO_MAX_ESIT_PAYLOAD_HI(info) << 16 |
+		CTX_TO_MAX_ESIT_PAYLOAD(tx_info);
+
+	ep_state = info & EP_STATE_MASK;
+	max_pstr = CTX_TO_EP_MAXPSTREAMS(info);
+	interval = CTX_TO_EP_INTERVAL(info);
+	mult = CTX_TO_EP_MULT(info) + 1;
+	lsa = !!(info & EP_HAS_LSA);
+
+	cerr = (info2 & (3 << 1)) >> 1;
+	ep_type = CTX_TO_EP_TYPE(info2);
+	hid = !!(info2 & (1 << 7));
+	burst = CTX_TO_MAX_BURST(info2);
+	maxp = MAX_PACKET_DECODED(info2);
+
+	avg = EP_AVG_TRB_LENGTH(tx_info);
+
+	ret = sprintf(str, "State %s mult %d max P. Streams %d %s",
+			usbssp_ep_state_string(ep_state), mult,
+			max_pstr, lsa ? "LSA " : "");
+
+	ret += sprintf(str + ret, "interval %d us max ESIT payload %d CErr %d ",
+			(1 << interval) * 125, esit, cerr);
+
+	ret += sprintf(str + ret, "Type %s %sburst %d maxp %d deq %016llx ",
+			usbssp_ep_type_string(ep_type), hid ? "HID" : "",
+			burst, maxp, deq);
+
+	ret += sprintf(str + ret, "avg trb len %d", avg);
+
+	return str;
+}
+
+/**
+ * next_request - gets the next request on the given list
+ * @list: the request list to operate on
+ *
+ * Caller should take care of locking. This function return %NULL or the first
+ * request available on @list.
+ */
+static inline struct usbssp_request *next_request(struct list_head *list)
+{
+	return list_first_entry_or_null(list, struct usbssp_request, list);
+}
+
+struct usbssp_udc;
+#define to_usbssp_ep(ep) (container_of(ep, struct usbssp_ep, endpoint))
+#define gadget_to_usbssp(g) (container_of(g, struct usbssp_udc, gadget))
+#define request_to_usbssp_request(r) (container_of(r, struct usbssp_request, request))
+
+#define to_usbssp_request(r) (container_of(r, struct usbssp_request, request))
+
 #endif /* __LINUX_USBSSP_GADGET_H */
-- 
2.17.1

