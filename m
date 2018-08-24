Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48EBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA5C21529
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jdhccEcd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OwNZuTsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA5C21529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeHXTIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:08:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36436 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeHXTIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535124776; x=1566660776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4P1O4prRgsbXwrVjHTnAnh/6Cg6Q9QKMqAruc9TGaiI=;
  b=jdhccEcd6LE/huSZ4Vq9PvBqbLP2Vo6lxn4aHgC+mU5r32jNHk7P7/Yv
   xW2Ck5tmChmrMPcV9tHPAgk2Xy1gM7ZNseg36KAsPu+2bqRDvzoWPf3Rl
   kw0A/5s9tf09wJ+4Ox4SLMbgapapFUTAbqKFT3XuJy9AzTImXf8uWWDYj
   S6yF9NV1YbhgW2d0vy0vZbkQ+4I2RlhuSz/TTz6H3JGAZaqNh23zM7/X5
   WIyuBfXyfmVbftiZ473IFzTGvOteBXxIxHsxVcC1oROIN28KxOOUemE0n
   l/ZrTZV2ZdtYln1F37eo7HieRVf3XFmO08oNKEj1nh5yCTT5SIw2aDIIp
   A==;
X-IronPort-AV: E=Sophos;i="5.53,283,1531756800"; 
   d="scan'208";a="89239063"
Received: from mail-co1nam04lp0047.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([216.32.181.47])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2018 23:32:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yuTv/Rtl+IQBGYJap8CrT1NTDc0RaILvz0ZxntehdM=;
 b=OwNZuTsSQeS1PpV6n0NkaEakrzjDYXE9a8NRK9Ua0flExgXAcPivnmvUnEd6vI+db/ZZmmYNf17iEQHNZeoB0KZldkPJrizJpZZpvElgU48mUus9HdxMJrf5vQk1fUCBpqyPolGnE0VunJi9kt6XZEVYneLhEPlM/AsZxbZ9qbs=
