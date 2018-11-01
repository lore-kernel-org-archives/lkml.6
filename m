Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1341C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711A52064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R0GLUfl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711A52064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeKBE07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 00:26:59 -0400
Received: from mail-hk2apc01on0101.outbound.protection.outlook.com ([104.47.124.101]:27552
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbeKBE06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 00:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpkClCmeDgGVkTDEix+AQza3TDdSVYpakaDkL31PuNM=;
 b=R0GLUfl8HSzKEgqSxpSpIyzJGLnPcvbxOI5f4CvZJVL268ScFTmxIdSSpu1IsnuuyyRdpM85Ykm+iKpWe5R33l6gFFdjTq13wq6O8bujy1HWvmINa6WNbigQXycKrqsJlcWonAWVQi7nPnk2LTMZ6l/eYAgtoZbgt9QIIazht4A=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.2; Thu, 1 Nov 2018 19:22:28 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217%3]) with mapi id 15.20.1294.014; Thu, 1 Nov 2018
 19:22:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: RE: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Thread-Topic: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression
 caused by incorrect clean-up
Thread-Index: AQHUZqDqbasvay7PwkmlHkiKerM2nqUukUpwgAuBcqCAAUk+AIAABlNQ
Date:   Thu, 1 Nov 2018 19:22:28 +0000
Message-ID: <PU1P153MB01690D11050FBDACD205EC6EBFCE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
 <20181018050932.27932-3-kys@linuxonhyperv.com>
 <CY4PR21MB077329FE239A11054FFDD661D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
 <PU1P153MB0169588D48E567E0551D4A9FBFCD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181101185638.GB10263@kroah.com>
In-Reply-To: <20181101185638.GB10263@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-01T19:22:23.8798584Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:f:c92a:8324:9e1c:a5e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0155;6:RrNEyOgy5EX4GgyOHrUvv3OF45WSFOumMjp7ttwUh/AQISiusTdbuqx8U9/JGm+v0d2zvL0lOBiJ2ydN+7I/swjYU01my586el+COmT3BUufbH1tVWbuOez4z2b9Avu1N2rOOtKoNwnnf0A0PDoG4pSKTwRH3eBMH4T2fOvAV9xm2wYtiooBViLES5qN/PFV+btXJRUTP3k4GsoF13rc0Vr8jU+NkubHVHPuac/BX4Xoo/RsZYv6Li5ynfQnleMYr9w7ptbOKw+761qNDb41RujHlyvroKPO/IcTT+/wBz3p5uLoY/uWABs1E1E61xiII8iFk9tyHz/I1Qsg0rp1oNo3L8ErY/61iwBMs1uM16VqIDdU0temZSZjA98vDKbQO7B89nBw+mlfrf/fK2A1t9TGigu+X/W5ISdmgW16c++HhwNLFwZXScY3fLU+02RZqCtAe3BB5nIjt72zlwSEBA==;5:8NQfnnwOAZyIbr7ReEc/zIJu+LRhcviRrzgRQy0e9s8gP2CWfpZiuos6Y1Ih+jJZwFCpXPXyAYaZ75ULQPyPTPguwMIjzA9k70kNijDrQV/sxJ8kXnTdRjPUWTcyb5S9qnvH5hQ/9/iEAUm7NW1/WiagM+ra8Zcd2NmAbIP1YFM=;7:qmi60kx58W8W9uyq4P5CqIAP3I5A0Xec4OdvH2o96ABMw4l8BVwRm2bU5a0bNyU5Ixa5YGwp7WSZ7ibn2ufYjUqS5V2FKxtBfahtPQn2K7gwL64ZXMli387xtJu3A8suJiqt8xV3bO+RGT5qo/lw6A==
x-ms-office365-filtering-correlation-id: 7ffd34a0-452f-434f-a6b4-08d6402f5cdc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0155;
x-ms-traffictypediagnostic: PU1P153MB0155:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0155C2A2F1D9CAABD75CF4A1BFCE0@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0155;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0155;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(346002)(366004)(189003)(199004)(93886005)(6436002)(8936002)(102836004)(54906003)(4326008)(53936002)(9686003)(256004)(6916009)(2906002)(5640700003)(7696005)(5660300001)(478600001)(76176011)(99286004)(14454004)(2900100001)(97736004)(55016002)(6246003)(1730700003)(8676002)(33656002)(81166006)(229853002)(10090500001)(81156014)(71190400001)(71200400001)(6506007)(53546011)(2351001)(86362001)(186003)(86612001)(6116002)(105586002)(22452003)(106356001)(8990500004)(10290500003)(316002)(6346003)(74316002)(486006)(11346002)(5250100002)(25786009)(476003)(446003)(46003)(68736007)(305945005)(2501003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-microsoft-antispam-message-info: 6QUMuZ9pP3wtJ/bRCz3oRzEQtnu7AKqcmuKi6n74IlQfgFxq2ZYXEQCs9DvJ6iaE9VqZSFqpL01yjkDYBogHfXPVlu157lfQax2+q29RfYGiAxs+5hJ1rso9nHOcjcrj5HpsV4l9CguyKYJAS8XCb8/eIdoyN0PvKkt0Mvxf5mEDo0hdAP2Gfkn+ad1mms+AQ77c33ma74WrUcmKxUDtzE8tPuUzgsv5RK1p7r+CsdazqvtAQPtX3InIDMlF7OP4jz67Ya9P2ibsBd6mfzvroxAjMLFM7/4U3INzdDv2yyG01cRYPL+v1eWE08q2Pb/Z7wup3UYa/wg4GFsNfQCjzx6eefov9wDKz/DJn6stmkY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffd34a0-452f-434f-a6b4-08d6402f5cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 19:22:28.1246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Thursday, November 1, 2018 11:57
> To: Dexuan Cui <decui@microsoft.com>
>=20
> On Wed, Oct 31, 2018 at 11:23:54PM +0000, Dexuan Cui wrote:
> > > From: Michael Kelley <mikelley@microsoft.com>
> > > Sent: Wednesday, October 24, 2018 08:38
> > > From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent:
> Wednesday,
> > > October 17, 2018 10:10 PM
> > > > From: Dexuan Cui <decui@microsoft.com>
> > > >
> > > > In kvp_send_key(), we do need call process_ib_ipinfo() if
> > > > message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns
> out
> > > > the userland hv_kvp_daemon needs the info of operation, adapter_id
> and
> > > > addr_family. With the incorrect fc62c3b1977d, the host can't get th=
e
> > > > VM's IP via KVP.
> > > >
> > > > And, fc62c3b1977d added a "break;", but actually forgot to initiali=
ze
> > > > the key_size/value in the case of KVP_OP_SET, so the default key_si=
ze of
> > > > 0 is passed to the kvp daemon, and the pool files
> > > > /var/lib/hyperv/.kvp_pool_* can't be updated.
> > > >
> > > > This patch effectively rolls back the previous fc62c3b1977d, and
> > > > correctly fixes the "this statement may fall through" warnings.
> > > >
> > > > This patch is tested on WS 2012 R2 and 2016.
> > > >
> > > > Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may=
 fall
> > > through" warnings")
> > > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > > Cc: <Stable@vger.kernel.org>
> > > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > > ---
> > > >  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
> > > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > > >
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> >
> > Hi Greg,
> > Can you please take a look at this patch?
>=20
> Nope, I'm not the hv maintainer, they need to look at this and ack it,
> not me :)
>=20
> greg k-h

Hi Greg,
KY has added his Signed-off-by in the mail.

I'll ask the other HV maintainers to take a look as well.

Thanks,
-- Dexuan
