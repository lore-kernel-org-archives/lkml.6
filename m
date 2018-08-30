Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E040C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE2720835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L42sDe25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE2720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeH3Voc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:44:32 -0400
Received: from mail-pu1apc01on0108.outbound.protection.outlook.com ([104.47.126.108]:34016
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbeH3Voc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WYrYo8gYoHFF4SKlbLwk46/RwWPiXs+mtxaW+Segtw=;
 b=L42sDe258O7SxlVG7Xkw8/UmrWgrwwPPqsWDukItnSp2QLHmZpfLO4xcsxROb6qAYoLAN8ghzf4NxIEXIiR5WUefK6Le/z4vAI7WogvnZYQPu3NDVbXBuIMn2TqJvD5ZZrVjyDE7qsvUzg5krdj0Rw/s2s7tV1vW5Mma5Nk29l4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0122.APCP153.PROD.OUTLOOK.COM (10.170.188.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Thu, 30 Aug 2018 17:41:09 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::b835:d23a:7cda:c4e1%2]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 17:41:09 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Use raw_smp_processor_id() in
 vmbus_connect()
Thread-Index: AdQ7H/34qAH7zeGBQLegJ1KnxB9zFAFWLlUAAAM1tsAAAE/x8AAAN4Bg
Date:   Thu, 30 Aug 2018 17:41:09 +0000
Message-ID: <PU1P153MB016985CD0F24D34445E280C7BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01694E53D6A6192A46EA3214BF370@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <MW2PR2101MB11138A251E48BC8C6B859BF1A0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <PU1P153MB016943FAF912D00D54F46493BF080@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <MW2PR2101MB1113456E92B548A3405A0E5AA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1113456E92B548A3405A0E5AA0080@MW2PR2101MB1113.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-30T17:41:05.5672530Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a27f:df20:5d83:f0e3:72fb:2536]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0122;6:UsWjY2t6Wbue1XPar3PUC/r/ZxOSjWguKJRWqkJffyDuNq9VCwMlAimfQ1G7eV/ZYYY1eO2+Yny5s9+xsNAnu1AA6x2ocwegOeEwnoc9KJ+h7rJB34P0Hvab9U8OsiYPus+3B0YvKYxRduvsIINmJAUqhyjadoKmoS/U6ksa3+hHu9IyaUyrt2kSJwPXGsyIXhpaTi4wAMPbN8djDlTUpqIN9JQtEOxKyxEDhFU5cYftBUtONF8RdmEqWhrGNnLtXxqJ1byAAT4QW4NfxRoy5aIUhQRaZcLcUOrG6WnoKJabGgoISdoVhUCW6BegkUMckGwmhjd/JaPbe/9c/+CQB3dPnZyECWGFopm+z2Ty5tbEZzlsudTRHtkAwkZ3Ct/WwWGYB8RHuD7AeD8DCB7PKQO1E3vh7xMZ12gcmykpnLCqDgj1xpNYuiJmWaktkInZEeWW6jWFF9P4pfNZCyc2SA==;5:IlEKZcEibkHqMcd1JB+OB5F9wAxwkHnoVSZSQsP/T/0nnI1IaPbJa8w9iioqxPhUFrDjMe9mdbjJNCXJRK30xJdBJC24IlpqlZpdQnnrwBovlu6iar7roH94MprqcTHAa5O5iUwTn6VbGrnws16h0D33ZoG21B/0mpUN35aB7Mo=;7:vQT4uCvUiW6YqARRqELXRrgJ79NVW20OMK2ykiRLiqTjOR7Z5yGWDGbkBVKUlEAYtdR68UZ1D8ayy2+zW8ZziqeDyVRkDo0FHNry69EIzs+/lRP+X3V82vUa/F1kJEHjiTd3OA72V2YFR6nogbOT3hudOeKsUqFWXOFXXf36Dmj9X6esDYfcYS1Yu4vl9kdmACdzSa4lvDxeXZuMMEkWzn1AquLBQyqONLlx2gaA4YmtYtHhWCR+V2IUTT7yi9W4
x-ms-office365-filtering-correlation-id: cdfb51d1-6c3a-485c-5338-08d60e9fc5b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0122;
x-ms-traffictypediagnostic: PU1P153MB0122:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0122CD90CB60F1FCDB03C409BF080@PU1P153MB0122.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:PU1P153MB0122;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0122;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(81156014)(14454004)(5660300001)(33656002)(76176011)(74316002)(305945005)(7736002)(86612001)(6116002)(106356001)(86362001)(6436002)(46003)(7696005)(8990500004)(68736007)(99286004)(25786009)(97736004)(5250100002)(478600001)(6636002)(8936002)(8676002)(81166006)(256004)(10290500003)(10090500001)(14444005)(2906002)(6506007)(102836004)(110136005)(22452003)(1511001)(55016002)(53936002)(9686003)(54906003)(486006)(2900100001)(105586002)(11346002)(316002)(4326008)(476003)(93886005)(229853002)(446003)(6246003)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0122;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dkjb6bpsnvGNlCBc8LNlypQKBT7fC0aoDCuuzxmMAkOB8vDp1SKa1ZZmeJb67DNbgImEi8SjAmq3VVwSr/YY45izHC3TEepWo+50fdf3X1KI8iWwkbqpI4zWwtN8B6iEHbHVDVvTMdGuokmMT8FvhFY2x+rdriXYqjA7hyEkqyv9gqMPP66pjYYV6s+LuQLRlx1z8iCca7/PUyOtclgnZ7hlhIkLh1I5kCBv2xgDHyfvH/XsOo6fNMhJB54AhmoHGc2GPCOF/2VOcidZfOj70NtH1i4mdD9uklShdcArIxk1/SgnIbcol074YwWt4cmbrZlZtc5Bqp0+XJmB5OwVkXpJ3B4iZ6p99UngQYkkvek=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfb51d1-6c3a-485c-5338-08d60e9fc5b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 17:41:09.5159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: KY Srinivasan
> Sent: Thursday, August 30, 2018 10:32
> > >          */
> > >    if (version >=3D VERSION_WIN8_1) {
> > >        msg->target_vcpu =3D
> > > -            hv_cpu_number_to_vp_number(smp_processor_id());
> > > -       vmbus_connection.connect_cpu =3D smp_processor_id();
> >
> > > +       hv_cpu_number_to_vp_number(get_cpu());
> > > +       vmbus_connection.connect_cpu =3D msg->target_vcpu;
> > > +       put_cpu();
> >
> > While the warning " BUG: using smp_processor_id() in preemptible" can a=
lso
> > be avoided, the line
> > +	vmbus_connection.connect_cpu =3D msg->target_vcpu;
> > seems incorrect, as the "connect_cpu" should reflect Linux CPU numberin=
g
> > rather than Hyper-V's vCPU numbering.
>=20
> Yes of course!  Can you send me a patch with the fix.
>=20
> K. Y

Ok. Will do.

-- Dexuan
