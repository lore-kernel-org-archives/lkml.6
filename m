Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A70C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B49720671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="mglc60XV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B49720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeJWQ6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:58:43 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:28895
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727352AbeJWQ6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCULCQZxTpwZIkP10yQFAxRVF2ChI26cq5NYd3Dwk0A=;
 b=mglc60XV9us5r+uUsJMB/niABv+p19vug1sFlGoWrjcDaHcsEp4VVNDT2XAFAOM2EbHKUoPAJWOWPVlhjBmOdniDb5UyO68JRRj7fPvrEWG4HVpOJYghhbt5PAUSI7+VVKX0WchLdBoYOFERWO2NsVaWq2bNMpbvraweYuRvnus=
Received: from AM4PR08MB2788.eurprd08.prod.outlook.com (10.171.191.18) by
 AM4PR08MB2625.eurprd08.prod.outlook.com (10.171.190.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Tue, 23 Oct 2018 08:36:16 +0000
Received: from AM4PR08MB2788.eurprd08.prod.outlook.com
 ([fe80::11fa:6313:23e1:c943]) by AM4PR08MB2788.eurprd08.prod.outlook.com
 ([fe80::11fa:6313:23e1:c943%2]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 08:36:16 +0000
From:   Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Kristina Martsenko <Kristina.Martsenko@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, nd <nd@arm.com>
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
Thread-Topic: [PATCH v5 07/17] arm64: add basic pointer authentication support
Thread-Index: AQHUXIhuaCYPVPx6oECJrNko5qx/h6UmgRWAgAYcxAA=
Date:   Tue, 23 Oct 2018 08:36:16 +0000
Message-ID: <5ca5bf92-f2b7-48c9-ea41-5efeff09a799@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
 <20181019111542.6wrvjguirglzg7vg@mbp>
In-Reply-To: <20181019111542.6wrvjguirglzg7vg@mbp>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0246.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::18) To AM4PR08MB2788.eurprd08.prod.outlook.com
 (2603:10a6:205:d::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ramana.Radhakrishnan@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR08MB2625;6:AUB+e/UoJvx3VYvCHVoGvBpTqzmOR0D0itzJyaJGZnMv5ParIEWbCqqSzECH+mqDmWtjdVPcU93yxJqmIRJfMcktcNuIxwxIjMg1xkgGqxXirW/W1N02ws5TyW8uawkgOjZOlNjgGp3Aor6b5UIR3SGEgVAayYUbPw/hKmvraDvop3hX315V9+oIT6UzPSKRg47jVRoG76KVQCZVWj+GrTlQIZJgOyBUNcs1jR2zKh+jJsX3mU6VVbZgY6G0KMfdsjKrDA1NsOsT7My9bQULYpzvYpRbST/ixCGr33H8VkS0x0Y2/oXZplMbEsCmhJKDURhuiUZuDvAQgyaieDH9kLuLmGPQyUB5AcydlIIV4j4PTsqgRbvQiEeLcsrdPo8ubiXgtzQYmA9G/Lk8sqlvdhZADvdCumO2tbkgy7j769jS+fdf4SGxpf0zmckSU52LxZIhhOmZsYncFQG0ojIrlw==;5:PrPygIbV9Kw5L0tVyl520SZdry6GsYcqj4MFNxFW+0AA4t0Up+HpJBWDjIAsVlqUab9QgqL5ttKQeWDVbKhKjPiiS0m9MkQAZN/7o+09YJnMjlyvrpAsTaDcS2r+srTXSr9kdWKyyibVxOfHFKTsHOkaCb2GX+PvS+DQEwSNKHY=;7:BSFmoOQDoRR3kNaNT8ANEicmYYpHurNh9O8O4PII5WRS/DTYSvUaR/SiP1xI824zTvIBzMdZQ8oEC+AJathEbhzJszL/6doC7fH9wqWpIHU2355uae5KfKcfUR4/VJpCsYjqSZRpWfwJ+Z2FpT9m5wkBOfeEcMOfLq8D9GM8bgtAjQayexKyA2Zdo86Z/MSjkR8kgeDc7H1tTPP0nN10XNhK6dTo3E7QkwO0PEJ+i0Dn5UAi5brAvK/0f2f3lUcc
x-ms-office365-filtering-correlation-id: d53fc0e5-0238-491d-58b7-08d638c29908
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB2625;
x-ms-traffictypediagnostic: AM4PR08MB2625:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM4PR08MB26252D336429D89FFF66535D81F50@AM4PR08MB2625.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM4PR08MB2625;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB2625;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(446003)(5250100002)(53546011)(110136005)(256004)(6246003)(6512007)(86362001)(11346002)(476003)(2616005)(6116002)(97736004)(65956001)(6436002)(3846002)(486006)(2900100001)(65806001)(66066001)(2906002)(53936002)(186003)(44832011)(26005)(36756003)(7736002)(85306007)(64126003)(6506007)(25786009)(102836004)(305945005)(76176011)(71190400001)(99286004)(71200400001)(65826007)(6486002)(105586002)(4326008)(5660300001)(31696002)(229853002)(478600001)(81166006)(8676002)(106356001)(31686004)(316002)(14454004)(68736007)(72206003)(6636002)(52116002)(81156014)(8936002)(386003)(54906003)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB2625;H:AM4PR08MB2788.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wdI0/uhqyFHNSYt1OioI8/o48iyV6NmL0z54A4ZUU7T/u54xffpVnkqiqpW8puyHtebHi2PeuUDnEqNiOX2CjGwQRodr2+9QrkLA3aqjt46PdB8w0i/QNiB4RlffJEoSueGjV5YA2Vf2J6AxP4D/adxe4d9gXghS/M2PH0wquSl1Zfim1sqZjFbwIgUoNRaKFIxOknOOiMn0Vywnli6B/ZGofN70fB/DI83XQNRqS8RWkVGU3EuRmj6y34n8jtCE7JuRLkKWyG/iORdIrMPf0UwtgGPbH0QuU8Wmp724zLmg0Z7gaiEhtRx1+YfTUg5skxkQ90Q/f4qUja2dPGHOhVpQ6ZBsR7ngNtpPHbmkBTI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <AAD136982C3E6A438E34A7F2DAB94C7A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53fc0e5-0238-491d-58b7-08d638c29908
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:36:16.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2018 12:15, Catalin Marinas wrote:
> On Fri, Oct 05, 2018 at 09:47:44AM +0100, Kristina Martsenko wrote:
>> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/=
asm/pointer_auth.h
>> new file mode 100644
>> index 000000000000..2aefedc31d9e
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/pointer_auth.h
>> @@ -0,0 +1,63 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#ifndef __ASM_POINTER_AUTH_H
>> +#define __ASM_POINTER_AUTH_H
>> +
>> +#include <linux/random.h>
>> +
>> +#include <asm/cpufeature.h>
>> +#include <asm/sysreg.h>
>> +
>> +#ifdef CONFIG_ARM64_PTR_AUTH
>> +/*
>> + * Each key is a 128-bit quantity which is split across a pair of 64-bi=
t
>> + * registers (Lo and Hi).
>> + */
>> +struct ptrauth_key {
>> +	unsigned long lo, hi;
>> +};
>> +
>> +/*
>> + * We give each process its own instruction A key (APIAKey), which is s=
hared by
>> + * all threads. This is inherited upon fork(), and reinitialised upon e=
xec*().
>> + * All other keys are currently unused, with APIBKey, APDAKey, and APBA=
Key
>> + * instructions behaving as NOPs.
>> + */
>=20
> I don't remember the past discussions but I assume the tools guys are ok
> with a single key shared by multiple threads. Ramana, could you ack this
> part, FTR?

Sorry about the slow response, I've been traveling.

Ack and Will's response covers the reasons why pretty well. A prctl call=20
would be a good enhancement.

regards
Ramana


