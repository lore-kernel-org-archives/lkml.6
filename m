Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A509DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D02B2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qlL/zKiu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F6Vzy7tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D02B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeK0Cut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:50:49 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26855 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0Cut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543247778; x=1574783778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KSBzQCXg78d7ylzZC6znm6PxBxwICOIs5dd/8zhreDw=;
  b=qlL/zKiuXgghiAxSWsDxTvbIDAL5sZcc1MO+TmzJCa65HJ0UGDAhm0U4
   gm7TcrxgeikzRh2f8e8F/yxwnYZ94m3GwZ0UWo3HAOR3FfL3ITc7ZwAE9
   aavgDGblRUgKPVz78jBgougL8D9zfZcFN+QKrM60IRUhBr0KvtARg8h2V
   CYcSis3PX6oCliBpS0rrO23d4W6xs/NQPy/pDNNMTxIxQuTfnG/Tixih7
   KqOinenJ9eJDGi9Ga9hd5blTpBJXXP/s/R7reUejuuhEL6E1HpBikbMD6
   wT0Wvo1EaVaGu6K/mOGemgx3jFTYi7lYLJ2LVmmziUJt3th4OX2vNBBT+
   A==;
X-IronPort-AV: E=Sophos;i="5.56,282,1539619200"; 
   d="scan'208";a="199688958"
Received: from mail-co1nam03lp0024.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([216.32.181.24])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2018 23:56:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSBzQCXg78d7ylzZC6znm6PxBxwICOIs5dd/8zhreDw=;
 b=F6Vzy7tbMY/N6K6Ph96mshmcYL4i9/78aAjfnsbMGARq3mHz5QsNyhD55ra3uVNMtVUSA49uxLEXNm7ClHSBFTIvtPazGZ0NnF/0+x0oSlcbsj6OIkPTLVxIUqrR5TaRMf/7Vq/wzOL4TbbJE6TsNEumgoEsJUzExapm3ft35HE=
Received: from DM6PR04MB4923.namprd04.prod.outlook.com (20.176.109.84) by
 DM6PR04MB5451.namprd04.prod.outlook.com (20.178.27.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 15:56:16 +0000
Received: from DM6PR04MB4923.namprd04.prod.outlook.com
 ([fe80::ac55:8663:cdc6:ce4f]) by DM6PR04MB4923.namprd04.prod.outlook.com
 ([fe80::ac55:8663:cdc6:ce4f%2]) with mapi id 15.20.1339.027; Mon, 26 Nov 2018
 15:56:16 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: add fall through annotation
Thread-Topic: [PATCH] scsi: ufs: add fall through annotation
Thread-Index: AQHUhV+DuDuP1Pt4VEOxPX/P0UJsZ6ViNkJA
Date:   Mon, 26 Nov 2018 15:56:16 +0000
Message-ID: <DM6PR04MB4923C5B8A2F8190EFE4A3EEDFCD70@DM6PR04MB4923.namprd04.prod.outlook.com>
References: <20181126081034.30185-1-tomas.winkler@intel.com>
In-Reply-To: <20181126081034.30185-1-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR04MB5451;6:PNehV4UQUxcNT8medBsCVIm/8o6caLA8hl+wmmyTbqJnO+ZLIMxLbSu51nui4e0HbjKloWrFTLqcHI48CsTOXkmFsRaNJFI0no0wbngrEwkSObY7rkDC9Wc+bZKr/30J1vBjrPdNtHtizmNTT/pVKzemqSqOFcCU7Z0pcNYgQ4OddlNd9WRy6SUKUHLM6OkaK8I5OzBjhgn/groTln1FlWPHFtl2xVgln/NATvkF+Jnx/jCbJaFOWlyjUkJ0wgpTXsmjMId/aKwX4gXnakSutHu9G+B+Tvs1Koyd8WrBt5RwsqwcnrKJBy/QjpwTsVuzfz/AfVnjbz4Qqy3uYIjMBBsSh/BtvK4I4SxIHbo8ABUbFkYdHXvNDg2AhrjcC7JhT65rMwWz7aJQIYUh2N8tFy6NLrjimmrFXs1dJSAINDSqSMR4mGjTQal30ROe7qHtmZrSN5n7FB72LS8Fya2U+w==;5:EybSkO6WnVbmH6RUxzSG5n6tXWz2rk2liCi7iUQmiMTGnyj4SAB/853ahSGAi7F89c8nVcqWAkzo1ISDAIwXNHCr99N28PZ1oQOFTkLq5BusH495dvDsPAAGdHSVI/KkjqgTuecZRLxKvNE4xC2HyEV9iDwJdE3DTpDr/zX6SOw=;7:4MknB+lK/uwtzioCTFxL0EffOa1XwiMOB1km5ubmXZzzJ66eh28D9jXGGBIRNHlqF7YzjDEYofQtWpa8QA1HG1vHV1Poar6/6lwM9aUoTSaN6JVpIQstl1LdK2NeG11HONggocSaJnNjWbGdTfGQGA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1bb1dae5-f27d-4a7b-8e17-08d653b7b2be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5451;
x-ms-traffictypediagnostic: DM6PR04MB5451:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB545148150A5441740DD5E8ABFCD70@DM6PR04MB5451.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231443)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM6PR04MB5451;BCL:0;PCL:0;RULEID:;SRVR:DM6PR04MB5451;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(346002)(366004)(136003)(13464003)(189003)(199004)(6436002)(3846002)(6116002)(106356001)(2906002)(105586002)(54906003)(110136005)(316002)(478600001)(72206003)(25786009)(74316002)(97736004)(5660300001)(305945005)(7736002)(66066001)(68736007)(229853002)(14454004)(14444005)(39060400002)(26005)(256004)(7696005)(86362001)(186003)(99286004)(6246003)(8936002)(4326008)(81166006)(81156014)(6506007)(8676002)(53936002)(53546011)(33656002)(55016002)(76176011)(102836004)(71200400001)(9686003)(71190400001)(486006)(476003)(446003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5451;H:DM6PR04MB4923.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kGCAQs0HYHgkImqQoJxqfauid/I66wS/EZBBkxnvNbhdI0RLLWAaxIlURxbeFJBOv4A7Ss6BZeB4AG3D7LG7527ViXVu6k7+krJ79/nk17lCtx45OiY5MEzDvrNProAjoIqwplY22M5NPatY108Qf2kGDqYqjUcrzrmcLcYFTj2kfqKcgmKl1qwXeUcETmup782Q4JDojt+BF1NXrHGbgbvTryO7NZPzMlpkZECuyiVhxaIdU6oM5hPv9lqhQFGtAjWIX4N42PpD4UaNebMRwwJrfCMh+/ZvD78zzTdwCMqd5j1yUqJP+BTdsr7Fvozn8tfYclpBa/CGMa+g5/zKofx62OYsETTzR8rsjUKheBA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb1dae5-f27d-4a7b-8e17-08d653b7b2be
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 15:56:16.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tomas Winkler <tomas.winkler@intel.com>
> Sent: Monday, November 26, 2018 10:11 AM
> To: James E . J . Bottomley <jejb@linux.vnet.ibm.com>; Martin K . Peterse=
n
> <martin.petersen@oracle.com>; Vinayak Holikatti
> <vinholikatti@gmail.com>; Avri Altman <Avri.Altman@wdc.com>
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Tomas Winkl=
er
> <tomas.winkler@intel.com>
> Subject: [PATCH] scsi: ufs: add fall through annotation
>=20
> Add /* fallthrough */ annotation, to eliminate compilation warning:
> warning: this statement may fall through [-Wimplicit-fallthrough=3D]
>=20
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
