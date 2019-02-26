Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBDD20842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oVE1rVB6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DV7Awl5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfBZK7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:59:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25197 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZK7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551178755; x=1582714755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Wq91PxsHvxkpz9+drH+iQRz38I93zjI+nkASQ2RS44=;
  b=oVE1rVB6p5kFa9yH9uv07vCi5EOrwxXIVMb9nGaDwB7JbO4kHKmEVAfW
   pSiYE9EIb57YuYe0jdZjCRLdZQhqVp1b0C7/mosPTjJ2k4PsamoxV09wA
   pmJywWfALK4ew+WxvgoHKz9++hiPNsunPnyuTh+8S1vvWjh7nri3dOfIu
   MeYrcxlXbbSHWJEV9DiJOLNZSZdibBhzCgiVOQUWNevmGewNJDbeGDXKy
   YlxLyyDBu3w4FyQeFQfxbDBfg8smXoknKnWUacaZTuLT3Orjt00y49lXb
   plaaoGAA9kijoymq8LTSl9J+tW5gv7w4oc+I9Un843uT5n9VOw2plgW1R
   w==;
X-IronPort-AV: E=Sophos;i="5.58,415,1544457600"; 
   d="scan'208";a="107155716"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2019 18:59:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qfuzyXwp1tgwWrGFqTh/IslFs76QmkYQJyjGdZ6pMk=;
 b=DV7Awl5b09AAg44kIdn6A8Mnh6QDwncTMnu+Hu0zVfQjbhXfpxGFrlW+WOn3buSTw6CDpF42Yd+c1KF8ZzxHTuiiykAhPuu07BJctT4DFWHSIRq4DGMTWfQbDYFlcRetHHMRvAJqcL5QYxadtE86zVkTeeK8zjWJnRGdz21DAWM=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB5247.namprd04.prod.outlook.com (20.178.6.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 10:59:11 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 10:59:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: RE: [REPOST PATCH v4 0/3] scsi: ufs-bsg: Add read descriptor
Thread-Topic: [REPOST PATCH v4 0/3] scsi: ufs-bsg: Add read descriptor
Thread-Index: AQHUyOuHY+OrkkrmmEC9jJX6JX78PqXx8kQQ
Date:   Tue, 26 Feb 2019 10:59:11 +0000
Message-ID: <SN6PR04MB4925DC77A8727791B07EA648FC7B0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1550646674-15258-1-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1550646674-15258-1-git-send-email-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00718957-21dc-4bfa-e40a-08d69bd97088
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB5247;
x-ms-traffictypediagnostic: SN6PR04MB5247:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB5247;23:1rDq8muXe7XRdp1ZGjT4Xp5aNGLYetuu8hCF1hcjV?=
 =?us-ascii?Q?iFdfF4syVIw5xAxmPlJ/pZbNAXWVtqz2LP68DMiURflHQWRtd8yt/6R3sHR8?=
 =?us-ascii?Q?UMztAzGJYMkkAxXxqtRYlMjdpoQCUW+HDUYwlUWQsP0TFSIkh9EvV1I1wGW6?=
 =?us-ascii?Q?aJiZxThJTtqp7FSwgHRGF5DBlrLZR5NE0s2wvMrCA6NNUuUDqfnL4aYwfcyY?=
 =?us-ascii?Q?2ho+BzqjY1i/SNoJ2ir2bq4Rpsqh8+tkeZDuEmrtH8ChHxt8tLcECrYpinza?=
 =?us-ascii?Q?DBOpwyK2K7cLdYAZpLXJrqNcXx8CLC4G8jH1QRifeA7dzEWuYt098tqzKw1N?=
 =?us-ascii?Q?Y6eG9Y78eGyNS4kHt/iLYnrnfRQvp+UjtwebULDQsLICT093lsse/1w7p0mI?=
 =?us-ascii?Q?qMLttFwxVpz7KU6qhDhEeGqXtf7s8gqpOkigIKc4AmVXbW6Mo/FeVQ0Kcp/T?=
 =?us-ascii?Q?9+3ZVaKgYcqmW92ELq8MsqnTmdmWDnY2IsE1ncUbJlJa1mcvWYwwxjYEBA/U?=
 =?us-ascii?Q?C1kjMnOeO8SqXr1TmrLywmM3Ollpr1Ma02hSAhwtR2SE2zyscQnatqTvvpxi?=
 =?us-ascii?Q?EEU36CF+vV+HgJa/1hc1JUqPCMXVukGOwnY9WRMUQqYnQClz131tHzPXbR5A?=
 =?us-ascii?Q?P5RggzO3QPwGpEAT8LWoXCWXNCzLB65IdH7c7+Mmhz0aZA8gq27qdwWVU6O0?=
 =?us-ascii?Q?5JibIJNr3jF+aWwG6hGSuj+XT25vsiBFs6bSZ10+UvYSmtJb/EdvLroTZCTS?=
 =?us-ascii?Q?IWNabMDD5R5dpVtpnb4H43i2LRXMlFmzd4J5LHCaa9NDnLw2DLdmWcDCOVRU?=
 =?us-ascii?Q?1+8AR+S0rbpcRqVtvcN7o8OcY/vbbk8yAKwyOyRsbs6QzATJ4Ysn0uCPbZcn?=
 =?us-ascii?Q?PlPu1xIw3VwzNSaQEBbq/TmKw4F5UFgjHoarJqrJR5DXIuu/h1Fp85HmRaT3?=
 =?us-ascii?Q?qaJ0RhN38nPYJ1F+bRTWuLt5lT6vsu2LeqJI/ZrnzrtjuS9qmZ6jCryqVOWC?=
 =?us-ascii?Q?oNfdAarqqMYpENOKfVDcGxaRSq9AOLmDm4+L0Wtem4+xtDInNZHtFWo0cKo5?=
 =?us-ascii?Q?FMgrG8nhGB012O3rsBxHI8PgE59eJItXUfKHZbjdj3bwP/TJ0XWpUMf76NTv?=
 =?us-ascii?Q?dyJoRmPinHkZpIukERZkMoSznGtRoG1HpGuq/tfxmm3fkcht2lsR9w4+CYGV?=
 =?us-ascii?Q?Pp0XHfa2uW+OPbeqi97WzET9xaABMQ+FgIu0k3CSUUhbJRkfx/hScBYtf7Le?=
 =?us-ascii?Q?b/6/U+HPIRatCymw+WjCDvEAB6je2/ZfZtScD/FSA73mN72b3sOSoKUshCC7?=
 =?us-ascii?Q?frlmiRztC+xAqmt4W2oMWc=3D?=
x-microsoft-antispam-prvs: <SN6PR04MB5247937C2E84B308A1E7C3B6FC7B0@SN6PR04MB5247.namprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(14454004)(81156014)(81166006)(8676002)(11346002)(256004)(14444005)(4326008)(99286004)(446003)(6246003)(5660300002)(229853002)(72206003)(476003)(6116002)(3846002)(8936002)(486006)(305945005)(2906002)(55016002)(74316002)(7736002)(966005)(6436002)(478600001)(9686003)(68736007)(97736004)(66066001)(6346003)(102836004)(6916009)(106356001)(25786009)(6506007)(86362001)(6306002)(76176011)(186003)(105586002)(33656002)(54906003)(7696005)(71190400001)(71200400001)(26005)(53936002)(316002)(52536013);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5247;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8uPQMFur1FS5KPthGc1V8fEgqkOFkwpzuX8gLKfr07ChR5fK0slmkdhIlN6t9UOpxuf9+f/JnU4g8xwT7mcWZIttISsKDhtdvUNcnXbAH7LzVdKuB2eZ6zn1hmgyLSQBBLmAy07zzqmrXWZWxowHHiF3w6kNLOB1InTIiwOFuM4khHvEnbD6RaRBNoiRyB1wH5EnGzD1OS+sc8iatFjLZmDrHuSJZpHr7z8XNKvef0IUof7DwMxstUX5Jg221AZUsA7LpfKjaz5g9l+xbTJwGvAvagikJsXbCH53u0ix6wZ7C31FcslSLtN70DPcrLTcZSiObU4xVtDJ0fwgv4oIGXd+nyEAXTwF85gE1XqBHX9asK31UxKbidRx5rjehGj/83UBPP5vn/sB9mIWYVb6wzo35fulTHQqBHyrADyySLk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00718957-21dc-4bfa-e40a-08d69bd97088
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 10:59:11.6080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,
Any further comments concerning this series?

Thanks,
Avri

>=20
> UFS Protocol Information Units (UPIU) are UFS packets that travel
> between the host and the device on the UniPro bus. Our previous series
> added the capability to send UPIUs to the ufs driver. It does not cover
> all the possible UPIU types - we are mainly focused on device management,
> provisioning, testing and validation, so it covers UPIUs that falls in
> that box.
>=20
> Our intension is to publish ufs-utils soon - an open source user space
> utility that relies on that infrastructure to perform those tasks.
> This short series is adding one last functionality needed by ufs-utils
> that was somehow left behind - allowing reading descriptors as well.
>=20
> Repost of v4 and adds tags already received.
> While at it, it turns out that quite a few people are waiting for
> ufs-utils, e.g. https://www.spinics.net/lists/linux-scsi/msg127807.html.
> So I expect that the small, but vibrant community of ufs users, will try
> to expand this infrastructure even further.
>=20
> V3->v4:
> Improve code readability in ufs-bsg: Allow reading descriptors
> Update Reviewed-by tag.
>=20
> V2->v3:
> Add a prep patch with write descriptor calling convention changes.
> Elaborate the commit log of ufs-bsg: Allow reading descriptors
> Add Reviewed-by tag.
>=20
> v1->v2:
> Withdraw from the attempt to change the reply buffer, instead place the
> descriptor being read in the actual data buffer in the bio.
>=20
> Avri Altman (3):
>   scsi: ufs-bsg: Change the calling convention for write descriptor
>   scsi: ufs: Allow reading descriptor via raw upiu
>   scsi: ufs-bsg: Allow reading descriptors
>=20
>  Documentation/scsi/ufs.txt | 11 ++++++++
>  drivers/scsi/ufs/ufs_bsg.c | 63 ++++++++++++++++++++++++++--------------=
----
> --
>  drivers/scsi/ufs/ufshcd.c  | 20 ++++++++++-----
>  3 files changed, 61 insertions(+), 33 deletions(-)
>=20
> --
> 1.9.1

