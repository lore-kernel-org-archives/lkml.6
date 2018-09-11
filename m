Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE1BC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vfFT69OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0A920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeIKO3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:29:41 -0400
Received: from mail-sn1nam02on0044.outbound.protection.outlook.com ([104.47.36.44]:15264
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbeIKO3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqBUpvrhS29sxpf3N5NigaZnj5Jai4uGZLfYhVvZyhQ=;
 b=vfFT69OEf2XGlfbzspYdo0+X/r9AqcBFHLvuqtk1heVtbrKb3UfPZo9wBzZBEbyoDxaMfUcJGkA0KyJqHI7uWNZWp9Y0u983jh/+Q2CoHmnW6s+otEPdshmUXgcPXRYG2PMQwdSryOF6VTWmKSy0sDdUWSgHZS4W5zeaUgWOcBo=
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com (10.167.162.139) by
 MWHPR0201MB3468.namprd02.prod.outlook.com (10.167.161.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Tue, 11 Sep 2018 09:31:09 +0000
Received: from MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::f07d:71f6:8592:497f]) by MWHPR0201MB3628.namprd02.prod.outlook.com
 ([fe80::f07d:71f6:8592:497f%2]) with mapi id 15.20.1122.020; Tue, 11 Sep 2018
 09:31:07 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Vinod <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
Thread-Topic: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA
 transfer
Thread-Index: AQHUJZfEjDnYw63wzE+wSwsRCwPdMKTKg7GAgArgSpCAAOqtgIAAyp+ggA3bkzCABgWhAIAAHAhA
Date:   Tue, 11 Sep 2018 09:31:07 +0000
Message-ID: <MWHPR0201MB3628C8ED89865CA435DA4608C7040@MWHPR0201MB3628.namprd02.prod.outlook.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
 <20180821155553.GI2388@vkoul-mobl>
 <MWHPR0201MB362803E975383398B361330FC70A0@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <20180829040111.GD2388@vkoul-mobl>
 <MWHPR0201MB36282BE6CB5BD242480757F8C7090@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <MWHPR0201MB362841247B08AFFA21CB0A18C7000@MWHPR0201MB3628.namprd02.prod.outlook.com>
 <20180911074122.GM2634@vkoul-mobl>
In-Reply-To: <20180911074122.GM2634@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3468;6:YEZDW3wLJ09oyFMJEvQuBC8YNkJFGmvMMHS823D9xQL135wFQy2ep21RKqSSpJLjrO80ftvAor9k2Neu5bxa6xxGdxlTeIBCTPZmqRGgTy+qoL9m+fAejqnFLregx7t43G+dC1AN/hpZU4x2BG6U1ataRDSmI+dtZVkYQFyHlKlYCXYiEMcEfa0+0RmTsGdjH4dHjHjDoK36o6GBu0lEk+vjwrEh2VwSwnvIJXXLRDU6JU3laxs3fVO9UjiLKHgpd7B+wyWndDFGVyhjfEw06Byzltn6T8ncIuDkxJARHa9NuR3MFL8xfy2zPkODchIRFUc7j4duh7B+WN38P3+aFJHucKJ5PTZTH0BfzPPHMLDipxN7PxCn8od8U2qLxmZyo9VXIt1Q0Yg2JTrwZ3LOWiB12I6idtTsSFkqKI30CY7rq22OOC+HBPXjHXPBvW8XM5zaKhlYLVkyWfj5TAIF8A==;5:piLWTV1NMeEv79L8ip50bncQUAM6Ln9EGzQ8W7Sv33NjXS1bsn70/j20ybfA66PyD3aKJZuN1xvpiSQRN491rXRWyjlpejJFlnBlQyhGtqpzK9S/aTqwi5rNbNeLOnkOnAiovG+bsbGaAanJW6R3qCM1OXPgZDlENyksISJ2TlI=;7:IYenwU9pscdTbcCar7mqidXk/P7oQCMe5CI7IMwF8Bn/f+w8xqYGU8SBZfOzFme+hGBmABaqedPwjVB96X61yEGKaJCzw03BvUSn4k0nbqFuS89ysnCNRXVdSrxHVwzI3kXeRY/PSLv9Z7ch6Q+tJHfgvRUWGAwTWTNPsCtZkiaUSmmGyJ1uti5orq/wrkKtKykN15TquMOcBxmV4X/MGbgV11fjmlYKZw60Kfqq/DbSY0rUUX2cxAl6PW+n0vli
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(229853002)(25786009)(8936002)(4326008)(5250100002)(256004)(99286004)(7696005)(66066001)(105586002)(6246003)(8676002)(106356001)(76176011)(2906002)(81166006)(14454004)(305945005)(81156014)(86362001)(7736002)(6116002)(446003)(55016002)(6916009)(68736007)(11346002)(3846002)(476003)(93886005)(478600001)(74316002)(5660300001)(26005)(97736004)(2900100001)(6506007)(33656002)(102836004)(54906003)(9686003)(6436002)(486006)(316002)(53936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3468;H:MWHPR0201MB3628.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 74267535-1366-4e31-3b9d-08d617c94dc2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3468;
x-ms-traffictypediagnostic: MWHPR0201MB3468:
x-microsoft-antispam-prvs: <MWHPR0201MB34682969E257DDA3933B5F63C7040@MWHPR0201MB3468.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:MWHPR0201MB3468;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3468;
x-forefront-prvs: 0792DBEAD0
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Yvk1drQNWMXznepuIyecHWa6FFrGv7evGS66S6e/817rtOGB+rLEd+0zFgSNu5QPkhtk7KIUTeaoPkCIP4S5vAfDvZeLOQ4DXQcMZCw3ZAws5Iue9xrsxH+Ixre3fd8zRJBayIZvbncJAU9jqeRPeWNzIAY5f+J1rhfZNFB47Kx04omWhZTBLyM9zXDwqlefBO5m1F+wx1PkHyNioGLFPmr8naDijZmbowZtRJlWZaXryqwTQFN0mWZGFBrAeCnh17AQumOTDDtPlw8Mw0GWTq3oVeyDu4CwhYKhkzS78AKkEtzYYyBymR1T553Ss2nDcSGCDThShu3qPOpdbvsxRTGlSmiomI4KwguoCvP2cd0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74267535-1366-4e31-3b9d-08d617c94dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 09:31:07.8783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3468
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Yeah that part was clear but the implementation can be better..
> > I thought over it and it seems having a new interface dma_ctrl_write_64
> > taking lsb and msb bits input looks better and scalable. It will be sim=
ilar
> > to existing vdma_desc_write_64 impl. I will send v2 if it looks ok.
>=20
> Yes that is much better, btw why not reuse same routine as common xilinx
> lib functions :)

Thanks.  vdma_desc_write_64 uses a different offset i.e desc_offset.
For reusing it we need to have an additional check to derive offset
(ctrl_offset/desc_offset) based on channel config type. Considering
it, i think a separate helper interface _64 for desc/control offset
simplifies the flow. Please let me know your thoughts on it.

-Radhey
>=20
> --
> ~Vinod
