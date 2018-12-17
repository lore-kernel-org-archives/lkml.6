Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C28820675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dhCEPHe4";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="X4KGEqDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbeLQPiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:38:06 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43944 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727747AbeLQPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:37:57 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBHFacMi018355;
        Mon, 17 Dec 2018 07:37:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=0l+6xawoX+RZ4X2bweLRZsXcGFBP3sLkYqp2VVdOGG8=;
 b=dhCEPHe4oRJ54NwWu6Snf/TpyXUs2vW9o2pz5bx4/gt4s0MCLoS8xDKhR6UcI2h0YzZx
 VzXAjSyQo/FdXGjsIpH3j2u4vsTaIAe+J44wL+X6nZIvoIGU27MiT9No+o7VIcRV3vhl
 UQbV4GfEV3qqZKA8d811scLr18TL1ZDBswqqKd93jyldPGgENA6IY9MkhBEYQ0nrM4Zg
 n4pgNTBkqeNBvGPN+SDFub5l0gdGDfMcyPyKtI+2R5N56SmeSzImFJCt7/rbbpYL6lrm
 OGdKXkMqml0M2mIvGDX6qe8DzeqI2l8CmRXiNSFNEp0HLrsJHEorCVaQ7X/XM6OnM8yJ kg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pdbx6f482-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Dec 2018 07:37:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l+6xawoX+RZ4X2bweLRZsXcGFBP3sLkYqp2VVdOGG8=;
 b=X4KGEqDjtIuWnMnfDCjBXku/Qh7zXWd4kIt16UwhSk/zkcNVcudMSNucoOcGJzsLKaUE7dj9LGhQG76a5UEWYDN02rgTK7bF85gT4qFR3Yv2y4wDWUwFh/1ozFPMeYFyBObeVPK5g0a/n0YBy1VDpjOBiYxaDc9Ooy1J7tMhWiU=
