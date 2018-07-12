Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01926C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9F920875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AkhJEBTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9F920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeGLFzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:55:54 -0400
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:55959
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbeGLFzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c4WJOppfJxB0abs19oVSlHQHLx+e7TuHlCtgfYV8jE=;
 b=AkhJEBTg9uOOQ8tRcN2F/Y31OxDznrii5E44+ZZZXAIXw3E+rOoVAY+cpBvYgJVCQcCOaSBkalHp2aPSE5kOqry18FBT4IlB++GyQAkJY164GQ/upvtzPDHj/bdhe23HDuhVKt0J68ZKWvVhTp5bCNjjBHXKP61Ti/60QxnQeKU=
Received: from CY1PR07CA0039.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::49) by CY1PR0701MB1340.namprd07.prod.outlook.com
 (2a01:111:e400:4c1b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 05:47:50 +0000
Received: from CO1NAM05FT053.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::209) by CY1PR07CA0039.outlook.office365.com
 (2a01:111:e400:c60a::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:50 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT053.mail.protection.outlook.com (10.152.96.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkvt032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:48 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:01 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:01 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lj42029470;
        Thu, 12 Jul 2018 06:47:45 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lja5029468;
        Thu, 12 Jul 2018 06:47:45 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 01/31] usb: usbssp: Defined register maps and other useful structures.
Date:   Thu, 12 Jul 2018 06:46:58 +0100
Message-ID: <1531374448-26532-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(36092001)(51234002)(199004)(189003)(8676002)(426003)(105596002)(4720700003)(50466002)(6666003)(5660300001)(356003)(186003)(336012)(551934003)(316002)(14444005)(16586007)(305945005)(7636002)(42186006)(26005)(48376002)(446003)(246002)(107886003)(109986005)(486006)(51416003)(54906003)(26826003)(126002)(50226002)(53946003)(47776003)(1671002)(76176011)(86362001)(8936002)(87636003)(11346002)(4326008)(575784001)(2906002)(106466001)(476003)(478600001)(36756003)(2616005)(266003)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1340;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT053;1:rUHjBL8WU8a0KfTVy06bx7h4HmhQ0xNiABrqLVFMsv9YCLwtotO5Yg0cTF/7SRxAg9KBcASe1+yo8kEhVvzDN92vrVJV3c3P4KcpWBobr88FDsJVmXumtYqUmPebje+l
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c113ae7b-0de7-4f2e-7dfd-08d5e7bb00e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0701MB1340;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;3:70yS4kC8TtXioZO0Ir2rtHSsIGlyPEqtW/LL5CEjNrA/HYV49inxslY1fdEZv9s5FzQDfgXPpfEDqfudHEh7FOWJj8f0nzrDAm488rTte5yrEhqwIJmCjnnhKBH9UadDwgynfM5ddZ9Yd2vCZUassUgYEti6tjnPvD4FTgYLMh+Vo57DuESHw5Bsn2qUrbOIYtBFMfm31uhzdj3G45cF+n4KJ9/wP1/Vy3SqV+ra/rppNekcmTgkY/BjRFd3qrJ0ywHRpp8Q8zwjMzFvYrFTvNry4XNdWiPuUkRqrxGF4PCFTHvc4Uk2NtQ1k4E/QVoEOBlsulF/8BKEIT1HPVhXomNvEt0c42pjmKJ5yCVxhio=;25:W2pmAqS3PyRi75xW03OznFupnWxOf86KQY9bbb1860P8HQvkv7PXtceWiuxpqRNrMDEamyhdUdwJZqTNWUoy5qg2Pp5dSkaXwacjCpMJPBH227kth7K+fzd37SelSNppOFStzp8yu7DwJ9naNtjU3/0EC+Wi8QHABa3A+RKHDyxXMmJGKQmSEEmr6KYcX2kN6c3skLW1+7qFr3C9P9jD/T62nDnBI+m58jjqwEcixxYfjz6mtfryIux4RxGgf3uRDqdDI89sts2LDCbm6jDHqzJeTPsPXNZkcCySnh+xbzhQ0tE8avg/46aKKrmRxaVzUb2I5rso8WNWqCA7maJ90g==
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1340:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;31:XcSTo7X5OFedAlbLhNM038ln4RXn2TAk8yH6yydmtP7E5H6UF50wzlLgC5psLPGKBX3PcnTpfAzBCEz/XxxkkmMOh4z9ezP1Vdeq7A7rC99pZYK88pv3+kee79rmndIYzK2hevPARyeOzvZ6yerFj6IoCQGlwbNoItVR4mAayfzjlkQuq54D1AnGXVP2m0BITphHEt2Tbr31j2M2FB6xspR7rrwMbtderaZw9hKadrU=;20:Slzrumaa9Ls6tQIVYs6STRWZZlc5Iicuzlr3Dme0LYElRXPmCHcD6t+e4K5p7yB+louomWqJEt0DuRfrScIvHT+bSJnNDehfdOovhiUv9VU8JfB1SO7kDiBMjub+vrXhiNcKS4mgEzDqJEtYbes1AfADUNxxo7O2gE0ZiSXVG9XNRQ09OnuwWmoH5pAhV9P9RDj9rWippyjrWO9ljaJJZq+yJZZu3sx9jJ5GsFJqVOejk+4hXwSD0qsEYTyBq6OekjeDPQnYvMOrfWqg8H0TOTnm5OeidNZqlpigRLfGg5GPpQHjcVfc7V0ylcLUYJCMEPqucxLIwBQBAE04baSgjWUsynXCz2a9WcEig1/dKavxonLJhu8pdMA0XtNY5ZMA93p7ZK+A/Z6XQxfHWm54EYLqmZNJWLo0ikBVqbRS28oo6D66pc44hmeXeUP4V1WTsO/65/0kXJOXzNeFcQN9jUBZhEHY853omtNKXeTGcw76BDy51/VS2gXKf3iiUGxP
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1340941C9C6621F7301AF6BDDD590@CY1PR0701MB1340.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006)(21532816269658)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1340;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1340;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;4:RT3PN5Qteu4cxw3kQG6AArhXcDNiZwGwyN6SHWWN2QHuTqlblsUg2WbMP95Yy9ZWQqzl1HpqUflqrU1j4ZnKgkwYN/ts4sSELmOhO9oCZKtOt1IGIkRAh/D2Wri2rRpuX2qqBXG/A1OefEB3OuI+B6F4stM6rrcAVizNAZ1vxhuzhV849V3Nqlc3timxy4j2gnDZKRRGfy/pVz38vF1dAUFRwLcdu66A0yZbK+blFmom/xabEoto4iCgpHham5NKQRuLw7sQ288dN/LRA2O77H297KMmZCzR1sx0qRcpMfPcDUES1BAD6epIdSZPtXereh9c4ezf3dnGlUTdCfF8J0uQmWFuVl2U53qoZo0T7SrVNk9JCARDod0794k1+ugi
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1340;23:/ku6qMkM0bHOaEYOi20V0RJJMtK1V4h/UfKm6eL?=
 =?us-ascii?Q?2Mp2Hx3v57lLhRobFf/0Jo7wgiU0QtgtANV7evx29IUfB10iAjIPph3EFQac?=
 =?us-ascii?Q?N2ZM3ro8cpmzYe7S4y9xFCfiR9n4t0uAcC4Nn+DBZ1Z3HGGOtfSvjOr91yXg?=
 =?us-ascii?Q?qW21b6S329TjsCCfM1qraUsuMfaXDNUItfx8EaoMxcNXu5M6yCeqqovft5M4?=
 =?us-ascii?Q?Ae6lLzos+ugiIvktXyGzKH/eWa2HF1d/opqNlSDJp0u+cBpCnFFMEXidNIjl?=
 =?us-ascii?Q?5op1bxDHsY1g5DkMDuYGJzSsrOcHf92zUnpUFdQmepDOUcErC0T0V7jnMeMP?=
 =?us-ascii?Q?NGg9bDmyEEuJw3KtxWJTmT3JYReXGhO/vzKTberJDkE08k6vYty34DYJXaIl?=
 =?us-ascii?Q?l3X2Y+0us1R6kU6roNuyym8Af5KLufWmer03r1VozT4XKms3VZ78GMl3xoy6?=
 =?us-ascii?Q?BQU6k35YpoEvT3v9Xnpad/wYDZIj2v+6TbXH/e+q6JBeyYzNfjdn59Ds17F/?=
 =?us-ascii?Q?FSuHszHLIDCf8eu4nuBo07lfeLjybt57DaQa15r7+HdzNW/zaUWNKrsdLMok?=
 =?us-ascii?Q?/slHcptOzBf51q7mKp3Anqnb8h1fGQA7zzsiY6RB50XwWKrm9ISGHHG475D5?=
 =?us-ascii?Q?12Dz2qGHOzIJ8RxnDSkJ7zl4LF4hHfEm2rkE2PDThgvdKqk5f5opxKTp8YOW?=
 =?us-ascii?Q?0YbLmpnM+OEQRtumpdGuA5HfWKiyyTMB+Muuo0VAATTD44DqmB/0LMuDITU/?=
 =?us-ascii?Q?Q/riF+ZoEuW8cmycCVRHvuTvMV8aWSey9wBPFe8PtrdNKthSCVA3CH3AhTSE?=
 =?us-ascii?Q?6eJ4nH5ULB7WPSOmF+6FRjmd6G6TDrmNz1ePTIH1OsaOSpWj1lcxOGcfQbT0?=
 =?us-ascii?Q?2idc6uAaUl7HyGV2BSIsyfULE5p2H8cBqLien0xrrVzq/mcROEzmQZcJRO8C?=
 =?us-ascii?Q?1O7WXE6ImvDl22ZN60lG79uqFZeiRlrxjj80hi/u+iGovmbOfKRr7bWQ5Rkk?=
 =?us-ascii?Q?OyP4Ld7Q2i5B1OeehXxk242ySwJ489CcSdCn+WXx98qAuISgD/nhDWijIDmD?=
 =?us-ascii?Q?Sd2LO/3VnrhmsaKVhbOPE9yinstxfRmId7CGxG27i0E9vEgFOrBfJ5fZyseM?=
 =?us-ascii?Q?JAkMOKEkaNTdAfuNEmZaiABw5C7kO/Vx7jv6A5IPLU6ize0BD0Lq774g2Atc?=
 =?us-ascii?Q?lv6NpuQRv26iDSdH3BbUMDPpbFnP+w+bGU/6woQaAbSNyWKb/MSEQynSHH0A?=
 =?us-ascii?Q?UVsXoP0BOR5hYXtDTVZkMrqIYyEC+lYzpFTceKxuQ?=
