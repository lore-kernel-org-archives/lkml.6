Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D9BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B77214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NkTYDqCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B77214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbeIURlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:41:35 -0400
Received: from mail-eopbgr10092.outbound.protection.outlook.com ([40.107.1.92]:9728
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389647AbeIURlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcG4SKLp5l/ANMqhvkTk9A0QXEz1X4EdGM0soBWGh8w=;
 b=NkTYDqCVNT/xeYb/GqSwGQCQPXPElrMlmeeC02nRVYSKLqYUplJcvuPYnNVndPOLm8zaDonFZGE4Cz1j8V8yT51x+LkYBsHGdUW85HvtTVAyg8tDYJUD5/T8/aLFV6iA+UY4sVt8jjPOmBbFi8rhbSf11dqleH9JkHwxLDjcPug=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 AM6PR08MB3254.eurprd08.prod.outlook.com (2603:10a6:209:47::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 11:52:54 +0000
Subject: Re: [PATCH] kernel/kcov: Replace vm_insert_page with vmf_insert_page
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>, tchibo@google.com,
        linux-kernel@vger.kernel.org
References: <20180920191254.GA22764@jordon-HP-15-Notebook-PC>
 <6fa7d32b-07f0-ab6d-8053-021b171153e6@virtuozzo.com>
 <CAFqt6zbp8wynKqFRyp3Q55Scoi9ojfdCVkMrxC4w9qxPxWMXGQ@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <68b8cbf3-1b5a-2311-ac09-a8676280e85e@virtuozzo.com>
Date:   Fri, 21 Sep 2018 14:53:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zbp8wynKqFRyp3Q55Scoi9ojfdCVkMrxC4w9qxPxWMXGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR0101CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::18) To AM6PR08MB3254.eurprd08.prod.outlook.com
 (2603:10a6:209:47::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc599be9-8033-4d34-b915-08d61fb8c440
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3254;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;3:iYwQdaXXyvH0svSgEIH+7Xapyi9EWyfqchsyPuCUO5blNfgdAUXSEYocOPUT38NsPmHYODNUEDqoSBZGYdRbkW082L6KiIgHpNSyYhaKrbSQpM7j2TorxqfAuDw+axiz3vc35smCj8D+dQ5knfDpl2pqU5GDM134+8JE6V0G8Sy6wDoxSOP2UF5kooYNIyRRCNaQbQibr0o8T/k+FqG3J8Xais7qhhcXfy9q5yPML8nq7swZELEqOTcLpY/+XOiF;25:77Yf/Jfr4G5ZUR8N6fCZRTEFiIAWJE4vEQfpBuVDbn4RvgG2bVMuuqf1RubWuCxwLkePJC+TZUrQq0SGeeQuMQcouLdwUdv2BhE1Z+tgHY3RnKR4cvy2ts/WaG2bx+tdAAHU799HWnsE8AluLETVJUA0l7mAYYzLFABDBXmqUbcIFGcYPGck2tjhh7i1yhwhywsWfvaUrnuIlZI9TnU6/BVsTgFD+daPC3zr/YVX+10XcBcJiNnBEAE2v2eNySri82B9neeTKSsqybaC1a/8u87nOw8gs06fBJuz/yqriQXKY5OYiIrtQO4MLHcclO2XAf5/2bQEReTlk6FKBauvXg==;31:8thsAgccAgNnyidTJpG/wEU0RVxz4KQS5hVQro80bxVDCZktkRRKNGITAr2spr5fnzz9pg8FY40EhliZAzWRc9J3FVT0+XI/16uADxlMumEbKdVDlOanaj2rhnAGSe7ipthhmvprpPo7i5SMLZy0ab2Xm/i8AWhBY2K8Py011q8MqMLa+gmGQCngKEPghPLIpsaJ1pExpg+csVoAryt53/JAcsqHLsp1teN+RuWzRO4=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3254:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:AilcISjTda8YsaQASpAy6PdSp6GrYdwKfnokecN/gvvjna8WLtRLYaykSaPZu8gGha7jhWGiIRBDkfP//Kk2Ej5hcES1NcI/bt31kjhRkGoXl8g4gsjdyo5yCzDrKOlz2eiEA7GBSLDB/eUDppSayVzUq5VtMzhT3ULixj/U8q5QVHl+2RrMc2Yy9p/lIdnZNucTWDCRJDVlHnEdxWZxi3CbIhpjTX2TLpsTm3iRjpgSYkC4VaMqMl0k0S1cSNH0PdOzclzjfXZ08b1axhEwTHG9qTqV+5d1QuSiSZPVRblQdx8LSHBjqfoAyy0daXBj5b2grzb17N/lcjPWikr1EwrHu0rvNdASGngypAO1alc8wZapzM5R2OnUadBIA+UBQoQ6fUhVWCui+vZifu6VbM3RqIQsvY2UQV6RGtXcQ0wZ4zyDjNpXo1hMU8bQfR8xIAeQzxfsaZ2LjocjjSThEjfyLDgxQjugAHUwOYpe2rsqomb81oPzjAD2OtxBBEw3;4:fiSB2cDSFD5eI/kKSXOcF655i5rNnz4H7D+tW/QiWMlHbdTjpnAc84Tj7/POSzGEzvm16qHZqL+7qOySfypQuZHsYwXi2wFmOpcuSCphGlILQpCB5gsjDjG5ZHTUfo4TMGfNndU0bYvON5DHT5c9UDmwczojI/9uzjaBqVxOANAWRKjXRQWieAzeV0T5l0d+WkKrsGbc8Dj6+OdXL13o6xdY0nFSzPpO1t5hxRxfqP3RBEuPJAIvbc3JXOWkFt+EhRkITH4Vs2e1vGYzMvObH+kYWLrDMVOI+3VmReqyqoblMZZY8mMHy9lz9WtdRXskQkN3rqEqIh8HX2MPAZX60lcDCerjHjpLI5Bi1rSZPQ4=
X-Microsoft-Antispam-PRVS: <AM6PR08MB325425A8EC2DEC7E285F4F23B0120@AM6PR08MB3254.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:AM6PR08MB3254;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3254;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(136003)(39850400004)(376002)(189003)(199004)(36756003)(31686004)(386003)(4326008)(53546011)(316002)(305945005)(16526019)(186003)(54906003)(65826007)(2906002)(58126008)(16576012)(7736002)(6486002)(5660300001)(77096007)(26005)(68736007)(478600001)(81166006)(6246003)(14444005)(81156014)(8676002)(52146003)(2486003)(23676004)(52116002)(31696002)(76176011)(86362001)(6666003)(25786009)(50466002)(230700001)(446003)(6916009)(65956001)(65806001)(8936002)(476003)(11346002)(47776003)(2616005)(486006)(956004)(66066001)(3846002)(53936002)(97736004)(6116002)(106356001)(229853002)(105586002)(64126003)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3254;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU0OzIzOit2eHFGdTlRaFVlbk80VVJBZDhxYmdlblFy?=
 =?utf-8?B?UTNMcXNXR1NJazVsMW9SdmdNL1FyeExZSjBDQ3RBSVhMKzU3NmlCOGJ6VnBF?=
 =?utf-8?B?eXYzVE50b09GRUVqOWc3RDBCN3VVNlJaekZJS1pCbGQvZ21oZnZsemQwVkE0?=
 =?utf-8?B?b21RMmZ0cnRLR28xdE5sdG53cVI0dm96Z212eVB6Wmt5VnBvaDdxQkdVMlhC?=
 =?utf-8?B?WDJSelc3LzFMU08xYUZEUm9VTlM5bkVieEt0UTVZNjJWV0NBUTBCSWwzZU1U?=
 =?utf-8?B?aDc4SkxyM0FiRkVlRmxqak9wc3VjMlZnYnp5RlMzcHZCUDVZaWJLaWJ0eFV1?=
 =?utf-8?B?aGVFYW90U3VRVFZhMi9qRmFkQlQ5eFlPQVRPaUFYeGUveCswSWF5dXgyVlJX?=
 =?utf-8?B?QkI5Sm9PcEtkZWhNOTVldmt5U2FtQWdNUGI3b09nbVE3bGJHRElVZGdxWDdM?=
 =?utf-8?B?Y3FUTkk0TzRBd2RTMlJCUEhqTS84MWgzRDVJdmtGRks0LzltdEMwckh0b3JP?=
 =?utf-8?B?OGs0K2pHcFZaR09Hb1Eyb2VvM3ROTzF0dVF3K0h3QTltRjQrMWVxUHJGOEU4?=
 =?utf-8?B?aU9TWlJqa0dVVGhDc29KRVkvdHZiNklJYVU3Ykl5NndNbThIUmJUUkhvMEdJ?=
 =?utf-8?B?SHhwYWU1SDlBUEtIcUR3aXViYU5GQkJJVHgwTTZFc3ZKVGdZRitSMG50SzlS?=
 =?utf-8?B?ZTgvTy91SC9SdVU5UDFFazdHclZzc2E0Q3pVeUxXOXQ4b2JlWFpFYmIzd0JB?=
 =?utf-8?B?eFk1VDRMSHUyT2dkU0d3a0pwQ1Z5OUV0ODRic0FiOERyMTdaOGdNTDR5Z2VZ?=
 =?utf-8?B?U1Noa25IWGpaTHJ6cnRiY1dFdUlESzNIaWJjc0U1RjlKWVhyR29PQXVVNGFG?=
 =?utf-8?B?UWVrd0JHUTJ1Zktpcjd0L3JMMFJVbFBhY05yYVd1aGhGU3Y4aUw1cVUxOHVm?=
 =?utf-8?B?bC8xQXFBOGtzZ0xRN2NlanlzLzlLNFBDWnE5WU5zZ1dncHBGZ0JqUXQ2MGRz?=
 =?utf-8?B?aU9Mc0ZET2s4WmdpblZGYi9NSHVFYlFSVGdkOFFIT2VPK2tVYkYybStGejBK?=
 =?utf-8?B?VkUxV0lxK3dmL0RwZmhCeUhuN0wxaFF0Yi9pQll1cmJsRXhhaXlpUkpRaXU3?=
 =?utf-8?B?MzQvQS9ST2hVMXRZNzZHTXdId2F3QmsrNUJNVFE0eWNNSWtEY2JacU1zYzls?=
 =?utf-8?B?a3YzdkRTdTZpK1RtYVdCNUZCZW9CNXEvVld2YXJTM01zQ21CdnZqU2lLczNZ?=
 =?utf-8?B?bEdWMThPOWhrZ0FvSE0zMHArNVR6aUpmYXI3NU1hcUkxRHZPVDYydHh6bkRm?=
 =?utf-8?B?ZmE1TGRxRUdIMXhuS29PK3hEZkovcFp4ajB5b0RyeFRjSVlTUGh5VWxNcTk2?=
 =?utf-8?B?TC9FT3ppTHZTajdxVkZpdWNIK1FsM3BKU0sxNi9DZ0N1cE1iNFE4L1dWOERC?=
 =?utf-8?B?OWd4OER0TER5WmFLM1o4MFkzbTFiRldXajVhOWF0MzRTbkYyaEIrc3ZhUkRQ?=
 =?utf-8?B?Qlk0Z3pUenQ0SVlZdzVEM2ROam9TeWJKbmxZVjZYTmJOTkVkNzYwbGk4S3FB?=
 =?utf-8?B?Q2VnNmNCcHhQL3Y5cFVldE1ZVFZxYmxVeUUzOVg5SkJkYjdNaFFnVDVmdzF5?=
 =?utf-8?B?dWduR01udE4wUU9tUEN6T2kzSXptNFhVWGxjbUNUQjFyL1ZHNUxxRzRFOHF4?=
 =?utf-8?B?U1RQeFpjSERxdG5CMlhDWi8yYmdFdlV1aXVKVHV2N0ZkWkxERjhTVUZja3dp?=
 =?utf-8?B?dkdWL3ZydVdDU0hmTW16SmZDQ2xHYld2NjRKZ2VKWFF4Mi9SV3pkdUdWbjJU?=
 =?utf-8?B?NFpIa2ZFV21EQlBLUHVhYjRrMW1DZEJYVlhTbnY3ZXBHMGJLZ1hYNjR3Yk5m?=
 =?utf-8?B?WG5xbjRFQk40TEF6SkpUTi95a2RsRnRsWk5LVnZsb2k2Vjg2QXBMU2dveGll?=
 =?utf-8?B?UDBxMTBDQVZscXlvUDd3Ty8za2dZQUQ0NUZkYWk5Z2Y5Q3NJekd2M1VWWUEw?=
 =?utf-8?Q?q8epTL?=
X-Microsoft-Antispam-Message-Info: msCpF0fVEx3UXR+DbqWA1OhtQ/+I+HyMDCB1yLTi+ciQupeZOsBQuItCCCOpD63/2UqC3ocDZPGoAxjc2kBafL76+0EUg8ruyT53Oy42Ljdex7DnZO8NncZw9TO59AV+OZ1eE+JgaCn5ZTJ19LFYPdCvGQZbeShkrnXBwBc1HHKJYh9D3QnSEfLpDVaYHF+LHgfydhgBbYlf2WS5p3LMmiPyF03zbwpSkTXqvydL1LSfvH8WosM16fRSL0LmrZ5gh+IU50ZprvyqcSoojXeORdLfqpBhFK1S5/BR/meXkKEqN05TLmyE0w++HzYrkUGnDPK5UXWqgb/ycqhxCpHWBh3AGEODWTOTxrR/8SnZm0Y=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;6:LVd1f3RmodG7PFf848uBwovYyGYpHZ0cjD1lKg3+sew2ug/L12LDb1AKEh+lt+A1JNHpIKOBfrqW9ZMk39FETEV102nadfflVRZ84n8mznsLBv/OdOG/IU8ZweKFqtqjYVfmhDwKXxIe00Gm0Pta0heX5efJsxoSg9vezSDYolCNFA09AajbnP1rYgGy2qPBHXv6JeU4A98gv5uUWw+cevt5uWNgFdzN5onTI/PtNT+8HpAodq/Ow1sECNhCcZWUcdm8W5g6SETJJ8xyHQ5VMUdO0FBpPhe3xLJvGwR5otfId7WaOSu3DfAqrsxE/UE2c4YNy+yB7BtGcFFhKQsJhC0kT7wpwNSPTlM9r3p3w1lRRo7unN/66ZmujLzuUm/gnlImbE34a4kn1LCaAvlDm6D0hLloHyrNhO5Q5CpfuWo9cvKr9mKLG+JEVAK9s9CG808BiZbppnyx+F24Y0dIjg==;5:r+vvZayZ1aa3O6AipKXX9NY6OwgyTMHGydp0EA9wRtii5DFN3zamTsmujAAh1mlXhNTxp0CGcmvHe5bJf63eKvs/IoFrsLJvY6iWFayiet1LL5d2AVzctjQX22Fkndh15F7Ka7NHD+6wBbz9Tmcpn4LYcBEXgpFo8gol0eE3Z/M=;7:Gc5NYpYOZTsPy9tTbsjT3Dl/8EyOXlAeUErANM16+VbHadQgdNWxrD5QL4SOzyahA9sERpiNSGXxzb6gIJI1cE0fcAKiEDOnFOl2DWllUShEw/S+I+vrlB88Yc+PyOBRn5T/KQeL6xa5kkX6UkgpNQGa1JgsP0VqGYQfm7E0q7JGDyOGc73+67ez/ekgown+ltJzMAsIYGZYMGJVJoxb85bXeP9NeH7Fi1vDajZYbmcs24e/BIIgNDq+ld1/KCZi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3254;20:Lq0oOfFZUeqRG7cLqKAwf5fsVZY0ADT9l9skxEzQGYXCuCvcxjhB2IFAoro8pI8JHH87BUsoXQ3iPjvICGd7rgW5MiueKD7ULVwsN8qR3njkjS/r6LbP2RaPdU8VnyOctrMU4QrfXOQQMFS2ILZ9fxKh1/9mTdTfWPr5Sf95mPA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:52:54.0898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc599be9-8033-4d34-b915-08d61fb8c440
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/21/2018 01:03 PM, Souptick Joarder wrote:
> On Fri, Sep 21, 2018 at 3:06 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>
>> On 09/20/2018 10:12 PM, Souptick Joarder wrote:
>>> There is a plan to replace vm_insert_page with new API
>>> vmf_insert_page. As part of it, converting vm_insert_page
>>> to use vmf_insert_page.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> ---
>>>  kernel/kcov.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/kcov.c b/kernel/kcov.c
>>> index 3ebd09e..8900d8e 100644
>>> --- a/kernel/kcov.c
>>> +++ b/kernel/kcov.c
>>> @@ -293,8 +293,9 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>>>               spin_unlock(&kcov->lock);
>>>               for (off = 0; off < size; off += PAGE_SIZE) {
>>>                       page = vmalloc_to_page(kcov->area + off);
>>> -                     if (vm_insert_page(vma, vma->vm_start + off, page))
>>> -                             WARN_ONCE(1, "vm_insert_page() failed");
>>> +                     if (vmf_insert_page(vma, vma->vm_start + off, page)
>>> +                                     != VM_FAULT_NOPAGE)
>>> +                             WARN_ONCE(1, "vmf_insert_page() failed");
>>
>> Nack, don't see the reason for such change, it only makes code worse.
> 
> Yes, it needed.

No, it's not needed. vm_insert_page() works perfectly fine here.

> Going forward vm_insert_page will be converted to
> vmf_insert_page. As part of it, this code has to be converted to use
> vmf_insert_page().

This doesn't explain why such conversion would make sense for kcov_mmap().

> please refer below commit on linus tree -
> 1c8f422059ae5da07db74

That the commit has nothing to deal with kcov, it doesn't explain why kcov_mmap()
can't keep using vm_insert_page() and/or why we should prefer vmf_insert_page()
over vm_insert_page() particularly in the case of kcov_mmap().
 
