Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18072C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03A820818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="aofnDKkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03A820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeKHEot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:44:49 -0500
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:40667
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbeKHEot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAD6FOZ4wzUb+lntkSX/2IdZUzzMpONTBbDLXzof6eg=;
 b=aofnDKkUHZGt0m99pyR5MYkHVyA0+DMMpLILlCMRBjNXqOxpmsZbF6cKOF8RtZ7TPjT0W7o2b8cxac0RYW7pR0HCYVqsAsXiuUsdT6oqXzigDJGkFaprKKWTG36f6G7a+B5+2vA/kgeFZw8fTM6F3w0yvKp66GcXMaoZLy/wZ7g=
Received: from SN6PR05MB4783.namprd05.prod.outlook.com (52.135.115.17) by
 SN6PR05MB5069.namprd05.prod.outlook.com (20.177.248.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.14; Wed, 7 Nov 2018 19:13:04 +0000
Received: from SN6PR05MB4783.namprd05.prod.outlook.com
 ([fe80::c964:38d3:a19b:6091]) by SN6PR05MB4783.namprd05.prod.outlook.com
 ([fe80::c964:38d3:a19b:6091%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 19:13:04 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Thread-Topic: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Thread-Index: AQHUcwQ37jX8+phTpkyCnxi097WrnaVBPEeAgAN5fgA=
Date:   Wed, 7 Nov 2018 19:13:03 +0000
Message-ID: <9A69025F-5B49-4A26-AB95-F6D36908983B@vmware.com>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-3-namit@vmware.com>
 <20181105140925.GD22467@hirez.programming.kicks-ass.net>
In-Reply-To: <20181105140925.GD22467@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR05MB5069;20:sQK9b1FLk7qmwHR5ucGWhj/B6/bi6sU+MXtkkMKnNHPo+1H9GYxYCGum5Bl7m4BeaYfVnUcMRJaJ5Rp0Zcv9W4brQQCkFTQ3LS8QRDkQQQyTV09ljD+epep8fTql4bVT8zC+RzjR1fwiqBQIiB1L/I008rk17PyHUQFZl/L2Yy4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7db3e9d9-7836-41bd-f28b-08d644e50ae3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB5069;
x-ms-traffictypediagnostic: SN6PR05MB5069:
x-microsoft-antispam-prvs: <SN6PR05MB50692D1CDBA61583CCCD621ED0C40@SN6PR05MB5069.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(61668805478150)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR05MB5069;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB5069;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(8936002)(229853002)(6486002)(68736007)(575784001)(5660300001)(4326008)(86362001)(6246003)(53936002)(6512007)(6916009)(6436002)(478600001)(25786009)(316002)(14454004)(54906003)(36756003)(186003)(2906002)(2900100001)(6116002)(3846002)(8676002)(81156014)(81166006)(99286004)(7416002)(256004)(486006)(476003)(2616005)(7736002)(305945005)(83716004)(71200400001)(71190400001)(82746002)(14444005)(11346002)(446003)(66066001)(97736004)(76176011)(102836004)(26005)(106356001)(53546011)(33656002)(105586002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB5069;H:SN6PR05MB4783.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: buWGavrxXzH/svAl0BcGblhJKSy+7sRMHo2Euoir6y0sp6gbZAzCDXo6KNLHVMaonPbSQ93fCMXMqmF8T+tJVoddh2eNhplQq0Oyr3gxrnPWcMeDyOvvMbCIuRHYwJVMh9XD9nluVEzUmkzOHYL0aiyrLMKTeW3uMLV2kLPIVXApkH2UoiEBV212cB9yLWjSmXCOoWQG1jGtV68LbA40LzUW0+69U55txUjAbr3B6iZXAh0iWMYJ8B5m7BOHZKPVDJacJ40ZdWDdshZVRlAVr/DrTjcNPb51cI1X97uFCuGL9efNFK98MD5kL3aDHshvl3stXCMqY8AWBdtkekKZvKKNfhgjGWAmxxSQJUf9taQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <09600D2BC6A5424EB817014D1DDA04B0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db3e9d9-7836-41bd-f28b-08d644e50ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 19:13:03.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB5069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
Sent: November 5, 2018 at 2:09:25 PM GMT
> To: Nadav Amit <namit@vmware.com>
> Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@ker=
nel.org, H. Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.d=
e>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.co=
m>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, D=
ave Hansen <dave.hansen@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
> Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during =
early_init
>=20
>=20
> On Fri, Nov 02, 2018 at 04:29:41PM -0700, Nadav Amit wrote:
>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
>> index aac0c1f7e354..367c1d0c20a3 100644
>> --- a/arch/x86/kernel/jump_label.c
>> +++ b/arch/x86/kernel/jump_label.c
>> @@ -52,7 +52,13 @@ static void __ref __jump_label_transform(struct jump_=
entry *entry,
>> 	jmp.offset =3D jump_entry_target(entry) -
>> 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>>=20
>> -	if (early_boot_irqs_disabled)
>> +	/*
>> +	 * As long as we are in early boot, we can use text_poke_early(), whic=
h
>> +	 * is more efficient: the memory was still not marked as read-only (it
>> +	 * is only marked after poking_init()). This also prevents us from usi=
ng
>> +	 * text_poke() before poking_init() is called.
>> +	 */
>> +	if (!early_boot_done)
>> 		poker =3D text_poke_early;
>>=20
>> 	if (type =3D=3D JUMP_LABEL_JMP) {
>=20
> It took me a while to untangle init/maze^H^Hin.c... but I think this
> is all we need:
>=20
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index aac0c1f7e354..ed5fe274a7d8 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -52,7 +52,12 @@ static void __ref __jump_label_transform(struct jump_e=
ntry *entry,
> 	jmp.offset =3D jump_entry_target(entry) -
> 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>=20
> -	if (early_boot_irqs_disabled)
> +	/*
> +	 * As long as we're UP and not yet marked RO, we can use
> +	 * text_poke_early; SYSTEM_BOOTING guarantees both, as we switch to
> +	 * SYSTEM_SCHEDULING before going either.
> +	 */
> +	if (system_state =3D=3D SYSTEM_BOOTING)
> 		poker =3D text_poke_early;
>=20
> 	if (type =3D=3D JUMP_LABEL_JMP) {

Thanks for this change, I will incorporate it.

I wanted to point a small difference from my version. Although this version
ensures we are UP and the kernel is still RW, preemption is possible with
this version. I presume that it should not affect jump-labels, since it
switches between JMP and multi-byte NOPs.

Thanks,
Nadav=
