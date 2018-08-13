Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7F2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B392175A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 18:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c3vZGELk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MHaAaNcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B392175A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbeHMVY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:24:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42210 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbeHMVY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534185693; x=1565721693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r6tlQzmYoAIQhrDsuKFzQyKqDBWMyCOA/ISQmo/mrNs=;
  b=c3vZGELkyO2ls9g5+uzso06S9xG+x7pGUUaX1v03eb2sTtSrRp872TLL
   N4ZPZHZ0fS5XbbJFrq5pR+n/gxGOiP32j0A51YDmbvOLvIF8ZYUpLHdWO
   4IyGTkyp98nyFP9LszDOwt7xmJVAAS2Qrv6ChpGYhLKqLiJmJu6ft0zaZ
   SdRBlFc9nMDmRA2H8OoaN16UuLpSbRCRYJ1KhxQY8423vieecPd/9iQ1v
   V9kgo+dR+fCqUJji0hVpoHy/aRZ6DpBLhaqhnrGtnBnyJZxi1FOgMlptV
   bVUd4O2w1FLcLKc/aTFSeQLlpxSu+5Ejob3/fNqc9Mvsiy+wGvpIPRhlG
   A==;
X-IronPort-AV: E=Sophos;i="5.53,234,1531756800"; 
   d="scan'208";a="88967181"
Received: from mail-co1nam04lp0050.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([216.32.181.50])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2018 02:41:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uKqWEHGK2kL5HG/hXl8CdBHByQMtIiDlgfADbJlSHk=;
 b=MHaAaNcq/IG8zrv5fR0ix+rZdam96vO2nEAKAPJpcmPP8acl3LSG1Dd2s9dSM7aP0n+j6R3wfjTCndx4P7w+wIuRl3nxI92Bb7DTg0XlkqQa385xzmmRFcOWULwp+LQNeTBAi1ZsGBOaj2IPNyaTBJs/0j3n8/LBPjiWPcq57q0=
