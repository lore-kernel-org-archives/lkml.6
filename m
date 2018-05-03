Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeECKxD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:53:03 -0400
Received: from mail-eopbgr50116.outbound.protection.outlook.com ([40.107.5.116]:18464
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751354AbeECKxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:53:00 -0400
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
 <20180426130700.GP17484@dhcp22.suse.cz> <87efj2q6sq.fsf@xmission.com>
 <20180426192818.GX17484@dhcp22.suse.cz>
 <20180427070848.GA17484@dhcp22.suse.cz> <87r2n01q58.fsf@xmission.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <4d9cfb63-dc7f-1469-161d-1bbce3d0c393@virtuozzo.com>
Date: Thu, 3 May 2018 13:52:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87r2n01q58.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: CWLP265CA0199.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4e::19) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:Nfwb4esjX3nTGYiapcH+nDssy+6e1nMeWT+9hVFP2HFv5P739p8JW24qun9NGqm2kuOrhZ2LJd6bN3r11wLpgF+qbpRDAhVEj3FOHzx9r4NRFyPgV+paYYN33Dy1A2zcEnJgmSRlbPcfXF2Q/79FdH8ELpuIprUu0hAx+S0ziMxHa00xx0u3orNigCdt6SaJ2siUs64DmPKWJPYYYVP01r8sI5aLbUbACSq0zI0du2H4rtxUzBNwC/0xxdEjMRnt;25:jDJE+Qi2oNwxUMxGeSsC3ufN2PLjNHKJZz4AVh8QMXhZCtnxx13SFc+uHofqJqPXIhCEsam3Sz0ByJmSKKZfvsIdRi2eriffaJpeVQhEHlOzJCIQsOFD0ocy0/iSqGxLbhhAqhRZfj7HsH9ctn/8xkSsrXvYSNRYCy6tTSjiYOoA9T4+gDWMVgwK8V8XPBEy4UdJgSnZm1NgB4GJRDZSwJ855F704AL3hSLpuS390nooyQbkQ6HYib0DbOSkQX4TWtgRmD0jb6XDyKoz+T9ZoCMRgfa7/qxdUZlJVKrD65BKXMxlGJDDpbCAB24r5lc4UVJA3UYdamCcjYqaX89ILw==;31:5xOOyZbKUNOT1lO1le6PCkWJ6nKXNaeGrpL4ORkehLf3ZRCX3USr7oqGvi/lszAPIZOIdQOcjZ7aYRGzQxESncO/41BBl0FfAcAEEKcNPwqrNN+QeX2zKeCgHq4TEfJ3IjlR5ci7q2iAh9iplD2BIf5PSWevwYfRb2QKjTPzShPH7h40/Vbz9c1HxBPiFOC1jN106wRbrCvcqHZ/saBrpOCb5rhSL8sBxF6UVgvSXWc=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:CI3plXukRcrzd2Re1YdDap3p1W4vA2XgZXvx9bmLFyetNIZx2L5d1xHQaMQR861KlcCMkuboPaP+2eMb+gDJgTvGgaRmZDDX9xVKOE/m3PnuE2maNBmGX2qEiWV8r/1yEwB/J44aFmxiYrEWX9VQRf7km1EkevOAFJ2qUkK4iHIVgd/UPw3/4zh8y6EMLa/AhwhBYq2jOBwsLE82wEAs5JdVPUrPaiVojnvEC5IZMh02Z5rUHRAxMXrAFsjMDhb9qmwp3sESPFdR8NCEg1jxEodfUTo5y4udlkIgYqQ/7EvkyinrnUyJf6MS7F6iU0YTyEgJ1wwUNR5C1vEOnpKrZ+oL96gT9jsfcisM4DTnjq6/keP1OUBOkN3WzWMy28eEkiICk6LV0CXEjzdB5Vgc+fRl8da569cqWCQVwaW21Nn7cTgtGgzBdAcNXnc811qJPYvjifJcdVCZQTfsJ9UVx3b7fUo+8tDySZ/cTBChU4TJz4NMJ8Q1MO1Jmi/cJUjk;4:1uujQ57kZGQozeAZyo9HGjYWYCYq+obLE1/mOqpznj608+gIBnaaLSqYQ7QdH+Wz1JAnoMiXyshNanNA6CnqbVQ7dpRRaj7+svNkqnV+sI9utbTzHaAK6X59qUmQbjqfLuaIJif6Auxd2qJWP1BopcPc7IL8jaVS4xnVQ/SgyiWR+BJemsVCM2IDMmxj47ORRcouhO8/BHvYZ/o6biOXf+UUHZozPR0QsonvZVbUsa9ovLbRYC1hjHkda4SMtaK20f05n/evCTQIQSLDGpvu36pBhtAbDZlSdg4/Xwy2bJZXOgst/gW/2yYNf9JHV9IL
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342074BA71CB39096640838CD870@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(346002)(396003)(366004)(39840400004)(189003)(52314003)(377424004)(199004)(478600001)(6666003)(7736002)(6116002)(8936002)(3846002)(31696002)(16526019)(31686004)(230700001)(956004)(476003)(8676002)(106356001)(25786009)(39060400002)(2616005)(6306002)(486006)(446003)(86362001)(316002)(5890100001)(6246003)(966005)(11346002)(81156014)(81166006)(16576012)(105586002)(53936002)(68736007)(65806001)(26005)(186003)(66066001)(6486002)(65956001)(77096007)(47776003)(36756003)(305945005)(50466002)(7416002)(2906002)(52116002)(2486003)(23676004)(5660300001)(53546011)(52146003)(65826007)(93886005)(110136005)(386003)(97736004)(58126008)(4326008)(229853002)(64126003)(59450400001)(76176011)(55236004)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:[172.16.45.234];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6NGpBSENMMzJFclJ0WFE0SmRxaGNJaUc0?=
 =?utf-8?B?QU1yQXFLQUwyQ1QzUFBXRFBqYTd1MG5GNnJMcmpENnpFWVFxZnRHL05OMGkz?=
 =?utf-8?B?Rmd3TFdLcTBCcHM0b3VKL0YwaGp0cEpzTjhUVWFnWlYwekw1YVBoQUJvSTZJ?=
 =?utf-8?B?OUNZNUVWM1BGR0IxTkF1TFhtbXdEaEFzd2YxekdFMmhsN1VHaUd1MXFRc2hD?=
 =?utf-8?B?S1YyYTRGcjRvcnd6dDg4TnVQNEtPL243SEUwYVBzSGplNzBqcDNRZWlxemUv?=
 =?utf-8?B?d0QvMjNCV0doeFhjVGQwWitOVWtHcHBTSVk1RzFIZWJMdVhGSi8rL1ZSTHNC?=
 =?utf-8?B?ZU1MQWxsV0JzSzZKUVJrb3J6VUxlVlAxWjZQMExoZzdRRUc3TEZZWVhudnNL?=
 =?utf-8?B?cy9SejJZOFZqRmt5K1R2QlRPeUxFeVVXMUJ4bktGRGJ6UVhxZUxSSkR3V0Zy?=
 =?utf-8?B?MWtHSXFxSUNYc2k1Nnh0dGREZXk0anVJeUFYSFdjTGhYN2xBSzM5cGtjTXdN?=
 =?utf-8?B?U2ZZWjVkT0RYTjJDcm0vN3BxUFMyMlRCMURaN09WMlVmbVpvRXBFQ3dEUVM1?=
 =?utf-8?B?c2VkQThDekVtRDhWYXhSbngzbWd5T29ES2JtQVAyenFucGNmazk4MHdqQ252?=
 =?utf-8?B?eTJucjR4U09RQVZpOFdyQUR2ZVF2Q0cwcmZVNSs1d2hqb0VtZFVLR09zZzhq?=
 =?utf-8?B?SU9rZEltUkUzTFFScG01azZTUEdXL0drMUxmUnRmQWNQKzBrSmErdzNyK3FS?=
 =?utf-8?B?cW5LWkJZTkFVYWhYUjI4NEQ0RlpTZ1Rscjl6aVRLY3dXS2dlMmQ3MjJwME1E?=
 =?utf-8?B?cTRkN2EvMHZJeC9nRCtmVUtzdEo2UUdjU3MzZjFvS3czdnR0MVAwWHZjTjdn?=
 =?utf-8?B?dkRBcVVRVWNOTEZPNWxSbmwveEpVTHlDM2hyemNZT3J0c3RlTVBtL3NlMzJ6?=
 =?utf-8?B?d0x1R1piZnNVVkZacGIrclpvVCt5Yjl2Z3RTVUNuSnljdFcrRHAvOURWMnda?=
 =?utf-8?B?RUM1eTBzenBhVzdySGRodHNmelhnWi9IK1A5YnhDRVNFNk5pVHB1NHIxMldq?=
 =?utf-8?B?OUVVaS9uZmVud0ZKcGZkWm5ycHhzRDdOcUNQYy9pNHZtbE5xVWVSWExvWmo0?=
 =?utf-8?B?MFJoYk92Mnl6N2dLQVpXRERBQ2I2aXZMR0pQQUNjenZLUUFhMnJxRzVmZ2dS?=
 =?utf-8?B?bDJNaEV1OU90TEp3bzVObEREWE13YzBzQ1ZOSWJjMDdyWE1kTG5tOVRzdDR4?=
 =?utf-8?B?UjlUSmdtMTcvQzFTcDErYVVaVVFKK3djd0REY1IvRXM5b1Z3L3hmVFB1OFJM?=
 =?utf-8?B?TlZnb0I0Y3JEL05iWXZrbmFFZjA4eWtuR29yS2xtOGJRc29OK3BoMzM0b1p0?=
 =?utf-8?B?NU54RnJmZlo0S25aSW5xZTJ5TThPOWRRbkV0MlQyQkh0bGV2OHFId1liZ2hJ?=
 =?utf-8?B?V09oZGM5RnI4dFlxTEhuRzJDM2VwN05kZWFvVVRtT2huWGU3MzdCMHV5T3Bu?=
 =?utf-8?B?TlFZSW5ybzd5Rml0T0ZNbWhFS3N3eHV0d0RobWNSMlNHQzJtR3hISTRMZ1Rs?=
 =?utf-8?B?d2FLZW1PUXBCVXBvUGgzUHJCK1VwTXdLL01nVGR1K0ZtWWZsS3ZtWVhXSG93?=
 =?utf-8?B?UlhYcnIwN1JyajdQdkVkYTQ2a0dsVGppcUR4QmhsbFM5aGxwanZaQVdZU1F5?=
 =?utf-8?B?eHllY3FQd3gzWHpWcDNkWDFVcjZZUzJXSVFWZlNEMml1eGRWMFoxRk1rQWhV?=
 =?utf-8?B?dFFXUWY0TnZxclZLb25XWXU3L0M3UWRJZC9oVDhNOGdoVXR3N004bTlJaUxk?=
 =?utf-8?B?R1JUaW50WEtTeEFBeGZIYkpPRDBSL2prTldOc3dIUHRaSlJmWDh2UnFmRXMr?=
 =?utf-8?B?QWl2dDBNODRCc3JjTnRESlJPKzVDMnR5RjlWbENXM0dISllVTGJlMmNZNW1o?=
 =?utf-8?B?VENwR2IrakpTaWI1OTRoSUJmSUFkbEhUNzh2RUZDNE5HdndGUmY4Wlp5TlpR?=
 =?utf-8?B?UkRhQzZkYzFEQ0pZSitLYURhdE9DbmJjbzJITnhlYlAvT1I2UXdkR2FrR243?=
 =?utf-8?B?bW02YXh1aHNpeUJHdmhZaUI5Z0ZRQjM1a3FOT3NUbmFONTRJUzlhazFrQldp?=
 =?utf-8?B?MG9oM3VsTDFrUXBmN1p3TGJVRVZGanJ6SFlIelJrU1EzNEl2MkJ0M21OOFQ0?=
 =?utf-8?B?Ui9pWlBEVkdaaURXRUxzUTRuRFUxZ1UrSE1xOEU4bU12cU15cjZqUjE2ZGlx?=
 =?utf-8?Q?2xU+Dc7wH+iZutx6ghBa?=
