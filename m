Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA62C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B392080F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="MJiFmmPb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hcSoD4s8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B392080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeKRUa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 15:30:59 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36382 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbeKRUa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 15:30:59 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAIA6XnX016036;
        Sun, 18 Nov 2018 02:10:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=RbBYnu6XCdppM5JOAT28tKGA2sIdM637Iqwktx/Z0vQ=;
 b=MJiFmmPb7WhP/ksWeb0f6iQGuAjRnntkWyFALmlhS3z5aYv7Bq7sZWekjunIFfzBlC4Y
 Om+oFlMPEqLc4VI9o2qJ5kh9uWWcqgNKtVhnZs+lzG4NEfKSroJAgvr6mXAq2GU4CO/Q
 Bd7AIngbxFG6uUydTU7WzxPWdrzaka8dM7DTgS8acIVVLcFiFYFDo6yYbZRFb/UhyY0J
 XCbZdCUpcP9JT3qPhuxp19911u9aTbye+zbKgmeqyPVOOb8WpMOXehGzi7Fgn53bMEJ9
 jTD0BuUFrlR8ZHeByIRGdb5wmDfOFs6mWp2ILOScFQFwLunzOPOslurLA5oEHEz1erfN yQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0175.outbound.protection.outlook.com [216.32.181.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2ntge14vgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 18 Nov 2018 02:10:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbBYnu6XCdppM5JOAT28tKGA2sIdM637Iqwktx/Z0vQ=;
 b=hcSoD4s8lPKpDQbhfqn5lNaDxGhmm+kojG4pHb8+d/AZrJI7dNahPCSS09AOGKEGrXrGqLC/j3OxyEevsJvP0DZjusMGyrg5WNsG++2HZC6yVR1rv3Cy+bE9TL2RLXih1cLr0v02Em7d54hkQrLrPIBbbG5Zm+mTA2U3a4h6eqU=
Received: from DM5PR07CA0079.namprd07.prod.outlook.com (2603:10b6:4:ad::44) by
 BYAPR07MB5175.namprd07.prod.outlook.com (2603:10b6:a03:6d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Sun, 18 Nov 2018 10:10:51 +0000
Received: from CO1NAM05FT011.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by DM5PR07CA0079.outlook.office365.com
 (2603:10b6:4:ad::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.20 via Frontend
 Transport; Sun, 18 Nov 2018 10:10:51 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT011.mail.protection.outlook.com (10.152.96.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sun, 18 Nov 2018 10:10:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAb5V029622
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 18 Nov 2018 02:10:46 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 18 Nov 2018 11:10:44 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 18 Nov 2018 11:10:44 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAeEe032339;
        Sun, 18 Nov 2018 10:10:40 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wAIAAenF032301;
        Sun, 18 Nov 2018 10:10:40 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nsekhar@ti.com>,
        <nm@ti.com>, <sureshp@cadence.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [RFC PATCH v2 13/15] usb:cdns3: Adds transfer related function.
Date:   Sun, 18 Nov 2018 10:09:09 +0000
Message-ID: <1542535751-16079-14-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1542535751-16079-1-git-send-email-pawell@cadence.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(199004)(189003)(36092001)(4326008)(106466001)(217873002)(2351001)(14444005)(356004)(16586007)(4720700003)(36756003)(105596002)(42186006)(6916009)(86362001)(47776003)(6666004)(316002)(54906003)(11346002)(2616005)(126002)(446003)(476003)(486006)(76176011)(336012)(26005)(426003)(186003)(107886003)(2906002)(48376002)(50466002)(305945005)(246002)(7636002)(87636003)(26826003)(478600001)(5660300001)(8936002)(8676002)(50226002)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5175;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT011;1:sjTvcmcxvf1mx1D/e0pTogGhsD6p6Us/RtqkkaTcTAuxvTQzYohWf1wxLCJb7bS4uXm+e9Upbflphu5b4OjnLT0/7Lq2T7uxPrn3KBSsIYxqMj6p2/bXANJ5JdjVGdBi
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b538636-8c49-4088-9f9a-08d64d3e1e12
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BYAPR07MB5175;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;3:J4mirXqvdv0FlrjkctBBy+TScLl+UA4d+n3LyvIsUALHLGqrgkhdGmxqw6SGn3tahs6o9u/CZMdgd4wst7YOqhKKVwyGvM7WQWzgbRGfqPSPNAosx0NIyHEpOBfNuCcIrj/B0ylNpUTR6+Hqmy0kWxGkbD0PDdCzQ+sxxIAMPB6UlPSN1DdUCq40RDsQyFzeWIfxG4u1C/QcFY/agzIS3pIfyEhY4h7g7/OhWiHiV6bLJ1QYLSzqCEeuly+QXndDj1zndSOWb+KjRua3jQEGexnflOuXBAomNxs43+z91iUu39ke6u1SezojFcRiF/j8evouLYX6+QhI3BYyEYp23cM1K24ZXnVQMFvaHOPdR14=;25:vrkiEoVa4KwJei0DzrQHpX6AAYqRlQ47W+XCYuCEV113Ce5pcO1dtLVqomx6Ema+trlbI2SO0rcz/7Q59wmtpX9G72/mOxF2Atvcuv4WjkKBaPfMJJfopApTi87/9zaO+eJyEelH+boZYbfsBBZiTeCHzeJl2HumtQtydvVGmbS/Phf+dmnnircFL7t3HJ+Aay415JKDsipiSJWwoEC5QWmWMIdE2kTVS8n+OOwTgeW5HwHybRBJPchVZZ8LOxw8EZTbpCPRzjeE8XVWYCG+f514xNts8Dgupr4DccoCuaXQrRlF+Vt6hEWLOp2+LWi9ZfWd+ljMmbD6kGSoRaZmkA==
X-MS-TrafficTypeDiagnostic: BYAPR07MB5175:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;31:mvNxnld+QBpJxu3wlgG3pkRlGObWTZ2tebz7zyIFOYLE2zfuJfIS63Jv/S+3g+kK3AqHSEwzFEU8rxnLolW8QrH28tMYmT6wV8iSW4Lrgou9XRtcAPk3fy4ZADCu7oH5WNed98kDM1geJgciT44Gp6brPP54SOQOeeZqvDbRyjse9PCCBJ0G+ocBh/2N2UCLfBcQD0zWCM0+yodbNLjp4jXKaO073t0YBAamnQMY9Vs=;20:8UZ4qRPKAfxM4kcZVKxVddhYpLF2MtX5uMx8RDElRj5tQBsWx+MuOwnhAEhst6Q1H8WXpTUCM9KRtenXx2b9cBL6xC/cbWSfnpwQBWNZBb2M9AvaYb6sbwNsneTLjykZQJXCv7tmna64ZqksIOE7KIPx7i1CQpV9oyZRpyO1LCYtZjGdSYnZG2vqM3fXI+sDIDZhzjT1Y4fbXv1kcQkkvROZs+UMhCVyE7fQZ7aKwD2voWYiE3oeSi8gCM/E8dB95XGeXRstnKFjdfIrubksew6BwimX4Nj7aASf6iO/giWAJ7u0B5b7U8/OeFhVGHT2DLa6pOMME7Zok+bYhmLuzMNINNZRTbtdEzHEASM/jH8ijuR9r9FFMB/9Sp+Lmy4ptWvB4ZdqqXCcKno5SbmiMkCVUHIjLu1wxWL9qkJThzmTCgHyVYP1ITKyhery/ODcCXjo0Wqi8tYPZTA4ofHYNZ5v3kmeTW7acc3kLRVQq4tysFDqAqIyJmxgEGltpYjS
X-Microsoft-Antispam-PRVS: <BYAPR07MB517585BB92C8D8A59E48F8D1DDDF0@BYAPR07MB5175.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93003095)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5175;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5175;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;4:HVXWtZqSkom0WPrwsjALegriLB0nHFFMwC9aNPqO/TX3dBsfF9XRyYs7OidGtHtY0u/WQMLHmd2laCh5y84W3Jv2IRg1ubDX13niEuLEyVe5dCJX1n+RNKC3itxprYZG24Gk+YO0mMy81+AvBJjjmUFiKw0vQ6lD8ZoJidnKeK6BjWtSgSHKdCxrsCp4QLtmnQvN5ZKm7uP9qoKWhryjYKD/DnSYnNlsJMWxQqlBwKgRRav7n6qHZcQB4Yx7Nye1EH8H2gYlEMCSplH9/99gXg==
X-Forefront-PRVS: 0860FE717F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB5175;23:Qi50UrOwzq2DKQqVg/zAPhVF0fJfaJP4uSaOJW3Fp?=
 =?us-ascii?Q?PLPWS+8oF7OdpebYXxCRR3elw3hkQbA2QEt1sIjG3fHW4jnWVe6IUPGIyEtg?=
 =?us-ascii?Q?4tb64rACV5PJG4YQnqy4EIR985HEPxiDfnA3MrAM2R5dOjeaQ8OsRjKlGuOC?=
 =?us-ascii?Q?JQXckPof2qGtNaO38mEorFZolkHXGLZ4/bpIWlAjwevXH4OsafnXtuvdNTG5?=
 =?us-ascii?Q?X85FkyiiIzmnAToZ4wMTe5eZRSiUFLv8w4uxfwlX6UbZAlG6hRqaUp4k1zf1?=
 =?us-ascii?Q?VENM13AADxrxPSUtMRf1EXlCOYZJOYN41wPNboaADds2joUPJYuL96xog43f?=
 =?us-ascii?Q?yB2MJyVp1WjAcqBZpQMGWIW5ZZfiP2zR+2TfKJSfgTHCgx2S1Pyt04fzmYal?=
 =?us-ascii?Q?Ub1moZSNwoHyRSpnzIYaUfiEfIoN9CcSqcrah7KYVRLqizU5UaXjdOcx8MPL?=
 =?us-ascii?Q?82aVOExG9u8rsIZY4eDbpP0UzZm5X66rtWsNHd9L7U6WqwEwvH4whZcyeoFF?=
 =?us-ascii?Q?JkqSm07h9agAwahcZakpbLnc0X8HhTg8yhpWoxyfO7T/r10N0JHVJTtP3HfE?=
 =?us-ascii?Q?BD59ARv5QuqNl7aijKJTX1QYEpyq3r6za1FmJ9icsIYG1IYXB+PFQxhoAMTG?=
 =?us-ascii?Q?Yogq3/vBc0dGZdVJIU/Ue9CJDVfUtPm+VhCfxFyBRbNfb5OjEQfCZ7zwPpk9?=
 =?us-ascii?Q?7HstmK2bmOaovmIjm7S2n018VcXBofF/istrrN+gfb93qg8p9aCFpZThYw6/?=
 =?us-ascii?Q?VU964xA9BpnCVhPUPEK3BCM61qnTSEKbyRzIfv19n2S4S7dJLMEn9vV6vRaG?=
 =?us-ascii?Q?LUzTYu/liMv6CwG9f1TBbAy3fOr0NlUEpXFac/eaE0gQ2egf9ffjYmlpXEW8?=
 =?us-ascii?Q?UdMCuab56yQkJgnUkpk4i/rQCZaxGhYreOBaZTFnIzwHELoWOOpveNdGbV61?=
 =?us-ascii?Q?4y0xp33nHEgxfacBGhCGPUZSff/ioecYTK+Nr1jjgXGMAHiD98y0eo/5AXul?=
 =?us-ascii?Q?HjDqhgjYeIBqO+nKiPZ1NmMSFdY6P0/JfN46uQn7kqXlntaEf7dnsfAlcgCm?=
 =?us-ascii?Q?r/mIt5QBLQQpXaN+kmH73cfze8+FxMEkUNRyE6B7ycwzSg3jVklTCmYAwapr?=
 =?us-ascii?Q?iP2056lZSF7O3b3W5/PxzCbZ8HRxLZ0g1mvLfkkxhIMNQUpBnVgSQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: sdJJi/oHa5QEkZFnZJAkbfByz+LqhXBpTG5ojyNLySAZo1IVer9LnZKnTDnL/88Jz1iLS7KWIhNmS7GrUEwgyatpZ5obeCGuZaIhEjbxYMORhzV5mjX18ePomk2cFpFrciHjo+iBWFqXJpIGIufLcQoR/U6v5wwnMaUvLz34viy0OWQY3KNY/8Q0z8Q9oIb+INI0AQAQB4QQEo7fDQ7MPAxFLo0mq3FJP8Sqv9yWB9crTyOYVEOjRy+1VNhz4gu/sCjodufmtnh7VxotFd5QeR1OjeEE7H7bpEIhou5MX7MLWIkqZtgwnb5peqh7DKf/NiWvP2sR2jt5IxN4zAAV/SkgEDJTpqqAgMgfFF8wmPI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;6:Dnq554/cTvYexCRgJcigOdy3HxEYCsuJ06PkE/HW+JdQfat0MSx8zuXiZLfMrpxbmY3785GYChvMSbCNyOZZXVSbdRStWt7eO2RqA8tTS36omTeuk+VLhrq4NCcSeDN6cqaNerRREz/Gfo9/F5d/H5g7XFV+IBlGvUa7QyYFUSzEPxKuVSC1ELdvMb3lux541PWre4CEDNosiw40bTmtX9d4eqwXfFqnC2d+jT+hlmbmC4czSBZU+hrrZmMTp99ol4ysjQmCzGh3TywXfuGueyFYn9L19L6CJmf+NLT7Es2JwqitRqIRzFh1NN4ntqHNnf0IpdrJzbA8NflXZBJc0wEGkmpTE1xUICF5J5JMT6kdaNBaRNZaKQdxAHjt/CSYXnf0fjtIKszaxx7m0lqqRG89AUGfoEpjOMXRdaZUfa47FHKegHOiXEAaL17gdK5Ycqdeb1uEZQGjI4KBRE6Kmw==;5:5HQtmkl2cDsr8uD0x3nntip7swTh9GBTlFOh8ee/3Fzj/3hee8jGCLuUZ1DgRaQaPCYhZwJSM3uhgCX1xgT9sKez1f0vcdseYEtvIAz002CZUeXO3Ip015jb/T7XOsYt8Av+tYhhXOFf5AdQGSXKrSbdPAlUW5+UEWhiDKFAHg4=;7:ZZjZhLXqvCuRNd3yL2p6dENGBVXvFAi9TqCcMkRd8ln91Ui4Y77dUkplYDVLQ2FdoXPt5j8gm3QumR2TZpA3E7dycKp7TZjIgPr1Xd9hw6js7S7WEF3H2e4xEyMXckj1iKkFKpR8q1SyLKg1pliVKw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB5175;20:d/JqL4zTuF3NfqPOhc8DPB/PVOGc2mLJk6mdB3InRkYMM/Z0sCKjga0gAvn1d5Z+oG2/yTyGlGHmRR7WzrCkRZiZllC6Vk4ZGQLCEC1sWqA6OoYsF9AA9CVRZFLlxRJ4upiYxO9PgEATYMs3VkskWcFTrxlTdlQKUxfjgkaqucdiU28C8OdpBS8zMni3KYYklR4DghYgcn0hszlYUqWBv4JMnmC9RSepFTYPmk/fRQrXl/tx+6uCwww1YjdWS3f2
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2018 10:10:47.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b538636-8c49-4088-9f9a-08d64d3e1e12
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5175
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=759 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811180096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements a set of function handling transfer on none-default
endpoints. For handling transfer controller use cdns3_trb structure.
Each transfer request block (TRB) contains data buffer address,
length and some control bits. Each transfer can consist of many trbs.
Such group of trbs is called transfer descriptors (TD).
Each endpoint has own array of trbs that make up a transfer ring.
The last element on ring is reserved and is set as Link TRB that
point to the first TRB.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 235 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 0202ff5f6c90..911d9b8c1c8f 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -239,6 +239,45 @@ void cdns3_gadget_unconfig(struct cdns3_device *priv_dev)
 	priv_dev->out_mem_is_allocated = 0;
 }
 
+/**
+ * cdns3_ep_inc_trb - increment a trb index.
+ * @index: Pointer to the TRB index to increment.
+ * @cs: Cycle state
+ *
+ * The index should never point to the link TRB. After incrementing,
+ * if it is point to the link TRB, wrap around to the beginning and revert
+ * cycle state bit The
+ * link TRB is always at the last TRB entry.
+ */
+static void cdns3_ep_inc_trb(int *index, u8 *cs)
+{
+	(*index)++;
+	if (*index == (TRBS_PER_SEGMENT - 1)) {
+		*index = 0;
+		*cs ^=  1;
+	}
+}
+
+/**
+ * cdns3_ep_inc_enq - increment endpoint's enqueue pointer
+ * @priv_ep: The endpoint whose enqueue pointer we're incrementing
+ */
+static void cdns3_ep_inc_enq(struct cdns3_endpoint *priv_ep)
+{
+	priv_ep->free_trbs--;
+	cdns3_ep_inc_trb(&priv_ep->enqueue, &priv_ep->pcs);
+}
+
+/**
+ * cdns3_ep_inc_deq - increment endpoint's dequeue pointer
+ * @priv_ep: The endpoint whose dequeue pointer we're incrementing
+ */
+static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
+{
+	priv_ep->free_trbs++;
+	cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs);
+}
+
 void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable)
 {
 	if (enable)
@@ -278,7 +317,27 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 			   struct cdns3_request *priv_req,
 			   int status)
 {
-	//TODO: Implements this function.
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct usb_request *request = &priv_req->request;
+
+	list_del_init(&request->list);
+	if (request->status == -EINPROGRESS)
+		request->status = status;
+
+	usb_gadget_unmap_request_by_dev(priv_dev->sysdev, request,
+					priv_ep->dir);
+
+	priv_req->on_ring = 0;
+
+	if (request->complete) {
+		spin_unlock(&priv_dev->lock);
+		usb_gadget_giveback_request(&priv_ep->endpoint,
+					    request);
+		spin_lock(&priv_dev->lock);
+	}
+
+	if (request->buf == priv_dev->zlp_buf)
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
 }
 
 /**
@@ -290,13 +349,185 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			  struct usb_request *request)
 {
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct cdns3_request *priv_req;
+	struct cdns3_trb *trb;
+	dma_addr_t trb_dma;
+	int sg_iter = 0;
+	u32 first_pcs;
+	int  num_trb;
+	int address;
+	int pcs;
+
+	if (!request)
+		return -EINVAL;
+
+	num_trb = request->num_sgs ? request->num_sgs : 1;
+
+	if (num_trb > priv_ep->free_trbs)
+		return -EINVAL;
+
+	priv_req = to_cdns3_request(request);
+	address = priv_ep->endpoint.desc->bEndpointAddress;
+
+	if (priv_req->on_ring)
+		goto arm;
+
+	priv_ep->flags |= EP_PENDING_REQUEST;
+	trb_dma = request->dma;
+
+	/* must allocate buffer aligned to 8 */
+	if ((request->dma % ADDR_MODULO_8)) {
+		if (request->length <= CDNS3_UNALIGNED_BUF_SIZE) {
+			memcpy(priv_ep->aligned_buff, request->buf,
+			       request->length);
+			trb_dma = priv_ep->aligned_dma_addr;
+		} else {
+			return -ENOMEM;
+		}
+	}
+
+	trb = priv_ep->trb_pool + priv_ep->enqueue;
+	priv_req->trb = trb;
+	priv_req->start_trb = priv_ep->enqueue;
+
+	//prepare ring
+	if ((priv_ep->enqueue + num_trb)  >= (TRBS_PER_SEGMENT - 1)) {
+		/*updating C bt in  Link TRB before starting DMA*/
+		struct cdns3_trb *link_trb = priv_ep->trb_pool +
+					     (TRBS_PER_SEGMENT - 1);
+		link_trb->control = ((priv_ep->pcs) ? TRB_CYCLE : 0) |
+				    TRB_TYPE(TRB_LINK) | TRB_CHAIN |
+				    TRB_TOGGLE;
+	}
+
+	first_pcs = priv_ep->pcs ? TRB_CYCLE : 0;
+
+	do {
+	/* fill TRB */
+		trb->buffer = TRB_BUFFER(request->num_sgs == 0
+				? trb_dma : request->sg[sg_iter].dma_address);
+
+		trb->length = TRB_BURST_LEN(16) |
+		    TRB_LEN(request->num_sgs == 0 ?
+				request->length : request->sg[sg_iter].length);
+
+		trb->control = TRB_TYPE(TRB_NORMAL);
+		pcs = priv_ep->pcs ? TRB_CYCLE : 0;
+
+		/*
+		 * first trb should be prepared as last to avoid processing
+		 *  transfer to early
+		 */
+		if (sg_iter == request->num_sgs && sg_iter != 0)
+			trb->control |= pcs | TRB_IOC | TRB_ISP;
+		else if (sg_iter != 0)
+			trb->control |= pcs;
+
+		++sg_iter;
+		++trb;
+		cdns3_ep_inc_enq(priv_ep);
+	} while (sg_iter < request->num_sgs);
+
+	trb = priv_req->trb;
+
+	/* give the TD to the consumer*/
+	if (sg_iter == 1)
+		trb->control |= first_pcs | TRB_IOC | TRB_ISP;
+	else
+		trb->control |= first_pcs;
+
+	priv_req->on_ring = 1;
+arm:
+	/* arm transfer on selected endpoint */
+	cdns3_select_ep(priv_ep->cdns3_dev, address);
+
+	/*
+	 * For DMULT mode we can set address to transfer ring only once after
+	 * enabling endpoint.
+	 */
+	if (priv_ep->flags & EP_UPDATE_EP_TRBADDR) {
+		writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma),
+		       &priv_dev->regs->ep_traddr);
+		priv_ep->flags &= ~EP_UPDATE_EP_TRBADDR;
+	}
+
+	if (priv_dev->hw_configured_flag) {
+		/*clearing TRBERR before seting DRDY*/
+		writel(EP_STS_TRBERR, &priv_dev->regs->ep_sts);
+		/* memory barrier*/
+		wmb();
+		dev_dbg(&priv_dev->dev, "//Ding Dong %s ep_trbaddr %08x\n",
+			priv_ep->name, readl(&priv_dev->regs->ep_traddr));
+		writel(EP_CMD_DRDY, &priv_dev->regs->ep_cmd);
+	}
+
 	return 0;
 }
 
