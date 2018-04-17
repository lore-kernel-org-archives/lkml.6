Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeDQOPx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:15:53 -0400
Received: from mail-eopbgr30107.outbound.protection.outlook.com ([40.107.3.107]:15771
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752273AbeDQOPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:15:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
To: Matthew Wilcox <willy@infradead.org>
Cc: jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, peterz@infradead.org,
        mingo@redhat.com
References: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
 <20180417140110.GB21954@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3518b26a-2a81-1fb6-e01d-8d0b06eb0ad3@virtuozzo.com>
Date: Tue, 17 Apr 2018 17:15:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417140110.GB21954@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0192.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::16) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:pcwXfi6DBZKwvwTWWugOrCG+SaCpl0cdGQAxasaFXxX9XxHfq35sHR+6WnzVJ1qiewRKCGpss7V6RxnO8ByRWGbGhgyYV1vQSBaJRfN5DvEK1HCEVQIpOwhCat8OJ+zANcIrIaedMUD+n0Q7jETorL0BW/etevW7zh21saTDwbOzLX373bx3lapwVMj0SxRkuQ6JN4rYmoH0nPGGaHChMPZ06yrDdnwRblZxaSAzicjceHtqsDZkDID0+JQdr1/9;25:nJDamtCltU7vl2TXQOYQHEp4oxWZj6hUR27AliJaLUOzWVnuZYpvA602virJL/9H+c/Uassly5QdlQZsHjAlVYhbn0JY++7dcSvdB+09oDd3FG+vCzMxoBPt82RMwWYYqm/LpeApVsSgGQ7fLUO/SxIDzpLGLdLaVu6DCYtw2hLGAdYJ6Fni2tjkOLLD1e39V59mVnK7n20rECLAOp2kVlOPG5bUhUdepMEmqw7w6FglspxDNeFvJyD9a4o4rTyxwBcLUnvv4ZswaG9O3FEvZ0ig71pSgFNsqCui/rHgdtJ85ksudBf5xJVWCRqLp9XTxc0UnbbGywwjcmNo9uYH/g==;31:NfvOfxURa+ouRe596Nsrcr6Wm+Z7aKViXL1U7/CNN9lXGara0uNqG/52UPJITKKxFxWsvI7NqIDg2OohZg6Dvr+epMFo7SWeYJncTnWegddyTQ9G+erFWC2+AXezzCUCkpYnI2AXUO+e5OqKMCx+m4PI3SoMDqkMrBhhl/6DrJb3gIzsxCxbE+i6RWGvb+9zzXVv2fhUGR1akGWbrLmnZtUeNvrHQLOnjJLQVlT35a4=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:pheyS51CezbadU36W7GZiU+ytfrfoJnMJ45KxWJdPgc5ET89LWUU6IyroH7AZ0U7IZXQPK8cYeGKPnaHtUuJJ8L2V/xobeE3A2eKVkF5J5o0xNx7yhZTUn6L5zlwBMD9SyFUnb4PVVj5ZxWahbck/Q+a0CLm0hMSYabDgHxDawA3qVfzMCbjGC4+7YrTB5nw1+b9AulOxB+nFaDB/Fmscl9jZuhPjZ6jHIk8MW119XCR902Uc4ixORcbKju7iJfgkP+OdpvX8NuD+S5ouF0XwlGqKF+UL6XL3kpKRkNUhKU50yoiayYdC7uyOvKT4+idHYqQVaQXDtpiJXI4yYw8pMrczPliKzsu/N9Qpu+SinhKn7oG04Ofzi727K9Z+LRLq1WUDk5QDPlO0GtHie6OzQI8x+rs5L9F16QvXGKQYGJr2MSXYhf0bmZWvfZfwhLDhQethExGPe4KUYsCweZEdeH1vtIP2bH9ryjr7AxmPt4HYysMip6AmGH4PJNiD67x;4:tfCQQaIhXnZY/YSyvlq5MJhzWIT+pT0g18oXmy0iIrMy1qjAXA1IsDMhbZWQz8nk6gY5qoWpDo/fKW5yL2CyZQw6el579cLYiTtzfuFDKFx8EKD9elWGxn9R2e0oHWWcGZM2iM/h891jwwCONciUbDwWPksDqsF9+Lx3Rjqw8jwhWfDbXiGcA/qbkLgV1MidEV+s9ZvTCh9dsm97V48zeIe0ox/6++H7rtBctuP8qhtAFsZ7YTK9m7V3xI8vWfcOj8TWRzGnNBulg6RZUVufdw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1335A06E9D6ADA673CCD6757CDB70@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(366004)(39850400004)(346002)(39380400002)(396003)(189003)(199004)(50466002)(31686004)(7416002)(305945005)(5660300001)(7736002)(478600001)(6486002)(229853002)(105586002)(2906002)(64126003)(4326008)(106356001)(6246003)(39060400002)(53936002)(36756003)(25786009)(8676002)(6916009)(68736007)(6666003)(81166006)(97736004)(81156014)(55236004)(230700001)(77096007)(8936002)(66066001)(65806001)(65956001)(47776003)(52116002)(186003)(59450400001)(53546011)(26005)(386003)(76176011)(16526019)(86362001)(23676004)(52146003)(2486003)(31696002)(65826007)(446003)(11346002)(486006)(316002)(2616005)(476003)(3846002)(956004)(58126008)(16576012)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6Y0xaYjI2Y0lBVlh6anc3WlpLZUdRd1I3?=
 =?utf-8?B?d29hcE8xMjlrYTREWmljQmk1UTJCR1ZCbDlWWmJrSnJEVVJUM0Z4ZVFMNjMv?=
 =?utf-8?B?Y29UYXA2M3hZY1ZlMGNKMUZUZm9HUURpYnNiQ0NKY0VvQzVTOERuUEEycGFL?=
 =?utf-8?B?TDNjZTlKeGg3eXMxb1BEMmlUVlJ1elFtZUlhckI0Zm92WFFCNTBGeEl3RWJX?=
 =?utf-8?B?a0k4ajRDR0FnZ2FqZDhmV3hmcjVFTFN5MEdFTmc1eUhjSkYzcXczOGJMY21J?=
 =?utf-8?B?Q3U1czZCdi9xYXFreUtCNkZ3U2cvc3RrOHA2ZGowN2FQS2Y0d1Q2VTJXQ2JS?=
 =?utf-8?B?a0xNbDhzTUhKU2kvZ1U4ZEZCMjIrS01QRjlpdmhCSm1qR0dNajdGUWdqTTcw?=
 =?utf-8?B?YUVNdnJSTUpQbmN5U0JIbXRzeW16T2lmN2pMQ0RDZHdVYXlSVXgxSU1RQSs2?=
 =?utf-8?B?L0U0ZEpkVU56SmxjNm9uTStVNkxwZ3YwWVlBYVV5dCsrcnByQnFLNGdPdFJD?=
 =?utf-8?B?aWRkSmZOeGVIWnkyNWRlU3dMS3pFOThPWEZTWkpDYXl4WGxxa2Z6dmtVWFBo?=
 =?utf-8?B?bGRVclMzUVE4TFlRT1c1VnJxS3ErdnR1ZzNxMTRFNWhWcUxGRElGME94Qnhu?=
 =?utf-8?B?ekxidXp2RDFOdkJwODgva1A5V3VJMHh2VlFhSEo1MXZlVk1XcnZNenNPdzJu?=
 =?utf-8?B?TEdmQUt5SjYva2tVeCt5SUdmbk5GZ0dCT0g2Z2dhZEo5ZGgvL3F6eGt2K1FX?=
 =?utf-8?B?Tm9hNnhPSFJ0R0UxVkxXZlRHY1BpaTNtaVVuK2VGeTJsWTBSMFg1RW5oNzRw?=
 =?utf-8?B?V1dhRFlZaTI2WVdmRXBCVklGVC9MMEo2Y2Z3NDdnWUxRWkptd254QmRsSzBi?=
 =?utf-8?B?OThaV0JOd3pQeitoUllERGpKK1JjaS9NbzhJNXlwZ1RDdVNMWWhWVUw4Q21L?=
 =?utf-8?B?V0sya3pvR1RTQzA4U21aN1VWempSbEdsTmhNUGVXcnRLVkhuVkNmWjYxZk5R?=
 =?utf-8?B?VEtNOWVyVnkxbzNPZ3VON2ZFaytMWjBHVm5QZU0yVHBQYWc2UVhvVk9xbVBm?=
 =?utf-8?B?bUdabHRkZDYyaS9jcldkNnRPTThxT1F1OVNjL09RbFk4VS9hNklpc2owdUIy?=
 =?utf-8?B?bldPOUJHS3BkS01YWUlyWWRmL0pSYmZSWFBOdEpYT2dyelUvTUtzT1g5dlg4?=
 =?utf-8?B?eXBTZWVQVzRqN3lNQi8rUzcxMzdYaWc5Um9vcWI0T2ZHb3ZxLzZlbEFjaHlG?=
 =?utf-8?B?UkxVYzBaYVR4a1NqdU8rZnhOazNmR1lPUDBaRys3M21zM2hwUjFMZWNaZzgz?=
 =?utf-8?B?L3YwRkNlaUFmdlRXVXpVQ09PQk5ETUdaU04wWlBpbk5TZjd5MXE3ZWJ0S2JS?=
 =?utf-8?B?SEZEMGovV2FZWjNzYmthVmxxRWZIWTdkQVQ3SXVwclcvTGlQNzY4SjkyMUNa?=
 =?utf-8?B?b3UyK1hmbTFnRC8zU1ZFZXhFVkJ4dko5M1V6ck8rSVArRDl2S2QwNFdQblZJ?=
 =?utf-8?B?RVAxVmFMQXhaZFR3WlVZNC8xMnAvSnlxSEhYYm4rYnlmZExZRGMvNHRRRjZW?=
 =?utf-8?B?SWdpNmZ3VTVrT2c2eStsOXZKbFRENlBjMDFOcytaRWtjZVEzKzBJN3VqTVcy?=
 =?utf-8?B?TnBDMzhLNWpqa1NQWWxHVWthaE9BRU9XTDhqUG91Z2RhZUZ6QmJSQXVNZFFn?=
 =?utf-8?B?QXVxK1gzN3FFamJta09zSUVuQ2Q2VXZPZTNJVW00Vmppb1diZ2cyOVZHZDBR?=
 =?utf-8?B?QVMrM3ZGbFVJSDNiZ2pIMHRjOG0wRkpIdjhUdVVSbXVjQjArU3Q0NStBazYr?=
 =?utf-8?B?ZkZaRk9hMkxMWXZKdmxBVjNQa1RVS0Q3WXQzWUp0TFo4aW9KTEZmQ3BsRlkr?=
 =?utf-8?B?VVY5R21sYkNkZDhFVkhnRXRjekt3TjJWek55V0paTnJkRVJSSnNFL0ZkWXdE?=
 =?utf-8?B?R3FjaURWdGdTNnlQVjJsZGhiNlpDSU1kM1hVR2FjYVYyZkl5Ry9IMTVtYmh1?=
 =?utf-8?B?OXBrM0hZVDJiaEtTRGkzbzNHMVVIYWU2RUQ5a01tUVZ2c3M5MXJzTW55cUVo?=
 =?utf-8?Q?6ptwS8=3D?=
