Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BD8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF07214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lOTez9p0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF07214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJQN4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:56:05 -0400
Received: from mail-by2nam01on0121.outbound.protection.outlook.com ([104.47.34.121]:11422
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726429AbeJQN4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2Jt7lViBjoGzXIEU8SFrVcC9pMSlhkmcwMvuyAVCLU=;
 b=lOTez9p0tLccS8f2tyLqd5hsP4tp/mFI9sr8WiTC9AQmomvbvGOG/GLsxe38KAMVRZ69crYAx9Dr2xrjsZVhgBZaAws+yzO4EjbLGEyJ3//rDfM6rYsK5KBY93DxDkRZPbmGRdJKDSPerH4DL6AxkLARyPUIOKFzXDy3LtjsfTw=
Received: from SN6PR2101MB1118.namprd21.prod.outlook.com (52.132.115.32) by
 SN6PR2101MB1037.namprd21.prod.outlook.com (52.132.115.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.5; Wed, 17 Oct 2018 06:02:02 +0000
Received: from SN6PR2101MB1118.namprd21.prod.outlook.com
 ([fe80::dc2b:5afa:e768:4791]) by SN6PR2101MB1118.namprd21.prod.outlook.com
 ([fe80::dc2b:5afa:e768:4791%5]) with mapi id 15.20.1273.004; Wed, 17 Oct 2018
 06:02:02 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: RE: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused by
 incorrect clean-up
Thread-Topic: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Thread-Index: AQHUZcefp2c2L/xHKU6ef38i9wdqSqUi4u6AgAAOufA=
Date:   Wed, 17 Oct 2018 06:02:02 +0000
Message-ID: <SN6PR2101MB1118766D1B569319FDB8E5FCA0FF0@SN6PR2101MB1118.namprd21.prod.outlook.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-3-kys@linuxonhyperv.com>
 <20181017050705.GE22447@kroah.com>
In-Reply-To: <20181017050705.GE22447@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:506a:a801:e603:e795]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1037;6:1AYYAr4bHRkYDYokJ5sp3DSRAEjF8iWQ/4wf0SXbaSONJxYnzhNTRBxn7Czk1CThtHRx/BpvI1z0uRWv9Qb75V3snj0F7og0TiIB4giwh3K1qkUGtLn60AKJOHwUYOiphoolm+MGjOmGd55n0tfJhS6OP0PWeZodmCx2PckbM/McKtu/ojUnB3t/b471XlKUbLFJZGEjgDm5yksMU4Pud+VfZJAdE/i7cHJtqiH3ue2cj4jdwf/gefgefhSVLd0tgOKI6F1YoOOGJTYm3N3oZ5OjTHONcS7qT59GzCVYCd3Qqdk6cYn29i4URLgYfI2wFeB9IUYiMZcFHLYM4BhBZP33/QmpsL1IYV9+NVoOEFz4V5l62FiCHS/dBrusLCTNmj/cDo6XHftHlA0G4oEitbLAcVbPtifRGTlxICnhAiwpRwPf7Wswd03Hn742aj6XGQo8aw6zwmL0GH5cGwJgbA==;5:MtO3WOYIPmaeGdcKqQYHmsLvO8P/QR0YmfQwOY9nFtrn2KvcAg5wXOw8AY2EwrW4mjWarB04sxXda9vTdbR/Bpm7EoY0/f8eAt2l54xgGWDwnm+RNj6MLCvGACLq67NQno9E2w2QeYgNNN+Dh6Al1fsdOAxEJmbLRviykOxE3iU=;7:gJcWiVR4yk1yob8Gb7Ald906tL24yIZm5ZbGweb04+GbmHpH8FdCVoEel5CB0OdS9RNkk8OmJi7WdQngR2w8lHy115F97oIKpaaemnj5FhDxmJHHfE/enb/66NXozuxEM0HzQQPfUfuoTSHHy2k4nA==
x-ms-office365-filtering-correlation-id: 6b516c78-e8fe-4b0e-e8e0-08d633f60efa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1037;
x-ms-traffictypediagnostic: SN6PR2101MB1037:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB103774FD5EF3C3B14CB76503A0FF0@SN6PR2101MB1037.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991092);SRVR:SN6PR2101MB1037;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1037;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(13464003)(256004)(105586002)(8990500004)(74316002)(10290500003)(102836004)(68736007)(305945005)(6116002)(6246003)(54906003)(14454004)(93886005)(446003)(6436002)(11346002)(81166006)(8676002)(106356001)(8936002)(71200400001)(71190400001)(81156014)(55016002)(316002)(478600001)(486006)(9686003)(53936002)(476003)(7736002)(86612001)(22452003)(86362001)(33656002)(97736004)(76176011)(229853002)(7696005)(6506007)(186003)(5250100002)(2900100001)(53546011)(46003)(99286004)(5660300001)(6346003)(25786009)(10090500001)(6916009)(2906002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1037;H:SN6PR2101MB1118.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-message-info: hgLu6JcSjv3XV3aK3eDmBO4DZDNJ0t5ERyt9piJFHz8b0YxMOycbC906XIa5iWBniR5idNi2NDH7C+pKv3LMnMzCMJhKWnoarOjHh9lnHTp7O6H6IKLQjkSR1pvVQD5woRWUye42mYZKVvd26NCSt2bHtzGWRNOujBgn7anrWXUj0NFP6n5ddVY3bJQU7a4u39FFskxrzBS0cmIxIFKpOxPGMIb74s2T1QfQ9tVLRolwEY+PoH7Hrio7p9ce0OdqaHJqeksiW3l7MhzWAjrsTRsZ+sLeZ+emQT5S3AApDfY6PH00ZWceSzE271CnGQBrJFgovOtBAvJZDMCdXjoHq6FjJHALT75jbqBrq8m7xAQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b516c78-e8fe-4b0e-e8e0-08d633f60efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 06:02:02.4368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, October 16, 2018 10:07 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets <vkuznets@redhat.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stable@vger.kernel.org
> Subject: Re: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caus=
ed by
> incorrect clean-up
>=20
> On Wed, Oct 17, 2018 at 03:14:04AM +0000, kys@linuxonhyperv.com wrote:
> > From: Dexuan Cui <decui@microsoft.com>
> >
> > In kvp_send_key(), we do need call process_ib_ipinfo() if
> > message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns
> out
> > the userland hv_kvp_daemon needs the info of operation, adapter_id and
> > addr_family. With the incorrect fc62c3b1977d, the host can't get the
> > VM's IP via KVP.
> >
> > And, fc62c3b1977d added a "break;", but actually forgot to initialize
> > the key_size/value in the case of KVP_OP_SET, so the default key_size o=
f
> > 0 is passed to the kvp daemon, and the pool files
> > /var/lib/hyperv/.kvp_pool_* can't be updated.
> >
> > This patch effectively rolls back the previous fc62c3b1977d, and
> > correctly fixes the "this statement may fall through" warnings.
> >
> > This patch is tested on WS 2012 R2 and 2016.
> >
> > Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fal=
l
> through" warnings")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: <Stable@vger.kernel.org>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> >  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> > index a7513a8a8e37..9fbb15c62c6c 100644
> > --- a/drivers/hv/hv_kvp.c
> > +++ b/drivers/hv/hv_kvp.c
> > @@ -353,6 +353,9 @@ static void process_ib_ipinfo(void *in_msg, void
> *out_msg, int op)
> >
> >  		out->body.kvp_ip_val.dhcp_enabled =3D in-
> >kvp_ip_val.dhcp_enabled;
> >
> > +		__attribute__ ((fallthrough));
>=20
> The comment should be sufficient for this, right?  I haven't seen many
> uses of this attribute before, how common is it?

