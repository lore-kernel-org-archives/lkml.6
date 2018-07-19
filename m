Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A388C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074DD20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Jo390uyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074DD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbeGSSqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:46:45 -0400
Received: from mail-eopbgr730050.outbound.protection.outlook.com ([40.107.73.50]:14081
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732058AbeGSSqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmxXUEiS42yBQ74q2YJ84RponX0jBEOhDWror27VFEU=;
 b=Jo390uyTkmkNxfG/DnUHM2dNP/elHv9KKoJQNqw5Izw69WrxcH8u4itmE8NMzVunI1mgwBh5YwHa3HPePpoBI5xgP9aigK3KuxejP/mcF01RBQR1d8+1a7OItZ6T2ykgYOuD7p/ZzTDkTZpG+qect0vLLrC7TSfcA+h3BpYeJa8=
Received: from CO2PR07CA0072.namprd07.prod.outlook.com (2603:10b6:100::40) by
 CY1PR0701MB1338.namprd07.prod.outlook.com (2a01:111:e400:4c1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 19 Jul
 2018 17:59:18 +0000
Received: from DM3NAM05FT007.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by CO2PR07CA0072.outlook.office365.com
 (2603:10b6:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:17 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT007.mail.protection.outlook.com (10.152.98.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:16 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxARw019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:15 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:26 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:26 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxB0p005720;
        Thu, 19 Jul 2018 18:59:11 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxBjV005719;
        Thu, 19 Jul 2018 18:59:11 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 08/31] usb: usbssp: Added ring and segment handling functions.
Date:   Thu, 19 Jul 2018 18:57:41 +0100
Message-ID: <1532023084-28083-9-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(36092001)(189003)(199004)(50466002)(2616005)(48376002)(26826003)(478600001)(87636003)(486006)(126002)(4326008)(476003)(1671002)(8676002)(426003)(106466001)(11346002)(2906002)(105596002)(47776003)(446003)(109986005)(76176011)(8936002)(107886003)(356003)(51416003)(16586007)(316002)(42186006)(54906003)(5660300001)(14444005)(186003)(6346003)(26005)(4720700003)(6666003)(50226002)(36756003)(305945005)(7636002)(246002)(86362001)(336012)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1338;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT007;1:zpFKA8XKCJxvze8j4f+gGqqR5ODDxZe24ONM4dm2Uv0c95DY8oYjWstpmseOxLMpKJoLouUxQTzwWJqF8rcc0bC4TQrD+mwQVKH/paTVIJPHRCm0EJskbazPOn5K+1rE
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9372d3c-877f-43ca-f076-08d5eda1587c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0701MB1338;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;3:/PKgHijzYUt5CqmnDvtQKlA8YVHulqKt5dGJqILdX//eFZ6Vau/NeUwk6rZpkYf/BC9P/IJ2L+GPhdyogSJ+59sm3nKk1UBHOfTeMeO6y8TcYAY78gLyxGNa1VScxoT9s9PXnEpc8MezTLu1J7Z0usKGt84GCoCZnkRjK2o7Zi29wKXPFwoQ4aISEaHE2BV3y+TxOg1Qh2Ifvewsd4lo7YK/f/tjikXB11YJNJ/aQssqCJLRxvAT0/ZHYgJPcYwyfCnV4fGvVBoqnGn0FfFguBM5VK1LdWelgZZ0Bc0wrOl/dzR6Au4gKQuhYoGIeKwexlAcnSyV/DGGfU0mGP9UNEF+27UrRWNgNt6oyn0yfa0=;25:xUdkaNRXUKRl4jzFGLsu4r7f2WtgsDU3DdbCoSuDZPynNx6OFagXXs7JV/mI8e8n5oFhBBno38hDV50A0eRoxTGpJzvV7p2VsWgwT8w8yovcp3gPJmhuHSz1KMglywSH89jDivRce9fqWb5R5XvLKlWP60Cu60RmMKxODm3jsdgeHYuwqAqOKOwcpHi8464iN/4qzhd61M9cPBiJ4/0IhS3EA198nMZ9r/2pRP/6dvTM6TQ9TSxNNJntjqmW1OKXR5yXlR34frAlC66BIV4k45gr0J2GEISoL6cIyKzAsm0YHDlitsa79QbxDVH1XLVdDKq20Sa5JcvQmZuOpyci+A==
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1338:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;31:2MP8i4ZfzPccIUVFYX85T8xNrCPsab7h4Xv/ejt/8dkF5uTzmeOZZNE8pqPb5iLkN2DSS3gyrCNBhsrPRNFRtWAw7d0ls/EL7TtjRn1aLjLQhNuKCh4f3uFPRWo6hCOJSMePdhg0bJm02P69d5F5Bx6ML5K6NGkl2ZHLnmG77bIl5wzK/eQJh1LpRu7SM5sOdpBEUZwSPytA+/h7PqWm/nLDjnKW1rZlRdcBaOrubNg=;20:hHr6ujAwV/oh9NWnq5D91M+rhW5Mm3KYSk6jS2tV8K35EySriF3oikJmSKDybcC1KxFnAQykLBL16zolQTspVw2hPHZLeJJu732r6fAnuBb/C/EYd0fuYVRkfWXnaGDFd5sCOBAgltovdoJhKUxgn/RRiZn72ZxM+cTNafNy8y7WA1PYc/VP4ur2BWS2QGQQQ6NmhIRDGRxZNjYh6czvvg3AERS741YlYPhfhLjZ3IFwhVPfVnKMlPQDcIrbk88Wjh6xkdiJYzDJpR+SdIP2xpw+/nLRSBtW8VDX0MhA2xMgfK8XE4DZLpDp7PdG6UjAfPTsA6TKcWdj+OCLxyFHrd9LkC1/wkAdA/95ort7Yf2nb9RGAgvDqRstZW6p86FObMGJgjq0wwKQ0woIImL7AV4yElztVjp2NZ16MJ6Ws0+VF+mvOLyzK/Kb6rLJFtf1Bp3XtNt5AWJ9TEwM3oJoE8Nudrj4EfzunzTEEAoDuMAivvXqeQ8aNyQb6CYk4izb
X-Microsoft-Antispam-PRVS: <CY1PR0701MB133886D23D4BA9F325F9A3AEDD520@CY1PR0701MB1338.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006)(131327999870524)(211171220733660)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1338;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1338;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;4:2lzUPuWncHMFvQpwI0q/a6WXx/qDZfWvIQtXsKkECC9+q8PXirbepFM7cFwu4t7bmCLlxxNOkUilBdJYri+et/NGUAvd6e4Oye6oSYQP3DtIyCf1qjZL7gk0pHlePJSAsBuhfwovdLXw9RITtEiurV5XTw762ZqmN4Vyv4mLWTTmt8QM6OuQNIwEac/nJMfCdw+A/KTdDQVhzr8ZzmJSJhx9sSQ7XluNB7cMn6sKnSj7ppvEs+JV7SAXHYEila3QMd6mOP89izOuKu9n5utNpLPfprVvfVoydg+l6V4K1Rv1FQecIRqBWGZso7FJHIkduh2UZzisNJZI4fkR3HlB9ztxRK/mLh2BeFZ12UOiKEWy8HxrAMCPlmS2S+YNTElYoMC6opssewvXp1W/X9WyBctozM80GicReuWtdy85A9g=
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1338;23:iY+GyCOPFL+Z6MSlmIbINDYHTIqkruDrbxCIAnM?=
 =?us-ascii?Q?V6pQmeU5mJRpkG3Mn9fylyAcrHnBT844o0wCzhcEha+IfWyCh1c+lyavTu+H?=
 =?us-ascii?Q?yTMfEgAwARzTlB78FA0Ohx0DC3/2uaQ+8fEPyUJJhzUkF8WWmv1Eg/kq9VwM?=
 =?us-ascii?Q?cA4eRx0jMf0ZAQHkbPvV6X4jWk3Nly03QiaiYFPq2xS3y2cQIIYLFID4boKN?=
 =?us-ascii?Q?yGpAwTO9CeSm96VMpFaMVNIAhEROy56Z3LU7VnaAzwBkW6F1wwjzqD8cTeML?=
 =?us-ascii?Q?smQ8GJthbGnHZukVLF/xENYbEDWdl+cizD/lxUqBG2mfb33d8E/iFzS6jZcZ?=
 =?us-ascii?Q?8dCRC4fgKI5cDmh+5Lj5xcZEhkhVCg3U0dfG2C17Jon57Cm1oaGToARToxZV?=
 =?us-ascii?Q?wJ5mQvpEIBC/0Fz+hsx/iL49f4gO/zOZrJmWkXi2n4IBSA/JWP5y9daF86WB?=
 =?us-ascii?Q?Ph8Ks7bNCIXfpcdcBsCy8zKEkitlvi8p4nLY/M8wkrFpxqgRpM2uNll1YNky?=
 =?us-ascii?Q?08RmaLWRGQ+SRi4KxhObHn/XM8cQOTBFXGifjW6FliEE+QIqz0M4JD6NApUs?=
 =?us-ascii?Q?xZ0nzL+MtTR9EFPSmtomzHRPMGnjcqo4sFEBI3kKvHdiZZ5sF0+3eA7d6olR?=
 =?us-ascii?Q?b5D+f/21yEebNOD7ek6CCrCuSetX2O+MXV8341HI34f+HY3A+FL4gp/c54qI?=
 =?us-ascii?Q?9EiLdUEM/nSMcRBVTy5fCzqsOalM4gC/FBQ2My704bvrqmAzSvp4NJecbjOw?=
 =?us-ascii?Q?Sd22sqFYIUIOtu43pgUfFfvCTkiHK8ESUhjASIyeucmhKPQUNroz24O5wPEu?=
 =?us-ascii?Q?liGOrWvEN14o0uvvcgbTvou6Bj9KmNLrHUvpoRLIEFg0woXUD5bHR9AKKty2?=
 =?us-ascii?Q?MJB3Ao4FlSl4yLGZZEY7pdXbbLNVRj8acTNDdWERZIRjtXOJv1QijZyy9pEB?=
 =?us-ascii?Q?zuqdZ/5q7rviGPzr7YVN8ZwKyURzu2AFIP61mXQvmwJRgmtu8chSQNJxqEBt?=
 =?us-ascii?Q?U6QpXYb3cVcottkHYZRwuqHbi1clh+uGLH/7mYUPABly0sHmgbgN7Al1Plv9?=
 =?us-ascii?Q?mKtxbzRS5HCv1/iJVvdxMwv3DBXNJQWjm5o4d3pWOHOQ9DvUeNhYwJ72pWtX?=
 =?us-ascii?Q?27LTUeQL7NmEjLw3GfxpbTgPyNU6RnVgDA7AAySQ5bbn6t4pMkcT5pprMGf4?=
 =?us-ascii?Q?pMyjU0rEoCdQrzMQ=3D?=
X-Microsoft-Antispam-Message-Info: ul/zPH2J8teEn7GTcsh99UBRh9RQGLC1UH1kafqeTnH2vjEYPGKqrDQmeRrc/fDdeCfqi1b+tEAd+j73zpq20yIb78cB5UKo0dfutgQiOYrnjEvDgnsf6IIHwMxhwXtRmRd4hRtAKeC5GBVOs51vRO0ZyA7lzbC24CVhY9Pm/22VvE2O73XciEtiz7iQNcTYvimzWDIXDaawwmFFEP9+dHyKbJBiMUb6ijQqTWgIGDQiXKpZYG9TNGohO+6GantAUAGqAzUCz1AouOSKtQL3BK5YyLp5d+geoUM/LFvSAd51KgxHkJa0j1SYq67zpTN+vq9eVhPBVQXaAeCtjw0kDVzQUlIWkYmpwbroiaPs5JbOk5pWztsPBFN2eO6IPOdWKWl77yKq5Cc8lEuK99kgqg==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;6:XfZBOej3SXN8lbuzj6wL4Rj2v0FV61mZhckoTalSI7lUFVYJv7lyHXCgDNlgAsTMzPFphA3Y61lg1arfE7Yg1SHmAWX+2y8tvD9cdao8bBDTuwwE4vrHS68mVMy8SdJb2e5h84zry/rFFcTrLjmlYfBn84ArpAzzMMZr+gF/+BnQg8XVCszXwC2qLdeq5ecKwFqrnX3bljy0GphaBCoJe5YenNRI/htkFp1tUtqpCSmZQpF8LIMmZqOMdBbl0F+wLevvCZ94WjgzmNdgxanRcBBOfOOLnlDO1f+aQhm1+U+ThMjhSFDh+jnrkEexvshdeq5cnOnycewJDXV2dyaneA1wF9cTClfweAew5KiU56l4Dg38DTEaf3gwY1ocxCYcDagjauP2hnodVvoZj4ut8icyh1u6/01RMvKn8DMV9fgZftlIiEp3gdJZeA2P7Mlev9YOpN90u/rxcmoQmtVh8Q==;5:ahLK75uRr90XVhHErYAyAar7OoYKkvVX99SW1J+JztLdDgo1lToQxVkyfheN8e2SMf/RuFkwRDZuGG0hYhHhWUOxwdUGoKeXg/PMCp/ejydmJZCY6NG06AD3XJaErU1kIKsZ1zmDLWe7FQkOAvK0cvvUHsLefMO7FIRNXE1yQEo=;24:5vusMJKWuyhKvDmTBbdn7Ao4qLZDDQO6XinOffyf4sBmEkStg2lx8OuMC6LeX8zu8EwcEluR9QGSpk+/tePjHUzZhrUgdJ981KekSXQAxVI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;7:oZ48jZWS8sZ0swSOi+kHB+tlR7QvxLOeX/XOsz2M+c061q2BD5KJPEI3bQGIYRbjlgno6i0+bV3a0tEOv5ZL+4YQvj0RgnjMIm4j0OsF2C3EQr0TUpluoXkZqUyD54n5EiGSmUfUVUFP/Ypbg8JJfNIbqw5Lao02sDj3IxnNcHiV0KwotG71koTAw89pwA2QngRyrmP4P1SRsUxW57x8VD2BHR1CnsHY/bXJMhmAbQlQvt/L2ffmWJVxWZ7HZRrf;20:s5C+NAyvzAVBwkk/U0b38Is8+8D5dXA54XZQIJ5CmZcrdyXF1aDl2RJASmA5nOGa9WbPLmagBZtElRAPOMdCxFKb05CS5q6u+W6stEeMrbaQ753lacMDF2dbCgsCPfhbtXKFaxciX4Hd8J1SeRdqt9ktZrOiuRT7fJ++SzIttAundfRgBh/HoJVcaxd1Pe8e+H1m697F7zsAjajjTTVpgcdH8MlgpFM7V7/lEGXsV5GNsq5ToETQF1PPDcwFR1Oq
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:16.7112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9372d3c-877f-43ca-f076-08d5eda1587c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1338
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add generic function used for handling rings in driver.

USBSSP controller use three types of ring:
 - command ring - is used for handling commands. In this case driver
			is producer and HW is consumer.
 - event ring - ring for reporting events to driver. In this kind of
			ring HW is producer and driver is consumer.
 - transfer ring - ring used for queuing transfers. In this case
			software is producer and hardware is consumer.

Driver has only single event and transfer ring, but it uses many of
transfer rings. Each endpoint has own transfer rings.
If endpoint use streams than have many transfer rings for such endpoint.

Each ring can contain segments and each segment contains
Transfer Request blocks (TRB). The set of elements create
Transfer Descriptor (TD).

For more information please refer to XHCI specification.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c | 433 +++++++++++++++++++++++++++++++-
 1 file changed, 432 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 11bbf18dacba..06a59febbff2 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -18,6 +18,347 @@
 #include "gadget.h"
 #include "gadget-trace.h"
 
+/*
+ * Allocates a generic ring segment from the ring pool, sets the dma address,
+ * initializes the segment to zero, and sets the private next pointer to NULL.
+ *
+ * "All components of all Command and Transfer TRBs shall be initialized to '0'"
+ */
+static struct usbssp_segment *usbssp_segment_alloc(struct usbssp_udc *usbssp_data,
+						   unsigned int cycle_state,
+						   unsigned int max_packet,
+						   gfp_t flags)
+{
+	struct usbssp_segment *seg;
+	dma_addr_t dma;
+	int i;
+
+	seg = kzalloc(sizeof(*seg), flags);
+	if (!seg)
+		return NULL;
+
+	seg->trbs = dma_pool_zalloc(usbssp_data->segment_pool, flags, &dma);
+	if (!seg->trbs) {
+		kfree(seg);
+		return NULL;
+	}
+
+	if (max_packet) {
+		seg->bounce_buf = kzalloc(max_packet, flags | GFP_DMA);
+		if (!seg->bounce_buf) {
+			dma_pool_free(usbssp_data->segment_pool,
+				seg->trbs, dma);
+			kfree(seg);
+			return NULL;
+		}
+	}
+
+	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
+	if (cycle_state == 0) {
+		for (i = 0; i < TRBS_PER_SEGMENT; i++)
+			seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
+	}
+	seg->dma = dma;
+	seg->next = NULL;
+
+	return seg;
+}
+
+static void usbssp_segment_free(struct usbssp_udc *usbssp_data,
+				struct usbssp_segment *seg)
+{
+	if (seg->trbs) {
+		dma_pool_free(usbssp_data->segment_pool, seg->trbs, seg->dma);
+		seg->trbs = NULL;
+	}
+	kfree(seg->bounce_buf);
+	kfree(seg);
+}
+
+static void usbssp_free_segments_for_ring(struct usbssp_udc *usbssp_data,
+					  struct usbssp_segment *first)
+{
+	struct usbssp_segment *seg;
+
+	seg = first->next;
+	while (seg != first) {
+		struct usbssp_segment *next = seg->next;
+
+		usbssp_segment_free(usbssp_data, seg);
+		seg = next;
+	}
+	usbssp_segment_free(usbssp_data, first);
+}
+
+/*
+ * Make the prev segment point to the next segment.
+ *
+ * Change the last TRB in the prev segment to be a Link TRB which points to the
+ * DMA address of the next segment. The caller needs to set any Link TRB
+ * related flags, such as End TRB, Toggle Cycle, and no snoop.
+ */
+static void usbssp_link_segments(struct usbssp_udc *usbssp_data,
+				 struct usbssp_segment *prev,
+				 struct usbssp_segment *next,
+				 enum usbssp_ring_type type)
+{
+	u32 val;
+
+	if (!prev || !next)
+		return;
+	prev->next = next;
+	if (type != TYPE_EVENT) {
+		prev->trbs[TRBS_PER_SEGMENT-1].link.segment_ptr =
+			cpu_to_le64(next->dma);
+
+		/*
+		 * Set the last TRB in the segment to have a TRB type ID
+		 * of Link TRB
+		 */
+		val = le32_to_cpu(prev->trbs[TRBS_PER_SEGMENT-1].link.control);
+		val &= ~TRB_TYPE_BITMASK;
+		val |= TRB_TYPE(TRB_LINK);
+		prev->trbs[TRBS_PER_SEGMENT-1].link.control = cpu_to_le32(val);
+	}
+}
+
+/*
+ * Link the ring to the new segments.
+ * Set Toggle Cycle for the new ring if needed.
+ */
+static void usbssp_link_rings(struct usbssp_udc *usbssp_data,
+			      struct usbssp_ring *ring,
+			      struct usbssp_segment *first,
+			      struct usbssp_segment *last,
+			      unsigned int num_segs)
+{
+	struct usbssp_segment *next;
+
+	if (!ring || !first || !last)
+		return;
+
+	next = ring->enq_seg->next;
+	usbssp_link_segments(usbssp_data, ring->enq_seg, first, ring->type);
+	usbssp_link_segments(usbssp_data, last, next, ring->type);
+	ring->num_segs += num_segs;
+	ring->num_trbs_free += (TRBS_PER_SEGMENT - 1) * num_segs;
+
+	if (ring->type != TYPE_EVENT && ring->enq_seg == ring->last_seg) {
+		ring->last_seg->trbs[TRBS_PER_SEGMENT-1].link.control
+			&= ~cpu_to_le32(LINK_TOGGLE);
+		last->trbs[TRBS_PER_SEGMENT-1].link.control
+			|= cpu_to_le32(LINK_TOGGLE);
+		ring->last_seg = last;
+	}
+}
+
+/*
+ * We need a radix tree for mapping physical addresses of TRBs to which stream
+ * ID they belong to. We need to do this because the device controller won't
+ * tell us which stream ring the TRB came from. We could store the stream ID
+ * in an event data TRB, but that doesn't help us for the cancellation case,
+ * since the endpoint may stop before it reaches that event data TRB.
+ *
+ * The radix tree maps the upper portion of the TRB DMA address to a ring
+ * segment that has the same upper portion of DMA addresses. For example,
+ * say I have segments of size 1KB, that are always 1KB aligned. A segment may
+ * start at 0x10c91000 and end at 0x10c913f0. If I use the upper 10 bits, the
+ * key to the stream ID is 0x43244. I can use the DMA address of the TRB to
+ * pass the radix tree a key to get the right stream ID:
+ *
+ *	0x10c90fff >> 10 = 0x43243
+ *	0x10c912c0 >> 10 = 0x43244
+ *	0x10c91400 >> 10 = 0x43245
+ *
+ * Obviously, only those TRBs with DMA addresses that are within the segment
+ * will make the radix tree return the stream ID for that ring.
+ *
+ * Caveats for the radix tree:
+ *
+ * The radix tree uses an unsigned long as a key pair. On 32-bit systems, an
+ * unsigned long will be 32-bits; on a 64-bit system an unsigned long will be
+ * 64-bits. Since we only request 32-bit DMA addresses, we can use that as the
+ * key on 32-bit or 64-bit systems (it would also be fine if we asked for 64-bit
+ * PCI DMA addresses on a 64-bit system). There might be a problem on 32-bit
+ * extended systems (where the DMA address can be bigger than 32-bits),
+ * if we allow the PCI dma mask to be bigger than 32-bits. So don't do that.
+ */
+static int usbssp_insert_segment_mapping(struct radix_tree_root *trb_address_map,
+					 struct usbssp_ring *ring,
+					 struct usbssp_segment *seg,
+					 gfp_t mem_flags)
+{
+	unsigned long key;
+	int ret;
+
+	key = (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
+
+	/* Skip any segments that were already added. */
+	if (radix_tree_lookup(trb_address_map, key))
+		return 0;
+
+	ret = radix_tree_maybe_preload(mem_flags);
+	if (ret)
+		return ret;
+
+	ret = radix_tree_insert(trb_address_map, key, ring);
+	radix_tree_preload_end();
+	return ret;
+}
+
+static void usbssp_remove_segment_mapping(struct radix_tree_root *trb_address_map,
+					  struct usbssp_segment *seg)
+{
+	unsigned long key;
+
+	key = (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
+	if (radix_tree_lookup(trb_address_map, key))
+		radix_tree_delete(trb_address_map, key);
+}
+
+static int usbssp_update_stream_segment_mapping(
+					struct radix_tree_root *trb_address_map,
+					struct usbssp_ring *ring,
+					struct usbssp_segment *first_seg,
+					struct usbssp_segment *last_seg,
+					gfp_t mem_flags)
+{
+	struct usbssp_segment *seg;
+	struct usbssp_segment *failed_seg;
+	int ret;
+
+	if (WARN_ON_ONCE(trb_address_map == NULL))
+		return 0;
+
+	seg = first_seg;
+	do {
+		ret = usbssp_insert_segment_mapping(trb_address_map,
+				ring, seg, mem_flags);
+		if (ret)
+			goto remove_streams;
+		if (seg == last_seg)
+			return 0;
+		seg = seg->next;
+	} while (seg != first_seg);
+
+	return 0;
+
+remove_streams:
+	failed_seg = seg;
+	seg = first_seg;
+	do {
+		usbssp_remove_segment_mapping(trb_address_map, seg);
+		if (seg == failed_seg)
+			return ret;
+		seg = seg->next;
+	} while (seg != first_seg);
+
+	return ret;
+}
+
+static void usbssp_remove_stream_mapping(struct usbssp_ring *ring)
+{
+	struct usbssp_segment *seg;
+
+	if (WARN_ON_ONCE(ring->trb_address_map == NULL))
+		return;
+
+	seg = ring->first_seg;
+	do {
+		usbssp_remove_segment_mapping(ring->trb_address_map, seg);
+		seg = seg->next;
+	} while (seg != ring->first_seg);
+}
+
+void usbssp_ring_free(struct usbssp_udc *usbssp_data, struct usbssp_ring *ring)
+{
+	if (!ring)
+		return;
+
+	trace_usbssp_ring_free(ring);
+
+	if (ring->first_seg) {
+		if (ring->type == TYPE_STREAM)
+			usbssp_remove_stream_mapping(ring);
+		usbssp_free_segments_for_ring(usbssp_data, ring->first_seg);
+	}
+
+	kfree(ring);
+}
+
+static void usbssp_initialize_ring_info(struct usbssp_ring *ring,
+					unsigned int cycle_state)
+{
+	/* The ring is empty, so the enqueue pointer == dequeue pointer */
+	ring->enqueue = ring->first_seg->trbs;
+	ring->enq_seg = ring->first_seg;
+	ring->dequeue = ring->enqueue;
+	ring->deq_seg = ring->first_seg;
+
+	/*
+	 * The ring is initialized to 0. The producer must write 1 to the cycle
+	 * bit to handover ownership of the TRB, so PCS = 1. The consumer must
+	 * compare CCS to the cycle bit to check ownership, so CCS = 1.
+	 *
+	 * New rings are initialized with cycle state equal to 1; if we are
+	 * handling ring expansion, set the cycle state equal to the old ring.
+	 */
+	ring->cycle_state = cycle_state;
+
+	/*
+	 * Each segment has a link TRB, and leave an extra TRB for SW
+	 * accounting purpose
+	 */
+	ring->num_trbs_free = ring->num_segs * (TRBS_PER_SEGMENT - 1) - 1;
+}
+
+/* Allocate segments and link them for a ring */
+static int usbssp_alloc_segments_for_ring(struct usbssp_udc *usbssp_data,
+					  struct usbssp_segment **first,
+					  struct usbssp_segment **last,
+					  unsigned int num_segs,
+					  unsigned int cycle_state,
+					  enum usbssp_ring_type type,
+					  unsigned int max_packet,
+					  gfp_t flags)
+{
+	struct usbssp_segment *prev;
+
+	/*allocation first segment */
+	prev = usbssp_segment_alloc(usbssp_data, cycle_state,
+			max_packet, flags);
+	if (!prev)
+		return -ENOMEM;
+	num_segs--;
+
+	*first = prev;
+	/*allocation all other segments*/
+	while (num_segs > 0) {
+		struct usbssp_segment	*next;
+
+		next = usbssp_segment_alloc(usbssp_data, cycle_state,
+				max_packet, flags);
+		if (!next) {
+			prev = *first;
+			/*Free all reserved segment*/
+			while (prev) {
+				next = prev->next;
+				usbssp_segment_free(usbssp_data, prev);
+				prev = next;
+			}
+			return -ENOMEM;
+		}
+		usbssp_link_segments(usbssp_data, prev, next, type);
+
+		prev = next;
+		num_segs--;
+	}
+	usbssp_link_segments(usbssp_data, prev, *first, type);
+	*last = prev;
+
+	return 0;
+}
+
 /**
  * Create a new ring with zero or more segments.
  *
@@ -32,10 +373,100 @@ static struct usbssp_ring *usbssp_ring_alloc(struct usbssp_udc *usbssp_data,
 					     unsigned int max_packet,
 					     gfp_t flags)
 {
-	/*TODO: implements function*/
+	struct usbssp_ring *ring;
+	int ret;
+
+	ring = kzalloc(sizeof *(ring), flags);
+	if (!ring)
+		return NULL;
+
+	ring->num_segs = num_segs;
+	ring->bounce_buf_len = max_packet;
+	INIT_LIST_HEAD(&ring->td_list);
+	ring->type = type;
+	if (num_segs == 0)
+		return ring;
+
+	ret = usbssp_alloc_segments_for_ring(usbssp_data, &ring->first_seg,
+			&ring->last_seg, num_segs, cycle_state, type,
+			max_packet, flags);
+	if (ret)
+		goto fail;
+
+	/* Only event ring does not use link TRB */
+	if (type != TYPE_EVENT) {
+		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
+			cpu_to_le32(LINK_TOGGLE);
+	}
+	usbssp_initialize_ring_info(ring, cycle_state);
+	trace_usbssp_ring_alloc(ring);
+	return ring;
+fail:
+	kfree(ring);
 	return NULL;
 }
 
+void usbssp_free_endpoint_ring(struct usbssp_udc *usbssp_data,
+			       struct usbssp_device *dev_priv,
+			       unsigned int ep_index)
+{
+	usbssp_ring_free(usbssp_data, dev_priv->eps[ep_index].ring);
+	dev_priv->eps[ep_index].ring = NULL;
+}
+
+/*
+ * Expand an existing ring.
+ * Allocate a new ring which has same segment numbers and link the two rings.
+ */
+int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
+			  struct usbssp_ring *ring,
+			  unsigned int num_trbs, gfp_t flags)
+{
+	struct usbssp_segment *first;
+	struct usbssp_segment *last;
+	unsigned int num_segs;
+	unsigned int num_segs_needed;
+	int ret;
+
+	num_segs_needed = (num_trbs + (TRBS_PER_SEGMENT - 1) - 1) /
+			(TRBS_PER_SEGMENT - 1);
+
+	/* Allocate number of segments we needed, or double the ring size */
+	num_segs = ring->num_segs > num_segs_needed ?
+			ring->num_segs : num_segs_needed;
+
+	ret = usbssp_alloc_segments_for_ring(usbssp_data, &first, &last,
+			num_segs, ring->cycle_state, ring->type,
+			ring->bounce_buf_len, flags);
+	if (ret)
+		return -ENOMEM;
+
+	if (ring->type == TYPE_STREAM)
+		ret = usbssp_update_stream_segment_mapping(
+				ring->trb_address_map, ring, first,
+				last, flags);
+	if (ret) {
+		struct usbssp_segment *next;
+
+		do {
+			next = first->next;
+			usbssp_segment_free(usbssp_data, first);
+			if (first == last)
+				break;
+			first = next;
+		} while (true);
+		return ret;
+	}
+
+	usbssp_link_rings(usbssp_data, ring, first, last, num_segs);
+	trace_usbssp_ring_expansion(ring);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_ring_expansion,
+			"ring expansion succeed, now has %d segments",
+			ring->num_segs);
+
+	return 0;
+}
+
 struct usbssp_container_ctx *usbssp_alloc_container_ctx(
 					struct usbssp_udc *usbssp_data,
 					int type, gfp_t flags)
-- 
2.17.1

