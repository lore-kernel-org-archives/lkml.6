Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeBTNI4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:08:56 -0500
Received: from mail-bn3nam01on0069.outbound.protection.outlook.com ([104.47.33.69]:56400
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751645AbeBTNIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:08:55 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 1/3] locking/ww_mutex: cleanup lock->ctx usage in amdgpu
To: Peter Zijlstra <peterz@infradead.org>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180215141944.4332-1-christian.koenig@amd.com>
 <20180220123532.GD25314@hirez.programming.kicks-ass.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c22fe062-6c7e-cfa3-5f0b-da135a751921@amd.com>
Date: Tue, 20 Feb 2018 14:08:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220123532.GD25314@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88]
X-ClientProxiedBy: AM5PR0502CA0023.eurprd05.prod.outlook.com
 (2603:10a6:203:91::33) To DM5PR12MB1306.namprd12.prod.outlook.com
 (2603:10b6:3:75::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 044b7b7d-6fb5-4e9b-e1f1-08d57863177d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1306;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1306;3:lMj4UhDndC5QDOSN9Bq6T9gcg0AiMzirIK7qi/0w71Fw9SaT3/NNgIbd/KKlKJUlmDzb4QyYTpWuj13Sx8mS8QQCo8acR7Curqrbyfuw89hV5urHa4MS1l9B0zlyOQVLmOzyYMj7AbJtOWS6g8eVzg8gg2OExPK04oi+WDi0SN8FNDLj4jhlQsISzvTCnVO6n9rdrGPwZ3ePFJLrVGf79lMd3RdCJZPSyMH7sbW4ZjMaN8MRdx0IdaEBdPyarwea;25:k5j9GvgmWCYwxizJ7/s9H6kHtIdr38NctP+wfySuuUiaaSas1iT4/BmNYoiyLoE07rb3Go2yO7pmpjUfpzl1tVuPgdWaCtyuJYT9XdaQpvQRJ3AlqloM2wMidWhXI3hscJzF1yBscO3d3GWftbA0bR4p/J2H2j04aNT42eu4FWFFncGk0jFC5xYiyXeifFJ47brOGG2l6QOqlUQ50ZSPhb9l1ERXakgCg3s9wHgdpt2zY0LnuKiLAusC2zUwbbNVrpq9Mq7GNKTqA1Rhl6vfO4KS25HGmZsCVmot/ev9SLTwcDBVigFgBAafowvhGDaPM1cgdwMz8oC44IELTNM8HQ==;31:Mqr7zWjxf3HzcWr6gWr3QAv7CjwWcnJ7qpxshjXRJOek6MPwbfaW6o/wNjFFcmw9TecQ0aoY56p20/4byMwboS2IqZyTXzJ6wDJjB7GJQzM9WTueL3SKdUb6LQEwNitjuNAf0k6v1e7eqR2moWJNIjEITP3rFVGGTwACxNP8Z5x/tpi+9G7X+hpREyTA+c77NzSPQdCugVfcJCmGviFML8fpAxTvOBDtLagerPuCors=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1306:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1306;20:z0ucrM1q8L5dAi3BxVCzETmhsLu6O/seIf+93vDP0t5/QM23+saZYrpsnD82Ph4YmNDBmnQ2U+mLBpTI5d2eje1EcBrS0/MK4RC0853sDhgN78/08c6uoBpTff1mRGf4/vzdDjvMD0WFGP6q8PupRk2pBoBk5okLwmITXzGW5Bi1NDbqodS9iYxVo9Xk7yP+6ZHs4hYiSue9KL5TI+J4xiZoNS+cGE/ERk+e36CnXHt7ENVdD2fOeVzYzL/tkaM7ntjm4Y4jOuC+d9KfDdiURJpvmoc6lT8hiT02p6BnGk2+aACNdPGktZBLH6km00yEywgq7TycCR6seMvkLZCQlOF0Bmry769A/RFZeDqvjN4LzFW2k9+vJQsLENe09xj8ZhsvNNwWiRf6oSrfo2vuxk5wiXJ8LomdI6Zqe5rVLcZOcjICOf8ZsuYSNn1RTWUTB4xP4DoNL5QXCh1TswIaoKxzqZT0nLg7NwNyMjVu7IJAZCGGR2QN9CucS3kEMn5H;4:rrKr7z4qxPf6sui1WQofFUY6nV0Ee8gVYYzfi+KuKGQ3HnEHQ+aTYJT80c8UVx3dJ46Z9nu1pkN8TRIfjL+IT8GUDiOzgNMhy9ALSRGl1ED48WRkRuMcTzKIpzgKDAuol0XSZnk8UJLW9Xi3DkNTU9XtCvK0MWSPz9p9AohoOAdaigpSTaGTTfVMhi4RKgr4sizZvwNrId3aq5wewq54A7VQjhR9k/cMLqjfeO7Lg/nfMd5MpntPSx5sfjL50iDPUzXtalibJjJHXNAKsURluQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1306244554C9C4A051D3445C83CF0@DM5PR12MB1306.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1306;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1306;
X-Forefront-PRVS: 05891FB07F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(6486002)(31686004)(16526019)(229853002)(25786009)(53936002)(31696002)(86362001)(67846002)(5660300001)(386003)(186003)(52396003)(59450400001)(8676002)(81156014)(81166006)(64126003)(8936002)(83506002)(305945005)(23676004)(52146003)(2486003)(76176011)(52116002)(50466002)(36756003)(58126008)(97736004)(2870700001)(2950100002)(68736007)(72206003)(65826007)(6666003)(7736002)(6916009)(4326008)(105586002)(6246003)(1706002)(316002)(6116002)(478600001)(106356001)(65806001)(2906002)(65956001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1306;H:[IPv6:2a02:908:1251:8fc0:4c6d:7233:b7e1:3b88];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMzA2OzIzOlNQa2lXUjJBZm51MHh5MlpNaGNlS2tLbDAv?=
 =?utf-8?B?d2ZGbUtCMzkrYStaYlJUQkhqRHJGd1R6dDJSMnlrS2Vha0VLMEFPbE4wN3Z3?=
 =?utf-8?B?YVdwT2p6UUFrN0Nyd29ZRkpsSUswemtVTzZhSzFqd3d3a3hxd3RBcW9OUmxn?=
 =?utf-8?B?K0xNMWxNaGp2eHAzSlcxeGt5VC9LTjZ0Q1E2MnRDL0FaY0RUWlFpTVRJVlBt?=
 =?utf-8?B?dGxWc3BOMVd3R2RqTDdyUldIWndPTFFUR0htQzM3aXVLRWhvalNhRjJ5VDlV?=
 =?utf-8?B?THowRXl6dlZSSjNxK2h5RjBnaHJYQU5NMUE2RlROWW9KWTUrb2FWaWEwY05l?=
 =?utf-8?B?R2wzVDltRW9ma0VZVUl2TzRjalJoRUlrRVdEQUNIaGRWY0lnT2RwT0JRMFJH?=
 =?utf-8?B?VWF0V0NHbWMwZWZSS3YvenN3UG4wODlIODhlQUVoMkQrNUlNVXVsYUtpcnNk?=
 =?utf-8?B?K0ZuVklXMEpWOEhxVDJHY0V4RVE3ZTY1UzVuOTB5V2xpOEh1L2pJZzVZOUdx?=
 =?utf-8?B?VHR4dFQ2Q2pzNUJnMy9yNXRhdUNkdHRIWndpZUUwVmRxdko2Sy9zWno3L2dp?=
 =?utf-8?B?eENwMGxneTRSYTBvS1pLeU1Ca0FOUzcxTUVUWURPYTVhcDFjcVJmdWtWQ0Z6?=
 =?utf-8?B?YUlwVE9nbnp5bVlrM3lIRFg3b0VCMmF1bC9EN3llanRDL01SdDR5L01ReVUy?=
 =?utf-8?B?V29rMGZhYWFqeDBKQ2s1SG50N25oR2NNN3FwR2lCTGxWY3VGb3U4S25VcUk1?=
 =?utf-8?B?MUljQ3VSaFlVOXhmTnJ6Z1pnR3RBU3JwNm91cnllUXdIWGNLQ3NHM01hZG5O?=
 =?utf-8?B?dzhaY2R1TWd1OXBKRzFQMHRoSG83cTNobCtmSjVoRjdHUkhaNGY1NjVSc21T?=
 =?utf-8?B?Q2p3a290a3JORGNiSWkzY0xIS2VsZldNYXhSYW01KzFGN2huN3pRWEJXRThi?=
 =?utf-8?B?YlVaSWFxOGJzMDdzb0hqNXlMYUZSL0ovNDF5S3B6QW5HYnh6OXpCeTZkSloy?=
 =?utf-8?B?UzEveWhFSjYxVFlRS1hiL2IyRnlZdjM0U0tiR2ZMVWVXMDBSYmQxTzJ2eUZk?=
 =?utf-8?B?cngxY0xKQjVnMS9sRUhtbnVWdEVFWmpXUm9LZTdBejkxVjRRZHozZDMrcFZV?=
 =?utf-8?B?ZHgwbHJwSEdONlBWVkxZck45S0FWNjlhM1ZHVmJLbzJUTzJLYzVpRzdkM0FT?=
 =?utf-8?B?aHNSWml5c3ZPaDBiYlV1ODQ4Wk55akFHOVptb3VvZk14NWVpQnN5NG00ZFVJ?=
 =?utf-8?B?SjBBcHRpQkNNbUR0eGFyc05vb25YZXA0SVRMZndwVW9VQ2t6NEZtVlEvaFBl?=
 =?utf-8?B?QmJjemRwS3k3YjUxa3RaMTRVbjN6VFo5cW9jZThnd3pZUVhLYWczbjlackRH?=
 =?utf-8?B?VjhDSEtrRjJMNkw0czd2M3I4RTdLMTRmZHdwa0R5QkExWlpxTHF2dnBKMUlP?=
 =?utf-8?B?M1JQWmtOK0p4aDZTNlJCOXBYNVdZbGhKdzVOV0U3dVozYWZTVUxWY3FMVHJm?=
 =?utf-8?B?VzNQOUYvUU9TS2FwRkFKZUlSdXplM3dVdjRydlpSN2NCL3JXcmxqeU5xUTZm?=
 =?utf-8?B?VGdzS0o4OHd0M3I5Nlk2N2x3c2J3VWNnakN3emxCWGl5eitDMXpycjkxNmZS?=
 =?utf-8?B?VnFpMngxaFFQNktkUjcvTHp2ZUJXKzF0SVBWdDNmVVhCeEwybGNwRitCdUZC?=
 =?utf-8?B?VGZ5WGYyK1FuSzlJSXRoL2hReld5dFFxOHNhWGZVRlVkYWZJczlrYkxUU1dF?=
 =?utf-8?B?N25mNlhiSVovU2hlWDJ5ejE3WGhVMXpLNWRXY2QxSjRHNzhRNFh4UGhObEkz?=
 =?utf-8?Q?zRYV2vx1f4Dqk?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1306;6:Trdzn3jfRxh+T13JnDZvfkHe7P5jOLQMDy0vDhLACd4DaHrxOPskWdaGDMJQ82j35aGotCUcoh+esEIHoDwW6gl3wM6dpbTbh8j9h7KLfYNfk0k8vyEaq69ZvGYtqpifkgbOZBx7WDOUxcL3Dp/VvlgcqOvog1R4MU+kRAfBkgci2MPnoJ9qvsBT86/odRGXSivgCs4X0pi8xqjsU0vVWCUJ11GAREceQsY/7wKOhlB2IVDuNxfa6VP5Jbfft+UlzAhdVd62KngTVJXhf2TydoKh6ERwrCDCl2x8M2HSqQmpNXl2gdYW9vErZE726dmQf4j7PT1257GZA0PuPFesGXOBaqaFkM1Il18eNOoiNqs=;5:GmOMIfBJfhhejh6e5P+1yAnq7OGqZChOGMfEdtsRoMG6eZSv8gX4VcOyj0T9BEsHnlgUcAEE0fb3D8EQwGN5CUVLDZiaU7DQNGC61QolnTBHmdZLrl/6CPT5VDSwNwjpX92EE5SSLAbTC3Svg/cCyC7I4VrCY5reDTcLEwIvzfg=;24:2KcNFjeZJCrJkW8G7WvGph0l9dzTvh25JuPcfnXmzAOc1s2HWKJJjF4wT16F2AECdem5e3ONbGiLIlgxMTgDgo8Hw1NauZLAmZTgK4ipaD0=;7:5o/gqp2BhCfoCFqOL9etDdBJuSgR4V9wN+4T0OoZC+8YpI7jyI3z/Twzltj+TkUo8H6fKb5/wyUkBzwQO08JKo2k2dZ+x/GONnZM8EUbCizsIpddH3NBhNF9+TBJ+JtFCmhWYPOykiEG7uSS6nsVTzWaOpC0f4X3lm95Z1CNA3bPdwofRPkzx+9aHCIdZoplrt5wFv+unv2PZjk9LdmYpQQcDne5cPTNJXfO72815k/2id82InkP0/czqgCe66Xj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1306;20:P9CI2P43j0QoaqUupMaQOoRRspEsYIdEFbGkB/VVUwW4SFUPPGtdzg8+PtoFVeI+ZXQ5Tbl6FcoLkf0uTjCF0mzjS+WYy/TdVy1mwZOepXXokLLK/9nJsjghefveVcJxra0C9IZumL3Hxy9bDA90VOfTtmUlCAwJEArGf/2Ii7bs+Dd2HxOTGlu5hACqEPQ3/UeI6VknFjnybFaKMs1olPAjfLUSbjJsXPdXcPVIRGDHz0vdOMBAUjW9+u0joEzC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 13:08:52.5957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044b7b7d-6fb5-4e9b-e1f1-08d57863177d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1306
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.02.2018 um 13:35 schrieb Peter Zijlstra:
> This really should've been Cc'ed to me.
>
> On Thu, Feb 15, 2018 at 03:19:42PM +0100, Christian König wrote:
>> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
>> index 39fda195bf78..dd580db289e8 100644
>> --- a/include/linux/ww_mutex.h
>> +++ b/include/linux/ww_mutex.h
>> @@ -358,4 +358,21 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
>>   	return mutex_is_locked(&lock->base);
>>   }
>>   
>> +/**
>> + * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
>> + * @lock: the mutex to be queried
>> + * @task: the task structure to check
>> + * @ctx: the w/w acquire context to test
>> + *
>> + * Returns true if the mutex is locked in the context by the given task, false
>> + * otherwise.
>> + */
>> +static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
>> +					struct task_struct *task,
>> +					struct ww_acquire_ctx *ctx)
>> +{
>> +	return likely(__mutex_owner(&lock->base) == task) &&
>> +		READ_ONCE(lock->ctx) == ctx;
>> +}
> Nak on that interface, that's racy and broken by design.

Why?

Regards,
Christian.
