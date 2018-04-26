Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756748AbeDZQLv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:11:51 -0400
Received: from mail-he1eur01on0121.outbound.protection.outlook.com ([104.47.0.121]:45481
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756605AbeDZQLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:11:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 4/4] exit: Lockless iteration over task list in
 mm_update_next_owner()
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, mhocko@suse.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <152474046779.29458.5294808258041953930.stgit@localhost.localdomain>
 <20180426123542.GA819@andrea>
 <c21ad28c-cd23-2a75-6622-ba49c37137db@virtuozzo.com>
 <20180426152942.GA2737@andrea>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <21b98d67-9a8d-8c23-f55d-c324f67f4c86@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:11:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426152942.GA2737@andrea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0024.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::34) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:QSmo+T9hP/kI/rTgmCNiYzkbs836sg0lqgyulI89Ed91ZGfzpTrCGBXdH48Tib6cS4LknATVCnyS1gDuJaVVzonc15PiqeYlg3iID65yKMKh+3t5lkbzuORIPOg29Pvm+FoX0I8V5zeYWUmpYClz1RaRP5lXTAbjhF0FftQAqxXFptWx5yT8BysxN5+qyzDWtf+xCzADvdWOuQ7ssoWsbgZTurDrD9x1xnQwsgcRop6d2qHppK3t20hKElGCY4nh;25:F01tmyN6D5SsvYHxTlFkF5Ab4PfCzu3pmh1RPwT2R9Ew2V2BobxQC1zyKVsHm1NTBM/1jZU+rcEHqtVu00UNPKJ8HDfynJEANi/SXoizuFQk+i7ZoFxlgY/gQs3I63aKVwlLVY37ytdBqsEgqhoTIYNx3G9koSnM4c9Kt1aFn0ro6/HGtmO/XHv6GjEfZnFurSkuO+2DTWB0WtHSWbAbvrFkwlHh4w2dwJKpChAMjoXmGuZbzivrZBVU53cYOXz9Q03de/znJoMQ6s255XU/4WpwNUx7B1kk4WuHHlPM+ijebRtEgcymzaa4vcN6Gucaw+mYRxiJebo00QPsEiOzAw==;31:zCxVlyal+JeyhJZErs9L5AoPKFdqyDTKM6PirgyFiH1FsiEmvV92cP3feemNsK00dgVCvDC2CZUf9CtTDMkeOMH6SV1WZndAvFsBAlnHqgGoNTUzA1bFKQGsl1I5t9dUnWXt+maG7qtFcr+HmZpklPtQaefZXiH14ZKwsMUa9DeEMH6870HCy2nP/MfqgovVlLR/1r1aH5xC+VCqUBGUnUE1sFAyuzhKNFeRcVvq7pY=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:Q0T7/AsmdFuI+qAlB+2R6DeRoVk8nnmHdd15oZNENLDjd+Xse2gybtqit2ckmDxDsRoasqdyxFoU405mRQ66sMKVdQuLpU2nghlhAQpGZg9iupWh3skKq444WAQqNCZFg9ajbmtPMCByhENysGkCWnytVcCRC42rRJw3qqGHwXEdwLVUxvqTlc5jhJ/sCrBOwHOTZPNJRHD6irVAoWw2vba1cIhmF1mm42xRgVdFJr4ogKG2bQX3uF4fvpEGF+JpthqfVVS3piafKmDx08eAkqi8jsuz/dMTAfLez+dspHi3udtHbXp5DizrwSijDl0yjAyGvcNBTkdgPZM/PgQzdOmc5/pzRlAmhezoOvxJZ1SeJcB0E9Jj7rKERG7w/KE6/dA423T97xIsD/T1y43eXZO98OfXYR0rmBZQ/Nt3jQ6rahTF0sQJtyc/yngjHOkOFXvwaEf297sgIxTZEbZLSuLDu2OzYN8bjLzY/agYgF0y75R8GBDazkyLGCBHVsch;4:DIvrDCjU+VuwJ04hP+aAoHSo4yM85ZxIFdtx34sU+yUdmVcD0fxzDRMDGkehgHi3xwhBH74zl9LZRTPknw5GWYVVrjEpmauojBTa0Tj7IT56z32l6OJESomZj9uSRo/DbxZkeMMlbBoRXkbmjUuQhDs1qhzbnXiUOecqvfr7INXtrEnBzrsN9uz626XCnTt+R6qadzypL0jZ1gKcax08VcCAIl74MVRNoiw2a8N9XSCDR3wr2iPnP5PlGzOfyr8h6fd9ZYdqLnmohywn5v4M6sUBz1XgyDwaVSfEifEAUMGKRAYv6BrAlogjDiSdtEYfXlLLL9qKBrIt4gESAhsKLmr8FT6Y0c7cw7ANSWYKm6M=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13435CFB060E51ABB6CD97CCCD8E0@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(39850400004)(376002)(366004)(346002)(189003)(199004)(486006)(2486003)(31686004)(68736007)(25786009)(76176011)(4326008)(81156014)(81166006)(50466002)(52116002)(66066001)(31696002)(52146003)(23676004)(2906002)(65956001)(47776003)(65806001)(5660300001)(93886005)(16576012)(65826007)(8936002)(476003)(316002)(97736004)(58126008)(386003)(53546011)(966005)(305945005)(105586002)(478600001)(55236004)(59450400001)(325944009)(6486002)(106356001)(54906003)(26005)(77096007)(16526019)(6246003)(6116002)(186003)(7416002)(53936002)(6306002)(36756003)(3846002)(230700001)(2616005)(64126003)(229853002)(7736002)(575784001)(86362001)(6916009)(956004)(8676002)(11346002)(39060400002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:[172.16.45.234];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6azBIcU55ZVdVbHkwUHozZ3J0R1NSenlr?=
 =?utf-8?B?SUlDMWhrVE5IekJtaC9wajZ2bXF2dnJLQ0VScmZJOG1CZkN3RDEvemVYZmh3?=
 =?utf-8?B?Rk0xZVhkUWZ0VDJEeE5PQ2RMQXdiR2o0WGY0SEFiRExNSlJjMlF2Z3RPWWhm?=
 =?utf-8?B?dnRudmxjNVNQUno2elZYR0JIMFUwTDJ2RU1uVjN2dUw2ajdQR3VvVmpVQlli?=
 =?utf-8?B?RG82eG5FQWNOUHM3ZHVlV3pSeWx5Qk1xODZYMXFtQnRBR25OMW8xQ2wxWFpw?=
 =?utf-8?B?WGV6Skk2NTBYQmdSblJKZUp0U2puZHRJbElucDErOTR0NVZyWTNYMEVidmlM?=
 =?utf-8?B?VklIalhZQ1Zwb0JRRzF1S2k1bnpjcXFTcWdKcnZhbnZBeUxIaXN2Z0RlSXk0?=
 =?utf-8?B?d1dZVFJxdjZybmJyVmVTMTROVSt5RWFjeUpMSFpRcUtmbXB6b2ZwR0xKT2p5?=
 =?utf-8?B?MFVpbHR3ZWpvU2dob0lXWnBLZDM0ZVpPOUMxemoxSjJDeFVETW9MMFVHT2RJ?=
 =?utf-8?B?L1VuaXNYamdqWHZQakYrU1c5ZWZ1SmJwUXpnaGxzUUJRMFZyaVZ1OFllYjdn?=
 =?utf-8?B?cDhBd2MxTjlJZnI4K1UwUThoaFpxNzlnTkdzeEdHRXFVRXpsOXlrSktWbjUz?=
 =?utf-8?B?SGduR1hQblV5eDBkNXRQak5rTmRFYUk5c1pUY012TURKSmt4RmZFMTdYSWRO?=
 =?utf-8?B?bmpuUDNBdFcvRnB5YktUVlg4aUhqV0FaWXBPTjZEUkIvWGk0VHh6WUpBYm5F?=
 =?utf-8?B?SGh3aGo2cWUrWTJyV01XQkhtYTZjY1BueWlGVVFkeldvVm1FOHI4TVd5RXV5?=
 =?utf-8?B?M3k1UVZ2UXhxQXkreDlXMHZXWWtQUkl3anREZ29HdFgwVFdhOWpNRTB5SXFL?=
 =?utf-8?B?ak5XQWcyazMwVlQ2Y3M2RzBQaHk1QkJKVUVjSHBWTzdvdDNveXBhdisyU1ow?=
 =?utf-8?B?SVdEMG1UeDBWaVl2dDlIRVhJVHQ1TGpiaFo4NHpVbi8raU9pMmc1RCsvV0ZD?=
 =?utf-8?B?UlVrUEVjTDN6c01oZUdBZFJva0FOSFc1dTI3S0wvSVpGNEV0TU94aEkycWNX?=
 =?utf-8?B?SmxVSGxHWlpHSitMVHpDeVF6R1V5K0d3WkZxVkJzMHlvR3J3OXRZbGNIWU0r?=
 =?utf-8?B?OC9XRTI5NlNHL0VwbUZnMjEzcFdOUklLMEl3T3JnTncwVVhya1VCK1pSWXE1?=
 =?utf-8?B?M0prMnVOOE56ZEZVemZBbUhsZG4yWnFmS05QOUNDdVhSQU00cmdNSTVDQkpo?=
 =?utf-8?B?am1qYSt2ZG4vbTM1U0tEb3JYMS9ZMDJiMjlqaVFXTmMvWkFzcFhvS045aFJU?=
 =?utf-8?B?VkgrejBTcWl5eFRTTG43L2U2L2FtdFFGUzBjVDh0TUNxK095WFhhUld4RXpm?=
 =?utf-8?B?T3BuSXkvaUFOY0JmbmtUczdXUXlwNG40aGdhcDVGUEFDdksrZ0tTSG9icUwx?=
 =?utf-8?B?UlNpMFRHb2ZNRnAxS3hvNjZqN3lDYkxJZm9LeGVPajRsRzg1a1l2Vnd5Q1Ny?=
 =?utf-8?B?Vkd5ZUZDcFcxZ3lFZGwzek9vT1BqZE9OeHlmVWFXQnJkU05kOXlFSUtwL2NG?=
 =?utf-8?B?ajVFU3lGWFBubzFhSm5DaHhIbC9NM1FpZGJqUHNaMG5JcFNRMTEwUGVPZHlG?=
 =?utf-8?B?TFJXT2dKWjJiVWhBTnZPSDFVdHFYSnZUWGE5Y0hQaGRoRkcvdWhkZGVGcUtL?=
 =?utf-8?B?SlVCcGFQcnl6bTY1Q0oydEc5SWpYeG02NFVPdWVSNjZCcjdUTVU3a1Yxa3ZC?=
 =?utf-8?B?eHRuRWtXQnF1ZUpyYVpUR2hXWDUzS0IvVmNMa3F2QS9JSzRlV2UvVmxUUGRM?=
 =?utf-8?B?TTZBRjBRWURsVGVEa0l1SDlJQ0tJNnFmK1JIcGoyQkZKMkwzK2xRbGYwSGVC?=
 =?utf-8?B?QUNNQWRsNzlTRkhMVGppNjIwcTFHNXZEdS9HR0JzcUcwcDZIYkt2R29vWFRM?=
 =?utf-8?B?a2FPTG5CekdLYUpnOHlaaDcvd0dpOW5xTFBMeDYrMkpiaUNYRDRCQlRldGx0?=
 =?utf-8?B?Q044QlBuY0xKVGdzQXVBY3QxYzFCUHozdW5mZ0ZvTS9CVStQajNXd1hZakdl?=
 =?utf-8?B?aENJcjN4cDhlMURhUVJ4ck5JK0tVa2t1Skg3SzMwN2VEaVJ3Wk01aFNocmFx?=
 =?utf-8?B?T1p6ZU1EbXRlLytOZzIvRmloS1NER1VHSU5JQUU2bE5XZG9WMXZtRU1JWDRK?=
 =?utf-8?B?Ulkxa3hTdEpnSldQMVBFd20zdmFTdFE9PQ==?=
X-Microsoft-Antispam-Message-Info: du+KjArmdd6dIHhXiYq7qG5o9XWS0dFamuCemh/B0rE5xFk63YMc3vN20wjbVLWlpvvDrA+Lt3nrJESJtxSp9qQ+B9X1UvR+wO6ZvxMi7eiEEgai4U76JA5MMiXT7MI3vah4fN83DTp1tr/fZVL4hR5uSOMz3styfY4jdycAT2cKQWCckJijd9BzF0dhSiej
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:835/8Nq6i+Cd+j5TESV/ilthjorzwGbP73kd34va82lhXTGhwl8T7GIn5JJ7vhcYGK6OV3cNRQZNEvox2aczNDKsMrE4upyqSt1ciELrGX/tYmdLgoF2ClJAcG11ecBRvAxyG+SQFFGNhrQQokoaJ5ifIlbzPXTRQzeEEqMUZPGdyoZzw9HlL168fBbr0X2pOygN4+gV0jONmO6HV1B7hJw8rvc5882N5Bx20jS1eXCzBREko6G1Sq/R2/oSEvoWoNmhfThXUBi8Dn9soHZX1DQdlE5B67JbDN6LJ1KkP7Se2++STUJlKpPdyEb5VLlqDzaE/q3tcAf6D7tO/8Egt7S5GCgjcRCuPukmdBYcLavSjnl5DWLamNkJaRH2QQMjgeQpgyo6bozinHt8Iu/ZUi57+4+QUs8mTc+LlzuestdT7BXTM4ds0Vg74GWbn+O8tzK03qdhy02nSb1Y98jqTA==;5:rBU6fa8XoZ1fmdsntvzYrYhYhSlqz1WlXHc9PhKRkGvEPs3HGgVkaR0h/bnacyKLxAJ6x3Jv3xVKydxXG8wvg6vYtrved3fl7xJxbguEmv79iqqyFQYkC/LvgcagIdzI/H6cVjrfcFgKd/liiv3hxaVIqrEGYPahPK7QpMT5Zg4=;24:b/rS1W/7JSIHoU3peZFWKe+3NnQJj8RtzGvD0WyoSrC5LJVftkikEZw8k8YTsmsjC5LTQDXbAaoHVWIjM1Hg9Tl4EpFzA07v6ar+b46mw10=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:MKZu7A+B0VA+f9L5clVpMk4NKvLwownpEtKXfAlecxncJ8wWPJYLVezjp4yptx6y0DOB8fTudorBMBmqes1jF7PurTvsP7qnfWy83tTZTPuVwo7IXQ500JkBTK9/XCGxX0H/DRoZXOe6tJ3eUNEVycc7X5zziRHyVB38O5fofafJrPqskpRkvncf3a9nbZjcAJtOVBeGafdSmNMNI0BVnu9+GggY5qVHss0RzQfuhKkOqjTFEXn3hA84yIu8hQnE;20:DT1G62v5bgzwvywnOl+Y2Kx/+KTvJQyvCMk3f/n8U5BmDPaHaWqUynsw8ccTvPUhqOE24pCkNV2BrOlqx4opPQSLtZNcePdjSswJSkPee40n79YpxeXmqSJVAs5sHesX8qOlh9D2hvtniCtn+bbyV1XifFv5pWo7/JQZ6eKk1hY=
X-MS-Office365-Filtering-Correlation-Id: 421d10e9-04e0-46e6-3266-08d5ab9068bf
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 16:11:44.6449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421d10e9-04e0-46e6-3266-08d5ab9068bf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.2018 18:29, Andrea Parri wrote:
> On Thu, Apr 26, 2018 at 04:52:39PM +0300, Kirill Tkhai wrote:
>> On 26.04.2018 15:35, Andrea Parri wrote:
> 
> [...]
> 
>>>
>>> Mmh, it's possible that I am misunderstanding this statement but it does
>>> not seem quite correct to me; a counter-example would be provided by the
>>> test at "tools/memory-model/litmus-tests/SB+mbonceonces.litmus" (replace
>>> either of the smp_mb() with the sequence:
>>>
>>>    spin_lock(s); spin_unlock(s); spin_lock(s); spin_unlock(s); ).
>>>
>>> BTW, your commit message suggests that your case would work with "imply
>>> an smp_wmb()".  This implication should hold "w.r.t. current implementa-
>>> tions".  We (LKMM people) discussed changes to the LKMM to make it hold
>>> in LKMM but such changes are still in our TODO list as of today...
>>
>> I'm not close to LKMM, so the test you referenced is not clear for me.
> 
> The test could be concisely described by:
> 
>    {initially: x=y=0; }
> 
>    Thread0	Thread1
> 
>    x = 1;	y = 1;
>    MB		MB
>    r0 = y;	r1 = x;
> 
>    Can r0,r1 be both 0 after joining?
> 
> The answer to the question is -No-; however, if you replaced any of the
> MB with the locking sequence described above, then the answer is -Yes-:
> full fences on both sides are required to forbid that state and this is
> something that the locking sequences won't be able to provide (think at
> the implementation of these primitives for powerpc, for example).

Ah, I see, thanks for clarifying this.
 
>> Does LKMM show the real hardware behavior? Or there are added the most
>> cases, and work is still in progress?
> 
> Very roughly speaking, LKMM is an "envelope" of the underlying hardware
> memory models/architectures supported by the Linux kernel which in turn
> may not coincide with the observable behavior on a given implementation
> /processor of that architecture.  Also, LKMM doesn't aim to be a "tight"
> envelope.  I'd refer to the documentation within "tools/memory-model/";
> please let me know if I can provide further info.
> 
> 
>>
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
> As mentioned in the previous email, if smp_wmb() is what you're looking
> for then this should be fine (considering current implementations; LKMM
> will likely be there soon...).
> 
> BTW, the behavior in question has been recently discussed on the list;
> c.f., for example, the test "unlock-lock-write-ordering" described in:
> 
>   http://lkml.kernel.org/r/1519301990-11766-1-git-send-email-parri.andrea@gmail.com
> 
> as well as
> 
>   0123f4d76ca63b7b895f40089be0ce4809e392d8
>   ("riscv/spinlock: Strengthen implementations with fences")
> 
>   Andrea

Yes, I'm looking for smp_wmb(). Read barrier is not required there.

Thanks for referring this.

Kirill