+static bool cdns3_request_handled(struct cdns3_endpoint *priv_ep,
+				  struct cdns3_request *ss_request)
+{
+	int current_index;
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	struct cdns3_trb *trb = ss_request->trb;
+
+	cdns3_select_ep(priv_dev, priv_ep->endpoint.desc->bEndpointAddress);
+	current_index = (readl(&priv_dev->regs->ep_traddr) -
+			 priv_ep->trb_pool_dma) / TRB_SIZE;
+
+	trb = &priv_ep->trb_pool[ss_request->start_trb];
+
+	if ((trb->control  & TRB_CYCLE) != priv_ep->ccs)
+		return false;
+
+	/**
+	 * case where ep_traddr point to last trb in ring (link trb)
+	 * and dequeue pointer already has been changed to first trb
+	 */
+	if ((current_index == (TRBS_PER_SEGMENT - 1)) && !priv_ep->dequeue)
+		return false;
+
+	if (ss_request->start_trb != current_index)
+		return true;
+
+	return false;
+}
+
 static void cdns3_transfer_completed(struct cdns3_device *priv_dev,
 				     struct cdns3_endpoint *priv_ep)
 {
-	//TODO: Implements this function.
+	struct usb_request *request, *request_temp;
+	struct cdns3_request *priv_req;
+	struct cdns3_trb *trb;
+
+	list_for_each_entry_safe(request, request_temp,
+				 &priv_ep->request_list, list) {
+		priv_req = to_cdns3_request(request);
+
+		if (!cdns3_request_handled(priv_ep, priv_req))
+			return;
+
+		if (request->dma % ADDR_MODULO_8 &&
+		    priv_ep->dir == USB_DIR_OUT)
+			memcpy(request->buf, priv_ep->aligned_buff,
+			       request->length);
+
+		trb = priv_ep->trb_pool + priv_ep->dequeue;
+
+		if (trb != priv_req->trb)
+			dev_warn(&priv_dev->dev, "request_trb=0x%p, queue_trb=0x%p\n",
+				 priv_req->trb, trb);
+
+		request->actual = TRB_LEN(le32_to_cpu(trb->length));
+
+		priv_ep->free_trbs++;
+		cdns3_ep_inc_deq(priv_ep);
+
+		cdns3_gadget_giveback(priv_ep, priv_req, 0);
+	}
+
+	priv_ep->flags &= ~EP_PENDING_REQUEST;
 }
 
 /**
-- 
2.17.1