Yes; a common should be sufficient.
>=20
>=20
> > +
> > +	case KVP_OP_GET_IP_INFO:
> >  		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
> >  				MAX_ADAPTER_ID_SIZE,
> >  				UTF16_LITTLE_ENDIAN,
> > @@ -405,7 +408,11 @@ kvp_send_key(struct work_struct *dummy)
> >  		process_ib_ipinfo(in_msg, message, KVP_OP_SET_IP_INFO);
> >  		break;
> >  	case KVP_OP_GET_IP_INFO:
> > -		/* We only need to pass on message->kvp_hdr.operation.
> */
> > +		/*
> > +		 * We only need to pass on the info of operation, adapter_id
> > +		 * and addr_family to the userland kvp daemon.
> > +		 */
> > +		process_ib_ipinfo(in_msg, message,
> KVP_OP_GET_IP_INFO);
> >  		break;
> >  	case KVP_OP_SET:
> >  		switch (in_msg->body.kvp_set.data.value_type) {
> > @@ -446,9 +453,9 @@ kvp_send_key(struct work_struct *dummy)
> >
> >  		}
> >
> > -		break;
> > -
> > -	case KVP_OP_GET:
> > +		/*
> > +		 * The key is always a string - utf16 encoding.
> > +		 */
> >  		message->body.kvp_set.data.key_size =3D
> >  			utf16s_to_utf8s(
> >  			(wchar_t *)in_msg->body.kvp_set.data.key,
> > @@ -456,6 +463,17 @@ kvp_send_key(struct work_struct *dummy)
> >  			UTF16_LITTLE_ENDIAN,
> >  			message->body.kvp_set.data.key,
> >  			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
> > +
> > +		break;
> > +
> > +	case KVP_OP_GET:
> > +		message->body.kvp_get.data.key_size =3D
> > +			utf16s_to_utf8s(
> > +			(wchar_t *)in_msg->body.kvp_get.data.key,
> > +			in_msg->body.kvp_get.data.key_size,
> > +			UTF16_LITTLE_ENDIAN,
> > +			message->body.kvp_get.data.key,
> > +			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
>=20
> Worst indentation ever :(
>=20
> Yeah, I know it follows the others above it, but you should reconsider
> it in the future...
>=20
> thanks,
>=20
> greg k-h
