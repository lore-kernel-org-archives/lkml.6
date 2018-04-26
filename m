Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755228AbeDZLAh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:00:37 -0400
Received: from mail-he1eur01on0121.outbound.protection.outlook.com ([104.47.0.121]:34400
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754663AbeDZLAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:00:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner() more
 scalable
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, mhocko@suse.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date: Thu, 26 Apr 2018 14:00:19 +0300
Message-ID: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0021.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::31) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:XR1FIqiiQ3pj+YXIRBDR+aNz0n6e2e9L7tpHHgSj53RsQ2KfsfJoXK0fJCyioWQ9cqia1QUiVBTwxJ+W9FWbAgo5R2D/aAqlBKM3cT8IQb9JugpilwQOcTO9dhKx8sJgk6dynMbPUBMsBy7cF4JXNzo+GcZ2DKaFT7BqIsE/33/Pbk78245PMs4yOORYv01u5+W39JAN2SEttdJypUX76lWJ3ggJr+EJnMgF8zX6YFEIm0QzHELZsUm1xsozWyfn;25:qHVZSKkudYRrdmY+6yJIEnq2MjRrQ9vBOVGS0trQ1hCDUGASHo51ifvYjC6+wsmCt7RLJG6JDmcgczUNnCMmZaHzENsa6Iq9abQmOuKiDwCI3kdQcWyocpuOmJjQBWLLvQ46WIsjPMFfXWe66E9m8Tol4VWXwEMNaxvaW5eRTbJP5A7IBPExS2v7IBikS04n+USTFN7ZNOS2/7ubQMDT+U1E6CTju4csu/rGjjIbw6j/UQasNvB/ykakxejSosC+yn9wT6vatyvEG6ttJMCM0oaiVZVc74qR+iGyGxpcAyGOFfBSpMW+PfbYKwEuJhEX5gSU/TQ9VyBaJK8go998ow==;31:NYWkVstzd9bkNmskaqUZN6ynmAlbBtH/FUev5LvuhmKWMEB7tmY51LuakNyjCzWtpQLRY8gdOuDgBvEYwmrkqqzKb5oCAGrSoNeFM9ZNvSlJwtjZUF3p+XwvXNcab7H2GOcNcWUNvyrGLMpAsENqlBRf2EGIDcP+u5/kjuSWPvsUnaLjeuH36y70481GrFCN2LOuE044Cz55leLq3DZWmRF/Ak3dsRoOf5m4qxhP3No=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:Jve+rOtnpTg49Q+vqyumt4vikdSXHVTvHSBDod1Ap6Tjww+YyVTh4c29o4CtDMaNV2cWQ/OkIFgsilFf8FdMydchoPHde7eEYyLJSxakzgFXDSzN+ICXsAKGVnp+STGT2/kKl+5UaSgmPeBtOeN2DAF6IWxcPkzg4nH+qag/w9FXCjO0+VV0fZzA4aAvtZqaNOxzTFJjUS4zrvAvZ538iJ8gLIKZRYfdRKEOacerC1DLUdWxUW78qGpk5UOawDc/wcYGtZ8dV1AK3GhKO55BTcU6slqTK1DAmIkxYIMvTcWpZXXWqP6cjjJHfPwle+82DXqzm9kOXweOC8hNPLpiBxGNAxX+nUSRwEmzFSYsaoREftqc3+mqroorOyWAOW4Ht2ujVfX+YG3I2hwZno4Vm7+sV9+KxpJ9TTy1ytYDwS5J5kj/Cao8lzCtFXqs2bs/KmOfcFqX6EcaqpjmRM4S6TCVS8wJwXIC52ez89L1dDRt3gtY51oXTRKDM8qtPgV2;4:PsomnGgj81MAdyq+233BaHBw8kJ0TBMUIRIuHyne1w1gahyMTR0axzcn71x4eS6/9OzcwM0mLfs8MkUXapPyAaFDnLRsu66bZRIFoPuvQvy7V4T41n3yJb/ctwmZ2nWN5MiIDeoPP+qZAEWE0sCM1O1x7ikDIEWTjRUyOoOC/uIW+H007opt7dPa7wOazzFYmnWHOvJ8O+f9Dektf60MQavgyQ8Dr6e6pT8AHECiOqGTlycjADwN8MgWplcEeJS46AdeXcLly0GQrB/oDR3+nYOisSaIFYAlFW7RH65sWLi5fgFG3AXfosNykfcenOYF
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338031F7016C2391E362C9ECD8E0@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(376002)(39380400002)(346002)(396003)(39850400004)(199004)(377424004)(189003)(5660300001)(97736004)(186003)(230700001)(7736002)(8936002)(106356001)(3846002)(956004)(86362001)(81166006)(6116002)(105586002)(61506002)(305945005)(55236004)(6666003)(50466002)(476003)(16526019)(23676004)(486006)(66066001)(7696005)(39060400002)(9686003)(316002)(6506007)(52116002)(2486003)(81156014)(58126008)(8676002)(47776003)(26005)(103116003)(386003)(68736007)(478600001)(7416002)(53936002)(55016002)(33896004)(59450400001)(2906002)(25786009)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6cXJwMWtWTktTeGFvWkkraG1xYVRZVys1?=
 =?utf-8?B?WWdyNWJROVMzdWo1UkZKWUJwUFJYSWZiTXV3RDF5UGRSYWpNSWZzcmxHZ25T?=
 =?utf-8?B?dklLQ3RGZzZCWXJROWZrWmVwVzZmS2Z2VUw5OXdSdjQwdWZxMUp4SVpISmtr?=
 =?utf-8?B?eUQ4b0xZUE1HU3BmbmR3SHZiRHBCeGVnNGx3OG02azBBYS83UVVkSFpHU2Vs?=
 =?utf-8?B?UVdSMmVicnZzT1BlOW0rMEw5K2ZHcXpwZHJmcVF2SE0yUUdlWVFoV0Q0SlR1?=
 =?utf-8?B?dDBnWFJxdWVidEJzcTNrcm1MbzlYM0R0MmZNR3FZQkdPQm9Hb2luSXhnMk1t?=
 =?utf-8?B?aDUrTVpBTG1OcGd4VzBCc3JZWWsvU3lodE16QWFyOGVnQ2tzVFN5dzFxT2V4?=
 =?utf-8?B?TWx0UlJPZFp1Qk9rb08xM1VWeElGeEdaS1ZEcHM1aDNBOW5VazNKS2xVaXcz?=
 =?utf-8?B?WjdZandNc1dyazhiL25KNy9EWGtIRURMSEhXRmtkMFhqTmNNajRZZm5vNy9G?=
 =?utf-8?B?YW9hdGpBTkZjMWxUZXF5b3JGbHlJQ1ZhczhxcHV6VDMvaTNKa2xYbWx1SzN0?=
 =?utf-8?B?TFpwOCtrdFVEZzIveXRZWGdYUzdzLzZHRU9CempSeEZjYzdWR0JHNDFNQWRi?=
 =?utf-8?B?Q0VEeEE0QVo2OXNIZC9Cc0swREFlN2x6TmJ5c1hKZENMN01GVjVCWFdhd00y?=
 =?utf-8?B?T0YzSWpkZFc3WFc4bFdZWEhvL0ZkNVZ2TVBqeFFYS2FIZTFIcXhqN3RsbWVV?=
 =?utf-8?B?c0lkSnBkMnNNTGUxYkh0MHJRcWR2N04wQ201d2h3cWdoVkw5NnVISU9QN0N5?=
 =?utf-8?B?QWw3cTZsVzRFSGhoKy9pR3hIWExObzBud1BiNmpsOVBMTVdnVEJ2NjQrSjNC?=
 =?utf-8?B?NnVvR3QwTTRaQU9wWk1EM2NucHhKL1pPVVhIREdRNHpiRjdXKysvZkdWam1n?=
 =?utf-8?B?S3NtdC9lZFVYbTdlQUVoeGRLWWUxMG1CeVFTbHRaNTVuU0FEd3RVUHloRG5Y?=
 =?utf-8?B?UzdVSmtwaFo3Y05HQy9SWFpsZFJXZWJ0S0grbTc2LzRGck0vSkhGSGZhZ3J1?=
 =?utf-8?B?djdiYk1nb3pUb0V1NGpVTUZ5Nk52bnErb1VlY1JPd0czS2F3MFQ3Y0hwV3hm?=
 =?utf-8?B?bDcwNmQ1ZmdTV0tsQVZGTkRjcTh5VjJvcHQ5Q2RBOTNYMEZnWnFxOUhGOUd0?=
 =?utf-8?B?bW9wQUsrWm9Rb1dhNjZIR0wrSkVZQkw2aDVNQURUSjZlaGRSOEVlbXhiY0lC?=
 =?utf-8?B?WHhhRFQ0eUIyN0lTaGdQcmM4ZEFYbnVoUUxjT3FaNldoL0RaamlBc2EvUWlV?=
 =?utf-8?B?UGo3NEI1ajJNejNUanVnR1orbm5GUloyOEdFTjJSeTdtTXpRbGlJTTFFVnNG?=
 =?utf-8?B?SlRZU3RQRHlUUjdPNHZOazNBMXZOMmRSbnNKdHVMU0o3UU5QNUNMaUU3d1Vn?=
 =?utf-8?B?N29DMm5wRUNaUDhRWlpqWTRFNE5wUWtONGxvVzFra1Zsd3dveWdvYzZKYlAv?=
 =?utf-8?B?aXdYMHBpc2wyd1pSMzRvcHNhMkJydWVrSWpzcUsxZ1VoUEJuVVVLN1dnL0Nx?=
 =?utf-8?B?aHNPWGNiRkQwVmtjZW04SXZET1FzRzlQdkF2M3NlblU4R2o4M3lWZkhyMjZk?=
 =?utf-8?B?WXRhMjE0LzMrSUtjNTc5Y2haSjJhZ3dwRzErYk5nRUdBdXdhajI0ZHVXbUYw?=
 =?utf-8?B?anV3N1RYdldkTCs4eVMyaXk4dmxNNDhqV0JsaFQ4cm5pdGUwZlI2bndvWjJ0?=
 =?utf-8?B?WDBDak8yUlRZN0I1SkpIWEtnPT0=?=
