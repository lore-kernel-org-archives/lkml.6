Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D40AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45402146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GCB2DSzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45402146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeHBJxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:53:09 -0400
Received: from mail-he1eur01on0115.outbound.protection.outlook.com ([104.47.0.115]:31824
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbeHBJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIw906ph0bI5s0nDS6RhBXdJmz6EIy/+JD+n7yyyfvU=;
 b=GCB2DSzwL2z+ULrOUaHAga/vMsBOAsdi2k6z8J/DTHHVxxkn+gYYHtR/9xhaE8dBPykDllo36cIPNf9lTLJ71lE/aSg9W9byFWuWhZJhYubRavuLdyak8GCkEH2D1H7SwYG2GG4BdWPrMtGCVkqoHCSWyBj4YEiqzke2Vo9O54E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2022.eurprd08.prod.outlook.com (2603:10a6:4:76::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 08:03:05 +0000
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
To:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180413115454.GL17484@dhcp22.suse.cz>
 <abfd4903-c455-fac2-7ed6-73707cda64d1@virtuozzo.com>
 <20180413121433.GM17484@dhcp22.suse.cz>
 <20180413125101.GO17484@dhcp22.suse.cz>
 <20180726162512.6056b5d7c1d2a5fbff6ce214@linux-foundation.org>
 <20180727193134.GA10996@cmpxchg.org>
 <20180729192621.py4znecoinw5mqcp@esperanza>
 <20180730153113.GB4567@cmpxchg.org>
 <20180731163908.603d7a27c6534341e1afa724@linux-foundation.org>
 <20180801155552.GA8600@cmpxchg.org>
 <20180801162235.j3v7xipyw5afnj4x@esperanza>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <7a836e47-f0a4-6802-9b90-cc473e5ab90b@virtuozzo.com>
Date:   Thu, 2 Aug 2018 11:03:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801162235.j3v7xipyw5afnj4x@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0102.eurprd07.prod.outlook.com
 (2603:10a6:207:7::12) To DB6PR0801MB2022.eurprd08.prod.outlook.com
 (2603:10a6:4:76::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b19448f-a777-4f8c-7cd4-08d5f84e60ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2022;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;3:hrAmZ2j/pTXWDy3Ak+SKChuJBIdgdfDgzg/w0pZIdyyK70p688mXkqRzkOOW7dB1IEI+FnwI6jtUrYf9R21+PxWGb4FSGRg++rKIRp/7161ZCzmAOTPPTs1I8a6z5w3WOg2gk26nu3XXKvjbjJIgFQbQHCKy66eaGBV0cXgMm9HqjVlaFMyZ6n7+SrsS4/a8EFFhAwivjocvlpKs9ungfvDdiTXkufcmnJWf4APY8A7Sff/u/PkRNp/8lbuhq4/n;25:9gN6RGNXwMgxPo922IvvUU/ss4fIng0ZjI0vPKQEN9mIN8MD46ZBuFeYMEdwGbMqhpLFwFx4413Sy3D1zvds0RUYfWMZOS353goZ1bFvpib7/qL6KGn+vst13NhOupyWAHt5PsXZdKbHdrKU67fv5GeD+SITKlXxYl5fkHssWF/05nau4k1bxnQNRFvtth6p2QHL0lAKcku44N/rDXWFb6S9d6dustc+WWElwpjROj4jMYtc+gDQboGW4uVNh1dVbgtbZZkBhaBZUD3Omd4gdCIoPk2J5VlbIE++q5OsnT4ORDFmko5frj81pD+N+jv/A8y1XHrW5kmEZAVosMWmyw==;31:ja5rNIhsxtrSSDL1fxmGPOHSNw6+jFnqLYg8c+NzPuRaezUHhTJOCW4ZYkylnFdN4jLLGOYIDErRGPuW8GpE1BNuVbdHDrEI9AN+5V322ZCMVAb/LPKJOYA6HENw70sYsj7buTNTx0Av/4dhu2Z+ewnqVJ8HGuOSvyb1q60uAqgRfI4nW9nRuSY+U81l7RFK3OBTarCLKWmAv0JyB/h//nT5ePMcxynBydsQK4j+muk=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2022:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;20:34/w4dWYaf2/uBaig54n8xzVUYwVspP0wjW/uyBdiZLcfvfbYE7+8baqz/zD5yKeNS3h4wJIaxZsl7nQZAUHIhuDBJHtc77FPUqzdsoB9mMhahZv+wI6S6ZFb6Hdx2kZdsXDB1zsO4wbQorLXnVR+AK2htfai9P8CF7SdywCHWiNHNK2lzd4K9yU01T76tIwMSJ7UDezRNeuqz4sWAbeRGyrBzy4rlq/egaRteYM7cVLkqMfV1X5rLnzIj4Pv6Du0Orqlc8XDHlA2SPipvCfIyidIPyWv2tunKXoFeekvdtmbg9ThmoC394WdK1q14A1ieVh+fMRREM3Kt8/olNpvGWkD5lTLCx2+q5x3WEHdm4t1+v3GQ+fLh8d6OqxjH7LzCkyJY70ysJ4dwpRoIXiHoAOiAZoboH7kKeAXBIPBsb0zChkvoASjl7Hi5wJVKj1h6I0D+QrW8BCW5B1eUTa5jtS6FhjQ1sup8HkVGI27Vhl/VwkmvA1L2tWDllmCuWL;4:AwcjRefjmdGXf+42imsSiwHX5/g8a/kJQN9c1RBsiHuVvQ7ojAKfEAAs2dcL46oxr6dorT+Lqsi6rH5nl0Iclir9khNaAjsr4bfYvZ53dhnPh+a90uGDJ8rm5i2bhLTb/FdcIOEAQ21mWj510ntklPNordaGgYX9uDJuEx+LreXiiNv1s65NXuhInlR5XLhNwlEvz2T+7nXqHSJbVKjc9V/FHK6DTXcVuUyNpsxuVFUaSYN4eBd8FOsS8wtb+v7sfPBPpzVOQw7YWk4lDa6GtcxC72xE69Of1myXZuGk6rbo+LLYhN79xZRxnID645F9
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2022FC4C180834D70F75A13ECD2C0@DB6PR0801MB2022.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2022;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2022;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39840400004)(346002)(366004)(136003)(376002)(199004)(189003)(2616005)(486006)(16576012)(11346002)(39060400002)(50466002)(58126008)(68736007)(2486003)(316002)(23676004)(110136005)(52146003)(54906003)(36756003)(25786009)(186003)(16526019)(446003)(6666003)(8936002)(5660300001)(76176011)(52116002)(26005)(77096007)(97736004)(53546011)(64126003)(386003)(6246003)(86362001)(476003)(81156014)(81166006)(53936002)(14444005)(8676002)(956004)(4326008)(105586002)(2906002)(230700001)(305945005)(31686004)(47776003)(229853002)(6116002)(3846002)(6486002)(106356001)(31696002)(65956001)(66066001)(478600001)(65806001)(65826007)(93886005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2022;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjI7MjM6Q29rUzBTaXJZVUhPcnRvcExFeW1xUW1k?=
 =?utf-8?B?TUV5K2xXRE1ac0lNMXRYU2oweEE3NXFUR0syRUZ5MnZvQnVURVhEM2svOVJx?=
 =?utf-8?B?WlBLQW45TW5FZGxTM1hpQXJlS0tYQ1Nvc2ZaaG9sWGkrUFdWVldzMGYvSFBp?=
 =?utf-8?B?ZWFoZTlkL2k1ZHZENmc1VVpyUjZyVEtYVmpESHNaUnhXaENRWnZBSFpyL3FN?=
 =?utf-8?B?WXdGWTcxakF0RVV1MXBlWUE2YXZ5RHk5TFBQQXpuZmxHUEVMdktMNStMeTFV?=
 =?utf-8?B?alBzbUhXZjdtK0RoQlh4ZUc5akxPTHc0Y3U1VXBzdFpSOVVJYkM4S0lZTUow?=
 =?utf-8?B?NElsdml2d0kyd3NjbVdpUkw4UDBVQVR4ZUUvcis1dmNPNTVFVWl3aVBGOEt6?=
 =?utf-8?B?NDBHMWdxWXc3SnBhTU1QL1gyaVltaUNEZmpzbnpkQXJiOS9abllzMENCV2Qx?=
 =?utf-8?B?ODhtalc4MWxkb01YdllCWUZha1VWMU5WM1ltYXN3dC9oYmtTMzN4bjQwR3NW?=
 =?utf-8?B?c1N2MWRiTUM1UFdFUENQcHZ1QytjUjlrNmxBT0hVSG4yTEpNNERMZFM1Z0gv?=
 =?utf-8?B?SGc1YUNLRnJQTlpDRHVKOEQ1TjMxRGVicXhTLzEyN0k5MmN4cFoyUXpmWUhT?=
 =?utf-8?B?aXJKc2F5ZTczckhoVEt3OGh1S3JqRWhBZFZjZlhORnZmSmVpREd4bWRHdWVJ?=
 =?utf-8?B?cEhnRkdXbk01SlFaTVpPd2JGTlhURkE2eWo2UXZrbjVIRUsxRnYwNytEa21u?=
 =?utf-8?B?ZFlSYUEzZlN4ZzVVa2RReTBrZXMybG5hVDBPdVk3UklpY0RzZXN0OFVSUzhh?=
 =?utf-8?B?Zk5mdXlnNjg3NlJpODhtWktmSWdWa3pRVzJhZ2xyOC9Nek5WYzg1aDNtNDA4?=
 =?utf-8?B?d3kwK0xEdVBLVFA0NHZEdlJaVEZGbXNXbUJWcksxVVBnTExZTDBFZGY0OFpv?=
 =?utf-8?B?TXM0Wk1ueTBMUm13YnM5cE9MQ09Qc1IxWm9SL1BoL1pEUE1Zd1paT1BNNHdi?=
 =?utf-8?B?cEVYckExY0pqbzFmYzcyUDAzOUJsSHpMM2c1RnJ0TWQ2bW00L0RNUlFpNnRT?=
 =?utf-8?B?ZkZwcWVwOHArSC94NkhydTduUXF2anVFRlhhWTJpK082d1U3LzZmQ1UwL0NV?=
 =?utf-8?B?REF3eG0zTXR4WlV1TTNieXNpMmNadWViWmtBalhFMERUTlp4QmtxSUxrQmpa?=
 =?utf-8?B?U3IwL1Y1ZTA4aHNsYVpJak5yMCtxWmNYRUsxeE14WkxiL0hJbjRYb1o2T2xm?=
 =?utf-8?B?Ykc5OXRvd2I2LzU2YytwV2hNZmxPREszeWltU1NFN1V5eml1MFJlQ1VvMFZy?=
 =?utf-8?B?dlJYSXV3VzBFV3hybDY3WGR3L2M5ZjZoZkdSWmFVWE9FUEpFaFNzdXdVK2x4?=
 =?utf-8?B?UFlNWWpGSXVIN2cyck1Hbk9JWXpNN0J6YWdKeU9OZ0N3YkxCbVR3ZVMwVEVL?=
 =?utf-8?B?c01QUVE5d1pUVW1BZWloUnZ6YktqRmpEbU1MWllrZ3VsMXVtaTIvK2hUY1dt?=
 =?utf-8?B?c1ZRclFtSHg1RFBNQUZockcvNHUxVUZiMDdDbS9yVWpHQ2pFSGJvZkRkeUVN?=
 =?utf-8?B?NG9mRERROExGcm1LRnlma2IxdVFoWURnaW5VdjViUnVwOEtoL1VRaXg3NDc0?=
 =?utf-8?B?UFdCNEgyWkJVbmhteGRqY0EvNDFjVUx1Zk5XUTZDNzE1TmVZRVF4S3FpTGdQ?=
 =?utf-8?B?STMrVzFWbDc5eTMvSGpyaWhwRTE4Ry8rK3dqRFFZNm13dFFYb1pHaUx2MlNy?=
 =?utf-8?B?dk1NYVFlQk55SzdRTzUxdmhUNXE0L2NRZjFPTUtUQ2ZWZHI2eGh0eTk2eHlT?=
 =?utf-8?B?OC9UM0wvcnMwRXJjQUtjT0dqeHNrRnRhRkx4ZlFqOEoyYk5xcVQ0cWxzb1l0?=
 =?utf-8?B?bVVqTzU2bVdidGlBUEtrYWFmS0NWbHJNVTN5cDF0bGtoSHhzSC9iZlJIUzJH?=
 =?utf-8?B?TGppd0hLNnFRb1JJMU55NkdPRFUwRk94Q0FZY2VSNi9hZUxpdGJxdzZ3UHlE?=
 =?utf-8?B?MEkwWEVnWUlja2MzaEdORy9jYzZxT2VZYmRxMUpBPT0=?=
X-Microsoft-Antispam-Message-Info: jPH5hqJW7lrh4rxQUrLw8SvZQjQ4A9pyhplCt9cyvBiQVt5bgvpr1A5mnRyb+en3W8rE540j+R1SpxAJv1yi9hgbThMJj9V6xxVPP+OwuNsWSN8cEX9O/Nki3Dl1xFbD6ee03VDg5gDQ0TpQ7LuE1TCLM56TE/zyefyqTJraJ312vJsro4I9pRfq7PrFQ+9qZt/aGnn4EQu1mSMv9Pdm3E9CFWR8qfP7NaAxz43dXRKFQyj48DIb56gxk7xmNDod3wVWMkNO/cRrI2PNaP2YF/rBsxe3TzGQ4SnP/xvDfYCIZfPUoaqYEW5DCqB86ha9D6arjqzZblU6z8AhnQXbTOzcEsFEeZMJ72S5qaKn7Ww=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;6:N08u1cMjxGTsOaYkVVBB563w9U5b9BDni2DkBR7dpR+cmZ10NUjGEEFP9Ex06RexbL7KGQBwWJioLb1DPVWhjEw+RZ5ofMR6A4UvESXavXp2l9iR3rYKmhFr7qYti2nWIfvTvkRVmcQZ0UA7H785ZxOGSLTjyxh9kwcu0vefQbu84gc+mcRkHI39bte5FJ7IvxgvXv5mTFP+ozltsuZFiib2Xy3ZMG2pP6RuVJeoo4xLgaQhGgo8N6omdzVucGezTU6doZgu3Qq7Bc6J95/VPNENhVyj5A8764oA0jotBMg01UAlzn5eim+1STyijD+le/lI5HOov4S4fRR6q11FTpBM/io9MuEaYqnxLcORjQGR9UvtQ4ELTL8Nmn7r7LA6Fvm/z7WSO9ejgx3fxALUQ7MdfLEom0KQh2pBq1TnupfmvbDX08NcY3imy3rDJrBIEFCxpyNzPjir+7pW/I17XA==;5:yb8VvHRUQrjAEr4ZDeaBGKEWaEXDhT/KmJ+P3DHIz50irjSGhQFWTfAhKJqWwTxzRbMxEp9HErjfDIvqDtHCU1lAYv7hvctm//PW4QbFw7KduB+l8A+8Rm+xa0p8+cKRnMYbzYi0nYwikM+Wj6tj4G0Q53Z7e+T+ySlTNJc4u+E=;7:0TXN+MxjKz95PlXMTFRNYW5B6ouy4V8tUMelLukXf5KuCBqWXWJ2YVZGHtKEbA0cJaCgdg44VIk3TqcfFBXrHwW6egROKRf48BQFp73W1j2eN5iZjfIDD5u+dzyYejfFGW53a6k/CRj3tfNwkKmYvwP5DJfgUrHbh6PTXv3j8cUSmSfL50Fi4UG2PWVQYX4Ue5Qch5CS4xMY/p6aIyLGz/qSbPJzpYBmtiodmncJJcJu/ReS6n6z4/rHePLioNab
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2022;20:b+xsoQbaUcYAhqRu5DYokgjF/YWmpQSCl8cEF5jREQ8IKHuklWILeu/8Qm3Jll1g1WzALXsjyXfbc9J2dXrAYQFPFBphNjygYMn3e+I+2ce+cXxy7d9nl82P+8Elf/7SaHTd0Tnl5rKw98rXcayD6apW2sHs24cjS/2+54ukR04=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 08:03:05.0313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b19448f-a777-4f8c-7cd4-08d5f84e60ca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.08.2018 19:22, Vladimir Davydov wrote:
> On Wed, Aug 01, 2018 at 11:55:52AM -0400, Johannes Weiner wrote:
>> On Tue, Jul 31, 2018 at 04:39:08PM -0700, Andrew Morton wrote:
>>> On Mon, 30 Jul 2018 11:31:13 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>
>>>> Subject: [PATCH] mm: memcontrol: simplify memcg idr allocation and error
>>>>  unwinding
>>>>
>>>> The memcg ID is allocated early in the multi-step memcg creation
>>>> process, which needs 2-step ID allocation and IDR publishing, as well
>>>> as two separate IDR cleanup/unwind sites on error.
>>>>
>>>> Defer the IDR allocation until the last second during onlining to
>>>> eliminate all this complexity. There is no requirement to have the ID
>>>> and IDR entry earlier than that. And the root reference to the ID is
>>>> put in the offline path, so this matches nicely.
>>>
>>> This patch isn't aware of Kirill's later "mm, memcg: assign memcg-aware
>>> shrinkers bitmap to memcg", which altered mem_cgroup_css_online():
>>>
>>> @@ -4356,6 +4470,11 @@ static int mem_cgroup_css_online(struct
>>>  {
>>>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>>>  
>>> +	if (memcg_alloc_shrinker_maps(memcg)) {
>>> +		mem_cgroup_id_remove(memcg);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>>  	/* Online state pins memcg ID, memcg ID pins CSS */
>>>  	atomic_set(&memcg->id.ref, 1);
>>>  	css_get(css);
>>>
>>
>> Hm, that looks out of place too. The bitmaps are allocated for the
>> entire lifetime of the css, not just while it's online.
>>
>> Any objections to the following fixup to that patch?
> 
> That would be incorrect. Memory cgroups that haven't been put online
> are invisible to for_each_mem_cgroup(), which is used for expanding
> shrinker maps of all cgroups - see memcg_expand_shrinker_maps(). So if
> memcg_expand_shrinker_maps() is called between css_alloc and css_online,
> it will miss this cgroup and its shrinker_map won't be reallocated to
> fit the new id. Allocating the shrinker map in css_online guarantees
> that it won't happen.

Yes, doubtless.

>Looks like this code lacks a comment...

Ok.