X-Microsoft-Antispam-Message-Info: eV6KB+CWz/IqSM143VvdRquem7xFNo1qNMAh28ID81llM20yjZHtbXG/v06slo/iLmbMPfow2WH6To1/eJ0GM4oa3DOd2VhZ9WgwRdPSXLN3sjFToG3q4R0EFUE5YepkdnyRLYmC78hdt/4+HJJhCFIxlwAxKoz477fKSoo1/3l8dvFgqlrdpPX6ltYgtJY0
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:rG+VkI0QyRsiXx0RfOnF1CZRguuiWBbZkD5A+ukMKDxvGxzV3qm8m+VE2lPIWxcVAWcPMDk1Uvm6njPZ4TZorJu6rUmEaFRvpa0GEkAWV1bC3RdFddqYEOze220tbX8ADoAZUb1wrrNPFiS8d4wvhUPMpkF7vSKviGcCd4RaTmAlcIRrtTy4cICw/NlUSeD5qSQFWGP8x+k5pMsIiy0F8aR4oMR519OB1f3VXJtJEF38fpwRCHddk90FypmMSxbhv8d/w9FViAZ9QjmknhnThWinwDQsMCOAU11qDFWlWBfVp7bCGW5A81vNDqh9LoAlWWYVzxW82EAam3pDl8NUiIAUt/WNuS99LVA+hDFxgFi1LAwC5xH9Ae0p0J4jtGZTXQCob9LjIUU+X8APc7S3RYEMVBjcSEpDMUhQt/TxyzMSzMzbJDETQZunVPYVqXLUG9G19Ve5jzob/a/FJ8IhNw==;5:yceB55cODDGfsimw9r6WtKcjVSncK0HN6HxB0kOj55m/dB5YLjEeAGuug3CBJdJiWA2FHCFiU5BS5QhN832IDoOQ66Mh1TDGEquLjztGFNTfmwg3fhN02DfvzkvDw2HSkhxTnYayjSs3mL2IandUg2J5N9pucwbWc+LpKN+T5v8=;24:KD6nkX0Ty+Cqe04n2hisA/xiDcJOI9mFr3h371+5Kk/v+folpj3FihnCysRd3zoCH6btI4jcAUi/ndMbYJlgprQEim8NsXyV7LTqHMOJIcM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:+wVzrMLt2t/Gg4mAl2xV4tQOO5J4lPZGD+UTB5uro92w9PUwf003VEGfe7EFt5+w4UMS0aZMNO9Nzk8L+Qm8ewKlloGDryfTLQNuX3hl1UjWQWvL8GZXl4vSLCDTlm8Ub0aCeGyIiLmTbK2hjbaeM9FV0NvWSq4lnIriPnYcbawwDYTtanDPLLs5Woci/cB+ppHZ72ROV9EmhSQv//rirzMwtzXtJyIAtUJEtiryCF43EVGHVKiJaLq6iH088zox;20:xGnbXyxsBmsUpEsDaf40tinXQd3xvIRXoyP6RVDuPCTKMqFcozWSvbNQuJvXv8qub96L4CEGQkYVHGdFFje4/i5B6lGVTxikCc1G+oHNJbx+UkLdKEGAZesXF8Gk3tqY6aCl4y0IsPsIOs4LWI6mdwcGX7e+p8ZqkEhUFTH/S+o=
X-MS-Office365-Filtering-Correlation-Id: f79c161a-e8ff-4a7e-0d39-08d5b0e40775
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 10:52:54.7405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79c161a-e8ff-4a7e-0d39-08d5b0e40775
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.2018 21:05, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
>> On Thu 26-04-18 21:28:18, Michal Hocko wrote:
>>> On Thu 26-04-18 11:19:33, Eric W. Biederman wrote:
>>>> Michal Hocko <mhocko@kernel.org> writes:
>>>>
>>>>> I've had a patch to remove owner few years back. It needed some work
>>>>> to finish but maybe that would be a better than try to make
>>>>> non-scalable thing suck less.
>>>>
>>>> I have a question.  Would it be reasonable to just have a mm->memcg?
>>>> That would appear to be the simplest solution to the problem.
>>>
>>> I do not remember details. Have to re-read the whole thing again. Hope
>>> to get to this soon but with the current jet lag and backlog from the
>>> LSFMM I rather not promis anything. Going with mm->memcg would be the
>>> most simple of course but I have a very vague recollection that it was
>>> not possible. Maybe I misremember...
>>
>> Just for the record, the last version where I've tried to remove owner
>> was posted here: http://lkml.kernel.org/r/1436358472-29137-1-git-send-email-mhocko@kernel.org
>>
>> I didn't get to remember details yet, but the primary problem was the
>> task migration between cgroups and the nasty case when different thread
>> grounds share the mm. At some point I just suggested to not care
>> about semantic of these weird threads all that much. We can either
>> migrate all tasks sharing the mm struct or just keep the inconsistency.
>>
>> Anyway, removing this ugliness would be so cool!
> 
> I suspect the only common user of CLONE_VM today is vfork.  And I do
> think it is crazy to migrate a process that has called vfork before
> calling exec.  Other useses of CLONE_VM seem even crazier.
> 
> I think the easiest change to make in mem_cgroup_can_attach would
> be just to change the test for when charges are migrated.  AKA
> 
> from:
> 
> 	if (mm->owner == p) {
>         	....
>         }
> 
> to
> 	if (mem_cgroup_from_task(p) == mm->memcg) {
>         	...
>         }
> 
> That allows using mm->memcg with no new limitations on when migration
> can be called.  In crazy cases that has the potential to change which
> memcgroup the charges are accounted to, but the choice is already
> somewhat arbitrary so I don't think that will be a problem.  Especially
> given that mm_update_next_owner does not migrate charges if the next
> owner is in a different memory cgroup.  A mm with tasks using it in
> two different cgroups is already questionable if not outright
> problematic.
> 
> 
> Kirill Tkhai do you think you would be able adapt Michal Hoko's old
> patch at https://marc.info/?l=linux-kernel&m=143635857131756&w=2
> that replaces mm->owner with mm->memcg?

I was at vacation. Sorry for the late reply.
 
> We probably want to outlaw migrating an mm where we are not migrating
> all of the mm->users eventually.  Just because that case is crazy.
> But it doesn't look like we need to do that to fix the memory control
> group data structures.

Kirill