Received: from SN1PR04MB1824.namprd04.prod.outlook.com (10.161.255.18) by
 SN1PR04MB2126.namprd04.prod.outlook.com (10.169.124.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Mon, 13 Aug 2018 18:41:28 +0000
Received: from SN1PR04MB1824.namprd04.prod.outlook.com
 ([fe80::6992:d2c3:487d:5bf5]) by SN1PR04MB1824.namprd04.prod.outlook.com
 ([fe80::6992:d2c3:487d:5bf5%5]) with mapi id 15.20.1038.023; Mon, 13 Aug 2018
 18:41:27 +0000
From:   Jeffrey Lien <Jeff.Lien@wdc.com>
To:     Joe Perches <joe@perches.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Subject: RE: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Topic: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Index: AQHUMN4sEhSi1wxjA0WmqPMOFuusJqS5XWQAgAAK+oCAAEWTAIAAKVSAgABrggCAAGUpAIADX7hw
Date:   Mon, 13 Aug 2018 18:41:27 +0000
Message-ID: <SN1PR04MB18246863506680B4ACB30866EA390@SN1PR04MB1824.namprd04.prod.outlook.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
         <9b5b906f42dfab78f382c90f66851717d258a15d.camel@perches.com>
         <nycvar.YSQ.7.76.1808101601110.13885@knanqh.ubzr>
         <b3c86ddd67a73c09e09f3e51d7fc70036f00fb7b.camel@perches.com>
         <75d66dfa-688b-f941-04fd-5a39cf882b21@interlog.com>
         <8e63583eb6898c3f481f1cb45b067234737a11b4.camel@perches.com>
 <2089960838bccf80f6fb9cc586b1a663f1f9e9da.camel@perches.com>
In-Reply-To: <2089960838bccf80f6fb9cc586b1a663f1f9e9da.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR04MB2126;20:2W/Gv7ozPFqv9b0xmb1gGTBz/FAPP7wKOzR+buYHwcxt2zTviNjorBmW6zl78zzNqb5f+/FwWWzxNqjOdByUzGDXD0tfscXy6A3WiCqx/lOltRytmROrgvnk+kT/wsMvrKLraPfw4rDmpNCRKzlJmuD5IZXqtAGwEIqhKBUmM1s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: f6696cc5-64db-4a64-9dc2-08d6014c60fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR04MB2126;
x-ms-traffictypediagnostic: SN1PR04MB2126:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN1PR04MB2126A945BDC9B4E0B12496CAEA390@SN1PR04MB2126.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR04MB2126;BCL:0;PCL:0;RULEID:;SRVR:SN1PR04MB2126;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(366004)(376002)(346002)(13464003)(189003)(199004)(6436002)(26005)(478600001)(99286004)(186003)(74316002)(72206003)(2501003)(8676002)(66066001)(81166006)(5250100002)(81156014)(5660300001)(54906003)(110136005)(7736002)(486006)(446003)(476003)(11346002)(256004)(6246003)(102836004)(14454004)(6506007)(53546011)(6116002)(68736007)(305945005)(33656002)(14444005)(3846002)(7416002)(316002)(4326008)(8936002)(53936002)(55016002)(25786009)(86362001)(9686003)(93886005)(229853002)(106356001)(2900100001)(2906002)(76176011)(97736004)(105586002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR04MB2126;H:SN1PR04MB1824.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mzHZ6tXXTQ2Wq148X9MBKThCub2y42loqdXmsZlEE2WE07wSEwXUDUlrxqmN/2FVqrTvWqfnrerqVzPGdzbcH7JbbgDKCYuzkB1Gd8lW5tl0niZ3DtZSSRHart10D9meDD94TI6/3avllU09pWucmfs7S3Hjmdsk+y6U6TlwTFZYANJ4FFPlhG+DBRqKNxndHz70LaFBdnpeYF1z7O929njJxlVnixLwlAYVLvIuIjbQA16rFQG0LFitq/8Q/arQ2uomj6879aKn9gTQ6CoKWnqerkl19H0fwTRzD5ul9rEtb8x2ro6ppQxrHRpEcDoXILW8fP+3Rqwu17ERdpZXen0IieNi8K/yic9iQcxm4FI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6696cc5-64db-4a64-9dc2-08d6014c60fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 18:41:27.4030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR04MB2126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe, Doug, Nicolas,
The CONFIG patch change suggested by Joe and Doug makes sense to do.   I'll=
 do some additional testing to verify the performance on my systems.  =20


Jeff Lien

-----Original Message-----
From: Joe Perches [mailto:joe@perches.com]=20
Sent: Saturday, August 11, 2018 10:06 AM
To: dgilbert@interlog.com; Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Jeffrey Lien <Jeff.Lien@wdc.com>; linux-kernel@vger.kernel.org; linux-c=
rypto@vger.kernel.org; linux-block@vger.kernel.org; linux-scsi@vger.kernel.=
org; herbert@gondor.apana.org.au; tim.c.chen@linux.intel.com; martin.peters=
en@oracle.com; David Darrington <david.darrington@wdc.com>; Jeff Furlong <j=
eff.furlong@wdc.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.

On Sat, 2018-08-11 at 02:04 -0700, Joe Perches wrote:
> On Fri, 2018-08-10 at 22:39 -0400, Douglas Gilbert wrote:
> > but below is a copy and paste of a table 27 from draft SBC-4=20
> > revision 15 in chapter 4.22.4.4 on page 87.
>=20
> The posted code returns the proper crc for each=20
> CONFIG_CRYPTO_CRCT10DIF_TABLE_SIZE value from
> 1 to 5 for these arrays.

Jeff, could you please test the suggested patch with your comparison framew=
ork again with each CONFIG_CRYPTO_CRCT10DIF_TABLE_SIZE from 1 to 5?

I get on a very limited test framework here:
(runtime average of 10 runs)

1: 4.32
2: 1.86
3: 1.31
4: 1.05
5: 0.99