X-Microsoft-Antispam-Message-Info: 3lsKw06jonVHOVX3rfw/VaMmbrsDjrj5k44BKcLkOMtM7uwKza7HxeYeatoAI4uyj+gGLlmzmJCqDjdBwwYZ6u70Q4WXu7XLoGC4BdV6ATTxM3hzcKeZkpoSqM7k7xLnygRJ93l/Mzk3l96cPwdDM5/lHYozZtZ+czRJP/FAxVsDkICpOD9k+Nq5cFzOYahQ
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:JWa4qs1kKsGqPmXDHNYnmSnx5DU9xFrEnZG34be+MY7FESE1wpA+v8GJr4zy3Wt8vOqUPM/VPgUqOfGcVq+hYzVtyTsNQ0dKF9HNXblZ1RE/LfdOZL7G2r+8eQzqQe7fib68b7W//SqdafmKbulooL2+r+F5GEJfSm0TeBl7Gxwx68rokMIiC/68l6vzzaoOfplAVMmM2uwc/1nCX5GyaiuxvZqmDh63puzWLilwi4w2xPCObHAqEfF2ecjDRmFlAfvqpbydLrcWuCsFu+df8AP5pnOS5vaR1dFUJH5oSwPIssEpG+ihRVzKSEiiuSNjUOdiDJ7SOiM0GD3tNU4kXygykVKFfT6bVFTKT8hIIm5uI6b0ONQhSObdK//9ef+dFtq+Oawkn5uFt1Fzw8j+LGqIW2f23mPN1SuABVX7kZjwtimr/qgngqX8YQ+QWZVwuskpv4L600I7hyboWo2J7A==;5:vDZ3U46ShgKNhIqWm4FTCsazkpe6hfJ391GJAPfggt8qTfAyVzlaqDtZ/phq4jve6kfBy5dDWhxd+1OGtxduGaJ1XP01Fov1yKzhzk/u6gDO2Z1erGB5GqOLNv3H1/dt8qTwax6tv72LGxDjmoj2p4wsZxGGzG0A56O1nKvn96w=;24:OZMTwC5Btm9cmQHcio38jpaQSWgXGMjM/P0eH5WSB8Q4aAiwaQ5YhKqWggOwaXQLiNlOXGtEF3pJ+DtDYgv4u7iMfvRm3VtXMALsbp8D5Xw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:vSXcRmVw5ep9H8EzfwH7vzfQ3nQDz4dFiRCBRAdG/YaMO15rlc5LSYNRdO7bAw9prmpxCFGGYXitaw33tO4oHkaJOb9+c+O5Xmjzjyd04oVyovZmfnORWsmmEd2ek45d696BaFzmePp5dbUTfCT3D/ira+NnwVE4mCoJtlxn/JJBn1VqQNcsiPDkVh4Rx6pGukfRSyeiqhrA+t5Uwy3lc+loj01kmaEsiFSiCNGmluplXkKa3UWCwUTyl9n5pqUM;20:XiLlpWxL8415QdW6E0zr0SMjAmlCD2Xzh23ZqhIkMFgwPFszIHX3xhAfwUB6cb6PbjBOaYpgymAy//yNsXhbXn6iOI/+2ZDSG0chTwuOe6+yze/s/JCVZPx7z5EogL3qzoQOv8JRlrO4hDeqW/6VEMeIKLgldqCMaz8oxYVX3+M=
X-MS-Office365-Filtering-Correlation-Id: bbe0db15-ca50-46fc-436c-08d5a46db766
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 14:15:46.9209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe0db15-ca50-46fc-436c-08d5a46db766
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.2018 17:01, Matthew Wilcox wrote:
> On Thu, Apr 05, 2018 at 02:58:06PM +0300, Kirill Tkhai wrote:
>> I observed the following deadlock between them:
>>
>> [task 1]                          [task 2]                         [task 3]
>> kill_fasync()                     mm_update_next_owner()           copy_process()
>>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>>   send_sigio()                    <IRQ>                             ...
>>    read_lock(&fown->lock)         kill_fasync()                     ...
>>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
>>
>> Task 1 can't acquire read locked tasklist_lock, since there is
>> already task 3 expressed its wish to take the lock exclusive.
>> Task 2 holds the read locked lock, but it can't take the spin lock.
> 
> I think the important question is to Peter ... why didn't lockdep catch this?
> 
>> -		spin_lock_irq(&fa->fa_lock);
>> +		write_lock_irq(&fa->fa_lock);
>>  		fa->fa_file = NULL;
>> -		spin_unlock_irq(&fa->fa_lock);
>> +		write_unlock_irq(&fa->fa_lock);
> ...
>> -		spin_lock_irq(&fa->fa_lock);
>> +		write_lock_irq(&fa->fa_lock);
>>  		fa->fa_fd = fd;
>> -		spin_unlock_irq(&fa->fa_lock);
>> +		write_unlock_irq(&fa->fa_lock);
> 
> Do we really need a lock here?  If we convert each of these into WRITE_ONCE,

