Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF2CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DEE20661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Rlnq7ede"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DEE20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeLEDIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:08:01 -0500
Received: from mail-oln040092009051.outbound.protection.outlook.com ([40.92.9.51]:6117
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeLEDIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLbuKtsJRrhmz3LT2AQs2aRNciZ78LX7hNLENIVFBjU=;
 b=Rlnq7ede8pUCH80o4IejO+/A/M9jdCemlP8QyeaKBaQGCvRV2flpiNGbNve8eHA3mMgQNmURS5i7EY3lLDOxaCoZBMVrqVJXhTVWvITnnJG4vsiSKGCsWMLTQzP/DLpBrGxj0htqFqSPVlU2wmMMn2yu/u5E9X9WL+CCfsbXPCHZKoxxyC0+PUDriqAEnyFsBKgx6LOb0b/rcQ0aDcZzgyJaY7vqEL2sIj0qMtbEZI6NmfWh+7Y9+mQIYc7rK0g+vXguVac2jLJyNuQ71zzHjJ3V/Teyksup33/eDoxZAXClJWvRuGTiaw5iOdzi2ceUAyggkcN0WIeWYBEz4H+6WA==
Received: from BN3NAM04FT052.eop-NAM04.prod.protection.outlook.com
 (10.152.92.57) by BN3NAM04HT023.eop-NAM04.prod.protection.outlook.com
 (10.152.93.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.17; Wed, 5 Dec
 2018 03:07:58 +0000
Received: from SN1PR13MB0304.namprd13.prod.outlook.com (10.152.92.56) by
 BN3NAM04FT052.mail.protection.outlook.com (10.152.92.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17 via Frontend Transport; Wed, 5 Dec 2018 03:07:58 +0000
Received: from SN1PR13MB0304.namprd13.prod.outlook.com
 ([fe80::399e:4b0e:8423:5bad]) by SN1PR13MB0304.namprd13.prod.outlook.com
 ([fe80::399e:4b0e:8423:5bad%3]) with mapi id 15.20.1404.016; Wed, 5 Dec 2018
 03:07:58 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>,
        "donb@securitymouse.com" <donb@securitymouse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Index: AQHUhuxfhCM/itRkZUmE23ES7mjh0qVlNWoAgAkytACAARlyAA==
Date:   Wed, 5 Dec 2018 03:07:58 +0000
Message-ID: <SN1PR13MB030484F09EE8A00DB094CDFADFA80@SN1PR13MB0304.namprd13.prod.outlook.com>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
 <5C0654EE.5040001@oberhumer.com>
In-Reply-To: <5C0654EE.5040001@oberhumer.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:36::14) To SN1PR13MB0304.namprd13.prod.outlook.com
 (2a01:111:e400:c42a::30)
x-incomingtopheadermarker: OriginalChecksum:66EF434305ECB96DDEC6DBC10391118EB9BE1E58D9FB71BC9F54884C5D131134;UpperCasedChecksum:4B58398381E8F205A32B563A83AF6321FF85099A27EEA46B9C81EA533A0C5BB7;SizeAsReceived:7784;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Yb5Ox/83svVV3pYk/IoNaSJKzAJwONhj]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3NAM04HT023;6:kzjYXkEx/6DDyU1lBH6v/Kdh/exqlQule+FmqofjKmcd5Ylkh42tdZdKjyFv9zfEQKC/bDZHBh0eD07Vzs0uuN41j/KxFft8ouZw5p6dWNibvHIRq30Qo0I8EYTV0rC3GUI+cyAlnSm5awYcxYWZTkf+rxFpx2DS491b2xR5ptaVaG2tPGVY0El3xlfbZpjeC8uDZd+gv3Boi/5nHK6xtVIEA66ZFMyfv/UwNal5rDjfsSn4vt+nXEGqLsfxvbDK9V3lrEyejPI+7jWJhSodKPmh/OMQRDnTAOqdqDXSSYmDeLBaZ4nMOyp3ZkKVrhq/tggdSfFDA5LV/6RL6mtx22VgFhehNSpq6rIMbYbKAF2whkFo4FJqVpw2rrr+R5e+KWSfhdY75FzE368ZbozigLUh20q+Gr3yhNQIAaXNiqG7TF+oEkYwde+0glTwbujW+xfYq7vqEVqflZtG7GYHCg==;5:Zrh+/GMKD12Vti1Gnkm/2EEQjByZATnc7JKhsNUVkCFs42Ww6vfLzGM3nHVkhffIxx2BFdk66qjwonod0DYxxUmWFKHGPKBYNaWR0VDqh1X3MMa44Y8rNgOGPMHqelm/rQ9jryPpHlyjWwnJuwhJ9gcxu39jZVnmAbMxgAvpbLY=;7:fIgk411clJ7rI1/cscbKZhOXi8VoO/zIagq/lQWOdZ3oYi7L5/SkUVfaJzD+pTYsXYJ/BBrTh2/kvx8/rX18E2iSC5FmR8V7IyeGg5EOLRieL0iWN7dcS5m2pX8NQ93Ub41Qgc82Z5/U0Bz3LplMRw==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:BN3NAM04HT023;
x-ms-traffictypediagnostic: BN3NAM04HT023:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BN3NAM04HT023;BCL:0;PCL:0;RULEID:;SRVR:BN3NAM04HT023;
x-microsoft-antispam-message-info: pFTvcd5vqCxIL8SKBEf/TWMMfMhhOV6U9kgvstQM7OqL1d15PUfTiRGuTNiSWEtf
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <134CC919548DFB49A9286CA73E1EAB66@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f25aeed-6c9c-40de-b4b8-08d65a5edb0a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 03:07:58.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM04HT023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Thanks for your review.

On 2018/12/4 18:20, Markus F.X.J. Oberhumer wrote:
> Hi,
>
> I don't think that address space wraparound is legal in C, but I
> understand that we are in kernel land and if you really want to
> compress the last virtual page 0xfffffffffffff000 the following
> small patch should fix that dubious case.

I guess the VA 0xfffffffffffff000 is available because KASLR be
enabled. For this case we can see:

crash> kmem 0xfffffffffffff000
       PAGE               PHYSICAL      MAPPING       INDEX CNT FLAGS
ffffffbfffffffc0        1fffff000 ffffffff1655ecb9  7181fd5  2=20
8000000000064209 locked,uptodate,owner_priv_1,writeback,reclaim,swapbacked

> This also avoids slowing down the the hot path of the compression
> core function.
>
> Cheers,
> Markus
>
>
>
> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
> index 236eb21167b5..959dec45f6fe 100644
> --- a/lib/lzo/lzo1x_compress.c
> +++ b/lib/lzo/lzo1x_compress.c
> @@ -224,8 +224,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t =
in_len,
>  =20
>          while (l > 20) {
>                  size_t ll =3D l <=3D (M4_MAX_OFFSET + 1) ? l : (M4_MAX_O=
FFSET + 1);
> -               uintptr_t ll_end =3D (uintptr_t) ip + ll;
> -               if ((ll_end + ((t + ll) >> 5)) <=3D ll_end)
> +               // check for address space wraparound
> +               if (((uintptr_t) ip + ll + ((t + ll) >> 5)) <=3D (uintptr=
_t) ip)
>                          break;
>                  BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_C=
OMPRESS);
>                  memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
I parsed panic ramdump and loaded CPU register values,  can see:

-000|lzo1x_1_do_compress(
     |    in =3D 0xFFFFFFFFFFFFF000,
     |  ?,
     |    out =3D 0xFFFFFFFF2E2EE000,
     |    out_len =3D 0xFFFFFF801CAA3510,
     |  ?,
     |    wrkmem =3D 0xFFFFFFFF4EBC0000)
     |  dict =3D 0xFFFFFFFF4EBC0000
     |  op =3D 0x1
     |  ip =3D 0x9
     |  ii =3D 0x9
     |  in_end =3D 0x0
     |  ip_end =3D 0xFFFFFFFFFFFFFFEC
     |  m_len =3D 0
     |  m_off =3D 1922
-001|lzo1x_1_compress(
     |    in =3D 0xFFFFFFFFFFFFF000,
     |    in_len =3D 0,
     |    out =3D 0xFFFFFFFF2E2EE000,
     |    out_len =3D 0x00000001616FB7D0,
     |    wrkmem =3D 0xFFFFFFFF4EBC0000)
     |  ip =3D 0xFFFFFFFFFFFFF000
     |  op =3D 0xFFFFFFFF2E2EE000
     |  l =3D 4096
     |  t =3D 0
     |  ll =3D 4096

ll =3D l =3D in_len =3D 4096 in lzo1x_1_compress,  so your patch is working=
=20
for this panic case, but, I`m
not sure, is it possible that in =3D 0xFFFFFFFFFFFFF000 and  in_len < 4096?


Thanks,
Yueyi