X-Microsoft-Antispam-Message-Info: KeC0NRJE3HZdgrAKIUKRMuo1NySbrEAyiGNVrUWtNCTPLWvMNI7RF4qKCg0rMtG6GCGbMBP5x8iageDSo9rSOUF8Jg4rlnG4nCHWu9mnz8xw7qhi7Z6u6VsdT1I3r9afmUoMfu73FFdrreGEIiUAu+gwiSPe9U0voCayABvyDo9JLNhG7xfmo+Smodp7fnUa
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:jWR9W/bhl+aTsIckH/WPwmvfzVk582qcrXKA9ovMBxfoGrojdMf/9JAWAOKHoAb7VyZXBWIUFKcjAw7Di9wSTE5w2dLOk1Be1xYjX3bPr90NdWj22drQJatyYsxxg8ZymG9xOZg3qPgIDL6a5XSfneSmAqQ/hPDZ70xOWBzxGIYDT+2PoDiqMU364kUv/wtkcLiDQLjid97r4VoQ+C0f2L8+sunh1b5kub4oznTxefomMKHTTKyfXw81li1W+aMtY+2M7acFwa5Mc68PfjEXHcgygSm62X6fobOC99E7v0tqbDLHy6u0GLY3zXTHJon5s99E9SQqQJynC2jLk+wuWWlt6hEOI0a/QqXOHaAlGQD6gECn1gpiGPQ0/ST3zvwlzfsW52Rz+LsLHaa1Z/6aNfi3g01w7f6yM7FvqzV2YOAQdJX1F9JJzr0sPYehSGR4IOmq93inB0Zo7Lgu5/5JPQ==;5:X9J5p9ewZ2CYSJxflJ2vgUf08dmuf40P/8NPgEbBdJ009HTOiXFIXTGdLnECQTW7jWZyGMwC7Tl6qVVGjxuI7dFurtrJYArdIpxniQOD5h0V5N+PpjK9MYtOp6TF/fN2+WtLi4CqEbLOWadNPMut24I8sva1mW7UmE8ifR4t/ko=;24:zHSSCXg2dmBne/zLgc4uFs5OJGnvyqiAY50GpZj3QI0yB9HK8858dEazblpch07+RZz37GkyzBH9k6SdzKuiUXJ2hPw+TqHJHA0B3p+BabA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:99kxvEy0RgdpE5J0y6ijr9S6bvm1WHk52Bd6o1psAvtVOB/YJjFKec2SjR+ccCi59aqoCTCRx38Md+WRqks65Lz+8GsrL48mB20bVkfjMlPmh67KoZtpUEB4KEe/lts5JArz5P1wVr8VSbTljPsYcP8GE4KRoQHXunPEcXLQgGznAp/R+SvEWZ3Zu30ZUlayd3sMAhxhgiH86LqMaomwhY5LfVl8zZ7kELK7jwrqMEgbIkSxuH1yiF7VjIGaDwBF;20:hYIWRjBJCds68Mv9KJIIFAIRu/6qPKIEzp/hziLn7lXT4KfgN3nOvyMQq6J+yi2ut1GSaVQkI+/hID/OV0c2lJk8SE0C6sSrWCJSpfIw9sTiDsf+GjZkPyUw14hHWG/rwOir82Y7vvWquncQWTt9Sex4lPIvWA75NtEDG9imuk0=
X-MS-Office365-Filtering-Correlation-Id: fd5f97e6-4c39-47f9-57cf-08d5ab64ebdb
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:00:27.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5f97e6-4c39-47f9-57cf-08d5ab64ebdb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function searches for a new mm owner in children and siblings,
and then iterates over all processes in the system in unlikely case.
Despite the case is unlikely, its probability growths with the number
of processes in the system. The time, spent on iterations, also growths.
I regulary observe mm_update_next_owner() in crash dumps (not related
to this function) of the nodes with many processes (20K+), so it looks
like it's not so unlikely case.

The patchset reworks the function locking and makes it to use
rcu_read_lock() for iterations over all tasks in the system. This is
possible, because of task_struct::mm may be inherited by children
processes and threads only (except kernel threads), which are added
to end of tasks list or threads list on fork(). So, the patchset uses
RCU and memory barriers to make race-free traverse over the lists [4/4].
Patches [1-3/4] are preparations for that.

Kirill
---

Kirill Tkhai (4):
      exit: Move read_unlock() up in mm_update_next_owner()
      exit: Use rcu instead of get_task_struct() in mm_update_next_owner()
      exit: Rename assign_new_owner label in mm_update_next_owner()
      exit: Lockless iteration over task list in mm_update_next_owner()


 kernel/exit.c |   58 ++++++++++++++++++++++++++++++++++++++++++---------------
 kernel/fork.c |    1 +
 kernel/pid.c  |    5 ++++-
 3 files changed, 48 insertions(+), 16 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
