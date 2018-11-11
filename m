Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD9AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B58F214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QPZ7Jb+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B58F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeKKOFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:05:44 -0500
Received: from mail-eopbgr1300097.outbound.protection.outlook.com ([40.107.130.97]:62150
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727037AbeKKOFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpnEb4WeLHWw2Gdge9EARKFlhj8K042z1Ab8QD6O/TM=;
 b=QPZ7Jb+CuIlZmgMpeftK5kmQMz8Z1fNNuX1zk0X5LAEAFRcrECscxKgAEuVST130V/7DWYtSGOcrebQrwbfNdKa2CqEX3xu1SHr4XHbm3aWaXjqitALehTAbCo9TcSLbdlLQrPvwwvl4bqyNoKMJv1IV1IvtZ/rhbVtIMaW9zCU=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.1; Sun, 11 Nov 2018 04:18:03 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b%8]) with mapi id 15.20.1361.000; Sun, 11 Nov 2018
 04:18:03 +0000
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
Thread-Index: AQHUZqDqbasvay7PwkmlHkiKerM2nqUukUpwgAuBcqCAAUk+AIAABlNQgACgpICADhpNgA==
Date:   Sun, 11 Nov 2018 04:18:03 +0000
Message-ID: <PU1P153MB0169705E20DB757385F3C98BBFC00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
 <20181018050932.27932-3-kys@linuxonhyperv.com>
 <CY4PR21MB077329FE239A11054FFDD661D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
 <PU1P153MB0169588D48E567E0551D4A9FBFCD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181101185638.GB10263@kroah.com>
 <PU1P153MB01690D11050FBDACD205EC6EBFCE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102045412.GB11843@kroah.com>
