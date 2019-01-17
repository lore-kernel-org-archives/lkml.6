Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AA2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5580F20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GcjqJnPL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aJKtIVa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAQIO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:14:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53421 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfAQIO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547712897; x=1579248897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=APwytAAQYo1w/N+BixohA/Yz6VjUOs0vPLH/EQ5+ZeU=;
  b=GcjqJnPLfLR81+6ykdutTPzQTnNDyjeaDZyUUrViNmw0FNsOPkVqEJ25
   bQeADsbQdwNyuyTAw1uECV5qIEFbN+238AorvHHMdjc0vXKqhm/VO3gYQ
   kvgVDEwRcGRX420dxTY8rWLGeMkUqPrG7mSJg2SG0U6iOXdXAYXwjR4ol
   /dD7CyVPwhWreQFtNBlEA+9qosF6AxBqGateXLKKlRlxOZVKr75un5mXu
   KTH5tRjdn9B0SZepAze5h2UvvGxzitVrH0AxdueVvWkbGFc/rxKHMP8/h
   n/qfO3g4dMrGHtpAuqeg7MEaUd1Xut7E3DqFR/5jAWuH6yQQQsACIuGjN
   g==;
X-IronPort-AV: E=Sophos;i="5.56,488,1539619200"; 
   d="scan'208";a="103963872"
