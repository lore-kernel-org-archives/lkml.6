Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeFEItA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:49:00 -0400
Received: from mail-ve1eur01on0104.outbound.protection.outlook.com ([104.47.1.104]:49901
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751343AbeFEIs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:48:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner()
 more scalable
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@kernel.org>
Cc: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz> <877enj9uwf.fsf@xmission.com>
 <20180601135725.GE15278@dhcp22.suse.cz> <87a7sey3ud.fsf@xmission.com>
 <20180601150219.GG15278@dhcp22.suse.cz> <87y3fyv88o.fsf@xmission.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <c1be5b75-d17b-2bbf-8bd2-4e6ade54bdae@virtuozzo.com>
Date: Tue, 5 Jun 2018 11:48:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87y3fyv88o.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR09CA0073.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::17) To DB6PR0801MB1335.eurprd08.prod.outlook.com
 (2603:10a6:4:b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1335;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;3:ZJ2iUbNAWjjQjekbFbE4qeOzXO1npSt9j0GyNej5uXRL1cHVSDJCwQYaL/53BltZTmJ7wDyw63HoruBeKsztBgNMlcF8io6liN1abUAKUJz7HlW7QPphdKLHxsGa5xu+ZHstZq0XeHA9QwnXQ/4YYEjXt7RMzOCQhW+hR3bHQGbWFaqS/hv3fRMe3Zwq75BkI5y3uO6Yfax9pmEK0J0vtg1VafmLKttvexMzLygtSwvJjQjAf6Gd+R7lUTLVeg7r;25:fy56k29Nso8YggMdDh2Q4Fg+N7fBnKQbamhAUSKijP0HNTr27o8y7YKAPeEJZ2xNaVgKFRtw4zG/I2YUUajlr+ZErOUP/lFmp2jJISwjVgQ8qIft8IhR7HD/uAxXjRDdT8XbxY+Xb87Bkam2jG7NR0HoX56k2c/WNfWCeEefwA0p87/EjxakeCTEj+ahAP+Tc/HehTteXmwp9W5FBamTX0k68B1opI85m6tx9jLPOZ9kOCPo0dtfJWj2TQKGug0gIYlrIAKuhkxY0cAQJJ8ar2aelSRo4kYkWPBTRF5mnVUznf4QY+Ji1wtWjUwMp9Cv3hH2rOkhtD0jQ0k3KxwXAA==;31:BbCeqmnlJnlMvwqeEGnOLeH8LQdfIlOCxT0X3VbyxfqC8VA/EBxUguwGusi1vT2nWBW79j27FwDESUiKdYTMQFmfJiaYtKHRcjcxJ2qnkX7OjLgmaxtxGioZtVrMpJAUcU7Oq71zH+a869wLwCuUSwZBmrGd4mo+mbanvxKduFRrti5RL0GaktKKWnrEdyF/ouA8BqWGxVGpMo4XpalkYi7NVX4n1H8yw2zszMrGnvw=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1335:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;20:7GOhjzqwmVsFlVtJjj7FtJerAp2G6TfCoqxm7Piegd2Nkc2chzTi3iwuG1vkUXudxQpDTI5CvvxcMsOUKVM9jWL+QGjodrGCLS2GyZI0KcugiHzlFALnC+82dZayX8tUWJAtacODTUSQcYOOaksD2yJ1gJzWZQvCTMA5y6t1IlreHH5qwmyHTdozFgR/IDyfxFfXxkPbOaU2Ds2hcR0ChrDAh1GoY5sgCDreC20UqXCZORzM+UIf1l35Rxx9RZSIeDQyUgyVIlNFSKIIX4RsjvNvIiM1WurdtuRvQFvH1o/G5miqw6JS4WlKCN7RGo8hO1y+D3psGhGGKjT/fBlyg3IJCbovkyQgwmJ47sGiANBk6Urq9Ztyt9KMev2N+zNTv6x3aM64kexFmRxs07xzAk4kHgXH0eSZanSnzTKxMy54skttKk/RY575iM8++KOuOiPL3KAsL3aLOZY73vy1sLuAfszMOpYUwCFmk4b0QklugDsjBjqGw1awZB8IFrcC;4:QTCGA3rjnARHwcUuPNPcEK+8v/OLR64GRxHr3BhgyfhNgVfBghd8X94Yj7mT1ARRqhmpq9Gqs7GwYLrte+zLkM5GI8Axa5bn6Ky6KrmlOvG8t9I8QXu4GXnUMcmd8/0Yzj+uni5s4OHq6PEaYe+e58NzNrw72/wnmvv33wGtaIF0Z02re5gwF41kmohV869goLuSmNWYEcLvdgMsK4skW88N975cvFKRRM8hjsjLEJhgAPJoeT+j8msLJ1QsiESYpAHnqz48GDR6DHLwz++Q6mvX62Hu5dtUbtisYjwFd8T4voszWP6wfAU6vfJeQOy8
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1335C696D0E18108A31F85C7CD660@DB6PR0801MB1335.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1335;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1335;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(346002)(396003)(366004)(39850400004)(189003)(199004)(486006)(6116002)(77096007)(65956001)(65806001)(36756003)(7416002)(6486002)(4326008)(97736004)(229853002)(66066001)(305945005)(16576012)(58126008)(7736002)(50466002)(5660300001)(316002)(47776003)(39060400002)(53546011)(23676004)(2486003)(31686004)(230700001)(52146003)(52116002)(186003)(105586002)(106356001)(2616005)(110136005)(956004)(6666003)(64126003)(2906002)(478600001)(6246003)(81166006)(65826007)(86362001)(25786009)(446003)(8676002)(11346002)(16526019)(68736007)(3846002)(81156014)(55236004)(476003)(26005)(76176011)(53936002)(93886005)(8936002)(31696002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1335;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzU7MjM6bm9wMVgwMTl3WEFSeGJhWnB3WU43dWtW?=
 =?utf-8?B?dkc0Z2d4Q29XdmNaWHF3QUlrRi8rOGhoYWp3VHdkS01CakxZSTAwRXRFR1dx?=
 =?utf-8?B?YjV0RHhhR3E1SDIvamY4SUt3RjVpRDdIbi84cmJnU05OMXlOd1NldDh6SE9U?=
 =?utf-8?B?cjlGQm5pbVIvelNySTNtQTNvSjUvZnVJYW9kYmFzKzU0anNZaUMvRjdNV1Rm?=
 =?utf-8?B?QTlsUG1kZHJyUGY2cUtWNDFuN0hDWGszVzF2TlBPL05jaCszZHdvUlNjdk1O?=
 =?utf-8?B?d256bEFFeFhqci9iUGt0RkVRRUxndmZKM3lBM3hSQzRPRzIrRlJDSWtsSldp?=
 =?utf-8?B?Z1phRDh5WnR3b2xRaG56S1JLRTZSTWIxV0VndFJvQnFIVEtMYXBxYlRzN0Fp?=
 =?utf-8?B?NkhsR21DOW1jRVRVSjJWTktaV0MrMGFDUU4rYUZaWjNHSG1nTmRpeHhlb3hz?=
 =?utf-8?B?WU9NQXZybU1LRHZXbXpaT1F3Ykt5M09JOG1oMDZ5TXEyOGRFODJqcXBYa3Fo?=
 =?utf-8?B?TGQ0bjhiS3VGSElhbDRYZDQ4RjI4alB6ckd3eHFIa09vcFBISnJiVGt1cmkv?=
 =?utf-8?B?TldrcWRLV2ZTcFJ1bDUxV21LSHZmeEhMUUwvdEhveHQzVG8vcjQxTWluZkt1?=
 =?utf-8?B?N3BwODhNdWY3V1lQcFNVVjhReWV3aWJLZXJURHhKY0xncnVkSWtLTjRxVVpF?=
 =?utf-8?B?T2VuSmlvTG5IYTJnUSt6ZGhZZmlOZHh4ZG1LNUhNRVhoNFhodVc4RERhN28x?=
 =?utf-8?B?b3JjTUpDeDlwNjRUWld0eVd5L1VwdEtuRjFXOFpjQ3hsUHM1cXBSRk92MzUr?=
 =?utf-8?B?azNtazFFWXdyblE4Rk04aDNxS3BWTXZTbTB6eDZRakhRT3MrcjBLRWtGY0x4?=
 =?utf-8?B?dFo0cTZIUDdibEhZQit5em1xZytwaTJCZTdJQkJxNENOaGR4dzkxY1FDMHZF?=
 =?utf-8?B?aVEyZC9TTlJrRmoyb2tyVDMwQ05WT3ZLTmQ2VmtzamthUkRhK1U4TTBJZE4z?=
 =?utf-8?B?N0I3U3ZhcHpiYnBHS2xabWcydHRyVU1Vck5VMXBkQXhOUkhOb0FwQm9RWUEv?=
 =?utf-8?B?ZU10NGJZMDZpQ0YzRStHWnFxRlZTN2lVMDhPbk9UQ1pBcmtyOGJwbzk3QTh4?=
 =?utf-8?B?M3VrTWZlVUppSnJjdXdydC9UNkN2TFUybGU3VStwZkl5aVpadTJXaEdCNHQ0?=
 =?utf-8?B?c2MyaUdWOGZSSXJxSlZtWmRTQkFOaG9BeWRoWk85SWw2Z2JBMzN4TDFad1li?=
 =?utf-8?B?a2gzMW14aVpLbjBaUVNXSFB6eklNMmFqc1FtajNHdE9OUWI0WFhUNXU5ZjB6?=
 =?utf-8?B?TStYb2krY2xzaWZPTnQ3MHUvUTZneEcxVVdPRFdEUjBZQ28ybG9OcjAzdWlU?=
 =?utf-8?B?Z2VnMXFySzk2cll0N0JYK2k2OVJUNzBwWkpCWStFQ2NxeFlBWXRMYTE0SVhY?=
 =?utf-8?B?dUozUnRQazJxYXhsVDAvUUdYd25XMTRubHpBRDkydU5QaE5CcnNNMTZqejE3?=
 =?utf-8?B?SzdDYU9UblBPY3Rkb0pLV3JBRnZiRFhwS1FXcDQ0L28vUmZCdW93Uy9zbytB?=
 =?utf-8?B?b1hsN3l6b1lzRjVha2hQMHFuSTFJTkZPcDdZZ3dlTlB0NVFRN1AvUFArQmRl?=
 =?utf-8?B?aVpXYVFvS0hPUUN5cXFMVmVDdDVaNjZQUEowelhVS2lvQXgrQ2RYZHJ2aVB4?=
 =?utf-8?B?eU9PdldJVVdRaVE1REpIMG5IQWxzclprODl2Mm1CZHFLZ3FGR1ZBZWNYT3FK?=
 =?utf-8?B?cnpnc2MyejlHeWlNOUpQRmx4dFlLVlRnQld4dC9LZTFzc2hLT3N5aDl0SkN0?=
 =?utf-8?B?MWJHWTVUa3p2VjZmY3llc0wxUDJHOUcyTWRhZGxWZnZCc1JZeG56Rlh3WjMv?=
 =?utf-8?B?b0lnSVFhOG04U0p2eXhVK1FoekRrdU5rL1FVcC9ibk5ZN3IydWdJYnhxalVD?=
 =?utf-8?B?MmVFMlJabGI5M1pwdGhVYjkyaUY0UzJJQVZ0Z0w3WlBYS2VhRUp2UnFMaUEr?=
 =?utf-8?B?enVHRlFyZURwajFmZlBqV0RnWGRhdGlwdEFFYUtjcEUwdWhYYWk0Qy9qMlRF?=
 =?utf-8?Q?2jBqOs=3D?=
X-Microsoft-Antispam-Message-Info: 6gmBtL5F/SRlRJu0L8AK2U2ARtm0niqY+tauYu2KQN4vby2omWDY/ME0CvjTgmoZOUnA5e2OcLEsrz5/gIPqm7vHXOOnrKPOpey52TpisQ0vNIeNtVLH6ZBnH87stNnVpkSZuXQRJSWAsXBlrwlWdF2mMhYkyrSSkKf6H2mCN0a1wvYX6QlH/hp6WAd823hO
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;6:eIFrVvjwHKIT82I+vHinsf8F/FLzCl8sf1twYnAXJexgoYNEBBVNf3ztm9BZmQrjAJc75Lvw2YqGg1Wtcmgtk9qodvuq/iSZXp8nAWCtKlA1xYMdHFmG5bWThOnGC+UG+lyOjkV1UBp+vlrIMa0D6aft059kv0cQQdKLBkqHtKF4SMsSreHN1Cmoka216y9H48Lp3tWF2myB3frYYUg7g2g/EwV8dBB9RbhmtakWfCQ5mroKjiNdjl9rSgRovFel65iCTou64AmOMXz681C/W4hembj+v7EAifAxvoV/B33hAHvbBWMo/X+omTlarUQeK48lcaDKjkS5KwcPsCVvH58o05TImrboiNoCN/zFJ4kprGLJX4WQPi09Roj2S2KTmYbQOukNpg7QC08XdlfbFFIzqzJ7CMiAL5TNu1bXSlMwsBGcQ+ucpz+W95o3DZCs4l9+QNpZvmVp5CKoAyuC8g==;5:GoCfVxtCHsw2UJ1TEs/YvI21uZpHKIzmkymAfK46gBrMwgKhg+vf6qwhJeOBE7XIFioSabKuoj5Ttkn7dInl+5ayDAcmG5jHvWKJurXMnt59bcDFIorohuuoFLKnWBJd4BVKTEMxx3HbXgacJqa93SaABtzofH0QByi79FfsHmE=;24:o6ZqddUK7KzSBQFzOIhWj9N7lVuHB/7PHPQuZRhwu9w04qFPwG9qOCOZyglxmFbKDV2JisXZ7/SDSOyvAhxedVxFjmTB7U7T7SIw78eNGMg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1335;7:ymWsAMQEZTNVpjKXY/dUJCQytUvJ1wd4uF3gI5Q6YyKhcN0A9NfxuGu1Op2bJaUWjkwr/XsJ13pzALnf1lUlOOu8/iN8Jj0FOkKA7RmLqEPHimSDmrRBClY0T3DFBH/wOftVmA2ZF0/4Wx6xMqDatGdznCzUqljarG4IfCce6P8XzVM1GHSxDaRcTzCgTZ0wWpkOndIcoSWrrrPVkhkO1AztozdUoJGFfjpII5OdhibH4ocCgK8aOpKOIYfJ70l7;20:QvhkhRK5kP0JmHL8UeFxuZmyCXy/rsRUZNn4rvz13VPLMtY6RXAG8WlWZ8yZPCPnzz6nfnrARCkutaFDg8oChovfl2/sUTeHp9hdHV0H23g8qyIxQHISCgITvz0JKyFSytRJAToTrJhIzNkeOdz4v+WCqh9l4EbKMN/Cyb662+Q=
X-MS-Office365-Filtering-Correlation-Id: bf1d3ba1-c1b0-4076-b1ec-08d5cac12b2f
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 08:48:52.8514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1d3ba1-c1b0-4076-b1ec-08d5cac12b2f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1335
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.2018 18:25, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
>> On Fri 01-06-18 09:32:42, Eric W. Biederman wrote:
>>> Michal Hocko <mhocko@kernel.org> writes:
>> [...]
>>>> Group leader exiting early without tearing down the whole thread
>>>> group should be quite rare as well. No question that somebody might do
>>>> that on purpose though...
>>>
>>> The group leader exiting early is a completely legitimate and reasonable
>>> thing to do, even if it is rare.
>>
>> I am not saying it isn't legitimate. But the most common case is the
>> main thread waiting for its threads or calling exit which would tear the
>> whole group down. Is there any easy way to achieve this other than tkill
>> to group leader? Calling exit(3) from the leader performs group exit
>> IIRC.
> 
> pthread_exit from the group leader.
> 
>> I am not arguing this is non-issue. And it certainly is a problem once
>> somebody wants to be nasty... I was more interested how often this
>> really happens for sane workloads.
> 
> That is a fair question.  All I know for certain is that whatever Kirill
> Tkhai's workload was it was triggering this the slow path.

It was triggered on a server, where many VPS of many people are hosted.
Sorry, I have no an idea what they did.

Kirill
