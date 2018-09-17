Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1846EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7A0206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y3mHLBnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7A0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeIQUxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:53:19 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:14336
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728859AbeIQUxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es3OiffKguouSFtrtWMluuLT20544AaKnOv2PbZnZWg=;
 b=Y3mHLBnlQuy9WAUdm8+ov9waAMKyDC+almjRf250WpAwex+DtaSueWz2qGqQ+jPJjJw/WzUypW/uq7PcrdzaDCL39KzmxRlLPnZxp9EMZk2orhbERqijAXK4stwxsdHHHNVf2Eiw/ucddqKGoMSFp+RJwYd2Z1ru99Yo/MHSGHM=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0939.namprd21.prod.outlook.com (52.132.146.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.15; Mon, 17 Sep 2018 15:25:22 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::8dea:f5e5:67f7:c879%5]) with mapi id 15.20.1185.006; Mon, 17 Sep 2018
 15:25:22 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown
 operation was requested
Thread-Topic: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown
 operation was requested
Thread-Index: AQHUTj0kC9QAPEQ0iE6UniLG57hPj6Tz6QmAgACbuWCAAAQqAIAAD9ZA
Date:   Mon, 17 Sep 2018 15:25:21 +0000
Message-ID: <MW2PR2101MB1113B8449D633C9D12BA5A07A01E0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180917041352.11402-1-kys@linuxonhyperv.com>
 <20180917041455.11455-1-kys@linuxonhyperv.com>
 <20180917041455.11455-2-kys@linuxonhyperv.com>
 <20180917045613.GA25435@kroah.com>
 <MW2PR2101MB11138F9E55814399F152859FA01E0@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180917142828.GA31799@kroah.com>
In-Reply-To: <20180917142828.GA31799@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:2537:f2ed:4e7c:3212]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;6:EUklc5t/f6ME9YhuO1vYD0gvvbLByjMcnHHhEXTCF82uztBjOU0+Qi8nUNledXvYzBzkTbA4E+Vub1iSkCqvLycI2tzB3FXGuUhbqESnShZb4Ucciwbda0lznLZJOczjxXjOEcT9KR0/XNs4ReNRFtsNwjGRCpvqkYcSUf4i6WVo2mn2UyuecA81kYEEVqXRZ9j/hdpYkcEQWEr5sJCnPHb5wEeT9V7IwxYTRyonHt4JPzgkkE09ek/IUAqc1doFbFJnSWtVcf7U4FKE272Nt9uTJod8VVeiaMm9JYHnwShLEIt8HBybrJYxAADmOfTtTSdFzGerR6BJIrY95hpxAOXfku27+0u2SRzLac4iPRNiO0j786K3Kam8z5v7LLsyWzwSz38pnU7dyz9k1slz2ALI+TrCgHjfrtsNf4Fy+b+W6sxVlWaoj8uiucXkqNQeNovMYOaJtZzYDchouzMCBg==;5:Hyv5JFfCV7NeMmaGSMHrqwRmC4XJEn5hmUVJHqx4KIA4SWeKk1MOBO0PrIbgkokDzLjwrRLYhHExlqFILqxeOMpfwzrikjSNONSHmbyTY/WEjpqASSgR48b6/4ailxrSB1hydenbFAER86qBQmf907zTu3buxGraBmAmUd4QLtw=;7:2GZa0HSiuWK5sHhIayzYuyWSfrOR2BcpiPTVNfHAxMqG0Qya0vxD+QkqKZTh0oCpZJ6CvweTnlKs2H2jW9y02ffrLa0a6AP1yoenIOmcUhE27kfVfiYYXxLucb87fZPXqQxWgGPqBrQqvG44aFO6v8Pg8VRBvbXlRg+o0PSJzhNdKhkmGgJ1SqZJ5GK0ikBgG2haQoCEfYpSxAKBCQ1KTKuSdYWoPZtMF0MMhS4YJqU3xTjLbfWBQnqADe/UqldH
x-ms-office365-filtering-correlation-id: 8b08e10c-d141-4f82-6ead-08d61cb1c917
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09397619BE8FD181CD2965DDA01E0@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(13464003)(189003)(199004)(316002)(68736007)(6116002)(5250100002)(33656002)(478600001)(86612001)(6436002)(7736002)(486006)(22452003)(8936002)(55016002)(53936002)(76176011)(14454004)(2906002)(9686003)(7696005)(256004)(53546011)(10290500003)(6916009)(476003)(305945005)(2900100001)(25786009)(6506007)(5660300001)(99286004)(186003)(74316002)(54906003)(6246003)(93886005)(6346003)(229853002)(8990500004)(97736004)(81166006)(106356001)(105586002)(11346002)(86362001)(10090500001)(46003)(8676002)(81156014)(102836004)(446003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-message-info: vXSh0BfgKwqBm7CnvNFVBIxYrIeuSakNpEwIztvXyToMhpuPy2fuaE6lzfbNbC2QcXzKaQRb1XYJPf+EPf2RRnQFEA4QoytIQOmnc6ns5JuvcOD6LyJXYb2ok1TwxeXToP/nKirjGZSPjxMq1UpAFotIqmmuFklv7nRvvpuxgwh+TZlZoHLIUTuEZFS0wNoNDA9HIq+cQKvqc6+FTeq7ZgaJbwk2Dp3kWhoGx+PXbR6Hehmsrrm9+6K1B51trh7aSEyBrNa+YOSV1OYuQX4xd7ljt59j0iyEVpc5qj8108OH/jL5qRwrgm1t9hcHvLfJkjhSDCHnu5EGr11r64Xqm5v6pwYR/Q5IVB9yTQhbK/w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b08e10c-d141-4f82-6ead-08d61cb1c917
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 15:25:22.6708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, September 17, 2018 7:28 AM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: olaf@aepfle.de; Stephen Hemminger <sthemmin@microsoft.com>;
> jasowang@redhat.com; linux-kernel@vger.kernel.org; Michael Kelley
> (EOSG) <Michael.H.Kelley@microsoft.com>; apw@canonical.com;
> devel@linuxdriverproject.org; vkuznets <vkuznets@redhat.com>
> Subject: Re: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unknown
> operation was requested
>=20
> On Mon, Sep 17, 2018 at 02:16:48PM +0000, KY Srinivasan wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Sunday, September 16, 2018 9:56 PM
> > > To: KY Srinivasan <kys@microsoft.com>
> > > Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> > > olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; Stephen
> > > Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> > > <Michael.H.Kelley@microsoft.com>; vkuznets <vkuznets@redhat.com>
> > > Subject: Re: [PATCH 2/2] tools: hv: fcopy: set 'error' in case an unk=
nown
> > > operation was requested
> > >
> > > On Mon, Sep 17, 2018 at 04:14:55AM +0000, kys@linuxonhyperv.com
> wrote:
> > > > From: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > >
> > > > 'error' variable is left uninitialized in case we see an unknown op=
eration.
> > > > As we don't immediately return and proceed to pwrite() we need to s=
et
> it
> > > > to something, HV_E_FAIL sounds good enough.
> > > >
> > > > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > > ---
> > > >  tools/hv/hv_fcopy_daemon.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > >
> > > No need to backport for stable?
> > Thanks for pointing this out. Should I resubmit with the stable tag?
>=20
> I can do it... :)
Thank you!

K. Y