Received: from SN1PR04MB1824.namprd04.prod.outlook.com (10.161.255.18) by
 SN1PR04MB2080.namprd04.prod.outlook.com (10.169.124.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Fri, 24 Aug 2018 15:32:54 +0000
Received: from SN1PR04MB1824.namprd04.prod.outlook.com
 ([fe80::6992:d2c3:487d:5bf5]) by SN1PR04MB1824.namprd04.prod.outlook.com
 ([fe80::6992:d2c3:487d:5bf5%6]) with mapi id 15.20.1080.015; Fri, 24 Aug 2018
 15:32:53 +0000
From:   Jeffrey Lien <Jeff.Lien@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Subject: RE: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Topic: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Index: AQHUMN4sEhSi1wxjA0WmqPMOFuusJqS6sJp4gBBgCD2AAE4DAIADvsFA
Date:   Fri, 24 Aug 2018 15:32:52 +0000
Message-ID: <SN1PR04MB18241CBDC8E4CA5275EE4424EA360@SN1PR04MB1824.namprd04.prod.outlook.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <yq1in4gq5jf.fsf@oracle.com> <yq1lg8zb2lp.fsf@oracle.com>
 <20180822062016.GA10356@infradead.org>
In-Reply-To: <20180822062016.GA10356@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR04MB2080;6:/xLEAyEWQjLdwx5LA00W+eHEjqXXO3++InEUHjXXeJBVj++7gmwpiEsQ7i5Oc8y9AcRof2BcxtO9lVk7KY3AXJSb8bbrHo+1OCipnejzicdkv21TiRth//jalmuFBGdz547hamWH3mAHN2WuVnAzC3NNb0fdW/wc4Kvkmr8X2hAAmGCHpFePevD/TFXvIrx7QLoLRrwzpkmXwlykaiIGTncA7893PUlvKp7xPgOJTUyT9a8I1htFrItPV/uxwJmkAQgdFlIFTyuuTfy3a5fCDhz0mXE+7695Zz5Tyx25OvEG0ZJPcPDApiAECji7mdjTMpd+D6y2taPbux74Q2y6Ccz6iEIhXMXg9Kfnba39XVTOsStNhpp6hqljnu40nAPXudPkoIRzH+QbMe2ENgxS0xzzN3CIKshdXnNOoD5/N809ra2I3cm7xX9Wxy5Jd9Y9jxDwCn6ubgCeZW5H0KEdEA==;5:xi5F6wcVEjKe+U0sZcP9YoHL/lnwYZLXvJbbf/00PiYBlfTOMKcgbZxbgoMeTNghpvh4nUaDSycMlz7q+aRh+vbK7KAYU1OfTaM6/yIAUwFEG5g0tiX4j3Knkw/B1jDOG9k0yOwyRIUS8h5FIRrAeSlihacT4BXFbWj0PhKrGRQ=;7:xup8woVaiHU6UMaUckbO3Rwwy5IerWUk2njQKEm6gDMjgge0s4e04/ZMZGIDB62QUE7WJoUD84ii/mHFEF8Xab9Ste4aUgcm2BGyU5Wpm/9AFeIIumhnpWGOU/3d3dtkwyU7woIlMj/XZcmBThW3R9EJxtQZaMhYJrFoAH7QkFjDBpaeue7Oi1fQlGvQm5lQydFerIU5s8TcaLhJRsuRtB24ZzaOpyAKMfSwxLBoBcAv/tCa4bp0I+qI4WYpp1Wa
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: e1b56f22-a937-4b96-67c2-08d609d6dba4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR04MB2080;
x-ms-traffictypediagnostic: SN1PR04MB2080:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN1PR04MB2080B0C60410EC57A6E103D2EA360@SN1PR04MB2080.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:SN1PR04MB2080;BCL:0;PCL:0;RULEID:;SRVR:SN1PR04MB2080;
x-forefront-prvs: 07749F8C42
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(396003)(346002)(199004)(189003)(13464003)(76176011)(6506007)(53936002)(99286004)(55016002)(81156014)(81166006)(4326008)(9686003)(53546011)(6246003)(72206003)(478600001)(5660300001)(25786009)(14454004)(33656002)(66066001)(2900100001)(110136005)(54906003)(74316002)(8676002)(2906002)(3846002)(5250100002)(316002)(6116002)(102836004)(14444005)(256004)(105586002)(7736002)(86362001)(8936002)(106356001)(93886005)(476003)(68736007)(446003)(11346002)(486006)(229853002)(7696005)(6436002)(305945005)(97736004)(26005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR04MB2080;H:SN1PR04MB1824.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: u4yX4Qujn9JGiwusM2HaKLVjV2kBufDYhXaLGys09q6KgbMpQrFDSpSqqJE4QfFbdaGXngkSyOLju1BDV/FkIXz/NDYDPwmM8mMRdjULXofB4eqvb907HRQ9oI4w4FpLsRhu1h8T0j18QYxHjY/gRVEBn/yq77ZuMxXFqVh3vC8EYlDhbHi99krxBTA24fjERdmwjW3r6+j1uu8um90t16CIpfVZew82N76r0VeRjVqwzeI0ASF/c0LQQbka/XYyB7XolxVcjAw87go+ev26a7pIUqeQahLHuLkUHT/9VJ+FqHxjJNImTVzSxviseW9Hzdc6jedZ7cOJ74nH2bS8ITTx2AmLKxEKeQRIzkJSn/E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b56f22-a937-4b96-67c2-08d609d6dba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 15:32:53.0378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR04MB2080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I rebuilt my 4.18 kernel with CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dy as Martin =
recommended and got even better performance results vs the CRC Slice by 16 =
changes.  Here's a summary of the results

FIO Sequential Write, 64K Block Size, Queue Depth 64
PCLMUL =3D y Kernel:        bw =3D 2237 MiB/s
Slice by 16 CRC Calc:      bw =3D 1964 MiB/s
Base Kernel:                     bw =3D   357 MiB/s

FIO Sequential Read, 64K Block Size, Queue Depth 64
PCLMUL =3D y Kernel:        bw =3D 3839 MiB/s
Slice by 16 CRC Calc:      bw =3D 2730  MiB/s
Base Kernel:                     bw =3D   797 MiB/s

So it seems the CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dy provides the best perfor=
mance.  Are there any negative side effect to this config option?   If not,=
 does it make sense to recommend all the major distro's change their config=
 options to have CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dy as the default option? =
=20


Jeff Lien


-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]=20
Sent: Wednesday, August 22, 2018 1:20 AM
To: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Jeffrey Lien <Jeff.Lien@wdc.com>; linux-kernel@vger.kernel.org; linux-c=
rypto@vger.kernel.org; linux-block@vger.kernel.org; linux-scsi@vger.kernel.=
org; herbert@gondor.apana.org.au; tim.c.chen@linux.intel.com; David Darring=
ton <david.darrington@wdc.com>; Jeff Furlong <jeff.furlong@wdc.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.

On Tue, Aug 21, 2018 at 09:40:34PM -0400, Martin K. Petersen wrote:
> When crc-t10dif is initialized, the crypto infrastructure will pick=20
> the algorithm with the highest priority currently registered. Both=20
> block and SCSI will cause crc-t10dif to be compiled as a built-in so=20
> this selection happens very early.

Ouch.  This might actually happen in a lot of other users of the crypto fun=
ctionality as well.

> However, it seems like a bit of a deficiency in crypto that there is=20
> no way to upgrade existing transformations if higher priority=20
> algorithms become available. btrfs and a few others work around this=20
> issue by not using the generic lib/ CRC functions (which defeats the=20
> purpose of having these in the first place). Instead they are=20
> registering their own transformation at a later time where any=20
> accelerator modules are more likely to be loaded.

If we can't fix this in crypto (which doesn't seem that easy), we should at=
 least clearly document the issue somewhere, and fix this in the t10pi code=
 by initializing crct10dif_tfm in a lazy fashion only once the fist block d=
evice starts using it.
