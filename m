Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E212DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA46220874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iYovzmZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbeLQSoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:44:24 -0500
Received: from mail-eopbgr1300095.outbound.protection.outlook.com ([40.107.130.95]:10714
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbeLQSoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f10RJtOVnZKrSu2aNrcIST9hw4rjJLDfayOIpah62wA=;
 b=iYovzmZi5PPj8kYAYdzQ+QqHRnl3S05Wrfs8RLZz9msTlBRaVOXlC9QYZj5zy+y0HM/MVOJFuMtpI0KRSapLgYcheay60HoEdFp8FVtiCsjHdQAHDx3VFcsPfnhuzwof3QIELPe9W4Q5U9OcrFm/KQrGOc0SKF8dpUlUuoa/Sb0=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0105.APCP153.PROD.OUTLOOK.COM (10.170.188.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.4; Mon, 17 Dec 2018 18:44:13 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%6]) with mapi id 15.20.1471.004; Mon, 17 Dec 2018
 18:44:13 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files for
 unopened channels
Thread-Topic: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files for
 unopened channels
Thread-Index: AdSSumYR+EFelO/iSCugbWbDq9Br5wDcbnsAAAFGcVAAAN72gAAAc6qAAABYKKA=
Date:   Mon, 17 Dec 2018 18:44:12 +0000
Message-ID: <PU1P153MB0169F16082CBD9FD9F0457B1BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181217091518.5004d4c7@xeon-e3>
 <PU1P153MB0169725E468897F135F2155BBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181217101703.78e8bb3f@xeon-e3>
 <PU1P153MB016981FD2D1CF90635DCE562BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB016981FD2D1CF90635DCE562BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-17T18:31:12.5119722Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:2:3cb9:7d38:c591:f3ce]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0105;6:X8rbWWrY1cw7J5Y+aSSuikE3rLOUByaMusk2D/0K6qEirI50b5T0+J6rmpXsv6qIcW749DD/Cb5ySZ2pfLj4VfqNsnK0P3IrHY91LrC0IR7/5N5Vgo+3Fp7OZO2tdGauDepNapHwLZurfawPiZv3hHbf4Yx7CkbyqzuoquyIIbIsL/qBL1xdmZahpbdyDbzT96Wo6bwVjguRCC/ckXlrnhhzGGNq4nidmGdyZ1t1FOa9TDtbBK0Ose+iO/CJl/wjbTdgvUol67EpVk1NcYaz0MS0e2J3JkLciDwxoHMH47CrHYwPXmFc1tMKaOd9ONfLaImFAVTrwh3g2WPpRwbieXb/oP6Yceinknr2jZcpFmKVP8PQOpbbpLFAkl8OoOP9XZZieYTvqdoCRdLwR8D83XcvLUQoSBux1m2RcwZtmBOM0EPCJekS/F+VcM8sp/3i4vnbAhhn8qiX369LNsxiXA==;5:qWLzICTFFczypPbzU0uaUy/Izddy0mL2t+xs2FPxwqLlvuXQc9E1/EGl95co45Ks00R4NVMsfk/MnooyWy3/csXg8lg4ArjaO5vcpJ8WVazDLkwrmkNEyyUNAENztwgvrTotMm+cXD5HQ3osUnNrNYjddkkQWQ2Fg5Beg8VKPXQ=;7:jtu1lV/RSAgZ4iYHwxH9+64l5MI1ECR2pGdsUYfPhjookrT2JKybGRN3gsfgpKcybh8XtK2SkZLJxSBPlGVgF0dbqm1E4v9oHQhG+Uapi2M7A9tgXt1XgBavQetMKTiL/8h28wjn9izj9Hs27tI/nQ==
x-ms-office365-filtering-correlation-id: 95ad44be-07f1-4b96-f0e0-08d6644fa3ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0105;
x-ms-traffictypediagnostic: PU1P153MB0105:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01052513CE17A2F67D5C644EBFBC0@PU1P153MB0105.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(2017102700009)(2017102701064)(6040522)(8220035)(2401047)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0105;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0105;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(68736007)(6436002)(10290500003)(55016002)(74316002)(14454004)(9686003)(97736004)(5660300001)(106356001)(6246003)(53936002)(446003)(11346002)(4326008)(6916009)(256004)(86362001)(46003)(305945005)(7736002)(86612001)(186003)(6506007)(7696005)(33656002)(8936002)(2940100002)(93886005)(22452003)(81156014)(81166006)(8676002)(105586002)(316002)(102836004)(54906003)(76176011)(25786009)(6116002)(2906002)(6346003)(10090500001)(486006)(8990500004)(478600001)(229853002)(99286004)(71200400001)(71190400001)(476003)(93156006);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0105;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-microsoft-antispam-message-info: 8SjOFUa5eBTll8lwHydnmxZzchJJCC3LNhMrqz0VI6xkvfc+WhLbBNFPD1sh3Q5kzCPuSG4L01zlxFSnsJcQwweTSOwj43PIAR3bWQmmKuG81BbL+gMfEki9AdgRwwm8KLl50YEIxeJzDXAjf3CxwcQ1C9Fxf8ZkP3bRWk2kY/Mso4WnC0A+f6DdHeAh9uQJ9asJZGRwnTicX/uflEsb+lf1nI5Ibi44mHbnElCmaJ3Gv7OaJ3PpwmI1lyJoraPcIwuzouGCCT7vW+d5wz12ywHVNlWegx8lMfhN6iOS/wozFaNsXCmui3nSCLohDbwV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ad44be-07f1-4b96-f0e0-08d6644fa3ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 18:44:12.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> Dexuan Cui
> Sent: Monday, December 17, 2018 10:31 AM
> > From: Stephen Hemminger <stephen@networkplumber.org>
> >
> > The old code was risky because it would silently return stack garbage.
> > Having an error check in get_debuginfo would eliminate that.
>=20
> OK, then let me make another patch based on the latest char-misc-linus.
>=20
> -- Dexuan

Hi Stephen, your patch can apply cleanly. Let me rebase your patch to
char-misc-linus, do a test, and then post it with your Signed-off-by and mi=
ne:=20
I assume you're Ok with this. Please let me know in case it's not. :-)

Thanks,
-- Dexuan
