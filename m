Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0D8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2662177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="MJ9/Uq3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfA2HH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:07:57 -0500
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:17865
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfA2HH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vVeWtQPpK+2jLt+YmUrbgVB0Rtm1wbpIsLZFenMjZo=;
 b=MJ9/Uq3i19fw/CJrgxpQ7f/vqP9TBncmkHj7D9bY5MjRNRAW4bS9b12IKpydGdjI70fkROVv3ut1AB73vwHeKjxLwmXCJNch29v+OPc1ZJxcOKWAoFuwPAgC68u6Vffz0bKNUCcxbJ8tl5V/68TRAq0GtMNZGEhS4wIOhej3XRs=
Received: from VI1PR08CA0181.eurprd08.prod.outlook.com (2603:10a6:800:d2::11)
 by DB8PR08MB4569.eurprd08.prod.outlook.com (2603:10a6:10:b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17; Tue, 29 Jan
 2019 07:07:48 +0000
Received: from VI1EUR04FT012.eop-eur04.prod.protection.outlook.com
 (2a01:111:f400:7e0e::206) by VI1PR08CA0181.outlook.office365.com
 (2603:10a6:800:d2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.16 via Frontend
 Transport; Tue, 29 Jan 2019 07:07:48 +0000
Authentication-Results: spf=permerror (sender IP is 23.101.59.148)
 smtp.mailfrom=wolfvision.net; posteo.de; dkim=none (message not signed)
 header.d=none;posteo.de; dmarc=none action=none header.from=wolfvision.net;
Received-SPF: PermError (protection.outlook.com: domain of wolfvision.net used
 an invalid SPF mechanism)
Received: from eu5-emailsignatures-cloud.codetwo.com (23.101.59.148) by
 VI1EUR04FT012.mail.protection.outlook.com (10.152.28.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Tue, 29 Jan 2019 07:07:47 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (104.47.5.53) by eu5-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 29 Jan 2019 07:07:45 +0000
Received: from VI1PR08MB3758.eurprd08.prod.outlook.com (20.178.14.18) by
 VI1PR08MB3357.eurprd08.prod.outlook.com (52.134.31.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Tue, 29 Jan 2019 07:07:41 +0000
Received: from VI1PR08MB3758.eurprd08.prod.outlook.com
 ([fe80::e90a:5bd0:70da:db3b]) by VI1PR08MB3758.eurprd08.prod.outlook.com
 ([fe80::e90a:5bd0:70da:db3b%2]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 07:07:41 +0000
From:   Matthias Fend <Matthias.Fend@wolfvision.net>
To:     Martin Kepplinger <martink@posteo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: AW: [PATCH 2/3] Input: st1232 - add support for st1633
Thread-Topic: [PATCH 2/3] Input: st1232 - add support for st1633
Thread-Index: AQHUtz0ZeEn8sMV6Zkqi90ABMX1cUqXF0meA
Date:   Tue, 29 Jan 2019 07:07:41 +0000
Message-ID: <VI1PR08MB37588C9F91E99390591E5DCB85970@VI1PR08MB3758.eurprd08.prod.outlook.com>
References: <20190128084449.16070-1-martink@posteo.de>
 <20190128084449.16070-2-martink@posteo.de> <20190128190334.GA34692@dtor-ws>
 <894cb7d4749835325c4e0f9c65d31a63@posteo.de>
 <419160a7-edf5-48cf-85ea-d6d5e9cd6e59.95bf7d06-047e-438c-8c7b-895af195351a.4c28554a-ad2d-4f90-8e2b-982cefd223a5@emailsignatures365.codetwo.com>
In-Reply-To: <894cb7d4749835325c4e0f9c65d31a63@posteo.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Matthias.Fend@wolfvision.net; 
x-originating-ip: [91.118.163.37]
x-ms-publictraffictype: Email
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 46666a34-634f-46b0-ca19-08d685b87988
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3357;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3357:|DB8PR08MB4569:
X-Microsoft-Antispam-PRVS: <DB8PR08MB456923C47B8B6D2FB4C54B0785970@DB8PR08MB4569.eurprd08.prod.outlook.com>
x-forefront-prvs: 093290AD39
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39840400004)(136003)(396003)(199004)(189003)(102836004)(74316002)(508600001)(7696005)(7736002)(66574012)(86362001)(97736004)(316002)(53936002)(26005)(110136005)(71200400001)(3846002)(30864003)(6116002)(54906003)(71190400001)(81166006)(8936002)(8676002)(305945005)(76176011)(39060400002)(72206003)(68736007)(966005)(14454004)(81156014)(476003)(486006)(6506007)(106356001)(14444005)(11346002)(256004)(446003)(4326008)(99286004)(33656002)(6306002)(25786009)(66066001)(186003)(93886005)(9686003)(55016002)(45080400002)(6436002)(2906002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3357;H:VI1PR08MB3758.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wolfvision.net does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: d9WJVQJZCdLOhX6xulxpvEvXYXhFdE2pKxlpA3c+dd9i7qz8boMo003RJZLEjbTsNdkW7R5LmPZJtTXY65+hZfdgZ465+ZEUKQJJvOtv7fvB6FuX5/vg1bVETCOuqdq+6sLG8X/R/h7vctYhXj8hOvSv2mzzt2XRszgJa+SmQrwlEMc4GFr5SbeoT2QdFil8MUTCDOwHmSY2xDO8mCfGC5yB3BAiJusQ6wqQnbgpImSfmUmaWba5tPa3Ixfca9cq+PPVqzTzcBdyhvAzFDxqEsyhk4X1rALWuvg9EPmVWKQ05lC0s0rKGy5hI5dRMuXGPXUhbkmOeBET70smyGlT7BjX74q/gjMM5qtF91PT0Vzh3xXAegNeTaPWlFUyScbmmZcNErrJNSMKf+zmC5IFRqu1myPe7jQk2td3DCjmd0w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3357
X-CodeTwo-MessageID: 20190129070745.c69f9cd5-a621-4f61-a5bf-98baf1a09646@eu5-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR04FT012.eop-eur04.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:23.101.59.148;IPV:NLI;CTRY:;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39840400004)(346002)(376002)(396003)(2980300002)(448002)(199004)(189003)(336012)(66066001)(186003)(356004)(45080400002)(446003)(66574012)(8936002)(8746002)(246002)(8676002)(30864003)(106466001)(47776003)(15974865002)(476003)(11346002)(14444005)(114624004)(508600001)(93886005)(72206003)(966005)(126002)(3846002)(6116002)(14454004)(50466002)(7696005)(54906003)(76176011)(55016002)(486006)(85326001)(4326008)(25786009)(26005)(6506007)(110136005)(7736002)(316002)(23756003)(74316002)(102836004)(33656002)(305945005)(86362001)(99286004)(6306002)(7636002)(9686003)(2906002)(7596002)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4569;H:eu5-emailsignatures-cloud.codetwo.com;FPR:;SPF:PermError;LANG:en;PTR:eu5-emailsignatures-cloud.codetwo.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;VI1EUR04FT012;1:zc2inJoIGMmGdZfNjImkVShQxqGn95ayzSwGSKB3LH28fiSpQrqK7c3+IIKJI5U4+rhyUT+ClLe2/0S4iHaeCKBFDoadSsV5Bg7XorKE4dZiPELpOgjOfzSgVGiSQJLjF0pXoXH/+sFYQQpOA0IduCAsw0rYaq0ioRn5Z3Ckk3Q=
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4a3a7d98-f263-4164-c69f-08d685b875bb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(710020)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB4569;
X-Microsoft-Exchange-Diagnostics: 1;DB8PR08MB4569;3:TjiMXIYsR51FkuD4qDgGsdtHwjschw3MM6zCD7bqftw0GzJuslUnQpILFkIk3DafyA7io2+O2GzZLzPktPRU7Z/GxRBJcJKdoKkZKHT/IT2TOuzw342d4UNiHKAdrjSQ3DGjzTKsZUowM2GPSnBhd4htWaYdbJJSbnayeZ5Blc4c8NptDHYxkpJGlBn5Krz1q3jFV+Lv+p8oPYLLQNcL2HghjVEorLR+ndKnFxcnNOyi8ZstiIeGI2OBOJFWw05dn7vywh/quiZ3HV43IE3h05wl1aG3HyCHIhwX9KBrQchoudGxkUNn2CQHlyVstX6a4dNUPA37bQjO3H1FOlNx74iR2Bz3YdEhmcYeGRVOXxmZr86zUiadPJWFmn67M59l;25:yTeC/bg6nSrlzy+ulF953jleHc4nEi0pK7vV06aMxaTVnp700BuKryS3pnwghyr8tQsWCwzIZCy5RR+OlZW2w+UO1UW7ZOwBNYzv/Vg3bW4mqs1JbGwbyOdwskIzhgprs2BreUUlYjoxCDRjKpOt9q4ET3bo64mqlacRvo4RDIh06nvZbwgdEJMRg2+ZdIgf9BUNTdSWpqL5K4TvwHxKeQPqBLuKBiGfFajxfvhEz4N8wzZDDak+JY6HqArTlY5PWfHYFDz0qDIbPClntazlMgyD+fkgBBotGDIylBz5g0JvvsQtz1u8hcb6c1h95VdlDXLiJl3gnpiqXrMZozO4eQ==
X-Microsoft-Exchange-Diagnostics: 1;DB8PR08MB4569;31:N749a3L3aqRhNpq0AI/c/z9i2Vp9wIqrr8S+cleBV1PYQ0QC3mQro9P+0ieyzWxGW3CFJ9Aa6s9ZwzLPr2AHUoAMjweJtyhdF7inI90cwR6/SckIyoD8ede9mraEfnAqIWm3WZ3tTU30ihWS30i4jsLMaqEuuCUCMvzT+RGQIoJWY/ESTRJBDposho3/Fv2We4UV6TOox36VVdf3iCw3FfApSKeQfjkrCesiaybZN1Y=;20:KsO3V5XZdkRL9NJteHaS5GV0wAMw2xJ/x9wEF4Psynoic2UJTmnsOwqlISlo4EotHRqS1qTDebU+wJk4TbjhgyIEAnJFbuIRGsX9rnKXkjmgZcmq7OsRKu8kpsqUvYMNOdBSaxxnQyq8KnFDcD8kYhMCTvbL1mOEJqzO2JRwCTZIZ6zop8i9XC003aJpaDB/KS4G4rKPhizG79sTjcATWkwwBDIyv8++csEEEuz7f67ru1PuAPTz6RHpcdb+Gad5UNia27sASQMtdwflM3rYhAkDeFJmn90HquvLCcXQ1OAhZhLV3ARPfi5kaAse0H5D+kYk2Gnwe0a/xxRPb1/R8wLdAZUsT3YaOYGzPI8q3f3CAt0xrL2hWfFbAHfokzg9uyUxv1XF7cJyyEuzAFIpaZfmQmyQ2ieYA+GBKySiiwZg3fMv1l8FBoYryQuPSFgU8SPuDAK5qfZPVg2CUrBm8dmw0BjtSW50SAjtJABOGw1ujzXBC/fYPS9py8DHKHK3BtYKGelo49hO9qlPP1rbug==
X-Microsoft-Exchange-Diagnostics: 1;DB8PR08MB4569;4:P0Ageg7eJRTMrjHlvT3nqcffs5cskTVzhk9inNUW0frKOyGYaO6J6DQyilSK31XTgOJknPippAPzpC1Wi8NUuxVmip6uj31HpIgSgx4JHeEn5MzpGRrX35FOp4GUGDNVnUsPrA5k6QjMjcZwsG1mbvp3T+FeJLexub6c/9+UdsH710lzWBwV78aLNSIkjwG6IP5wwhkLqIE0tkvR1Al15aPzkv/X/B3LkYNX4VOgsjKd1OH3juH7CwQQqgXiphMApFFOFPw0F/CiyYwtafbhsQT+TvC4R6t0nhBCluxbajM7AdJxvIHe/ojvdbsUzX5H
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;DB8PR08MB4569;23:ZyVZlPSv3cDzMoikRgGmbFf+3ZZcnuTB6xiSU03?=
 =?iso-8859-1?Q?7zELCF9ha/yFNH+EVtg6ePQa3JyCeJcY8Bi1hlZFJIQCBM4uTyBgtT4ug6?=
 =?iso-8859-1?Q?caxDuaYhPHRJRSWVgTrd/WfCDvu9fWxbobYxS7K8Dv078jdBAgTp3SkyI0?=
 =?iso-8859-1?Q?hyusMnWDRdOUjcNAydT3aHErhrJEmWbm6YBwzMsdKFy/9tfO8zGvZeGlW6?=
 =?iso-8859-1?Q?2wi73YVEhC0Sni2xhU4pOGqVpx2sYFsyh+GvIRl2xT6yTMyUqkwNJQf6vz?=
 =?iso-8859-1?Q?YQ18V9C/cGjsb1CFan2XBjaZDV8zfcJoLKz9Ib6CyZav2/j383LiIO3A0O?=
 =?iso-8859-1?Q?Z6pyDtUi4xsK25pQybjUZz0Ztoa4yuyOzxPE0e7kNS5RCGsT7iPbFkMyNS?=
 =?iso-8859-1?Q?9x5icyU2B7wxojFSU78jNSziohHtS1DWnzDBWSjoF0quBq+2ewTy+4o4WZ?=
 =?iso-8859-1?Q?SZLSAfssY/K3gko95e3rtThApqrnEiB9T6g88JnOwR1oaZJX4KivnttR6F?=
 =?iso-8859-1?Q?DgBRYm4UFhq59wo2gBfFlcfnGhzGO11HyBRgdaYibm9cuEbiwnnBeVJJ9a?=
 =?iso-8859-1?Q?X3+lExMmRGzh41V6ZOawrkZdVvXazLsYPsMe09RvZgKHAS2ed4vH+ZiooL?=
 =?iso-8859-1?Q?N47t3rQkpyoQ0HbzWZh1cXixy36xXNwMSxXhgBTRoUwoGUKB+qYAJVEAwr?=
 =?iso-8859-1?Q?A45YbO/OgZmU6LpHB2JKMMo1Jjuu/USxD3TesFhx1m9O8YNR48+UQTXLnH?=
 =?iso-8859-1?Q?EXe+oRpZob+C0yHlCbfgyAq2EJ8kMWSpUhbgpcBM87l2/rpNr9AAB6BYFP?=
 =?iso-8859-1?Q?erOprdOkihHq8wqwMBOUy/m56xXmSWVnfmUjCkOMmMIaI+8HuG1/H1Rhnu?=
 =?iso-8859-1?Q?SbmJjt/j4nsPJUpriR8f3RXmB9ut32s4hI4h4QRUyW8GdTubi7qzQDlp5b?=
 =?iso-8859-1?Q?mFRsWpzo+i18HyVcyFKRK8sqSWVBgK7mlFT6JjntOhnqM4nKg7+hsU0aSL?=
 =?iso-8859-1?Q?hkTWlbXfzQBNtLDw7AmLwy86woCtN1VaK84HIIqDpE3NLhl/+FWSCNar5R?=
 =?iso-8859-1?Q?wYyoS72iQxdCp6uThTKPU4JJeb6o2HFOLub/wGuGtk2sdksNwdm9NQTU+j?=
 =?iso-8859-1?Q?C141KhGvdAFnIZeuNTLBXcbJIrHuijxgPfjclkvnm0VdtlekwSCGJvb89S?=
 =?iso-8859-1?Q?g3jd0kZGGiynocKgqYc9avq7FAzVoE6k7sMP0Cqaz1C6+Nq+Q1UW2Wr+RT?=
 =?iso-8859-1?Q?4dJHk8O2EzAf47OFtskJABu0/JLFrkgnzLL9PEhoiaurXm9+wG4G39t1oU?=
 =?iso-8859-1?Q?mhSS6M8w9BdBUrvdTkRWKRqhgxamFAizKoiqg2MvsYyzwRUN/9UYz70t7x?=
 =?iso-8859-1?Q?MOnRcu2QEP+KAI+xsDLgyo4IDK+mpKgnVTBQyzbe7663/YXUtEnE6LTImo?=
 =?iso-8859-1?Q?pUPhgZE7g71Tx0=3D?=
X-Microsoft-Antispam-Message-Info: 3Qc825tTlHzw2s1X1D79TNo4OhzwEHz10TqqA9WJBLsINqkSUOoXOjZyPBEDwIx4x/X+C7iXPfESNo0bz/XKzyxsW0UgZCNx8ISwK5mr5mkp9J5JkNq07Mf36FIrw+iXzGCy7OLelYq+FqP81lbkK7OvUnLgAZcvCr/4hv0VGl7spVUZZr40fyFB5BIopDJcPqNC+3QgfX2M7duixmAOrkIV33wqiZWaNL86iSkFgfbLsMtkzWJzdiCMJ5JsUQu1rFngDhqYlUn1xxdsdc9uyGJk04yQP/vdbNgePmfaM1Rvq1bbodbbFUzAEGnQPUgbJTFKsWfdwlpeb9hbPJGxa1TxlkQpFKbsOV+igJRZ0w5YF0aMxR75qFgYs+ZcA9Bc90vRDsvvM/OO73GVafzDFb46a1BZekhYNG66w4kWPRk=
X-Microsoft-Exchange-Diagnostics: 1;DB8PR08MB4569;6:6YWIJ7Vqtswcbe6BDn6GtiqdyaiDbuMuoVVr+7jGVF9vAxquaudoQgslprsfJADpVrBOL7MdQ7hhbUA0RvA4ay8nUhgsfY8JJI/3xarx9cjEMf5lpFNP07XFEvqAXuGjkYl28GUaTx/wUqWJu3Wres2WmVpDtpWd3XLxWHnzr/RfV1IQHqYInACcemU2JRaUf0UWWXKaLscPBgFO586vBAjO2H9PNmjoErvnL6Nd5K382wbdoSYZbZ0pCsGXBH3ayNxOW9pSOVVx3VhuftRqb9wAsbRQ0VkMliPf9iy/XYnNo4YkQ0NZ4YHTUPLgqb3ET+jG/eXBJ37Rizx2BqwHGtb101GB1ZVmZ2BDQceoPeL79hrLqJAPZjttHRkvo5wJBtq22apYTp9vlsnjKWUISgxn+d4jzGWVZiyJokqL08tG4MaSlFNbsG6TP3UeWeJnJC3TrgZfYAKFhWbqP3LWSA==;5:m7ptsA9fOSDSrUA3Z9LcZp6t4taUOYnGhyfqlVQSsHB9AVBF8qh6uMbAMYnf4++meMnZTk0AvKSidFUULLnytMBbXkrQfuuBBZbZHivO471K0PFU/q+T6eMdmMtGrrp8uiVO2DVRvguHe6PDLLOfnQXgo8y7dh5NbUsYTTQURLNxvcAw807FGyjise2wtHQeskOsM3W7TPmwlmj+NehYzA==;7:JqDra0GPZdX96X7bNVK74FK6XUN79/bXr6AUtDmv7n1tltkRe1XIj+6qrWokMPVGMV0uEU9zeZs1Tl5SpKFUXhLoOPuytDesV9pEsvZ67okdRolTlPHfSWZ1ul4z2shTV04wraZIviCZTs6Suj9zfA==
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 07:07:47.2462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46666a34-634f-46b0-ca19-08d685b87988
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e94ec9da-9183-471e-83b3-51baa8eb804f;Ip=[23.101.59.148];Helo=[eu5-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,


Matthias Fend=0A=
R&D Electronics =0A=
=0A=
Wolfvision GmbH=0A=
Oberes Ried 14 | 6833 Klaus | Austria =0A=
Tel: +43 5523 52250 | Mail: Matthias.Fend@wolfvision.net =0A=
=0A=
Webpage: www.wolfvision.com | www.wolfvision.com/green=0A=
Firmenbuch / Commercial Register: FN283521v Feldkirch/Austria=0A=
=0A=
> -----Urspr=FCngliche Nachricht-----
> Von: linux-input-owner@vger.kernel.org <linux-input-
> owner@vger.kernel.org> Im Auftrag von Martin Kepplinger
> Gesendet: Montag, 28. J=E4nner 2019 20:10
> An: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: devicetree@vger.kernel.org; linux-input@vger.kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; linux-kernel@vger.kernel.org;
> Martin Kepplinger <martin.kepplinger@ginzinger.com>
> Betreff: Re: [PATCH 2/3] Input: st1232 - add support for st1633
>=20
> Am 28.01.2019 20:03 schrieb Dmitry Torokhov:
> > Hi Martin,
> >
> > On Mon, Jan 28, 2019 at 09:44:48AM +0100, Martin Kepplinger wrote:
> >> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> >>
> >> Add support for the Sitronix ST1633 touchscreen controller to the
> >> st1232
> >> driver. A protocol spec can be found here:
> >>
> https://emea01.safelinks.protection.outlook.com/?url=3Dwww.ampdisplay.co
> m%2Fdocuments%2Fpdf%2FAM-320480B6TZQW-
> TC0H.pdf&amp;data=3D01%7C01%7CMatthias.Fend%40wolfvision.net%7C4f9d
> 56475f674b1e3b4008d685543b35%7Ce94ec9da9183471e83b351baa8eb804f%
> 7C0&amp;sdata=3DYTw33BPKKpdN%2BBFrufVk8e4YqXOzR6VQKuzRMOjcwWk
> %3D&amp;reserved=3D0
> >>
> >> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> >> ---
> >>  drivers/input/touchscreen/Kconfig  |   6 +-
> >>  drivers/input/touchscreen/st1232.c | 122
> >> +++++++++++++++++++++--------
> >>  2 files changed, 94 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/drivers/input/touchscreen/Kconfig
> >> b/drivers/input/touchscreen/Kconfig
> >> index 068dbbc610fc..7c597a49c265 100644
> >> --- a/drivers/input/touchscreen/Kconfig
> >> +++ b/drivers/input/touchscreen/Kconfig
> >> @@ -1168,11 +1168,11 @@ config TOUCHSCREEN_SIS_I2C
> >>  	  module will be called sis_i2c.
> >>
> >>  config TOUCHSCREEN_ST1232
> >> -	tristate "Sitronix ST1232 touchscreen controllers"
> >> +	tristate "Sitronix ST1232 or ST1633 touchscreen controllers"
> >>  	depends on I2C
> >>  	help
> >> -	  Say Y here if you want to support Sitronix ST1232
> >> -	  touchscreen controller.
> >> +	  Say Y here if you want to support the Sitronix ST1232
> >> +	  or ST1633 touchscreen controller.
> >>
> >>  	  If unsure, say N.
> >>
> >> diff --git a/drivers/input/touchscreen/st1232.c
> >> b/drivers/input/touchscreen/st1232.c
> >> index 11ff32c68025..19a665d48dad 100644
> >> --- a/drivers/input/touchscreen/st1232.c
> >> +++ b/drivers/input/touchscreen/st1232.c
> >> @@ -23,13 +23,15 @@
> >>  #include <linux/types.h>
> >>
> >>  #define ST1232_TS_NAME	"st1232-ts"
> >> +#define ST1633_TS_NAME	"st1633-ts"
> >> +
> >> +enum {
> >> +	st1232,
> >> +	st1633,
> >> +};
> >
> > This enum seems no longer needed, I dropped it.
> >
> >>
> >>  #define MIN_X		0x00
> >>  #define MIN_Y		0x00
> >
> > Given we no longer have constant MAX_X/Y I simply used 0 in
> > input_set_abs_params() and dropped MIN-X/Y.
> >
> >> -#define MAX_X		0x31f	/* (800 - 1) */
> >> -#define MAX_Y		0x1df	/* (480 - 1) */
> >> -#define MAX_AREA	0xff
> >> -#define MAX_FINGERS	2
> >>
> >>  struct st1232_ts_finger {
> >>  	u16 x;
> >> @@ -38,12 +40,24 @@ struct st1232_ts_finger {
> >>  	bool is_valid;
> >>  };
> >>
> >> +struct st_chip_info {
> >> +	bool	have_z;
> >> +	u16	max_x;
> >> +	u16	max_y;
> >> +	u16	max_area;
> >> +	u16	max_fingers;
> >> +	u8	start_reg;
> >> +};
> >> +
> >>  struct st1232_ts_data {
> >>  	struct i2c_client *client;
> >>  	struct input_dev *input_dev;
> >> -	struct st1232_ts_finger finger[MAX_FINGERS];
> >>  	struct dev_pm_qos_request low_latency_req;
> >>  	int reset_gpio;
> >
> > Could you please create an additional patch converting this to gpiod?
> > Instead of doing of_get_gpio()/gpio_is_valid()/devm_gpio_request()
> > smply
> > do
> >
> > 	ts->reset_gpio =3D devm_gpiod_get_optional();
> > 	if (IS_ERR(ts->reset_gpio)) {
> > 		...
> > 	}
> >
> > and later
> >
> > 	if (ts->reset_gpio)
> > 		...
> >
> > Looking at the code it looks like reset is as usual active low, so you
> > will need to invert the logic as gpiod takes care of convertion logical
> > value to proper level (active low or high).
>=20
> I'll test your applied changes and get back to this tomorrow.
>=20
> thanks.
>=20
> >
> >> +	const struct st_chip_info *chip_info;
> >> +	int read_buf_len;
> >> +	u8 *read_buf;
> >> +	struct st1232_ts_finger *finger;
> >>  };
> >>
> >>  static int st1232_ts_read_data(struct st1232_ts_data *ts)
> >> @@ -52,40 +66,35 @@ static int st1232_ts_read_data(struct
> >> st1232_ts_data *ts)
> >>  	struct i2c_client *client =3D ts->client;
> >>  	struct i2c_msg msg[2];
> >>  	int error;
> >> -	u8 start_reg;
> >> -	u8 buf[10];
> >> +	int i, y;
> >> +	u8 start_reg =3D ts->chip_info->start_reg;
> >> +	u8 *buf =3D ts->read_buf;
> >>
> >> -	/* read touchscreen data from ST1232 */
> >> +	/* read touchscreen data */
> >>  	msg[0].addr =3D client->addr;
> >>  	msg[0].flags =3D 0;
> >>  	msg[0].len =3D 1;
> >>  	msg[0].buf =3D &start_reg;
> >> -	start_reg =3D 0x10;
> >>
> >>  	msg[1].addr =3D ts->client->addr;
> >>  	msg[1].flags =3D I2C_M_RD;
> >> -	msg[1].len =3D sizeof(buf);
> >> +	msg[1].len =3D ts->read_buf_len;
> >>  	msg[1].buf =3D buf;
> >>
> >>  	error =3D i2c_transfer(client->adapter, msg, 2);
> >>  	if (error < 0)
> >>  		return error;
> >>
> >> -	/* get "valid" bits */
> >> -	finger[0].is_valid =3D buf[2] >> 7;
> >> -	finger[1].is_valid =3D buf[5] >> 7;
> >> +	for (i =3D 0, y =3D 0; i < ts->chip_info->max_fingers; i++, y +=3D 3=
) {
> >> +		finger[i].is_valid =3D buf[i + y] >> 7;
> >> +		if (finger[i].is_valid) {
> >> +			finger[i].x =3D ((buf[i + y] & 0x0070) << 4) | buf[i + 1];
> >> +			finger[i].y =3D ((buf[i + y] & 0x0007) << 8) | buf[i + 2];
> >>
> >> -	/* get xy coordinate */
> >> -	if (finger[0].is_valid) {
> >> -		finger[0].x =3D ((buf[2] & 0x0070) << 4) | buf[3];
> >> -		finger[0].y =3D ((buf[2] & 0x0007) << 8) | buf[4];
> >> -		finger[0].t =3D buf[8];
> >> -	}
> >> -
> >> -	if (finger[1].is_valid) {
> >> -		finger[1].x =3D ((buf[5] & 0x0070) << 4) | buf[6];
> >> -		finger[1].y =3D ((buf[5] & 0x0007) << 8) | buf[7];
> >> -		finger[1].t =3D buf[9];
> >> +			/* st1232 includes a z-axis / touch strength */
> >> +			if (ts->chip_info->have_z)
> >> +				finger[i].t =3D buf[i + 6];
> >> +		}
> >>  	}
> >>
> >>  	return 0;
> >> @@ -104,11 +113,14 @@ static irqreturn_t st1232_ts_irq_handler(int
> >> irq, void *dev_id)
> >>  		goto end;
> >>
> >>  	/* multi touch protocol */
> >> -	for (i =3D 0; i < MAX_FINGERS; i++) {
> >> +	for (i =3D 0; i < ts->chip_info->max_fingers; i++) {
> >>  		if (!finger[i].is_valid)
> >>  			continue;
> >>
> >> -		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
> finger[i].t);
> >> +		if (ts->chip_info->have_z)
> >> +			input_report_abs(input_dev,
> ABS_MT_TOUCH_MAJOR,
> >> +					 finger[i].t);
> >> +
> >>  		input_report_abs(input_dev, ABS_MT_POSITION_X,
> finger[i].x);
> >>  		input_report_abs(input_dev, ABS_MT_POSITION_Y,
> finger[i].y);
> >>  		input_mt_sync(input_dev);
> >> @@ -142,12 +154,40 @@ static void st1232_ts_power(struct
> >> st1232_ts_data *ts, bool poweron)
> >>  		gpio_direction_output(ts->reset_gpio, poweron);
> >>  }
> >>
> >> +static const struct st_chip_info st1232_chip_info =3D {
> >> +		.have_z =3D true,
> >> +		.max_x =3D 0x31f, /* 800 - 1 */
> >> +		.max_y =3D 0x1df, /* 480 -1 */
> >> +		.max_area =3D 0xff,
> >> +		.max_fingers =3D 2,
> >> +		.start_reg =3D 0x12,
> >> +};
> >> +
> >> +static const struct st_chip_info st1633_chip_info =3D {
> >> +		.have_z =3D false,
> >> +		.max_x =3D 0x13f, /* 320 - 1 */
> >> +		.max_y =3D 0x1df, /* 480 -1 */

I guess these values are the dimensions of the referenced TFT display and n=
ot any limits of the touch controller. I wonder which values are correct he=
re?
Maybe it would also be easier to just use the decimal representation and dr=
op the comment, what do you think?

Thanks,
 ~Matthias

> >> +		.max_area =3D 0x00,
> >> +		.max_fingers =3D 5,
> >> +		.start_reg =3D 0x12,
> >> +};
> >> +
> >>  static int st1232_ts_probe(struct i2c_client *client,
> >>  			   const struct i2c_device_id *id)
> >>  {
> >>  	struct st1232_ts_data *ts;
> >> +	struct st1232_ts_finger *finger;
> >>  	struct input_dev *input_dev;
> >>  	int error;
> >> +	const struct st_chip_info *match =3D NULL;
> >
> > There is no need to initialize with NULL given that we do unconditional
> > assignment below. I removed initialization.
> >
> >> +
> >> +	match =3D device_get_match_data(&client->dev);
> >> +	if (!match && id)
> >> +		match =3D (const void *)id->driver_data;
> >> +	if (!match) {
> >> +		dev_err(&client->dev, "unknown device model\n");
> >> +		return -ENODEV;
> >> +	}
> >>
> >>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> >>  		dev_err(&client->dev, "need I2C_FUNC_I2C\n");
> >> @@ -163,6 +203,19 @@ static int st1232_ts_probe(struct i2c_client
> >> *client,
> >>  	if (!ts)
> >>  		return -ENOMEM;
> >>
> >> +	ts->chip_info =3D match;
> >> +	ts->finger =3D devm_kzalloc(&client->dev,
> >> +				  sizeof(*finger) * ts->chip_info-
> >max_fingers,
> >> +				  GFP_KERNEL);
> >
> > I replaced it with devm_kcalloc(&client->dev,
> > 				ts->chip_info->max_fingers, sizeof(*finger),
> > 				GFP_KERNEL);
> >
> > and applied.
> >
> >> +	if (!ts->finger)
> >> +		return -ENOMEM;
> >> +
> >> +	/* allocate a buffer according to the number of registers to read */
> >> +	ts->read_buf_len =3D ts->chip_info->max_fingers * 4;
> >> +	ts->read_buf =3D devm_kzalloc(&client->dev, ts->read_buf_len,
> >> GFP_KERNEL);
> >> +	if (!ts->read_buf)
> >> +		return -ENOMEM;
> >> +
> >>  	input_dev =3D devm_input_allocate_device(&client->dev);
> >>  	if (!input_dev)
> >>  		return -ENOMEM;
> >> @@ -192,9 +245,14 @@ static int st1232_ts_probe(struct i2c_client
> >> *client,
> >>  	__set_bit(EV_KEY, input_dev->evbit);
> >>  	__set_bit(EV_ABS, input_dev->evbit);
> >>
> >> -	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
> MAX_AREA, 0,
> >> 0);
> >> -	input_set_abs_params(input_dev, ABS_MT_POSITION_X, MIN_X,
> MAX_X, 0,
> >> 0);
> >> -	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y,
> MAX_Y, 0,
> >> 0);
> >> +	if (ts->chip_info->have_z)
> >> +		input_set_abs_params(input_dev,
> ABS_MT_TOUCH_MAJOR, 0,
> >> +				     ts->chip_info->max_area, 0, 0);
> >> +
> >> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> >> +			     MIN_X, ts->chip_info->max_x, 0, 0);
> >> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> >> +			     MIN_Y, ts->chip_info->max_y, 0, 0);
> >>
> >>  	error =3D devm_request_threaded_irq(&client->dev, client->irq,
> >>  					  NULL, st1232_ts_irq_handler,
> >> @@ -261,13 +319,15 @@ static
> SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
> >>  			 st1232_ts_suspend, st1232_ts_resume);
> >>
> >>  static const struct i2c_device_id st1232_ts_id[] =3D {
> >> -	{ ST1232_TS_NAME, 0 },
> >> +	{ ST1232_TS_NAME, (unsigned long)&st1232_chip_info },
> >> +	{ ST1633_TS_NAME, (unsigned long)&st1633_chip_info },
> >>  	{ }
> >>  };
> >>  MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
> >>
> >>  static const struct of_device_id st1232_ts_dt_ids[] =3D {
> >> -	{ .compatible =3D "sitronix,st1232", },
> >> +	{ .compatible =3D "sitronix,st1232", .data =3D &st1232_chip_info },
> >> +	{ .compatible =3D "sitronix,st1633", .data =3D &st1633_chip_info },
> >>  	{ }
> >>  };
> >>  MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
> >> --
> >> 2.20.1
> >>
> >
> > Thanks.

