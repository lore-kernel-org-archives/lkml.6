Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756304AbeDZNwx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:52:53 -0400
Received: from mail-ve1eur01on0133.outbound.protection.outlook.com ([104.47.1.133]:18880
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755861AbeDZNwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:52:51 -0400
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
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c21ad28c-cd23-2a75-6622-ba49c37137db@virtuozzo.com>
Date: Thu, 26 Apr 2018 16:52:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426123542.GA819@andrea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0390.eurprd05.prod.outlook.com
 (2603:10a6:7:94::49) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:dYEA1pRUsIslbibEDSW1x3fGSah8Jj5okHx1BfiPioqYoWmzPvz88Oj9d6NdB/etri1zg3UuK/8wt+dKlEew+IeA7mxFYihzDRQQsBO0MKJ5hlYzbZxDokTW0E8SQppS+c9+mpPrL2qBwpHYQsA1D+J2wRK6NGyYGJHxY+FUt2UeXeNrYW2oy4fpvyZBhfC1sGQU/hVRQNJg4I5/ynu3IxCOoIfgYCMhvYTbfsp455WBuctSdONATliya8WdwM6W;25:on2us/d7XvhOi3Qc3a5unHav8l6vZmicPzoYT5Mu0cLalg6nqTAd8jFVB1yQTzk0RIWPrhb4U5MTKEoZJDd8W2THLve5gbSwThb3F6IJLj+PqsAzfA8nJidrUDwTFfs47jyDC7awxcQ3kIiVb2thAMbeL4VD/PeugKzg87/UHwLdVlQOGsx4VXb9S3H09hP8LbmIBEXr0MahgwWpkPk3VqG91mj7MbsJ1howxLoD/Ocjd0+Dt5wNdM57rZmB0Vwk8MMnmmwXefaq9vpZ5GRQuWzzBGlgm9iPOx4Jhek2prDFnAM3mGqZU3evCTeQinEiR3n57kszZZkO5qem07LOuA==;31:U5qcS/7vumhveluvLd/z4troL5qw/No8fUVkJsmQ7U7BB3irYNCBQfH+poE9arQk30YcYLziAdbKc2d6xIHx4uVgRWgcRTwTznctht41vHkwhXqL9qeboboMAeRSyMDqC1yW2bLLR7C9R/cA+lwwDXBJ/fqZQcHosMT3vqzH9I5/ZNP62gChmsCrhfQW2RdfdJuBK0bh+V3AhNH9THzbda+ZkWDlF4gMAoPG/tHXw/Q=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:BQOh/hNW2LXt6RiQILn5tSUnRE2DWFQ931w0K6WvSbUsZVdb4Haqhmaop+ovgc+rtR6TwFzgrDzEvBSOw22LtNBx2HzzBhdgD9F1fNmhIJ/FSem7LeHF/ls4DkCUUiCH8zNOh98fWdU9cqjJzXt9yJZYa2FAQiDw0CoscdPlpEJuouwZvGFO1zqfjP5zTjmlfg63rIcsf0iISFRlyQgBCOXOlPZAHYeYxrmRqiNY6glOy4E1tz728Eas8XKVXjsI3nJAbP4MzvRAPVauCQrKX503aQL/T3OORhN5VamXnyOH9M2uqnlulQFVU/nMD5XMie0YfMFFPJI+h3Lx28SjlKKf7L/rq0vuR4yzz8GLdkqayt8h1M1G3msl47oC9J/aUIoIERlP+BCllKbR2LIfsprMTjsp6kaHkXhMSIu1MlVyyHnFdipI8fln467tXD2SqyVONfcA1Ly2+1J+a9jRt3IECgGcsDURC//qVdjQOhBgnymoTvRNfJkGUEybn+UA;4:auHCO0i3DWcraBotl6S4AeO6X9EBXZS9+5Hfv/FhkaiXUqcIJVNllEIyAZvM28PGjJR5JIPhaP+FDs1kIuXuZOL36p3YiMKED7E+rOP2+jurevah6VDl/7yZCtPNdbPXhNkYKQRlZoDF7eSIJDOtsbp5xmU2j6FS+NkPn7fhQ2PtYOyPTovZVfSKrCgp4sYxEWBEfICubwfdYa5dqDVgbR8m1aTcF+J1dDkUL1zgMxFUSNBuoDuSVbvmSk5k1KxkNzWV57gHWc4YPHO7BpctORBF0uIwiaF9vvQ56LqsQrj/kjSEfefNcJNh/eoOOKhD
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1339B100AC60141D790696F2CD8E0@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(366004)(39380400002)(346002)(396003)(376002)(199004)(189003)(7736002)(386003)(6116002)(59450400001)(230700001)(186003)(16526019)(26005)(16576012)(3846002)(97736004)(58126008)(478600001)(4326008)(316002)(53546011)(77096007)(31686004)(486006)(52116002)(2486003)(2616005)(52146003)(956004)(476003)(105586002)(23676004)(76176011)(305945005)(7416002)(446003)(6666003)(11346002)(64126003)(229853002)(53936002)(25786009)(86362001)(6916009)(106356001)(68736007)(50466002)(65956001)(6486002)(65806001)(47776003)(2906002)(8936002)(8676002)(55236004)(31696002)(65826007)(81166006)(39060400002)(36756003)(54906003)(6246003)(5660300001)(81156014)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6YWc4TUUwMi96am5MT21CVVVRb0tXWTNL?=
 =?utf-8?B?SHVPOEM0bCs0NDFKSzA3azVpZGh5QlR0Qjh0K2tGckYxQXJ3SFhTQXloVHBB?=
 =?utf-8?B?bWJsU0ZicHJtZ3hmeTV3ZnNBbURpM3BlMWRrRFFmd2ljUkpGYWtjcjI0M0pO?=
 =?utf-8?B?SUZXazFWbVQ4YUJ4ZmhKcTVoeWNacUVJdm1OZmo0Ry80MFNKRTlqWHJpWTZv?=
 =?utf-8?B?Y2FlbHJHcmRtZTcyblEwcmc4MCtwZEs5Ry9xbGJReml4NHFJZkJoR3h3L1hI?=
 =?utf-8?B?M003V09YQUwwMmZHWThkM3g1ajFZTGRscHZ0UjRjRUswNS8xY0IvU2dlRkdB?=
 =?utf-8?B?bmxmTTZtcHdUdk9VZEkrNG5yanZXRXlzTWNCM2gzQ0tCZ1Z4SWplMWI0NzFz?=
 =?utf-8?B?QWN2alkyeGEyb2FDcm5oY0RESkhheXl6eU5SK25vYWtjNkcyM1dzMTlkdU15?=
 =?utf-8?B?RnZOZEhJSEtmNys1c1NMZU04L0drMVhUNjIzcWExdHdFeXpNb2pyS09EWjlx?=
 =?utf-8?B?N3lWc3FENkdLUWlTbVhQZFc1ZTJya0REM2pqbTNIekRPN0FVQVgzb1Y2bXZa?=
 =?utf-8?B?MWlXSFczMC91SHQ5SW9qWHEzK29SV2tLOEpweFA0SW9welZBMzJaQ2kvQmVq?=
 =?utf-8?B?eiszcnZYeDVuRWlZTUtkREhyWkt0RUJzQm1QbHF5SDRQSW5SbEo5bGNKT2RU?=
 =?utf-8?B?ZVU2UnM5NVZXNllTUTFpY0xkNUNUSmdSU2xrWDgzczBSWWFXRGpDclZqQ2M0?=
 =?utf-8?B?RE5EcmxGM2ZON2RZSEFxcWlVNkRjdWk2MlJOSWZPTWRzRnZSZjlCeDAxTVFJ?=
 =?utf-8?B?YThIa3NuNTlORHIxVjdpWHdRZURIbFNTaTZBU3Z0bXkwcDdTcy9leFRoTWor?=
 =?utf-8?B?UEtmTkwranVadElZTEFSRkc0cVg2Zi9zSU5qTkJqUGdlS3JyNFVYY3lnMjJO?=
 =?utf-8?B?TmdYZHd6bmQ3aW5nK3hyK1RuZXkzMnpIUmtTVjFKRkZ6QU9NUUhJVVBzQXRk?=
 =?utf-8?B?Uk9hMXNDN3VpcGVKdkxRMWJTS3dlR1ZiY3RUZTcyR0l1Z0JENmxFalZrQnJU?=
 =?utf-8?B?L3hCZVZpVm1ueDVpeGlwZHNqRTRBajZwZ2hzMDZLQlVYRS9nMXBRdTRDUVQ0?=
 =?utf-8?B?R0lPck5WMmlLTUJqdjJiYVRqclZXdnJSemxmdnJaNG5yRjhHNE40akNLUk5W?=
 =?utf-8?B?VkRlbURjaDVacCtzQmVEdmdFUjBIcEZ0MEpDMldlSldKN1NJc1QxV2U4V3Nr?=
 =?utf-8?B?dmRncmxmVXFrbmNnL3RCLzdPK2wyeDdpZ2VoS2xzeHgxOUdaZTlvZ3FuWFc1?=
 =?utf-8?B?TGNKanovUTVXdUJCSzZ6MlZ6SjNrUnJLdFQ2NnNnMjlXSCsyeTNCOEZhTFBt?=
 =?utf-8?B?VFdBTkVLTW5PM3Y0NExORVUvWlZXem9KcEJxUFd5OXg4RlFlMHZkd2lMTk81?=
 =?utf-8?B?eUJjd2o4Vjl3MGNxcW1NTlRSNFBMRXBRODZYUlZBVnFpbEF1K0krUmxwS21p?=
 =?utf-8?B?R3E3cUJsSnVzUGVBb3lNeHFFVzNUSEpIYXVxVndOMk5uTTAwQURydlBHb0t6?=
 =?utf-8?B?SHg2SnVQZjdYbWlIYXZhYiswQVVhRGhmdmNHNS82NkU0SXJIeWZlandkWXpW?=
 =?utf-8?B?TjA1VW5Vb0J1UjlmcC9Vb21BSzJNN1FVSmFKUSs2anVYY0ZyRXhpQmxiYWhD?=
 =?utf-8?B?UnJ4Z0grSWxwalRUdE9CazFrRVJxUHB2WHNQMWg5RkNEaklObHpxd0w5eVZo?=
 =?utf-8?B?TFY3UmNreHByZ2hTQmZNRDRDZ2xTVXlYY0VjdDlFNmJIM1pJcVEvVlNYUmxl?=
 =?utf-8?B?RWh0M3d1bThrSG5uY1c1dURPQmVTaldiQmNFOENGUUtkNmdtM2lhNDF4Tk1k?=
 =?utf-8?B?TW1PTTk3QksrUG5wNW1tUGhGOWdmSFNUQjhLQlI0c2hocENyZEI5akFYS2dq?=
 =?utf-8?B?Y0lZUmRldllISTAvdm43cjFucVRuZU1YTlVSOEMzL3lFcTdBLzBZYjlJQ0xO?=
 =?utf-8?B?NmRzSTA0dDJTYklTUTJEVE1TVkdPc05US3QwRDVzcVV4V2JaNVpnZ0pFTlh0?=
 =?utf-8?Q?cNF2W16Dk6204YFQNow41nun4hs?=
X-Microsoft-Antispam-Message-Info: Sv/jQIC6rDqQGzCwJniAyxcQhT42W0YdgmCi95gALlAt/XjIv0wy+UDAkfcv1HWmaB4u02RmAA/0Ml1qcUNdHCuqHukris19WM70o/gVzRFjFUJouBM/zCjAj3RjXP0WIjQNzeNGUvcLi5v02cJA+VGAOky3eE0UbgVs/ingWnyleNiB4Yp0u1nszsiosBnF
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:9lUGBtcQ9CMjA9Dh3KSXDCuR/SeJw03DfMcUBrm3rGS/qr9+yNdcA8RRyAmJ16V8llUWC4dUsPPoXpw+BQzBoNmm7F8ub4CB0SNbbdZnguf7y3WQkEB/qFGUnwuvMxkr6mdxIUvKTOBMY1NgSjMjrfkgw+lpQHjztOWFc2qPubmz8w0ZciYpj1MT9iTIrbD4X2X1+6v/XNzVvej9Y3SXsLt/K/4uvwxuKESJYUYot3fqcyXd7gNWyKGcoIHW1Yiyya1xqV2NavqAEddHfgicwsQkUkD9XGPOFaX3MEo/baCnYFyEnyiyPU29KZVJox6y/QJjRRIFxZ0d7E0Ku9YwDnp6scspmFtpqjakB9m9U/bp7s5ALNtDDEAb8UL86GBt08UTFTV/zTg7AGT+jjufEgHT39dKhmikkTGiYlBzjwpodBvtQC47SvlUqfg6ZT9xKmE0j7m3Rxs6p3sp8Qs1Rg==;5:f4F2RBzUUy1UQPaIUcBozms7QZKRGmp1iGT0XA+c8a3ZNP3HPHl/inorT2h50eEN+OPKxm+5T2X52/wjjTdh8JMBM3rZN5JA5py77Btc0cj1Z0NYVxENLzVTYGwQjEb3SegHqW4IkaTqkl9L275d925sfvGbV+DN+7RIPTAIBuI=;24:aIPIVE3g4H/p1KyWu/zG0hRUi9GEZQQFy6AsXpPIwYssC5CLI70kebo8qQTCXJaklvEzsN1s3jqniyLZ/mEq72fzm/JMeow9LtqpSi/RP/A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:7ypmQXdP5RxADxr7eXPwQha/pPIu1Q2k1AdYAO6WVIj8pm0ZmklSrMaWVYtHPTNgL1B+TlKztyUey4XENoS9oNkz7QusGhQ586mNbtmQc0H1Cr49ojyZfEBiS6W1A1m3g1uuVHD9ufRfTuRaLLe03lgvI1hvU7X7HLTbAtLkLQlScr2r828XqY5YpUcoRT1yDvyeZESn2IDXt/m+t+EOFpZ08Hq7XzD9d6gN32+cCt++iv8UYv+g2EtegiIBr1hX;20:Vf2kAKgUyTQZgmLNYIb27IHWJKIIqpHOZuUqOm8v45IhfjrFa2e2z8fJL04lEJf6+T3LdRHiL/k0fYSUSNgwKXuFJrJV0h2Ic9CTLEk8I+d1okb+M7R8Tk1bar1g14tzb0+F9NFqxyFromUtUTJQE5K5nvRHnG4BLQF1fWWXrTw=
X-MS-Office365-Filtering-Correlation-Id: 67a0f592-405e-40d4-53a4-08d5ab7cfdd5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 13:52:45.8047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a0f592-405e-40d4-53a4-08d5ab7cfdd5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.2018 15:35, Andrea Parri wrote:
> Hi Kirill,
> 
> On Thu, Apr 26, 2018 at 02:01:07PM +0300, Kirill Tkhai wrote:
>> The patch finalizes the series and makes mm_update_next_owner()
>> to iterate over task list using RCU instead of tasklist_lock.
>> This is possible because of rules of inheritance of mm: it may be
>> propagated to a child only, while only kernel thread can obtain
>> someone else's mm via use_mm().
>>
>> Also, all new tasks are added to tail of tasks list or threads list.
>> The only exception is transfer_pid() in de_thread(), when group
>> leader is replaced by another thread. But transfer_pid() is called
>> in case of successful exec only, where new mm is allocated, so it
>> can't be interesting for mm_update_next_owner().
>>
>> This patch uses alloc_pid() as a memory barrier, and it's possible
>> since it contains two or more spin_lock()/spin_unlock() pairs.
>> Single pair does not imply a barrier, while two pairs do imply that.
>>
>> There are three barriers:
>>
>> 1)for_each_process(g)            copy_process()
>>                                    p->mm = mm
>>     smp_rmb();                     smp_wmb() implied by alloc_pid()
>>     if (g->flags & PF_KTHREAD)     list_add_tail_rcu(&p->tasks, &init_task.tasks)
>>
>> 2)for_each_thread(g, c)          copy_process()
>>                                    p->mm = mm
>>     smp_rmb();                     smp_wmb() implied by alloc_pid()
>>     tmp = READ_ONCE(c->mm)         list_add_tail_rcu(&p->thread_node, ...)
>>
>> 3)for_each_thread(g, c)          copy_process()
>>                                    list_add_tail_rcu(&p->thread_node, ...)
>>     p->mm != NULL check          do_exit()
>>     smp_rmb()                      smp_mb();
>>     get next thread in loop      p->mm = NULL
>>
>>
>> This patch may be useful for machines with many processes executing.
>> I regulary observe mm_update_next_owner() executing on one of the cpus
>> in crash dumps (not related to this function) on big machines. Even
>> if iteration over task list looks as unlikely situation, it regularity
>> grows with the growth of containers/processes numbers.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  kernel/exit.c |   39 +++++++++++++++++++++++++++++++++++----
>>  kernel/fork.c |    1 +
>>  kernel/pid.c  |    5 ++++-
>>  3 files changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 40f734ed1193..7ce4cdf96a64 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -406,6 +406,8 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
>>  void mm_update_next_owner(struct mm_struct *mm)
>>  {
>>  	struct task_struct *c, *g, *p = current;
>> +	struct mm_struct *tmp;
>> +	struct list_head *n;
>>  
>>  retry:
>>  	/*
>> @@ -440,21 +442,49 @@ void mm_update_next_owner(struct mm_struct *mm)
>>  		if (c->mm == mm)
>>  			goto new_owner;
>>  	}
>> +	read_unlock(&tasklist_lock);
>>  
>>  	/*
>>  	 * Search through everything else, we should not get here often.
>>  	 */
>> +	rcu_read_lock();
>>  	for_each_process(g) {
>> +		/*
>> +		 * g->signal, g->mm and g->flags initialization of a just
>> +		 * created task must not reorder with linking the task to
>> +		 * tasks list. Pairs with smp_mb() implied by alloc_pid().
>> +		 */
>> +		smp_rmb();
>>  		if (g->flags & PF_KTHREAD)
>>  			continue;
>>  		for_each_thread(g, c) {
>> -			if (c->mm == mm)
>> -				goto new_owner;
>> -			if (c->mm)
>> +			/*
>> +			 * Make visible mm of iterated thread.
>> +			 * Pairs with smp_mb() implied by alloc_pid().
>> +			 */
>> +			if (c != g)
>> +				smp_rmb();
>> +			tmp = READ_ONCE(c->mm);
>> +			if (tmp == mm)
>> +				goto new_owner_nolock;
>> +			if (likely(tmp))
>>  				break;
>> +			n = READ_ONCE(c->thread_node.next);
>> +			/*
>> +			 * All mm are NULL, so iterated threads already exited.
>> +			 * Make sure we see their children.
>> +			 * Pairs with smp_mb() in do_exit().
>> +			 */
>> +			if (n == &g->signal->thread_head)
>> +				smp_rmb();
>>  		}
>> +		/*
>> +		 * Children of exited thread group are visible due to the above
>> +		 * smp_rmb(). Threads with mm != NULL can't create a child with
>> +		 * the mm we're looking for. So, no additional smp_rmb() needed.
>> +		 */
>>  	}
>> -	read_unlock(&tasklist_lock);
>> +	rcu_read_unlock();
>>  	/*
>>  	 * We found no owner yet mm_users > 1: this implies that we are
>>  	 * most likely racing with swapoff (try_to_unuse()) or /proc or
>> @@ -466,6 +496,7 @@ void mm_update_next_owner(struct mm_struct *mm)
>>  new_owner:
>>  	rcu_read_lock();
>>  	read_unlock(&tasklist_lock);
>> +new_owner_nolock:
>>  	BUG_ON(c == p);
>>  
>>  	/*
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index a5d21c42acfc..2032d4657546 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -1805,6 +1805,7 @@ static __latent_entropy struct task_struct *copy_process(
>>  		goto bad_fork_cleanup_io;
>>  
>>  	if (pid != &init_struct_pid) {
>> +		/* Successfuly returned, this function imply smp_mb() */
>>  		pid = alloc_pid(p->nsproxy->pid_ns_for_children);
>>  		if (IS_ERR(pid)) {
>>  			retval = PTR_ERR(pid);
>> diff --git a/kernel/pid.c b/kernel/pid.c
>> index 157fe4b19971..cb96473aa058 100644
>> --- a/kernel/pid.c
>> +++ b/kernel/pid.c
>> @@ -155,7 +155,10 @@ void free_pid(struct pid *pid)
>>  
>>  	call_rcu(&pid->rcu, delayed_put_pid);
>>  }
>> -
>> +/*
>> + * This function contains at least two sequential spin_lock()/spin_unlock(),
>> + * and together they imply full memory barrier.
> 
> Mmh, it's possible that I am misunderstanding this statement but it does
> not seem quite correct to me; a counter-example would be provided by the
> test at "tools/memory-model/litmus-tests/SB+mbonceonces.litmus" (replace
> either of the smp_mb() with the sequence:
> 
>    spin_lock(s); spin_unlock(s); spin_lock(s); spin_unlock(s); ).
> 
> BTW, your commit message suggests that your case would work with "imply
> an smp_wmb()".  This implication should hold "w.r.t. current implementa-
> tions".  We (LKMM people) discussed changes to the LKMM to make it hold
> in LKMM but such changes are still in our TODO list as of today...

I'm not close to LKMM, so the test you referenced is not clear for me.
Does LKMM show the real hardware behavior? Or there are added the most
cases, and work is still in progress?

In the patch I used the logic, that the below code:

	x = A;
	spin_lock();
	spin_unlock();
	spin_lock();
	spin_unlock();
	y = B;

cannot reorder much than:

	spin_lock();
	x = A;		<- this can't become visible later, that spin_unlock()
	spin_unlock();
	spin_lock();
	y = B;		<- this can't become visible earlier, than spin_lock()
	spin_unlock();

Is there a problem?

Kirill
