Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADB5C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D47C21B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TotgYpim";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lpUcanIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D47C21B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbeHIKiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:38:07 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43807 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIKiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533802466; x=1565338466;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=OJp/5nE5/o2G3OlxdWDbnRhnES9RSt4u751VmqO++I4=;
  b=TotgYpimXa8sFznoY5Eye6bZ/Um2YT+ySnuxS6o7g6qIX2BU70D90jMX
   PkI46tJU3/psUEQuB7tCDA79Xm8Z59dLQ0VdwVZjVEfSgb/aVLLSsBcLU
   cgy6qXboTGo07FcnMqxU8ImLqBwCRTAUNdfvFAeymKSuRWN2hPEqMRGK8
   1F2fImJbICcfMGvx/zIFKto+MwK0BmFGhL9LctG+GGyvJYtN/uH8oahr9
   cgke7YFok9+64eyvHfNs69bSWVcfSnmQi0pSlo7wqsT0toCDLzRW1q380
   axQ7bFXp4kgvVoFkI9Qh102sF7ob/OL4qHcx71exs15u3rkB6imW0cCHo
   g==;
X-IronPort-AV: E=Sophos;i="5.53,214,1531756800"; 
   d="scan'208";a="88645775"
Received: from mail-by2nam03lp0051.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([216.32.180.51])
  by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2018 16:14:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJp/5nE5/o2G3OlxdWDbnRhnES9RSt4u751VmqO++I4=;
 b=lpUcanIn3sqmtu96HEL9YhE7vqbMrbZ44RcT0zKOP/lCIDfXGNaU+rtjKNovaK7e//MyQ2m8D/kW0cnAWW5uP4NkF956jY03Q+ia+WtQahIREoT+iD21pHO+wv3z0Jw1J7L2AYFmCEp8jbDqZbmI+xsPK4oWlZWknXVZ9DHMSXA=
Received: from MWHPR04MB1137.namprd04.prod.outlook.com (10.173.51.151) by
 MWHPR04MB0799.namprd04.prod.outlook.com (10.172.168.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Thu, 9 Aug 2018 08:14:23 +0000
Received: from MWHPR04MB1137.namprd04.prod.outlook.com
 ([fe80::89ab:145b:a6ac:9ea7]) by MWHPR04MB1137.namprd04.prod.outlook.com
 ([fe80::89ab:145b:a6ac:9ea7%8]) with mapi id 15.20.1017.020; Thu, 9 Aug 2018
 08:14:23 +0000
From:   Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To:     Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: RE: [PATCH v4] scsi: ufs: Make sysfs attributes writable
Thread-Topic: [PATCH v4] scsi: ufs: Make sysfs attributes writable
Thread-Index: AQHUL2l3Lpn+7aAYF0aDp+p1wI1A/aS3Essg
Date:   Thu, 9 Aug 2018 08:14:23 +0000
Message-ID: <MWHPR04MB1137C131CC355C7303A0AB279A250@MWHPR04MB1137.namprd04.prod.outlook.com>
References: <20180808224454.243790-1-evgreen@chromium.org>
In-Reply-To: <20180808224454.243790-1-evgreen@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0799;20:oArXFsx5bscwhra/DPFtzuly3qnj7r3ks4GQUqiu0LSOj94yE5Agn4F6Fgj1R9OXAEXihYC/oJQIAyq5IxFNf18e9GSpHuR5GmupzyQtVfqBgjGxp2NnsWoTLS5GrlsqA2jhygJpWgJhyRmLnEVcLxHeYFR16ccNY2fDbIOEDiA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 0d499d6d-ca99-49a2-d62d-08d5fdd01d99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0799;
x-ms-traffictypediagnostic: MWHPR04MB0799:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB07997EC0128A96A21B92FA4E9A250@MWHPR04MB0799.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0799;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0799;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(39860400002)(396003)(13464003)(189003)(199004)(81166006)(6116002)(3846002)(81156014)(2201001)(8676002)(14444005)(316002)(68736007)(478600001)(7736002)(305945005)(33656002)(110136005)(74316002)(2501003)(72206003)(86362001)(106356001)(256004)(105586002)(5250100002)(2906002)(76176011)(2900100001)(39060400002)(66066001)(99286004)(9686003)(97736004)(476003)(53936002)(6246003)(26005)(8936002)(25786009)(102836004)(486006)(53546011)(6636002)(14454004)(5660300001)(6506007)(6436002)(186003)(55016002)(446003)(11346002)(229853002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0799;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RfuffGYIAl7JR31zjyqySc1LvamZEHEzQMY/f79hMTA7kQLSlM7eKXyQbksxWY7Z3Yb5UOw498/69VeXnZA9Zh8o0iwwpsOuMaCbFxj3RASXFLtSVwrfmxy+HHU75XY42l9+jNN0Fvj1Hg16BNMO3UWNHihPZZns5NDfP1qF2IXPs/KdR8xvbgop8F3PJ2xBCd/y1uWy4G89i9JIWrUr4J53Gwtl+4Ipr/Y381/agz7dXMoIF4eiGy0W7JeMZNEMmSZha2tb0J2TG/up9E11EW/MaKA9GnWFqWjJe3e3LnyX3mONUyL9K9jejyBmv57TUmkUG6uYRt52WrKaXp7F+izixdAkIHbzCIPwqIq/hyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d499d6d-ca99-49a2-d62d-08d5fdd01d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 08:14:23.2847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Evan Green <evgreen@chromium.org>
> Sent: Thursday, August 9, 2018 1:45 AM
> To: Vinayak Holikatti <vinholikatti@gmail.com>; James E.J. Bottomley <jej=
b@linux.vnet.ibm.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; Stanislav Nijnikov <Stanislav.Nijnikov@wdc.=
com>; Adrian Hunter <adrian.hunter@intel.com>; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Bart Van Assche <Bart=
.VanAssche@wdc.com>
> Cc: Evan Green <evgreen@chromium.org>
> Subject: [PATCH v4] scsi: ufs: Make sysfs attributes writable
>=20
> This change makes the UFS controller's sysfs attributes writable, which
> will enable users to provision unprovisioned UFS devices, or
> re-provision unlocked UFS devices.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>

Reviewed-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
