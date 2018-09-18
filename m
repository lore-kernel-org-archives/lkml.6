Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94FCECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCED2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h5Igj7iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCED2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbeIRRcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:32:48 -0400
Received: from mail-by2nam03on0051.outbound.protection.outlook.com ([104.47.42.51]:13977
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbeIRRcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZmvafujCntCptOMF/q/m9IGK4jeWKq7HZl5Ox5O7oo=;
 b=h5Igj7iOpa4R3UUwnN8LGL1V3s/BmoeQlhqNjB+LjU7ies9HQQ+IAZxEUq0us8OuMsL1R8HbFz7+WDYAsD7sG0Vf290JAPmnQqFaDkOAmsdFozR1eQyjFwQ4nyWdLcxr6XS2A4B6955kTyqViHUSYG5JUPSkU0NaiYzQgrbHmZQ=
Received: from BYAPR02CA0039.namprd02.prod.outlook.com (2603:10b6:a03:54::16)
 by BN7PR02MB5108.namprd02.prod.outlook.com (2603:10b6:408:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Tue, 18 Sep
 2018 11:57:26 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BYAPR02CA0039.outlook.office365.com
 (2603:10b6:a03:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Tue, 18 Sep 2018 11:57:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Tue, 18 Sep 2018 11:57:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g2EdA-0006qt-Oy; Tue, 18 Sep 2018 04:57:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g2Ed5-0003PV-L1; Tue, 18 Sep 2018 04:57:19 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8IBvIo4000906;
        Tue, 18 Sep 2018 04:57:18 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g2Ed4-0003P9-Bs; Tue, 18 Sep 2018 04:57:18 -0700
Subject: Re: [PATCH 1/2] of: base: Introduce of_alias_check_id() to check
 alias IDs
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
 <CAL_Jsq+yzot-NUEYGKW7jQFkFdi3O75j-3fTB0VZ_o+13J6pTA@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <553cff97-4c7b-2160-fe93-8ed19773d684@xilinx.com>
Date:   Tue, 18 Sep 2018 13:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+yzot-NUEYGKW7jQFkFdi3O75j-3fTB0VZ_o+13J6pTA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(199004)(189003)(478600001)(356003)(39060400002)(8936002)(316002)(476003)(126002)(6306002)(305945005)(486006)(106002)(58126008)(64126003)(81156014)(81166006)(14444005)(6246003)(229853002)(77096007)(23676004)(186003)(54906003)(47776003)(36756003)(26005)(53546011)(65806001)(44832011)(2486003)(8676002)(4326008)(65956001)(426003)(9786002)(65826007)(63266004)(5660300001)(11346002)(76176011)(966005)(336012)(110136005)(2906002)(36386004)(230700001)(31686004)(106466001)(50466002)(31696002)(2616005)(446003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5108;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT041;1:ALfHEqT3RkusSxqLkoP8XucAeQz8o09+SqVqJqOIQwBM7E0yLIh4ElnDYxHNYl4oBpp264w7tU79/mAQD83a1c4U1YCvmYFAhxt2thEyx8fJ9ATOysuXkuUdh5ls4HRh
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe32506-3c73-4d84-1a36-08d61d5de686
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5108;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5108;3:9VGLY8DQvrKXiNQNbXP89aG28EIS8djc85q1q/4c5dI7h3l71778PrdJiQ8lEXx891M3VAY2+A/Oz+81S0tr07r7or0QYQeM/Hzs9BrE1tTkSW0gJo6WZlhjhuNKf7SDuTiCUkC4pwVU48Bi9I+scqqGj6jRFePSvghpobvJBAfsCgkyAIwEDf8WFqupUQHy1Wcw5AT9W8X24bBQdfvzXQLns0F95Bi3pY0g/YHypPQvtOjHZWwjLRiaITwBPw3wEH9yXKNkRDKZc1M7VHUilb1NvFskqVFUVjeJ7vckXi0yszGEwcpcbo3S2jF7j+khjAcQZ1iljqeHdIxd3YCcBoSQIudp17BDaCM4voiCzhs=;25:79ygCx1Luc3ml0qNvFLETWxoPLigo0A2ah4+cy8tuSqmHPQoLE27GgG/ZCnowacyGXDFNV9Os/VupB/UdBRJlf7+wVJhKVw9qWcAa/hYGm1IkEqyao74IYWjiZW3a34axJVDXGHmy2zIDcMJ+cpxcem7zryM6U5Ph+9seLoO7K2NFh4ZThsMAXndC22m3IQBxKzy9xFcWx4JgbFrgrodKXrUftxd8OVdmaemhWlV6wq+s9X2bOPv+P/TZM0MANdmzz3lKaMoYtnF0ow3/YGSpIy2YrST0SUmXln+xo7eWW5MVquoagOUkKXu778phETzrUXIKyeLqGMPDI6x8WUlBg==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5108:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5108;31:1j2/ekbgf7BX6kQOZjOjvEtD3c6RCUl1NJmlFI4RVigT6fuZFtc5OB3i3u82vBFURy9pP+lM8SOGb7Tt9Li304WA4C1sPdiUL1VsiUYxbmsUW+AbNlIAMahn9fig9Ajl2gSOW2Q0/mAuuRZ1sh6ShD70LdCuoQKEsW3qhSzwPSNmEHcpx+XQgMDXALywyNZVsB48WVLTjZ7GER1A5wJ6fFMFm+g/BhsxHUD16uQEv/4=;20:c6+LYg+bY4QwJe75OOODlHDhFZfa42MdbckqgTwMrCRbbME2JXazIAmVtchFb4//La1rRTYFPKJohITPPiO81/phkYbOPMApNZjzKd785vbqmmDA4AtpKCSVoogsSFU3/saa9snUfDDYTX5Bm5iG8zWzRtwTOhyqnxbZ21mFh8bU7znC/iRJIinMynd97c7Lfd+BQr/rSD7PHU7zQBwoNT15A/Mbt2ed5VadRi76Tv+BWXmNYrBnUS/pDpAuxl+fQMlD01dKw9EJZtiLFlpm9eu1GQvCa8Fy8c/37BxC3I/e6oMY2mPvmAfdWRWcHngdw7kn9Gnpv9fbSjOyITmv7MWUgI/YVMUwPcy/32TXzojQWVb1midydvsc8oShvdkTQ/GsbGm7oomLHkf2VYl3ms+ZJghOdAWckVHyls5HeEKfAz+AaGqTtbCZ+ASX7R4OsUbBpP9o2fbc2KcKKH/7U0Sp0nDu/g8HccSHglvPRNZN+ezSAcvR63slebRgQE0f
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB51083AD3CC9E6D9313BCDA81C61D0@BN7PR02MB5108.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:BN7PR02MB5108;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5108;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5108;4:jbrV5ml3nFuEdIZs9nC1p4CtuyYJYoqOYYj1kn4QazbEE48JvH3ec/UWsJ+n9bmzIAlBLzw9bR0qgGskgI3VBOrWyBV0w6Wnlp7ZCMR0zGPpqdF5SdII5sJIeiJ/wf10p5HXI7HXJXAyvUzgMzNOg06YxghJvGzkxN5Pb9J01uk4yVfypN+V8Sqxpbc2SpVgYk2Uk3i/hfsYLS2NhrryZszYGTAE810roHA1ZRyJsl809GFiTX1ZPm8rS5JQ2uHtpSBJA5xnuTgGz1sxEf3APYFnRSMlHIS29C8z9ldEQoYUHHvq+c5ZQJMqpcGSTJP1
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjAyTUI1MTA4OzIzOnlTcVNrUHd1Nzd0MlMwT3lZRWtUOVlHc2xq?=
 =?utf-8?B?dkpuRlY5QVBYYXU5TXNpWlppVXliSHRqcHV6RldpcXJ3bXhPN0JUU21WanBh?=
 =?utf-8?B?QlNzcVZTc2luVHp0c0pWT0lZK2JwZzFXUXN4Y01yOVJkUHloOFQrSFd0OFBU?=
 =?utf-8?B?WkRlYzVueU4wQmFSc0UxcEdUV1lxakdhVkpSLzdyOWZZVDIwWjFhNlA5Z2R2?=
 =?utf-8?B?bC9SZUQ0WUN0bVZBUmdwNFd1U29MUEdraEd3cU5KbHJoR0oxRWRtK1JYQU43?=
 =?utf-8?B?c3R3Vy9HSks1Q2FCUm1TNDFRYjBMMWdFeXNxdUx3d2E5cCsrbmRMSXlBcGtY?=
 =?utf-8?B?cU02SXMxVmtvc1VzVnhheHZuZDg5N016bFdnNlpPZURMS1dPYzA5bG92dEE5?=
 =?utf-8?B?YzdiY0ZwUFZyUktYYUlvTkpGVWNNaGpkU2YxSWRRVFRwYllLc1hlMjJJbng0?=
 =?utf-8?B?SktzZ2VsNzVMZkpGRmhPSmpIWmZRNUcxWjZPYXRUY0FCREhwRXN3SWI4ZzdW?=
 =?utf-8?B?eDc5M2xCTzhhbXBTQ2dKcVQwZUZWU0VRT0dLelBBZytDaWE3ZGRONHZYVFZq?=
 =?utf-8?B?UmZNQmZIVUJiaVRacndwczQ5bHdTK3p3RWJrME8vNnJFakNXNHMzb0dDbWtH?=
 =?utf-8?B?QnJ6dDZOSUhGWnY0UmZzdnJuZkZMZmU3NjEvYmxjM3Fpem4yUkpldTAzbjhF?=
 =?utf-8?B?OUtDOGFvMVQwVkdiRDZmSVlzazFueWUwamd2K0tPMU1jeVMwbkg5dlYyQWZK?=
 =?utf-8?B?TjZkb0RrK1AzTmxvTkJyVnIxd1ZZWmNDaElmTUZHSTcvS01sOFJhM2VqcTdJ?=
 =?utf-8?B?ckVVL3ZCUElvMUQ5ZGoxMXdhTVo4RWpaZWoyOUtSWlVxMmp6c2pjeGdPMzh5?=
 =?utf-8?B?cUJORWdBaEpMOWxnZWpzZk5oSnluZW5QcVVGRzkrcFdyc2xRbkE5UFUveHlJ?=
 =?utf-8?B?bEFaSHBvRWRjUVl5ZmdORHk4dFh5dXZla1BtdktWbXZqTGs3Rm4vWlAyWjhG?=
 =?utf-8?B?T0FLZkdOSTBxRXFQTUkxekFNc0dMRTA4dkJhMy8vN0RzaXU2RzhTM2gvd3NM?=
 =?utf-8?B?aHVheVJpb25oYWRrT1o2amx6Wnl6NzJac3VUQmo2K0kzSDVnSzM2UjdldU53?=
 =?utf-8?B?QkpsRVdUYlRGd0tzUytIY1ZBSWFLZ3lqQ3Z1NHAvVzR3aGdkK1hldW9EZFdS?=
 =?utf-8?B?WEN4ZkZIOWFCTmo2OUwybExxWEQ1c2I2L3lma0NJRkpxL3Zvenh3YlhoVEhD?=
 =?utf-8?B?TEFKYTZmRk8zRWV4bWVYVHRiWE9iNmFRZjJtQ1RaZ3RsUFBUTHRPOUk3V3Bl?=
 =?utf-8?B?Q3VKNGo2M1RaTkwzekpldzh0dW5JNmY3MVRYTTlOc3hUMzdoK2NKclMxbjRL?=
 =?utf-8?B?RW5FdTgydFRKeGRNS2c0R2R2cFZjaXZEQXE3TWlSNUdaN2thMVkrR3NhY1NC?=
 =?utf-8?B?amZlMjJtZXY1RzQrT2MwM2RLTVA2ZTFaR0VuVGtwRHVlMDI2bVJ3ME51ODBT?=
 =?utf-8?B?YmlVcVB1blZnVWUrUkhJUGkwc3ZETStZbGpEV0xKalVLMDMxMlpnQ1c1SVhj?=
 =?utf-8?B?K2lObzJ4UkVsL3hsWlZveXA4MHhRNHZPYlhBcHlyb25yRmNyT2RneDdESTFN?=
 =?utf-8?B?T2oza0R5Q2FXcWhYZ3MxNnAzVS9PVWpweStjT3VCb3MraHd4VEdaTzM0bDFM?=
 =?utf-8?B?UVhXUFJoYWlHMTloMjNNbkZxd0xSYzB5YnRQOFVtRmZFN3dNZGpYVVBFd2Uw?=
 =?utf-8?B?RnNsZlc5a00wQWZqTlN5eWExVWEybk8xT21XbWg2NEJTMFc1TVZZK3VMUDNE?=
 =?utf-8?Q?xlJCG3IZN9fjH?=
X-Microsoft-Antispam-Message-Info: b4IC3dmCFDXMt2z6JNTuLZ+4HeNxWx7TGUEZ7llW3NucFQO6mrlI7c3sXiAtFbqPx/XA2V7h+mRPQHXYbIuR/Uv/Ojrx7PpStoduhy8q7JXQKK8sYXsz25YPcsByCuXw+1f9XiMlnq8K+ttHrbGia7aEE7Zo09Tfm0fxu3XAaUxbA0VAkGswmtEf0K5xnPnOQ8RCCY+JvMtmQuPk+pLspoWC2AzAXK22cPqglcedXo9mww0QMSjWF/l6R2lJVavtQ81/UVPJrnrkXmWwCAQBoZ+XWafoRoZiLYH7OpbkRHPjc3CgnuZLD/sADYofpBgjFudPkNT56FeEq9kKARHIkZXOyE2qivCvXlL8hkynmPU=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5108;6:g6VdOMzEM7I71EI3TRKBoEjYFNirHWlHbQ43L5RCz3UhE1KqIROJgkuZBLbHoRB0dt1gtXs1Pv+2xy00Jks2dgyTkONL7gs1fWxLy4BlfI/aN/Z4YaYL5Tuu4OLVsYIquEZ2YUr7zW+QTIRYHRUVVScDQOaA2J2c2iKHKPU1HSqvCh57SclboqOrU2IAOLeR5xRnmghmGlmAcUjyru/mIVEJh4bDh8A0t+fj0pFRLJ+SeQRENQEqvIjxtH0a9EDJjAslUluwf8bNtOvXr5ORyARlztIWP2ikYrHpp/bZpdjqxnA3RiAfZ1nfLdfvnLDu8nYpwPkr1VmHWSeyIR0U+DVJAwPq+bwsOi7B21Q6RV1KzSfBqqaJ3t2Qni7fwFV2+0LJ8edYgei7sZgizwLDuj7KSJ+d7gfa9HfFnrTpoTtSRQXzOgtx5FHwFMuvIuNe5v6sdJdKk0651oxVDNVJqQ==;5:tk4U/RzRnfvAKmDUUtdh9A3ebstz39yf2Yd55P7Mzst2IyxsCk4tpps1afPADXyhAeuY737hWsUCd7VRjxVtT6Ea6+M5DDozF0SMordHrSQ2O1WBQdB0w+e9+vTuNe0XDFi29hRLHPWWwWHkQl2mYKEDWFeHpBE0TEeohWDNUng=;7:fZ01Y80gvIrKJ/rsW2yAPeEEBP215ALnymfrua17yW13/9HVRTNcp0MzkYcmoItZtK+aIBUiqf/+6WjO6o9YNCEXWr9aELXRi0DiMlWaH96p1TDmn5L92IiyBPe5xjErh7uf8siM6taVqXFALHaAhvmXkdLHegOuNpoIaaOVEk65zAg/eI8RpSuCCxAyAyXgfftVhdMTGVlCK8a085qfd/So88QShB3x6FGTmdXy8tKkajesq8eDE3rT6J5E82g4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 11:57:25.2466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe32506-3c73-4d84-1a36-08d61d5de686
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.9.2018 20:53, Rob Herring wrote:
> On Mon, Sep 3, 2018 at 8:14 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> The function travers the lookup table to check if the request alias
>> id is compatible with the device driver match structure.
>> This function will be used by serial drivers to check if requested alias
>> is allocated or free to use.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Based on discussion with Rob
>> https://lkml.org/lkml/2018/4/27/397
>> nbits is passed to the function not to limit only to 32/64bit fields.
>>
>> ---
>>  drivers/of/base.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of.h |  3 +++
>>  2 files changed, 51 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 466e3c8582f0..236a85d69957 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -16,6 +16,7 @@
>>
>>  #define pr_fmt(fmt)    "OF: " fmt
>>
>> +#include <linux/bitmap.h>
>>  #include <linux/console.h>
>>  #include <linux/ctype.h>
>>  #include <linux/cpu.h>
>> @@ -1893,6 +1894,53 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>>
>>  /**
>> + * of_alias_get_alias_list - Get alias list for the given device driver
>> + * @matches:   Array of OF device match structures to search in
>> + * @stem:      Alias stem of the given device_node
>> + * @bitmap:    Bitmap field pointer
>> + * @nbits:     Maximum number of alias ID which can be recorded it bitmap
>> + *
>> + * The function travels the lookup table to record alias ids for the given
>> + * device match structures and alias stem.
>> + */
>> +void of_alias_get_alias_list(const struct of_device_id *matches,
>> +                            const char *stem, unsigned long *bitmap,
>> +                            unsigned int nbits)
>> +{
>> +       struct alias_prop *app;
>> +
>> +       /* Zero bitmap field to make sure that all the time it is clean */
>> +       bitmap_zero(bitmap, nbits);
>> +
>> +       mutex_lock(&of_mutex);
>> +       pr_debug("%s: Looking for stem: %s\n", __func__, stem);
>> +       list_for_each_entry(app, &aliases_lookup, link) {
>> +               pr_debug("%s: stem: %s, id: %d\n",
>> +                        __func__, app->stem, app->id);
>> +
>> +               if (strcmp(app->stem, stem) != 0) {
>> +                       pr_debug("%s: stem comparison doesn't passed %s\n",
>> +                                __func__, app->stem);
>> +                       continue;
>> +               }
>> +
>> +               if (app->id >= nbits) {
>> +                       pr_debug("%s: ID %d greater then bitmap field %d\n",
>> +                               __func__, app->id, nbits);
>> +                       continue;
>> +               }
>> +
>> +               if (of_match_node(matches, app->np)) {
>> +                       pr_debug("%s: Allocated ID %d\n", __func__, app->id);
>> +                       set_bit(app->id, bitmap);
>> +               }
>> +               /* Alias exist but it not compatible with matches */
>> +       }
>> +       mutex_unlock(&of_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(of_alias_get_alias_list);
>> +
>> +/**
>>   * of_alias_get_highest_id - Get highest alias id for the given stem
>>   * @stem:      Alias stem to be examined
>>   *
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 4d25e4f952d9..e474710e3930 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -387,6 +387,9 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
>>  extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
>>  extern int of_alias_get_id(struct device_node *np, const char *stem);
>>  extern int of_alias_get_highest_id(const char *stem);
>> +extern void of_alias_get_alias_list(const struct of_device_id *matches,
>> +                                   const char *stem, unsigned long *bitmap,
>> +                                   unsigned int nbits);
> 
> You should go ahead and add an empty function too as the other 2 alias
> functions have one.

ok. I have added that function. Also I realized that this function
should return return value to let users know if this function is not
returning proper values. I have updated this in v2.

> 
> With that, I'm assuming this is going with your serial patches:

yes that will be the best because serial driver is only one user.

> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Added to v2. If you don't agree with also adding return value please let
me know.

Thanks,
Michal
