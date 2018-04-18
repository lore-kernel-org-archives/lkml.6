Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeDRWlA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 18:41:00 -0400
Received: from mail-eopbgr50120.outbound.protection.outlook.com ([40.107.5.120]:10479
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750981AbeDRWk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 18:40:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
To: Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, peterz@infradead.org,
        mingo@redhat.com
References: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
 <20180417140110.GB21954@bombadil.infradead.org>
 <3518b26a-2a81-1fb6-e01d-8d0b06eb0ad3@virtuozzo.com>
 <1524081607.8502.18.camel@kernel.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <d0c9c1e8-0d31-a223-ccf1-9b4a736624c7@virtuozzo.com>
Date: Thu, 19 Apr 2018 01:40:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524081607.8502.18.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.178.229.144]
X-ClientProxiedBy: HE1PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::25) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:0lV/Cs9mInOTCdiRDhRBN+2nrHY6Cx9rDKMnIG5oCwmfkZEy+RO7t0wI9AOS1NRo0AXnua4DujRqCZ+aHjY+XeIsG9iulURpLW89/6p80+eoHf896bxbZmIROdwNLOaMWptKOo0YewDXrID884YtgjfNP92o+MPm0HZd1Ajl26zAGDkOt9HHZlkFswYPWYrXW0Cwvd7pjDpLPfsSHStSlpff1fWyEJKQ1rW8ZA50u9FHXbyr6EM2ZtlC55202rMU;25:uHLsg4Q6lNvr9756niTACUEfUZZFhdKoe6IO0O8upucESDhsjkhdfjXdOjk4PbQM8cPcOXLKEL6qyJbvCvr/mn5Ta6vpT082RoZxSVzR2h9fq6yHkv7gfgPVL/SLaOrSGUX6dqLi0mB8V2uBXbAW+r8zl/DHsqSbVQ3t/yotC5f+ihxGic0fnsYro2Bp0STt9DQswPIrezNpuQPTLb5aeelA2ILbxbf2QPGjuIOZPtcpsEr5jNjaB8LE+oIaep99dnMYwHBHDsEyCd4twkVhN5qbBY/1L0U9qbivBqIX+HXxJBR2Rdg0sWLpjSLYkb5k23/wkjhgOPKyNm1Bj5oMeA==;31:H499iPWQhsCnnGHBiv9S5DhWRmMGtS2ubbRrGjdkoOnIfghtKgVofXGOAbKNaUZfUi4sR2eLJLQrKtoaFLiQy9ogkm80iU1P9A4bNktktrLMjARaa0HzBeIEDQSoDlpWS+qEjr2ojccYFMbH7EbGcxjGETOsYIBphLnFvTzf2E/UhFZrgWkgg5IjM4QfcY03slii7V1aOzg0Ig51lnMPdwNqb9mQLcrXlROvHmZDFyo=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:GlH5EiHkINbG0zQETf3vMsJDTbB0KKvmsJe2eh5z9lYVFUFteLhI11iQ/MYxPPZ6fKeJKG55oFnzghpjqvkMjhtrTdcxT4piPTYgmCmIyqi+TeUYUgTQ7sRpfTebTrT9NhD2z1QwR3/C5cgdHFXR3xOrAJwbtd8jQhksz6z6HcPzuQqBez74TgVHF0X4Ti4osLHJAAJvFvwuLQHJQw+dwhq4XeZcgp/0y1kOVewUMW/F7NU96oh7DgWPXTFM3QagamoNKzJS8qukc1o2C/T28yMhbVwjvOr800IhVqZvJfCIKFLDxFk+ZTNuFDrNLvkgPubimx4Icpde4nhPbaU429piscMumyYS6m4Ea8kgKgSSjWXLyQjmtssKAqRmO+FXYGa2CxZIVMwKy9nShv3nlANIX05O2u9YEao0PWeo52A5O3GNqHLoyhzKvC61N7yl7YqGFO83ucj58KR9zNsZ6HQ4srQzjisuHSRHGgli0exvEhgc+/s54kICPvRZ9XxW;4:opvX9Tp+rxt1LtFSJwBLuWQqO2P4izZbSZJugxIr3tuilhLUcbf60VSJF3/4oEd/i1wXLXN8OfBn4w+fhEhlh2xbLiqsfOEPzYQi+seowN6kt6yTbpcWiVdmYsGhvzwnCfKUd9ETM6X7CaYqRPNopcyZqkkSkcxENdNg73giKf6/N8H3uoj9Bj7dFfOu7YyzlYJnSkOj+2VZonRMqx3x//CEokqXZZn9FX3FbFm/AQkB/YPS84NsILRZU1NWNuzDiBl0MJBBqmn1XeXfs9BUyg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13380EDA4D431302FE50FAA3CDB60@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(39380400002)(346002)(376002)(39850400004)(52314003)(377424004)(6512007)(16526019)(26005)(186003)(2906002)(64126003)(8676002)(58126008)(36756003)(2616005)(50466002)(81166006)(446003)(956004)(39060400002)(476003)(8936002)(53546011)(110136005)(7416002)(53936002)(2486003)(6246003)(23676004)(229853002)(11346002)(66066001)(47776003)(52146003)(7736002)(52116002)(59450400001)(316002)(3846002)(478600001)(305945005)(31696002)(6506007)(65806001)(76176011)(65826007)(31686004)(86362001)(65956001)(6116002)(93886005)(5660300001)(386003)(230700001)(4326008)(25786009)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6bWl0NTV0Si8rUDV2MFRJNTlUNzM4My9k?=
 =?utf-8?B?MFZTc2lleERGaHJ1b0ZDNEVDNStieEpTdTNOclNFSVNtOUd6TVZOQzBsOTZ3?=
 =?utf-8?B?NHJ5N0ZjOW14QVptemZ2RnNKbEpkL0xjQXZ4K0NHMkVFYlBZMnlvMVZzM2Fm?=
 =?utf-8?B?MStnVloraWtqcFpkakk4cFpGeHlUNnhiTDFqb01RN0NSeU55N3BvR2xua2NP?=
 =?utf-8?B?REU4bzRyMlZJdzU3Um0rU1l3dEhPYmtkVytUSWd3eUc2K3FaRHBTNWtObkMz?=
 =?utf-8?B?OUNJT2p5VERxRHVFSnE4Vk5DOURSS080a1NVcmZmWE1GUi9NM0ZmVWZGZWU3?=
 =?utf-8?B?dXN5SnRJMS91elFGOW16QitDZGpHb1phekVxZnBoTi9jK0cyZDFjUmllT1VB?=
 =?utf-8?B?UU42SmZ3QWhHRm1VR0dFdmRjU1FOc1ZWVi9MZElRcWs4clFwUXhvRWE1b2Jv?=
 =?utf-8?B?MUVUU0NCQmlJYi9KWUxqNE1uOWVhWWphaVBMblJJaDV6cE83NzhmU2M5ejZQ?=
 =?utf-8?B?em90OEJFNkhkb3pZczdZaVFWekYxVVV0ZitQekNwVExuZkdtTGdTUGhDdkgw?=
 =?utf-8?B?STFmQ3FXZ29nQml3SDlDQzNSR1lHcnBFbmtLWUVQZ1ZKLytMenkxeHNwMTgz?=
 =?utf-8?B?SHFKd0lML1pjODNFd1dheGh1NXJpejFqQ3p1K1ZqNGphTi9XNWxUcEFaemhh?=
 =?utf-8?B?cGJYYjh4SlcrdldSazdxUXdxLy9PSDNMMENnbCtMSXNwcUoySi9NYjg0SkhF?=
 =?utf-8?B?QkZBY3lEektXVEZpMXJVQ2tJOHFqYnFwSUF4Z0V5Vi82Q05UNGJxV2ROUUto?=
 =?utf-8?B?cmhnaTdmc2UyOU9hWDVnTDJ2ZThsc0k1NUZobHdTUitLbmM0R0R1UStkdmdB?=
 =?utf-8?B?ZDZDSCtWSjl5emk1VG5VaGpieWpsVlZxdElVRHVvQmhFWUJENEZKVFpldkRy?=
 =?utf-8?B?SlQxdGdnc1V5TzFWVmNDQTN2TzFZWTE1ekovYWtya0EyLzk1cVBjMUFIUnJz?=
 =?utf-8?B?aXUvb3JIZ3RVMm1aRzFYT09UL2NLRUlzZTZBanI4cjdsb3FCQ0RtN2lJVlIv?=
 =?utf-8?B?UXlKRERxM04vMEZTMVFnakRkYWlTanhuU1ZJQlhudWFBQUx3b3FHemw5cWYx?=
 =?utf-8?B?d1g4Q0haLzBxcjVYNFZJYWdMRXNSMXk5dEtiRTA5cDFIbWUyQnNlYk55MGNm?=
 =?utf-8?B?NjRWWXhBalA3aCtXY2tpQVR2NnF1ditxMExxd3IwWU5YNjlCbmhjdG1nUTBO?=
 =?utf-8?B?SVB2elliSmp5MjBUdTc1bDhIVWh1Q09yK3I5VitadHMwUHo1cmxCVmkyZWNt?=
 =?utf-8?B?eEhMVXJWM1hqK2Mycjh1aUc0R0E3d1IyVElaOXp1VjRNU3pmTDVRS3hSTlU0?=
 =?utf-8?B?VzZmcEQydTFOOUx2cEUvL2RPNUNJRnJTTUtHVjRHSUI5eXZnRTJNNU5qUndP?=
 =?utf-8?B?TWZ0ZndmelRIb21VbWhNNGJ6czlBejNlQ0ZLaDRtVlVhcXRtTkM5SlFGZmds?=
 =?utf-8?B?eUtwUDNRQlUwSTRjM1FHVkVEZzBuSVUrUHFaeEdtV0prcjNzRDNMNG9GUktE?=
 =?utf-8?B?VEtxZ3NnSGxmSWNzelRERnkvckxIdmVOaVBwU21SUm9pUm5DMkxUMXZReHFE?=
 =?utf-8?B?RFVkWnpRT2FER1BFRmY1THplMk1LYUIvRDR0cnNWSG9wRndpbXRjOFIvcXdn?=
 =?utf-8?B?aDl2QlQvK2c5OFpvN3RCU2MzYndGeVY2WU1wNW5VNWZqdEd1eUp0YjVRM3A2?=
 =?utf-8?B?Wlg3emRBRzY0Q0NkR1JONGI1V3p6a1YyamdVY2l0OHBobkgzd0xRbHRpU2d2?=
 =?utf-8?B?N2g3ZGVFQi84WExsSmFIdmdMT0ZvalVYZGtSclZ5c2paZDFQbzdTNWl3KzhR?=
 =?utf-8?Q?sqH9ahVZLlYww=3D?=
