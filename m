Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75242C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A97B21848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="scjv/rYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfAJKYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:24:19 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:43043 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfAJKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:24:18 -0500
X-IronPort-AV: E=Sophos;i="5.56,460,1539673200"; 
   d="scan'208";a="24868887"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Jan 2019 03:24:17 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 10 Jan 2019 03:24:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN7E2FqfM41P8JYiQq4dYXqD6Co9mpBvNtY/ydVDeXw=;
 b=scjv/rYW/1wAYtTGW/6Q5keRzqtMih3MErE0Uu4iA5RVV2Gm1ZFPaWqsviY841Fk/fUMvZBjlFOLQHnZwWfDqzmi87styMBUS5kezmbfx6fflGBkRLJWwmQ2TlFYtnD1E3Cz8cf8QVIPmg6GJwVtzpLHcf9AyT1GdO3KPK/boBc=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2015.namprd11.prod.outlook.com (10.169.236.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 10 Jan 2019 10:24:15 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::e553:ff9d:8c0b:9627%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 10:24:15 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <pavel@ucw.cz>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <rjw@rjwysocki.net>,
        <len.brown@intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] PM / Suspend: Add support to check if platform's
 power is off in suspend
Thread-Topic: [PATCH v2 1/3] PM / Suspend: Add support to check if platform's
 power is off in suspend
Thread-Index: AQHUp0DOM7WMwuf4TU6Qg1UGEhg3kaWm/LSAgAFSAwA=
Date:   Thu, 10 Jan 2019 10:24:14 +0000
Message-ID: <126e9fd8-1009-47f7-7299-9e5e93ebfd4d@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
 <20190109141417.GA8529@amd>
In-Reply-To: <20190109141417.GA8529@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::21) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB2015;6:tuSCj4a+owfMvjElZCYWD+4RuuXOMhA51QeM4GjJ8oIdwl0O0r2tronWgJkwjJxCG6c4TLuQzf0J1coShsxu6WIvzbZY1IXX9L+J++CeNEUn4QcDUdoWRq6p2RKkzkAnVPmrh7JEifED/brv/e69909oW/8zE1Yr4vhBbTNu4LlMiey3FlyUJ6Gmvhg+q8AeB3bfYtVk2ICDRsm/25ZCK6bMMx4ZMpEbn+1QyRIZHxkPRTpQMOLbFkKhtOoOAN4KKLpimeycTQP7IAwbZ0xy/orm1aNjnSsiFl5P0EYqtECWMNUu0uhm08uq8fkFUthDRNy/rGTBRdrQs49IntJwtnyor/5EHhRcWRRROGDbIesrAaJ82IE6mXule8mbzd54E1uGa99vTioNH5hwftBMnL0DjLd4mOIdvrNGtRd30O+cCTXZFea71uLsSM5MIuS11NSAMaa++B21oKoiNMcSXQ==;5:C3/+LeCmX7/sSe5hbw8GKpOIhFMfJCLfT1CVfXdpZQ3gtBLBFRcEE5mHP8qhg2WGEYcl5aHl6hH/FMImVVMjeJCFstDlVcrgbYCT/61ZkaLUJPInEoifmIQnqLr4gJVqrGkc2aIgx/medRC0u3s5/mOu76fa3lZjWbxzToAvRH7aicsY5sjQrNoNM1lAQzkt35iEebqKeetF0+KYhAhpLA==;7:lEU7pGckJaHR1Lg31dM3WPJm3GMxyeFDNZ640saWcA54cVxKc2Zw4Ngw6B4fbgYDpjYCEroIuMHOd/hnFZaF21jjgIWyBlatfN0kGilbvqSAIlCrCsg58vYxuzv9MRN12CRA30zJsm31oRWB7F6lBg==
x-ms-office365-filtering-correlation-id: 2cc22a02-9afe-4a61-6adc-08d676e5c513
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2015;
x-ms-traffictypediagnostic: MWHPR11MB2015:
x-microsoft-antispam-prvs: <MWHPR11MB20152686CA7818B1E4C1119287840@MWHPR11MB2015.namprd11.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(376002)(39860400002)(189003)(199004)(4326008)(25786009)(6486002)(8676002)(6512007)(99286004)(81156014)(81166006)(97736004)(7736002)(53936002)(305945005)(6436002)(8936002)(71200400001)(71190400001)(2906002)(66066001)(39060400002)(316002)(229853002)(7416002)(36756003)(6246003)(5660300001)(6116002)(3846002)(105586002)(486006)(386003)(256004)(53546011)(6506007)(106356001)(14444005)(102836004)(476003)(446003)(2616005)(11346002)(31686004)(14454004)(478600001)(72206003)(6916009)(31696002)(68736007)(76176011)(54906003)(15650500001)(26005)(52116002)(186003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2015;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: va1Jfe6tjFc/rNs4k2ekAuQ1l5B+Tz8Tgz4sG2/IuuLpYditamKwEf4h3X34Sr72QsL7vQvnlAljUyBhqW0B7iJNeAmnTqvru/nifniwQN/HwzGgMxsec9QjXbthhn1kQu/tedv4qClY0nqjRQN7a6KST2+h2iwuTDCxB6LbThTO4kWrHMGmvQmwDW4NY4Bb+GSSrDrpWAB8Wv9HWGn200CCc7VGjN2DeK8NiRm0uwivjmbN3n8RF/4cEeFgdH748TznmNSLGIVcXJD3bKo9Wit2SX9dtVqXQL7p24RXVGTRI9j8SDqSfh6Gudh66XygzcDkToLDoCc25Q9HXKNYoL0H+vx8tpFir0cR+v4A81ZNZkpI1POPTOuZN6OEuEqHGtCTeMPlj6a/JcTz5sVhvd6tbScP8iJrL2oDL7VyNGpBCOuv6zGWf038X1deBZ0J8XjlFgsxptzlNuCUmUPkDA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <96542B4514FC34429CA977BE733673A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc22a02-9afe-4a61-6adc-08d676e5c513
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 10:24:14.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2015
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.01.2019 16:14, Pavel Machek wrote:
> Hi!
>=20
>> Add support to check if platform's power will be cut off in suspend.
>> This will help drivers shared by multiple platforms to take only the
>> necessary actions while suspending/resuming (some platform may not need
>> to save/restore all the registers if platforms remains powered while
>> suspended). In this way suspend/resume time could be improved.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  include/linux/suspend.h |  6 ++++++
>>  kernel/power/suspend.c  | 13 +++++++++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>> index 3f529ad9a9d2..21f19b167fe2 100644
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -173,6 +173,9 @@ static inline void dpm_save_failed_step(enum suspend=
_stat_step step)
>>   *	Called by the PM core if the suspending of devices fails.
>>   *	This callback is optional and should only be implemented by platform=
s
>>   *	which require special recovery actions in that situation.
>> + *
>> + * @off_in_suspend: Returns wether the platform's power will be cut off=
 at
>=20
> wether -- spelling?

Yep, I did it again :), sorry

