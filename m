Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66ABC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804D1214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nzb/0R3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804D1214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJQNxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:53:23 -0400
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:19780
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726429AbeJQNxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF7jnjsp7wdXjtrbSnU7j0UJ5z0/OdoeQN8eTWjjhYk=;
 b=Nzb/0R3MFqYNZmiZpuzTmMGj6E+ZO8Jf+l1nwaeDfGvEQlV6ImifjnT7apmA62rE2aDfqGp9EOl3gGGgsOhj1lNFPoowq7v8zxSQg5OwTeCj+c6qcuuQpLBx4+1sVUCZXwcPyrJzpx2GDRAkx07kAyhOOqXlKTGKaytT/pFpsVM=
Received: from SN6PR2101MB1118.namprd21.prod.outlook.com (52.132.115.32) by
 SN6PR2101MB1021.namprd21.prod.outlook.com (52.132.116.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.1; Wed, 17 Oct 2018 05:59:20 +0000
Received: from SN6PR2101MB1118.namprd21.prod.outlook.com
 ([fe80::dc2b:5afa:e768:4791]) by SN6PR2101MB1118.namprd21.prod.outlook.com
 ([fe80::dc2b:5afa:e768:4791%5]) with mapi id 15.20.1273.004; Wed, 17 Oct 2018
 05:59:20 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 1/5] Drivers: hv: vmbus: Get rid of unnecessary state in
 hv_context
Thread-Topic: [PATCH 1/5] Drivers: hv: vmbus: Get rid of unnecessary state in
 hv_context
Thread-Index: AQHUZcef1et9N4RQ/kO4sJA3u6BssaUi4lcAgAAO2ZA=
Date:   Wed, 17 Oct 2018 05:59:19 +0000
Message-ID: <SN6PR2101MB11182BB44E4F099A3D17D1BDA0FF0@SN6PR2101MB1118.namprd21.prod.outlook.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017050458.GD22447@kroah.com>
In-Reply-To: <20181017050458.GD22447@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:506a:a801:e603:e795]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1021;6:QTq9lpMMPRTc1QovpQcSJRKFWaXm6JaKKSP8Cm2wfztEC3H+zTwPkw5WZUUC5xDI3YzRXTZx3ZPIcXjI4xO2cGxgKd39do1nq76cRJOQAuDFg+lbLe8RqPes28y/sj0TAWut0372hY4Tt5RR+JR3tPSPm8Rpfqtz+E01fPIsjqCA5FrgpfZhSfAORW5UTOl2xD+1bquxskoCfCM+DfKcT8FFeyOkpSSdf1hkrKqxcPM/hqiKYBxow0QTNW4GY1ifAEtVHWs9o6MM0KBItt4irl7fOUW1Rf1Qzo+NU7dHUeSMHoUooXexQfI+tmsXXXrmpE+fIKVdXJ63JQ/ow85VBgQ9/vk5kpfiSe7q5JNgL789349bfg7vRogLJMybYfzi4eshkl9rEOV25o+dzMvozOIMuSRS+Rtk3az01XNYsC7+eeiWyf3AbhBkA/N7VNXDRKzn8STmx8hd+mdB0oX2UQ==;5:fCq5e3pQ9KZVG0ZB5R+fsAUd8HixZMztqFsR/TC3eNItSr3uLdCXl8FqF3kU5zkfskr8n4ztKl4cHVtU8gOaFV6fST+0l4LYnsegIdQ76YRXCnb0JycLeVdkKp9iZ4yaXlsGaY0gfX+BPX5sNlrq4T+RYmtdhha7tBXjd0oKrMU=;7:2zZIhb63VxoPUoeEfTxp1q+3JwMeISTqR4M9kA94NflsKUGCySocLalwleKNEaeizb+PPC7CqZZpflWqyc7l8BZup+HkzDgLx9WNQmG0WIu3cTLReiPfvY+kIuwmy4hQwUWLl0+xXKfUhpmRvxpC2Q==
x-ms-office365-filtering-correlation-id: cf99a29b-b46f-431c-5753-08d633f5ae30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1021;
x-ms-traffictypediagnostic: SN6PR2101MB1021:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB1021EBA2716E85D43BE4D3F7A0FF0@SN6PR2101MB1021.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991092);SRVR:SN6PR2101MB1021;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1021;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(396003)(136003)(13464003)(189003)(199004)(305945005)(8936002)(53546011)(33656002)(7736002)(6116002)(10090500001)(76176011)(81166006)(81156014)(46003)(8676002)(8990500004)(6506007)(71190400001)(106356001)(71200400001)(2900100001)(476003)(446003)(105586002)(11346002)(5660300001)(486006)(68736007)(229853002)(97736004)(10290500003)(86612001)(5250100002)(54906003)(478600001)(25786009)(53936002)(316002)(86362001)(256004)(22452003)(99286004)(74316002)(6436002)(2906002)(4326008)(102836004)(186003)(7696005)(6916009)(14454004)(55016002)(6246003)(9686003)(26583001)(24704002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1021;H:SN6PR2101MB1118.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YrljUKGVRI1PKKnecb1B+UoCaP5TJrlQGKunOFfy8Db5UUqGs6DnV1uSiTVBMiC1e65nI2/N9RpOXS7gi5ieAVzW1Pg82pkk0TKdnCx9rJvLWAERoReJE9Ypkl7vKDCntkq70yV7UNSvF9cr02GUCS9Qso/NqhLwsxA1iwkFgFXhw0OIUvr9Oi70HMQ5/NVjvKyUvmTLmNwKxQnidxdRhrY/EkBC+LQnw14woIQnYIxBS/8yR9wpZVRXCr60yqgrXjWI+081r7UsBddpGSNh9MCZasA/f1vY8yYXFT8jb56GiJxhI1C6oMTIocNAN7LGpH0/gdlSdf/tF0OYZXnYwRN93m94+fTYxloERpVgcow=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf99a29b-b46f-431c-5753-08d633f5ae30
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 05:59:20.0390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, October 16, 2018 10:05 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets <vkuznets@redhat.com>
> Subject: Re: [PATCH 1/5] Drivers: hv: vmbus: Get rid of unnecessary state=
 in
> hv_context
>=20
> On Wed, Oct 17, 2018 at 03:14:02AM +0000, kys@linuxonhyperv.com wrote:
> > From: "K. Y. Srinivasan" <kys@microsoft.com>
> >
> > Currently we are replicating state in struct hv_context that is unneces=
sary -
> > this state can be retrieved from the hypervisor. Furthermore, this is a=
 per-
> cpu
> > state that is being maintained as a global state in struct hv_context.
> > Get rid of this state in struct hv_context.
> >
> > Reply-To: kys@microsoft.com
>=20
> Why is this here?

No sure how this happened; will fix it and resend.

K. Y
>=20
> greg k-h
