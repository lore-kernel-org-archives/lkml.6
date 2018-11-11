Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BCC2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 09:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="LT/Drv6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BCC2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeKKTak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 14:30:40 -0500
Received: from mail-eopbgr740080.outbound.protection.outlook.com ([40.107.74.80]:35388
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727344AbeKKTaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 14:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e/TiMFooWQkDN2vpZDu42/oANZWG2RwgEKjvqls908=;
 b=LT/Drv6Ros1U/ndaP5grnBUF+H0/jh+ffGpNbHFv1x2wp1D7uJ43MjB3xyA+48YPKc4O240qr9do9JQrdtpnPeK14h2VRQYwwDP7kovl1TJDcVJPkB1aPFXYfwn7s5Rq5h/RDpirpWhIMhmt84gL0GnbZGgKxdPY4Kw4TU/MHeM=
Received: from SN6PR07MB5326.namprd07.prod.outlook.com (52.135.105.33) by
 SN6PR07MB5342.namprd07.prod.outlook.com (52.135.105.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Sun, 11 Nov 2018 09:42:31 +0000
Received: from SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149]) by SN6PR07MB5326.namprd07.prod.outlook.com
 ([fe80::f0b9:acf9:7513:c149%5]) with mapi id 15.20.1294.044; Sun, 11 Nov 2018
 09:42:31 +0000
From:   "Richter, Robert" <Robert.Richter@cavium.com>
To:     John Garry <john.garry@huawei.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH 00/10] irqdomain, gic-v3-its: Implement late irq domain
 initialization
Thread-Topic: [PATCH 00/10] irqdomain, gic-v3-its: Implement late irq domain
 initialization
Thread-Index: AQHUduWqhR5TMbLPo06W2x2cs1kfyKVHsxAAgAKk1QA=
Date:   Sun, 11 Nov 2018 09:42:31 +0000
Message-ID: <20181111094222.GF4064@rric.localdomain>
References: <20181107220254.6116-1-rrichter@cavium.com>
 <e93e7a95-bd12-5695-18da-1ac80b8d595d@huawei.com>
In-Reply-To: <e93e7a95-bd12-5695-18da-1ac80b8d595d@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0143.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::48) To SN6PR07MB5326.namprd07.prod.outlook.com
 (2603:10b6:805:73::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.180.179.98]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB5342;6:tZb/vm0NWIvHjczLYlaBlrNx75/sLoD+isJoNHrd5uVZdeblY7UtcdsD/71j8OnMyp6Eaf+Vl7sC6KScXGiTC5U6kMjer0ColTa1vt8b4HkouOvPGQ17XWVMUGaSG80AYMFhcPLZXvnTblp3wNKmvfYpopoE7gCqRaE1caU6/8ToE0EYAPIZTH2UTFJN6igqXXhMXOvS192GCeLlGBYjlV8ZG/34Qbuy9pRuZnHXyPTM11p9FtTXTHpvqBs42YYyLz22QwBLzdXlE6bv0Et4r0bcb/7uJhVgz57v4Bw8fk4yYmPPBImuKhcCkEajk2Hth13d3bfmLF3IZ9d8WvzvTqpQg+vIHM/Ik29pz5CuCx8s9XhKOAKYmsuVdm2nCQeLrGxHcbGqxDH30pf9HbuHaSfpbf6q6X9IGe7DeOaf6JYpnwjTK0YBamgBnq9IcycghUkBk8Kc4lFiJ8BByGz6tg==;5:wxF84cAqq9hV9fAyPCYGmPnHljhRqBo3sRqho/Xh7WpkyqxHTDKwL35aBPMtZ11itQ95YX8tXT+9+WLQmE2q3njRicj/EjO74wFwZXF2FdOSmnIEoWhbZZC7lYQGg1iwnmU+DJyTdDTH2R2D/afqwc51C5MQABpWG6XvEcfuuKU=;7:zStvw6Lwy2Y5sUBEDstcdmFzHpzaKFL5oRWdjGE8Oe/I0CND2IwCdmNYLyFkQFoBPnnkH13GAHv19XtzaHu7NGKmkUJ7KqkPPxTtZ38DmqcADehq0v6cmjPOc8sXFJKBz+NT9117gvwgRvnr86VA4g==
x-ms-office365-filtering-correlation-id: f11a1980-3880-43ff-f394-08d647ba0015
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB5342;
x-ms-traffictypediagnostic: SN6PR07MB5342:
x-microsoft-antispam-prvs: <SN6PR07MB53422DEC9ACBCCFFD98F5299F1C00@SN6PR07MB5342.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR07MB5342;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB5342;
x-forefront-prvs: 08534B37A7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(6486002)(6436002)(4326008)(72206003)(966005)(68736007)(14454004)(25786009)(53936002)(9686003)(39060400002)(6246003)(6512007)(6306002)(26005)(7416002)(6116002)(99286004)(66066001)(256004)(33896004)(386003)(6506007)(33656002)(76176011)(102836004)(53546011)(52116002)(97736004)(478600001)(71200400001)(7736002)(71190400001)(106356001)(105586002)(86362001)(2900100001)(305945005)(5660300001)(316002)(3846002)(476003)(11346002)(486006)(446003)(54906003)(186003)(8676002)(2906002)(6916009)(229853002)(1076002)(8936002)(81156014)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB5342;H:SN6PR07MB5326.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ooj5qhOA70Vd15sYOsZxCl7cl70bsTQmJ5aGokHfFEly1xpzf9zFzPrSDUGLKAMqh6pVujBdYoc9Gfu7liViUtgNO763TONQeYwrhju3gMGdpYxw6Khf3rbKAmEH9rSGzdP2toV/Oy8aiawKWDdKyP36gtXSdx+Y0VW0in8j0CwGMxlbkrewjVXLA7UOhWknAC7jmZ+dsLsR0fi8Y2YxR9EXF0TTe69TfODyolabk6do325msNR+2+2ht8jHmsG1arGJwaNRQnipnTFs9w2BxWzPfi6R8ldR0PTLzSLJsf2miU+i6CyLZVyWW0Sa2MvgZxvdbJsDYmO2zw90NM6ojthnuG9a9VHC2uxArm4D7Qs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1C244F2CE404D4387D0BF25801D1359@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11a1980-3880-43ff-f394-08d647ba0015
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2018 09:42:31.6025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.18 17:19:54, John Garry wrote:
> On 07/11/2018 22:03, Robert Richter wrote:

> >Patches have been tested with Cavium ThunderX and ThunderX2. I have an
> >implementation of CMA ITS table allocation on top of this series
> >available, I will send out patches for this in a couple of days.

> For this follow-on patchset, will it conflict with this:
> https://lkml.org/lkml/2017/6/25/75
>=20
> We were planning on reposting with some results.

Both could be implemented, but of course, it changes the same code and
there will be probably conflicts.

-Robert
