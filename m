Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AFB2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a1CVsMBX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B6WhHsSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AFB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbeLKQSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:18:32 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35042 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeLKQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544545110; x=1576081110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M7eLCe13ghoaAxoj06FChGZGWdmA1XMDfk2f6pSjQW4=;
  b=a1CVsMBXdh8amICdQz4p0blYNYFCb6/Q/XaCGfs1e7BBGuVufKC4zUhB
   0Xmht0dPRMo5gd07kH2UZGdmVwXgvLWBDDkXZDQu9vBmo7iAq6oMCWRek
   uZW51Uj324GqFDbdVw+RWoOiOUryF25egImlalr6Otl4Hu/URtzUVjf71
   sVR+mcAYlMyO/pspAPxT3OXE4uE1stQWQKG5rJ2KGYIoIPB0PAtcAYYno
   785mSnpwlNUf620WORZ619K0+lckLrmXHm81ue3NRiDE/9lKSKih0rhhI
   uLBY2rL3eX01Q2hTYLpoQ1A1/MNWEDjGzDQIMw1gGydgNAD5Zet12wwW8
   w==;
X-IronPort-AV: E=Sophos;i="5.56,342,1539619200"; 
   d="scan'208";a="96331037"
Received: from mail-by2nam01lp2051.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.51])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2018 00:18:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV7RirUOqLRvxXV3TdY7Fa2baZnkF3hO+RQUpvOm7xI=;
 b=B6WhHsSSoQZL/lhSKfEJXpeyRhTZ0bAP9W+6by8VQ2wwokCZL79Xv99hf2OCcdd4kpUwlDG0Lq0hrDLoioknI8k9pxMGHFJYDY1MHNyOXfK9ngm9UdAD8w3XMAqKYjzYzOGkdF+WJS3DQ7YLFjNzOfOTx+EP5T9LS1VmiuzD1yU=
