Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967A9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337B421527
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VpQdlocP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337B421527
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbeHBRqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:46:39 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:45286
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387538AbeHBRqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFKzHrZxfbYsyAqVd/bZte7RSZDBpmB+xAHbJj7InOc=;
 b=VpQdlocPa5j1xpmGpMwC9LUO6Qq9BMh1rzMBee0ZYvY9nS9vJO1C/Po3OnKqDFxZggF/V5zkRT2Dngete3VKiwHLoMWt8oWaycwWF/O3jFLHTrmvNKzIHNfFkvXH/SEJowJSfyu+4ccDytaNODOEYKXaYOPCOIBA+B2tT8KgJM4=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0906.namprd21.prod.outlook.com (52.132.152.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.7; Thu, 2 Aug 2018 15:54:50 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::53b:50b9:3d09:aff4]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::53b:50b9:3d09:aff4%5]) with mapi id 15.20.1038.003; Thu, 2 Aug 2018
 15:54:50 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH char-misc 1/1] Drivers: hv: vmbus: Cleanup synic memory
 free path
Thread-Topic: [PATCH char-misc 1/1] Drivers: hv: vmbus: Cleanup synic memory
 free path
Thread-Index: AQHUKe6NBBh7WH660kaJPBPrLCap+6SsA9aAgACaWTA=
Date:   Thu, 2 Aug 2018 15:54:50 +0000
Message-ID: <MW2PR2101MB11135C6C11EF22882D9215F7A02C0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <1533163513-10764-1-git-send-email-mikelley@microsoft.com>
 <20180802064133.jm5wo4e5ypn6p3xq@mwanda>