Received: from DM6PR07CA0028.namprd07.prod.outlook.com (2603:10b6:5:94::41) by
 CY4PR0701MB3714.namprd07.prod.outlook.com (2603:10b6:910:93::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.20; Mon, 17 Dec
 2018 15:37:46 +0000
Received: from DM3NAM05FT035.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by DM6PR07CA0028.outlook.office365.com
 (2603:10b6:5:94::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.19 via Frontend
 Transport; Mon, 17 Dec 2018 15:37:46 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT035.mail.protection.outlook.com (10.152.98.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.5 via Frontend Transport; Mon, 17 Dec 2018 15:37:46 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wBHFbfoc019653
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 17 Dec 2018 10:37:44 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 17 Dec 2018 16:37:43 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 17 Dec 2018 16:37:43 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wBHFbfXl023056;
        Mon, 17 Dec 2018 15:37:41 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wBHFbfxR023045;
        Mon, 17 Dec 2018 15:37:41 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v2 2/2] gpio: Add Cadence GPIO driver
Date:   Mon, 17 Dec 2018 15:36:52 +0000
Message-ID: <20181217153652.20056-3-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181217153652.20056-1-jank@cadence.com>
References: <20181217153652.20056-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(36092001)(199004)(189003)(86362001)(126002)(6666004)(356004)(50466002)(14444005)(446003)(48376002)(11346002)(105596002)(476003)(47776003)(106466001)(486006)(107886003)(53936002)(2616005)(50226002)(8676002)(81156014)(81166006)(8936002)(316002)(42186006)(426003)(76176011)(5660300001)(4326008)(97736004)(305945005)(478600001)(87636003)(36756003)(26826003)(1076002)(336012)(2906002)(26005)(68736007)(51416003)(186003)(110136005)(54906003)(16586007)(69596002)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0701MB3714;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT035;1:y/lACUk/no4cXunhNYFq5exT7/Eq4DLAuvdqGUGLFHs1i/kJJ53CQJB06Y0htEGTMR56qhbGcyPYI+Az5ZYV5r6Za8Z4SIrUNhnpTSpgdzE5pOvCfInp+pVz+rYkgk34
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15a2e00b-2c31-4a77-1ea1-08d6643597f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:CY4PR0701MB3714;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3714;3:I6BOlfmUAz1sF0SzaEwJqlBY5SLe4oJy7tr17XP2ryHKJEry70qL640xfDdSb0WcNFhHeXv793OBPnifZ9D+Yj6/BQM3vc50xTEDe5L2RhM14pgSAkqI/zSyg2fvoEEhVmSGkVtI+sfTXp1iwyINVFGSSCQJrSyQ99zItdC2FAYU1rnZJ1mw1rmblrL4wfMqlhg+CNqxdudK23hvZF8N0fDk003eToIi6QnS2SGczxda1Qv1MA4BD/zHv46doDed27YBbqXumPZPZSBKBLvRuotR8qoFzqce53t2sYHrY7A0zSdRtrJewmAfSeDm3QYW8G9QgU1F64MGtDa2LWnnJQ==;25:hRwxgmxwRavmii5CqbmXDGxyixoScALsSgRqv/KM/sfytTB+04Gy+5LaUwfb5kBdIqFVcpL62OroQK2KWwK8i6YD97YbJoIhgP+eFYrlwpkDwouX7iuw4WMTUP8XdjnS0Gmp80nXFFIk6YEPbit5O4Uyst1+8MLXH3R+NG2R+dfUY2g6Aqxon+0hSU1na51TFt+JPa1neWQviBVJ1mA4cW1i9Jq21cmQKUSn0FL22XLldjucXx7IoaDwMrXz17WbFEyfmlLY0g/4bquMpv0kP1mieLsZWDGH2bDnvRjXwBSCbsLNXPlJG3+dzRNotXaYT0nRnFFQnxegax4FwbXz5Q==;31:V0fIdVnLJlNYYamrncJ12NroQshh7cNxsdqCQyMY5x0dm4qdZiUdH+6sRuCiE0OnnCS9ZoVhs7fPqMPO4ytu/8Zf0KyxuSKrM7jZo69lVfbAA/QHAP+pX1gRCpw++elqtaqnn5TH1vBx+KiB4hmNZmTtMP4rNg4mvBIN2Y5In6lDDoKE/YtcspQzMl7xGm1e/hh1QZaPBfiun4znvo7AnSuw3Yv8wbc/YEr6zXWjSKA=
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3714:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3714;20:YsrMKQVXXPkEKtxYGZUH3W7h+qhVZHhgeIEt++ShCEAvUf/vl+6QejBV+yOLa0whXddHL8m/GZbafkwwcg04F6+Pn2ke8c6Q+luNh8FfRA1M/RJvs+hb0sMKvx9mJ/nXwM34MtptC+Wb2424fulykFHxdDYa9ZJG0yMqDXeyWyj+t5XtOdimcTLWDLZDcDwbez3fgwcsONIxIUcWgNlOMi6NlhM5leCcKXUt5DKjsZDjFmq/UrfPCyZU5tev7k0PVh7s2nG0eThi+SV/Eusn033FFPv8qAJ5oyI6YfvEU7LgZTE2ex7ExhQOTxRmzIIUisMr6e4FzrFMI9wr7lSpj28mIQk9sJjczoQJbcJ77TdYs5aGXSswEGnRXKoaOe94XS7XpI25SAWayW9rKcTw1bn9Kiif9gcQOy0WntZ370x7kOcYK5/xupZ5cJiSgQkZvLykTJspXGIUzcr5VxRc4aKUMLWxjbPALa5F5KEak2ZWKQg7Eg9rINu8xVy16GOk;4:M+p98CBrAcLiInCKm8eInrgQQa+ZK/amXxedZb6nLKJlBDPUgdLjMpuTAci4KnSiCY9lFX/Xbfo6BJBHjG+umtb5IT/Bqf5FM8nxuaSQlmBNtFdEu6zugTIFe+ZqKuBZ+I0jBzxyizEpXmsns7vyTEktPRPJvjXY+LQFo7CYnAKMvfQL9o7m5NaDnWKKulfvn5pKBclSJt4AnqWleIAp/cGK1Z9CVNjlDs+LVtajG6VSJJxUUXy4RsTEWTPpbNeeXwb1CdnzHIUKBn6VYNj5ew==
X-Microsoft-Antispam-PRVS: <CY4PR0701MB3714540D047BD7BBCF20DAE5D0BC0@CY4PR0701MB3714.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93003095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR0701MB3714;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0701MB3714;
X-Forefront-PRVS: 08897B549D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0701MB3714;23:JQxyBc4JsQPsLKu/J52xD6h06tWRygZLnLhkRrx?=
 =?us-ascii?Q?BbX6YU4/2g4x8edTTQSKqGusRe7QM/6p8d0ZRylh+hPOwL4CCfSLJOXwUHvf?=
 =?us-ascii?Q?H2BbJXFbwH3jNrQI9BWj/fbuefftr+LJ8f6/F+nz7f2qt93I9jMAAEvJYXZC?=
 =?us-ascii?Q?w8ueUv7QqQAy9FMpUhYuN70W3/xDO1LXeybI0vaiHdngeji61sUjLzxK12hB?=
 =?us-ascii?Q?c/hfySvM0Nzg3/GKZ8iAP6GUhDXYXQ9fJRJGBB1vOTMFyZpUMgG/1qFa/V7q?=
 =?us-ascii?Q?vSrYTZuVF5xtndvgBddkEFHzMvmWjT5ZIl4YSIZ5MMV9gMena1d8bgUePk9w?=
 =?us-ascii?Q?TUJeHVvtEGDDqU4Al6lIQKxKVEet8GykGqBZDHCh5wnrwtj+9OymuzHk/qeY?=
 =?us-ascii?Q?RkXF99W6jKuBc5CcNlxrKY+lSbSTBtlc+qAhA4JW+TxPLjbMnPEW7cMNdQwT?=
 =?us-ascii?Q?BqdK1x21PCT6IU5ji2168cKFr3R36H6FIdvssJK6plwUjssHxFKdb6e3XuC/?=
 =?us-ascii?Q?zS3/2yg9wZg8vX+3t204ZKcSMXF0YrARnNE6PU3KG+EU9HTQCK+DhilVNCn/?=
 =?us-ascii?Q?Tll7OXz0ZYKMXd3RvMvhWgjPY75ireNwdoOz2R+LQxNykbNM9+rpVbGMq97L?=
 =?us-ascii?Q?aabzYmLwEmvP7LKZFWrEAxU8nFSwpfk1RKAv/jaDAE2xw9LAZvC5/iTD+Yiw?=
 =?us-ascii?Q?16ImpgJyXjBBdAZckrklV09TeTasiVPn/qEMZulEJ7nMBjGRTexaQGZKEugY?=
 =?us-ascii?Q?GvZlR2+hbdJ68bl+hDFSYCbVBIQGvAivOw02WGYriuqLZZZpHR5UCzRKG85v?=
 =?us-ascii?Q?08F95x9TLPdHjQSsfZH+zoDGqLlrdmHfFLVOcrIsxOZXM26UBHRGF4Yjkv+4?=
 =?us-ascii?Q?Zq9hPHDpqSK9jXXq72yrJD6l8etKFev+xnPxYAxrCXMTV57uJXEKm9WExdvJ?=
 =?us-ascii?Q?Ws1EjVzLCp2n+94O6fY3GAsoR+G20UKUVqJX/AdXW8q6SRUkxHdKoXcB4baX?=
 =?us-ascii?Q?BUs3JXljDJu4hHjoQ20GzN4+w7sXhHZzleOYiclHI0hiRWb4xzGNhV07uBxL?=
 =?us-ascii?Q?x8AQhNhtwSC656pMIVg0Pecq+RyhIPA2WUWaPMM4wO0ySyDBi+0D2lULxkDu?=
 =?us-ascii?Q?MSj4jSrKN18LMYIB+J5F+nHNvAOpA/Usx5D0VAJwmzWIlQNwGn9zgkC3/JTe?=
 =?us-ascii?Q?s0NLuGXryjuRTK3FJCmpP0KKPuX4K7dDkacao2aMT5gF5n3x/vRpjl0cpfg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: MMGZlt7pZVzRKBRN7HbsBrz6CvLNURbHZ2Lky4B3yzNWqbIdJGc7S8KN1cON22Y5GnEhs7PIC7pJ862cfaCJkUnAMtFWHL9VX25dUpemkrDbPhJdFdNjZARBrCUjNWZwfSHz+z9WkktJRad+Ai084bm2xGDVxUap2cSXRlVoFzlNWsK4wJpQ5oG7zGPZVhKNyKPW6IwUaX2khqcUhdmbwgCRe9XbmGt80DdPOCqVhJbJSmklxTzRCM32J88+yXVSU7fE1EnIOCPxbldW8saHSxm0kK+cjKJ4WWlipQCwkUR/h44gxru5HVsyzf7ncUNT
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3714;6:Ukjjkox3m/XDUWGjT6oeoscEStFtbAOF8ksXthxulk1+wlfVMFz4ZI+C8YqYhJESilFR6v/oy7Irlt9zc8r0oeJ8k3bj8pY7wepccHxWalibP4vjcX1w3n9otWxM1mZCF2lJW5zujUSXtFGGzx+4DrVO9ncJcvmW0305b5IBwXJVW3l3JPENLYcBZMm1S4PQlJQm+Iezr9E/kF4TvY74JvacQJzU5BozSifI0hHYqOopA5qadduwbm8UOQ0wN8A3KXNtJUsrWZYgRzkQK8URgPqVq8mGcIcgpBRbJnbbcJ2l6fOelPN91HSME79vav7E5d2b1tX3+RGB3TxDB5vO/6ycKKQdOREVjlGFGAAnuibZAjYEbpIVc3NYG2Lju8PVsUx8A72rFFWK3CjLzH0N2sGamv0Z1xFsA6q+EQuUwt3mhK/aTg1ddBoHhPiRWHggMSm1bViQsRnDHlX0XZc/DQ==;5:+N5s8GByjbF5Gnn38Qyb7qZzx/7NoSXTdU7PpOp8+hTHzQi7igmsKc5UPIgJ6XRAVINR4XxCsSGwwhBZM5QY7nahKyjVO7izF3zt4HPvFObEUvBm47HHT+jaMYDkrKBAof407W14wlewxEWXN8DTy0/K1o7TLrIKGKsYovSDDkk=;7:LJ6SaVr8EqPru8FGxNrX5Wggrs6/X8Lvup8aZred++UDQbi6htrhFN2PISLIWBK2uyKxKwxfDeyTriTFGFqT/ygeZik9Q7TyubhG9XCPQIcz+RPIfe62DPS/qyRE+nXroybXcvHJogfHnF5P971Ifw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0701MB3714;20:nFopkaJybkxFJV9l82d6BnH7NZVelybuqgEnvyMiXKb/wOpaqQoHhL+yCo7Ntu6ezGXeEdCxB8XLgwtLa2wqsiYIhZfR0BcFbZaymTU5hHXgjbrqEEmdZmsDV2OBkIDzc/gx+ujl7FyuHNY43z37D8ZUtT0MZ3NN3BQI1fSuif6HXnOwucE4iosi89E4QktutycliDIaMfqzVotDJBnL7ujqrfXEla/OhCDk+yyb4hNE1E1+fomstClAPGlczcXZ
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2018 15:37:46.0596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a2e00b-2c31-4a77-1ea1-08d6643597f5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3714
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for Cadence GPIO controller.

It can be enabled with GPIO_CADENCE Kconfig option.
It uses generic GPIO infrastructure and works
as an interrupt controller.
At the moment it only supports level sensitive irqs.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 drivers/gpio/Kconfig        |   8 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-cadence.c | 275 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/gpio/gpio-cadence.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 833a1b51c..8259f8f25 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -160,6 +160,14 @@ config GPIO_BRCMSTB
 	help
 	  Say yes here to enable GPIO support for Broadcom STB (BCM7XXX) SoCs.
 
+config GPIO_CADENCE
+	tristate "Cadence GPIO support"
+	depends on OF_GPIO
+	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to enable support for Cadence GPIO controller.
+
 config GPIO_CLPS711X
 	tristate "CLPS711X GPIO support"
 	depends on ARCH_CLPS711X || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 671c4477c..5fce8634a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
+obj-$(CONFIG_GPIO_CADENCE)	+= gpio-cadence.o
 obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_CRYSTAL_COVE)	+= gpio-crystalcove.o
diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
new file mode 100644
index 000000000..16cc9f50f
--- /dev/null
+++ b/drivers/gpio/gpio-cadence.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2017-2018 Cadence
+ *
+ * Authors:
+ *  Jan Kotas <jank@cadence.com>
+ *  Boris Brezillon <boris.brezillon@free-electrons.com>
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define CDNS_GPIO_BYPASS_MODE		0x00
+#define CDNS_GPIO_DIRECTION_MODE	0x04
+#define CDNS_GPIO_OUTPUT_EN		0x08
+#define CDNS_GPIO_OUTPUT_VALUE		0x0c
+#define CDNS_GPIO_INPUT_VALUE		0x10
+#define CDNS_GPIO_IRQ_MASK		0x14
+#define CDNS_GPIO_IRQ_EN		0x18
+#define CDNS_GPIO_IRQ_DIS		0x1c
+#define CDNS_GPIO_IRQ_STATUS		0x20
+#define CDNS_GPIO_IRQ_TYPE		0x24
+#define CDNS_GPIO_IRQ_VALUE		0x28
+#define CDNS_GPIO_IRQ_ANY_EDGE		0x2c
+
+struct cdns_gpio_chip {
+	struct gpio_chip gc;
+	struct clk *pclk;
+	void __iomem *regs;
+	u32 bypass_orig;
+};
+
+static int cdns_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
+
+	iowrite32(ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MODE) & ~BIT(offset),
+		  cgpio->regs + CDNS_GPIO_BYPASS_MODE);
+
+	return 0;
+}
+
+static void cdns_gpio_free(struct gpio_chip *chip, unsigned int offset)
+{
+	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
+
+	iowrite32(ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MODE) |
+		  (BIT(offset) & cgpio->bypass_orig),
+		  cgpio->regs + CDNS_GPIO_BYPASS_MODE);
+}
+
+static void cdns_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
+
+	iowrite32(BIT(d->hwirq), cgpio->regs + CDNS_GPIO_IRQ_DIS);
+}
+
+static void cdns_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
+
+	iowrite32(BIT(d->hwirq), cgpio->regs + CDNS_GPIO_IRQ_EN);
+}
+
+static int cdns_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
+	u32 int_value = ioread32(cgpio->regs + CDNS_GPIO_IRQ_VALUE);
+	u32 int_type = ioread32(cgpio->regs + CDNS_GPIO_IRQ_TYPE);
+	u32 mask = BIT(d->hwirq);
+
+	int_value &= ~mask;
+	int_type &= ~mask;
+
+	/*
+	 * The GPIO controller doesn't have an ACK register.
+	 * All interrupt statuses are cleared on a status register read.
+	 * Don't support edge interrupts for now.
+	 */
+
+	if (type == IRQ_TYPE_LEVEL_HIGH) {
+		int_type |= mask;
+		int_value |= mask;
+	} else if (type == IRQ_TYPE_LEVEL_LOW) {
+		int_type |= mask;
+	} else {
+		return -EINVAL;
+	}
+
+	iowrite32(int_value, cgpio->regs + CDNS_GPIO_IRQ_VALUE);
+	iowrite32(int_type, cgpio->regs + CDNS_GPIO_IRQ_TYPE);
+
+	return 0;
+}
+
+static void cdns_gpio_irq_handler(struct irq_desc *desc)
+{
+	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
+	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
+	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	unsigned long status;
+	int hwirq;
+
+	chained_irq_enter(irqchip, desc);
+
+	status = ioread32(cgpio->regs + CDNS_GPIO_IRQ_STATUS) &
+		~ioread32(cgpio->regs + CDNS_GPIO_IRQ_MASK);
+
+	for_each_set_bit(hwirq, &status, chip->ngpio)
+		generic_handle_irq(irq_find_mapping(chip->irq.domain, hwirq));
+
+	chained_irq_exit(irqchip, desc);
+}
+
+static struct irq_chip cdns_gpio_irqchip = {
+	.name		= "cdns-gpio",
+	.irq_mask	= cdns_gpio_irq_mask,
+	.irq_unmask	= cdns_gpio_irq_unmask,
+	.irq_set_type	= cdns_gpio_irq_set_type
+};
+
+static int cdns_gpio_probe(struct platform_device *pdev)
+{
+	struct cdns_gpio_chip *cgpio;
+	struct resource *res;
+	int ret, irq;
+	u32 dir_prev;
+	u32 num_gpios = 32;
+
+	cgpio = devm_kzalloc(&pdev->dev, sizeof(*cgpio), GFP_KERNEL);
+	if (!cgpio)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cgpio->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(cgpio->regs))
+		return PTR_ERR(cgpio->regs);
+
+	of_property_read_u32(pdev->dev.of_node, "ngpios", &num_gpios);
+
+	if (num_gpios > 32) {
+		dev_err(&pdev->dev, "ngpios must be less or equal 32\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Set all pins as inputs by default, otherwise:
+	 * gpiochip_lock_as_irq:
+	 * tried to flag a GPIO set as output for IRQ
+	 * Generic GPIO driver stores the direction value internally,
+	 * so it needs to be changed before bgpio_init() is called.
+	 */
+	dir_prev = ioread32(cgpio->regs + CDNS_GPIO_DIRECTION_MODE);
+	iowrite32(GENMASK(num_gpios - 1, 0),
+		  cgpio->regs + CDNS_GPIO_DIRECTION_MODE);
+
+	ret = bgpio_init(&cgpio->gc, &pdev->dev, 4,
+			 cgpio->regs + CDNS_GPIO_INPUT_VALUE,
+			 cgpio->regs + CDNS_GPIO_OUTPUT_VALUE,
+			 NULL,
+			 NULL,
+			 cgpio->regs + CDNS_GPIO_DIRECTION_MODE,
+			 BGPIOF_READ_OUTPUT_REG_SET);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register generic gpio, %d\n",
+			ret);
+		goto err_revert_dir;
+	}
+
+	cgpio->gc.label = dev_name(&pdev->dev);
+	cgpio->gc.ngpio = num_gpios;
+	cgpio->gc.parent = &pdev->dev;
+	cgpio->gc.base = -1;
+	cgpio->gc.owner = THIS_MODULE;
+	cgpio->gc.request = cdns_gpio_request;
+	cgpio->gc.free = cdns_gpio_free;
+
+	cgpio->pclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(cgpio->pclk)) {
+		ret = PTR_ERR(cgpio->pclk);
+		dev_err(&pdev->dev,
+			"Failed to retrieve peripheral clock, %d\n", ret);
+		goto err_revert_dir;
+	}
+
+	ret = clk_prepare_enable(cgpio->pclk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable the peripheral clock, %d\n", ret);
+		goto err_revert_dir;
+	}
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &cgpio->gc, cgpio);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	/*
+	 * irq_chip support
+	 */
+	irq = platform_get_irq(pdev, 0);
+	if (irq >= 0) {
+		ret = gpiochip_irqchip_add(&cgpio->gc, &cdns_gpio_irqchip,
+					   0, handle_level_irq,
+					   IRQ_TYPE_NONE);
+		if (ret) {
+			dev_err(&pdev->dev, "Could not add irqchip, %d\n",
+				ret);
+			goto err_disable_clk;
+		}
+		gpiochip_set_chained_irqchip(&cgpio->gc, &cdns_gpio_irqchip,
+					     irq, cdns_gpio_irq_handler);
+	}
+
+	cgpio->bypass_orig = ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MODE);
+
+	/*
+	 * Enable gpio outputs, ignored for input direction
+	 */
+	iowrite32(GENMASK(num_gpios - 1, 0),
+		  cgpio->regs + CDNS_GPIO_OUTPUT_EN);
+	iowrite32(0, cgpio->regs + CDNS_GPIO_BYPASS_MODE);
+
+	platform_set_drvdata(pdev, cgpio);
+	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(cgpio->pclk);
+
+err_revert_dir:
+	iowrite32(dir_prev, cgpio->regs + CDNS_GPIO_DIRECTION_MODE);
+
+	return ret;
+}
+
+static int cdns_gpio_remove(struct platform_device *pdev)
+{
+	struct cdns_gpio_chip *cgpio = platform_get_drvdata(pdev);
+
+	iowrite32(cgpio->bypass_orig, cgpio->regs + CDNS_GPIO_BYPASS_MODE);
+	clk_disable_unprepare(cgpio->pclk);
+
+	return 0;
+}
+
+static const struct of_device_id cdns_of_ids[] = {
+	{ .compatible = "cdns,gpio-r1p02" },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver cdns_gpio_driver = {
+	.driver = {
+		.name = "cdns-gpio",
+		.of_match_table = cdns_of_ids,
+	},
+	.probe = cdns_gpio_probe,
+	.remove = cdns_gpio_remove,
+};
+module_platform_driver(cdns_gpio_driver);
+
+MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
+MODULE_DESCRIPTION("Cadence GPIO driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cdns-gpio");
-- 
2.15.0

