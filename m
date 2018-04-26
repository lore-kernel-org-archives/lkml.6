Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756768AbeDZP5I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:57:08 -0400
Received: from mail-ve1eur01on0101.outbound.protection.outlook.com ([104.47.1.101]:5709
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753207AbeDZP5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:57:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 4/4] exit: Lockless iteration over task list in
 mm_update_next_owner()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        akpm@linux-foundation.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, mhocko@suse.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        ebiederm@xmission.com, dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <152474046779.29458.5294808258041953930.stgit@localhost.localdomain>
 <20180426123542.GA819@andrea>
 <c21ad28c-cd23-2a75-6622-ba49c37137db@virtuozzo.com>
 <20180426152000.GB4082@hirez.programming.kicks-ass.net>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <1d7c0dd6-22d8-89ea-15cc-bc3d46024bbd@virtuozzo.com>
Date: Thu, 26 Apr 2018 18:56:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426152000.GB4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::28)
 To VI1PR0801MB1344.eurprd08.prod.outlook.com (2603:10a6:800:3b::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1344;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;3:sbWzYR0JoHxdLyVKJZHc8YBmzkHcIncgPSm1s7+umuthVe894Oh2pJKnXXijtniTEHGWd+HvtGdPdcQiVO30priw4jG+9HtrGAA6GkHD0y4uxil2FijyX7oVxj8h5FaYfGVIWaNK0uTcrc2aqik2vKdPUsanezDayDwpk3TPRhRT0TxKJ6bIgD86RFSjRNdmJ29AOPD5O4HgdSVOK++ITGImjmNH52oTi3cVQiX7W7mwwMLRxnC4qJ86unnHVF4e;25:LPoc/Mm8FPE/r3BSl1og/03Pp0IR/oybb28l6ziH5cLT24t1nuxsJrgrmriJWFzNVAgUmh3ZVftGERC+IGbvxU4lakELHrMNh9k6g62uOXAh9T3PhIq8qa5RnYIspOnxCTyPgXF40Wk9GhBRRpjQZzDct2JijgblYrLoqh5UyJ4Lqj3euxtjlZXM0cFZrLIl/SWf+038QZUtEUVLqhqBARA2es5ml1+QO3dqZMj0fXWgDhcve0tx9YSi9TbUvOk+u+o0VMAnwmTiGnF0k3O1f50jbhlRjyd10rr4Qd96rmn/4GFJa4sa5OLmEI2lkoC/9+5suX+IihnZho5MXnAOWw==;31:ChF88s/S42C9I+o9Ciz+cNAoTyZpRgS3kKA8ARAwSyUQgoh8gHKF2qtY/vL2eMwczym2ivwv5gwXr/QWPxqEyPfVfFUecLlu52BqwhgS/GNx+ExIEdGEWUD/nXFkbudqZuS10lvGNCT2ae1RJqA+Vd3LG3E1mM6oX5jvrh7pEFgVjM3r+N6QliRnxqjHCWKK7ztxuGqTF5kV7x+g8++zln8EM7W5auxviZBaPX4KXsk=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1344:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;20:PpeoDMCYjrkCgO3z1way0urb1zkUZxviXPQLvdVoOtFTW14lQBGAL7SRam5Kw1p7xIxBjGJApXfZmxDO70lght9rWUwBfIypG0BddGjTd2jJtHcTY5VC39ly8tKrd7M8jbu27q6CQ/yAdsPY3BVCNRVxBAln6uOk/KEDfX+NQV6+hUTsXuccFaAm2ePf5caDgxxgYywDa38kcJXhljd1ia4icjEm0srHdJcN00Pzs2UfSEy2M9A/VLqJHkk55c5rZONJlbV5E1Xgkg7AZoaWu7hjjit/3e6+YDMSMPlwbb1ebGAmkuH2wA2HlJ+026nb05evfEl0anRdvgfhXipdjEnbylIRuMyq3+3M7gQD4BDuau69QXEA77PmN44XB12jJlI2KWjNPcYr5EUaaP5AUhY9Y/y8CJN9S/5SPb2MT3Mz/dSgTWgFX5acaWyo0T/myHbq5Nye/9i3/Wn3G2XFeKs48MNoi6vhUywGseO64ldjhfOPJrrIU+bxENusYgkK;4:xA+ycuqdDokMB6F3o50YglucynT9YA6Rtz1qlygpaHFrAWDqtmnv+YdWkVlhwYFYV91d+ls24sezB6A4seKDA/ROhQKG0KoU/wFfLES+zYsgAfgPwhA8FDXY/cHJt96avUq11nRhe0YDzrjLaW+O4QrISMX+/u3Q6nMDm7TYowvTj6s++ovrdhyYXjhOqzV1ZLwAAxkqMhrI8lcj0s/G9Crjj7Kf0l98ezIGsJXeffDdm1pmvYwnZqvw2u0LqsPetl69UApOmCz83a6l8aE/4Q==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13442F84C16EFF5C440F044BCD8E0@VI1PR0801MB1344.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1344;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1344;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(366004)(39850400004)(396003)(346002)(189003)(199004)(478600001)(2906002)(64126003)(31686004)(86362001)(81156014)(305945005)(7736002)(81166006)(229853002)(55236004)(11346002)(16576012)(106356001)(6486002)(476003)(2616005)(956004)(8936002)(53546011)(68736007)(386003)(31696002)(58126008)(105586002)(36756003)(59450400001)(47776003)(50466002)(486006)(446003)(54906003)(65806001)(77096007)(52116002)(25786009)(52146003)(93886005)(5660300001)(230700001)(23676004)(6916009)(26005)(2486003)(39060400002)(8676002)(6246003)(316002)(76176011)(186003)(16526019)(66066001)(4326008)(6116002)(3846002)(6666003)(65956001)(7416002)(97736004)(65826007)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1344;H:[172.16.45.234];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDQ7MjM6dEZJQ2E2YTBKOWYzdDNVQUJBSFpLZE1L?=
 =?utf-8?B?aFhPRUI0MmVIUHNWSmg5bTNwT0h3MG5GbW5qY3U3bGxFWG00d011ckpVekF4?=
 =?utf-8?B?RFZ2dHV6andPaW5GY21KVytpdWhhZHVUanprbkFxckdOeXhaZzZJSXVjUWN1?=
 =?utf-8?B?bTEvU0pSUmlweUtiNERKUWxvNk0zU0JqNFQwWGh2Y3VBN0xKc2MwbXRRTjhS?=
 =?utf-8?B?c0h0T081aUtSNTdOY3BGMDZUUU9TZHdhMmE5ajFiTUs1ODNRVmphR1k0dXNm?=
 =?utf-8?B?WEdqWVI4ZU5mNkZ5ajJRdkVTY2IyRzE4RXpDWVVoUGFBOTRsMEYwaWhlN1do?=
 =?utf-8?B?UVpIZkNPSUdxS2t3enFlaVhmOE1mZnBNOXkwTitoS2tTYUc0aDIwVDB3NUhF?=
 =?utf-8?B?ak5VTlJLancrdUZnYU5RbThzUnpvK2lPbm9hTGlPSjNNb2I4ajVoQUpGbkxO?=
 =?utf-8?B?RHhlQXdqZkwrcitLYVJnQXNqV2prdzZVQXBrMy9rMlZCb1R5aDJadG1qVmlY?=
 =?utf-8?B?ZVFERUxsY3EyMkRDV3NlWFgrMTljcEF6ZENNR1Z6NDlqczloNFdiQVNwbWtl?=
 =?utf-8?B?bFBNVEVkVHF3YjZPcWJsS2VHME4zQURzYnplQ3gxRm1ZWEp2YTRUelFOUEhG?=
 =?utf-8?B?WU1QYjNGWUdEeEpQOGY4QXFuc3JvWUFGeFdMMUExZkprTyt5SnpPcHpQTTdj?=
 =?utf-8?B?N0ErOUdDdFp5bXNjbXFBQi9ya1hKazNvNmUwTTVZYkwrenJJd1V0ZXNvOC9H?=
 =?utf-8?B?RElVOTM4NVlFTnJJZ3hRRGpNY2o1eWo2Z1drTFFwSTh3MVh2a2N5R1RNVDlB?=
 =?utf-8?B?UjRQREZyVVo4bUF0Qm1zOVZtYTdIYmJ2eVdIbmY1VUhMVUxLMGpOQkNTSVAw?=
 =?utf-8?B?Q01DKzFWMS9zOUVFLzBYVi9IUTZmajBoYTIvcFFGdE00ajh3QVpiTmNDdEhD?=
 =?utf-8?B?V2I0MDlrMFJHK0s5UlcydHhoL3l2STJJMG43VWhJaWpySzFEZVFwNVhJa2pz?=
 =?utf-8?B?VWtBRE5yZ0d2clVsakdkOXp6RHpzaHg4Q2IwbVhzallsMHRSRXNUSThYZlgy?=
 =?utf-8?B?cit4b1hGTE80TWN3cGdMK2Z5TzEvVDRTZzFWYWZlY0JMb21Hb2paQ2gyalZt?=
 =?utf-8?B?VjZEaUE5TWxsdVJYSXJNMFpGWFBjd1NTZ01pWHlIdXBiSWJqb0ZRb1J3VTd6?=
 =?utf-8?B?UzR3cTcrUGhpUit5eEpWTUxVSFJXOEgxeE11UTVqODVBY3dWU1BIWG5YM0sw?=
 =?utf-8?B?TVRiaGZhdkpoS0FFMVZwQjU3ZzZoZ1dXN0Z2T0F4amZoaHE3TFc4b2w5SVRF?=
 =?utf-8?B?OVVGY205aitHeVgzRTRGRkxDNzdYSEhpYytLeG9jTW4xNWlTVFJwN28yWkpB?=
 =?utf-8?B?a0drais4YWlhUnpVVmIxdGpyM1pjZGZUNS9QZUh4UFlwdE5ZUk5FczdvRVFk?=
 =?utf-8?B?YWtQblZXT1REd0d5VWJLNE12U1ljaVRBZjRHdkkrZ3B2ZjZlSVlmTlR6M0tD?=
 =?utf-8?B?eHRrSzlSbGxMWDhDdUpwdlJHVGIzSjFUczl6dGIyeUNQNE5uMTFnWlEyVHRu?=
 =?utf-8?B?TUdBR1JVUEFzRVVDQVcyQytFa1VnSThCM29RamtFQWNtbUZxVktXVmlmZmZz?=
 =?utf-8?B?dzZJUkZVQ2MzeXpwcTVCNkQ5Rm1TN2o0M2hDcnZhbDIrQTJMYm5HT0NmdDFE?=
 =?utf-8?B?S2ZtTkJidmhhQUlDYkgxOXBrUm02NDN4VUJxTmp0TGRvTkh0Z3BkVGc2SnBh?=
 =?utf-8?B?UDkvR0VuTzgzVHQ4NjNHTXhtTDZTbUpXK1VPMEJET0VBR1hrR25nZzlzSHky?=
 =?utf-8?B?dTQxd3J2WVZhYlZVcnNZdXEweVROT1VLZ1R4Q2NmUHUyeloyeUZKaDFLREVM?=
 =?utf-8?B?N0poRXZtUWl6MmkvajNwYSsxbWFxRVVrb3R1QmpkRXRubklURFhnUjRhTTBY?=
 =?utf-8?B?cHJqblNJTVd4d3AvbnpKQnpVWi96VCtGT3VqOGVOYVRCOHQ3ekRXMG5VQmRq?=
 =?utf-8?B?ejN3Smwwejg0ZzJURDk0SG5uOFZ1K0RuMjNzT1dUOXVHa3ZzUHVDSlZqYit5?=
 =?utf-8?B?WGd0TGdmd21GaXZtZXpBdS9SdzhxT3M0dlBJZEc0cGtobDg2eFBoNWcwRVgy?=
 =?utf-8?B?T1d2QT09?=
X-Microsoft-Antispam-Message-Info: KR8whB7RELMKm1Zza7QjLdG+Bhl0s5EvpZoj8jaIaSGjsJS/UIRYkSlivJD1RxvwZ7NNCI59k8FkCBG2gq31JkVvYx+vf6SCKHeCjuy+1nxLCijpqIqE1zZgaXDSuqx7VjnLfmxzHeLRbbFt7mNuOvHCRSeSAH0xfNXx6ehOKYqTpFUWOOmj0hVVlYNjGtkA
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;6:gtzLLKE7mKYQXFHxes1zHIxxtvDJ4IRL6JascT7wEL6tw6vM09Bb986hftJWwkfu2+63xUolDkzV61irkjKzf1NdDGAlkF/I+nClpf/tk2NdnqJfI8xIOVPXnjbIWa7Y+DejYk4i63Fu36L3lMgaTZYL8u699qeTxtMTQA89OZyBPeiuHRWjy/U7nAinTmL5mNyfTVMKDKV2UETufgz4kA5ZXmXdJ+4VGgDhcj9VBlP8xKfuRNh0PodV5joCAFnJF/P51nUjWom2aNrSPlBt0bZ9vpNPRH3xpSQpt5l1sdf683+AYwC1E/QIPP8E2ZiLltj8TDhZrgP3ZTW3t0No2WaU3Uodj84ho3pkP6NK/RT8IAOxGfjxuWPhoYID2HC9RK7ohR9NPs9ciMipUiEO368NOGGJdjA93Hwq/6bx7pzivNNqN5MDbRYCtLEVwN/9JqcoH+yUrrpzh0pL88YlOQ==;5:qRc+qUoTJiy4ghZ8YJBLcyg4FroMr/pMsjfrkKCsfbG2qsV5v+HA1KLiE4MXh+MvLIWBllqqFLmNlBtRJSsPhgezYb+0Vr2bVkvfPoAJtJFOSoXmdaeaiJ4ySHf8QPLT+k3OsvNXKenAcApISDIZ0jzEAu+zBV4f78URyvGeUvM=;24:ntgEsZXET0d28CQR7tVonQSmiiiaufxRdYrq4ILQZd/QaGIK8ITeAsYSwLeo0Bwqe3+VNfQwXHjq80H4uokGE8nSmXMWogH1pf9UMiroLfc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1344;7:n4+1jCWTVIQCXJ/hgKVIT1GUWkjt2TjSSQJ67QVhUFn60lMCnaCJ1/jUpSNO/CKLDT3Pat5FP+iHxEJM7gohGteBw3ati/90fYJNASoifEI/hqyYXskiEsaUumDEC1R9mf0BfjZV+xa87hEZ41w1HM2XqKY9TjidYGet0a+ibTnOk5AG6b5Ffsn7lsp95qzg4v+oyLDSlRGN9Cjc4Hu2hHJd95QQopXYHFO/l3YtrFVVhtMiGwNwHd/EbO0mmRof;20:b00Ftr55eOi2Ehu6dCYtOZJM7RH26ZdZVlyEnN6RDDPTxfg6TRUr2sS1QQR7R8ihyXKGrTQz3UgXJ9T0brdvwmTngbyEQzeG7wJI6P8V7+ya9mJaztkVoOtjKU91cv7izbc3a71/VDiiSrJMH5BoHg7OXa3aNCFHdUwBOhe97c8=
X-MS-Office365-Filtering-Correlation-Id: 2829d981-1031-466f-c51b-08d5ab8e5944
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 15:56:59.3082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2829d981-1031-466f-c51b-08d5ab8e5944
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1344
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.2018 18:20, Peter Zijlstra wrote:
> On Thu, Apr 26, 2018 at 04:52:39PM +0300, Kirill Tkhai wrote:
>> In the patch I used the logic, that the below code:
>>
>> 	x = A;
>> 	spin_lock();
>> 	spin_unlock();
>> 	spin_lock();
>> 	spin_unlock();
>> 	y = B;
>>
>> cannot reorder much than:
>>
>> 	spin_lock();
>> 	x = A;		<- this can't become visible later, that spin_unlock()
>> 	spin_unlock();
>> 	spin_lock();
>> 	y = B;		<- this can't become visible earlier, than spin_lock()
>> 	spin_unlock();
>>
>> Is there a problem?
> 
> The two stores will be ordered, but only at the strength of an
> smp_wmb(). The above construct does not imply smp_mb(). The difference
> is observable on real hardware (Power).

Ah, thanks.

But hopefully, smp_rmb() should be enough here.
