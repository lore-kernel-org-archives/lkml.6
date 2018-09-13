Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD89C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A747220866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1+9xZY/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A747220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeIMUEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:04:21 -0400
Received: from mail-eopbgr730089.outbound.protection.outlook.com ([40.107.73.89]:42064
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbeIMUEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgkW0XibscIwDrQJdLhMvvBYP8A64aacWD7BdV0VXIM=;
 b=1+9xZY/HmeiEd7Op7iymO7phnDqIiUh/fMrf0smtKwEbCh5wihs9WWbs+LD7E34nj63aLY1n/JOAKyxt6CmpaX8603GZwjAUPnPea8eV8qiEix8Bp+qECNpQEeB/+WyeVp8poGBqLEODu1I9va4QI39i2rd1IsGqaViJfNw96e8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.18.82] (165.204.77.1) by
 CY1PR12MB0168.namprd12.prod.outlook.com (2a01:111:e400:50f6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Thu, 13 Sep
 2018 14:53:21 +0000
Subject: Re: [PATCH v5 2/2] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101123520.15880@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1809101158080.1402@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1809101259520.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101343370.15880@cbobk.fhfr.pm>
 <f0fcbcd9-4619-391e-3c1b-34d06b00de50@linux.intel.com>
 <alpine.DEB.2.21.1809112315320.1427@nanos.tec.linutronix.de>
 <f95c28d6-70f2-3f18-4ab9-c756c7581126@amd.com>
 <d098fa9b-f244-68d2-77f2-e3f5dd30f174@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <d02da815-95ef-2ed3-b90f-776b60f8bc1f@amd.com>
Date:   Thu, 13 Sep 2018 09:53:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d098fa9b-f244-68d2-77f2-e3f5dd30f174@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:404:5f::11) To CY1PR12MB0168.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ef9a25d-f5fa-4b5b-bbf7-08d61988a72b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0168;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;3:GFFGIoOh1+aNs7oe3pskOxyMaJw1vaHgBsA7OHNDMAbFW6trPYXxCPGV2A6pH5mXuAAlkGLhtRn7Z7nSbSFzdG0m6jNfvZOq3DvlqNTJNQN8xPoRQx8L9IKrYLNHbd3y2O8X9/0G39E0YxO2GvO8KvFAheIw/usZvQ5+zUCDoLeYl9ASuoswp67R0myuvmpSendlKyeMsNHCYHRc4p4RdSzmexMCtJDEO/s+qaEIwVzB0EeRUDx7mpveUF64o6Do;25:mmNgX9Z/i5ldXT95FvpQW1lwpUPm9yXydZxg9R3Q2HRjUY9f/mPexAAVsiI2po0TKOJU9mWNGixfj6YLgE+b9lmynBEOvCHaArirxzWj5WR7aaD+ZYARR8uRacbuPhoL47ZLScEBV+2FaaJvA820Rrx17OQCmmNsszMUsgk90HAWFHOoi7ud6k9HesWN2PW3Lr61WK8hbNwZqrMbNk8MgCo0YV/4Lutjfffl65OT77EoXwR76B74bAkcnpZRyDNQZ6e0VeWEq/tlCzt1o68Gdy1NWDgq8hvEoHEcnOo/SKcEwiDQbJaROcfd0oSvKo4pxFLdXiVrfvXorrZjZBFJxw==;31:4tkmhHBiKE1XQE9KRW2Tb4uIcmbycnn1s++FmfSEQW1OUxO+aMJ0bGSHAw+dC3/Tp7UIf/3zo7siXl91/phQRpsdmAdm1blTFCwbINnN3XU3LWuXzSJzeOl3cK2H4/XT5D2TRYme8R/MnsxmhJad32r/I5yCE/4/WpxiepLK0n5ctNuJ8d5+p8s1HcItg6mGlc21lCK2LcHutgp9d8yj362sazqB0PEvFqRMHrnVIBU=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0168:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;20:J2Uily0hcFMec++2tvXqoyt+ON4vboKxEA1YNZ/aj8wFwOunLAMtX2Eu4mFfC2LsD2+XmAaMic4v3CXfCia3ms21I6O7RRO4E7H+K/5KduaKo6svGots2me9xH+V9ZPEJUHcdbNWTu5xtBfcoh/JajBzRn3aIMC7zEhg8I0n9jlY+i7htnmSjg7NhYVxEXH8hd+PSBBNjLvqBFQfqJ4gi7dEVabexg0sMzhee+1AOfWhWC2DxVx5QmhmQEFSiThe7ZKySBDSW6IkuBt8a+LC+mIIhoVS2zfL4YgCLy+y9n3zmM4heNlpX5gmCySsUJzJxI1ov+01O/7ZYf51bySnLCxBijz91E7Nb7nLUB28pKjVEJB/yTkY/f1SfHGM9M5tjlh1xmm1n7uBxl+kXKC8f1ReS4HovVIEtgWNX+TSNmopPme9jLHYqc/u0V2vs1iUrxXJZzDDuWZsS/drG0aBiNr4qxnHRlpWpSLrjsOeZhz2dbnNFpqKyp0mgzCGJuKl;4:reVy4dqNKc7E8x6lCUwDN4EQPdM6jz4KU1nYzOHhkQq6RSFMG1P3ni23LB844FWuRDFe/ZN4BWj92psJ3dTNSn9/fyKE6kgCIDLbbCixL4pJa9sGhqPqw2/zpcWHC28H+G288jtAeUmCUPqB3Zivi1s+8rOGJW8ENhGVB1y2rPLl87CKjxPhCig/jOpUZ3LeBIi9O8KoV9dggnbCS3LmDj6Yj2gVOw1gqtmLJb/Sm16i8rDPVUOwiAFTcoSw2dIg1EDnRROoRTUD4dcB5kc055wrUmYL+Bl10IKH+DEa9oID7Df2Ktz/85RUwMtPm3ph
X-Microsoft-Antispam-PRVS: <CY1PR12MB01681269FE2B5D90A01F8B14EC1A0@CY1PR12MB0168.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:CY1PR12MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0168;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(11346002)(66066001)(64126003)(47776003)(106356001)(3846002)(31686004)(6116002)(2616005)(65826007)(6666003)(956004)(4326008)(6246003)(476003)(230700001)(7736002)(229853002)(86362001)(110136005)(14444005)(486006)(386003)(6486002)(93886005)(31696002)(105586002)(478600001)(65956001)(8936002)(65806001)(72206003)(25786009)(53546011)(16576012)(76176011)(50466002)(81166006)(81156014)(2486003)(23676004)(52146003)(5660300001)(2906002)(52116002)(36756003)(446003)(7416002)(54906003)(68736007)(305945005)(186003)(58126008)(316002)(26005)(77096007)(16526019)(97736004)(53936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0168;H:[10.236.18.82];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY4OzIzOlQ2UkJjSTJ4V0haNVZkNW40b0x6Vm1qZ05C?=
 =?utf-8?B?dUJ4dHVtL2FaMGExYXVuSC85cFphRldla3RlOHJPM0NCWitLZjJ1bkhRS0lu?=
 =?utf-8?B?b3I3SURqMmxHZEFnYmcxNEozbWx6ZGREZHZNU0dqYzVmVXZjZUVTVWNYVzRO?=
 =?utf-8?B?T2hRSnB3bndoSStGeFBudWJOY3dOQnRkaFdENnIrWk5vcTVUOEFCZlE5SExB?=
 =?utf-8?B?UENRbTR2UmZHMjZjcVR2bVloWTlWVCt5ZW1TUDQxZU0xc2pwTk9xRDlZUnRT?=
 =?utf-8?B?c3p3Wm1qSkFZdGo0WFRUYnZZR3BLMzEweWdqcy9KYkRIOUVDVzJMbmJKWUtO?=
 =?utf-8?B?T0lqcjFnMkdOK2lYZ2cyaHNLUUtpSy9FOHdzaklpSWh4U295bHBNcjBNYXV1?=
 =?utf-8?B?TXJSTGhNL05Wcmc4Z1hDa2U2TWlCOEc4NWxFYmZXeTJsWnQvUDJ6U3VGdjlW?=
 =?utf-8?B?R214VEhDeXo4eWtPNzRFbXl3Z3ZlbmJSOTV0Y1V1b1N4ZnlmS0RTYVRUcjlj?=
 =?utf-8?B?bUVERGZOYWtTbW13RGFMTk9PaWE0VW1zQ3pHa3grYURnYzl5djdoU1JlTHgz?=
 =?utf-8?B?cnFpOVg3Y2loMGN2M244TzU2VWtqMUZOS0xZY1lLZkNPOU1XaHIwR3ZlTkpN?=
 =?utf-8?B?eFppWFlsWndmbU5WUVVIcXBzbm56VTdzZEE5eW1vS2RjSzdZSmdaRzg4OFR1?=
 =?utf-8?B?ZXpJZHZZemFqaEczTG5ZbzR5ZkdPOUhPNURVcUUwREQ0enJ6K2l3RFBLTlhu?=
 =?utf-8?B?YzdlQ1RFaVlmTnlRQWpmRjJDT25LMFZTTGZLd0lMSmdoSUIyaVpHVzNJeUx4?=
 =?utf-8?B?dmJVQXpGd202VUhqTWRyUUpQUW5MWHI2VGRMaFdJRHdaVTY1M3RKZTh1ZUQ1?=
 =?utf-8?B?eW1VVWo5ZnpJS2VlMVEwbjRxV3ZsU3RFOVRpNlUyK1B5TEd3eGRuY2hNaWlB?=
 =?utf-8?B?M1BFL09qSFV4aXJTM01VKy9GdU5jQkovMkpjb2tKU1FIRklmM25GT0JLcVJo?=
 =?utf-8?B?SjB5dUd2aWorSkxKaE1nOTAwaEsyY1ZObUszRHRDK0lmdk9YTWVOTkZ3VXVZ?=
 =?utf-8?B?WmRZS2YyQUw5V3I1a1o4OWU3ZHZwcGtPU0VpNGpoN1JsSk96MFdBQlhTeXlC?=
 =?utf-8?B?SDVLNEE5VHczQlpTSS9zZENoWEs2cVpHQTJRYWwxZXUvYzRYYUFKVkMrSHVT?=
 =?utf-8?B?NDN0UHBadW5yZUlUTkRLZXJIeE9MUkE1VjJWZGFhcnd5Z05nQ0w1VVorSzdp?=
 =?utf-8?B?NDArc3FvbmhKN0hwZlZ5MVpqclFJQ2NGcmlkK2FHck5uR0ViZElJSEIzM3VG?=
 =?utf-8?B?UndYWjhKOHNIMmJ5K3djdzdDSlJuL0Y1VnpsNHg5aDZmaDBSOUdUL3hncy8z?=
 =?utf-8?B?VDkrTU8vSVo5aVhJSXN4dFRqTWRnMjA5cFJpTmpYYU0xZDN2WFAzYkNCeFV2?=
 =?utf-8?B?OUZyM01jYXkyMlJoMlZma3lkMlk5Ti90ZWhEZlpqZGVTSTBGbDk5S0VtWUFX?=
 =?utf-8?B?SkMzYXdaV2lYN0hNcFJhZ0trNytraFVKNFNlR0VESWxHNjUzVnFVVmhHZWc0?=
 =?utf-8?B?STlHR3d5U0dqNlpDVUZFa3FLajNmOTY5L3FaVmhsZ3BEUUJLTktvU2lXZWN5?=
 =?utf-8?B?cTI3KzNUSmpyTmg5RWpGQmM0L2NCcVRQOVROYzdDYS8rSDVZcXhLejlkYVlO?=
 =?utf-8?B?U1R3Yy9TVC9tTWE5eGtvbmdNd0xkUEI1RnJWODFYL0VzTHc3VG40OE5LR1Zs?=
 =?utf-8?B?S0gyWU1oVHFXMDJkNHREZXJieUdoSXNxRFZnOFdJc0FZWVZJNE5pY2hjbGpJ?=
 =?utf-8?B?NTBDNFRuMXZLMU54dW84eXRBZ2VKRDU0cHFnL212d1J6S2liWlJScnhkWUdr?=
 =?utf-8?B?VTJ3V080REZ4OHZmdGtkQ3h4bHdOc2ViUXNHZDg3WGNrSmFSY25OU01DSCtZ?=
 =?utf-8?B?VU9Lc3JxUHRlek1aYjcvSWNOZ1FTZE80UlF4VUV2NEh5UGhFcmJzVmNMUzlH?=
 =?utf-8?B?dTRjWmlHNEYvSFFiaE9pZGxFRUR5ZXZmbUF1Z3J2M0JEWkJNOTZIcVA4bEdy?=
 =?utf-8?Q?XRf0=3D?=
X-Microsoft-Antispam-Message-Info: 1QIZYNH+0nb3Z8ZXoVHgExT1YRNzcweDQC7m7sGtxJ0y2PDLPOzW6T/SsyJoV23pcdw3Dq3jGFWPiLIlxQRPm9p0kMNRxn2tJ1CU6xfiDTBSwnABzRyLSJpwJX6SzrwNFHkoFqu5b+IV1Bu+Q6IkENawGTfKM1vbWlbqJyMP3fKDFAc0/QVEhLyxvyjZwuSPuCn4NYivSqQXM3O+LFuDguTIpAUfRnhI3ZtY2lTr86TZdF9L1UJI7Utzc4RhJ91zBbDiGHV2PT14vLQqnfT4RWY0qTt614jOHQq6g88hK9nDEqcOTSI3TSMahq//YDt85IThk4RNGyU2EOgU4O53wcfWLG45a7B5bTN4dbFNwdg=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;6:PeVP3ndRIewx1HRcgGNeEh7lRXMtPksZjSy7WRDSBLzMk/lFRYzFT6Xqw9NlI0gAJGa6nf7p/ooJwuUxJXiPfPNwkR3G+wu/Dx4etGzhLEukMzGgYkBxmx67/fguQ4KDSEmXjk172+v8ybDoF90Xzf/PciKIysJcDRobh2DVu25ZGxxYVegsYCnnpYNd1zANL9tlX725aUfby7Mrzi01XTxxP8E7H2N2sLZ8iVknX7M7GwyuBWM8wavNL8XMWzsQ/VPniDw0jNo7yYA3vfCYrsnnRladi7B2jN/B4ByCgoA1MnYPl8Q7e6KA99Kk/7yeymImouUYO3BSgW/I3Bby+m6mnSw3AQP4oVcdi+b+qEH08pp1afXS0tu1qlaqpcFu1sxs83866rrTHMKXvFTQEn7QdALzotOs1644rzceu89LXo2y/L8AhaOJxaxDdL8t5+VwlN4+gEhbRgzIpoi9WA==;5:VJsyatRx7tby0U1P1OzZB//ULAkVvcePA+dFuARE5F0bEX4xBXanUMflXkkI4QCAN/1DBiE0iznpjOzLfjnflnBsIjfqTEu04HBeUKp9n2a2lzSGdvPiCwp9WVxTGinu7k39/lNDyAbo+EhB4Y9JTWoZbTJC5HylfpHN2PN8f7I=;7:MTe3enZX9FUCifP68CJLSDBo+2SH6INtg3zqY/Pqq1XTtETZLFBZnXbWkT2n1BWPCCdjDUCeA+bJJojZuBjsPyfI8Ejiolgbhptats8v6fZk04+23ettFyR/tn9Hk8AJn+1fihCR3dBygya5AnXzSgQDD6Q9nF//hDICvWLbDB3QC5v9cLzB0+UGmrcGW6qA2JGWH9q1/oReieL0cZUd9oVjWo3t8gMQv+iIKiMdAYtffEx1kc09zXBKFunR2129
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0168;20:ZRjlgbUUBId/gO3pqAxH7qlf8goLUeEXvi5g1G4o4yvfx9Oj5gc0VDI2BeGfhdSi0aB2XmOQ93IrAZbv7tiB+bBOF7BlggMzGQbMiQSsgkiSOTRj3deDX3BsB63TWch7sXhEwDZzKYhqaGvP4tHPD9ijUvqwR/jlOXMmAxFyUCWj3P7HrjS8w3wE4mGKdWzBL1zh4O0yzGNilTYcGYgmO7oJpA7dxTXZnmgT3h60hEkyOWfLXbR9bpaHOYb9stJK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 14:53:21.3688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef9a25d-f5fa-4b5b-bbf7-08d61988a72b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 04:26 PM, Tim Chen wrote:
> On 09/12/2018 10:16 AM, Tom Lendacky wrote:
>>
>>
>> On 09/11/2018 04:16 PM, Thomas Gleixner wrote:
>>> On Tue, 11 Sep 2018, Tim Chen wrote:
>>>> On 09/10/2018 04:46 AM, Jiri Kosina wrote:
>>>>> Nah, IBPB is actuall there, sorry. So I'll add reporting of STIBP + fixup 
>>>>> the missing reporting of RSB_CTXSW for v6.
>>>>>
>>>>
>>>> I anticipate that STIBP could affect workloads with a lot of indirect
>>>> branches (see previous discussion with Andrea).  We should have a 
>>>> knob for people to opt in or opt out of STIBP.
>>>
>>> Feel free to send a patch to that effect.
>>
>> Tim, are you planning on sending a patch for this?  If so, what type of
>> opt in/out are you thinking about, something similar to SSBD?
>>
> 
> I'm working on a patch for choosing the Spectre v2 app to app
> mitigation option.
> 
> Something like the following:
> 
> enum spectre_v2_app2app_mitigation {
>         SPECTRE_V2_APP2APP_NONE,
>         SPECTRE_V2_APP2APP_LITE,
>         SPECTRE_V2_APP2APP_IBPB,
>         SPECTRE_V2_APP2APP_STIBP,
>         SPECTRE_V2_APP2APP_STRICT,
> };
> 
> static const char *spectre_v2_app2app_strings[] = {
>         [SPECTRE_V2_APP2APP_NONE]               = "App-App Vulnerable",
>         [SPECTRE_V2_APP2APP_LITE]               = "App-App Mitigation: Protect only non-dumpable process",
>         [SPECTRE_V2_APP2APP_IBPB]               = "App-App Mitigation: Protect app against attack from same cpu",
>         [SPECTRE_V2_APP2APP_STIBP]              = "App-App Mitigation: Protect app against attack from sibling cpu",
>         [SPECTRE_V2_APP2APP_STRICT]             = "App-App Mitigation: Full app to app attack protection",
> };
> 
> So the APP2APP_LITE protection's intention is to turn on STIBP and IBPB for non-dumpable
> process.  But in my first version I may limit it to IBPB as choosing
> STIBP based on process characteristics will require some frobbing of
> the flags as what we've done in SSBD.  That will require more careful
> work and tests.
> 
> The STRICT option will turn STIBP on always and IBPB always on
> non-ptraceable context switches.
> 
> Is this something reasonable?
> 
> Tom, if you already have a patch, feel free to post.

No, I don't have anything.  I just like the idea of opt in/out for STIBP
and thought it should be similar to SSBD to provide consistency.

Thanks,
Tom

> 
> Tim
> 
