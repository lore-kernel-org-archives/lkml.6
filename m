Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B4ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2740A2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VeXDkY4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2740A2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeISVT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:19:56 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:52789
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732164AbeISVT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxBsDIY80Zl+18c86WYGKG8nqqjnecGQSDMrh9wrvVM=;
 b=VeXDkY4Q7mYIwl4SI+RPQWueRrZA1FCSSwzICSwEQsJ1biWND9vlhEUvT0o6C1xZnqZF7s0oTf2G1j4WwTDp04+c+FfEvNM9Cnx3ZSFVmsoQqEKGuhYHJsvu8+/jlL/iIcg10wPKgAsUVwi1daauQ+T8Sw/8tyscP3YGR0KQmI0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2019.eurprd08.prod.outlook.com (2603:10a6:203:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Wed, 19 Sep
 2018 15:41:20 +0000
Subject: Re: [RFC] net;sched: Try to find idle cpu for RPS to handle packets
To:     Eric Dumazet <edumazet@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, tom@quantonium.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <153736009982.24033.13696245431713246950.stgit@localhost.localdomain>
 <CANn89iJ1UnwLFv5+AwXgeb1BUhYg8UJYTJLtiipavJee+2SWxQ@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2fdf2bd7-1cc4-a1e1-15c2-e2badfcd4d59@virtuozzo.com>
Date:   Wed, 19 Sep 2018 18:41:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CANn89iJ1UnwLFv5+AwXgeb1BUhYg8UJYTJLtiipavJee+2SWxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0008.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::18)
 To AM5PR0801MB2019.eurprd08.prod.outlook.com (2603:10a6:203:4b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e81f01d-f43e-482f-23bc-08d61e46590c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2019;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;3:9BwSXxShQ/PPVG72vWpq0kUlEqfTsqBy/avi6YoO3p7AqalDZXtjVaW9ry5icyvScTZksfFuJbBqY3IikVXT2GYHwxdi3uvFibkKKvXx0aXLY8H9H9FD7n9mQkv2VbcIHmcrbK7f7h5YFOPmjIlvrn2q/65yMrSg43gbk+NUoAxaZ/NwVQIqIRUOls9s6zlTU5KxOfkN1nLIS/mShm5RVza0t8vDD9/+b/unF6VdKtj+9fAv10PBFD4BwEKdU1wH;25:Y3+K62kQILP9Y0xk4jt0iMvolRYsoxuAQfPYpCsmV9J2hvqD1ws8FXUfHWmTN2UlEvWwSm+9DeuI+Sq9qNwg0r6XxcbRmgxjwCRiRl3pCPmkj3lne32HIx7d2ujpxlC1x08ZbCz6g3tLXs8q9tilrspXI0uJplsKT1AFZqAB9f6ZdvPBN3vbWReXzvW/O43KJjsgB7zqBSnrjZtm9aN4IR2DlXL9wt9rYiqAB5A/qM56hKREfXYOPwAfZLwCeJFxoRqcIlknjJU3KDesXKLjIZ1eMsz4dxQMv7+0UypQDtPgRxUcaXJsRykJtDlIMYus+9Bqd83jPR/zWRTnm3k0cA==;31:QrSNJ552qYRrSWgfPepNhc4Dqtn0lHW3ZdhfrmjwXT3DwDeb2WT0CVOJCCubqrMPmhFDMiO8NL0edvG2B4MUEW4xBnvyMXlcVF+4GFtH/IVM6MOoLinOP+gkhnu+cdj6/QhgRvO8Et3fi1GfQWmJfUf/ewB2U0qaIU1yc+DnmS060XBY6Rc2D5HF8V/R7s+BRf5l3S4bX3Rc4yQOIB+4gFgYI/hwuESmOyr88MCTzGU=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2019:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;20:nXpO37EiJkIeSWTBOZNP4HdoSuBATOt8iN1AzgQl5Gyadbpf2D42+IV1YMBx9jzbT4DpSYZb+WCrBZHBy0udN7puc2Fa41p+XuG0NV4Dz/f+gZLP85U0aTeIYQVYEjH2Lo7IFJxcQMwatx8YQ4RsvpRch9BqGPyuhk1eceSfJ8IBQV1N5zxRiFE6sSpI5kAmgQJzzjf+9jdyLVYIrVbs6i4o/jLZwsfYWouLUOADwhBjMy3Qy/FZXSCu0RO1GpXEF94IBaCc9HxY3R2tFXYoTa++8yoYMdmVB1V2CKvS17TEO9rOcdILWfo2IKrVBRtafbtzdUpZGnFrjuAKvE8zOg2S+fZ8oyjJu4oMmJiAeWdsCcaYyNel8gcLG8UjnSoFMuW245+BaC6hW1kbTAa/pE+lP2lAUFDvUfM4/ZfzUtHwBFw6nDrbOjz5TAAIhZsGY2MOox3zYDeChmLM4ZtwMkvACtaZp6EPTK7e7K1cjLnV7OM1z9pfVDexEG7j6V2t;4:xge2E2CvLsfLI9wHHoaSlF2zWzeM2QvgSFK6GX2yKh6bgB9EEF4/HtXqHGnm0CuZ0yEONAPoO4fTEmFaAkbK9SrP/dScRLAMbOMvSUICr6Qa/ZEHalhYN9FlOgrwocWBMOqSIa9zm52AlXCiOaSvEV4scSDKMRW9leWqmhM7+J1D8LU8RGzcnibwgZP1noxi2psPrXRRsqEAFV/Q0idRRP6jhdCpoP+C3SbpO9+tThatYo8pxOGsbAQ0G//YyV3Q6Mal/g3tBAXv4XCxPsIg8cRqcNsXoBQy6qJWoipYdBlZbs6HbXwONfN8CddhUzmbtygS1y5722WZoBpFtw6CrCfhmuAnNvUBMzvis5G/yOY=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2019B2EB8BDEE49E5439A35FCD1C0@AM5PR0801MB2019.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(269456686620040);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AM5PR0801MB2019;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2019;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(316002)(65826007)(3846002)(50466002)(4326008)(65956001)(66066001)(64126003)(65806001)(47776003)(6246003)(53936002)(105586002)(106356001)(229853002)(11346002)(476003)(8936002)(23676004)(26005)(97736004)(81166006)(81156014)(77096007)(25786009)(230700001)(16526019)(186003)(446003)(7736002)(68736007)(86362001)(956004)(2616005)(31696002)(36756003)(478600001)(6116002)(52146003)(6486002)(52116002)(76176011)(5660300001)(31686004)(58126008)(2486003)(486006)(6916009)(16576012)(305945005)(8676002)(6666003)(53546011)(386003)(2906002)(54906003)(37363001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2019;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTk7MjM6ZnlQY2JYMUZnRkZFeEtCdmUwdllXR0Q0?=
 =?utf-8?B?dlFlWGZXMGhEMGROdWNLNHRwalZkcXFlZWU2c0pIUFd0N2YzNnYyYXQycUZ5?=
 =?utf-8?B?OStqSVdqd2VCdjdBdFk4R0xQcjExeFV3MVpnNlgxQ2JCRDk3ZHFWeWsrS0NO?=
 =?utf-8?B?ZjlzUFFRS1Z4VU41R0VieHk0UFdrYmJ6WHpEMGRDbkFUWXdUL1ZTMlI1bFpV?=
 =?utf-8?B?Z1ZGSVZuSG5VVlQzQ2tBdHM3MFVFVUFkYWpSVkJTZmlSN3Y2Z2JDNWgzQSs5?=
 =?utf-8?B?dGZUd3JrTUFzUnBIU3c0NFdLYTZQeUIwVUszSkd6QlRHT3ArdXV2bjVZWFFG?=
 =?utf-8?B?TnBTc1QrUEovK1N0T1lLcExGcWhiSlovN2JDZm9IR1JEZGlkK2FaU3J5Skpa?=
 =?utf-8?B?eGozbkVZR1NnWnQ0cGVSeHdTYitOK2JOQnBNZmZVVC9ja2VaQmFZN0NueTdx?=
 =?utf-8?B?OVViNS9Pc2JnaU85NEczalVLM2thV0YzdnluMlBrVGVHUlVmNldqK1JVczRz?=
 =?utf-8?B?c2tkYmFhREpCNEtrSjBkZWNoKy94YzRPbVBOOERPeUlndU5kM1pqeGxwZE9W?=
 =?utf-8?B?dk9xY0trejA4MmFUSGh4WFA5OGtMMTlsOEc3UmNQcW15UWZkMS9jR2VYM3Fv?=
 =?utf-8?B?QUQ5elV3Tnl0eVQvZTRWOVhydkJRZnVsVm8yZk1Wa3R2azV0YzlqaXpJZWtD?=
 =?utf-8?B?dnFlU0xKajZvMjd5di8yMmJrYXRQN3dGVG1GbUU2c0E4cStPT0xTY3R0bUxn?=
 =?utf-8?B?QXd5eUJtb3VaUzdwM04wR1VMRHoxNExTdU1TSDJlSmZUTnI0clU4RnZ0Ti8x?=
 =?utf-8?B?SHVhR0FhTndwem9LMWZsZGhaTUs3VVp0cjJXQk5FSHlVUnRlc1VYWllLZ1Rw?=
 =?utf-8?B?R2ZBYW41Zkw2UWZyYkRRR1IreUVNOTg1WGR0a01sTms0Tnh5R3cxZGxhN1Rt?=
 =?utf-8?B?U0kvQSt0cWhVZW1IU285VW1mb3h6T0RMRjlmUEtWVlMxWXFrYlBteGJLOS9U?=
 =?utf-8?B?NStIMXJrMXYxRVdvUE8xa0ZDWFJyVzJQWWUrQ2kySk9LVE5sR0pic3dmRXQx?=
 =?utf-8?B?MTF0cEVQUm1ZcUw2SThrV0xrOGpHeWZuRVB1Rm9OTHV4RlZnY2FISGh3bnZT?=
 =?utf-8?B?YU9EMEs0d044NWRtSHQxdzRZSFV5L3RQREx3UGNzRSt6N3d3UEdWZTlBK1pS?=
 =?utf-8?B?ZlZnNnRUT1p0SUJ4RitQb0NUSkkyU0J4eCtZZ1oxMitnOS81Zmw0c3orY0Jk?=
 =?utf-8?B?SWJRS2xrVXBTdTB3SUJjVm9OcWNNRVVUcXRiNTh3WTVMRmFiTWFCRU1LVFVD?=
 =?utf-8?B?UFNrcUwwRXpPdVlsY1ZRRTdiR01sM2hsajdGMVg2WHpRb09vcjIxWXZ0ZTBu?=
 =?utf-8?B?bmRjWlhVelMyUlhZYUFUUkpVL0NQc3Z0TlZvVmo1a3AvZTA4azlHUXM3a0lt?=
 =?utf-8?B?T2Z4blNMOU4vOTkvamtkeHJsb29LVC9YNEtETXJsUHFoVUlkTXMyNUdmanZ6?=
 =?utf-8?B?VngwYVIzSE1OcHA1Y0lqREJYM29mbWZnWDBjSnZqam5VT0ZXRkk0b05OV2pu?=
 =?utf-8?B?eDJ4VGxtSndrTCtOZGFEQ2FpcWRMQzM2dTNzbnVwaU5VSFNabUVXL2gyM3FD?=
 =?utf-8?B?V2sxK1JmbDB5bkczVk9abGgwV2U1d3VFeHVTVHlQaDFNYVZnUlRjeEUrZEVK?=
 =?utf-8?B?UEExQmswcWNNUWY3S212cVZmRERhM2lGTE9OWFE1by8wWSs2aUVETnprYjBo?=
 =?utf-8?B?bUVwZVpCTW1VUGM5WnlMSXRmV2ZlMWlMY0FYdG5kcW9ZKzdEem5STnJqYWY0?=
 =?utf-8?B?dU5acThLYkk5dGNLb1pZNFdtci81R1gwYjNpdkdvcXJnK0lmT1dSM3FSY0xk?=
 =?utf-8?B?eVgzZngxTSs4dUtCMDRCeE9MT281ZXg1UVBnbFNKL0g4aWF0UytDVnhLSzh3?=
 =?utf-8?Q?YzuZKGdH+v1O+0He//Upep1xwxlRrQs0=3D?=
X-Microsoft-Antispam-Message-Info: SqeoH1QNJm/brLnD0qrRcO8WZEfSvYmeqM9UoqJzMYYbzAyJWJkthhSNqTrU0V0nO4+KMRi/n/cqOdHOg16wa3XlAi+lNyVEJit0zyY215KM/H2TYofl/t7UMaLHrVPM8gS8t6yGmuXp6v0mXsDvxfUytSe84OYdurVDcyu9t6W4orBXMfYjqwYOWE48HPRBVsPyPhh90f9bUpO9Aghr7XUS1V5x0yZnOj4R5+XKVuvonpS1n+MhbwjNnOjwZeouFHbXe+TXWIYOu9jSvmcvR6eeLPDq6EzJ2gqwNLTfIYx1p+w4B0cKn7QxmRlD3+UNmZNTSyLh5ddwoQ4yPn5RqfwQwJg2+LTVvhRVpaLu/MA=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;6:IheXaUmZ38wdZQlnHzWuGgxmHEbcHvMQeZam4pPpbJ89ylfqV/mTLJyhUsOxBt18ioB0Ai7wERsm6vWN+eA334RxnhmbWpuC3IYPsVuranj4NN7gz2kzomKeHy1AQ+VjPyJA40HMdpnt9fcOAVKiE10K+qtqpyLXkc4lvdKXkqHwrrfXFy9DNN+WE8dAie32qpCkvQz1zB9u1CX+jTuook9AhG/ucp4QeLtIK6VhYidkRDkEhaZTYHnt/7AxirmhCpFkWlzMXtO5moirH7X5xr3zLLnqq94jSbVb6WjFNdBo/dUgddLLMp6FlwB3r6RA1l+Fui9bsC0XrbfMu9ht0cEJM3eKD5RwOIFx8xYpVb8Wum1enaR53qq5WbX07fHA8U8PrqDNE9fDJ6wbM57OlGCsiZWRNoo86kj0fdf5lY2jgyQiA3YG6ScT35X6jnmCXoLu6ICDCeSSQUw5YCmaXw==;5:b28SgWAC5nsng96RhVlDV+/HFc385lT+PrCCf+u5i5dFlYzK4Ze593lHT/6D/xDRzJ5Y0vCxNjciFwnNydcDIzUZOEvAH7s2wJj7LkKxDiRiZDnJ9cxu3SZB3DuxRFBD1QHT+nIlkUqzCCstwFyd1Zd//7QXJfO2QlrCiVUHffc=;7:kzIfpDhTBqnnsPpc+jopGZHV1VHJICOB3m4Yz8NcZQv0oHFCtnygRpackiiBvr4j5yiXbj4F95ILpa+ghmMqRBPjlFjjMLx1T+8d6Pf1I68P3yoTCZGZqKKPGLCnO8UsmYNJUHf85O8PoL6siWmFI6+mfU9I2LNSaW5RdbKXiJfZuIIIkf4hVF9wz6ZQKi9wZYh5/Ds3g6IByfJKZ9YGCD568RDKyiWL1ejU96Xbd2GScWGuNW8uxRQ0ZxS5INdo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2019;20:2CSoEHfA1cnGtUdd0WSIAmBvIU5FCS5U+oVKFHdU95xhKdNDgkwN/7h+tUXTIW8fs9ntPR2yeQbzTrNXNDXwDEGLfnMYCg9oB5g64Wka/xR+mVBynT7q2fN122CAy2dqbxUaaOaRxR4AliVCn4j5EEX0RjJ+h82XjRIPUTs4bGQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 15:41:20.2399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e81f01d-f43e-482f-23bc-08d61e46590c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.2018 17:55, Eric Dumazet wrote:
> On Wed, Sep 19, 2018 at 5:29 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> Many workloads have polling mode of work. The application
>> checks for incomming packets from time to time, but it also
>> has a work to do, when there is no packets. This RFC
>> tries to develop an idea to queue RPS packets on idle
>> CPU in the the L3 domain of the consumer, so backlog
>> processing of the packets and the application can execute
>> in parallel.
>>
>> We require this in case of network cards does not
>> have enough RX queues to cover all online CPUs (this seems
>> to be the most cards), and  get_rps_cpu() actually chooses
>> remote cpu, and SMP interrupt is sent. Here we may try
>> our best, and to find idle CPU nearly the consumer's CPU.
>> Note, that in case of consumer works in poll mode and it
>> does not waits for incomming packets, its CPU will be not
>> idle, while CPU of a sleeping consumer may be idle. So,
>> not polling consumers will still be able to have skb
>> handled on its CPU.
>>
>> In case of network card has many queues, the device
>> interrupts will come on consumer's CPU, and this patch
>> won't try to find idle cpu for them.
>>
>> I've tried simple netperf test for this:
>> netserver -p 1234
>> netperf -L 127.0.0.1 -p 1234 -l 100
>>
>> Before:
>>  87380  16384  16384    100.00   60323.56
>>  87380  16384  16384    100.00   60388.46
>>  87380  16384  16384    100.00   60217.68
>>  87380  16384  16384    100.00   57995.41
>>  87380  16384  16384    100.00   60659.00
>>
>> After:
>>  87380  16384  16384    100.00   64569.09
>>  87380  16384  16384    100.00   64569.25
>>  87380  16384  16384    100.00   64691.63
>>  87380  16384  16384    100.00   64930.14
>>  87380  16384  16384    100.00   62670.15
>>
>> The difference between best runs is +7%,
>> the worst runs differ +8%.
>>
>> What do you think about following somehow in this way?
> 
> Hi Kirill
> 
> In my experience, scheduler has a poor view of softirq processing
> happening on various cpus.
> A cpu spending 90% of its cycles processing IRQ might be considered 'idle'

Yes, in case of there is softirq on top of irq_exit(), the cpu is not
considered as busy. But after MAX_SOFTIRQ_TIME (=2ms), ksoftirqd are
waken up to execute the work in process context, and the processor is
considered as !idle. 2ms is 2 timer ticks in case of HZ=1000. So, we
don't restart softirq in case of it was executed for more then 2ms.

The similar way, single net_rx_action() can't be executed longer
than 2ms.

Having 90% load in softirq (called on top of irq_exit()) should be
very unlikely situation, when there are too many interrupts with small
amount of work, which related softirq calls are doing for each of them.
I think it had be a problem even in plain napi case, since it would
worked not like expected.

But anyway. You worry, that during handling of next portion of skbs,
we find that previous portion of skbs already woken ksoftirqd, and
we don't see this cpu as idle? Yeah, then we'll try to change cpu,
and this is not what we want. We want to continue use the cpu, where
previous portion was handler. Hm, not so fast I'll answer, but certainly,
this may be handled somehow in more creative way.

> So please run a real workload (it is _very_ uncommon anyone set up RPS
> on lo interface !)
>
> Like 400 or more concurrent netperf -t TCP_RR on a 10Gbit NIC.

Yeah, it's just a simulation of a single irq nic. I'll try on something
more real hardware.

How do you execute such the tests? I don't see the appropriate parameter
of netperf. Does this mean just to start 400 copies of netperf? How is
to aggregate their results in this case? 
 
> Thanks.
> 
> PS: Idea of playing with L3 domains is interesting, I have personally
> tried various strategies in the past but none of them
> demonstrated a clear win.

Thanks,
Kirill
