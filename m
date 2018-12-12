Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29148C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA9520851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kYDuTm7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA9520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbeLLFVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:21:35 -0500
Received: from mail-oln040092009065.outbound.protection.outlook.com ([40.92.9.65]:37712
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbeLLFVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Wm+1o8AQh6Fb+tbtFnWIA6VlYl1V6O2WPvjomwkYzE=;
 b=kYDuTm7sowoQnoO7UEvXIY3kQhGBlYpZtRsrIQfU6SrsOK4TyqfxCW2T2oHO15lJH2P6oWYH5PDT8QfeqFXCdLy3eXYDAsBLUF1dhuUETZUi6o6Dl+bXAxsTazxwtCz2BrAG2LQE3UNZt6l5mkYkjSdID5HSz7isUEK7r7MHTcWTFXfBKdsFRmUX8CCeHXhatD5Z28QDNb1NEGrETGAyLiB2nQuFybp0tDAK88Vx48PwSmYrADtorey7HISFrgsTrobf2FKVb6s2vhN8fS3BQbPy4wXVLr0Zkk3OUvGDXeD7ttIiNCADr77z3UoU8Jwk2Uhxu6kJYHffzxa5boqE1Q==
Received: from SN1NAM04FT058.eop-NAM04.prod.protection.outlook.com
 (10.152.88.53) by SN1NAM04HT175.eop-NAM04.prod.protection.outlook.com
 (10.152.89.127) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1425.16; Wed, 12 Dec
 2018 05:21:29 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.88.54) by
 SN1NAM04FT058.mail.protection.outlook.com (10.152.89.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.16 via Frontend Transport; Wed, 12 Dec 2018 05:21:29 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 05:21:29 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "w@1wt.eu" <w@1wt.eu>,
        "donb@securitymouse.com" <donb@securitymouse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Index: AQHUhuxfhCM/itRkZUmE23ES7mjh0qVlNWoAgAkytACAARlyAIACWjQAgAjLaAA=
Date:   Wed, 12 Dec 2018 05:21:29 +0000
Message-ID: <BLUPR13MB0289EC81589A10E95912675FDFA70@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
 <5C0654EE.5040001@oberhumer.com>
 <SN1PR13MB030484F09EE8A00DB094CDFADFA80@SN1PR13MB0304.namprd13.prod.outlook.com>
 <5C093A30.4020705@oberhumer.com>
In-Reply-To: <5C093A30.4020705@oberhumer.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0078.apcprd03.prod.outlook.com
 (2603:1096:203:72::18) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:9BB462FF1A8E79942C531BCD5C2D08839FD69E37E73D50E52B9BE9371106D08B;UpperCasedChecksum:40930A6707DCA4D2CC186F42299DB28E9A9B1C03CDD3ED23629EA8C0F123902E;SizeAsReceived:7923;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [tH8cfgF2nZNEg/WU/vfktlpO50rud0/b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1NAM04HT175;6:9cBC8SmV0Skt8AonStwOhNsobN++c1XRWv50kvzf+R/aVfDVPxmXJ0rSTCYRDBeKpIJpF+3uIbUfr9iUsG5KS13tit3h0AEjXtTMKFoeEjcW8d3y0Hwo5Ikt5WriHPvOU878XjaDqlNdu1+d2Q4xELq7eMMy/1V7gtj16RPy+p5bQ8sj/Huwx+vn1wgbBwAF9LN+NHM6YUc8RFP6/ulEjteO936ExUXjAMfTnSfyaP7qmPnJCyOd79CVHkfOX85KauP5aPuc3r34linpdV0EhjE2s0wRlKgtPYdFjLhnKaD2hzr11glPWF0huAtE27MNnAmTV6jmeUokh2baYjZ3+5YSOWl77oTkTMctxVF5Z1MxpO4O6cCaqciD419CGmTM25nr9IsFcof5PWL9SGg/zEw7EJU4Sq0weOUvN0JvVMv8vHcODtUufntCoc1gq/OiXP0mtbSKggT6wWKZZlK+8g==;5:iQnfyCEKZtOUATa4mim2DPdKtw3GA4H66ZQe9T3OrZhBfv58IL46T9YTSQbBRLsJ2G4EOTknwn4SqpmFmhNNqS8Tj0HYz8MEXINTwWVph0qxds+Ki6CFyOrLAuPx1uh7n+0g5ifYt9o5aqCRXDBgXJ4W2xye5rMTx5VTk8SpmFk=;7:qkhH4rk65kKoBnVsi8Ej4QIIdB+lG2yXn1Tkt9CnGdTezHrKKEi2GPnIheLbER4a5v0Ke8UXf4ojvfSu14XXHvcttpNUURcmu9xEPxkEDD/kUKJqIVV8GAFTT6glo2+zcskyHfZN+StxSsMKrE2l7Q==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:SN1NAM04HT175;
x-ms-traffictypediagnostic: SN1NAM04HT175:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:SN1NAM04HT175;BCL:0;PCL:0;RULEID:;SRVR:SN1NAM04HT175;
x-microsoft-antispam-message-info: /EyWSYWRBnyIO8yN9oXnVt/OZmFJ02lvEvtCjxfVNyIF1UrBnH9reln6mPG7ynKc
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <29B2A161132E4A409E074A5006C1B9EC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: b75254e7-7183-41f6-0919-08d65ff1a9ec
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 05:21:29.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM04HT175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

OK, thanks. I`ll change it in v3.

Thanks,
Yueyi

On 2018/12/6 23:03, Markus F.X.J. Oberhumer wrote:
> Hi Yueyi,
>
> yes, my LZO patch works for all cases.
>
> The reason behind the issue in the first place is that if KASLR
> includes the very last page 0xfffffffffffff000 then we do not have a
> valid C "pointer to an object" anymore because of address wraparound.
>
> Unrelated to my patch I'd argue that KASLR should *NOT* include the
> very last page - indeed that might cause similar wraparound problems
> in lots of code.
>
> Eg, look at this simple clear_memory() implementation:
>
> void clear_memory(char *p, size_t len) {
>          char *end =3D p + len;
>          while (p < end)
>                  *p++=3D 0;
> }
>
> Valid code like this will fail horribly when (p, len) is the very
> last virtual page (because end will be the NULL pointer in this case).
>
> Cheers,
> Markus
>
>
>
> On 2018-12-05 04:07, Yueyi Li wrote:
>> Hi Markus,
>>
>> Thanks for your review.
>>
>> On 2018/12/4 18:20, Markus F.X.J. Oberhumer wrote:
>>> Hi,
>>>
>>> I don't think that address space wraparound is legal in C, but I
>>> understand that we are in kernel land and if you really want to
>>> compress the last virtual page 0xfffffffffffff000 the following
>>> small patch should fix that dubious case.
>> I guess the VA 0xfffffffffffff000 is available because KASLR be
>> enabled. For this case we can see:
>>
>> crash> kmem 0xfffffffffffff000
>>         PAGE               PHYSICAL      MAPPING       INDEX CNT FLAGS
>> ffffffbfffffffc0        1fffff000 ffffffff1655ecb9  7181fd5  2
>> 8000000000064209 locked,uptodate,owner_priv_1,writeback,reclaim,swapback=
ed
>>
>>> This also avoids slowing down the the hot path of the compression
>>> core function.
>>>
>>> Cheers,
>>> Markus
>>>
>>>
>>>
>>> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
>>> index 236eb21167b5..959dec45f6fe 100644
>>> --- a/lib/lzo/lzo1x_compress.c
>>> +++ b/lib/lzo/lzo1x_compress.c
>>> @@ -224,8 +224,8 @@ int lzo1x_1_compress(const unsigned char *in, size_=
t in_len,
>>>   =20
>>>           while (l > 20) {
>>>                   size_t ll =3D l <=3D (M4_MAX_OFFSET + 1) ? l : (M4_MA=
X_OFFSET + 1);
>>> -               uintptr_t ll_end =3D (uintptr_t) ip + ll;
>>> -               if ((ll_end + ((t + ll) >> 5)) <=3D ll_end)
>>> +               // check for address space wraparound
>>> +               if (((uintptr_t) ip + ll + ((t + ll) >> 5)) <=3D (uintp=
tr_t) ip)
>>>                           break;
>>>                   BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_ME=
M_COMPRESS);
>>>                   memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
>> I parsed panic ramdump and loaded CPU register values,  can see:
>>
>> -000|lzo1x_1_do_compress(
>>       |    in =3D 0xFFFFFFFFFFFFF000,
>>       |  ?,
>>       |    out =3D 0xFFFFFFFF2E2EE000,
>>       |    out_len =3D 0xFFFFFF801CAA3510,
>>       |  ?,
>>       |    wrkmem =3D 0xFFFFFFFF4EBC0000)
>>       |  dict =3D 0xFFFFFFFF4EBC0000
>>       |  op =3D 0x1
>>       |  ip =3D 0x9
>>       |  ii =3D 0x9
>>       |  in_end =3D 0x0
>>       |  ip_end =3D 0xFFFFFFFFFFFFFFEC
>>       |  m_len =3D 0
>>       |  m_off =3D 1922
>> -001|lzo1x_1_compress(
>>       |    in =3D 0xFFFFFFFFFFFFF000,
>>       |    in_len =3D 0,
>>       |    out =3D 0xFFFFFFFF2E2EE000,
>>       |    out_len =3D 0x00000001616FB7D0,
>>       |    wrkmem =3D 0xFFFFFFFF4EBC0000)
>>       |  ip =3D 0xFFFFFFFFFFFFF000
>>       |  op =3D 0xFFFFFFFF2E2EE000
>>       |  l =3D 4096
>>       |  t =3D 0
>>       |  ll =3D 4096
>>
>> ll =3D l =3D in_len =3D 4096 in lzo1x_1_compress,  so your patch is work=
ing
>> for this panic case, but, I`m
>> not sure, is it possible that in =3D 0xFFFFFFFFFFFFF000 and  in_len < 40=
96?
>>
>>
>> Thanks,
>> Yueyi
>>