In-Reply-To: <20181102045412.GB11843@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-11T04:18:02.1553205Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:547e:90cc:f252:ead6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0172;6:/fWfHwtECUZjWf99mmEA1z/umMW3s9V7oRy91f3YTQrDwyoE1mmXC6YSdNz540vExP2bIpkE7wwIQ/O8b4zyvnMgfU8949bugHT7/buYxZoQNth8SPhGmVBe74pe8iEjCZ6PmJ8Ior4sR8o8wcaLE+WDnDJ3eOyS7F5ZqbWFKTxJDq/EtStFFIFXM1Nw2nNROmSeCcKNtREOVHt9IdqIv/6zM6kj/8/1wODJc++Oclx7bQ6XciG1Zso+o9fXN8BwrYF2ArLUAt6L/zYMEnKLX3p6uG3Zkad/ERyytoQOuCkRh0qFFRRz5rwW48wjRKuyK+D1NMQJJL/67WQNqFKDSiaTWwIg7qjquCgHAeKxE5fLkJLuLdi9jI4+TKCnolShqpIxF1jaPVAmzJD7rSgP8FMPjG2vU1Rr4cd8Az3nX8NQne31qrOebp3LNBglWx3Hfn6WPfp565Xk8QSrNSMwzw==;5:7dT3S0pLL/8HjBsvBWQKONheFjo2F00mCpd3pPQUayKibEDjNlo35hrLkU+EYBIid3AP+sGHUNbdeBK1LRdCinUxj3sAyQPIpUOKr8IzFtgJ0vbqTrWjReEpZ04XUFw6bCcZS+6xQv1JitLsy2t4j7fgamdq5mHJQFeMg2yPvvI=;7:5uFpfupR/UF/TUwR2cnZSFSg8cqolDfh5/0/Rz14ObRQO7HMvMoKcqMHW08m1+ZEGz+KNueokY5KXB7cLPFpGLm9UEshK9XFxx/zTtEZ8o7IT+SHxfqC/4BkcY+V5DOr3B+a+LARp6z48P/HnJ/iKQ==
x-ms-office365-filtering-correlation-id: c4d2e0a7-d7c7-4648-f317-08d6478cacb3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0172;
x-ms-traffictypediagnostic: PU1P153MB0172:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB017297C9A027F10537B31D50BFC00@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231402)(944501410)(2018427008)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0172;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0172;
x-forefront-prvs: 08534B37A7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(14454004)(102836004)(8990500004)(6506007)(53546011)(8936002)(6246003)(81166006)(81156014)(1730700003)(8676002)(7696005)(54906003)(33656002)(76176011)(46003)(10290500003)(6916009)(99286004)(4326008)(5660300001)(256004)(2906002)(71190400001)(86362001)(71200400001)(86612001)(97736004)(6116002)(2501003)(105586002)(106356001)(476003)(486006)(2900100001)(478600001)(186003)(93886005)(229853002)(446003)(11346002)(68736007)(6436002)(2351001)(5640700003)(25786009)(316002)(55016002)(10090500001)(7736002)(74316002)(305945005)(22452003)(53936002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o4FQd6UcI/ZZsgVMWvQX2kJeNc1f4kJnO3TDip5HfVDE33bLLke0WDEOY336M3MV10bpRXqmGskvW344MuV0/Nc3bu80KSe5W7DYXort1VGrQISwWwXBjmfCCVIi1RKEhmplb0nz67L7Ec9NxvRuQV3VpDx+7aN2qeVlbNdaqv418r2/KCwEez/p3V4mgv9vakZPQeXFoe5SOPMwV0IyZhvpA9P2UkEfWl8trD4hEPA2PdTGj8zRgHujzNkgAJ8u0sYTHW0FBQNV7WgaP0ONer9QoGFBSSDPtmoFLlm5VUUeJ5v0eoc+wSKlUULujxtp7I8ArMedP1UgXvaDjtJHk2cEe6lzMjMbMHECu7awQN8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d2e0a7-d7c7-4648-f317-08d6478cacb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2018 04:18:03.4509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Thursday, November 1, 2018 21:54
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; Stephen Hemminger <sthemmin@microsoft.com>;
> vkuznets <vkuznets@redhat.com>; Sasha Levin
> <Alexander.Levin@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> Stable@vger.kernel.org
> Subject: Re: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression c=
aused
> by incorrect clean-up
>=20
> On Thu, Nov 01, 2018 at 07:22:28PM +0000, Dexuan Cui wrote:
> > > From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> > > Sent: Thursday, November 1, 2018 11:57
> > > To: Dexuan Cui <decui@microsoft.com>
> > >
> > > On Wed, Oct 31, 2018 at 11:23:54PM +0000, Dexuan Cui wrote:
> > > > > From: Michael Kelley <mikelley@microsoft.com>
> > > > > Sent: Wednesday, October 24, 2018 08:38
> > > > > From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent:
> > > Wednesday,
> > > > > October 17, 2018 10:10 PM
> > > > > > From: Dexuan Cui <decui@microsoft.com>
> > > > > >
> > > > > > In kvp_send_key(), we do need call process_ib_ipinfo() if
> > > > > > message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it
> turns
> > > out
> > > > > > the userland hv_kvp_daemon needs the info of operation, adapter=
_id
> > > and
> > > > > > addr_family. With the incorrect fc62c3b1977d, the host can't ge=
t the
> > > > > > VM's IP via KVP.
> > > > > >
> > > > > > And, fc62c3b1977d added a "break;", but actually forgot to init=
ialize
> > > > > > the key_size/value in the case of KVP_OP_SET, so the default ke=
y_size
> of
> > > > > > 0 is passed to the kvp daemon, and the pool files
> > > > > > /var/lib/hyperv/.kvp_pool_* can't be updated.
> > > > > >
> > > > > > This patch effectively rolls back the previous fc62c3b1977d, an=
d
> > > > > > correctly fixes the "this statement may fall through" warnings.
> > > > > >
> > > > > > This patch is tested on WS 2012 R2 and 2016.
> > > > > >
> > > > > > Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement=
 may
> fall
> > > > > through" warnings")
> > > > > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > > > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > > > > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > > > > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > > > > Cc: <Stable@vger.kernel.org>
> > > > > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > > > > ---
> > > > > >  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
> > > > > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > > > > >
> > > > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > > >
> > > > Hi Greg,
> > > > Can you please take a look at this patch?
> > >
> > > Nope, I'm not the hv maintainer, they need to look at this and ack it=
,
> > > not me :)
> > >
> > > greg k-h
> >
> > Hi Greg,
> > KY has added his Signed-off-by in the mail.
> >
> > I'll ask the other HV maintainers to take a look as well.
>=20
> Ok, then I'll look at it after 4.20-rc1 is out, nothing I can do until
> then anyway...
>=20
> thanks,
>=20
> greg k-h

Hi Greg,
Can you please take a look at the patch now?

The patch has received

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

Thanks,
-- Dexuan
