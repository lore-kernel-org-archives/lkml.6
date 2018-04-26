Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756819AbeDZQEZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:04:25 -0400
Received: from mail-he1eur01on0134.outbound.protection.outlook.com ([104.47.0.134]:50010
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756519AbeDZQEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:04:23 -0400
Subject: Re: [PATCH 4/4] exit: Lockless iteration over task list in
 mm_update_next_owner()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        akpm@linux-foundation.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, mhocko@suse.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        ebiederm@xmission.com, dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <152474046779.29458.5294808258041953930.stgit@localhost.localdomain>
 <20180426123542.GA819@andrea>
 <c21ad28c-cd23-2a75-6622-ba49c37137db@virtuozzo.com>
 <20180426152053.GC4082@hirez.programming.kicks-ass.net>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <bea7d306-9742-10b8-3ef9-2a1594dac3a6@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:04:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426152053.GC4082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR1001CA0011.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::21) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:z4HJsc+axtj309ntzoWu9wLWg8u2qPjZ1fZBLXHTh+oVe3sEpt64n9uFoTmDlAjrL0xRxs0Wx8b4xa+2gh8OItFQhDZiCiddG7zeBi5NfcoCbAayjsCpTesOTdbNWwGsxxMbCMURMDmFhf4UugJT5vY5TeQo2wEyRw5wX0k9p2u5Rm5lyP1sTyv/oJD/ghRiuB8usTVvHusItULfwcayJezT4l8BaqEha8TxmLOgBOSYwM5t/pkGz7l883jEE2yi;25:CG2rAZI98cCaZiOqivXHnPvtWh9Jp4nDh0mffgdmVfkDlDafn3V3M4pRm8gVIcpfyoUY87dh92vzvZsd1ra06fz9/jszKIFjooENGhSRhTxyajFxMdoEZPt3rT9454HvNwfRM0SYddh7HPrmWEVP5V1iOGt6GZmCm9ZOr8HMowEZeZSOY1/rlOAoNpNfBhb8+MaAQqf1pllWwtUf54xP+IuxbMQZUe3ZaCDYraQHiVk15fwuf8dw0FlyvNgcWe1TX14OUdUqdwb9cA6+jGWCegr+MwhFiMyla3hLNVmR1GgQ3T5msP/zu5pMtYic7PQ0Na4QHQc2GL82Hj/XjvBAJw==;31:jgvHE6g5Ul7dZ545tySHyk/NQe7iNiLnkV5b9C38MaublCGzpqVaQoSi0ZcDASM4SzPkPWbCJs1BowL+J6zUkarkgMhfrtpgjuMYG/Sj0IJo5qSPaTuEic5q8M3xPhy4mOGZR2x13cu32J9D5Y7rwSr4odSsYhWaQQlaOPKj218Iv5oWSVVz6Pb6qfo4RoK5Wjie8h3PUf//8Z6w/lQFIzwlT8uyV1UF6FiIIpWYx2Q=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:142vjfb+/3UOmZkkZJ/hlzQsh0yjcPiDnHnD7f+SF7ar9hhVYpcBH5oW/4SoRGtzteu2ensNvxSDbbSnBWzN4u9s/G9WP+URrTIwShIqM0reT3PlhvTR2Gj5HII4eS5BbZQUpqKLZL33WCRIl9fcLGoWsrlttKcBVjLn4ImveMj/GrHklRvSMMa1GpnGKk09py6+zHwR+ziCFJBs9mdHbM1cwtka8aqgs7FVCj5WpYcoXpRlcLQkTgsWMKei8q8k1EBwLdHwfw93UaUjjdZl+Li1qfysTNVV6hp8YK9Xw5rM7lnc2r6KQaUcbHo0xIfNZ9mMDGSurWIIfuuhu6nop4NZoc1me4CsVi29q5Yaq5Yymj031ql/G2dWdhqI6QoX0oDanGeAzsC7bZWcvx2EZaZvPCH/qDV93Do5yIu1kCivtq7NxDwOUOrCZKgPAP772dDAhgzJG7wijM+bhTBDzr5zp1V02dHN/GoKX85yw6dmSVYvLpfEuveHZ1d3SY2P;4://e/pxTMO5OdZrkdERzifkulmxw6T5D75u+5BMolxYeCtXE68jdmDxZYASFkbDsZ3sLFqWqzy1QuWrJ5aQ/2Nti/T4tVjC/PissM2qiZqzt4utYkB64zyi/dcee7qVZn8SizNzpYyDMcAw5kC4SzTlcaRjXeJ0fX/s3r3ElJ+e3obcViA9Vx9QaZxYacwbM/JXJ59E4j3CF4epMTEM0GeLShVsCYSwXA2T6K5w7s7SXV+Soz0VvTyHO8wAovKuMTgZanOr7hJmz7gW8w3GUxnQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13393E7C0C68B36249221A21CD8E0@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(10201501046)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(366004)(39380400002)(39850400004)(346002)(189003)(199004)(68736007)(106356001)(65956001)(50466002)(229853002)(64126003)(6916009)(86362001)(25786009)(53936002)(54906003)(6246003)(5660300001)(81156014)(81166006)(36756003)(39060400002)(66066001)(65806001)(47776003)(6486002)(8676002)(55236004)(31696002)(8936002)(65826007)(2906002)(3846002)(58126008)(97736004)(26005)(16576012)(77096007)(478600001)(53546011)(316002)(4326008)(386003)(7736002)(93886005)(59450400001)(230700001)(16526019)(186003)(6116002)(7416002)(305945005)(446003)(6666003)(11346002)(956004)(52146003)(2616005)(2486003)(476003)(31686004)(52116002)(486006)(76176011)(105586002)(23676004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:[172.16.45.234];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6d05XaSt2ZGpqVjhrNTFwaVorYU93WmVm?=
 =?utf-8?B?RUpoWE5KZFViL1JHMkQxdjBRcE9GTXliRXJCTHhkdVR0a2JpMVhUK1RPeFpR?=
 =?utf-8?B?REUyKzhJenFzV1p3LzVtR1V5b3JsM2s0eExUY3NNOW9YVC8wd0pzNFJUUmpS?=
 =?utf-8?B?R2tFd0RwaXN1MVdHYm1pbytMVy9iVkdkczNILy9Fb2I0d1orZWVKTEE2Nmcy?=
 =?utf-8?B?Zzg2Wm43Ny9ySk1vUFJCSWZFTmtsRTY4MmU3OUp1V3hlY3hLMFJLcGZwQ1ZU?=
 =?utf-8?B?L2dnMG1wUzVySmJtV1J3S0JmYXJodTJtajFNUmdHRnN0K3ArUldLTWJ0ZEVq?=
 =?utf-8?B?UXFGTzhHWmwvNlZmZmtiOUtXVFNkcUR3VzMxOW1MR0xERkdnckpxZFE4Wng3?=
 =?utf-8?B?VW0xZmRZRTBBRnQrcDk3V0YwZ1V6eFR5eSt2c2pWRmd4TEJSOTErb05iVmdC?=
 =?utf-8?B?VFJVMjVlUTlhbWFETHhJQk54QVVzMFREVmRFc1hFVDJuUkluNFZrYXhDY0hN?=
 =?utf-8?B?ZS8ybHJGYUg4UEtGL0xlWStSdUVabEFPUTJvaXFkWjRHMkc0SlVwN2h3dGpQ?=
 =?utf-8?B?UmJ2dnFSYkZwcEdsTHd4WkxGN0xPOElaeGc2TThtOGhDcG9wS1N0cXUyVVhH?=
 =?utf-8?B?Znc0L0NXdlArS2dCTFFHTnFTczkxUXJ6bHpKRGltVEZNMGdtWXA3MFYvdFZF?=
 =?utf-8?B?L29RRjhKeDhOL2dNdmRjUzBlOXpKVVNMSlVYWVdIRm9oREtNcHN0dzRJei9m?=
 =?utf-8?B?RHdia1FDNzFoUmlaekhhUzNMVHlVcG9DQWkyOW9hc2JnSVFraEVEcmpDdGdu?=
 =?utf-8?B?dSt4ZmNNSkFWVzk4QnJ3K2hjekJQWStqZXRMV0QwdndrRlFRcTMzVGw5ckVI?=
 =?utf-8?B?SXAzdjJlQ2MxQWl2OGR4RU9IUWFNT3dnUnBkWHF3ZjFDVk5Mdm9OaVVLNnJy?=
 =?utf-8?B?UUEvVndLUHJmdEhqN1FPUGxObFVXSVIwZGhCbDNDQlBMRUtaNUNZbGV5YjBI?=
 =?utf-8?B?N3lQMVlnMzhmczdjTXYyRFVNVEpRZmIzVmJCQzFHcU5jQWpqZy9sVXV6Mlhu?=
 =?utf-8?B?R3drYy8vc2tyQno0bFVYOHZXRXNtRk04a1dFRjVQell5M3BncnZpSjR3ZWx0?=
 =?utf-8?B?N0tRQ09rU3M1U2dBa1p5cTlBM2h3NTE5Wm42KzM2bSs2MS9LMGJPWkx3UnNV?=
 =?utf-8?B?bG54R1JEZ3FKNzZkb1JJWnBiNnhHWXZsSmRkL200aWQxTnZGeG5Zd2tnRDN3?=
 =?utf-8?B?eFdRcnNGWE52YjZ3dmJmY1pMWGQzVmpqUWJyQ2REU0JWamF2cmhmRkpjVVlJ?=
 =?utf-8?B?MGQyTE1UQXdIaGE5NUxMMDQ2SXgxWjlmOTlKSGR4SkcxU2NUOW4vZmJ2VFNs?=
 =?utf-8?B?RVQ0RHhLNWo3VkFaem5MeFBQeS9PMXVVQndEOStqaytXZTNQMktVaVNWYmkz?=
 =?utf-8?B?Q20zYXJWK2ZuZWo4ODNyQXpTclViUkFaL0k4WkFQSURKbEtpdEFURTUvVFkw?=
 =?utf-8?B?d3RtaUs1UVZxWHpYRHViN0xZTEpDQmU0dkVZb1YxdFJHRUFmMUVuQy9HWVFV?=
 =?utf-8?B?dVhtQm0zZ3M4QXUwWTh4SCs3M0s2RURjWTAreXA1ZGFlM0ZHUTYxY0JUU1ZD?=
 =?utf-8?B?S1YzRkhueXBFREpmeFlwYnUvOE4vODFnYlJmZ3ZtOFRZalRlZXBsKzZFVWMv?=
 =?utf-8?B?b01QVzVzZThkQjd5SWlIUlU0bHBHRjFLenVsSzd1bE9kN0NSWlU2L0VGaVJC?=
 =?utf-8?B?V2N2OE9URjlIRkZqWkZZalh5Wk5QNEdxUzRvd1NCVysxM2RiQlRFNHdsZDJp?=
 =?utf-8?B?VGVkYU1yaXJUbEphRDRFOGp2eUJTMzJPa0RZUXh0cjJEeW8xREoyQWdQY0VC?=
 =?utf-8?B?MmM4bGN3eGk0Y0FSVkVBZkc0MUwwOVlTazR1dDU2M2Y1dkJRWm1lL3FiTXJB?=
 =?utf-8?B?NGdLY3d2UVA4WXk4Y1RLMFJEVVBhOHQxd2YrNGhKVitkNnRjMFd0ZjVjVjNv?=
 =?utf-8?B?NVhFL2ZDZS9CamFPNFpoczNDZU9WeXlqL05pSmo3RGZubWJESlJmSjlHTFpk?=
 =?utf-8?B?R1cyRjB4WjBBcitBN1ZDUU1XUUtPVW4zL0FFMDdNclZqRUxYMjM5UFVxMGJu?=
 =?utf-8?B?NmFUUT09?=