In-Reply-To: <20180802064133.jm5wo4e5ypn6p3xq@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:30e6:f011:23ce:afe2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0906;6:crSieEScxFCuXRiO+Lo9cnfcMDA4YOjviCibR/7V3T7j0rXCHxRgRgHP76Ejodt0SPMvuQu7GCF1+2I/SM5haiKxCgI4yYnQN0pDnK0ydIZc9cgKT8eDUvs8ZJCJtp4hEzspBlIHGgDvWvplih6GWZlZd4K2vUWjJr1yxavRBHfxtRYG6ljCdXO0+YX4nl9k7F0MEGF3bbgGAxS84J56Rb2iKsik9oFlzWtdItcDfE8NDQXz6Sh+RH9rmvqrJ4UpozvaqErOplKTLuiHWeexilCTpoPULceYQnTS3bPYcdUBa0ZmgF9zQQWIIlpdj0RGgBsSfhk0b09EYl46L7IURJLxkkrKlfe35ZI82a4HqKTXhaNm8ubRx5Ev57gOb7dOiQ5SceeN7kr7w3h1Z0aen4PFz1irAsVdvH/Tcznp6E4CL5nNKpQoYdM8YMfajSng8BXYqJOPlI/Vtpc0RUO66Q==;5:ZvZGMQfHymt/BzXv9TCrOnCJ9JL6+XQI0ljoEMenHqo24QbNzL5Mfe9BCgVc/Op8LicVVF81pnlTr11WKkqJ4cNota2MDFljQG8UTGKVOtOQZyNok4Fgc+fHX45v/dsFIB6tGNWQ7agzir2fzsNoclJeOxttLoFY76QnwAN2+c0=;7:rXiLdJJbSt1H5Lrn4mnU2D/KVaXsrcQ0XzQ4OSvtIZW/37AriP/opfz/11meDi6wKkMetDBRvIMd5EXnjCp8tnc2Ye0hOrv3CgKyIQr+q1Epq8keuluDkR9Pax4sPEIwn38DWn+IW3++41omq8m9LvDxts/nu/9sVpkjUd1G4kx/z7JGsM0BWiadnISV2RZc5EVvu3EH4BSXcHvXJloAoA31vD9EI/AN+bA6BUe/ILc1R1vz2HBBy4mvEfu+uTjd
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fd960bdb-1a6a-46bf-c671-08d5f89047fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0906;
x-ms-traffictypediagnostic: MW2PR2101MB0906:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB0906E644C19B08D44D82A7C7A02C0@MW2PR2101MB0906.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(146099531331640)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0906;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0906;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(13464003)(6506007)(5250100002)(33656002)(4326008)(6246003)(99286004)(8990500004)(107886003)(53546011)(10090500001)(6116002)(486006)(53936002)(55016002)(2900100001)(229853002)(9686003)(6436002)(68736007)(97736004)(102836004)(1511001)(22452003)(316002)(446003)(106356001)(7696005)(76176011)(105586002)(110136005)(25786009)(6636002)(7736002)(11346002)(305945005)(256004)(74316002)(46003)(5660300001)(476003)(86362001)(575784001)(14454004)(10290500003)(54906003)(86612001)(478600001)(8936002)(8676002)(81156014)(81166006)(186003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0906;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4ralrLIDdcyxLWmvuwiTfNQPuBpoHFQbkJjo1Ma3QOQNMIfI+hkIYto0LscEuTSJ3OKVZ2t1FSV38biBiU5mRF5FC545VC0NCrywq0M1xD2XGhC1OwHnCXeSyAq4NCnPPQF1zr/kRrDCNVK7iMWFALPpcBRzN4IDkuYvtpos1vjEKe93lgAB64MuoOYc5ZcWxdEp8RWuQkOn245pKMfCdPKWivVm2XYg4eQzawFV1l6quj0F41kW5L1BDmWFT913gL6rv5jZ3oTm3U02IT4Lxort+j84o7BzNHLW+PwrOk4480o9VqvYqq6uaBXZTssWy2L0m6khuVDcBAKI6N3MObHos5erS8Zn39IJmfgtLBE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd960bdb-1a6a-46bf-c671-08d5f89047fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 15:54:50.7932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Wednesday, August 1, 2018 11:42 PM
> To: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; jasowang@redhat.com;
> marcelo.cerri@canonical.com; Stephen Hemminger
> <sthemmin@microsoft.com>; KY Srinivasan <kys@microsoft.com>
> Subject: Re: [PATCH char-misc 1/1] Drivers: hv: vmbus: Cleanup synic
> memory free path
>=20
> On Wed, Aug 01, 2018 at 03:45:13PM -0700, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mikelley@microsoft.com>
> >
> > clk_evt memory is not being freed when the synic is shutdown
> > or when there is an allocation error.  Add the appropriate
> > kfree() call, along with a comment to clarify how the memory
> > gets freed after an allocation error.  Make the free path
> > consistent by removing checks for NULL since kfree() and
> > free_page() already do the check.
> >
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/hv/hv.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > index 8d4fe0e..1fb9a6b 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -240,6 +240,10 @@ int hv_synic_alloc(void)
> >
> >  	return 0;
> >  err:
> > +	/*
> > +	 * Any memory allocations that succeeded will be freed when
> > +	 * the caller cleans up by calling hv_synic_free()
> > +	 */
> >  	return -ENOMEM;
> >  }
> >
> > @@ -252,12 +256,10 @@ void hv_synic_free(void)
> >         for_each_present_cpu(cpu) {
> >  		struct hv_per_cpu_context *hv_cpu
> >  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> >
> > -		if (hv_cpu->synic_event_page)
> > -			free_page((unsigned long)hv_cpu-
> >synic_event_page);
> > -		if (hv_cpu->synic_message_page)
> > -			free_page((unsigned long)hv_cpu-
> >synic_message_page);
> > -		if (hv_cpu->post_msg_page)
> > -			free_page((unsigned long)hv_cpu-
> >post_msg_page);
> > +		kfree(hv_cpu->clk_evt);
> > +		free_page((unsigned long)hv_cpu->synic_event_page);
> > +		free_page((unsigned long)hv_cpu->synic_message_page);
> > +		free_page((unsigned long)hv_cpu->post_msg_page);
>=20
> This looks buggy.
>=20
> We can pass NULLs to free_page() so that's fine.  So the error handling
> assumes
> that hv_cpu->clk_evt is either NULL or allocated.  Here is how it is allo=
cated:
>=20
>    189  int hv_synic_alloc(void)
>    190  {
>    191          int cpu;
>    192
>    193          hv_context.hv_numa_map =3D kcalloc(nr_node_ids, sizeof(st=
ruct
> cpumask),
>    194                                           GFP_KERNEL);
>    195          if (hv_context.hv_numa_map =3D=3D NULL) {
>    196                  pr_err("Unable to allocate NUMA map\n");
>    197                  goto err;
>    198          }
>    199
>    200          for_each_present_cpu(cpu) {
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We loop over each CPU.
>=20
>    201                  struct hv_per_cpu_context *hv_cpu
>    202                          =3D per_cpu_ptr(hv_context.cpu_context, c=
pu);
>    203
>    204                  memset(hv_cpu, 0, sizeof(*hv_cpu));
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We set this cpu memory to NULL.
>=20
>    205                  tasklet_init(&hv_cpu->msg_dpc,
>    206                               vmbus_on_msg_dpc, (unsigned long) hv=
_cpu);
>    207
>    208                  hv_cpu->clk_evt =3D kzalloc(sizeof(struct clock_e=
vent_device),
>    209                                            GFP_KERNEL);
>    210                  if (hv_cpu->clk_evt =3D=3D NULL) {
>                             ^^^^^^^^^^^^^^^^^^^^^^^
> Let's assume this fails on the first iteration through the loop.  We
> haven't memset the next cpu to NULL or allocated it.  But we loop over
> all the cpus in the error handling.  Since we didn't set everything to NU=
LL in
> hv_synic_free() then it seems like this could be a double free.  It's pos=
sible I
> am misreading the code, but either it's buggy or the memset() can be
> removed.
>=20
> This is a very typical bug for this style of error handling where we free
> things which were never allocated.

Thanks Dan! We will fix this issue soon.

K. Y
>=20
>    211                          pr_err("Unable to allocate clock event de=
vice\n");
>    212                          goto err;
>    213                  }
>=20
> regards,
> dan carpenter
