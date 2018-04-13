Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbeDMLGv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:06:51 -0400
Received: from mail-eopbgr00135.outbound.protection.outlook.com ([40.107.0.135]:52093
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751827AbeDMLGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:06:49 -0400
Subject: Re: [PATCH] memcg: Remove memcg_cgroup::id from IDR on
 mem_cgroup_css_alloc() failure
To: Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <152354470916.22460.14397070748001974638.stgit@localhost.localdomain>
 <20180413085553.GF17484@dhcp22.suse.cz>
 <ed75d18c-f516-2feb-53a8-6d2836e1da59@virtuozzo.com>
 <20180413110200.GG17484@dhcp22.suse.cz>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <06931a83-91d2-3dcf-31cf-0b98d82e957f@virtuozzo.com>
Date: Fri, 13 Apr 2018 14:06:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413110200.GG17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR09CA0077.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::21) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:5KfA9Ka9fjE6GnsjanN2Fjqb7WACS1eQpTQ0QfnqO0pYs7jNoChkULrvPGj6wwvfT2PRixVoLCVDFQXujMrYKdMdk/hmR9ODQ75GyoIGj2bY3uDxD5rfaOrb1tv5dTfZGyu89OPoFNDxdgQHfRfS6ReR7K1OG22luPvsfwu+MWXiD6d4F/3UF0XgjDCFbYQYo4cuRv5ad4sAqSC6SxvlTq9qSVuyh4zaBZy8FWrEiOGs0TlUeIHl5APlTPJoBefo;25:0tpvslvJl2xAmnxysiHFM29t4QoLJXbf2h68ZoWF1NbGU3WRBRl4zrw29DWx4SnDm3rVROtr+2FKLVDtkMqcf6ftSVHkDXAYFN05OCDijifNBC8Y6WI4kFgVvW6BFCObLlSspvhbdyzZtbTOdtVvJibbqTVs7L3fRNW89yWc0rHssZ/Kiiz1+Jsh2dxsjhl/s/beOegrM/fd0A1RYuAI5h3EHYDdwi5ksTl2WNSLgM9zsRxGYtrqPYVTxm5l5lL2NEUwQAJKhU++M1h5CXUYwASytKvkvSTEF+3C6wwG8bT4KJDENq/lKBSH8esm2Sv5kBH6jORMoHH4efA7AXTG8g==;31:Jhd8PIX7LgtOn3MJ25ZX+t/LpqeWlUaHchY686yX/z2QNDyGU30HMnf0kt57ZH387W/ocWpyyErD1UVvKlj8A8kECAgU9Y/ef23204Td9joZpPwXQeUp/fjamf3MoPa1xO1aXiWEvnOAixGMCMA5zPExypmAkf850N7HgftiDYwAdJ644k8LsRGZoWYEaNx6tQczzKXzG2d11aYAOzFq1V7JT5/f4lG39GMpKSrFXSg=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:Ko7+WfTXY+bUl34YuJtGUp2KjYTdf3Rqfn4eCyAUjaarsmooNTTyOh73xCrwq9PWAR916gUdbonM/ZSNVV6bx5fDIa1FEPr69kkF40sE/IFNzs+SYJ/2j2m6yHJDzw/hIMHYlqsBLmK4DegINhDnP40G8ffN/KPRJmkdD+4sizKKU8hMjthvszoEhjzoBXINPdeRFnmMcH8om3EzA1vMch+KK4uxk1yc8W+zL7HBaxXkyXRlzBiFk8ZMcGmFrW9nU+RdEamIs86X+o7zyCtoNFVHbKH3cLwJdvRrsHswpbGPGCu/XElE8mrOaT+KGm2G/iLqxwZEc2vPcBRaTAeqU5Cb0SUsoPHF8rKJrxN0b7W80zEnYHwHDdX6e4g8eJta5M6yvX6CumiGyvtSgbm4y36YK9XeTgFxy+eBZ1TK86ftEqSmuiMKsCF1u5Xl/L0ptVTz/HBbXCEIVP3h6WUKIZ6v7G8EBRKx/rxK9ptibTndAPUoWtAkediSyiPe099S;4:KvVLba8MHOpf0upbciZ9mHo1ED9dIj4bTP+jAJegjSTbTmujzmNoKdDwUXJZhGWT2JMUE/T55wBkZVAsBfIcW09LmkzRtZzClOaOui/6eXVOf5deAw0mZCzw1RCmNFYQO9hq8b3ncSEPUg5EQLIJBJu6gEDetkQKFgUzQTl3J6iZECloK3se2NN4WOPSMEF1TeUiwDbc9XZfxg2UcXsValwINR3CrqY5scet73pXlGTgsRO3EJ7qmxzIunLxjzBVZz/BAu0Pv2JNuqC4ybDO7g==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13392756023D11B57EAD9D2DCDB30@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(366004)(346002)(39380400002)(39850400004)(189003)(199004)(377424004)(52314003)(55236004)(59450400001)(386003)(478600001)(105586002)(53546011)(25786009)(316002)(229853002)(446003)(52146003)(31696002)(956004)(476003)(230700001)(6486002)(97736004)(52116002)(2486003)(11346002)(2616005)(23676004)(76176011)(6916009)(5660300001)(68736007)(53936002)(6346003)(16526019)(50466002)(2906002)(31686004)(7736002)(66066001)(305945005)(47776003)(26005)(65956001)(39060400002)(16576012)(106356001)(186003)(8936002)(93886005)(58126008)(86362001)(77096007)(65806001)(6246003)(486006)(64126003)(4326008)(6116002)(3846002)(81166006)(8676002)(36756003)(81156014)(65826007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6WmhRT0dsbFAxTzZYT0l1VjlpSkxpR0E0?=
 =?utf-8?B?blQ1S0RoUG0ybk84K05BMDlFd1l3UXQ4QWFjQW9WNDR2bkpFU1VQSWx2K2RK?=
 =?utf-8?B?dDRUTmpnL1NlcDNJa3VCQmZ2N2h1eFEwK3RmSFI5RHhFTDU1aTNIZk5WbHIv?=
 =?utf-8?B?VUlIWmgwREV4elRzYkI1WFlndVRsRzZrTGx6NFJnaFNnbWVaN1VQRHpINE1M?=
 =?utf-8?B?UDE4SGtDdGcrLzVkMWhHZ0R4SUF1d0VMTXI5V29DUW5tdWxMUTFuMVNxTnh5?=
 =?utf-8?B?bTJvK1phNjZrNCtkL3hIa1ZOTGZYMGVpYTA2YVh0NFVJdXF2V1hvekpaNngx?=
 =?utf-8?B?RTZGVHpkNzJyVHBMYlpuSHlheWVpZXVNZDlIZU1DYlBiQ1YrSHE4eGFCNkhE?=
 =?utf-8?B?RU9GNkdIcWhONFJYTE5JWnE3dDh3eEVtdzBiRW9na0pnRnFsdlFtdENnUTRK?=
 =?utf-8?B?QnFIUkVvYTMyVUd4QVBhZmh2OWlHRmwybG80djdzYU9yTnFleVFvdE5OZG5v?=
 =?utf-8?B?bi8yR3JtSWxvdkM1bzA3MDBwOWpWdUhXcUFlczFpbm1oblpicDV2Q1FPS3Ri?=
 =?utf-8?B?SXY4N0R0WGdscHl0RW1GNHczc2NiTDVscUNlK1F3amFzdHd6d0kwU2pweGo1?=
 =?utf-8?B?aTQwblZVQStQUld0RWpUWkdoVUpjaU9wY3A5NXVibEFUWkF5MXNIWllxQzNR?=
 =?utf-8?B?c0ZGT3R2TnN6VU9la2oyRTczdGpmZTk2dWlxQ0VmenBjN0ZCeVNaOTlodU1p?=
 =?utf-8?B?Y1FpamE2NHhtVXNlVzA2ejN0MEVVcXp2ZURyUW5JSHduWTk2TXFuQUVmYTZ6?=
 =?utf-8?B?ajdkWGxVeEF5dlc1QWIvSDRGVXlOSnpMaSsvREFnZEIvQXhsTE9LWElOOGhl?=
 =?utf-8?B?ZmR5MTl6SGJUaDFMWG92WG5OQmJEazN4Y3RYZEltVituTzVSNDVtR3RmWFZn?=
 =?utf-8?B?VVFZWktBWDB6Z1g1ZW44MURhTXVCK3Fob2NRYmxraHdWYWZnWDE0VHQrWFNq?=
 =?utf-8?B?Ymd0SFZQejY5NXF0VTVOZGZKKzF0T2JNUHB6bWppdTg0NFVrWXp0b0xlYXJk?=
 =?utf-8?B?NjU4YXM2dTZ0NXczSlo5Y3ZYM0VBeFY2cWJHaFNEanVvL3dBMEQwNXg4SEk3?=
 =?utf-8?B?ZE90VkZNaTFTZWFoUEFJSjJWRTVvRTFyZDhKL3JtcGJQbkluM0hhUEZNb3Jr?=
 =?utf-8?B?Y3I4d3BpdFNRZEdKOE5LWnpUYVFyT2dwSlJNQ3VZVmV2d3oxc2FIS21mdXJO?=
 =?utf-8?B?bTV4MVR3RnYyaFFrN2ZtUHFXY1hFQ2dBS0hiRkVmSFY3cWMvcG5OUzlzOW5W?=
 =?utf-8?B?WGJ0YXlTeTBISUFuM292eGFlWkZ5L1dhNFl6R3RjQS90SWd4bFZCeWlYbE8z?=
 =?utf-8?B?UVc3V3JvbDVvWXBqMXdXSzlVa2dKZmUyb3pUL3pxamRWUG1jb200aXI2YjlW?=
 =?utf-8?B?QVRwUHRMRjJ4ZGpvOXBDRzBpczZTalVPbFZ5bzczbEtsOG1SdjE5SDlzMUpX?=
 =?utf-8?B?Z05wVkdaeG9uRjErYmZrUVgycGhlSDEyZWZEbENIVENoN2tqNnlYY254dmUz?=
 =?utf-8?B?VzkzT084OHE2UXlxOTBsYUxGeFVrVyszcDJlNm9MVStoM0VLUU9KQWI2cUZN?=
 =?utf-8?B?R05ZNE1TSzNOODg2RzdyVElxOEcxTzk2MFFuYUIzUUlncXhqNG1ubzdmTUVt?=
 =?utf-8?B?MWEzNWpLZk9JVFhiaXJ6dHVrQXR0YStpZXBUSG9rT2VZOGJMQUVXRjlzZllP?=
 =?utf-8?B?UlZObExsRnN2VFFacmpTMll2R01SVmh5eDV6SUZLN3BnMDdhVkF0cEV4TVY5?=
 =?utf-8?B?a3NtcDB2U2l2clkxb2l1UFVrOTVjWUFLUHl3d0N4cWlkd2dQV0ZLS3BiTWlQ?=
 =?utf-8?B?WGIzbXFEQ1NyTVBCMUtocW02VnZuL3RYSzA5emd5dDNybGtvT2RSa0V1U3Zu?=
 =?utf-8?B?eGRyYUJTNTRzaDJHYmtNREp0ZjgrUHlQbENvTnRuTGhWNEV6UE50YVpUcTQ1?=
 =?utf-8?B?Rk5UZ2luMnhSUi95SkpqNmI5cGR1NStZSGZteHVzNkVHamc5TUJYeEYwdE40?=
 =?utf-8?B?cVN3d2E5OXJ6ODFhN3hUWHk4aUpGM3FKcmhHQzVhb2pmZGcyWWNoRys4SzYz?=
 =?utf-8?B?dUZIdz09?=
X-Microsoft-Antispam-Message-Info: J6AWJpHPq4Wle46JIKM/NT3C7Emm8IL80pj8a8s00rxbQDVVp4vuoLKcWuB6OyTpaTIrw4XyOvis9LktcO1Jaop+VC8DiiauetigcT5V4OjpZxz/MknzCK5zlzpK9pOIz/LQFGNdNa0gJ4vN0QVZcbyjgciPWxqBVrjlajXlUtwrfrnbKHtbGk5xUvz/prTh
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:53OaNJBOIsPpLf2EkhBfUoUmlSN0Bh5ZFkIiGzAAZ0VbFvd9tIMgqAUlHmGc1JQfuwujKJM2MwJt2TOVtrsBu10wtfzXaUFODECg5kvD7KS+Cd+eu1ycvC9pz/2F5n6shE2A9Y7qsSMa2dEummU7VBxHVRHJXGpoXsKT4SkFIj6j033e3H0K0fZC0x9zFd8Dk0lFAJBepHkW2DkjDEjWFaGBYKPvASBAN5ChmYbAR8hP9b65k9n7eb+wngBTmVLsSyj5KByUVt/nNA/ezdbkl5PRVZC1ix+4BJY2vx37pkuWPf1vNzN1rBhoEq0zydyAg+eARqfyyhAVuj+CHRrVSSvWfzMsgnVCf3k9e6TfIgX4hp8qZWe3DQaFd4tRaLqMbZd0UfN3/Kj55NYsVZ3h90K5fkVu75zC4UuLBBvDJXqbdwlOGfjzNs2hS/lpmsfMfVoYopboogJ1J8Yv7mlfCA==;5:Du2tL05drrL+Ta1E8TDV+2T2D7xEajk0cuzmpId0p7nsElrUusN64kyC/S4H5yEThg4oOb7eNsd+xogL2cA9g3ambD8sJAcbNu7TnsQ6f/OkHjilsFiAeRQS83PyUHGD+247pYpfqzAc0RQT+jDjRvTaUlfHyooJ//7Y0CgUkp8=;24:dssSUEceef6Evnjp708LVE+EQMwjjXnfHCy1oGa9WDblSlEYwZa63UYXMuKF+tSZbd3oEVf2ItSq++oGAkUFUZQbiE5XiE7G8PTnlH5nGsU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:esANjw9PUPF6HvLouGQoHgus1z7qSYml9CEzQS7UMq4bTPuVO2nWKTtWNbrTDK5MGndJoLt/7cyPxglMA0hQ89LhNg82M/iovXQgzcXUkBrkRmocXVutXZbutKNe6JyKn3EhzeOOLqPUlFBLdJYXLjvqW8omenZCSz4eCb5wBej4+UCbzahPXatlHLoifaqR7sJTm7ahC0SWMwxW9KCH8Y0UlIT8YF7ys7acCg+0KmEdrBIiX7azplsuyjXL+9sU;20:GPIMpuHX2np4ZYtFUGJcuGM3OUUFPy80TOB0zv4HbWtMnCCEl4fkiHq7v2m5JKbo0GDSW6HJkyyjRLHC687omtpdkuFTBQIG+44M+ssDt1STCvPHIXMD/lhCW+Fp5iRVK4u2aUqfgC2MbXWKmi3IaTRB134uR1JwyeV/Kybqkas=
X-MS-Office365-Filtering-Correlation-Id: 766cc70c-0dfb-409a-7659-08d5a12ea476
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 11:06:43.9775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766cc70c-0dfb-409a-7659-08d5a12ea476
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.2018 14:02, Michal Hocko wrote:
> On Fri 13-04-18 12:35:22, Kirill Tkhai wrote:
>> On 13.04.2018 11:55, Michal Hocko wrote:
>>> On Thu 12-04-18 17:52:04, Kirill Tkhai wrote:
>>> [...]
>>>> @@ -4471,6 +4477,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>>>>  
>>>>  	return &memcg->css;
>>>>  fail:
>>>> +	mem_cgroup_id_remove(memcg);
>>>>  	mem_cgroup_free(memcg);
>>>>  	return ERR_PTR(-ENOMEM);
>>>>  }
>>>
>>> The only path which jumps to fail: here (in the current mmotm tree) is 
>>> 	error = memcg_online_kmem(memcg);
>>> 	if (error)
>>> 		goto fail;
>>>
>>> AFAICS and the only failure path in memcg_online_kmem
>>> 	memcg_id = memcg_alloc_cache_id();
>>> 	if (memcg_id < 0)
>>> 		return memcg_id;
>>>
>>> I am not entirely clear on memcg_alloc_cache_id but it seems we do clean
>>> up properly. Or am I missing something?
>>
>> memcg_alloc_cache_id() may allocate a lot of memory, in case of the system reached
>> memcg_nr_cache_ids cgroups. In this case it iterates over all LRU lists, and double
>> size of every of them. In case of memory pressure it can fail. If this occurs,
>> mem_cgroup::id is not unhashed from IDR and we leak this id.
> 
> OK, my bad I was looking at the bad code path. So you want to clean up
> after mem_cgroup_alloc not memcg_online_kmem. Now it makes much more
> sense. Sorry for the confusion on my end.
> 
> Anyway, shouldn't we do the thing in mem_cgroup_free() to be symmetric
> to mem_cgroup_alloc?

We can't, since it's called from mem_cgroup_css_free(), which doesn't have a deal
with idr freeing. All the asymmetry, we see, is because of the trick to unhash ID
earlier, then from mem_cgroup_css_free().

Kirill