X-Microsoft-Antispam-Message-Info: 8L1Yr6bMD/TiNSul+/7KoON0Yi3Mi0/HoosHnlBOL8mS+fN4LVgOsW4ZPyOTLIHNoD39RFQMRXSWaYUuq9bCKT6TW+MXVV3NfQYCrIWJ/Z1YCG5oktQ7VJwUxHLNvu4eB5VLXm2gvEa+tmvXoK9TdWuSmcl9X4zq42oUbyBMEVXzr0Es4dJGJ1yPXv2HFCkEZrSg4N2Ql/dq1LxY8uSA5s0VPPBlWSajA89ihRF4sHzfe1i5RPoypUSgf74SyN/tla6qyptKDoWryYXR6BtldJFk/wmmTPyTmymTrh1gLbfhIl0wo/rg2tRz6X4AdvcONDJEdVdtYLCGZxhM7IZ4CWVmQsUD/I/Dfnpm/gdMECObmDppKtKBpJXDvHSEt8HltK9IDPyJh+YOMpoQbcF/Sg==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;6:ASunRD+ImDIslQnZQjx2jSV96lWP2ar3OYSKaWIQLJnYuu350VCfvQRPXQhUykwVMgwyJzOl/nnkRVA1/FrY86sGYPKMFw+2264+zru53FlY97wpxiBjTzfEpanMxLfLRZjUtYWtqunbJcC6LpvOQCPyurhZzIXOawAOTiLdcrySUkz9L6YBCPRtKAtWfjbSqfmUq/7ibZKg9K6Y9dD9aJBbDZUvD9XxFHd+yI71cQihz4K/n5cd031Pnd6xTO+aRaXtSC7MfcAkAzpK7pBj5msDeAH7iSwnvKpAghqe0KWcXJ4iQhAXD+u8C07rEOlLTK6zBX4upon1dHPZWaRj1Z5kQujf5+2M12bdreickluqsvQqOycfFXbCgM9n1Up373HX3TU4TxFnWs21NHgLKKFLbF0Z0KJr4rxt0vbJxknm0YKutv764T55IQqsyR+o3w09av0NcVIryPrSsrmKhw==;5:3jr96gfQDFbUbv3/u0K1GEeIpr4rxfQPM63T0TfQAvDUvHaxVqCPsGU7m0xvJZBVmzfcGQUpil+QQqGeSYWxaMUMdNUk7L/qztGuD4vCgXlfXHuPUwC0xostG97QRnp+XAkJPMqBHi431lLnDlC9mutdrrPAcpiP4JVYS4cP7s8=;24:uQ2hzi/0r3d4NkUFTCRmYpOd5dzZVlgZtuMAwxYp4RTfR6ONHibRFfn9whVLcI3BOQoAKTq2GeJqGzpEl4VXYWphxaKhPPe6pbb2s9FZMrM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;7:CNxCaevo/MstYie2PQdK15sadLsT8uilEkfdTdFYoDeeTupbz9RO3Ut9xyOXLcuWOZt/e+hxSSQGfpesqfsWfMTATbIshZfkmsqOao/DbrMl7goxaZUt9G9dtD7o1Ama+2f25ZnGNW4h0jKoRZS26WS7TQz+hxtyVNXF5Fuer4VtTsyS22Zd1E4E3pxQlGync0E5C2rlcKd4Ld1co0cYBpzz3Q5Ec1gsGhfh6ginIV0JHRSeLOpgesdaFwrI/sb1;20:7pXqcrCvXP6xmxviys5EZd1j8zkLywPFnQoE8J6LrgZv5jAx4DFtibwOoSgsczFl0UBp8GmnyFj5N0mCbuVWCAX1zX1Hz4eyhDMfNiTkLeVqrWfyId1frDikMo6gSnCXxsTDEMGSrosUkuLEjMq+jRh4Utt37/nXrgTlUYqgShsfj/ddi4jAGQuyfG/7tDXhFMvsfIerN8QHwvYcsj1F2BdLMXUsyUP5u0RO8tvtIr+gD7jhmHb17tZC4NayA+rT
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:50.1433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c113ae7b-0de7-4f2e-7dfd-08d5e7bb00e9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1340
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a first patch introduce Cadence USBSSP DRD
controller. This patch is related to device side.

Device part of USBSSP controller base on standard
XHCI specification.

File define macros used bye USBSSP controller,
structures holding and grouping registers, and other
object that are used by device controller.

Register map include:
struct usbssp_cap_regs - Capabilities Register Set.
struct usbssp_op_regs - Operational Register Set.
struct usbssp_intr_reg - Interrupter Register Set.
struct usbssp_run_regs - Runtime Register Set.

Object used by hardware includes:
struct usbssp_doorbell_array - array used for arming command and
	transfer rings.
struct usbssp_slot_ctx - holds information related to Slot Context.
struct usbssp_ep_ctx - hold information related to Endpoint Context.
struct usbssp_input_control_ctx - hold information about
	Input Control Context.
struct usbssp_link_trb - define link TRB.
struct usbssp_transfer_event - define Transfer Event TRB.
struct usbssp_event_cmd - define Command Event TRB.
struct usbssp_generic_trb - generic used TRB object.

Patch also add some high level object that hold  information
used in driver.

Some of them are:
struct usbssp_udc - main object in driver which is passed
	as parameter to most of function in driver and allows
	to access to all other structures.
struct usbssp_ep - holds information related to USB endpoint.
struct usbssp_command - describe command send to Event Ring.
struct usbssp_device - holds information relate do USB device.
struct usbssp_segment - holds information describing segments of TRBs.
struct usbssp_td  - hold information about Transfer Descriptor.
struct usbssp_ring - holds information related to Transfer, Event or
	Command ring.
struct usbssp_request - holds information related to single transfer.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget.h | 1567 +++++++++++++++++++++++++++++++++++
 1 file changed, 1567 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget.h

diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
new file mode 100644
index 000000000000..486e868068b7
--- /dev/null
+++ b/drivers/usb/usbssp/gadget.h
@@ -0,0 +1,1567 @@
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
+#ifndef __LINUX_USBSSP_GADGET_H
+#define __LINUX_USBSSP_GADGET_H
+
+#include <linux/usb.h>
+#include <linux/timer.h>
+#include <linux/kernel.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/usb/gadget.h>
+
+/* Max number slots - only 1 is allowed */
+#define DEV_MAX_SLOTS 1
+
+/* max ports for USBSSP-Dev - only 2 are allowed*/
+#define MAX_USBSSP_PORTS	2
+
+#define USBSSP_EP0_SETUP_SIZE 512
+
+/*16 for in and 16 for out */
+#define USBSSP_ENDPOINTS_NUM	32
+
+/* HCSPARAMS1 - hcs_params1 - bitmasks */
+/* bits 0:7, Max Device Slots */
+#define DEV_HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
+#define DEV_HCS_SLOTS_MASK	0xff
+
+/*
+ * USBSSP register interface.
+ */
+/**
+ * struct usbssp_cap_regs - USBSSP Registers.
+ * @hc_capbase:		length of the capabilities register and DC version number
+ * @hcs_params1:	HCSPARAMS1 - Structural Parameters 1
+ * @hcs_params2:	HCSPARAMS2 - Structural Parameters 2
+ * @hcs_params3:	HCSPARAMS3 - Structural Parameters 3
+ * @hcc_params:		HCCPARAMS - Capability Parameters
+ * @db_off:		DBOFF - Doorbell array offset
+ * @run_regs_off:	RTSOFF - Runtime register space offset
+ * @hcc_params2:	HCCPARAMS2 Capability Parameters 2,
+ */
+struct usbssp_cap_regs {
+	__le32	hc_capbase;
+	__le32	hcs_params1;
+	__le32	hcs_params2;
+	__le32	hcs_params3;
+	__le32	hcc_params;
+	__le32	db_off;
+	__le32	run_regs_off;
+	__le32	hcc_params2;
+	/* Reserved up to (CAPLENGTH - 0x1C) */
+};
+
+/* hc_capbase bitmasks */
+/* bits 7:0 - how long is the Capabilities register */
+#define HC_LENGTH(p)		USBSSP_HC_LENGTH(p)
+/* bits 31:16	*/
+#define HC_VERSION(p)		(((p) >> 16) & 0xffff)
+
+/* HCSPARAMS1 - hcs_params1 - bitmasks */
+/* bits 0:7, Max Device Slots */
+#define HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
+#define HCS_SLOTS_MASK		0xff
+/* bits 8:18, Max Interrupters */
+#define HCS_MAX_INTRS(p)	(((p) >> 8) & 0x7ff)
+/* bits 24:31, Max Ports - max value is 0x7F = 127 ports */
+#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
+
+/* HCSPARAMS2 - hcs_params2 - bitmasks */
+/* bits 0:3, Isochronous Scheduling Threshold (IST)*/
+#define HCS_IST(p)		(((p) >> 0) & 0xf)
+/* bits 4:7, max number of Event Ring segments */
+#define HCS_ERST_MAX(p)		(((p) >> 4) & 0xf)
+/* bits 21:25 Hi 5 bits of Scratchpad buffers SW must allocate for the HW */
+/* bit 26 Scratchpad restore - for save/restore HW state - not used yet */
+/* bits 27:31 Lo 5 bits of Scratchpad buffers SW must allocate for the HW */
+#define HCS_MAX_SCRATCHPAD(p)   ((((p) >> 16) & 0x3e0) | (((p) >> 27) & 0x1f))
+
+/* HCSPARAMS3 - hcs_params3 - bitmasks */
+/* bits 0:7, Max U1 to U0 latency for the roothub ports */
+#define HCS_U1_LATENCY(p)	(((p) >> 0) & 0xff)
+/* bits 16:31, Max U2 to U0 latency for the roothub ports */
+#define HCS_U2_LATENCY(p)	(((p) >> 16) & 0xffff)
+
+/* HCCPARAMS - hcc_params - bitmasks */
+/* true: DC can use 64-bit address pointers */
+#define HCC_64BIT_ADDR(p)	((p) & (1 << 0))
+/* true: DC uses 64-byte Device Context structures*/
+#define HCC_64BYTE_CONTEXT(p)	((p) & (1 << 2))
+/* true: DC has port indicators */
+#define HCS_INDICATOR(p)	((p) & (1 << 4))
+/* true: no secondary Stream ID Support */
+#define HCC_NSS(p)		((p) & (1 << 7))
+/*true: DC parse All Event Data*/
+#define HCC_PAE(p)		((p) & (1<<8))
+/* true: DC supports Stopped - Short Packet */
+#define HCC_SPC(p)		((p) & (1 << 9))
+/*true: DC support a stopped EDTLA Capability (SEC) */
+#define HCC_SEC(p)		((p) & (1 << 10))
+/* true: DC has Contiguous Frame ID Capability */
+#define HCC_CFC(p)		((p) & (1 << 11))
+/* Max size for Primary Stream Arrays - 2^(n+1), where n is bits 12:15 */
+#define HCC_MAX_PSA(p)		(1 << ((((p) >> 12) & 0xf) + 1))
+/* Extended Capabilities pointer from PCI base - section 5.3.6 */
+#define HCC_EXT_CAPS(p)		USBSSP_HCC_EXT_CAPS(p)
+
+
+#define CTX_SIZE(_hcc)		(HCC_64BYTE_CONTEXT(_hcc) ? 64 : 32)
+
+/* db_off bitmask - bits 0:1 reserved */
+#define	DBOFF_MASK	(~0x3)
+
+/* run_regs_off bitmask - bits 0:4 reserved */
+#define	RTSOFF_MASK	(~0x1f)
+
+/* HCCPARAMS2 - hcc_params2 - bitmasks */
+/* true: DC supports U3 entry Capability */
+#define	HCC2_U3C(p)	((p) & (1 << 0))
+/* true: DC supports Force Save context Capability */
+#define	HCC2_FSC(p)	((p) & (1 << 2))
+/* true: DC supports Compliance Transition Capability */
+#define	HCC2_CTC(p)	((p) & (1 << 3))
+/* true: DC support Large ESIT payload Capability > 48k */
+#define	HCC2_LEC(p)	((p) & (1 << 4))
+/* true: DC support Extended TBC Capability, Isoc burst count > 65535 */
+#define	HCC2_ETC(p)	((p) & (1 << 6))
+
+/* Number of registers per port */
+#define	NUM_PORT_REGS	4
+
+#define PORTSC		0
+#define PORTPMSC	1
+#define PORTLI		2
+#define PORTHLPMC	3
+
+/**
+ * struct usbssp_op_regs - Device Controller Operational Registers.
+ * @command:		USBCMD - DC command register
+ * @status:		USBSTS - DC status register
+ * @page_size:		This indicates the page size that the device controller
+ *			supports.  If bit n is set, the DC supports a page size
+ *			of 2^(n+12), up to a 128MB page size.
+ *			4K is the minimum page size.
+ * @cmd_ring:		CRP - 64-bit Command Ring Pointer
+ * @dcbaa_ptr:		DCBAAP - 64-bit Device Context Base Address Array Pointer
+ * @config_reg:		CONFIG - Configure Register
+ * @port_status_base:	PORTSCn - base address for Port Status and Control
+ *			Each port has a Port Status and Control register,
+ *			followed by a Port Power Management Status and Control
+ *			register, a Port Link Info register, and a reserved
+ *			register.
+ * @port_power_base:	PORTPMSCn - base address for
+ *			Port Power Management Status and Control
+ * @port_link_base:	PORTLIn - base address for Port Link Info (current
+ *			Link PM state and control) for USB 2.1 and USB 3.0
+ *			devices.
+ */
+struct usbssp_op_regs {
+	__le32	command;
+	__le32	status;
+	__le32	page_size;
+	__le32	reserved1;
+	__le32	reserved2;
+	__le32	dev_notification;
+	__le64	cmd_ring;
+	/* rsvd: offset 0x20-2F */
+	__le32	reserved3[4];
+	__le64	dcbaa_ptr;
+	__le32	config_reg;
+	/* rsvd: offset 0x3C-3FF */
+	__le32	reserved4[241];
+	/* port 1 registers, which serve as a base address for other ports */
+	__le32	port_status_base;
+	__le32	port_power_base;
+	__le32	port_link_base;
+	__le32	reserved5;
+	/* registers for ports 2-255 */
+	__le32	reserved6[NUM_PORT_REGS*254];
+};
+
+/* USBCMD - USB command - command bitmasks */
+/* start/stop DC execution - do not write unless DC is halted*/
+#define CMD_RUN		USBSSP_CMD_RUN
+
+/* Reset DC - resets internal DC state machine and all registers (except
+ * PCI config regs).
+ */
+#define CMD_RESET	(1 << 1)
+/* Event Interrupt Enable - a '1' allows interrupts from the device controller*/
+#define CMD_EIE		USBSSP_CMD_EIE
+/* Device System Error Interrupt Enable - get out-of-band signal for DC errors*/
+#define CMD_HSEIE	USBSSP_CMD_HSEIE
+/* device controller save/restore state. */
+#define CMD_CSS		(1 << 8)
+#define CMD_CRS		(1 << 9)
+/* Enable Wrap Event - '1' means DC generates an event when MFINDEX wraps. */
+#define CMD_EWE		USBSSP_CMD_EWE
+/* bit 14 Extended TBC Enable, changes Isoc TRB fields to support larger TBC */
+#define CMD_ETE		(1 << 14)
+/*bit 13 CEM Enable (CME) */
+#define CMD_CEM		(1 << 13)
+/* Device Enable bit */
+#define CMD_DEVEN	(1 << 15)
+/* bits 16:31 are reserved (and should be preserved on writes). */
+
+/* IMAN - Interrupt Management Register */
+#define IMAN_IE		(1 << 1)
+#define IMAN_IP		(1 << 0)
+
+/* USBSTS - USB status - status bitmasks */
+/* DC not running - set to 1 when run/stop bit is cleared. */
+#define STS_HALT	USBSSP_STS_HALT
+/* serious error, e.g. PCI parity error.  The DC will clear the run/stop bit. */
+#define STS_FATAL	(1 << 2)
+/* event interrupt - clear this prior to clearing any IP flags in IR set*/
+#define STS_EINT	(1 << 3)
+/* port change detect */
+#define STS_PORT	(1 << 4)
+/* bits 5:7 reserved and zeroed */
+/* save state status - '1' means DC is saving state */
+#define STS_SAVE	(1 << 8)
+/* restore state status - '1' means DC is restoring state */
+#define STS_RESTORE	(1 << 9)
+/* true: save or restore error */
+#define STS_SRE		(1 << 10)
+/* true: Controller Not Ready to accept doorbell or op reg writes after reset */
+#define STS_CNR		USBSSP_STS_CNR
+/* true: internal Device Controller Error - SW needs to reset and reinitialize*/
+#define STS_HCE		(1 << 12)
+/* bits 13:31 reserved and should be preserved */
+
+/* CRCR - Command Ring Control Register - cmd_ring bitmasks */
+/* bit 0 is the command ring cycle state */
+/* stop ring operation after completion of the currently executing command */
+#define CMD_RING_PAUSE		(1 << 1)
+/* stop ring immediately - abort the currently executing command */
+#define CMD_RING_ABORT		(1 << 2)
+/* true: command ring is running */
+#define CMD_RING_RUNNING	(1 << 3)
+/* bits 4:5 reserved and should be preserved */
+/* Command Ring pointer - bit mask for the lower 32 bits. */
+#define CMD_RING_RSVD_BITS	(0x3f)
+
+/* CONFIG - Configure Register - config_reg bitmasks */
+/* bits 0:7 - maximum number of device slots enabled (NumSlotsEn) */
+#define MAX_DEVS(p)		((p) & 0xff)
+/* bit 8: U3 Entry Enabled, assert PLC when  controller  enters U3*/
+#define CONFIG_U3E		(1 << 8)
+/* bit 9: Configuration Information Enable */
+#define CONFIG_CIE		(1 << 9)
+/* bits 10:31 - reserved and should be preserved */
+
+/* PORTSC - Port Status and Control Register - port_status_base bitmasks */
+/* true: device connected */
+#define PORT_CONNECT		(1 << 0)
+/* true: port enabled */
+#define PORT_PE			(1 << 1)
+/* bit 2 reserved and zeroed */
+/* true: port has an over-current condition */
+#define PORT_OC			(1 << 3)
+/* true: port reset signaling asserted */
+#define PORT_RESET		(1 << 4)
+/* Port Link State - bits 5:8
+ * A read gives the current link PM state of the port,
+ * a write with Link State Write Strobe set sets the link state.
+ */
+
+#define PORT_PLS_MASK	(0xf << 5)
+#define XDEV_U0		(0x0 << 5)
+#define XDEV_U1		(0x1 << 5)
+#define XDEV_U2		(0x2 << 5)
+#define XDEV_U3		(0x3 << 5)
+#define XDEV_DISABLED	(0x4 << 5)
+#define XDEV_RXDETECT	(0x5 << 5)
+#define XDEV_INACTIVE	(0x6 << 5)
+#define XDEV_POLLING	(0x7 << 5)
+#define XDEV_RECOVERY	(0x8 << 5)
+#define XDEV_HOT_RESET	(0x9 << 5)
+#define XDEV_COMP_MODE	(0xa << 5)
+#define XDEV_TEST_MODE	(0xb << 5)
+#define XDEV_RESUME		(0xf << 5)
+
+/* true: port has power (see HCC_PPC) */
+#define PORT_POWER	(1 << 9)
+/* bits 10:13 indicate device speed:
+ * 0 - undefined speed - port hasn't be initialized by a reset yet
+ * 1 - full speed
+ * 2 - low speed
+ * 3 - high speed
+ * 4 - super speed
+ * 5-15 reserved
+ */
+#define DEV_SPEED_MASK		(0xf << 10)
+#define	XDEV_FS			(0x1 << 10)
+#define	XDEV_LS			(0x2 << 10)
+#define	XDEV_HS			(0x3 << 10)
+#define	XDEV_SS			(0x4 << 10)
+#define	XDEV_SSP		(0x5 << 10)
+#define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0<<10))
+#define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
+#define DEV_LOWSPEED(p)		(((p) & DEV_SPEED_MASK) == XDEV_LS)
+#define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
+#define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
+#define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
+#define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
+#define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
+
+/* Bits 20:23 in the Slot Context are twice */
+#define	SLOT_SPEED_FS		(XDEV_FS << 10)
+#define	SLOT_SPEED_LS		(XDEV_LS << 10)
+#define	SLOT_SPEED_HS		(XDEV_HS << 10)
+#define	SLOT_SPEED_SS		(XDEV_SS << 10)
+#define	SLOT_SPEED_SSP		(XDEV_SSP << 10)
+
+/* Port Link State Write Strobe - set this when changing link state */
+#define PORT_LINK_STROBE	(1 << 16)
+/* true: connect status change */
+#define PORT_CSC	(1 << 17)
+/* true: port enable change */
+#define PORT_PEC	(1 << 18)
+/* true: warm reset for a USB 3.0 device is done.  A "hot" reset puts the port
+ * into an enabled state, and the device into the default state.  A "warm" reset
+ * also resets the link, forcing the device through the link training sequence.
+ * SW can also look at the Port Reset register to see when warm reset is done.
+ */
+#define PORT_WRC	(1 << 19)
+/* true: over-current change */
+#define PORT_OCC	(1 << 20)
+/* true: reset change - 1 to 0 transition of PORT_RESET */
+#define PORT_RC		(1 << 21)
+/* port link status change - set on some port link state transitions:
+ *  Transition			Reason
+ *  ------------------------------------------------------------------------------
+ *  - U3 to Resume		Wakeup signaling from a device
+ *  - Resume to Recovery to U0	USB 3.0 device resume
+ *  - Resume to U0		USB 2.0 device resume
+ *  - U3 to Recovery to U0	Software resume of USB 3.0 device complete
+ *  - U3 to U0			Software resume of USB 2.0 device complete
+ *  - U2 to U0			L1 resume of USB 2.1 device complete
+ *  - U0 to U0			L1 entry rejection by USB 2.1 device
+ *  - U0 to disabled		L1 entry error with USB 2.1 device
+ *  - Any state to inactive	Error on USB 3.0 port
+ */
+#define PORT_PLC		(1 << 22)
+/* port configure error change - port failed to configure its link partner */
+#define PORT_CEC		(1 << 23)
+/* wake on connect (enable) */
+#define PORT_WKCONN_E		(1 << 25)
+/* wake on disconnect (enable) */
+#define PORT_WKDISC_E		(1 << 26)
+/* wake on over-current (enable) */
+#define PORT_WKOC_E		(1 << 27)
+/* bits 28:30 reserved */
+/* Indicates if Warm Reset is being received*/
+#define PORT_WR			(1 << 31)
+
+/* We mark duplicate entries with -1 */
+#define DUPLICATE_ENTRY ((u8)(-1))
+
+/* Port Power Management Status and Control - port_power_base bitmasks */
+/* Inactivity timer value for transitions into U1, in microseconds.
+ * Timeout can be up to 127us.  0xFF means an infinite timeout.
+ */
+#define PORT_U1_TIMEOUT(p)	((p) & 0xff)
+#define PORT_U1_TIMEOUT_MASK	0xff
+/* Inactivity timer value for transitions into U2 */
+#define PORT_U2_TIMEOUT(p)	(((p) & 0xff) << 8)
+#define PORT_U2_TIMEOUT_MASK	(0xff << 8)
+/* Bits 24:31 for port testing */
+
+/* USB2 Protocol PORTSPMSC */
+#define	PORT_L1S_MASK		7
+#define	PORT_L1S_SUCCESS	1
+#define	PORT_RWE		(1 << 3)
+#define	PORT_HIRD(p)		(((p) & 0xf) << 4)
+#define	PORT_HIRD_MASK		(0xf << 4)
+#define	PORT_L1DS_MASK		(0xff << 8)
+#define	PORT_L1DS(p)		(((p) & 0xff) << 8)
+#define	PORT_HLE		(1 << 16)
+#define PORT_TEST_MODE_SHIFT	28
+
+/* USB3 Protocol PORTLI  Port Link Information */
+#define PORT_RX_LANES(p)	(((p) >> 16) & 0xf)
+#define PORT_TX_LANES(p)	(((p) >> 20) & 0xf)
+
+/* USB2 Protocol PORTHLPMC */
+#define PORT_HIRDM(p)		((p) & 3)
+#define PORT_L1_TIMEOUT(p)	(((p) & 0xff) << 2)
+#define PORT_BESLD(p)		(((p) & 0xf) << 10)
+
+/* use 512 microseconds as USB2 LPM L1 default timeout. */
+#define USBSSP_L1_TIMEOUT	512
+
+#define USBSSP_DEFAULT_BESL	4
+
+/**
+ * struct usbssp_intr_reg - Interrupt Register Set
+ * @irq_pending:	IMAN - Interrupt Management Register.  Used to enable
+ *			interrupts and check for pending interrupts.
+ * @irq_control:	IMOD - Interrupt Moderation Register.
+ *			Used to throttle interrupts.
+ * @erst_size:		Number of segments in the Event Ring Segment
+ *			Table (ERST).
+ * @erst_base:		ERST base address.
+ * @erst_dequeue:	Event ring dequeue pointer.
+ *
+ * Each interrupter (defined by a MSI-X vector) has an event ring and an Event
+ * Ring Segment Table (ERST) associated with it.  The event ring is comprised of
+ * multiple segments of the same size.  The DC places events on the ring and
+ * "updates the Cycle bit in the TRBs to indicate to software the current
+ * position of the Enqueue Pointer." The driver processes those events and
+ * updates the dequeue pointer.
+ */
+struct usbssp_intr_reg {
+	__le32	irq_pending;
+	__le32	irq_control;
+	__le32	erst_size;
+	__le32	rsvd;
+	__le64	erst_base;
+	__le64	erst_dequeue;
+};
+
+/* irq_pending bitmasks */
+#define	ER_IRQ_PENDING(p)	((p) & 0x1)
+/* bits 2:31 need to be preserved */
+/* THIS IS BUGGY - FIXME - IP IS WRITE 1 TO CLEAR */
+#define	ER_IRQ_CLEAR(p)		((p) & 0xfffffffe)
+#define	ER_IRQ_ENABLE(p)	((ER_IRQ_CLEAR(p)) | 0x2)
+#define	ER_IRQ_DISABLE(p)	((ER_IRQ_CLEAR(p)) & ~(0x2))
+
+/* irq_control bitmasks */
+/* Minimum interval between interrupts (in 250ns intervals).  The interval
+ * between interrupts will be longer if there are no events on the event ring.
+ * Default is 4000 (1 ms).
+ */
+#define ER_IRQ_INTERVAL_MASK	(0xffff)
+/* Counter used to count down the time to the next interrupt - HW use only */
+#define ER_IRQ_COUNTER_MASK	(0xffff << 16)
+
+/* erst_size bitmasks */
+/* Preserve bits 16:31 of erst_size */
+#define	ERST_SIZE_MASK		(0xffff << 16)
+
+/* erst_dequeue bitmasks */
+/* Dequeue ERST Segment Index (DESI) - Segment number (or alias)
+ * where the current dequeue pointer lies.  This is an optional HW hint.
+ */
+#define ERST_DESI_MASK		(0x7)
+/* Event Handler Busy (EHB) - is the event ring scheduled to be serviced by
+ * a work queue (or delayed service routine)?
+ */
+#define ERST_EHB		(1 << 3)
+#define ERST_PTR_MASK		(0xf)
+
+/**
+ * struct usbssp_run_regs
+ * @microframe_index:
+ *		MFINDEX - current microframe number
+ *
+ *  Device Controller Runtime Registers:
+ * "Software should read and write these registers using only Dword (32 bit)
+ * or larger accesses"
+ */
+struct usbssp_run_regs {
+	__le32			microframe_index;
+	__le32			rsvd[7];
+	struct usbssp_intr_reg	ir_set[128];
+};
+
+/**
+ * struct doorbell_array
+ *
+ * Bits  0 -  7: Endpoint target
+ * Bits  8 - 15: RsvdZ
+ * Bits 16 - 31: Stream ID
+ *
+ */
+struct usbssp_doorbell_array {
+	__le32	doorbell[2];
+};
+
+#define DB_VALUE(ep, stream)		((((ep) + 1) & 0xff) | ((stream) << 16))
+#define DB_VALUE_EP0_OUT(ep, stream)	((((ep) + 1) & 0xff) | ((stream) << 16))
+#define DB_VALUE_CMD			0x00000000
+
+/**
+ * struct usbssp_protocol_caps
+ * @revision:	major revision, minor revision, capability ID,
+ *				and next capability pointer.
+ * @name_string:Four ASCII characters to say which spec this DC
+ *				follows, typically "USB ".
+ * @port_info:	Port offset, count, and protocol-defined information.
+ */
+struct usbssp_protocol_caps {
+	u32	revision;
+	u32	name_string;
+	u32	port_info;
+};
+
+#define	USBSSP_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
+#define	USBSSP_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
+#define	USBSSP_EXT_PORT_PSIC(x)		(((x) >> 28) & 0x0f)
+#define	USBSSP_EXT_PORT_OFF(x)		((x) & 0xff)
+#define	USBSSP_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
+
+#define	USBSSP_EXT_PORT_PSIV(x)	(((x) >> 0) & 0x0f)
+#define	USBSSP_EXT_PORT_PSIE(x)	(((x) >> 4) & 0x03)
+#define	USBSSP_EXT_PORT_PLT(x)	(((x) >> 6) & 0x03)
+#define	USBSSP_EXT_PORT_PFD(x)	(((x) >> 8) & 0x01)
+#define	USBSSP_EXT_PORT_LP(x)	(((x) >> 14) & 0x03)
+#define	USBSSP_EXT_PORT_PSIM(x)	(((x) >> 16) & 0xffff)
+
+#define PLT_MASK        (0x03 << 6)
+#define PLT_SYM         (0x00 << 6)
+#define PLT_ASYM_RX     (0x02 << 6)
+#define PLT_ASYM_TX     (0x03 << 6)
+
+/**
+ * struct usbssp_container_ctx
+ * @type: Type of context.  Used to calculated offsets to contained contexts.
+ * @size: Size of the context data
+ * @bytes: The raw context data given to HW
+ * @dma: dma address of the bytes
+ *
+ * Represents either a Device or Input context.  Holds a pointer to the raw
+ * memory used for the context (bytes) and dma address of it (dma).
+ */
+struct usbssp_container_ctx {
+	unsigned int type;
+#define USBSSP_CTX_TYPE_DEVICE  0x1
+#define USBSSP_CTX_TYPE_INPUT   0x2
+	int size;
+	u8 *bytes;
+	dma_addr_t dma;
+};
+
+/**
+ * struct usbssp_slot_ctx
+ * @dev_info:	device speed, and last valid endpoint
+ * @dev_info2:	Max exit latency for device number
+ * @int_target: interrupter target number
+ * @dev_state:	slot state and device address
+ *
+ * Slot Context -  This assumes the DC uses 32-byte context
+ * structures.  If the DC uses 64-byte contexts, there is an additional 32 bytes
+ * reserved at the end of the slot context for DC internal use.
+ */
+struct usbssp_slot_ctx {
+	__le32	dev_info;
+	__le32	dev_info2;
+	__le32	int_target;
+	__le32	dev_state;
+	/* offset 0x10 to 0x1f reserved for DC internal use */
+	__le32	reserved[4];
+};
+
+/* dev_info bitmasks */
+/* Device speed - values defined by PORTSC Device Speed field - 20:23 */
+#define DEV_SPEED		(0xf << 20)
+#define GET_DEV_SPEED(n)	(((n) & DEV_SPEED) >> 20)
+/* bit 24-26 reserved */
+/* Index of the last valid endpoint context in this device context - 27:31 */
+#define LAST_CTX_MASK		(0x1f << 27)
+#define LAST_CTX(p)		((p) << 27)
+#define LAST_CTX_TO_EP_NUM(p)	(((p) >> 27) - 1)
+#define SLOT_FLAG		(1 << 0)
+#define EP0_FLAG		(1 << 1)
+
+/* dev_info2 bitmasks */
+/* Max Exit Latency (ms) - worst case time to wake up all links in dev path */
+#define MAX_EXIT	(0xffff)
+/* Root device port number that is needed to access the USB device */
+#define ROOT_DEV_PORT(p)	(((p) & 0xff) << 16)
+#define DEVINFO_TO_ROOT_DEV_PORT(p)	(((p) >> 16) & 0xff)
+
+/* dev_state bitmasks */
+/* USB device address - assigned by the usbssp */
+#define DEV_ADDR_MASK		(0xff)
+/* bits 8:26 reserved */
+/* Slot state */
+#define SLOT_STATE		(0x1f << 27)
+#define GET_SLOT_STATE(p)	(((p) & (0x1f << 27)) >> 27)
+
+#define SLOT_STATE_DISABLED	0
+#define SLOT_STATE_ENABLED	SLOT_STATE_DISABLED
+#define SLOT_STATE_DEFAULT	1
+#define SLOT_STATE_ADDRESSED	2
+#define SLOT_STATE_CONFIGURED	3
+
+/**
+ * struct usbssp_ep_ctx
+ * @ep_info:	endpoint state, streams, mult, and interval information.
+ * @ep_info2:	information on endpoint type, max packet size, max burst size,
+ *		error count, and whether the DC will force an event for all
+ *		transactions.
+ * @deq: 64-bit ring dequeue pointer address.  If the endpoint only
+ *		defines one stream, this points to the endpoint transfer ring.
+ *		Otherwise, it points to a stream context array, which has a
+ *		ring pointer for each flow.
+ * @tx_info:
+ *		Average TRB lengths for the endpoint ring and
+ *		max payload within an Endpoint Service Interval Time (ESIT).
+ *
+ * Endpoint Context - This assumes the DC uses 32-byte context
+ * structures.  If the DC uses 64-byte contexts, there is an additional 32 bytes
+ * reserved at the end of the endpoint context for DC internal use.
+ */
+struct usbssp_ep_ctx {
+	__le32	ep_info;
+	__le32	ep_info2;
+	__le64	deq;
+	__le32	tx_info;
+	/* offset 0x14 - 0x1f reserved for DC internal use */
+	__le32	reserved[3];
+};
+
+/* ep_info bitmasks */
+/*
+ * Endpoint State - bits 0:2
+ * 0 - disabled
+ * 1 - running
+ * 2 - halted due to halt condition - ok to manipulate endpoint ring
+ * 3 - stopped
+ * 4 - TRB error
+ * 5-7 - reserved
+ */
+#define EP_STATE_MASK		(0xf)
+#define EP_STATE_DISABLED	0
+#define EP_STATE_RUNNING	1
+#define EP_STATE_HALTED		2
+#define EP_STATE_STOPPED	3
+#define EP_STATE_ERROR		4
+#define GET_EP_CTX_STATE(ctx)	(le32_to_cpu((ctx)->ep_info) & EP_STATE_MASK)
+
+/* Mult - Max number of burtst within an interval, in EP companion desc. */
+#define EP_MULT(p)			(((p) & 0x3) << 8)
+#define CTX_TO_EP_MULT(p)		(((p) >> 8) & 0x3)
+/* bits 10:14 are Max Primary Streams */
+/* bit 15 is Linear Stream Array */
+/* Interval - period between requests to an endpoint - 125u increments. */
+#define EP_INTERVAL(p)			(((p) & 0xff) << 16)
+#define EP_INTERVAL_TO_UFRAMES(p)	(1 << (((p) >> 16) & 0xff))
+#define CTX_TO_EP_INTERVAL(p)		(((p) >> 16) & 0xff)
+#define EP_MAXPSTREAMS_MASK		(0x1f << 10)
+#define EP_MAXPSTREAMS(p)		(((p) << 10) & EP_MAXPSTREAMS_MASK)
+#define CTX_TO_EP_MAXPSTREAMS(p)	(((p) & EP_MAXPSTREAMS_MASK) >> 10)
+/* Endpoint is set up with a Linear Stream Array (vs. Secondary Stream Array) */
+#define	EP_HAS_LSA			(1 << 15)
+#define CTX_TO_MAX_ESIT_PAYLOAD_HI(p)	(((p) >> 24) & 0xff)
+
+/* ep_info2 bitmasks */
+/*
+ * Force Event - generate transfer events for all TRBs for this endpoint
+ * This will tell the DC to ignore the IOC and ISP flags (for debugging only).
+ */
+#define	FORCE_EVENT		(0x1)
+#define ERROR_COUNT(p)		(((p) & 0x3) << 1)
+#define CTX_TO_EP_TYPE(p)	(((p) >> 3) & 0x7)
+#define EP_TYPE(p)		((p) << 3)
+#define ISOC_OUT_EP		1
+#define BULK_OUT_EP		2
+#define INT_OUT_EP		3
+#define CTRL_EP			4
+#define ISOC_IN_EP		5
+#define BULK_IN_EP		6
+#define INT_IN_EP		7
+/* bit 6 reserved */
+/* bit 7 is Device Initiate Disable - for disabling stream selection */
+#define MAX_BURST(p)		(((p)&0xff) << 8)
+#define CTX_TO_MAX_BURST(p)	(((p) >> 8) & 0xff)
+#define MAX_PACKET(p)		(((p)&0xffff) << 16)
+#define MAX_PACKET_MASK		(0xffff << 16)
+#define MAX_PACKET_DECODED(p)	(((p) >> 16) & 0xffff)
+
+/* Get max packet size from ep desc. Bit 10..0 specify the max packet size.
+ * USB2.0 spec 9.6.6.
+ */
+#define GET_MAX_PACKET(p)		((p) & 0x7ff)
+
+/* tx_info bitmasks */
+#define EP_AVG_TRB_LENGTH(p)		((p) & 0xffff)
+#define EP_MAX_ESIT_PAYLOAD_LO(p)	(((p) & 0xffff) << 16)
+#define EP_MAX_ESIT_PAYLOAD_HI(p)	((((p) >> 16) & 0xff) << 24)
+#define CTX_TO_MAX_ESIT_PAYLOAD(p)	(((p) >> 16) & 0xffff)
+
+/* deq bitmasks */
+#define EP_CTX_CYCLE_MASK		(1 << 0)
+#define SCTX_DEQ_MASK			(~0xfL)
+
+/**
+ * struct usbssp_input_control_context
+ * Input control context;
+ *
+ * @drop_context:	set the bit of the endpoint context you want to disable
+ * @add_context:	set the bit of the endpoint context you want to enable
+ */
+struct usbssp_input_control_ctx {
+	__le32	drop_flags;
+	__le32	add_flags;
+	__le32	rsvd2[6];
+};
+
+#define	EP_IS_ADDED(ctrl_ctx, i) \
+	(le32_to_cpu(ctrl_ctx->add_flags) & (1 << (i + 1)))
+#define	EP_IS_DROPPED(ctrl_ctx, i)       \
+	(le32_to_cpu(ctrl_ctx->drop_flags) & (1 << (i + 1)))
+
+/* Represents everything that is needed to issue a command on the command ring.
+ * It's useful to pre-allocate these for commands that cannot fail due to
+ * out-of-memory errors, like freeing streams.
+ */
+struct usbssp_command {
+	/* Input context for changing device state */
+	struct usbssp_container_ctx	*in_ctx;
+	u32	status;
+	/* If completion is null, no one is waiting on this command
+	 * and the structure can be freed after the command completes.
+	 */
+	struct completion		*completion;
+	union usbssp_trb		*command_trb;
+	struct list_head		cmd_list;
+};
+
+/* drop context bitmasks */
+#define	DROP_EP(x)	(0x1 << x)
+/* add context bitmasks */
+#define	ADD_EP(x)	(0x1 << x)
+
+struct usbssp_stream_ctx {
+	/* 64-bit stream ring address, cycle state, and stream type */
+	__le64	stream_ring;
+	/* offset 0x14 - 0x1f reserved for DC internal use */
+	__le32	reserved[2];
+};
+
+/* Stream Context Types - bits 3:1 of stream ctx deq ptr */
+#define	SCT_FOR_CTX(p)		(((p) & 0x7) << 1)
+/* Secondary stream array type, dequeue pointer is to a transfer ring */
+#define	SCT_SEC_TR		0
+/* Primary stream array type, dequeue pointer is to a transfer ring */
+#define	SCT_PRI_TR		1
+/* Dequeue pointer is for a secondary stream array (SSA) with 8 entries */
+#define SCT_SSA_8		2
+#define SCT_SSA_16		3
+#define SCT_SSA_32		4
+#define SCT_SSA_64		5
+#define SCT_SSA_128		6
+#define SCT_SSA_256		7
+
+/* Assume no secondary streams for now */
+struct usbssp_stream_info {
+	struct usbssp_ring		**stream_rings;
+	/* Number of streams, including stream 0 (which drivers can't use) */
+	unsigned int			num_streams;
+	/* The stream context array may be bigger than
+	 * the number of streams the driver asked for
+	 */
+	struct usbssp_stream_ctx	*stream_ctx_array;
+	unsigned int			num_stream_ctxs;
+	dma_addr_t			ctx_array_dma;
+	/* For mapping physical TRB addresses to segments in stream rings */
+	struct radix_tree_root		trb_address_map;
+	struct usbssp_command		*free_streams_command;
+};
+
+#define	SMALL_STREAM_ARRAY_SIZE		256
+#define	MEDIUM_STREAM_ARRAY_SIZE	1024
+
+struct usbssp_ep {
+	struct usb_ep endpoint;
+	struct list_head pending_list;
+	struct usbssp_udc *usbssp_data;
+
+	u8 number;
+	u8 type;
+	u32 interval;
+	char name[20];
+	u8 direction;
+	u8 stream_capable;
+
+	struct usbssp_ring		*ring;
+	/* Related to endpoints that are configured to use stream IDs only */
+	struct usbssp_stream_info	*stream_info;
+	/* Temporary storage in case the configure endpoint command fails and we
+	 * have to restore the device state to the previous state
+	 */
+	struct usbssp_ring		*new_ring;
+	unsigned int			ep_state;
+
+#define SET_DEQ_PENDING		(1 << 0)
+#define EP_HALTED		(1 << 1)  /* For stall handling */
+#define EP_STOP_CMD_PENDING	(1 << 2)  /* For USB request cancellation */
+/* Transitioning the endpoint to using streams, don't enqueue request */
+#define EP_GETTING_STREAMS	(1 << 3)
+#define EP_HAS_STREAMS		(1 << 4)
+/* Transitioning the endpoint to not using streams, don't enqueue requests */
+#define EP_GETTING_NO_STREAMS	(1 << 5)
+#define USBSSP_EP_ENABLED	(1<<6)
+#define USBSSP_EP_WEDGE		(1<<8)
+#define USBSSP_EP_BUSY		(1<<9)
+#define USBSSP_EP_CONF_PENDING	(1<<10)
+#define USBSSP_EP_DISABLE_PENDING (1<<11)
+#define EP0_HALTED_STATUS	(1 << 12) /*For stall handling of Status Stage*/
+
+	struct usbssp_td	*stopped_td;
+	unsigned int		stopped_stream;
+
+	/* Dequeue pointer and dequeue segment for a submitted Set TR Dequeue
+	 * command.  We'll need to update the ring's dequeue segment and dequeue
+	 * pointer after the command completes.
+	 */
+	struct usbssp_segment	*queued_deq_seg;
+	union usbssp_trb	*queued_deq_ptr;
+	/*
+	 * Sometimes the DC can not process isochronous endpoint ring quickly
+	 * enough, and it will miss some isoc tds on the ring and generate
+	 * a Missed Service Error Event.
+	 * Set skip flag when receive a Missed Service Error Event and
+	 * process the missed tds on the endpoint ring.
+	 */
+	bool			skip;
+	/* Isoch Frame ID checking storage */
+	int			next_frame_id;
+	/* Use new Isoch TRB layout needed for extended TBC support */
+	bool			use_extended_tbc;
+};
+
+
+struct usbssp_device {
+	struct usb_gadget *gadget;
+
+	/*
+	 * Commands to the hardware are passed an "input context" that
+	 * tells the hardware what to change in its data structures.
+	 * The hardware will return changes in an "output context" that
+	 * software must allocate for the hardware.  We need to keep
+	 * track of input and output contexts separately because
+	 * these commands might fail and we don't trust the hardware.
+	 */
+	struct usbssp_container_ctx	*out_ctx;
+	/* Used for addressing devices and configuration changes */
+	struct usbssp_container_ctx	*in_ctx;
+
+	struct usbssp_ep		eps[USBSSP_ENDPOINTS_NUM];
+	u8				port_num;
+
+	/* The current max exit latency for the enabled USB3 link states. */
+	u16				current_mel;
+
+	u8				usb2_hw_lpm_capable:1;
+	/* Used for the debugfs interfaces. */
+	void				*debugfs_private;
+};
+
+/**
+ * struct usbssp_device_context_array
+ * @dev_context_ptr	array of 64-bit DMA addresses for device contexts
+ */
+struct usbssp_device_context_array {
+	/* 64-bit device addresses; we only write 32-bit addresses */
+	__le64		dev_context_ptrs[DEV_MAX_SLOTS+1];
+	/* private pointers */
+	dma_addr_t	dma;
+};
+
+struct usbssp_transfer_event {
+	/* 64-bit buffer address, or immediate data */
+	__le64	buffer;
+	__le32	transfer_len;
+	/* This field is interpreted differently based on the type of TRB */
+	__le32	flags;
+};
+
+/* Transfer event TRB length bit mask */
+/* bits 0:23 */
+#define	EVENT_TRB_LEN(p)		((p) & 0xffffff)
+
+/** Transfer Event bit fields **/
+#define	TRB_TO_EP_ID(p)			(((p) >> 16) & 0x1f)
+
+/* Completion Code - only applicable for some types of TRBs */
+#define	COMP_CODE_MASK			(0xff << 24)
+#define GET_COMP_CODE(p)		(((p) & COMP_CODE_MASK) >> 24)
+#define COMP_INVALID			0
+#define COMP_SUCCESS			1
+#define COMP_DATA_BUFFER_ERROR		2
+#define COMP_BABBLE_DETECTED_ERROR	3
+#define COMP_USB_TRANSACTION_ERROR	4
+#define COMP_TRB_ERROR			5
+#define COMP_RESOURCE_ERROR		7
+#define COMP_NO_SLOTS_AVAILABLE_ERROR	9
+#define COMP_INVALID_STREAM_TYPE_ERROR	10
+#define COMP_SLOT_NOT_ENABLED_ERROR	11
+#define COMP_ENDPOINT_NOT_ENABLED_ERROR	12
+#define COMP_SHORT_PACKET		13
+#define COMP_RING_UNDERRUN		14
+#define COMP_RING_OVERRUN		15
+#define COMP_VF_EVENT_RING_FULL_ERROR	16
+#define COMP_PARAMETER_ERROR		17
+#define COMP_CONTEXT_STATE_ERROR	19
+#define COMP_EVENT_RING_FULL_ERROR	21
+#define COMP_INCOMPATIBLE_DEVICE_ERROR	22
+#define COMP_MISSED_SERVICE_ERROR	23
+#define COMP_COMMAND_RING_STOPPED	24
+#define COMP_COMMAND_ABORTED		25
+#define COMP_STOPPED			26
+#define COMP_STOPPED_LENGTH_INVALID	27
+#define COMP_STOPPED_SHORT_PACKET	28
+#define COMP_MAX_EXIT_LATENCY_TOO_LARGE_ERROR	29
+#define COMP_ISOCH_BUFFER_OVERRUN	31
+#define COMP_EVENT_LOST_ERROR		32
+#define COMP_UNDEFINED_ERROR		33
+#define COMP_INVALID_STREAM_ID_ERROR	34
+
+struct usbssp_link_trb {
+	/* 64-bit segment pointer*/
+	__le64 segment_ptr;
+	__le32 intr_target;
+	__le32 control;
+};
+
+/* control bitfields */
+#define LINK_TOGGLE	(0x1<<1)
+
+/* Command completion event TRB */
+struct usbssp_event_cmd {
+	/* Pointer to command TRB, or the value passed by the event data trb */
+	__le64 cmd_trb;
+	__le32 status;
+	__le32 flags;
+};
+
+/* flags bitmasks */
+
+/* Address device - disable SetAddress */
+#define TRB_BSR		(1<<9)
+
+/* Configure Endpoint - Deconfigure */
+#define TRB_DC		(1<<9)
+
+/* Stop Ring - Transfer State Preserve */
+#define TRB_TSP		(1<<9)
+
+enum usbssp_ep_reset_type {
+	EP_HARD_RESET,
+	EP_SOFT_RESET,
+};
+
+/* Force Event */
+#define TRB_TO_VF_INTR_TARGET(p)	(((p) & (0x3ff << 22)) >> 22)
+#define TRB_TO_VF_ID(p)			(((p) & (0xff << 16)) >> 16)
+
+/* Set Latency Tolerance Value */
+#define TRB_TO_BELT(p)			(((p) & (0xfff << 16)) >> 16)
+
+/* Get Port Bandwidth */
+#define TRB_TO_DEV_SPEED(p)		(((p) & (0xf << 16)) >> 16)
+
+/* Force Header */
+#define TRB_TO_PACKET_TYPE(p)		((p) & 0x1f)
+#define TRB_TO_DEV_PORT(p)		(((p) & (0xff << 24)) >> 24)
+
+enum usbssp_setup_dev {
+	SETUP_CONTEXT_ONLY,
+	SETUP_CONTEXT_ADDRESS,
+};
+
+/* bits 16:23 are the virtual function ID */
+/* bits 24:31 are the slot ID */
+#define TRB_TO_SLOT_ID(p)		(((p) & (0xff<<24)) >> 24)
+#define SLOT_ID_FOR_TRB(p)		(((p) & 0xff) << 24)
+
+/* Stop Endpoint TRB - ep_index to endpoint ID for this TRB */
+#define TRB_TO_EP_INDEX(p)		((((p) & (0x1f << 16)) >> 16) - 1)
+#define	EP_ID_FOR_TRB(p)		((((p) + 1) & 0x1f) << 16)
+
+#define SUSPEND_PORT_FOR_TRB(p)		(((p) & 1) << 23)
+#define TRB_TO_SUSPEND_PORT(p)		(((p) & (1 << 23)) >> 23)
+#define LAST_EP_INDEX			30
+
+/* Set TR Dequeue Pointer command TRB fields. */
+#define TRB_TO_STREAM_ID(p)		((((p) & (0xffff << 16)) >> 16))
+#define STREAM_ID_FOR_TRB(p)		((((p)) & 0xffff) << 16)
+#define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
+
+/* Link TRB specific fields */
+#define TRB_TC				(1<<1)
+
+/* Port Status Change Event TRB fields */
+/* Port ID - bits 31:24 */
+#define GET_PORT_ID(p)			(((p) & (0xff << 24)) >> 24)
+
+#define EVENT_DATA			(1 << 2)
+
+/* Normal TRB fields */
+/* transfer_len bitmasks - bits 0:16 */
+#define	TRB_LEN(p)			((p) & 0x1ffff)
+/* TD Size, packets remaining in this TD, bits 21:17 (5 bits, so max 31) */
+#define TRB_TD_SIZE(p)		(min((p), (u32)31) << 17)
+#define GET_TD_SIZE(p)			(((p) & 0x3e0000) >> 17)
+/* DC uses the TD_SIZE field for TBC if Extended TBC is enabled (ETE) */
+#define TRB_TD_SIZE_TBC(p)		(min((p), (u32)31) << 17)
+/* Interrupter Target - which MSI-X vector to target the completion event at */
+#define TRB_INTR_TARGET(p)		(((p) & 0x3ff) << 22)
+#define GET_INTR_TARGET(p)		(((p) >> 22) & 0x3ff)
+/* Total burst count field, Rsvdz on DC with Extended TBC enabled (ETE) */
+#define TRB_TBC(p)			(((p) & 0x3) << 7)
+#define TRB_TLBPC(p)			(((p) & 0xf) << 16)
+
+/* Cycle bit - indicates TRB ownership by DC or driver*/
+#define TRB_CYCLE		(1<<0)
+/*
+ * Force next event data TRB to be evaluated before task switch.
+ * Used to pass OS data back after a TD completes.
+ */
+#define TRB_ENT			(1<<1)
+/* Interrupt on short packet */
+#define TRB_ISP			(1<<2)
+/* Set PCIe no snoop attribute */
+#define TRB_NO_SNOOP		(1<<3)
+/* Chain multiple TRBs into a TD */
+#define TRB_CHAIN		(1<<4)
+/* Interrupt on completion */
+#define TRB_IOC			(1<<5)
+/* The buffer pointer contains immediate data */
+#define TRB_IDT			(1<<6)
+
+/* Block Event Interrupt */
+#define	TRB_BEI			(1<<9)
+
+/* Control transfer TRB specific fields */
+#define TRB_DIR_IN		(1<<16)
+#define	TRB_TX_TYPE(p)		((p) << 16)
+#define	TRB_DATA_OUT		2
+#define	TRB_DATA_IN		3
+
+/* TRB bit mask in Data Stage TRB */
+#define	TRB_SETUPID_BITMASK	(0x300)
+#define TRB_SETUPID(p)		((p) << 8)
+#define TRB_SETUPID_TO_TYPE(p)	(((p) & TRB_SETUPID_BITMASK) >> 8)
+
+#define TRB_SETUP_SPEEDID_USB3	0x1
+#define TRB_SETUP_SPEEDID_USB2	0x0
+#define TRB_SETUP_SPEEDID(p)	((p) & (1 << 7))
+
+#define TRB_SETUPSTAT_ACK	0x1
+#define TRB_SETUPSTAT_STALL	0x0
+#define TRB_SETUPSTAT(p)	((p) << 6)
+
+/* Isochronous TRB specific fields */
+#define TRB_SIA			(1<<31)
+#define TRB_FRAME_ID(p)		(((p) & 0x7ff) << 20)
+
+struct usbssp_generic_trb {
+	__le32 field[4];
+};
+
+union usbssp_trb {
+	struct usbssp_link_trb		link;
+	struct usbssp_transfer_event	trans_event;
+	struct usbssp_event_cmd		event_cmd;
+	struct usbssp_generic_trb	generic;
+};
+
+/* TRB bit mask */
+#define	TRB_TYPE_BITMASK	(0xfc00)
+#define TRB_TYPE(p)		((p) << 10)
+#define TRB_FIELD_TO_TYPE(p)	(((p) & TRB_TYPE_BITMASK) >> 10)
+/* TRB type IDs */
+/* bulk, interrupt, isoc scatter/gather, and control data stage */
+#define TRB_NORMAL		1
+/* setup stage for control transfers */
+#define TRB_SETUP		2
+
+/* data stage for control transfers */
+#define TRB_DATA		3
+/* status stage for control transfers */
+#define TRB_STATUS		4
+/* isoc transfers */
+#define TRB_ISOC		5
+/* TRB for linking ring segments */
+#define TRB_LINK		6
+#define TRB_EVENT_DATA	7
+/* Transfer Ring No-op (not for the command ring) */
+#define TRB_TR_NOOP		8
+/* Command TRBs */
+/* Enable Slot Command */
+#define TRB_ENABLE_SLOT		9
+/* Disable Slot Command */
+#define TRB_DISABLE_SLOT	10
+/* Address Device Command */
+#define TRB_ADDR_DEV		11
+/* Configure Endpoint Command */
+#define TRB_CONFIG_EP		12
+/* Evaluate Context Command */
+#define TRB_EVAL_CONTEXT	13
+/* Reset Endpoint Command */
+#define TRB_RESET_EP		14
+/* Stop Transfer Ring Command */
+#define TRB_STOP_RING		15
+/* Set Transfer Ring Dequeue Pointer Command */
+#define TRB_SET_DEQ		16
+/* Reset Device Command */
+#define TRB_RESET_DEV		17
+/* Force Event Command (opt) */
+#define TRB_FORCE_EVENT		18
+/* Set Latency Tolerance Value Command (opt) */
+#define TRB_SET_LT		20
+/* Force Header Command - generate a transaction or link management packet */
+#define TRB_FORCE_HEADER	22
+/* No-op Command - not for transfer rings */
+#define TRB_CMD_NOOP		23
+/* TRB IDs 24-31 reserved */
+/* Event TRBS */
+/* Transfer Event */
+#define TRB_TRANSFER		32
+/* Command Completion Event */
+#define TRB_COMPLETION		33
+/* Port Status Change Event */
+#define TRB_PORT_STATUS		34
+/* Doorbell Event (opt) */
+#define TRB_DOORBELL		36
+/* Device Controller Event */
+#define TRB_HC_EVENT		37
+/* Device Notification Event - device sent function wake notification */
+#define TRB_DEV_NOTE		38
+/* MFINDEX Wrap Event - microframe counter wrapped */
+#define TRB_MFINDEX_WRAP	39
+/* TRB IDs 40-47 reserved, 48-63 is vendor-defined */
+/* Halt Endpoint Command */
+#define TRB_HALT_ENDPOINT	54
+/* Flush Endpoint Command */
+#define TRB_FLUSH_ENDPOINT	58
+
+static inline const char *usbssp_trb_type_string(u8 type)
+{
+	switch (type) {
+	case TRB_NORMAL:
+		return "Normal";
+	case TRB_SETUP:
+		return "Setup Stage";
+	case TRB_DATA:
+		return "Data Stage";
+	case TRB_STATUS:
+		return "Status Stage";
+	case TRB_ISOC:
+		return "Isoch";
+	case TRB_LINK:
+		return "Link";
+	case TRB_EVENT_DATA:
+		return "Event Data";
+	case TRB_TR_NOOP:
+		return "No-Op";
+	case TRB_ENABLE_SLOT:
+		return "Enable Slot Command";
+	case TRB_DISABLE_SLOT:
+		return "Disable Slot Command";
+	case TRB_ADDR_DEV:
+		return "Address Device Command";
+	case TRB_CONFIG_EP:
+		return "Configure Endpoint Command";
+	case TRB_EVAL_CONTEXT:
+		return "Evaluate Context Command";
+	case TRB_RESET_EP:
+		return "Reset Endpoint Command";
+	case TRB_STOP_RING:
+		return "Stop Ring Command";
+	case TRB_SET_DEQ:
+		return "Set TR Dequeue Pointer Command";
+	case TRB_RESET_DEV:
+		return "Reset Device Command";
+	case TRB_FORCE_EVENT:
+		return "Force Event Command";
+	case TRB_SET_LT:
+		return "Set Latency Tolerance Value Command";
+	case TRB_FORCE_HEADER:
+		return "Force Header Command";
+	case TRB_CMD_NOOP:
+		return "No-Op Command";
+	case TRB_TRANSFER:
+		return "Transfer Event";
+	case TRB_COMPLETION:
+		return "Command Completion Event";
+	case TRB_PORT_STATUS:
+		return "Port Status Change Event";
+	case TRB_DOORBELL:
+		return "Doorbell Event";
+	case TRB_HC_EVENT:
+		return "Device Controller Event";
+	case TRB_DEV_NOTE:
+		return "Device Notification Event";
+	case TRB_MFINDEX_WRAP:
+		return "MFINDEX Wrap Event";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+#define TRB_TYPE_LINK(x)	(((x) & TRB_TYPE_BITMASK) == TRB_TYPE(TRB_LINK))
+/* Above, but for __le32 types -- can avoid work by swapping constants: */
+#define TRB_TYPE_LINK_LE32(x)	(((x) & cpu_to_le32(TRB_TYPE_BITMASK)) == \
+					cpu_to_le32(TRB_TYPE(TRB_LINK)))
+#define TRB_TYPE_NOOP_LE32(x)	(((x) & cpu_to_le32(TRB_TYPE_BITMASK)) == \
+					cpu_to_le32(TRB_TYPE(TRB_TR_NOOP)))
+
+/*
+ * TRBS_PER_SEGMENT must be a multiple of 4,
+ * since the command ring is 64-byte aligned.
+ * It must also be greater than 16.
+ */
+#define TRBS_PER_SEGMENT	16 /*was 256 */
+/* Allow two commands + a link TRB, along with any reserved command TRBs */
+#define MAX_RSVD_CMD_TRBS	(TRBS_PER_SEGMENT - 3)
+#define TRB_SEGMENT_SIZE	(TRBS_PER_SEGMENT*16)
+#define TRB_SEGMENT_SHIFT	(ilog2(TRB_SEGMENT_SIZE))
+/* TRB buffer pointers can't cross 64KB boundaries */
+#define TRB_MAX_BUFF_SHIFT	16
+#define TRB_MAX_BUFF_SIZE	(1 << TRB_MAX_BUFF_SHIFT)
+/* How much data is left before the 64KB boundary? */
+#define TRB_BUFF_LEN_UP_TO_BOUNDARY(addr) (TRB_MAX_BUFF_SIZE - \
+					  (addr & (TRB_MAX_BUFF_SIZE - 1)))
+
+struct usbssp_segment {
+	union usbssp_trb	*trbs;
+	/* private to DC */
+	struct usbssp_segment	*next;
+	dma_addr_t		dma;
+	/* Max packet sized bounce buffer for td-fragmant alignment */
+	dma_addr_t		bounce_dma;
+	void			*bounce_buf;
+	unsigned int		bounce_offs;
+	unsigned int		bounce_len;
+};
+
+struct usbssp_td {
+	struct list_head	td_list;
+	struct usbssp_request	*priv_request;
+	struct usbssp_segment	*start_seg;
+	union usbssp_trb	*first_trb;
+	union usbssp_trb	*last_trb;
+	struct usbssp_segment	*bounce_seg;
+	/* actual_length of the request has already been set */
+	bool request_length_set;
+};
+
+
+/* DC command default timeout value */
+#define USBSSP_CMD_DEFAULT_TIMEOUT	(5 * HZ)
+
+struct usbssp_dequeue_state {
+	struct usbssp_segment	*new_deq_seg;
+	union usbssp_trb	*new_deq_ptr;
+	int			new_cycle_state;
+	unsigned int		stream_id;
+};
+
+enum usbssp_ring_type {
+	TYPE_CTRL = 0,
+	TYPE_ISOC,
+	TYPE_BULK,
+	TYPE_INTR,
+	TYPE_STREAM,
+	TYPE_COMMAND,
+	TYPE_EVENT,
+};
+
+struct usbssp_ring {
+	struct usbssp_segment	*first_seg;
+	struct usbssp_segment	*last_seg;
+	union  usbssp_trb	*enqueue;
+	struct usbssp_segment	*enq_seg;
+	union  usbssp_trb	*dequeue;
+	struct usbssp_segment	*deq_seg;
+	struct list_head	td_list;
+	/*
+	 * Write the cycle state into the TRB cycle field to give ownership of
+	 * the TRB to the device controller (if we are the producer),
+	 * or to check if we own the TRB (if we are the consumer).
+	 */
+	u32			cycle_state;
+	unsigned int		stream_id;
+	unsigned int		num_segs;
+	unsigned int		num_trbs_free;
+	unsigned int		num_trbs_free_temp;
+	unsigned int		bounce_buf_len;
+	enum usbssp_ring_type	type;
+	bool			last_td_was_short;
+	struct radix_tree_root	*trb_address_map;
+};
+
+struct usbssp_erst_entry {
+	/* 64-bit event ring segment address */
+	__le64	seg_addr;
+	__le32	seg_size;
+	/* Set to zero */
+	__le32	rsvd;
+};
+
+struct usbssp_erst {
+	struct usbssp_erst_entry	*entries;
+	unsigned int			num_entries;
+	/* usbssp_udc->event_ring keeps track of segment dma addresses */
+	dma_addr_t			erst_dma_addr;
+	/* Num entries the ERST can contain */
+	unsigned int			erst_size;
+};
+
+struct usbssp_scratchpad {
+	u64		*sp_array;
+	dma_addr_t	sp_dma;
+	void		**sp_buffers;
+};
+
+struct usbssp_request {
+	/*number of TDs associated with this request*/
+	int			num_tds;
+	/*number of actually handled TDs*/
+	int			num_tds_done;
+	struct	usbssp_td	*td;
+
+	struct usb_request	request;
+	struct list_head	list;
+	struct usbssp_ep	*dep;
+
+	struct scatterlist	*sg;
+	unsigned int		num_pending_sgs;
+	u8			epnum;
+	unsigned		direction:1;
+	unsigned		mapped:1;
+	uint32_t		start_frame;
+	int			stream_id;
+};
+
+
+/*
+ * Each segment table entry is 4*32bits long.  1K seems like an ok size:
+ * (1K bytes * 8bytes/bit) / (4*32 bits) = 64 segment entries in the table,
+ * meaning 64 ring segments.
+ * Initial allocated size of the ERST, in number of entries
+ */
+#define	ERST_NUM_SEGS	1
+/* Initial allocated size of the ERST, in number of entries */
+#define	ERST_SIZE	64
+/* Initial number of event segment rings allocated */
+#define	ERST_ENTRIES	1
+/* Poll every 60 seconds */
+#define	POLL_TIMEOUT	60
+
+
+struct s3_save {
+	u32	command;
+	u32	dev_nt;
+	u64	dcbaa_ptr;
+	u32	config_reg;
+	u32	irq_pending;
+	u32	irq_control;
+	u32	erst_size;
+	u64	erst_base;
+	u64	erst_dequeue;
+};
+
+enum usbssp_ep0_state {
+	USBSSP_EP0_UNCONNECTED = 0,
+	USBSSP_EP0_SETUP_PHASE,
+	USBSSP_EP0_DATA_PHASE,
+	USBSSP_EP0_STATUS_PHASE,
+};
+
+struct usbssp_ports {
+	u8	maj_rev;
+	u8	min_rev;
+	u32	*psi;		/* array of protocol speed ID entries */
+	u8	psi_count;
+	u8	psi_uid_count;
+};
+
+struct usbssp_udc {
+	struct device		 *dev;
+	struct usb_gadget	 gadget;
+	struct usb_gadget_driver *gadget_driver;
+
+	unsigned int		irq;		/* irq allocated */
+	void __iomem		*regs;		/* device memory/io */
+	resource_size_t		rsrc_start;	/* memory/io resource start */
+	resource_size_t		rsrc_len;	/* memory/io resource length */
+	u8 msi_enabled;
+	/* USBSSP Registers */
+	struct usbssp_cap_regs __iomem		*cap_regs;
+	struct usbssp_op_regs __iomem		*op_regs;
+	struct usbssp_run_regs __iomem		*run_regs;
+	struct usbssp_doorbell_array __iomem	*dba;
+	/* current interrupter register set */
+	struct	usbssp_intr_reg __iomem	*ir_set;
+
+	/* Cached register copies of read-only USBSSP data */
+	__u32		hcs_params1;
+	__u32		hcs_params2;
+	__u32		hcs_params3;
+	__u32		hcc_params;
+	__u32		hcc_params2;
+
+	unsigned int num_endpoints;
+
+	u8			setupId;
+	u8			setup_speed;
+	enum usbssp_ep0_state	ep0state;
+	/*three state or two state setup */
+	u8			ep0_expect_in;
+	struct usbssp_request	usb_req_ep0_in;
+	u8			three_stage_setup;
+	u32			delayed_status;
+	/*temporary buffer for setup packet*/
+	struct usb_ctrlrequest setup;
+	void			*setup_buf;
+	u8			device_address;
+	u8			bos_event_detected :1;
+
+	uint8_t			defered_event;
+#define EVENT_DEV_CONNECTED 1
+#define EVENT_DEV_DISCONECTED 2
+#define EVENT_SETUP_PACKET 4
+#define EVENT_USB_RESET 8
+	int			remote_wakeup_allowed;
+
+	spinlock_t		lock;
+	spinlock_t		irq_thread_lock;
+	unsigned long		irq_thread_flag;
+
+	/* packed release number */
+	u16			hci_version;
+	u8			max_slots;
+	u8			max_interrupters;
+	u8			max_ports;
+	u8			isoc_threshold;
+	/* imod_interval in ns (I * 250ns) */
+	u32			imod_interval;
+
+	/*revision of current used port*/
+	u8			 port_major_revision;
+	/* 4KB min, 128MB max */
+	int			page_size;
+	/* Valid values are 12 to 20, inclusive */
+	int			page_shift;
+	/* msi-x vectors */
+	int			msix_count;
+	struct msix_entry	*msix_entries;
+
+	/* data structures */
+	struct usbssp_device_context_array *dcbaa;
+	struct usbssp_ring	*cmd_ring;
+	unsigned int		cmd_ring_state;
+
+#define CMD_RING_STATE_RUNNING	(1 << 0)
+#define CMD_RING_STATE_ABORTED	(1 << 1)
+#define CMD_RING_STATE_STOPPED	(1 << 2)
+
+	struct list_head	cmd_list;
+	unsigned int		cmd_ring_reserved_trbs;
+	struct delayed_work	cmd_timer;
+	struct work_struct	bottom_irq;
+	struct workqueue_struct *bottom_irq_wq;
+	struct completion	cmd_ring_stop_completion;
+	struct usbssp_command	*current_cmd;
+	struct usbssp_ring	*event_ring;
+	struct usbssp_erst	erst;
+	/* Scratchpad */
+	struct usbssp_scratchpad *scratchpad;
+
+	/* slot enabling and address device helpers */
+	/* these are not thread safe so use mutex */
+	struct			mutex mutex;
+	int			slot_id;
+
+	/* Internal mirror of the HW's dcbaa */
+	struct usbssp_device	devs;
+
+	/* DMA pools */
+	struct dma_pool		*device_pool;
+	struct dma_pool		*segment_pool;
+	struct dma_pool		*small_streams_pool;
+	struct dma_pool		*medium_streams_pool;
+
+	unsigned int		usbssp_state;
+
+	u32			command;
+	struct s3_save		s3;
+
+	/* Device controller is dying - not responding to commands.
+	 *
+	 * DC interrupts have been disabled and a watchdog timer
+	 * will (or has already) halt the device controller, and complete all
+	 * requests with an -ESHUTDOWN code.  Any code that sees this status
+	 * (other than the timer that set it) should stop touching
+	 * hardware immediately.  Interrupt handlers should return
+	 * immediately when they see this status.
+	 */
+	#define USBSSP_STATE_DYING	(1 << 0)
+	#define USBSSP_STATE_HALTED	(1 << 1)
+	#define USBSSP_STATE_REMOVING	(1 << 2)
+
+	#define USBSSP_STATE_DISCONNECT_PENDING	(1 << 4)
+	#define USBSSP_STATE_DISCONNECTED	(1 << 8)
+
+	unsigned int		num_active_eps;
+
+	/* Is each DC port a USB 3.0, USB 2.0, or USB 1.1 port? */
+	u8			*port_array;
+	/* Pointers to USB 3.0 PORTSC registers */
+	__le32 __iomem		*usb3_ports;
+	unsigned int		num_usb3_ports;
+	/* Pointers to USB 2.0 PORTSC registers */
+	__le32 __iomem		*usb2_ports;
+	unsigned int		num_usb2_ports;
+	struct usbssp_ports	usb2_rhub;
+	struct usbssp_ports	usb3_rhub;
+	/* support software LPM */
+	unsigned		sw_lpm_support:1;
+	/* support USB2 hardware LPM */
+	unsigned		hw_lpm_support:1;
+	/* cached usb2 extended protocol capabilities */
+	u32			*ext_caps;
+	unsigned int		num_ext_caps;
+
+	u32			port_suspended;
+	u32			port_remote_wakeup;
+	u16			test_mode;
+
+	struct dentry		*debugfs_root;
+	struct dentry		*debugfs_slots;
+	struct list_head	regset_list;
+};
+
+#define GET_PORT_RRBESL(p)	(((p) >> 17) & 0xf)
+#define PORT_RBESL(p)		(((p) & 0xf) << 4)
+#define	PORT_BESL_MASK		(0xf << 4)
+#define	PORT_HLE_MASK		(1 << 6)
+
+#define PORT_L1S_HLE0_STALL 1
+
+#define	USBSSP_CFC_DELAY	10
+
+#define usbssp_dbg(usbssp_data, fmt, args...) \
+	dev_dbg(usbssp_data->dev, fmt, ## args)
+
+#define usbssp_err(usbssp_data, fmt, args...) \
+	dev_err(usbssp_data->dev, fmt, ## args)
+
+#define usbssp_warn(usbssp_data, fmt, args...) \
+	dev_warn(usbssp_data->dev, fmt, ## args)
+
+#define usbssp_warn_ratelimited(usbssp_data, fmt, args...) \
+	dev_warn_ratelimited(usbssp_data->dev, fmt, ## args)
+
+#define usbssp_info(usbssp_data, fmt, args...) \
+	dev_info(usbssp_data->dev, fmt, ## args)
+
+#endif /* __LINUX_USBSSP_GADGET_H */
-- 
2.17.1