X-Microsoft-Antispam-Message-Info: o2cOXopKGTA+RE7gfCb0tRx/5w75QkRQxmm7aYMCdCOiukWtzTDewJRUC/ESUPoQAikyvksghFfzjjcO18ZepGQhxliJbPSJUe5q3BscI5peFshWGXFlzResWzsgcS6dUF4B69/DwP95Ys8SXnwoIgCAiOk+NKO6vC3NdCR08Pxevl1TsqlvjGH0YS79MXNn
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:DC7XU9JFa5ALl+oW7iee4Ty72DURIPpzXyIWhkWPfoZE5u3uzixx4tfXIV3ch19ATEiawPXrTs6nnFOINmiRGtunEH4hAXSwDcdq+432tBx/F7rZpArWARYdhoZtKzVPx/+WhK3M71SFiAYy56f5rSIso2G7137b9+l++LDQ/WurUjeqk6eRAHLaIsBxc0qekrAPCm8ERYGzdndAAA9169qveTU9OmKU4tNTNhbdSQCeL2PPVwsLeMh7d+Tvb9EPrrnmyxJpOHmNybTNSprPdTm4pC0nk5df96hHRfaCE6NMt+hC0CPftjqSOa2749xw+l+PWo8t+TVk6QmEsOTSYkxkpN9rT/Dd9SNaNMAX+Bxp1m7p1EbA7mfniEYi7PkTXOxTPRS6Px/NvnKBbuJ4izmA3MO3q2qXTczwwoh9KhjXPn4qwnGIQF3w2bwdeK4ZFtlWh6wmvILyTjNTpEBfqA==;5:Jaj3jbMUH81gQQgi5CO9jQcKuKFDrwI8Pm5HFA+LwnhcP7PJ9nOphshPRxfo68LkM42/DbomzSlPpjqL6FoTu8oagu8baqZ2qU5J05Kgrr+iPlIwNWbltm1ZOv4sgBt7NgjQ2unwzedkDw1Op/HIiRVgWGRSw0t1QdKQFq/XnFA=;24:27D4szI2Wtc7sRl62ybRH2aK69G8vpFRJkIDtm1zkusB/Qjbb06QaDxEMo4yF1VnYW/zn0dzu6/tlXRwHSJNoP+yCDCu5CPedvo7Ff3h0RY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:fD31XfzFobK4ZvBAUVdBzpLQTsDH0ZZWqrJog7C5/DkDz5MW3KtmQY4jZidle1eXDPs5odsbEH61MAwXxq+W/fxETXklBuwI7g+1Yr3o48E88NYEt4c8t0M4xT89aMSe3kaNP9GgJzdhOW2iPP+O8U7YOOn9csqtv0xrxT3chV1/ngCzZx1lwuXaR7UmYaEzINEabQAsNGt/vweWIbqUIk9sqOijb29Q1hzzA4ZUwFm4bhSrQlekbk9zdytsmqwq;20:sUW46kxCeBgSuXBxbLU/94Srzznyr+PkJXnejWHZgdeNrUjMa2hd0dR3V1ABDJd5K93x/F1rGZKK3H9sgYUCPhPA/LiAOdsDMh9SYiGULnID2jxFTr8CCc3KnattrQ77zXCzC5m3J9ZwM3ZCbJCirp2k/n+qR7OsyMWMrLdlgxU=
X-MS-Office365-Filtering-Correlation-Id: a91b5b01-8783-48e2-6480-08d5ab8f5d97
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 16:04:17.3231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a91b5b01-8783-48e2-6480-08d5ab8f5d97
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.2018 18:20, Peter Zijlstra wrote:
> On Thu, Apr 26, 2018 at 04:52:39PM +0300, Kirill Tkhai wrote:
>>>>
>>>> 1)for_each_process(g)            copy_process()
>>>>                                    p->mm = mm
>>>>     smp_rmb();                     smp_wmb() implied by alloc_pid()
>>>>     if (g->flags & PF_KTHREAD)     list_add_tail_rcu(&p->tasks, &init_task.tasks)
>>>>
>>>> 2)for_each_thread(g, c)          copy_process()
>>>>                                    p->mm = mm
>>>>     smp_rmb();                     smp_wmb() implied by alloc_pid()
>>>>     tmp = READ_ONCE(c->mm)         list_add_tail_rcu(&p->thread_node, ...)
> 
> For these two; what's the purpose of the smp_rmb()? which loads are
> ordered?

(1) and (2) make visible g->flags and c->mm in case we see process is linked
to the task list.

It seems in mm_update_next_owner() we may see result of list_add_tail_rcu(&p->thread_node, ...),
but p->mm = mm will not be visible.

Hm, also I've dived into list_add_tail_rcu() and it contains smp_wmb(). So, it seems
we do not need the barrier implied by alloc_pid().

Kirill