X-Microsoft-Antispam-Message-Info: 5EqiK90U8sCsfL2LS9CNAZv/ZRbqWHG5BHar2MHZ1GLqSbs2+anMyY5wt5fybKdUpyDkA1ysX+mAL7/Psd//oJRcZHm/vlGqAohajHkE6ZyLyjgjbIv+rQc2im/CQuXOcuF8+3Fu5NktwAcbymMhH/DXJFG5o76pIx6OAr++mHaWgblitrhoOOmfybzgsCqo
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:UdqObQ4WwaAL7sypN0siIO+Jb8PkIotmaCgaq4wJyR4ih/RpVrFCoCIN2VNuHKHdJQg1b/Vv/oKiYt9EwqTOguLSYn8CSW0sG6PGogfJv436302kwejI0vKCd811WEFqha87JQI4Ur8RzCgSrUuUgJ9yWfe3wJF6o8Ljlev8y/orQNggkm9PWns66d/mY8GpZFgLvP0A8PJusYq7sCyZcZYX1RkmDlbtSXFo1tinZvGbYa12nuD2OvX0DJrUptIXDKlYj2J39gLCcBBl42I0faUGxy2HQ9SyaEWCpeMdCtpPfBHp2Mz8sy+txj0io4zemZnrl4uIfDh8ueC19QMebjV3acFhgyeC5gc6VbiXk1IhWuIWfmp0HvB8GvgzRKEGepKsQ0kfhdlNsr71P7S0yRGKa4vZ8JpevIAVqbVbe7bcXtbn862tfyyiyfFB6+CXyoB2y4uRnKKIDw4jHL/Bbw==;5:LUMp1M42pjI/2CkUZICrP2q+bMbO5BnthgvN82YYAAbRI+FOPe86corBioxFw6jwc6fgdkYkuA3YlHCxPtzsO+9YZnThJscbfYDLY4Dbet6Ofyf+4d3V4gO/7yr9k6PwZQLp7ybTbXyi56PCod1u/SQOcjdWo0E2wLHgKOBmlzs=;24:Br4DPSL5KC1JIdBNQXsEqXzcdb61/To6Yk6regl6pOUTuQmkwV1vrJaKVdVOUj2a5PFOQmnvhv6zLqNFAuiYqIC/eVNOYb2YxWLOf1/VTAk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:aq9nNqioY9nClOOydd0QQGHzsjT8AaLWvWlDUaKmICUgpEmsNgQy/FO1DnbbBfq9M6MwaxRaF6QRoSVModNwe3UvnVElKGdSYKx/FERZCbDUXlkaKzGgrxENVG964Zl/BlStTX0Z8Bb5FulRYQwW9VpPqn1NSwKg4sJDlmxcAn8guws6HCei43jdmD/8npXB7DQlbFifgXXRq/rV90eZuzZPfbzE027WAxz/Do4DdCfa30QwgDDmSWOfBt82RWPo;20:9oGXnTI6dreMfKGp312q4QDbTpry5OXz2bdTNfhDRKS2us31lghtoBwfbEkfxjvKY++/bXDAuvGhA0EucTzvhVS6FeloAYz/hqR2yPxVSZhsuIgWpy0G3sFz9XRvQd8LQ1U9XgJDvvJX9TOQ6Q0HCw7hcaE7op3MgmZNtGPH3zQ=
X-MS-Office365-Filtering-Correlation-Id: 985d8575-2abd-4e2a-c764-08d5a57d6e49
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 22:40:47.8554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985d8575-2abd-4e2a-c764-08d5a57d6e49
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.2018 23:00, Jeff Layton wrote:
> On Tue, 2018-04-17 at 17:15 +0300, Kirill Tkhai wrote:
>> On 17.04.2018 17:01, Matthew Wilcox wrote:
>>> On Thu, Apr 05, 2018 at 02:58:06PM +0300, Kirill Tkhai wrote:
>>>> I observed the following deadlock between them:
>>>>
>>>> [task 1]                          [task 2]                         [task 3]
>>>> kill_fasync()                     mm_update_next_owner()           copy_process()
>>>>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>>>>   send_sigio()                    <IRQ>                             ...
>>>>    read_lock(&fown->lock)         kill_fasync()                     ...
>>>>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
>>>>
>>>> Task 1 can't acquire read locked tasklist_lock, since there is
>>>> already task 3 expressed its wish to take the lock exclusive.
>>>> Task 2 holds the read locked lock, but it can't take the spin lock.
>>>
>>> I think the important question is to Peter ... why didn't lockdep catch this?
>>>
>>>> -		spin_lock_irq(&fa->fa_lock);
>>>> +		write_lock_irq(&fa->fa_lock);
>>>>  		fa->fa_file = NULL;
>>>> -		spin_unlock_irq(&fa->fa_lock);
>>>> +		write_unlock_irq(&fa->fa_lock);
>>>
>>> ...
>>>> -		spin_lock_irq(&fa->fa_lock);
>>>> +		write_lock_irq(&fa->fa_lock);
>>>>  		fa->fa_fd = fd;
>>>> -		spin_unlock_irq(&fa->fa_lock);
>>>> +		write_unlock_irq(&fa->fa_lock);
>>>
>>> Do we really need a lock here?  If we convert each of these into WRITE_ONCE,
>>
>> We want to pass specific fd to send_sigio(), not a random one. Also, we do want
>> to dereference specific file in kill_fasync_rcu() without a danger it will be freed
>> in parallel. So, since there is no rcu_read_lock() or another protection in readers
>> of this data, we *can't* drop the lock.
>>
> 
> I think it's probably possible to do this with RCU.
> 
> You'd need to put the whole fasync structure under RCU, and we'd have
> to stop resetting fa_fd in fasync_insert_entry, and just insert a new
> one and delete the old when there was one like that. That'd be no big
> deal though since we always allocate one and pass it in anyway.
> 
> We could also turn the nasty singly-linked list into a standard hlist
> too, which would be nice.