Received: from mail-co1nam05lp2053.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.53])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2019 16:14:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4RuHo+GB8sEdJa9pj4vzXwmyU3Ggkidjfvok3vCaZQ=;
 b=aJKtIVa+Tmk5hSQs5tYPP87nvWaXINK4zTe0j2U7UY9rpMYV4J0stYTC3AAAfo8B72FCBnMv6WVIckZg3tVrH/QGEQ/c468MURB3S9lXWJTqOXiBzq7qVdhcgQLiCSz5Pkjli8JQNF38IxVz0ZsPc0pY0uqMajDbHiNsz4110eM=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4688.namprd04.prod.outlook.com (52.135.122.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Thu, 17 Jan 2019 08:14:55 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d461:bbc2:b03a:d4b0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d461:bbc2:b03a:d4b0%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 08:14:54 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: revamp string descriptor reading
Thread-Topic: [PATCH] scsi: ufs: revamp string descriptor reading
Thread-Index: AQHUkToZe4SsRaGsKUGoSCcHYz8eo6V5tOmggANuPoCANi0vAIAABlzg
Date:   Thu, 17 Jan 2019 08:14:54 +0000
Message-ID: <SN6PR04MB492505EFD15BB09BDC0A4D80FC830@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20181211110705.11646-1-tomas.winkler@intel.com>
 <DM6PR04MB4923D16D47784A1750811A19FCA60@DM6PR04MB4923.namprd04.prod.outlook.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA525B5@hasmsx108.ger.corp.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA7C91D@hasmsx108.ger.corp.intel.com>
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA7C91D@hasmsx108.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4688;6:3D+36FAOeLITeqo92boi7YCCNui9INCV4G3zddtvR5Ni4JMOGIp6mtQpNLUR/L69gHtE4D3+zDX7wZwlDmIrHGVnCetjatQEohldkE4O10669XWuLytLYjLjET+NkDhNnIsBKOXun++ZzYTH+z3FTjxALBCgDKiB9dwyIDC6JqG7qvoNDNz5PVjzt8jijeAoB9trwJhWmpNVzzh4cMZw3Dttu+B3xGNQ6hBZYeFLd1tVc4UVsKYi0BYc9lupf0jLNo/bBqJ2Yt4L4S2US0nfa3Ht4a1GAm6fVUriMnfQIqafeya3Lml2BGogRaeGSOOiGcLnw29UtAi9b+F52rJ5xal8SnjMJbHmghl3op909MaTvCab0YgC71iaWYAT6g64OaWP9USQ2RYTloPegSaU7FxV2IWsf25nb6eZWV+FZ6Xovoq5rFQIDK5AmITT8oHksuZjY6X1z9wEsuylRp++/g==;5:LBAwl7wS6R6RENzX3iOdv/1n+kQga/2LMzkYf6P9lh5c0cnq7VpXxc7PVdfGHyxSBdCQHfagLiQi1RvV5sGwciUrEaMVihKSPNOhxE0Rv45yzfEb8W+CfMqi6FzE7ws7dJlxRFFN1i0cGpi2oS89P30JMppneDfidpE4Gz4LNjCteUS3DqvjoWSUYU7KjShMEgIJG9EVeNm3NBCfMg0E2A==;7:ETPEb7ZEbFNk4+kOSo4HbK/LWB3KN7CA0NgNFRxTgE0t2IoeaDzavsFks9rxp8Iru4J1LORq9rwvgg8emU19ON+H8KqH+9kDWt/L/h2rdRFPdsT0jZj0h6ZCIiZhGEtw30EebutomxgPdR0DdsSCBQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 8c3dc87c-cbaf-4d72-c151-08d67c53dcb9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4688;
x-ms-traffictypediagnostic: SN6PR04MB4688:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB46883CF8A5C7F11E0B43B2F5FC830@SN6PR04MB4688.namprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(136003)(346002)(189003)(199004)(8936002)(39060400002)(6436002)(55016002)(86362001)(486006)(105586002)(53936002)(81166006)(81156014)(97736004)(99286004)(3846002)(5660300001)(6116002)(8676002)(6246003)(9686003)(106356001)(4326008)(93886005)(316002)(14454004)(74316002)(33656002)(68736007)(71200400001)(71190400001)(446003)(11346002)(476003)(2906002)(6506007)(76176011)(7416002)(26005)(102836004)(7696005)(229853002)(7736002)(25786009)(66066001)(305945005)(72206003)(110136005)(256004)(186003)(54906003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4688;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qpmd+YunBeShNo7TSNkSwM+3Ml0fkADlsTL+1INB+DznwAcLzs01x4YT7izHKA6iixFU1MYGlMvtbNibYLFVEeMJ7Asil5fW6L+ls9hVnT6DQfjuoz2LS1/dbAj2dK/mPKmS/1dGWNjr7ibHSPX7HsIjPY+dAYgWMjUl3xzk2Vx45bvrw+a2rsPPZ0jpYHBzbTU07yH2Mr804VBsLcmuJHc16pt65vrbz78F4PSZUDpHKfi+PxDJ1wFmicws53gGrudqOJNyO4nsqfMg6oVgVGU73jIYFvkybWXtE9rLlm54aRjhGSYHzNm7yGHu5r5PiLZKY0wO+yvqS3+bkydjBClENU7v480deZW+0bipUo8qUt2E4LQd1eRiyDNGljVvNZnRrPD631R2gWprovtL4ahad87G/RCrScL2XaYG2Ic=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3dc87c-cbaf-4d72-c151-08d67c53dcb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 08:14:54.5734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> > > Hello Tomas,
> > >
> > > >
> > > > Define new a type: uc_string_id for easier string handling and less
> > > > casting. Reduce number or string copies in price of a dynamic
> > > > allocation.
> > > >
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > Tested-by: Avri Altman <avri.altman@wdc.com>
> > >
> > > Just one nit - doesn't really matters.
> > >
> > > Cheers,
> > > Avri
> > >
> > > > ---
> > > >  drivers/scsi/ufs/ufs-sysfs.c |  20 ++---
> > > >  drivers/scsi/ufs/ufs.h       |   2 +-
> > > >  drivers/scsi/ufs/ufshcd.c    | 164 +++++++++++++++++++++----------=
----
> > > >  drivers/scsi/ufs/ufshcd.h    |   9 +-
> > > >  4 files changed, 115 insertions(+), 80 deletions(-)
> > >
> > >
> > > >
> > > >  	ufs_fixup_device_setup(hba, &card);
> > > > +	ufs_put_device_desc(&card);
> > > ufs_get_device_desc() and ufs_put_device_desc() actually serves the
> > > quirks setup.
> > > Make sense to call it from within so the logic is clear and in one pl=
ace.
> > > Might also save ufs_put_device_desc().
> >
> > You are right from the current perspective , just I'd need it also for =
the
> RPMB
> > patches that should follow, then it will have bit larger span than the =
quirks.
> >
>=20
> Is this okay, can we merge?
Looks good to me.

Thanks,
Avri

> Thanks
> Tomas