Received: from DM6PR04MB4923.namprd04.prod.outlook.com (20.176.109.84) by
 DM6PR04MB4986.namprd04.prod.outlook.com (20.176.109.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 11 Dec 2018 16:18:27 +0000
Received: from DM6PR04MB4923.namprd04.prod.outlook.com
 ([fe80::2cbd:3bf1:18eb:228d]) by DM6PR04MB4923.namprd04.prod.outlook.com
 ([fe80::2cbd:3bf1:18eb:228d%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 16:18:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: revamp string descriptor reading
Thread-Topic: [PATCH] scsi: ufs: revamp string descriptor reading
Thread-Index: AQHUkToZe4SsRaGsKUGoSCcHYz8eo6V5tOmg
Date:   Tue, 11 Dec 2018 16:18:27 +0000
Message-ID: <DM6PR04MB4923D16D47784A1750811A19FCA60@DM6PR04MB4923.namprd04.prod.outlook.com>
References: <20181211110705.11646-1-tomas.winkler@intel.com>
In-Reply-To: <20181211110705.11646-1-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR04MB4986;6:rPYAAMg9fzDYg0DMRM1skaEm7EX+BxdACJV4afaMq5OgAs+/tJj3ymdebzTKDBDQgp29gWX12KxNE1oQxNzVQfcHGX/KZ4/aVwD8XUIPSGrbbn22WRULFsq1VJ9EfU3oL2BTcw0ZFsTnsYxbZVBE+hBSCpLCqztYcKV7D9zlPPNuSl8Y48GBBCuC2/xUlDWA2MzzjnDi8emG1nlMllvyYk/Hdst3Z4r9o3jqHpDM40fWyqRxr/1q3siBDONPcoQ6l49llna8NEThGaimeYcE6jCv9kASFhtLMWdBwNH5FxaVNNRkaN7Oymrfm2GbUqWni0QqNV5GspOB3lUx/LnuTRHeEAuzLRMlvIHy4wkXw9pBTrK4qv4V6C2TihQgByrMh9GP7lQpX5pzO9AHVYr0wCkOnrk4jDpWyq1hnaP9ez7wCZcIOZTciiG5gnwd9hEGDi/13VxOwo09P1t4RFmtGg==;5:nVy0YE6JDXDvHUd+81b59eEVzklnmdNWeu8+JK3PIJ7JHljj6xg7UTZ/32nwC+lt4e7kuOK9Y+KHtYFPp76ppvNZY/4WtEI1lQ4al6sGCMMOcRH3l39I5/fSMn3YiJWA76+U9rzpZtpYb0GyG1lj/AiGi426SX38OHWkDUnjLAk=;7:PlMF5TUwBcD4WV+P5pUY8Dg0qh0p61OCt7WRVrXtVx/Uou2sp45q2KeoqIsKsEj0ce/iSmiKfpjoTihy4AYqiBuDlJR95rfxdeYCBJbKuUEubi1wpg+trBf00bFikONhee9aFM7cDXT8mvpUkMjoLQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: aa419fa2-aee7-4ee1-9969-08d65f844852
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB4986;
x-ms-traffictypediagnostic: DM6PR04MB4986:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB4986C16D0E87E0B2C5C649FFFCA60@DM6PR04MB4986.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR04MB4986;BCL:0;PCL:0;RULEID:;SRVR:DM6PR04MB4986;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(486006)(71200400001)(97736004)(74316002)(86362001)(66066001)(81156014)(8936002)(316002)(8676002)(81166006)(102836004)(54906003)(99286004)(305945005)(105586002)(186003)(6436002)(26005)(476003)(14454004)(2906002)(7416002)(6506007)(76176011)(53936002)(229853002)(4326008)(25786009)(478600001)(72206003)(55016002)(106356001)(256004)(446003)(11346002)(6116002)(3846002)(71190400001)(9686003)(6246003)(110136005)(5660300001)(7736002)(68736007)(39060400002)(33656002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4986;H:DM6PR04MB4923.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: s4OWEXRB6i5/BHEscAvpzK4JBPgHoU1xWb5FbnQCTiL2sO/c05xUGyyaHk3y7nAtG3s/4brW8cO3MtPgfLhUSD7yLVhB1UmC8Xxwkr91UoyrCZBW9PUjNnGYrzC1eoKG9PGUFA3vK2eU8aZPH5CdZrx9vvZMmhhCS+hBA1+KXM+NtEjnwmMSHda0AY7Fcrfe6ySgmwfb/4zWR9M/TuKSxJbr3H+SsddhNytsdNWDwlDAERXRQwNEzrddTrMb6Ycinh1X0/0r/HL1LbRVoiDNBTY1NXl1bARjnTbiEklT5XU0n+N6V9e3NT3NgrIMAtQ0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa419fa2-aee7-4ee1-9969-08d65f844852
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 16:18:27.2487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tomas,

>=20
> Define new a type: uc_string_id for easier string
> handling and less casting. Reduce number or string
> copies in price of a dynamic allocation.
>=20
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Tested-by: Avri Altman <avri.altman@wdc.com>

Just one nit - doesn't really matters.

Cheers,
Avri=20

> ---
>  drivers/scsi/ufs/ufs-sysfs.c |  20 ++---
>  drivers/scsi/ufs/ufs.h       |   2 +-
>  drivers/scsi/ufs/ufshcd.c    | 164 +++++++++++++++++++++--------------
>  drivers/scsi/ufs/ufshcd.h    |   9 +-
>  4 files changed, 115 insertions(+), 80 deletions(-)


>=20
>  	ufs_fixup_device_setup(hba, &card);
> +	ufs_put_device_desc(&card);
ufs_get_device_desc() and ufs_put_device_desc() actually serves the quirks =
setup.
Make sense to call it from within so the logic is clear and in one place.
Might also save ufs_put_device_desc().
