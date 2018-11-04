Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F004AC0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806302082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 03:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NkdbFhdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806302082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeKDMxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 07:53:03 -0500
Received: from mail-eopbgr740104.outbound.protection.outlook.com ([40.107.74.104]:27904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbeKDMxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 07:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybdbD9Gm1PzcLyLaeDpxXAuUtYazli/sTcwo7s3lUsw=;
 b=NkdbFhdYFbFIfWP4J1KlLg+MzH1uOcJxG33+BuCmqakHQcE4JngZLOKLa2pL+x/Y7L2N4tB5RwChHwZj4HdGzkgiCv0KAJ0lqsi0+hZxhcJrSmKjjgHTCZOxrOw6hKAYGOJxBGLzlQSq+qh0U77TQmFp5ar/m8zjoWoXni3tvII=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.3; Sun, 4 Nov 2018 03:39:36 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::6d0b:b90f:7a73:99fb]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::8168:9429:a646:f916%20]) with mapi id 15.20.1294.014; Sun, 4 Nov 2018
 03:39:36 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "akataria@vmware.com" <akataria@vmware.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
Thread-Topic: [PATCH 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
Thread-Index: AQHUcgifYe6LR7d4Q0+wCx1mDqTim6U8GngAgAI08oCAAKvHoA==
Date:   Sun, 4 Nov 2018 03:39:36 +0000
Message-ID: <CY4PR21MB0773628CB5DEE1A1F11461C4D7C90@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1541093374-10496-1-git-send-email-mikelley@microsoft.com>
 <11f82d95-539c-b680-183b-b6c5c60468a8@suse.com>
 <alpine.DEB.2.21.1811031817570.3160@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811031817570.3160@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-04T03:39:33.6857397Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:meMTxnRv73N5bfW05/ZCmBUWBQ2vsda3R06Zw+zib2TkPjlFTFEqd0D0mlRkuSp40lMH4dkPrROZLlKdDJHvMkB7zy1irMqaGeHMsieRViBYRVxiAfPQFy1pgwkHUnSc0t86glCMbBBKUI7+3MqeQK9B+2oFAdgjIW1+UVH85fCJfep6BtNU4xrVLehwZsHOvV//I8DDXEXQJQaznQRk5IqoBI8novCP4dVLc4H8A/IsEu0Itl9r5K2DMxkJhsgSOhxe69tr0gurpnBrOISfZILg/8ZPzjhAYw9WAvxS2XqR9xt9UibzbugXBhbkA5KDv8cILk+eoTV0LlXFTftoHdVv7CtZGV1X+OBBEIBSq3uXInWdTMEpdTUoSUo2K2u5FXdzNYgzAh4ixxhFRdm6qodWm75Ssti5uVNS8dcSEqyUZIPa0bLtUPkeL9ElQtkdickiuDU1kyXe8bdOE++OKw==;5:9OppEnxYSkBd1+vRHv4/ZfVBt09uaNJWxv4xPB9YsWjSahW8GCTneKItNHRsRfrqXPdBId2JIknlFhD30zsrWNI97a5s23ogh/PUGD0NeqWToU8MHCpKYOF+65RCtv3JFVR4PdnIXWFxJGJQOTTfLNQnOsmhzh9nc99nrZSb62Q=;7:J+tMstCABHlMCoANvcvYrFC4jTredigCn+6Gfh+z2/7mZm/zTEf6e7/uFc/UyoTjKJR4xpB0rm7qAyCkq2XGwtDhBB/WAtYUD58DPc6qfBxTQA9lyQcVc6FrkntI/JTCb14ahLyWG+iR/4ZHXYR8yQ==
x-ms-office365-filtering-correlation-id: c2415a7b-0d12-4be7-d33c-08d64207249b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0119839C0038AECDA90E86A2D7C90@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231382)(944501410)(52105095)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 084674B2CF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(102836004)(66066001)(7736002)(74316002)(54906003)(6246003)(8936002)(110136005)(305945005)(10090500001)(229853002)(478600001)(71200400001)(71190400001)(446003)(10290500003)(2900100001)(5660300001)(22452003)(11346002)(486006)(476003)(99286004)(2906002)(7416002)(33656002)(316002)(76176011)(53936002)(9686003)(8676002)(186003)(3846002)(6506007)(25786009)(26005)(4326008)(6116002)(68736007)(97736004)(81166006)(86612001)(86362001)(81156014)(106356001)(256004)(105586002)(107886003)(7696005)(8990500004)(14454004)(55016002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0cZ6sfYA73ba+FBU2cleWha+goZnbGXBUKsCAn/HMX0XsFItGpIPxji3uEc8g4juUrZRtsjaA98amk0cpf3yPWUkUZBwPAuxFDarUUxnUrRmaZMaS6OYrp+RpSQl/WN3jPckT3y0LNEZDgc1wMxZQp0tb8FcC3+LysOIEWzEfBM+RE/B4/SH+Lex6XZhqrKhy0Ptwo5qrEPEgT5CJkxaygj6RICFUhbGJaNLZmS4zgtpj7/nj4y9hW6NAbaCBZfFOak2zpvQC2EGuyu38GYCW3zbawOp+QE+EFISvRkKy02Q8184Kl9e3YzhjXv7wlRD0pB35TOiV+e7oZzHlAsiioeas6UlJV2TRgIqCITT42A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2415a7b-0d12-4be7-d33c-08d64207249b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2018 03:39:36.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>  Sent: Saturday, November 3, 201=
8 10:22 AM
>
> > Did you consider using a static_key instead? You could set it in
> > ms_hyperv_init_platform(). This would enable you to support future
> > Hyper-V versions which don't require avoiding to set the count to zero.
>=20
> Duh. Now that you say it it's more than obvious. Instead of checking for
> running on hyperv have a quirk check in that function and set it from
> hyperv. Not necessarily a static key required as this is not a fast path,
> so a simple ro_after_init marked variable is good enough
>=20
> Michael, sorry for guiding you down the wrong road. Juergens idea is much
> better.

Thanks.  Will send a new patch set shortly.

>=20
> If you redo that, could you please make sure, that your mail series is
> properly threaded? i.e. the 1..n/n mails contain a
>=20
> 	 Reference: <message_id_of_0/n>
>=20
Argh.  Caused by a one-time foul up.  I'll make sure not to do that again.

Michael