We want to pass specific fd to send_sigio(), not a random one. Also, we do want
to dereference specific file in kill_fasync_rcu() without a danger it will be freed
in parallel. So, since there is no rcu_read_lock() or another protection in readers
of this data, we *can't* drop the lock.

> then 
> 
> ...
>> -		spin_lock_irqsave(&fa->fa_lock, flags);
>> +		read_lock(&fa->fa_lock);
>>  		if (fa->fa_file) {
> 
> file = READ_ONCE(fa->fa_file)
> 
> then we're not opening any new races, are we?
> 
>>  			fown = &fa->fa_file->f_owner;
>>  			/* Don't send SIGURG to processes which have not set a
>> @@ -997,7 +996,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>>  			if (!(sig == SIGURG && fown->signum == 0))
>>  				send_sigio(fown, fa->fa_fd, band);
>>  		}
>> -		spin_unlock_irqrestore(&fa->fa_lock, flags);
>> +		read_unlock(&fa->fa_lock);
>>  		fa = rcu_dereference(fa->fa_next);
>>  	}
>>  }
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index c6baf767619e..297e2dcd9dd2 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1250,7 +1250,7 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
>>  }
>>  
>>  struct fasync_struct {
>> -	spinlock_t		fa_lock;
>> +	rwlock_t		fa_lock;
>>  	int			magic;
>>  	int			fa_fd;
>>  	struct fasync_struct	*fa_next; /* singly linked list */

Kirill
