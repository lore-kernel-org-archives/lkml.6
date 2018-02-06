Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeBFPGu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:06:50 -0500
Received: from mail-ve1eur01on0097.outbound.protection.outlook.com ([104.47.1.97]:33376
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752037AbeBFPGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:06:41 -0500
Subject: Re: [PATCH 1/2] rcu: Transform kfree_rcu() into kvfree_rcu()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
 <151791238553.5994.4933976056810745303.stgit@localhost.localdomain>
 <20180206093451.0de5ceeb@gandalf.local.home>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <52fe3917-cf72-d512-8422-d53bacf40113@virtuozzo.com>
Date: Tue, 6 Feb 2018 18:06:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206093451.0de5ceeb@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6PR1001CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:55::19) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be0ea72-f068-4eac-9d5b-08d56d733847
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:Q2/WCQB9GipRiM/81IxZ4Miwflg3oxfZDhQ7e6154m4R6U9E7OjpWbDCRx5sjeXMJlRuKHnGDP/O73yLQIT+YWHzRWc/kaBsfpRCYzxrME4n/BY3ru4xxE0b4ePKYYhMqZnRQRo9KPEvhQpWzby3ME6b6iYUy+F41GxkNuOIHP7vW36XLNMzSlBSJySjh/OL7BrKgl+NgI6XDU26WtYeTJrsSoecrtk3ZivuiJ+xdnlMNUKZmflpaf7a8VuFxrf3;25:ZTZNHhTK/zdGmowiaJK2HFesxl/UPliEBrXoPM+13yYxu0mkhLUi9Z+xVhetyhdFneCCg+1INNpZRxgP/rrJNfSYO3+SoLzKT7JQCusAS5q9qQ2yw0jtuXB09htFeRX/xEljSQPrDANaCVa2yRzr8mUGzBqvBrxWQ4CFYbSAUPfLvZBXt2E/US5t4umvrZY59DrxYZnOAN1vHp4eMluE1oMfkaQqQB217lXcKeHyxZsBlyJ9aOnfzS7o4VvzTEETUALoQJ+Y51vSQU5u+gw/UjhfroIlBpr+wZ3Vgrpd3Ja5LkDhOFoPLK/srnun3SdA7BNLxDltIAuKBHiO5V/lzA==;31:ZmhRjUrTKRkk8he3BrzCVpkkq50Duy9qKD3OxOtk+ZmD4wF3Ul/CKlGywIIpGUB1ymG0CxCQ4YonXKs2At8BY5ljzzk92utXaq7BKvJDcNmbPBqfaKHtaOH5IJL42i3gn0elm1ykWXTk+XZ9b7VniL/yyXbEmFTVJ5xZ91Rn5+kvGw74Y+BWdn1WkvO45tVsU1CiJshg5RJyjFd3fFExpBL6jyD7SVmqJN6fzq0AuVU=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:XH1apU+qgF3CBWwaUzsDoc8SwSf4RRP93jRFoTe2gH///xMcGElRVFL+IIE4USIUkGurA+Yq4IUMvnJaNZdA0yPS0udMqC4JSay/IhxzxeTTNGbQI3rB1ZY02vQ95pFtwQ8OwngWtWxCojygZ6MLfOiJLz8CZ47WVTf2jZr65CvG3lJVOf0kU8nmlWdwTaeB/wmtxno8wmO8/QVFy/TS7o62xGW09x+HdmRjqzYu7XXs2VXfIwwpIJ+XiPntLBwJkDmDwqzqlxSrgtB02M3EwJP5CHab77L90nAJAd1VPrkvIBNA31vyz6qxghIQspDMa2FO+nYbe3/hBnlyVEYrJLJ+Q/qpnDqaUcJvGlXBDFDp4WVgVGibqYsebE6KBZiB3XNGiA0Um4xjYeQ/PP4YcUqc71IWLrgg3EOlkpHTzsw=;4:/2J1Yx9t1y2FmXfH73cgPa0mibewD9ICikBj2vd3JK3JiPKVB/WGcLT5t4TjrPnDTiUumiXSObXzMhUd/FZ1/eoTA2HH4ln1UkEhDZftEgzZf9VwN+M2z8QF/T1wo0QW7MpIix7I7gHWe3sb6MYuDrIQfL+W6nOx8NJX3rL4qfPKIMVN1RSekUfxZJqY1yInkfT5kJcpiwj6DIc8XZkTUqM5s3dJMy5gTTeBFM0UYS65TQEQ52lydgm32lPUgb/gptwlzFhRrCcUNZzsk1lJag==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1332D433DBA7E7979AB6E707CDFD0@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6041288)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 0575F81B58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(39840400004)(346002)(396003)(376002)(199004)(189003)(5660300001)(478600001)(65826007)(6666003)(2950100002)(86362001)(2906002)(105586002)(230700001)(52146003)(23676004)(6916009)(16576012)(58126008)(2486003)(76176011)(316002)(6116002)(3846002)(59450400001)(386003)(39060400002)(83506002)(52116002)(53546011)(186003)(77096007)(25786009)(16526019)(7736002)(66066001)(65956001)(65806001)(31686004)(47776003)(6486002)(305945005)(106356001)(55236004)(7416002)(4326008)(26005)(6346003)(8936002)(50466002)(81156014)(8676002)(36756003)(68736007)(81166006)(64126003)(229853002)(97736004)(53936002)(31696002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6VVRvY2RNNU5JWElxM1pUbWliMVZrSEN3?=
 =?utf-8?B?ci9GdmZyY1pRak1ITWQ0MSszUWVrVndvQzIwZHNUZ0NOazlST3p2MWZwREVr?=
 =?utf-8?B?cGJsWTdKS2l3UjJIU1hDaGpiVkN0QkVJZlByT3BQSmI3VkdIS2NkUzVKdU5O?=
 =?utf-8?B?WjlINm81dnN5enpkTWNiYm8xM1FFWSs0RVdYaFJSOWc1TExKeHVZQUkyVG9R?=
 =?utf-8?B?WEQzZXRZSzRzODB1dWJrNFNmWHMvbXBwS0JNMWtKcmk4Y1Bab0NkOGpoV2dt?=
 =?utf-8?B?bkR4V01wNDZhdEgyOUlDUkJOMXJxWW1YdVVLWU8zMVNlRkJkdXIxODhZQkpP?=
 =?utf-8?B?bms1R1A2ejNsUTRPanE2S2tHNkhYMlJsdWIvMGVraFNMQllhTi9vTVhxWjc5?=
 =?utf-8?B?bkkzVm1yU0oySnhpbTNJdm9mV3N2NnBxODEzaFhaWjcrcVN4T3FxbU42UnVs?=
 =?utf-8?B?QjI4a1BBYVR1S3RHVERSVjZZWUg2MnpVZXRyOGZiZy9PeVdHcHNRRW91WGVs?=
 =?utf-8?B?bG0vRXhFOWFPRm14a1Z0NWIzbW9FVEJpN01EZXBNeUhRQlRMeFhzdG5mOUht?=
 =?utf-8?B?TWErcy9ub25VVU1wa1BsY1BVZW5LU011dGJ0WWlpL0xBSTk1TXFqYTV4a2ZQ?=
 =?utf-8?B?STY1M0tuVnhMSGRmSiszTTFKNDhUdTBsY3Roa2E5RUtnMlhueGVwekVLaFFJ?=
 =?utf-8?B?dzMwdE9HWW1OeFVCVmtGVmdiR2ZpNUgyZGpQY2JtZ2ZmM3RUTzVxQ1AxVkNT?=
 =?utf-8?B?RGZEVkVnaWJGU2dlV21sT2dLdndSaEgrSXF2d1F5RFBBQ1pnYkVJRkxRMEZx?=
 =?utf-8?B?M3RxT1dHdnpKUVdxbjFwK0RxZlZ2NHJ2RE9LRVRqOXFlbGREaCtwQVlleDdI?=
 =?utf-8?B?TjBwSTI3V1Q0cFlWQlVPZTc4c1JURVNKLzFQa20rUkVsRVZockhBaG9CNzUz?=
 =?utf-8?B?SzROcU5kY1ZZd1FKMS9zbTdUYy9RNGExbTZCNEhGcDVmcTlObHZIQlRwTmds?=
 =?utf-8?B?UlRxRkxhOHE3ZGk5aXFTUC9GZFVJZzNnNEtRTVQrOXQzSGl2VVJtd1NaZE5B?=
 =?utf-8?B?bUxiYWFhWmszMXcyU0ZkUlF1SHFKS0NXUzByMHFPMDNhK3hiRnZoU0g1UTdX?=
 =?utf-8?B?MmV3TnJ2Q0k5L0grTkorRGNEbnBjRmkvUjF4SmZQT2pCaE9nYXM0QVB6YlN4?=
 =?utf-8?B?cG1uck5ENTJmTEx2anIraUJyQlFsZWZncXpNTVB6bGxubElHbW9JWVE0RUVz?=
 =?utf-8?B?U0s5bnNkU3ZHQ2MwVVhQaFBJMjdHbVFRZUYvV3QwYktnc1J0QTlLUEFMS0t1?=
 =?utf-8?B?YmR1aC9hcmhqU09WbjJmRjRXWG4rd3FsUk80eGdXSWVCdEdmeUhTZi9zZVFD?=
 =?utf-8?B?TW9iWUUrQ1hRZ01TdXlrSitCQmN3Q3E2MU0rakJSdEtzS0VFWkd2YVhTK1Rm?=
 =?utf-8?B?bGk2ZjdWN3AxalVyQkY1Uy83dUJUR3JENEJwZG5pc0Rlc3o5dWVvMlB5QmVY?=
 =?utf-8?B?TDhqZlU4Q2ovZWNKTUpoTWFncVJ5RzJsV3BOcnprdXBRZzVxT0JXT29PVzUw?=
 =?utf-8?B?R1h5dXQwVE8xeUl0WFBoejd6eXd5di90QXg5RDRML3pjYjdXa216a1Q2NkxH?=
 =?utf-8?B?Y0JZbnpxL3IrWk84UHVPMFhpSEV5RGIwMVBaSzRjZ2lxb3JVYStENUVtWjlW?=
 =?utf-8?B?ZUVVSU1pc05WSGxCcHdzSXc0V2RXM0dBUlpTOTJVTHg1NjEyZDdBQjhvd1RE?=
 =?utf-8?B?TkdoNUJDYlZBbktVOGFVenNyaUd5VzU5OWNkd0FKcXBTT1V4azN5RTZmajBO?=
 =?utf-8?B?TGlWSit4bEs0MzZGMHhnanNkOE9YSDNXTEhLV05vcFgySnNyMTl2Y2FQenIy?=
 =?utf-8?B?ZTRqd2JCUnZDUkZjeS93bmNXOUZTSGljaXgzdmJrb0k0czBDaDlnVXJQelps?=
 =?utf-8?B?L2VXZVRlU3hVS1JhMW5hanNTTmFJTVJFeVFuYlVYWHVHZStZSGowQ0paV2pu?=
 =?utf-8?Q?H/btmb0H?=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:npNlMD4/NYSraHMTBQPIQbpADlVxXsDuZhLQqMEi0aYriby7EmJ3aJ7GYkJVbxbD8CCfmlI5oqudzkHaXHXT8lyh3tYX/tvOKykQXJuqznooq4p1IITN3hMGK3cEbTBZqKso/1nZFSuEsq5hNalr6jPYTpevnOM/3KE+TpUisF/W52rvSRm6EMSSaAUIGiqaMT++cbRU6sEl3XvQj0cbFbANj00X/s2SZK6/WH0xag65lLgR7+PaiCeGTSaySSTdxvWhwfGaPP6ECtv2dMkhhoMNgQp17F9DpLeu2jb75ljfrCI/NxVkyOug9yEP5oqVBSVQui8swCGsdNFJnherFHH9QEXsqG+DNwyMzhLen5U=;5:sUIsL7v45TjEaTExczaGoN8n9p36KHQGmRfb7F3yv6HrvAE60c2QFqLh33S5dsLcRM4T4y/jBfEx614YyhS6qfT1BOA0oOROwuCMzewt/Q+uDCvaq6dDlp4J35aGr8F1kF9CpOmzb+8VKWr+n2pgh4SxUO8Yyrv9SqbrO9vHCo8=;24:blVChFu1NGlfu36G71kL4bWoxwVXN+KjQOvrUHIB0Gov/gj9U/fUgw0qIO5MEFNdAdrm3V1s+7kCOAtTWV5pCQVRu0QzCaimj1SqS7wNYPI=;7:AdGBvBWIJF6YD65Co0ppo0dFe3JgnDAOqmQqwd+K15emU2PqRyAF9sJ3BXJTqhwxMQV1p5u67WjxGnA6c96GsAVbUpyKQAU7CMaImsYJ5n9NT8eb+tS1FZ0TkDXVmIaHAf1vCQu5vgtRyC0MMjYTaJzOtQeZzVtXD9EXWdatub+ydIXV0c5XMVkWcJxrsyWymkoLLLHbTg9rSTNC/CQU8oVtb22MQz5njxB9gDFxM2Drs4vyJ647FiSr5B+inzXw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:I+MjxkOp9WMW8tMNsUQ9G3UtzMDZmY7gyNE63nCRcoeWlh8CQB2Mlc9f/wRwAmeHCgm+vZxZoTWqj4GXcy4WhCppw9g3ftUXUOPy4edl5Lu0sv6SJ+qvotkz3NzNNXIueObRDbc1kntK/RX032AoTVcNQ61inwtvEM7iAsoJGu4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 15:06:36.2864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be0ea72-f068-4eac-9d5b-08d56d733847
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.2018 17:34, Steven Rostedt wrote:
> On Tue, 06 Feb 2018 13:19:45 +0300
> Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> /**
>> - * kfree_rcu() - kfree an object after a grace period.
>> - * @ptr:	pointer to kfree
>> + * kvfree_rcu() - kvfree an object after a grace period.
>> + * @ptr:	pointer to kvfree
>>   * @rcu_head:	the name of the struct rcu_head within the type of @ptr.
>>   *
> 
> You may want to add a big comment here that states this works for both
> free vmalloc and kmalloc data. Because if I saw this, I would think it
> only works for vmalloc, and start implementing a custom one for kmalloc
> data.

There are kfree_rcu() and vfree_rcu() defined below, and they will give
compilation error if someone tries to implement one more primitive with
the same name.

We may add a comment, but I'm not sure it will be good if people will use
unpaired brackets like:

	obj = kmalloc(..)
	kvfree_rcu(obj,..)

after they read such a commentary that it works for both vmalloc and kmalloc.
After this unpaired behavior distribute over the kernel, we won't be able
to implement some debug on top of this defines (I'm not sure it will be really
need in the future, but anyway).

Though, we may add a comment forcing use of paired bracket. Something like:

/**
  * kvfree_rcu() - kvfree an object after a grace period.
    This is a primitive for objects allocated via kvmalloc*() family primitives.
    Do not use it to free kmalloc() and vmalloc() allocated objects, use kfree_rcu()
    and vfree_rcu() wrappers instead.

How are you about this?

Kirill

>> - * Many rcu callbacks functions just call kfree() on the base structure.
>> + * Many rcu callbacks functions just call kvfree() on the base structure.
>>   * These functions are trivial, but their size adds up, and furthermore
>>   * when they are used in a kernel module, that module must invoke the
>>   * high-latency rcu_barrier() function at module-unload time.
>>   *
>> - * The kfree_rcu() function handles this issue.  Rather than encoding a
>> - * function address in the embedded rcu_head structure, kfree_rcu() instead
>> + * The kvfree_rcu() function handles this issue.  Rather than encoding a
>> + * function address in the embedded rcu_head structure, kvfree_rcu() instead
>>   * encodes the offset of the rcu_head structure within the base structure.
>>   * Because the functions are not allowed in the low-order 4096 bytes of
>>   * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
>>   * If the offset is larger than 4095 bytes, a compile-time error will
>> - * be generated in __kfree_rcu().  If this error is triggered, you can
>> + * be generated in __kvfree_rcu().  If this error is triggered, you can
>>   * either fall back to use of call_rcu() or rearrange the structure to
>>   * position the rcu_head structure into the first 4096 bytes.
>>   *
>> @@ -871,9 +871,12 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>>   * The BUILD_BUG_ON check must not involve any function calls, hence the
>>   * checks are done in macros here.
>>   */
>> -#define kfree_rcu(ptr, rcu_head)					\
>> -	__kfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
>> +#define kvfree_rcu(ptr, rcu_head)					\
>> +	__kvfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
>>  
>> +#define kfree_rcu(ptr, rcu_head) kvfree_rcu(ptr, rcu_head)
>> +
>> +#define vfree_rcu(ptr, rcu_head) kvfree_rcu(ptr, rcu_head)
>>  
>>  /*
>>   * Place this after a lock-acquisition primitive to guarantee that
>> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
>> index ce9beec35e34..2e484aaa534f 100644
>> --- a/include/linux/rcutiny.h
>> +++ b/include/linux/rcutiny.h
>> @@ -84,8 +84,8 @@ static inline void synchronize_sched_expedited(void)
>>  	synchronize_sched();
>>  }
>>  
>> -static inline void kfree_call_rcu(struct rcu_head *head,
>> -				  rcu_callback_t func)
>> +static inline void kvfree_call_rcu(struct rcu_head *head,
>> +				   rcu_callback_t func)
>>  {
>>  	call_rcu(head, func);
>>  }
