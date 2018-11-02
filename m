Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58295C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4122081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="We+VKkfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4122081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeKCHEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:04:35 -0400
Received: from mail-sn1nam02on0090.outbound.protection.outlook.com ([104.47.36.90]:60384
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbeKCHEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZZke8yHbwAIURF3N3Mbs1ahAXmXdQe+syuT3+ARwMk=;
 b=We+VKkfb7Sy/1fxd/S//7JNwz6G4kKyKSoXomY7ZOzBMQEPQ1UpLIUO5yW5Biw9lJMD45Cobc20wIBgMXXApaz5Oa0zUUiZiTzjmWKGDxWeWEkqwjyIqBvtdBLKKmZsRL5I7Qy3oVbsR9HiaH6c1zc4n6shgsXYLP5jm2lRToX4=
Received: from CY4PR2101MB0804.namprd21.prod.outlook.com (52.132.100.38) by
 CY4PR2101MB0721.namprd21.prod.outlook.com (52.132.98.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.9; Fri, 2 Nov 2018 21:55:35 +0000
Received: from CY4PR2101MB0804.namprd21.prod.outlook.com
 ([fe80::b922:44e9:332d:aab5]) by CY4PR2101MB0804.namprd21.prod.outlook.com
 ([fe80::b922:44e9:332d:aab5%3]) with mapi id 15.20.1294.014; Fri, 2 Nov 2018
 21:55:35 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Dexuan Cui <decui@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: RE: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Thread-Topic: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression
 caused by incorrect clean-up
Thread-Index: AQHUZqDq9mQr3C04KUSXSQHeogE0bKUukceAgAuCiwCAAUeoAIABxCBQ
Date:   Fri, 2 Nov 2018 21:55:35 +0000
Message-ID: <CY4PR2101MB0804234F74AA6A520D3A492CA0CF0@CY4PR2101MB0804.namprd21.prod.outlook.com>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
 <20181018050932.27932-3-kys@linuxonhyperv.com>
 <CY4PR21MB077329FE239A11054FFDD661D7F60@CY4PR21MB0773.namprd21.prod.outlook.com>
 <PU1P153MB0169588D48E567E0551D4A9FBFCD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181101185638.GB10263@kroah.com>
In-Reply-To: <20181101185638.GB10263@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:0:b4e9:dcd3:41b6:82a2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2101MB0721;6:bxVOg+pW4w8w6645xknT7pZjc5NueexUVFKfw1P8GkaCLc6mGQAVt4wNHAFnADQ5zNUeD9R6ip/PnTPbPItIScx2BUYAclkPLHt4EzgVYYAGduUb3u9xMzz4gUk8FerXZI/wKmok5YaMohd7GsZTfDtyIpXNgMFm6YBRJ+wg2G6ij9wTso/Z6LOEtdsx1kPWbx3EcFimpNZatEI46ZubTHVW+rSk3vuca1ap2eXXav3ssVvQKGJlDjZ7TEybqRwlcfDler/dUIwS/l5lJiORkejIu4SGAy9I9uZymWZZ4vW2gDpdUNzva0MjRyuSmRUoHY436njc45hcJGmxwd0KJHMkl91a3h7FK4/fruh45aOUKLGBKtwjGBLqQBG8uW5KQDWkWlvNvDFcOL6mUY3QS8/+hNI8mCEFiS2ylIujM/KTH465q1iFQ15gvI6z96BqY33zrlfFrW6mHqSv/J08Hg==;5:dg5A/Jp3YGadecqwwMLhmHo2ABppQi6xQVYAUBRMwdZDGV44Ce/s39Hu53PnglByoMd2B6KGmvKbgAt3vvNw+OQkD6JKaoUdi5BkVFJD1k/OtyX2m6mXCsaavNkYUGvdKVxiAv9g662C/bh8gRTYmMRX/JvOdJu1lj2GVzGo+z8=;7:PhSCIYLRckHkvzDVGUma3P/0ZuclBxKOxllSRsZxrBwvrQseMuipDU6cOMEY+hIfYUcUxKAWGL65ZG0RTNkhRAmpLr3vMCoX/4dEzj50N66ehv8YlyLDfEyFaSNgAnikLkV4TT0pii++hKD2wuNLww==
x-ms-office365-filtering-correlation-id: 0ec7f9bf-1e8e-4436-9ae2-08d6410deb0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR2101MB0721;
x-ms-traffictypediagnostic: CY4PR2101MB0721:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR2101MB07210EC9BFE508D61DAC048AA0CF0@CY4PR2101MB0721.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201703061421075)(201703161042150)(20161123560045)(20161123558120)(6042181)(201708071742011)(7699051)(76991095);SRVR:CY4PR2101MB0721;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2101MB0721;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(13464003)(199004)(189003)(105586002)(1511001)(10290500003)(106356001)(2906002)(68736007)(33656002)(93886005)(22452003)(256004)(6116002)(86612001)(9686003)(8936002)(6636002)(8676002)(81166006)(71200400001)(86362001)(81156014)(486006)(110136005)(11346002)(476003)(229853002)(498600001)(305945005)(7736002)(446003)(8990500004)(54906003)(14454004)(6436002)(6246003)(2501003)(5660300001)(74316002)(53546011)(99286004)(4326008)(76176011)(7696005)(102836004)(71190400001)(186003)(2900100001)(53936002)(97736004)(55016002)(46003)(10090500001)(25786009)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2101MB0721;H:CY4PR2101MB0804.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zIohk3bvOfyEBpYAefxCXDMFzxbq3XQhG26warBSTwBZSdFQc9MQ5WNyNqlVKfl0AzgPU6ENI+4fT/cOAtZEwa3gENs3U4+mSQL2O6WD6DSR3GIGc1/KUhIRUIxG5NddM7NkH232hv9B3KNR7+tmgcJibUtPNXdtIwCa/5PqR66CCSwvu/0PMDo5bd2BqddFR7Hsiohuiu6eiFPRBy4mE6rUwJVukzSURnsecFlHgsIQJn05XWfKPqFUjfFuMp6QneqLTOUNEVbbXZ5fUDeKDimpRiT06irxpn8OOwBSz+j2GOKzC9xfzC0tmLs84+6geyxyommOciUMUASDnAyZ63gtCTg0qAa89KTU14m9pdA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec7f9bf-1e8e-4436-9ae2-08d6410deb0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 21:55:35.1385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Thursday, November 1, 2018 11:57 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; Stephen Hemminger <sthemmin@microsoft.com>;
> vkuznets <vkuznets@redhat.com>; Sasha Levin
> <Alexander.Levin@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stable@vger.kernel.org
> Subject: Re: [PATCH V2 3/5] Drivers: hv: kvp: Fix the recent regression c=
aused
> by incorrect clean-up
>=20
> On Wed, Oct 31, 2018 at 11:23:54PM +0000, Dexuan Cui wrote:
> > > From: Michael Kelley <mikelley@microsoft.com>
> > > Sent: Wednesday, October 24, 2018 08:38
> > > From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent:
> Wednesday,
> > > October 17, 2018 10:10 PM
> > > > From: Dexuan Cui <decui@microsoft.com>
> > > >
> > > > In kvp_send_key(), we do need call process_ib_ipinfo() if
> > > > message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it
> turns out
> > > > the userland hv_kvp_daemon needs the info of operation, adapter_id
> and
> > > > addr_family. With the incorrect fc62c3b1977d, the host can't get th=
e
> > > > VM's IP via KVP.
> > > >
> > > > And, fc62c3b1977d added a "break;", but actually forgot to initiali=
ze
> > > > the key_size/value in the case of KVP_OP_SET, so the default key_si=
ze
> of
> > > > 0 is passed to the kvp daemon, and the pool files
> > > > /var/lib/hyperv/.kvp_pool_* can't be updated.
> > > >
> > > > This patch effectively rolls back the previous fc62c3b1977d, and
> > > > correctly fixes the "this statement may fall through" warnings.
> > > >
> > > > This patch is tested on WS 2012 R2 and 2016.
> > > >
> > > > Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may=
 fall
> > > through" warnings")
> > > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > > > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > > > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > > > Cc: <Stable@vger.kernel.org>
> > > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > > ---
> > > >  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
> > > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > > >
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> >
> > Hi Greg,
> > Can you please take a look at this patch?

Greg,

I have already signed-off on this patch.

K. Y
>=20
> Nope, I'm not the hv maintainer, they need to look at this and ack it,
> not me :)
>=20
> greg k-h
