Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F670C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B9920858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 11:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Wtql+lt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B9920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbeKJVBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 16:01:45 -0500
Received: from mail-eopbgr760078.outbound.protection.outlook.com ([40.107.76.78]:45519
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728883AbeKJVBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 16:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg2jV37CmPh2u578YT0FRFaVwPg84+7+Xy1ZPnFsgJ8=;
 b=Wtql+lt3AwRAISvNLGqk4F0laRP2udBnKkEZVGqGIOVuASh1uweXb7iUsdaIgR1DOzYnTLgKTZWIsOsjZJ8wjzo9mecNJ0lcgmxz9jiiICjcC932LAfpdAIfg/Bc08IZsyiyPsdIhMKRyFUJw2yuh2NNW3wT50ALpKHlnEHOEPo=
Received: from BYAPR07MB4599.namprd07.prod.outlook.com (52.135.204.25) by
 BYAPR07MB4999.namprd07.prod.outlook.com (52.135.238.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sat, 10 Nov 2018 11:17:03 +0000
Received: from BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::1513:e267:a343:917]) by BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::1513:e267:a343:917%5]) with mapi id 15.20.1294.034; Sat, 10 Nov 2018
 11:17:03 +0000
From:   Jan Glauber <Jan.Glauber@cavium.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dcache_readdir NULL inode oops
Thread-Topic: dcache_readdir NULL inode oops
Thread-Index: AQHUeDnKfcShvdBH+0+6hZ8Ik/l9/A==
Date:   Sat, 10 Nov 2018 11:17:03 +0000
Message-ID: <20181110111656.GA16667@hc>
References: <20181109143744.GA12128@hc> <20181109155856.GC2091@brain-police>
In-Reply-To: <20181109155856.GC2091@brain-police>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0018.eurprd07.prod.outlook.com
 (2603:10a6:203:51::28) To BYAPR07MB4599.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.43.113.75]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4999;6:GWab3flnLDK98fW7XMdAU5T7PbRL7dsbhCuxtqr6Dej3OWcW9Dcuy4zyBYtslJNaC8TjMLsU6fVRYqbb+yH4R434C2O0AXnWO6rS0XcZKEI3kFXcaEbE5DZWXUrfeb9m/mjh1laED/Z00w7u8GEv0dtIQGmevfKFuJphbhiaW2uj3ypRNlmG2uvqw1FTgqZVnvd51mS9P8ISvX7xUZcdlePxJ2ez/4OJJKuQU6C+/ld2FNWA2JNK87uabqP5wbesLCmICWPxLkQKRcyBuJGC4Q0XvaHX6vljigjoEGBWYfdzP+iAmxL/1NlGdLFTuVvD6Vqu7rdzkrj/PtAPTILowADzBTr+2UeqXGrnKHf4KBklBo+SKmDbAkUT6c1xeUyOCaDUffCHyZd7JHkxtqbFj4zfmXDH6bqJtqaQUPPv3XY1DRm+1BFYVeGGB+7ypYN9isAAt/XAjuEzSuQSr3dlBQ==;5:ZipqWB3Ss3yThzQGbe0fSDuzKlGuhC69y8xU2se8FaK2K/GwHzZNGZpi1e3Nj7ypow7tIFByB2NJOxtTWey1EVjTBN6WyxxByY//hj2tLxq5qPT1lYZtbqq0H/606Olk+ncXaVVKVnUp7pYzfZ2720OwEBTBrnENv4r/kZA3Q0A=;7:He2fso/tvwfOXNZCYmY54eVhQP+gPZLO9Qf/DjtgmFz4JTNUFO9m8x7WlPU/qWH0tMbBiztqYumWVm8yvzw5Fu3YnQdYpILDyxjCoxfeSaZBJ0Mh/2hO2bJ9Uha+GkQ4Gr37vNfr4XS0x1rjJ3LMnw==
x-ms-office365-filtering-correlation-id: a6473483-8bd5-49d1-5c9c-08d646fe0a10
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4999;
x-ms-traffictypediagnostic: BYAPR07MB4999:
x-microsoft-antispam-prvs: <BYAPR07MB49997B153DEAB6600EE9BF2691C70@BYAPR07MB4999.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4999;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4999;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(81166006)(8676002)(99286004)(6486002)(2900100001)(76176011)(72206003)(8936002)(52116002)(386003)(33896004)(478600001)(102836004)(68736007)(5660300001)(81156014)(71190400001)(6506007)(229853002)(6436002)(53936002)(106356001)(105586002)(1076002)(71200400001)(97736004)(9686003)(256004)(3846002)(6116002)(14444005)(186003)(2906002)(6512007)(305945005)(14454004)(54906003)(6916009)(6246003)(33656002)(7736002)(25786009)(66066001)(446003)(476003)(11346002)(33716001)(44832011)(86362001)(486006)(4326008)(316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4999;H:BYAPR07MB4599.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sV9oyaHsJU+8Fb8ntWuBEVoIWDTa4YwgigbbW1MoCyR/Bp127Xhs2DzhT4my+pX6KDJzAGfwZ0ty5P8K41AaNQT/bWp7JRmNvimTiX9OW+1eUalPBLRTkzQNUJm3vsAiy5cUM1GaJgMn2/wcv1kT6FUufvFePZ2YrL2DvfbbjCsM6JE6jyuCYhWcRCSEJC6MrclSnIkwfPrv6J34Xer3zhNZZCMCf119fwnUMKuYkX32tUAHxmiz6EfoiNDUXuKST7FTUD2DyJEu/D8jFwPQqyUGnfnbzgDIQqYLqrMvKtwuCzyoYN0rhe7sVoATGzywLjirZwIKFM3peHAR01WRNq17uZMr1Cs33b0di0FY+f8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DBA5766A495184FBAA4713EA7AB162D@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6473483-8bd5-49d1-5c9c-08d646fe0a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 11:17:03.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4999
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 03:58:56PM +0000, Will Deacon wrote:
> On Fri, Nov 09, 2018 at 02:37:51PM +0000, Jan Glauber wrote:
> > I'm seeing the following oops reproducible with upstream kernel on arm6=
4
> > (ThunderX2):
>=20
> [...]
>=20
> > It happens after 1-3 hours of running 'stress-ng --dev 128'. This testc=
ase
> > does a scandir of /dev and then calls random stuff like ioctl, lseek,
> > open/close etc. on the entries. I assume no files are deleted under /de=
v
> > during the testcase.
> >
> > The NULL pointer is the inode pointer of next. The next dentry->d_flags=
 is
> > DCACHE_RCUACCESS when this happens.
> >
> > Any hints on how to further debug this?
>=20
> Can you reproduce the issue with vanilla -rc1 and do you have a "known go=
od"
> kernel?

I can try out -rc1, but IIRC this wasn't bisectible as the bug was present =
at
least back to 4.14. I need to double check that as there were other issues
that are resolved now so I may confuse things here. I've defintely seen
the same bug with 4.18.

Unfortunately I lost access to the machine as our data center seems to be
moving currently so it might take some days until I can try -rc1.

thanks,
Jan
