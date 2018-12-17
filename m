Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38672133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j/bhDRJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbeLQScO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:32:14 -0500
Received: from mail-eopbgr1300090.outbound.protection.outlook.com ([40.107.130.90]:4320
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbeLQScK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHgbi1ffnERLp7dKALGyHzlM18QxC/za1+FsSx3R774=;
 b=j/bhDRJvMUZKOUpX3SL9R0J1E7xeEj2iPIn9jf5rii0+WNtYJWpVpPvQbvFZqmy9CmiVP7WQgSMTqW1KE5ZMOhqasKpnvvC/CvTE9PbzkzQfpsSPPWH8Iq5ePn7VzG7WcHlbY3maFsfC9eSbcyGxFvTMm6xHu1uuJFTi2v9qfIc=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.5; Mon, 17 Dec 2018 18:31:16 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%6]) with mapi id 15.20.1471.004; Mon, 17 Dec 2018
 18:31:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
CC:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files for
 unopened channels
Thread-Topic: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files for
 unopened channels
Thread-Index: AdSSumYR+EFelO/iSCugbWbDq9Br5wDcbnsAAAFGcVAAAN72gAAAc6qA
Date:   Mon, 17 Dec 2018 18:31:15 +0000
Message-ID: <PU1P153MB016981FD2D1CF90635DCE562BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
        <20181217091518.5004d4c7@xeon-e3>
        <PU1P153MB0169725E468897F135F2155BBFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181217101703.78e8bb3f@xeon-e3>
In-Reply-To: <20181217101703.78e8bb3f@xeon-e3>
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
x-microsoft-exchange-diagnostics: 1;PU1P153MB0169;6:FZr6SIV4Po1yGUQTMAbp/jE8VThwRBpKHfKDdnJ3leGZaO8Ws9mSVf/Ksucp7ysDtIQfmsUh4Es+bAjggk2ZlspOMKAA/QWI87rEM3FHGxPJm1gTe+yJoqcd6EmV8gw0VHQnNvBcZtGgo3q2P8aBCkgVeG1RHJVV6guEV4AJSH66e8WdSe/qZp/ZYWXgIsxz+mC1sU673V+ATIE/YCz2K1pQfhhsHPLgs2VYKm8vT9F2bhQOngzht7ivz5nCIHhijUpLZfxvq4osVdkXF2N91/9a1eq0i0sww0xyZXvBtWe/sJZ6rX/sOBqIaa71DAP7a4yanGZkOOepQJlcBg/HtThyOALEKB3qBR4AqWUomsWxfr4rVNcrjOiklLzuhPxq1PeQtFN/S+JXSgYtlieZIolOpEjzexkI2wUSbssIMX/tKb8k9DzIvBX2CNWkPbPAomGK4nJ8HlaJVneKNl4i+Q==;5:SJrORGHbTlm0KCFsP2K/MqzoCjobBPVoK0Bp2QRHpwMUxZZAuycOXbMnriIVFixuC5ckR/LV04vW2MKeFM15zfs7igvTgtm892EiDOrR7V6pwJh1ZYc+TSUOZ4daM3utju6Dds3i8eOTiLGXE4Ti+kC70NwtI4ym6M52Y9B1Jro=;7:KMZZn/800xkTiEuxm8B/f4DQZHyvosXr4DZhUnxnMePrKeUgBu6BiwLYob2tXGL0abU9r8f5+ORWNqcUwA+8707a7u+HXcJxFTsIvjxiIS4N1dqVrRXZtxAIPci5LjfpG+2yS+Y6yH6+v45Y2Da7rg==
x-ms-office365-filtering-correlation-id: 013e8414-699b-4b8c-c401-08d6644dd4ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0169;
x-ms-traffictypediagnostic: PU1P153MB0169:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0169A40A6AA9555AAE02CA64BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(8220035)(2401047)(8121501046)(3231475)(944501520)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0169;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0169;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(7696005)(76176011)(68736007)(5660300001)(8936002)(54906003)(22452003)(305945005)(86612001)(74316002)(71200400001)(7736002)(316002)(53546011)(14454004)(6506007)(102836004)(106356001)(256004)(478600001)(86362001)(105586002)(97736004)(186003)(46003)(33656002)(486006)(25786009)(93886005)(476003)(55016002)(9686003)(11346002)(10290500003)(53936002)(446003)(10090500001)(6436002)(6116002)(8676002)(99286004)(71190400001)(81156014)(81166006)(8990500004)(229853002)(6246003)(2906002)(4326008)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0169;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NWPF0qj0RK+uDfwHXm+LsOhOZGA3wYROMcNVVyBsCIy1tZlPSuhp7HkAbBqSru1BV6xFT9ok4Of/ngfjZeR6lIxHvxuqPmnmfg0kE1u0HK+IT9xUYPIBJQX0PkxzfeizRYOR/j6AYOegTwYJ2tFgnYhRvqKFvaPeEjCKBktqW6yntHKDV2RXSjc8A3yPfYTMlmggncDMJTTn811y75YvJikqAREYT5GC5P86Ca7F8nHmDHLjnCErPJFagW+zSP4ux+91l48s/PZrOrMdQocoMCyg3qQHS/0+zHMOHt2zq0nHRRdeQFWIMXJq7E6hGwdg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013e8414-699b-4b8c-c401-08d6644dd4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 18:31:15.9213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, December 17, 2018 10:17 AM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> On Mon, 17 Dec 2018 18:00:29 +0000
> Dexuan Cui <decui@microsoft.com> wrote:
>=20
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > On Thu, 13 Dec 2018 16:35:43 +0000
> > > Dexuan Cui <decui@microsoft.com> wrote:
> > >
> > > > Before 98f4c651762c, we returned zeros for unopened channels.
> > > > With 98f4c651762c, we started to return random on-stack values.
> > > >
> > > > We'd better return -EINVAL instead.
> > >
> > > The concept looks fine, but maybe it would be simpler to move it into
> > > hv_ringbuffer_get_debuginfo and have it return an error code.
> > >
> > > Since so much of the code is repeated, I would probably make a
> > > macro which generates the code as well.
> > >
> > > Something like this:
> >
> > Thanks, Stephen! Now the patch has been in char-misc's char-misc-linus
> > branch, so IMO we may as well leave it as is (considering the code here=
 is
> > unlikely to be frqeuencly changed), and we have a smaller patch this wa=
y. :-)
> >
> > But, yes, I agree with you that generally we should make a common
> > function to avoid duplicate code.
> >
> > Thanks,
> > -- Dexuan
>=20
> The old code was risky because it would silently return stack garbage.
> Having an error check in get_debuginfo would eliminate that.

OK, then let me make another patch based on the latest char-misc-linus.

Thanks,
-- Dexuan
