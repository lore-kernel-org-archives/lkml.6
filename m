Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D503C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FEF20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 13:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NF8+KNBp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ApImFonG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FEF20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeJLVFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:05:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47004 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeJLVFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539351161; x=1570887161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hZgn9nReAXrUIzBepK7UHisxvlN+5Zqo/r8Phn8u8uc=;
  b=NF8+KNBpoTk8n28UJC49Ww68qF/jShNXKin7h2N/vTjPrbLzVz/YPRtN
   aqoLW4O/ZZqteLmi/7cT4c/20RXK5zczCHFHqkkPV5TSzcVdHRLUIuIP3
   b3JzNWPACMzjHJ2bJ1a2sSSzKNggICzF/Y5jX3H5xp0ENpJTJaufXfZRj
   IyWxpN6EYbAjM/Yeu+6ee5zZ8NeGf8DtOWS8iCJM2omd5n7xCTeNhfQW5
   +YT9YQZOUcDunirtBUPo4py/DWBTstlFQIPDrpe9gzxC3uIN6/xmyD3Rc
   fzngV+C7vQfwNBiI+PAu2wZSIxNjPhqO1UI4jufO+eFKxssUIj53TsY+o
   g==;
X-IronPort-AV: E=Sophos;i="5.54,372,1534780800"; 
   d="scan'208";a="92915045"
Received: from mail-cys01nam02lp0047.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.47])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2018 21:32:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZgn9nReAXrUIzBepK7UHisxvlN+5Zqo/r8Phn8u8uc=;
 b=ApImFonGbuXJrFnoqCjHbNsI5muS2e5BGMs7ctbAbaIQKkgYJsSUmkXa6A+uWoH17TmlYMujHqHF19NlACFc6H0hmNRhP4/E2+Q6Ywzyc10i/wXjiWDOak5kEwt7NfHhUFMq+iqSC9cn5UUgRL4WX9wtypGP2e4iOsReYkkH73g=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4320.namprd04.prod.outlook.com (52.135.72.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Fri, 12 Oct 2018 13:32:38 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b%2]) with mapi id 15.20.1207.029; Fri, 12 Oct 2018
 13:32:38 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Christoph Hellwig <hch@lst.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: fix integer type usage in uapi header
