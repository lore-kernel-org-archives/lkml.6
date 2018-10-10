Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78338C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCC9214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lUndjn3/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IeryP/IB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCC9214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJJQEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:04:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2452 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeJJQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539161018; x=1570697018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tEc2ufvMtyIxYGOa1Ux5E3SrPWuNWlxOdYEM+YLJRqY=;
  b=lUndjn3/pGmUVWO63pV/FjzCR/1mfQBpFc97eSs/v0fxSWd6vBycOdlB
   6RtcYundGnlynvsGc5hDK28oXue7CUzTCsR3sntotVAy+Wlb2k2G15y1N
   YDiKcrzFX52oTEq4olmSQ+IcVbaz1kvZ7gLcXUeSrdlCGn6UrxAET4by1
   FKekpr483dnEfyH63riRKprNymwMf9S/SZwb6X6QX+9vL6ft8DCCvLFIf
   FzhAp/AaQbXz/qHwoM/y2bD6sOQMtwolog6L4vBMxwuLIBiLX9z3vHxbo
   /lChbwyr2mEqw9N8aW3nYvxSZysZ/1rjd4w5E583Fo6iHR9X/3gLBCPmi
   Q==;
X-IronPort-AV: E=Sophos;i="5.54,363,1534780800"; 
   d="scan'208";a="195964169"
Received: from mail-cys01nam02lp0050.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.50])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2018 16:43:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMzRQ5MhNchuSSK1smZVGpA6Mlee5oUS75Zuruah0CU=;
 b=IeryP/IBRoKoWJOMUhQ/msXUkdcnoq42E86/YvMZKveGI47s94jJClvmdg/I1rmWp3WA2b0P90J3DmivrvhzPz+sIsdZItr4hemnI/l8AErg66FWioq08VvmK2mXONmhGJiJ3ieNG02gQHhwV+jIovIDwIZV1qQcP/CIw1+8meQ=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4943.namprd04.prod.outlook.com (52.135.114.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Wed, 10 Oct 2018 08:43:25 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c99d:1885:c976:a93b%2]) with mapi id 15.20.1207.024; Wed, 10 Oct 2018
 08:43:25 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     James Nuss <jamesnuss@nanometrics.ca>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/7] mmc-utils: treat FIRMWARE_VERSION as binary field
 instead of string
Thread-Topic: [PATCH 2/7] mmc-utils: treat FIRMWARE_VERSION as binary field
 instead of string
Thread-Index: AQHUX/Xq43uhKANLSEyJ2lkIDSULFaUYKgrA
Date:   Wed, 10 Oct 2018 08:43:24 +0000
Message-ID: <SN6PR04MB4925CB991DADD39F28A31D13FCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
 <e2b6431104a6a822840d4e7b984d7aa23048a0af.1539103468.git.jamesnuss@nanometrics.ca>
In-Reply-To: <e2b6431104a6a822840d4e7b984d7aa23048a0af.1539103468.git.jamesnuss@nanometrics.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [77.138.253.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4943;6:H448sm8WvVIzKAUL6CMG562F4B4HFlS+I2FDPZ4p0Z9kfvpzgXzQR7uDpnyzwZqrfR4Y/kyllsLL5BfkoJb/KxFO/vl95M8v0RNkuHMXXW8JX8/libWyp/QKeOCwMy2eiF12TQdBIuDWRvmn5E7xSKo0AhQlIkUTcN9cO4+9t5EXhjmVqYav8LdsJO/NmxLuyWvvV9HOQA2sI2Ere8zj0CtSBALLKGDnXwh/S5AzAqgZtT5zCvXrNxWcyTgDtBIehVcU3E6aiKpUA83hHV+WU+efF3+0vaWhB+5wnJo6/HdU9TR9ZTc5/mDT4q++NpYINcLBYUiWodCG/NKA3ePpvA8/IyjPGmymFs3UG9Pri+a15VNzQzu9iRbM04/2oWAMjoxdl1n7OSKisj1DW8IcWwmypmaGzvR2eYKPfqubmbs/6VYcHcuHNQcXejDIHZNTPPCIs4F3bJBCv9RYVOGqRg==;5:Ruma73QpQkLJ3+m++86ut9VvvTObHv4SV4EtMYJm94Ga1v5EswSxBwRZCwDCUa6dI+tazEWPsmrX2jPGVUPmxCXqMlonX1ktyDzTADATfjYA+2UsrnlfvL5vulMA7ORZv0LarLafVK+VbhEYyGFXVGLYPl9U4WaTF5keZPCGvx4=;7:d3gZgtyoWenQuW/qhI21C2whH/YVzLq3ztIwIcTFIkrgkKWFxbCfLCmoCPXp6Qmd4sh2gsJ8ZtNCbDeAgEECLN4ZlLLRpkUUR74iWM7crFEI0xEdPLXV5ywfKipy5td7Yp9foj6GKg8JnYvYa0wK9qjGSyZs/atp2qxJwZJjFufX/gS+R697q4xvUvKaySsBa1juLA/yW5Bc2/wCXJ4Numqnt5ppvSoQ+IJGfksAwkQfd/jsmCJrrUhUUFXNyyTH
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 25bec8ad-d977-4c58-63aa-08d62e8c7143
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4943;
x-ms-traffictypediagnostic: SN6PR04MB4943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4943D595D98F94B0E3CE4B50FCE00@SN6PR04MB4943.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991055);SRVR:SN6PR04MB4943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4943;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(76176011)(6246003)(2906002)(6506007)(7696005)(2900100001)(2501003)(478600001)(5250100002)(4326008)(72206003)(25786009)(3846002)(6116002)(7736002)(229853002)(66066001)(97736004)(14454004)(316002)(99286004)(74316002)(305945005)(86362001)(256004)(81156014)(6436002)(33656002)(106356001)(105586002)(81166006)(8676002)(110136005)(11346002)(446003)(55016002)(8936002)(9686003)(68736007)(53936002)(26005)(5660300001)(71190400001)(71200400001)(476003)(486006)(102836004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4943;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: z+sSPRFT4JaEPT+f0MxdgV6yJHkJ/WcVgSe4E1Dex3QwuaXApTs+sBM/eIoaJI1SpSm4tOVnKPagqJYEWMKGnSRRJCX/f+jqAw8GSkVutONO4SE9uTPhwQy3KeIrq3I02p3dRbsP23HNPGUuo4XbzQijhrS20F2zXYNmVhswAt+hBHWyeojV0BqpW4ZPEVoInXkywEXKqOyKN1NBVAFiQz58tbQ6ytsAWTZHsbRnrGICRwtaE8IJkyFKZUDnMdzAwm9GlibGEs5LCaTmoRhOmO/DqzhLCJ+mfuECVv9F7ge4+j4OqMHWcMTHZ5C4BXV8fHsDM6ekLu+KTkN0lhmsouzaoFzhNWNxsBrfC/yzkws=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bec8ad-d977-4c58-63aa-08d62e8c7143
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 08:43:24.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +++ b/mmc_cmds.c
> @@ -1758,8 +1758,15 @@ int do_read_extcsd(int nargs, char **argv)
>  	}
>=20
>  	if (ext_csd_rev >=3D 7) {
> -		printf("eMMC Firmware Version: %s\n",
> -			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> +		printf("Firmware Version:
> 0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_7],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_6],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_5],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_4],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_3],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_2],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_1],
> +			ext_csd[EXT_CSD_FIRMWARE_VERSION_0]);
ExtCSD[261:254] is an ASCII string, just add a terminating null.

Thanks,
Avri