>=20
>> @@ -185,6 +188,7 @@ struct platform_suspend_ops {
>>  	bool (*suspend_again)(void);
>>  	void (*end)(void);
>>  	void (*recover)(void);
>> +	bool (*off_in_suspend)(suspend_state_t state);
>>  };
>=20
> Dunno, should it be per-regulator? SoCs commonly have more than one
> power supply, with some of them off during suspend...

Every regulator has a suspend state which could be described via device
tree. In our case, besides other regulators, we have core regulator, which
is turned off in suspend at the end of the suspend procedure, when PMIC
detects a level transition on one of its pins, transition which is
triggered the moment the CPU is shut down (we are doing this from software
at the end of suspend procedure).

One aspect is that we map our proprietary power saving modes to Linux power
saving modes (suspend-to-ram and standby) at the system initialization. So,
we could have our backup mode mapped to any of suspend-to-ram or standby so
that when:
echo mem > /sys/power/state or
echo standby > /sys/power/state
the final power saving mode could be or not this backup mode (depending on
the mapping - which is done at system initialization based on kernel
parameters).

And so, depending on the mapped mode (which we currently know only from
arch/arm/mach-at91/) the real core's regulator could be on or off. We need
both these information to know if core's regulator would be off in suspend.

I chose to have it here, in platform_suspend_ops thinking that it is more
related to suspend procedure and that every platform could take use of it
to do whatever the platform specific things are done in suspend.
Also, I had in mind that regulator framework doesn't care (as far as I
know) what every regulator feeds.
It looked to me more proper to have it per platform since in our case we
have the mapping b/w Linux power saving modes (suspend-to-ram, standby) and
SoC specific power saving modes done only in arch/arm/mach-at91/.

I also though that doing so, and having the platform_off_in_suspend()
wrapper, in drivers we could only include linux/suspend.h and make use of
this wrapper and in case we would have had it per regulator we should have
been taken care in drivers or regulator framework which regulator deals
with feeding the core.

Thank you,
Claudiu Beznea

> 									Pavel
>=20