Thread-Topic: [PATCH] scsi: ufs: fix integer type usage in uapi header
Thread-Index: AQHUYhgwOWjMH69wiUOXN+I2pWROeqUblbIQ
Date:   Fri, 12 Oct 2018 13:32:38 +0000
Message-ID: <SN6PR04MB4925ED3D6D5FFD616FA9D69AFCE20@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20181012104143.1931393-1-arnd@arndb.de>
In-Reply-To: <20181012104143.1931393-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4320;6:SnYInKj9ghzH5PPijnW8/vYbbW2eKoCwWZK5MCM9J7Tt9JDNtK4dZ/a04nXEHxlatCwoZ7ly/6uPuYE7aPlD0mPXdFF0lAhZiPSyYfjLaa3YDnYoImviQmPcWrmn8KbqVhW/RKZTAec4/uVpYTnT/Vk1sw4sGwc4+QCXXIe269Vch5zJjC/OqaNfN16jygEGMg+XUn5gToclEm8sfJt6qDD9PYQlT+XnHhpIY58xBJT0ZCuYlgbAg52e5Il7UUItq8/XMWz+9xI8IJ/VGmG3vkib7GK8U6y2vAqpcpSEqiFj1RdNPFnSnn+g4srQll8fayrkqXaDSfgi4zA2P2oUpEuQkOq9kTRv0WqwDWkWeIiiG+II9KhwmhIpYXN0gdXJxyDYOtXo80Nlbyc4Y08Kwvy3lAKUHxQlKFgTNvaY8Dk3aVvqtmsB5bBFYLYjck7Q1ySKpQGUn5fFWTBf+uiVVQ==;5:PeTIaVlSnR3dtUK+a2fSuB2G5l3Iquyg3rdb92Ef9j40rpeILQYrvZJV1kJ81UtTHVXuCpjNmvU/DwZPY5O2/P0tWaDdbJxuJJOJsovcdT2uUQ6vhBgqmmJ0k8TynlwGLpwvU+LJ21kIIdz/TS1RjirbFZuN5mINwx/SYuG1cM8=;7:BqZWoDeS880i07pQ3/H0OFOitmeygyrGrHNwM7DZ0sejDbEFLSz6BB3BMPB2fL+ZsRGCvEHugzw5O/Y8358XjZKMhddXSoLY1pSedNwXF5fXvuVm68jgmWst1Z9vhD3VJiagtMqWfqsM37oAkgXFN+bzBH7rCLwbkM3pN710TO7YV9j5jXSIE8oJBOpcd/BAgIxiiFxjv5BeBvZunvwzY1d1tyEIu0JnTSaONeJI5HYKuhxEeZlbs3RH7lRUT6oq
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 7695f7f9-dc19-4b67-97c2-08d630472db8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4320;
x-ms-traffictypediagnostic: SN6PR04MB4320:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB43201F7D8FB3FF8A7CD7B3BCFCE20@SN6PR04MB4320.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:SN6PR04MB4320;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4320;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(54094003)(97736004)(14444005)(256004)(316002)(9686003)(33656002)(446003)(6436002)(105586002)(106356001)(102836004)(229853002)(55016002)(186003)(6506007)(26005)(7696005)(5660300001)(66066001)(99286004)(14454004)(478600001)(53936002)(72206003)(2900100001)(305945005)(7736002)(74316002)(76176011)(110136005)(54906003)(345774005)(71200400001)(3846002)(8936002)(68736007)(71190400001)(8676002)(81156014)(6116002)(2906002)(81166006)(4326008)(476003)(86362001)(25786009)(5250100002)(6246003)(486006)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4320;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tjwy/H0TRDU+S7qDdQ8hQiGpQufZM0NyFobMlU4KAVOTWJqPb7VMA/DTzF6d2dPLzbcLhVCzPse96E1U+a2FVPf1bkyOibsDg1YOlQgbkvc3q/UyIkmUJD4R1BEFAjcmUg40gSd6CKXZrp6t5SdyuBjMBCz10dbJPVcGDU5IvyJaww1oOwUacFu3CWy8PMCSV5uXWMKgRLMFjiorn+X+/RenU2cPBvpLxjjNkOo6jl33fmwg4iJAdXA0z6SDnZfbBYw+RU0KI5Wn/eiRQd+h+CprAvhLK36AZqrxNiG6LQWk6cFjP7kagkvfnHwU5/m5X/LKwEJFVffcredXzct5IaJ0hmFPGaFPyDoSCtwvbPM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7695f7f9-dc19-4b67-97c2-08d630472db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 13:32:38.5856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
=20
> We get a warning from 'make headers_check' about a newly introduced
> usage of integer types in the scsi/scsi_bsg_ufs.h uapi header:
>=20
> usr/include/scsi/scsi_bsg_ufs.h:18: found __[us]{8,16,32,64} type without
> #include <linux/types.h>
>=20
> Aside from the missing linux/types.h inclusion, I also noticed that it
> uses the wrong types: 'u32' is not available at all in user space,
> and 'uint32_t' depends on the inclusion of a standard header that
> we should not include from kernel headers.
>=20
> Change the all to __u32 and similar types here.
Ok, Thank you for fixing this.
Reviewed-by: Avri Altman <avri.altman@wdc.com>


>=20
> I also note the usage of '__be32' and '__be16' that seems unfortunate
> for a user space API. I wonder if it would be better to define the
> interface in terms of a CPU-endian structure and convert it in kernel
> space.
I think its fine to leave this as it is.
The user-space app that will use this API, is the mmc-utils sibling for ufs=
 devices.
It uses the ufs transport-layer protocol, so whomever uses it,=20
Is aware of, and will account for the hw endianness whenever needed,
Just like it's done in mmc-utils.

Thanks a lot,
Avri
