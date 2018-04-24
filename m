Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeDXVCt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:02:49 -0400
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:23264
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750995AbeDXVCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:02:48 -0400
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David.Panariti@amd.com,
        oleg@redhat.com, ebiederm@xmission.com, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org, Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
 <20180424194418.GE25142@phenom.ffwll.local>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
Date: Tue, 24 Apr 2018 17:02:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180424194418.GE25142@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b::4]
X-ClientProxiedBy: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To BN6PR1201MB0113.namprd12.prod.outlook.com
 (2603:10b6:405:55::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:BN6PR1201MB0113;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0113;3:shBBAP7SsfOkEYQon3EbXfxMzXFGJ/DaHvjPL4XCHxYHb8tDAWgkHYqDQJ40BlnBQp35I7ttXcgk78fUJ5Uj0t0n2KLU64PWutWJNJ5Nv7vAhz/jYgEBXfzfa9qX7iLzYX/fo8XnVqHSV/z+uQiWuctdYrcWdfp+ZN5GiWfGzT8aDDExGQ0fHMLWDDiqwFaFY2tumQjGg4xlca2yVtL5+sf/F+RfhoLa9tTNmfjbCNSdLaCJy712aKrUe/4oPF2Y;25:AD1Sd6MNGPUY8MZEc8LZ6+uXxbJGjhiadkUcBqLcwitCrAFQrzzB6dw7LqnyUvtZT+9OUWgGFixsYJxNkSk7ohR4W7g96AG3KKyXPkRdjUhDoe2TFVa6ZrIs5vfV3KLm7RO17FEmp+OGU3qn8cmhPXujGskupGKn3XbHdOtUiah/sTXUc444+eSwwF07wglwHdsDF+8OtiT50XW87BhcZRl69onUkvliIgC2SAUvQTiCyevGybAK0ZumELcdYnbSMi5yQj+gU4k/DRYjRL51oWuwmg3vDF6EaLa3OhdgNUvX4z8NDwMu/IwMJS4TXc77AhMcCnUqWoRMpc11KdyT5w==;31:QMjrWK85p/WqxMuWSdHZOVkLmKn7CX6a2JXAGhWgBEbtykNbF/p4hrNY4lJi6GQCJoZ2mmfm37eDvpjzsqp72kQkCqLAtcdSWJGjZvjdE+HsGaI31crv82FUy5D1XlCI9n50cktQibEDf4kXCeRS8b2nB19QEzfcJ2EMlxwh1wh8TeIVsTjdufT6wG12kZ813gFDM/slUHhf+d3CGOcpom6LzxMSRQgdhKutCSFTr6w=
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0113:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0113;20:3tDD8Q0ie6hVLgOPp/x41J/vDQPd71u0dlC6aZCs3WdsVc6yPG2tKnxX+zQaEybVcDWt8s1qWrszo0f74WlpfD1iBXc2T8vlFZNFiXuIlNwsU3BDiN+u2+JNbMpccj5ckKY7+tMWP+78qxQHyeA1ctLEfx3RtgZ8OJfUGTXCaKM5AVyQVyKaW+ekUe5ahR6fPDLoEMgwxQruG43Yzjn14lXkQV+4DUiuf8oT/TpD6IqrfyJPhiRotVDyYZliMtlCw2ekWbrJ7BFD8poapacqd1+AxWVyIbA88cDXBw9dn8+PUxOlT75I8Y9lKQRGSOibPhkzybf6S5JOCXQdiat3zvjMtuuTbEPMKXndHLtqVIrjWTk9oV7IIoS5M6NmHGI7cGPYk4WckT08DedGqkUgnoAcHu5j7yuIGoqndzSGp3CUTDbDlQubr5iSEI8c0FQ03Qo9eoDIpS4ecJtC3CeHExRc3Ye5ThNjgGbmGkvpEhBK/EClv+JAfOyWdE3VYh6H;4:YnqCi8QrQf1q3FqoTmKi0CzUJYXvIqFcKVy6lVYXksO9Sx6MQlGP+UsU0LmXElNvNNqz9Ur+WAi3Y9sJQ/WDQRLEZGSXntZWOTCxYQE9+il62Bn+80NTvugXOsdU3cJqRRo05y9jY3vh7YcSiNGVgyXsPwfoSGxudkmTZjwAWlbWz6xNO8Mx8FVN9nf3+Y/7D9SPeAUKaIKXhIXiNpiOC4RuiDaRSafzHIJduwzrj7LdWAfXKPrdn2WOahK5lZ+dexcGOxBSMW+PtU/UBCF/V+4l0FaG/5eP41QRPDheVf0H9VRS3kmjMgp8nzKOPK3CYATTUmUGc+9sCCeFm2M14E/aZTXB6LttXF9IuWXb2SNsopxMwNDGHzM3Vk39NO8x
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0113BCE0A13EF9D8F370E963EA880@BN6PR1201MB0113.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(95223839027130)(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR1201MB0113;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1201MB0113;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(366004)(39380400002)(189003)(199004)(377424004)(2870700001)(16526019)(6116002)(59450400001)(46003)(8936002)(67846002)(6486002)(31696002)(86362001)(2906002)(5660300001)(105586002)(65826007)(6246003)(68736007)(8676002)(81156014)(305945005)(81166006)(53386004)(2616005)(53936002)(11346002)(476003)(486006)(446003)(6306002)(229853002)(1706002)(6666003)(6636002)(52116002)(52146003)(2486003)(76176011)(23676004)(53546011)(966005)(93886005)(36756003)(65956001)(52396003)(386003)(7736002)(58126008)(97736004)(47776003)(316002)(72206003)(65806001)(478600001)(31686004)(50466002)(106356001)(25786009)(64126003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1201MB0113;H:[IPv6:2607:fea8:3ce0:41b::4];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyMDFNQjAxMTM7MjM6Z3hZaG5icExQbnFFQyswc25RYjZPL3lr?=
 =?utf-8?B?bllsRnB1UGx4SFRsNjFaREpKaHhmeXhnVjhsWCtkdG56VTAyQk90TVdnTERI?=
 =?utf-8?B?cnB3TlkzV2trVG9vek1OY0g0dlowNWVVa0ZVNC85cE5MSlpyQXZIODZrSVl5?=
 =?utf-8?B?RGJCYlJLTVB5QjVEK1VuWTdKc3E3RWRqc1hrb2l5SkFOaTB1Qml0alNSVjFP?=
 =?utf-8?B?RUUyQTUwWmdFOHZvYUtaTXdYTFo2dXFpY0szMDlsMEt4QVZ4WDJnNTlOUmE2?=
 =?utf-8?B?Z0RZM0I2dzlaWHlXZTVvSWNUaWpOTXZqQVJwWXd5QzR0REJsN3hxazVzM2pI?=
 =?utf-8?B?RUdkZ2RkQVZ1aXVpdkNQZUlPRTFDV0tRWjJkT3BFRDQvOHhycDBzNGUzd0xo?=
 =?utf-8?B?M1k1aGdZeFZsRlBkejlnN1g0K09lRFFnVGN4c1RCb2dxeU8xLzhwUnUveHIy?=
 =?utf-8?B?R3o1RkxjOTV6a1NMc0tCQ0dGdFdsZEhyQW9xYmFSTnVSbHBQKzNBZ3BCTyti?=
 =?utf-8?B?enh0YTZzOVdPSFZ3ckdjY0F4ZVUzenV6NU8xL09rS0FMVHhUZjIrVkM5YjFl?=
 =?utf-8?B?NjNseUpWbVg2M29nZkhNeTY0YktjdnBwTDVKcjBpT2J3c3B5RkIvRHFTdmpj?=
 =?utf-8?B?TU9pRFpGYjdhQ1FyYXZtTWFrOE1aSkZVRUx0VjRMckg5czdLdUdKUGZncS9I?=
 =?utf-8?B?UDYyRklHMktlRnZEZHhxOGhlK1BWVDliRzF6dlJ6NHMrMFN1YUtYZVZBeUoz?=
 =?utf-8?B?S1FMZGRvc28wNE1IZ3M3Vmc3SWtBNGc1UXNBOGZyQ29KWDltZWpjaTlwdzFO?=
 =?utf-8?B?bkdxbWtSWktnOUVnaVo4SWxsbjdGVENMNm9SSnN5RGpNWkdkRlY1am5aa01l?=
 =?utf-8?B?T1lhSC84b1F0NDdSQjZGTWd5V04vODN5dC9uM1JTUjNjM0VNelF4L1N3cjBH?=
 =?utf-8?B?SDZaSVM2V05tajZ4dm5pSm81d1p6elVZZzJnQ0ZpT2t5Y0l4OWVJVmtJd1hI?=
 =?utf-8?B?SFhOdWdFRWtGSlNHOXl2MHQ4anFtaE1EWlBiNWJCN1owakt3TmZTbkM5SW1K?=
 =?utf-8?B?TXV3Uy96RHl2U2ppT3lUNHI4NlhENm1UWFMwdFBHZ1hVbmM0TTJhRUY1bWQ4?=
 =?utf-8?B?R0ZaUGhWc05WSU1hMEZ2amdXL3NKRGh3RnRDeDFxNDYxdjF3d1JSeG5lS0xo?=
 =?utf-8?B?bnRqNE5VUkRqb0U2SXhoc2M4U3N4cmZ1UFgxc20zL2ExeWlaRkd4R1hwQWlZ?=
 =?utf-8?B?by9KdEVvdWRManlYTlNOaGM5MnlCL0Z4dmk3cFYrQk5GV0VRNnQ1cW56SG5S?=
 =?utf-8?B?UTArQ0xHVEVjcy90UFRWNTI4a1BoUUNzTkVlazFIeUtpNGRSamFIcFhyeGJl?=
 =?utf-8?B?YnhmK1J3UDZpTXpCeS9zTTlTQUhMeGhJWWkxZXA1dWx4b3FHVFFFNUd6NWx1?=
 =?utf-8?B?bzE5M1ZCcTJqcjg0US85THlPbFVEb2VHVkJJTHVicHAwUnZ6azVPL1lOYlhj?=
 =?utf-8?B?QTlXaFRpaHJDNnZqTWNyWXhJZ0trOGtKRDRkZW5UWnErUkx4S0JmUlJoQjBk?=
 =?utf-8?B?cVl0bUVzb0NGN1dWbHRoa0N4MWF1azlsUUs4cjg3b0pGeFhoRGFJb2ZEUWE0?=
 =?utf-8?B?VUoycmxybDR4V2NsVEdyRk9IS29vRTZyMWhVK3hVeTE0K0MraS8rRE1YREJT?=
 =?utf-8?B?K3Jnam0rQW5RQWxoRVV2ZktCTzVlYnVYdmFJWEV2NXJreE1COFRIaG9rWFNT?=
 =?utf-8?B?R1dEUWVaaHNIbGhvVGJhaE5qdHlrT285SjFncElFWHQ5ZWdmWnlMV1JpRTJw?=
 =?utf-8?B?aVpjeWpXZWFGMGl4WW5QNVBoSUtXbXp3ZEN2ZUlVdU90Q1VnL1dITG90eEp2?=
 =?utf-8?B?QTZnaXJRVHB2VERDUm9CVlJzSms4T00vcTBuWTBxZXphUmFJK0J6QWlPMkk3?=
 =?utf-8?B?MmRwVEZVNTk1Qm53L2hYMUt6YVJhOXVqMy9yRDJLd21zR0lnRjg3eHl0dG0z?=
 =?utf-8?B?UEhQU0RGUHNkZllILzl0aUg2Syt0VlZHSUpJSWJqeTN4YXdkOGhENzRIdERY?=
 =?utf-8?Q?W8ei+8=3D?=
X-Microsoft-Antispam-Message-Info: 0TVs3YU+YCC7vguXZH7lNV5c0+CGcxVUKl8hPlaRHWALBZbCP1aSeyQKdc5pbRlAMBl7tiI681PxC0azRmHiKYWvqhSZo4a9Y76tVBpXXGg9l4m1PFRYhuz+O3NPyVP0bINUl6ocFmh9GybNLUBduPKkyzO2TlWbCSvAANlzNIgwXQ6Iq6DwZNj/2FSSZbrJ
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0113;6:RmhS8OnW4wX0nT+iS8aIxg4KI1jPVtPs+DT13AyeTY76CFLPCKY0ZbUzVjiS1bFlyKdIxtgQvbx93EPA/FxFAwHr0CVXod9qkdD0RBxZAv9s8UGVHyZie5skLKGnv1Ifs8FYGiTH6W+B4GiNFlm7gT+bcTGRDiGi25BjoHc/VAQy54O7fYh5lwKXTO4oc9ieBrX4aknRsTRRFy31vwKtRO22qQnclcYezCAIZv0uhNtKWKePYX8Xh4ZFbCAJcUhmfH7LRKsQErJnFH5g2J1lLYoj+5IlVW22LdKSz9tCTQHWRPV7fLHo6EakpKJqvXicwynIUDSGUAWxlsVRMykT8HooZ22GB5kmxGWuAAJKOlG80VqIMXv1vHX/SqgRJ6c19DwF7hRM74BOt8Ee5S7RhYALh8OwiCUVYGc56SeSbpPCXxSXYHXZucgem/gNzqvhNhxsRVZ54c/y2Znx89UWCw==;5:QhggKJ2RrnOwOTs2xZSwPSimP2pqafZScmJyPjt4LfbgecOp5Uz8hpJbeDqhX8wxihX/NPidb9qh3CugGQPEIGjtO/kwff4lLPJE7Dsah8I9HhkKhjCCYWnNcTCxFPD4L48qZy/0zUi6Ts3Sz+yURXZuf6dzu0gdUjwJ++AmNdM=;24:zd6jr9aSonfB0Nc25VYy3uM9OvU9Cu14MCr/2CWb6bvZHh4Di4qOZzt+ErpRKyPSny8B3+CZ+GDPqAGXeUhs1HvxwyJGyMzL21JLUwu+dXY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR1201MB0113;7:RHQI1VBaBxcaFEKPA9D79U5rGIeUGDj+41t10sldb1Vl4GcH7LjxvfiqRz+q+5U9G6FzdeMA3VniaVAqJ+L85z6o+yY7IVKbVMwaELkF0RHMKfANIS1aX07BQuHPQ0+hm51RP7sFGe6yz1SkHJ6D6tF20uJWpqDun4Yf+NEF0UiTJlaGnWR/gXH3frasg6vzGkW1D1P90crcPhlrN04kdVxejj8rhqnEhNtYe8wLzjygOkDF47DtMPONOJ0rIYbX;20:Ow+xe8ChwD3iuNpxHapSeLLrm5oX3XUoiVvps+YjU2GjAA8dO1OLC0GsIJwsC3Ybus+ByEVkdw0U0+Ebpyo7X5necFMpxv2+uo2ZTyVFO73MZjem6UrM7XV06aVc8R0C62laPvlIAYn59oK42Qm1EQN2TArwMXyQRHDu+j8nA2rOoqPJ7QVrpbppgAO0+gtWHMMw3cAYCkIJripvaBjal/mcwKqdIWVi12Pf0L5T07muwB2xDv8e8GWBmDZu2/PQ
X-MS-Office365-Filtering-Correlation-Id: b12043f4-bf6a-4120-46ea-08d5aa26badc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 21:02:45.3583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12043f4-bf6a-4120-46ea-08d5aa26badc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0113
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 03:44 PM, Daniel Vetter wrote:
> On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
>> Adding the dri-devel list, since this is driver independent code.
>>
>>
>> On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
>>> Avoid calling wait_event_killable when you are possibly being called
>>> from get_signal routine since in that case you end up in a deadlock
>>> where you are alreay blocked in singla processing any trying to wait
>> Multiple typos here, "[...] already blocked in signal processing and [...]"?
>>
>>
>>> on a new signal.
>>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>> index 088ff2b..09fd258 100644
>>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>>   		return;
>>>   	/**
>>>   	 * The client will not queue more IBs during this fini, consume existing
>>> -	 * queued IBs or discard them on SIGKILL
>>> +	 * queued IBs or discard them when in death signal state since
>>> +	 * wait_event_killable can't receive signals in that state.
>>>   	*/
>>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>>> +	if (current->flags & PF_SIGNALED)
> You want fatal_signal_pending() here, instead of inventing your own broken
> version.

I rely on current->flags & PF_SIGNALED because this being set from 
within get_signal,
meaning I am within signal processing  in which case I want to avoid any 
signal based wait for that task,
 From what i see in the code, task_struct.pending.signal is being set 
for other threads in same
group (zap_other_threads) or for other scenarios, those task are still 
able to receive signals
so calling wait_event_killable there will not have problem.
>>>   		entity->fini_status = -ERESTARTSYS;
>>>   	else
>>>   		entity->fini_status = wait_event_killable(sched->job_scheduled,
> But really this smells like a bug in wait_event_killable, since
> wait_event_interruptible does not suffer from the same bug. It will return
> immediately when there's a signal pending.

Even when wait_event_interruptible is called as following - 
...->do_signal->get_signal->....->wait_event_interruptible ?
I haven't tried it but wait_event_interruptible is very much alike to 
wait_event_killable so I would assume it will also
not be interrupted if called like that. (Will give it a try just out of 
curiosity anyway)

Andrey

>
> I think this should be fixed in core code, not papered over in some
> subsystem.
> -Daniel
>
>>
>> -- 
>> Earthling Michel Dänzer               |               http://www.amd.com
>> Libre software enthusiast             |             Mesa and X developer
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
