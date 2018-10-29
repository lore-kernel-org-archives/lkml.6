Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35414C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E301220824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FzGYLRBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E301220824
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeJ3FGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:06:47 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:36187
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbeJ3FGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaUACPcL/dyplk0PMoBupA/KN4dnBkYF6jUh9z5JHxo=;
 b=FzGYLRBOIWDnuclAbv1Tqv5V71pPzkQG/tTJ4vRiKtjqhgSAeoa5yrGwOuMX0BAOfll5BgUfPAo13+dG6OyVGVXL2rdyd+2FG1lrzldSEXSP4rJVzhxIwKaWMpRmWHdQRYSmXXWmDdthSiqm9zwhyFpU4TVCVulh87ZZL4FlbyA=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.4; Mon, 29 Oct 2018 20:16:30 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb%8]) with mapi id 15.20.1294.014; Mon, 29 Oct 2018
 20:16:30 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Choose CPU based on allocated IRQs
Thread-Topic: [PATCH] Choose CPU based on allocated IRQs
Thread-Index: AQHUanM/SeOs7Q7r6USMZx47e/faSKU2s0IA
Date:   Mon, 29 Oct 2018 20:16:30 +0000
Message-ID: <CY4PR21MB0773D8F02354E91BC4711E03D7F30@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181023014044.15888-1-longli@linuxonhyperv.com>
In-Reply-To: <20181023014044.15888-1-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-29T20:16:29.1299072Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:f:50cc:f2af:fc37:b75]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:siugKeWNWyIii9z+y2cXpWw6Bq4UcYTXU5YyRC/uL26ZIYXmyrQ1CBnu1YpZ2/NUYygrUoCmJS8jncG6YNCeZ0ydepRaUD9hRxlDOXANaWcjKpUNdOblYM1SrunnguKWPBz3wum6O9yL9EGCHm4aCUDDCiOqsjMUTVA2Z5aSl16O5jQ9LaSZ/4pG896NQbtA3mwdu/eal0P4Giwz/nw4C00meAdv0Z65ucMUyEebmqSW7GtGC1by794hA1VCYjc2bUh1AfNGWm8PTYk5W1wiw4sM1kusJtFVHcUTBijbV0KnsG/jMa+RDUQ/kgp5QAWP1wTPQTMjP/zroEji3x3Wa0ZtDLuFgl/3ooT5fEQv7AcLFVGWF4+bmsxPjRcX/LDpQJewHULovvv7Uqfr6EcwTDsKNmHZ39QF/cnIivLKxs7BXAFffYTmnVo/3Udpm7WCsOyshsgJT14KB4eU47Whpw==;5:TvBb1eUZNWL81DhKrZdgaNvn3ImEa/IwAb34ZyHntd8Scfr87NOn+2x5cdYxkFrvJLmI3brQkLJ1qjgDpSsyqwJ9mYJj0RAbAW4w1VLrRV/9yOp06y5CZ6Bm9tadiP3lSZ8ZHuO/WZNgS762FZ2RNy1o+XpWn5+xgXUSbMsybEg=;7:GIo9KCYHbx1d75lcMRy93h1/XNDSRUw73/RpDie9wH5n0WyYOTwOvDj7oaMfHa3qW4VVegCs2LTcwy5qq26DshSuHoA0xllh0pMJ/XM9A6Et7kKnQvc2TbRIWPx4FtAFDwOfXRDkmCtFTGem/G9/fg==
x-ms-office365-filtering-correlation-id: 5e11ca22-3f86-43bc-871c-08d63ddb6a41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774036F0D442A30E121595BD7F30@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220027)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(105586002)(106356001)(7736002)(9686003)(478600001)(7696005)(102836004)(76176011)(33656002)(55016002)(97736004)(14454004)(6346003)(99286004)(46003)(53936002)(186003)(68736007)(10290500003)(6506007)(6116002)(486006)(74316002)(305945005)(2501003)(11346002)(10090500001)(71200400001)(5250100002)(110136005)(6436002)(2900100001)(22452003)(316002)(446003)(25786009)(476003)(71190400001)(2906002)(86612001)(229853002)(8936002)(8990500004)(81156014)(256004)(81166006)(6246003)(5660300001)(86362001)(8676002)(1511001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-microsoft-antispam-message-info: rcfmSmTAtHH/AENVAb3ICgzwMv+2Axsxo2skLLPeG9q6INYIhzuDiZ4JRLZ5eWuuUHaVvJRLwRsk60jbaFk6Vs2DZdHq2uGdlmabLRKDKonSeIV+GL/1P/hmoWzJHxW4fbxKwbdRz7XDEpfu9jfMIPfIonmBppQni8/FkQD3re7ryEYCRpbE4wNwEVUgvnDlRbNx6MpwjJYcgHu0yvw+RbNWHWc+gp0DfbBSaM8TFKmlIXOGNbwaKyT6McvVSLNOC4GAR5fz8MWU1QmRtgSykpVYwqIrqTY1peViqdC0UG2iLSaodKj2eXWW2f8gQJ6YOFt7zojBUQu6Ju7uGjijDm524nZhKEgxmW7YSw8J2LU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e11ca22-3f86-43bc-871c-08d63ddb6a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 20:16:30.7423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>  Sent: Monday, October 22, 2018 6:41 P=
M
>=20
> In irq_matrix, "available" is set when IRQs are allocated earlier in the =
IRQ
> assigning process.
>=20
> Later, when IRQs are activated those values are not good indicators of wh=
at
> CPU to choose to assign to this IRQ.
>=20
> Change to choose CPU for an IRQ based on how many IRQs are already alloca=
ted
> on this CPU.
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