I don't have objections it's possible, but does read lock there is real
performance problem we meet? Write lock is taken for a single operation,
so it does not seem to take much time. We used to leave with exclusive
spinlock for long time, and even with it nobody complained. If there had
been one, I assume, he/she would have submitted the patch to fix that...

Anyway, if we have to make this code completely lockless, we may. But
I would not take a risk to do this as a fix, which could be backported
to stable kernel. I agree with you, it should better be made as
a development work on top of fix.
 
> Regardless...for now we should probably take this patch and do any
> further work on the code from that point. I'll plan to pick up the
> patch for now unless Al or Bruce want it.

Ok, thanks for clarifying, Jeff.
 
>>> then 
>>>
>>> ...
>>>> -		spin_lock_irqsave(&fa->fa_lock, flags);
>>>> +		read_lock(&fa->fa_lock);
>>>>  		if (fa->fa_file) {
>>>
>>> file = READ_ONCE(fa->fa_file)
>>>
>>> then we're not opening any new races, are we?
>>>
>>>>  			fown = &fa->fa_file->f_owner;
>>>>  			/* Don't send SIGURG to processes which have not set a
>>>> @@ -997,7 +996,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>>>>  			if (!(sig == SIGURG && fown->signum == 0))
>>>>  				send_sigio(fown, fa->fa_fd, band);
>>>>  		}
>>>> -		spin_unlock_irqrestore(&fa->fa_lock, flags);
>>>> +		read_unlock(&fa->fa_lock);
>>>>  		fa = rcu_dereference(fa->fa_next);
>>>>  	}
>>>>  }
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index c6baf767619e..297e2dcd9dd2 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -1250,7 +1250,7 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
>>>>  }
>>>>  
>>>>  struct fasync_struct {
>>>> -	spinlock_t		fa_lock;
>>>> +	rwlock_t		fa_lock;
>>>>  	int			magic;
>>>>  	int			fa_fd;
>>>>  	struct fasync_struct	*fa_next; /* singly linked list */
>>
>> Kirill

Kirill
