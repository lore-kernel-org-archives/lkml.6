Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C7520857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="La8Xrf21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C7520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeGaSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:00:04 -0400
Received: from mail-db5eur01on0119.outbound.protection.outlook.com ([104.47.2.119]:13126
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727063AbeGaSAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prNRmbTWCGNYBo9BOWKiszbpzKL2QcSpGHlWGxZbME4=;
 b=La8Xrf21Pbhnk6OwgEyTaJyJe4obHplh/6Piugyu/gwCOJsDiPyZHDcFOyx/gPFJF46J6hviklxsBq8bKo84oL2PWC6zw7xycHSuhMxvFvXAkx/wfjnQ2l+/0uUstgfuJCWpHMso+l1Bu0mSV6HiW43Z5ghuVblPOiWNUp1G4OE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3254.eurprd08.prod.outlook.com (2603:10a6:209:47::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Tue, 31 Jul 2018 16:18:50 +0000
Subject: Re: [PATCH v4 13/17] khwasan: add hooks implementation
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        vincenzo.frascino@arm.com, Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <cover.1530018818.git.andreyknvl@google.com>
 <a2a93370d43ec85b02abaf8d007a15b464212221.1530018818.git.andreyknvl@google.com>
 <09cb5553-d84a-0e62-5174-315c14b88833@arm.com>
 <CAAeHK+yC3XRPoTByhH1QPrX45pG3QY_2Q4gz=dfDgxfzu1Fyfw@mail.gmail.com>
 <8240d4f9-c8df-cfe9-119d-6e933f8b13df@virtuozzo.com>
 <CACT4Y+Y=61VwwETQP3FwAN16ompSNJOCyDCG6Ew1Bm5f_Fe1Lw@mail.gmail.com>
 <b6b58786-85c9-e831-5571-58b5580c84ba@virtuozzo.com>
 <CACT4Y+aUs0YMTaQx4x9QiQsMjFNZ5gUFNuMkG_hneDPTb3Nu=Q@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e73efbea-9f23-9d1f-bd1d-add0c0fe4710@virtuozzo.com>
Date:   Tue, 31 Jul 2018 19:18:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+aUs0YMTaQx4x9QiQsMjFNZ5gUFNuMkG_hneDPTb3Nu=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0202CA0026.eurprd02.prod.outlook.com
 (2603:10a6:803:14::39) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df56459b-0c2c-41e6-9b06-08d5f7014f00
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:c/wgCYeGqGfdheHjoUKaNxmGeCzXBE7DUmGMi8hLtEbUTk0iocBw5Niyu1or3pOfo34tyg8brTFc2dcimzfO7eA6MZ3DJcLgv7gWIJOt4pCVeihjHzFmDLU06jC4Gcmbr0kNc66ZaAXGwHrlaovoQOseeMV/ae8j5qXdUbDm2vqBWP6U6IPFJNS06HNdGURW3xcCJ9e4CLv5Sb4Rxyl2lNh/g6MywGorra2NKTyL6LTp3qf+ygG2GbWR1Vc9umGa;25:NzIT6XPKP80+nVPjeP41MArj2I9iyFXxv+a1RfPmle+JiKrQS3stbrbNwIK7AaFmrh7CY/con20QVi5DS90AMxYiF71Qm1zeLmHFWe3TeudefYLQ7BiQsLkmcTIJFTaB+gdkwUAl4vUpWFxTpYn4YCHc67nnqba3f4D+a7PJe5mr9kBQQ5EZYJ/j1pHc0aHLG9vtKAYwOOES/0dp+1kK1EzKvpbVeUPq8V4V1ROLfcTha4ka2mlFBqXAHfapUSik0HhmTw8NFKl5jkNEsCQYy/fxnawiFJLZOAhB8gl170eKo+dJwSKOxQjmnamEJk18Zg6sWDCD6baYqBcQiEYzRg==;31:MG4knPC2oNSrVrnfnVHWpH1WSJfcXvcEPXeIknE2MH3wjv/CLiiP1G224iOFUaHl1t4JzQRsq1utLZ9to8PljCKdvDsSpYo33RhkmQXuy6qa2ynfHYqWhJkurPXfBnZGFpazxbsklVgXkDUrsP+k+/KpxlcUmGI4t+qt8SeOPUrRzEfAIJzohbV+h7LJm/d1OQaVH419/F7DDseLSLQqeMO7hYeKNlhy/FGG0bAPYDw=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:vpe6ke++Za6v9Fp5MAca5HrKdrRdWeeguRl+ey2RjlUh67ywI/2bmJEE4UWfR0vsu48+CHIvUVqBpEH5Rw+tamvJeWDicRP1ixE5/+ZWccJbkkUkg9XoTIN/1zaZ8YJ1VVrmtgHHGkpsyzLKW6uIP2x3jKpvhpu4q8ifY1r263weaDoUIZuBbelXyt5nFUhz5XQMxxgyHcO5oSy8gonkQJIcgGsC5rekrpnlm6/l6QB+jHLw8hrl9H8GNZmfsjkJ4IaAgEXw6ypq/Beu7dEm2AcOowsQRieGAKggSmACRb2THl8GFrkBYJX31nCGnV7rfxPV5Ly8kNkqhgxE8VMohEnj589a5xdB/9mlSv2DvwXdamkQ3Ukvvs415KXOlY6i0YOKx0IkQNVVKOL5tkIoZ5/2XeNHofN9ibUlGxaRlgeoDrUAvHk7OHJADzu6rVVb7/MZIll4lyweV8D+FkFxBOAbnRVcTjJSBw4/MpqPrJNq6Vl0VwZZcYFqoQBh8IHr;4:3GpeunDhA3PHrUZGXTAOSCJYPRYo6QbCN2llrMwltTtH9TcLU8WUYtb3m1Y8+Rg/Rw6dcItwOgv+c+8noav9fYDC1qMmEQ7/fFWSITc7scYflKyMH8rZ2973NoU7rs2UrmHjs4Aa5op4259yYW7jZPmso8bKdha5j7gqiAL/nJOthhG4HDU8GjzfML7HG+3blGxSvlcDUYSbKNRkBFwNBu65KFjn1i9Pi3CcrMOBj/Krv7y7Yjb9HNml3S6hy1iI0jAJzzaY4CKoFzCkS2ml5Q==
X-Microsoft-Antispam-PRVS: <AM6PR08MB32545A048B3A8DB6899AEAB5B02E0@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(2906002)(68736007)(486006)(6486002)(305945005)(66066001)(8676002)(81166006)(6916009)(50466002)(47776003)(65956001)(65806001)(6116002)(3846002)(2616005)(956004)(478600001)(476003)(81156014)(7736002)(5660300001)(7406005)(52146003)(106356001)(97736004)(86362001)(6246003)(2486003)(26005)(52116002)(54906003)(25786009)(446003)(14444005)(53936002)(58126008)(7416002)(16576012)(77096007)(11346002)(64126003)(31696002)(229853002)(76176011)(316002)(105586002)(65826007)(186003)(16526019)(230700001)(31686004)(6306002)(4326008)(53546011)(36756003)(8936002)(23676004)(386003)(93886005)(507254003)(556444002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU0OzIzOjlIeGZQTFZYMnM4VGZNQUhMUlVLVjQyWWFP?=
 =?utf-8?B?cWhnYzlIQXNhaVNuNUZ2Rm5FeUNYQWI5ZTRWbHY5TWNjVDNWM0VjM0dMZ1M5?=
 =?utf-8?B?OFVhMVNwVFltVGZOaFZUZ1ZuOWtNWi9OcTkxbFFyTzVNN3VSd1prbzQ4VzFs?=
 =?utf-8?B?d05HRGZDaTVVNlpHYmFiakgybUVjMW8rVi9ITVN0UTZSR3liQi9WYkZrWnkw?=
 =?utf-8?B?RVllZm5CeFE2K1RmbnBrS0hoQTZrWm03V2dWb0FYTzRoMFNlc29ZV2NnMmp2?=
 =?utf-8?B?NEdqVnk4bnRsV0Q5WDJlYjAzd0IrM3VPYkZDbWtyN0lsUUkvcHkwanZHUkFT?=
 =?utf-8?B?QTRwNWptR0FzamZqVmIwSTlKa00xSmkwSHhtOVNkWm5WZmxiRVVLS0hPUHRU?=
 =?utf-8?B?V2dwL0FaTDVCMHRoSmE5eUJMNmtqSGhoanY5eHg3OFVlaTNuWFlFSDgzREla?=
 =?utf-8?B?VEZKcExFbHE3aVBBb1J6ekdQMG13VzdpWjArN20rdWRvdzRKMmk2ZGJ5UkZK?=
 =?utf-8?B?UEFLbDkwT3VKSEJjNlBJVVdFT3JHQ3hyZWtkT0RWdU1zb1ludndtamREWW53?=
 =?utf-8?B?eFlrbmhtNWF3QVV4NHUyenBiV2J2WXRQTzlwTFdONWp3dnJYUG0zTXY3anRR?=
 =?utf-8?B?NU1ETW5QekI0SFM0RUZFcFpmTmdEdTFBOFkxTllkc3VzaWwxRDZudlVOU3ds?=
 =?utf-8?B?MkRwTldpLzBHd3RyTlVyTWdVUHlwYVRNVTUrN1I3blhuYUVDV1F1WkZTUy9q?=
 =?utf-8?B?MWdsVnhjT1d1dUJWbHVIRTEvcW1GVnRQVUVQZVMyVmNXNjg4OEJRYzRQQUlj?=
 =?utf-8?B?cVZ0YlZuV0RBSnFnTlpUTHZwMUpuaVYrRUxjaXJzdmlUblM5T2tQNmdjVEZt?=
 =?utf-8?B?VmhWUXhmV3djNWhSMzB1bXRZWlhDV3pIZjBSR3IraU90d09GdGo5djVGQ3Zu?=
 =?utf-8?B?Yzc5Sm4rUG9LMml5TlljYTEvcXlrQzNnZC9lUjUwUllGU1NldE5IMk1nM0dB?=
 =?utf-8?B?cXBQMy90VG52bXVVYmc0VjA2bWtRV0VhZm1xWklzVnRNTFllYkppREFVblc4?=
 =?utf-8?B?SldzQzdZc0RUcDBVcFBoZnBMM20xUFlEc3pJOHBRS1RSU21nWjMwK0s3U1U3?=
 =?utf-8?B?RjFocmp4MGREbkd4NEZ4bCtUTU4xL08zVUVUL3grMDNmOVJNK3VOMWVvUkpX?=
 =?utf-8?B?UWkzS1lPc1FsQlkvbHpNMlRSN2M1VWNycmFxRmF0OTA2MFluK01EUWlqUFR0?=
 =?utf-8?B?aFBxS3hOdGxBLzRwdllTVzQyYVBwejhSQXZ5Ri9UbHkxdWowak1RYnk1cnh0?=
 =?utf-8?B?aE01OTUzZnpldExYc2p6WFJqOHZvYlZzRXNCNnRsV3Bqd3phNVU5KzgxY2Rq?=
 =?utf-8?B?ejZNaWgybDJrOVMyRGZwbGJoUGEwVGF2d1ZqUGJ2QWZLdEthTzBYM0Q1Y1V1?=
 =?utf-8?B?dU9tQStYb1FYb2dQWURma09za09YeW1sWDE2VDFvUnkrV3B3UDdDRTdQNStT?=
 =?utf-8?B?aFAwaDRyMERxeENQeGR4ajNRelFCOUlrSnZ2OWV2azV2LzhGamhneEc0ZWRr?=
 =?utf-8?B?UGhYeHo5MGRkR21naUl5TTRVYThPWDg4MU5sWFJSMHEyYkozQU9TelJ3OEZ5?=
 =?utf-8?B?eC9yelJRNHhjci9PNmt3aHF0SE5ablFyLzZOVCszTHRva1JhUTB3am9oWHI5?=
 =?utf-8?B?T0lUbUl5Q1hoTzJSL2dSSVhqWGFyRHlkY09Sb216UVZjMi9xYWhVWThWL0ZT?=
 =?utf-8?B?V2l1NFVYSzZ5TGh1WGdsd01uc2JjdExpTHMwVUM3bVRPQ1FhS0ZnRCtMRjBp?=
 =?utf-8?B?OFR2WU1uVDhQcmx5K3EyL0x0NkgrbE1nWGNpaHQ2VHJNOW96VTVjZ0s3cFEy?=
 =?utf-8?B?SGxQWUFQTEt0cUFVSVFvOU1vZHl1MVVEa2hlUGs3TEx4cHlKalJBbUptQ011?=
 =?utf-8?B?Ly9jaWM1MjJQdFhwbUUxYUpmUDVhRU92aGtMeE9HaGFlc3BtWVdObW1EVmZO?=
 =?utf-8?B?ZEJJOVBLa2dxUE1QV1RHdldZNmcrb3Z5TVA1VWdjbmFYbmdyck9pQ2JHNmo5?=
 =?utf-8?B?NlF6bDlXVjRpVFdlTWh6K1Q5R3hBUXp0Y0ZjVldCaExueGdMYjBGMTdUTHJY?=
 =?utf-8?B?VWc9PQ==?=
X-Microsoft-Antispam-Message-Info: BbCsbeSCqEvyg/az4mOWI2OiUsEoFdCXi33wLhItsmBST9fg5PHLPgoKIBiLzyfxgh6f48hD/SHbcsVaF+Mim66MH42u2LU9665zLUrJg9VoFD3X4p7qSKxJX9IyvXipLDJ2sBasSpoEOdOYOMOLUUlh2nF834OTAlvTFLwikSifelZORFBvi4PC4DqjBpfDaQGwEJ1aVPmqQZ3yOPm7Ylo1yi4U/nF50NIG/LK5cnb24uRUuPp5lw7STgQz/Lc1EgfjM7y5OSIEQc+ikV/6KBkqcXBt3KKswYl0YuwOulYjdMq2x/llFgLv+UAaMPARPG31wqej+1k5gm+WCUTZ2kZ7t7sbMlCKGpsVxa3oB5M=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:GeHmNaNZ4Hp6B2PkqEDyivKn8tocWnpUu8rweBwaGXxKNyN7KZpo75qPtu9PR4U20X29ZAFGt1iUJ0PRujNtoUNt9i0q1J02CGzuaGpgQr0rk7tQ6kE0z9AxaLEw2jOVYQCaFRkjXsuBoQoEtOzS9AWFaypNKdfpGoiJduq+PI3lxXkZJUqpfROMdRVouKluOpqK0Vrl5LTSNQ9zacJP60TaSg84HD1pAgsFO/pWeTC+GwavkWTmuy/qquv9n+bs61eAMYHZmR8nEECRAAEgWa9RfKgocF5pHNK6dR6KqMVQ4SYfUYw0j8Ldxa6TM6Vq6OX1PNqsmQB0wnyoDVqAZsju17GV/MecoiKsMH5cgIlGtMJS8TPDoRBYTs7mPfI774ljWKkrVcrTIalZ/kIZD0obSqh0Wfwv8oinGO4Xyo8B6KZntQDk0ThsnuKguQVlywUSeRWLUX7zag+U9DyTHw==;5:B8vdZU0ctEL2aGNTaU/ac81wbjBaU7l21XrjOlJA0iD/GzSR10eI/8z8ECWSfFDLFGeMUA3HfYGY48o0g9PcdeX0C80pDnLM393114nXFnGsYd3kaHVGe4exaJpOAiyXa/a16dpbKtKoafGffGpRvbXlfHID7Vqp2LHkxULPry0=;7:EAJIqrFgmXVqIfxZnCscj8oT379WRoMTH55MoXLxUZxBR1mPDyeH8f8LuEvfO0Iew8x0GZTh4MOGkgg6FVECAJX5OJnVh3p7fn0CP2VMkDynJs4QaVotlGytKZXjQ/AoPugTAAxt/yE0NBmIZOnBfjOSC5Qg/hcnHtXx1y3fI+KCFxXVnDR0jkcxAvw5TtRRuXyX1/92wuq3025OgRlvL1cJfofWfJxY4YKTXOFGndV+meGKJ8iS+yUtYJyfJWbk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:SxYysiLh6UKCTDPPxtjeBASk4bgA0xsainNyFy5QYjBqBuADYWyn7SdUbZvjdYbeal6zZTkFjwt0UnFWJKg8CZjXDUuextXzCBLwzh0OoGuFKPNBRWW2JS9J1Weazni6M4neuZGDNOiMO8HkjIsTvjzDBgVt61DfepMnUbIw+ao=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 16:18:50.2788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df56459b-0c2c-41e6-9b06-08d5f7014f00
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/31/2018 07:08 PM, Dmitry Vyukov wrote:
> On Tue, Jul 31, 2018 at 6:04 PM, Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
>>>>>>> @@ -325,18 +341,41 @@ void kasan_init_slab_obj(struct kmem_cache *cache,
>>>>>>> const void *object)
>>>>>>>     void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t
>>>>>>> flags)
>>>>>>>   {
>>>>>>> -       return kasan_kmalloc(cache, object, cache->object_size, flags);
>>>>>>> +       object = kasan_kmalloc(cache, object, cache->object_size, flags);
>>>>>>> +       if (IS_ENABLED(CONFIG_KASAN_HW) && unlikely(cache->ctor)) {
>>>>>>> +               /*
>>>>>>> +                * Cache constructor might use object's pointer value to
>>>>>>> +                * initialize some of its fields.
>>>>>>> +                */
>>>>>>> +               cache->ctor(object);
>>>>>>>
>>>>>> This seams breaking the kmem_cache_create() contract: "The @ctor is run when
>>>>>> new pages are allocated by the cache."
>>>>>> (https://elixir.bootlin.com/linux/v3.7/source/mm/slab_common.c#L83)
>>>>>>
>>>>>> Since there might be preexisting code relying on it, this could lead to
>>>>>> global side effects. Did you verify that this is not the case?
>>>>>>
>>>>>> Another concern is performance related if we consider this solution suitable
>>>>>> for "near-production", since with the current implementation you call the
>>>>>> ctor (where present) on an object multiple times and this ends up memsetting
>>>>>> and repopulating the memory every time (i.e. inode.c: inode_init_once). Do
>>>>>> you know what is the performance impact?
>>>>>
>>>>> We can assign tags to objects with constructors when a slab is
>>>>> allocated and call constructors once as usual. The downside is that
>>>>> such object would always have the same tag when it is reallocated, so
>>>>> we won't catch use-after-frees.
>>>>
>>>> Actually you should do this for SLAB_TYPESAFE_BY_RCU slabs. Usually they are with ->ctors but there
>>>> are few without constructors.
>>>> We can't reinitialize or even retag them. The latter will definitely cause false-positive use-after-free reports.
>>>
>>> Somewhat offtopic, but I can't understand how SLAB_TYPESAFE_BY_RCU
>>> slabs can be useful without ctors or at least memset(0). Objects in
>>> such slabs need to be type-stable, but I can't understand how it's
>>> possible to establish type stability without a ctor... Are these bugs?
>>
>> Yeah, I puzzled by this too. However, I think it's hard but possible to make it work, at least in theory.
>> There must be an initializer, which consists of two parts:
>> a) initilize objects fields
>> b) expose object to the world (add it to list or something like that)
>>
>> (a) part must somehow to be ok to race with another cpu which might already use the object.
>> (b) part must must use e.g. barriers to make sure that racy users will see previously inilized fields.
>> Racy users must have parring barrier of course.
>>
>> But it sound fishy, and very easy to fuck up.
> 
> 
> Agree on both fronts: theoretically possible but easy to fuck up. Even
> if it works, complexity of the code should be brain damaging and there
> are unlikely good reasons to just not be more explicit and use a ctor.
> 
> 
>> I won't be surprised if every single one SLAB_TYPESAFE_BY_RCU user
>> without ->ctor is bogus. It certainly would be better to convert those to use ->ctor.
> 
> I have another hypothesis: they are not bogus, just don't need
> SLAB_TYPESAFE_BY_RCU :)
> 

I'd call this a bug too.
