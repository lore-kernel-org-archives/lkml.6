Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B619AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8F520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="rXrSnTgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8F520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbeGTMBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:01:48 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com ([40.107.7.97]:26240
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727361AbeGTMBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVWv95Hva3+8HbpoOWArAuDa9RoWgYyn+y0HnpT7Hrw=;
 b=rXrSnTgOpBvcBDhURNlJUER+C5EyMZiue/KqbtkQt205iKmQlOUfzfpsxQTk6J7lRz0C38z3MwEHLTQLvWF/gAUTOuWx4CfJaX257XLpZyfUOMTR24T+s0AraWrbhmoGpaWaQd3+kO58jOEwcesUWhp9nI5DGt/4fdTNVlyhLF0=
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 11:13:54 +0000
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
Date:   Fri, 20 Jul 2018 13:13:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0185.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::33) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a56ad5f8-722c-4e77-72b0-08d5ee31e280
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600067)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:dSDZZc32OLAYKxsj0yngjtkHFKlsOOm22nyMKndcGIeu7S7azisnTCq/ZtYLCxMXnnvR27/AiiYZ5nGjj68Ijy/zJu89DKsggaUU8sJWY24wHNmQk9sGKp4YLTGnqaVEIbEdFRn83ie6ey3dsY67Sb7FvFODBo5y5j8Gj82J7pdL2b4ikMP+/6j2qYofygVgMzGSrjEA8YwXhP3j3PU33UxJfi2R2ixrb/OOKkNos3g//owRhMFFPcm3bBpfv2WQ;25:/ZFJcy65WEOSWG/fQKG6Ddl69J3hVgt9VoCG1kr98H1oeL1r/5ckO5ztjkTG9f11R7uE5r43zIigd7EkKCrTsEbvzxO5+CZ0G92slJWe5aO2LC+t5SSruIhbLxB5l+crIQilPMi5y7e5tO6kepZMCIoRdxPo3EfaxBjxz5nG4BGGBU2b5URpujGSIC24Urgw7NizJ+G12Nh9Pu6itnketEhSdMb+cnIsyYNPxpXoyZvtcJQZvzhJGQCh+CGGqTg2fdwtz0yYY+wQR40U0SllU5z4Cvid+1EuFOysoGCuyq9VDTDEZL96jKMBlGpvfk55yFvi0DvzLrJRa6ANU9Vpag==;31:az/4GG8kcA4KWS05yZGd1z0lTAJut8qhLURGrtCwWkblqglgtdJAXuXJ6dJoMLdj82IfFYYHcB1zB3mFALR1ngvEhNYK7RbFzg27i41Uhahgi5NScVE5WC8XmCjb9OcGnf/dC5lnoS4O89A6VJYSmXEkJQg+9sDjPDUyH+3qVotr9QOk19ozT1jh5MF/aQu3Fbbwigksx5mTkUFMInlbcOybVEnFqrP2+C+Me8lbFTM=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24521B50E7A6A9A3B1CCA6ADBC510@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(2016111802025)(6072148)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:uuMVdlP2tYLkX0vUW3TAWI8CE6urFCBZN4uAGU+2cL/YH4e9nRA1OCVSpUideiZ1sFQ/Xm3bCNfu1VWtAZ3W2VTjbVdSxZBvWr/ISHqx4a2zNEivuFlpoDaQ968yOhX+uqApnVmGlGgx3DfXcVtljtJJyVD0hkZ+LLFMuyMq+9BJ5t/Ocb8JjJCTPVE+2Q59x2IwLEHtvYH3+rMO8GV19MneEQsrZ4eTKDNoevrwlkPv3fw0UYn+Xpu8jRy2vm96bwSu1l5l8F1QITGCaJTlwg==
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39830400003)(366004)(136003)(346002)(396003)(199004)(189003)(5660300001)(186003)(7406005)(77096007)(8936002)(86362001)(7416002)(6486002)(65826007)(26005)(50466002)(305945005)(81156014)(36756003)(230700001)(4326008)(478600001)(81166006)(6116002)(53936002)(6246003)(7736002)(8676002)(3846002)(31696002)(446003)(25786009)(3260700006)(65806001)(66066001)(117156002)(65956001)(64126003)(476003)(11346002)(68736007)(486006)(93886005)(47776003)(97736004)(2616005)(956004)(52146003)(386003)(106356001)(316002)(23676004)(58126008)(16576012)(31686004)(36916002)(74482002)(6666003)(229853002)(16526019)(52116002)(2486003)(2906002)(105586002)(76176011)(110136005)(54906003)(53546011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTI7MjM6OWk1cVViY2FzSWR3Sittd3MrZFg4NlpP?=
 =?utf-8?B?VVNWNCs0NDZwTmR5VW9xcTNtYklLeHkvcjdySlNUMzJ5K2NuL21TcGl0S2Rw?=
 =?utf-8?B?WW1teDVaNmFyV3F4THJiRFZPR3lIRWt4MUloalE3ZjZhNjhJZUo2WCtNTTNs?=
 =?utf-8?B?WGVmSkI2Vko0SnV2b2IzZ3RlbXhDU0FTY3AwNlRKU2R0RDdHSUJjakEzWFM0?=
 =?utf-8?B?OTZ2bGU0NWxUOE9uZFdaUHZzdEk0REZ0T1VLWk9HbEJhdEt0YlBNV29BWVVN?=
 =?utf-8?B?UnFJR2RyRHlIS0x2WkQ0M2RXamhxTWVZQjIxZWhuSTdxYjIvbDZRdE9FYjBC?=
 =?utf-8?B?UTF5OTgvZGR0bnNtMEduMndKVjJZSWNCSlJvQThpaFQ3ajllUlJNbkMzemkv?=
 =?utf-8?B?NWdCZGdxRjFwZmNNdHFOWTZyOG9JbmdILzN2ZjJJUTRqWGxSSFN4Ulhlcm5u?=
 =?utf-8?B?aTZiMzVzOHU1V1pyRmdoS1hTbitZS000RmJVcUFCNjhzV21Ud0U3bTRPeExG?=
 =?utf-8?B?YUFRZ2NaTU5qOG1VUWpydWQvcGdvSzAxWWJPRXEzUzUrTnJ5RStlZGFkbFlz?=
 =?utf-8?B?dkxpYWlXcUFpSDRPUEF2NTFTVnRuVm5rNjhQS2ZCY1lEOEN1SWszcHJlU3Nn?=
 =?utf-8?B?Q1kwTEd0d05ZSWRoTFVZSXM3YkEzTGl4Wk14ZjZ2cEtDSS9rM1A2dWhpWSs1?=
 =?utf-8?B?VXhncFZhalQ1T1NucnFKMFZkK2k5WUdIa1lqNjIwd0d4dlNCNHB0R3NxL2pN?=
 =?utf-8?B?VG1saHNHeVRnUXNBWTJHVjRwcTZsdktnZ1RlN2Y1QUp6WW9qcXFNQnpBM2J5?=
 =?utf-8?B?c3ZKQ0FycXB4UlBja2NwSzNjbTRWZGNlc0hlNnBIZXduUkcxR0padlRSVWV3?=
 =?utf-8?B?T1hoVitaSnZjY3ZyMGVmcG1PZHNpSmRDWHpQbm40YzcrV2luT01zSUZ5YUFo?=
 =?utf-8?B?aG9oeUdhdkhrUTBWeWRsQUR6RmREMWd1bWZ5TzczdVRqbU9NMVVzaGlMUy95?=
 =?utf-8?B?bXc4YVAzZnhWM0JNbGpKTmNIOXYxV1k3QjhiZldpaE1UL2RkdkpLczBsbC9J?=
 =?utf-8?B?aDk1aUpJSkE2dlhpdGJXQnJNa291bDl4KzM4RURIYUZ0QjFCWE5UUUFoZU9p?=
 =?utf-8?B?cnQvdkFYK3JMNDUyeVdjZFlKNzhPcDBTV0VHd1d3K2haRE1xTTMxblFGV2o0?=
 =?utf-8?B?TUNUSFh6cjIyN2NtaFlCU2ZrMFAyTEJyNmRXTE5iQ2llSlBmZExEaDhiRXZx?=
 =?utf-8?B?OHhRcTRicXNoallsWG94enZZZHBnRUh6cXVRWmNVakd4MHBWZzFPS0wvb0Ux?=
 =?utf-8?B?dEZ1Y0xXNDd0T1ExWEV2UXZOUEJaZUpSY1paaFY2QTRjSk5DMEN0dTBTbVda?=
 =?utf-8?B?QjVkKzE2TExNRlFpcjlYd3ljcDVLcHhRWUVrdHRCM2ZvWmNOT0F0M21HRm4w?=
 =?utf-8?B?cTRRZ293SDhzTXd5TDRqNVVGL1gycWw1L21taklIaXNwUENxUlQzclcrSTVV?=
 =?utf-8?B?ektxcGhZNVFmSi9nWi8waWFrSTVsYVZFWFZSdVV0bFRvNjRZSFVOQ2hteFFH?=
 =?utf-8?B?VCtRTEVETU10Uk5UMGpndGpFOXpISzdFV3pkNUl5WlAySnBtTFQxeS80cjhn?=
 =?utf-8?B?ZXFNVDVhN1ZzUmgrcjUvSEE2K1NvTUhrbVRiUzZvV1cvR2tqelp2bkZVbjMz?=
 =?utf-8?B?VldMNmtLQkpQRFJ2TzRmTzczMkFwTmVmQk5aT044QVFESDNRY2R0dDNYMW1L?=
 =?utf-8?B?YTRqR0hlNUtiSVdnT3BjcWQ1Q3V0Y1YzK2tDUGNkck9mZnRDV2dVTWxCbWtl?=
 =?utf-8?B?bUN3UFZDWWsrelpya3d0cTFwdmpkdXdNdUZHeEhvT29HVlEzSk1wQ0RwMzlz?=
 =?utf-8?B?dGNjT2Z2U0h5K0hxajBVakNnZkMxQzRINFhZTi9NRFA1bkJLeHdYd3U1TnFj?=
 =?utf-8?B?cW1sWlo2bTRFQU5pZHlnMlNVRXFJNlJDcjQ4L2sreGFoU0pMNnFjVk1qQk54?=
 =?utf-8?B?eDJlemVnZjV5U0g3YXp4L3VHN09udlM0QnFPdEEzcUNVSFlmcUR0ZkJVWVd5?=
 =?utf-8?B?Q3hoRUhJOXpyN3lxVS9Yc1dsMFIzVDBPZVNCOUVvRHdGOW5HbWZRTWdHU3NS?=
 =?utf-8?Q?VmIpL5mubuVguDEyjHL9d5Q+OgNfZntyQem569T8HcFSgp?=
X-Microsoft-Antispam-Message-Info: rplRuakyA6v2gEY1qabkOMXrVNXcidDBNvWJTILdajC2I9Jt8q+x/BMcc2AhbRh0l/vR6Gq1tkTkNO7aWZmURIS2dT/6xk+uNl8rxGEyOiRlfmREJKiIBcrRWas44nF4fMgINgpkXDfWrp4sViZwUVYbarFlQ74j6uQGtEcYBMhl2A6Bpb4NOJIMYCVdQt0wLehuRh4ogiQo6biBdbj8WOG6tbDSRfqhoCn9Ld2olrA2Ighe5lRqLHEV4MWiHi2sJibMUJjEWQuWDCiqPKIW9/YycwLSZ5nirregSnNY2qH7PHRtp+Xuc5cOSpSZ7fB1te8642f7oyXuG+69VX34/BqLgmsDSS0FSzDIztdMeq0=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:MGNCj/pvU8SPIyZK6r/YBC4E1cyJ8WJJdbATW62gcgZvpkQgLW9SOhjH789spAPRhTApKatvf21UbMB+Qo25M/XVOzptqhabrLbf4IjJYNOVKJPY0c+1eePcTQE++a5jvcttNJ60ADxX9lzpxOM3sGg2ZA+awH7Ms0sMztySbardU3o4oiCKmoTNWLHuamfHy7RHUXoq8LCPuZvwBNCY8KrwPY5Y4dRejFfqoSKJShm1g9OK7sLyDxzDdVYmhe/8M0TzLn1UowM2dE5AgY70/WkTN6Ps08HLEihlXOlOXWZOPKjqybSNZ1+qcsnKZ7S5tC+Lr8OtYTsQrUNkQp8c6kzMwW8mJI/qZ1Wvev6MftF1Ot/SoDYU4OgunZlvxYa18RzQndq+baS+rPT9f8hANyTZBczX4ghsWwVIvPdcLjd6X7L87vTt6sc+FA0FsnkFDh6O6WC36/Ol4RVTZ8/CsA==;5:0bSHdzMKQ7y7DS92QkLmgX2FuPcX0cpsqEn5hb7DiBcG0C2AvawuheW610xvgWd+KpA3gYgIqXcPhgTxVorNM8W+JhONMbXY8HEJseimgbKjBEjb7oEtO7Jz4iumDoALNxPJK91Twrj40XXKAyheOQ+zeVeNx2CFY/UlP4Lq35E=;7:moQibn8V+ASG38UA0oxxQGj/qk+1i3p3JyplXR3ACkct3yc9SbE6CUa3AZZjVcS8B3SAuukXT0YBQH9kL52E0msFnifRe5MMPHd4iGf/weUFjpjQhuSMQBRl/yiRIUtgwnU0oaYBFFuMWhzszxTrNhEswhDAN20slcPFyy3Ckxp0w+J5250+lfAJFJnACu8psVbAma9HJbKkw+r9KwzQVrrzFgqXaLM7SJUksup4nFZ3svqKOw46Ug95UU1pQxdJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 11:13:54.4704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a56ad5f8-722c-4e77-72b0-08d5ee31e280
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 12:57, Arnd Bergmann wrote:
> * What I understand from reading i2c-demux-pinctrl.c, a slave device
>   will only ever be observable from one master at a time, when you
>   switch over, all children get removed on one master and added to
>   the other one, to be probed again by their respective drivers.
>   I can see this as a useful feature on i3c as well, in particular to
>   deal with the situation where we have i2c slaves connected to a
>   pinmux that can switch them between an i3c master and an
>   i2c-only master (possibly a gpio based one). That particular use
>   case however doesn't seem to fix well in the current code, which
>   is structure around i3c buses.

It's pretty easy to come up with examples where this reprobing is
not desirable at all. E.g. if one of the involved I2C devices is
a HDMI encoder (I have a TDA19988 here) sitting in the middle of the
graphics pipeline. Blink-blink on the screen because some *other*
unrelated device needed to be accessed by an alternative master. Not
pretty.

(No, I don't suffer from this since I don't need the demuxer. Which is
fortunate. This was just an example, I'm sure there are others.)

Cheers,
Peter
