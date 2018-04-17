Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49VdjKx3mzaRrA/CiTgmQE6mM+AuJ4YmMH/E+Eqo69aZ3NB82bJwuldRLbC9BA336wU7O13
ARC-Seal: i=1; a=rsa-sha256; t=1523980436; cv=none;
        d=google.com; s=arc-20160816;
        b=m2j7jM3/vxNPa5/oXa/jtQUJEXW1gS9o6Eq5GiBD4qTwJBvPXZr6zXIlLxWW8vkRvx
         mtRealhT6ILcJkAyHW8bVbsUaqOtZ01EPqe8e8KA9tz9tyq9olkq8B8XKuFHyl2wKrQc
         04DBLd+z3/lZZjcz/xkIaeJqYzqjbXUAQLYznBJQ+1jwFGvqOSTuMwpCZlTbQy3yI93M
         LrXFYcSUfM/dZTuqIe4xjid+dXikUROT4GPXlY41s4h/HNw9abQXdYm9iKr7rroRN3YY
         fWnULkD+Uq5ZeROr81qDJNEeSNQQOTCS7bJl45ysO5oRyJ/tdu8WPy6klzZ3zZqgxll0
         l5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=zETBXdcwhdLLCYcdTJuM1Wx3KMLGUEyvsXVxiATPWGQ=;
        b=SXpB/4rKVczhEpmgEHwlYDvZP15rCYghw7/33t6lVK7zgZxVKUps29+cQ0n6+Z/dZ6
         yMEufFQZmsyRFADkVD+T+55l9Loj+W4pC3ksF3CZJ6XXYESg9rjIsp/dkMzDWnAmksHh
         408Qavy23hhf135aTkxUAkiaALJBoEnzqz6BNYSaxDm4Eohpc+4rBu/yvkhYqjcog92g
         1nRSCnBc94aLwKdjaXO84l5d/I+gs0MA4jLF3JuRAcGGi6YglbsGyUbCm4AhQLgBv/6w
         DuFROiUswgWDBJ33cJYHBx08KQJPqHoKiyHuyFNFioso6HjcdKGnoOu3e0xQnAf7Agpx
         dO9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=J+ZKcHsv;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.100 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=J+ZKcHsv;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.100 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v2 04/12] mm: Assign memcg-aware shrinkers bitmap to memcg
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
 aryabinin@virtuozzo.com
Date: Tue, 17 Apr 2018 21:53:31 +0300
Message-ID: <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::30)
 To AM5PR0801MB1331.eurprd08.prod.outlook.com (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:nbe/lSlbJvqEIIhmil0x1WrfB8HDEO4E0sVm1PdtR/5E689njDOobZFyfublxS2ceIZvePgm5uDcn8Ofhae6M9uZ1yqUrBTvl7eTX+v4YVMqdqbUKWDrh92M05b1l5s3Y3y6gR6+u5BTfySzUeOALWaujjuxvkVnZLKUrJgyGCbIL53LxOY9fIF6Km0YYcXF/P0q0mIZJrH3C6CoqKbJl8S94AOGg8Jhc5ihpNFfDEFHW2FdEOQCJxLm9U/83+UH;25:/cEztO2pbcgsn34/r3r05rmJcYie1O8EMnjzSZdPnhA/iyUNWjB/+7G59PiO01q3dYF4sQfu5K5bnXh7eSKvyRlr6mQJiC9WmDqPcMRE/yHloUEE70gmWdbEBVuBRgWH6LKdGlLX8FJXo7/2YMvUiYydPYnf/8YBWhfU+7A7HM/Xa82HfbUfYw93M0uLqGGNCsixkAShAA8NNl0lH27jl7DdXkRqQEHxUe7UK0FXXz21M1dPWNs1Ahux8ZaqdC+vzDwME0pjSutBHrjpG1w3wLm2xK/KYe4GScQwfULprqQZ2VupQmncOEgx/e5qc3QFOFxvyUHvD46DZGedjG0F0g==;31:DV+RfDHTF8tqcd+2QjNJNbUB5Q5XNDhylRHFmhVhjl3gOnJ1Co2nPGWiCTvLEJFyDyhmHz/TQYyj4rDp3smmg2VCisLbUL4RqHUkoT9TLYZNYMF9jU4P2tn/YoO6yy7jjHyX8P24n/y+WB0UiJu352wmbpy3sJ0QmyJojG+2dNHD51jTyXVu3eKErN50easKf//nZl4dodcZqGGnjY1x7zNArjSxufyqOPfM7kFpbI0=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:vI4TVr/44lbbre+88PpMMu9r/brPeV+FiJ7ln0kVixkHnbCf5OfTf2f5Xgzsm1KF8L3H/SBn9tyjTlRKVe8eNx3v8Gmo6dPJCIY0Fr0XUx0oBV6wZJdDX8cowJgxxsYXmO79edRKMrSVgOXrDM4QBZvjsqqpgrdt4HrHaQW4KCz+D5lj+LSZOahGK2NmoL0N9vkNQP24tTz+Z7mUx/KS3BqGOdX2tIfFGshwsTlkgzzbA1I9va3yr+Fu5D7HyVVmgf+fh+lNkf0LQTNlzfPzmijISeCUkySeyFI84Tgz5hBvDGFApcZaF7VjrslKeY/0kRJUEWR8RCDLkWKNeVBOiC5v8ltbfWbb42C7yoWfbzgYk6Qbzhmc+bkkjexnGkYzsujo+9uOFlZkSKD1cFORsG52Q06LIl//NVcitqSpKNSV0+uoc8t6ZuWJ/BPflDDDMu43DG37eQT9mBqjXJ3nuBVM4MFyNJGazvi2WLP98pbrojaeJYo3GG02UvMtWlcE;4:k89otuLzlXIIAoJzSCSp9M7qa3FJUe9fkSF/TZGppQsgSw9Xr38+0G4HLLSCSbKlnO2zNYraK1tXe52YCefYXQhAa7smr671TuzjDh2iSH+QvaMlwyNbzeJkmITYNwONjdACh+ugcMCRdTSk2z2hvGus8lp2QydEXNW8KFbv9GqAWwqOi8Du60VuJ3iPiobei1SlzMQxXmPKiD8DoaLQkIjAlAHCGP2cNagS5sZ9pL1CljWxCgxIGMhVVDOxfcHGbZ4SUnqQMcW88d4ilYROmQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133183D4096E2340872D4A86CDB70@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6069001)(39850400004)(396003)(39380400002)(366004)(346002)(376002)(189003)(199004)(956004)(9686003)(478600001)(55016002)(186003)(59450400001)(316002)(16526019)(6666003)(6636002)(55236004)(68736007)(103116003)(476003)(97736004)(386003)(6506007)(105586002)(6116002)(3846002)(58126008)(53936002)(486006)(47776003)(50466002)(52116002)(2906002)(7696005)(61506002)(23676004)(2486003)(446003)(76176011)(33896004)(11346002)(66066001)(25786009)(26005)(5660300001)(39060400002)(86362001)(305945005)(81166006)(81156014)(7416002)(7736002)(230700001)(8936002)(106356001)(8676002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6ZGs1U1Nzd3dLREdwOFZ0RnhCZkRhWnBZ?=
 =?utf-8?B?aU9idzdqblQ4LzAzOCt3Uk1XWEdIS0d3NVM1QkJkdWQzTTJIMUpSelErbWpk?=
 =?utf-8?B?TXJyazFMZ2FJMTFOMUNGeVFSTTVISFZJaGNjUFRLM0hueVlTVEdBVVlIVElj?=
 =?utf-8?B?amVkSG9vYnl6R0ltdFhNeXE2VnFSVkx4V2pjemlYeDdlVUVpUXF5REZSK1U2?=
 =?utf-8?B?N09OZUVpcnU2ai9oVTlhcGlod2RoUmh6dlZIcnJ5ck5DeWozeUplaVdmZHBJ?=
 =?utf-8?B?UklET3J3OXpyVDhRQ3dPa3FXTFFUSG9KcHZBbUc3Rys1d1V5bEZPc2pOVTQ4?=
 =?utf-8?B?VFNzQ3Z5M0d4YW1LenE5QnYvOUgzdHg3K2xNUDMxMnZ6NEUvRmFtS29ialRO?=
 =?utf-8?B?RFNXcnhuWkYzZ0FlNUZRd25FbVNkUW52czJCSzVxRGVBYjc3bEw0UHdFYjZ0?=
 =?utf-8?B?aG1xd2N0YlBFbSthZkFJSzhIRi9ZT3RPYVQvdnhYSTk1Mk54ZHVLRWxjYzJF?=
 =?utf-8?B?amoxQWVvQXlFeVg4VzBhV3hPUEZOYWc0OFlzaktzMlJtR1lvbEQ2NG1xRUpR?=
 =?utf-8?B?dUptbkU2WW9kNkpZc0s5OXRRbjIvbWlVWG53Ryt4S25TbFYzRTZERFhyOExO?=
 =?utf-8?B?Mm16SjZCNTdBbm93VGZ2Rm0vUmhIS3N3eVptS0xIZGFHWUZieDZZMGRZWHc4?=
 =?utf-8?B?a1htMjNPWVE0ZXFsMlpQVnlMcXNOeTBaREhRdVE5cHJINzVoUG9taFlRZzNE?=
 =?utf-8?B?WEpRT25zN1l3UkZUL2hndlhubXFuYlFkVUp5SjlReHBwdnBSVndWdTZVVlNN?=
 =?utf-8?B?QW1wZEhDbzB3clF4VXBzRG83Z1o5ekRmL050U2o5RXVRemlWSERzY0ZISHd2?=
 =?utf-8?B?Nm55bnJOWmQ0NGJPM0RzWEx4V2tIbEtRSy9nOFFZT3RuZ1E0ci9sRVRkcUZF?=
 =?utf-8?B?T1JVU3U0ZW11TVVTTjlmTmNJK0xrKzhMTTVEclpuNUpNbkZPa3BuZVhFUnly?=
 =?utf-8?B?eUxoNjZSS05lVXFKdDY5cUlYZ280cDVoOUoyUFdsY1lNYU9uUkU1SS9NanIz?=
 =?utf-8?B?cG5nUXk3b1Frd2ZCVHFRd0xPdXBOY0FEMm5TT3dWSkY5M1hEUGdrc2xnUjBT?=
 =?utf-8?B?YVpveGxuSWRGT21YazN5SjlkWkNVUWRpNURJU1R5QzEyWms3U3QzckFMdkE2?=
 =?utf-8?B?bWVxUGJaSmRGRTNqQk5NRjJVMi9VdExjKzMySExLcUJCMmtwZGJCb3FBMmc1?=
 =?utf-8?B?MGpmZEVuR0ZpZGsySEZBOUpSdnZIYm5BZlFQbG10dHhiaXdFaktodHhtSkJR?=
 =?utf-8?B?ZlMzSXBaSmJ1Sjh4YzkvTTBJZDR2Sk9aaXAwOUNZbmVwVFRpdFlIR2pXbnNC?=
 =?utf-8?B?aG8xMFFIWTl2djhIRWdqRElmUVFVN1ZBN20yMFhxOEVZMFhGRGVHNlc2REJN?=
 =?utf-8?B?cFI4cWpla1pnSXFOK1ZhNXVua1BXMFZzdDdYTTFkbU1FenBaSG9OeHhGcTdP?=
 =?utf-8?B?TURDY2lJSjUwNERvaDhmOVVvcWZwQmQvcjhlaTh2b25PQmRqSitINlBMVVBw?=
 =?utf-8?B?TURISU9IaUxNRnJ1ajA3NkxRTm14RDl3T3ZGNnptRThtRnA4QlM2LzNlbTFm?=
 =?utf-8?B?eDdxbzMzbjBwOUZYdzFKb0RSREZkRHNOaHRFR0tndUhyandKRW5ESFVCN3dQ?=
 =?utf-8?B?Z3JMUG5RRUpPWi9xZDl6LzlOQjVxaE5FQVUyYVBEOUd5elFXQkVsRXAxSDNj?=
 =?utf-8?B?eVd5Z3VFL3hLQk05czJ6amNGL3o2alQvbHJrM0ZucStpRDE3ZzRCcCtEREFM?=
 =?utf-8?B?ODJBRUw4WFQxQURNMUtRQXNTTUFiWDhLQkFXRXBYamlhWUIwT1BQczNrRmtS?=
 =?utf-8?B?WmJ1eWlFMW1YdXRXNjdqYmdsVFdkbWpkS3pnNCsyS29RSEhjN0Y2RGVWS3lh?=
 =?utf-8?Q?uFRxe3oinqCmKEGlFlN4L0/T9tsCggvo=3D?=
X-Microsoft-Antispam-Message-Info: YbtSoHENWi4a/SiLW4jBTf7yoLtYnjAj54p3RfydmACwQplClMOPeT5kxNQVT1n2DUEOgNY+GA65GpxtbHH2wVukuH5q+z3fMOx/tR0eyAU0Qi+O01JFglEI3EvRnO6B470dWWX+ESVlwTydfMqQnEorXEIQY2+poMim7jAv1bJg5iiADm1E2gNpD/lZ9skb
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:7rzrwny5fMnmLP2X8YK2CYoGM4p2nS+G3dvzETsDQFoFEgg+2HHWKUHWklB+765VYgrrOv974FtAVUkInhtOzPVBDf0H8jkTLShiXkvzjPgk113LIzg5ZSC3mj60Vmb/2XkyDgBOkNQUi89g1yt/As18k1nmoSlpxFspVXdULwkbqkrXtEOB7toUpLnkwMD1bcJTb8KGPL2m35qGv/o0MaPy3851270jpTnSIy+1wRfMnN1vr8vb09GkBfYdWoHskJG/6FSHQbNTRTqUStuXxr4VnHjfoCe+Gc/19/MNDaL75+pE/1A0g6w9ELu4Ck+a/VJjAxiz7D0Uq2hIlxMAbYWhnJqOG5NB4YY3kUponVLwTBkGngPjtrhvJIdMesVx9ejlPuFeP3YcsvcabAC+NZYJg3oUwWhqqX2Qj2IHD2aKbxLcFcM1zBNdk1LrJOEqgF6lEgDENLdZs+O1SYRHPQ==;5:X4OfyCytaj2Yi9R+XU5XpOZPlft2ZACHSVsmDkayA4t+83lcS285uS44WSetncZBS+XGorUtUGmDQ3fTs4UjfLWfe9PAHCak2QgGXleVQU3Zm+HtLlPxen83Rl+CXEEGEW+BVhrnZM8c7ZijXHmK5q9LXLGESxzRl0m7IMtdGsM=;24:k5HioDLZ+TOXji3tPmUNVSlbOxjOnwqyEq9NIpeaNfN50kuxVJZYbekAc+azbcqELXKopS1rr2Q9QkFgG6gdAFZi7MBqxvJ1SUxGEjKwySM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:/t6wmQ+ONzCD8dWbaFEbuFPFY0vgC0xCDIHJE89xdHGO76tx7YjfDaZg/t3bgklE5eiIucPjlaynATv7If4epOmVLCCoCdM8nGv2oxCEeMTreeHneRFSksiprcOZ1KZOMrSX+eKmszjyISyANh+fhyN2Mjl3bzrJ6nbRuL2tFRUVIjhvM0BocaZ1MSs2xaa6sO6ZfZfE3d5y6/X4ZbapcdcSzEkKTGu9Q0tpLB+OZ9NeGSqEIogngA/HisLL6fBb;20:h9mcp26Iwfi2GtzNsNcknnzSTgWPaVGkgdeAfNJqCEyrX9QsBS9lS9/LuACmjQpiiTBzswkJIqg11b81UuMkLa0kkUtvNBarIdk+MR+d6LpqfYevXg+/DYU0WRKrLRYQTTvZwZsEx3Tc5/RGJfnOzSgw1okPC9rWAqr1IWoZk1A=
X-MS-Office365-Filtering-Correlation-Id: dc185a79-1822-46f3-fb0f-08d5a47b68d5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:53:46.6922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc185a79-1822-46f3-fb0f-08d5a47b68d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598009310068873507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Imagine a big node with many cpus, memory cgroups and containers.
Let we have 200 containers, every container has 10 mounts,
and 10 cgroups. All container tasks don't touch foreign
containers mounts. If there is intensive pages write,
and global reclaim happens, a writing task has to iterate
over all memcgs to shrink slab, before it's able to go
to shrink_page_list().

Iteration over all the memcg slabs is very expensive:
the task has to visit 200 * 10 = 2000 shrinkers
for every memcg, and since there are 2000 memcgs,
the total calls are 2000 * 2000 = 4000000.

So, the shrinker makes 4 million do_shrink_slab() calls
just to try to isolate SWAP_CLUSTER_MAX pages in one
of the actively writing memcg via shrink_page_list().
I've observed a node spending almost 100% in kernel,
making useless iteration over already shrinked slab.

This patch adds bitmap of memcg-aware shrinkers to memcg.
The size of the bitmap depends on bitmap_nr_ids, and during
memcg life it's maintained to be enough to fit bitmap_nr_ids
shrinkers. Every bit in the map is related to corresponding
shrinker id.

Next patches will maintain set bit only for really charged
memcg. This will allow shrink_slab() to increase its
performance in significant way. See the last patch for
the numbers.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |   15 +++++
 mm/memcontrol.c            |  125 ++++++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |   21 +++++++
 3 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index af9eed2e3e04..2ec96ab46b01 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -115,6 +115,7 @@ struct mem_cgroup_per_node {
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 
 	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
+	struct memcg_shrinker_map __rcu	*shrinkers_map;
 
 	struct rb_node		tree_node;	/* RB tree node */
 	unsigned long		usage_in_excess;/* Set to the value by which */
@@ -153,6 +154,11 @@ struct mem_cgroup_thresholds {
 	struct mem_cgroup_threshold_ary *spare;
 };
 
+struct memcg_shrinker_map {
+	struct rcu_head rcu;
+	unsigned long map[0];
+};
+
 enum memcg_kmem_state {
 	KMEM_NONE,
 	KMEM_ALLOCATED,
@@ -1200,6 +1206,8 @@ extern int memcg_nr_cache_ids;
 void memcg_get_cache_ids(void);
 void memcg_put_cache_ids(void);
 
+extern int shrinkers_max_nr;
+
 /*
  * Helper macro to loop through all memcg-specific caches. Callers must still
  * check if the cache is valid (it is either valid or NULL).
@@ -1223,6 +1231,13 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 	return memcg ? memcg->kmemcg_id : -1;
 }
 
+extern struct memcg_shrinker_map __rcu *root_shrinkers_map[];
+#define SHRINKERS_MAP(memcg, nid)					\
+	(memcg == root_mem_cgroup || !memcg ?				\
+	 root_shrinkers_map[nid] : memcg->nodeinfo[nid]->shrinkers_map)
+
+extern int expand_shrinker_maps(int old_id, int id);
+
 #else
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2959a454a072..562dfb1be9ef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -305,6 +305,113 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
+static DECLARE_RWSEM(shrinkers_max_nr_rwsem);
+struct memcg_shrinker_map __rcu *root_shrinkers_map[MAX_NUMNODES] = { 0 };
+
+static void get_shrinkers_max_nr(void)
+{
+	down_read(&shrinkers_max_nr_rwsem);
+}
+
+static void put_shrinkers_max_nr(void)
+{
+	up_read(&shrinkers_max_nr_rwsem);
+}
+
+static void kvfree_map_rcu(struct rcu_head *head)
+{
+	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
+}
+
+static int memcg_expand_maps(struct mem_cgroup *memcg, int nid,
+			     int size, int old_size)
+{
+	struct memcg_shrinker_map *new, *old;
+
+	lockdep_assert_held(&shrinkers_max_nr_rwsem);
+
+	new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	/* Set all old bits, clear all new bits */
+	memset(new->map, (int)0xff, old_size);
+	memset((void *)new->map + old_size, 0, size - old_size);
+
+	old = rcu_dereference_protected(SHRINKERS_MAP(memcg, nid), true);
+
+	if (memcg)
+		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinkers_map, new);
+	else
+		rcu_assign_pointer(root_shrinkers_map[nid], new);
+
+	if (old)
+		call_rcu(&old->rcu, kvfree_map_rcu);
+
+	return 0;
+}
+
+static int alloc_shrinker_maps(struct mem_cgroup *memcg, int nid)
+{
+	/* Skip allocation, when we're initializing root_mem_cgroup */
+	if (!root_mem_cgroup)
+		return 0;
+
+	return memcg_expand_maps(memcg, nid, shrinkers_max_nr/BITS_PER_BYTE, 0);
+}
+
+static void free_shrinker_maps(struct mem_cgroup *memcg,
+			       struct mem_cgroup_per_node *pn)
+{
+	struct memcg_shrinker_map *map;
+
+	if (memcg == root_mem_cgroup)
+		return;
+
+	/* IDR unhashed long ago, and expand_shrinker_maps can't race with us */
+	map = rcu_dereference_protected(pn->shrinkers_map, true);
+	kvfree_map_rcu(&map->rcu);
+}
+
+static struct idr mem_cgroup_idr;
+
+int expand_shrinker_maps(int old_nr, int nr)
+{
+	int id, size, old_size, node, ret;
+	struct mem_cgroup *memcg;
+
+	old_size = old_nr / BITS_PER_BYTE;
+	size = nr / BITS_PER_BYTE;
+
+	down_write(&shrinkers_max_nr_rwsem);
+	for_each_node(node) {
+		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
+			if (id == 1)
+				memcg = NULL;
+			ret = memcg_expand_maps(memcg, node, size, old_size);
+			if (ret)
+				goto unlock;
+		}
+
+		/* root_mem_cgroup is not initialized yet */
+		if (id == 0)
+			ret = memcg_expand_maps(NULL, node, size, old_size);
+	}
+unlock:
+	up_write(&shrinkers_max_nr_rwsem);
+	return ret;
+}
+#else /* CONFIG_SLOB */
+static void get_shrinkers_max_nr(void) { }
+static void put_shrinkers_max_nr(void) { }
+
+static int alloc_shrinker_maps(struct mem_cgroup *memcg, int nid)
+{
+	return 0;
+}
+static void free_shrinker_maps(struct mem_cgroup *memcg,
+			       struct mem_cgroup_per_node *pn) { }
+
 #endif /* !CONFIG_SLOB */
 
 /**
@@ -3002,6 +3109,8 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 }
 
 #ifndef CONFIG_SLOB
+int shrinkers_max_nr;
+
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	int memcg_id;
@@ -4266,7 +4375,10 @@ static DEFINE_IDR(mem_cgroup_idr);
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 {
 	if (memcg->id.id > 0) {
+		/* Removing IDR must be visible for expand_shrinker_maps() */
+		get_shrinkers_max_nr();
 		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		put_shrinkers_max_nr();
 		memcg->id.id = 0;
 	}
 }
@@ -4333,12 +4445,17 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn->lruvec_stat_cpu)
 		goto err_pcpu;
 
+	if (alloc_shrinker_maps(memcg, node))
+		goto err_maps;
+
 	lruvec_init(&pn->lruvec);
 	pn->usage_in_excess = 0;
 	pn->on_tree = false;
 	pn->memcg = memcg;
 	return 0;
 
+err_maps:
+	free_percpu(pn->lruvec_stat_cpu);
 err_pcpu:
 	memcg->nodeinfo[node] = NULL;
 	kfree(pn);
@@ -4352,6 +4469,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
+	free_shrinker_maps(memcg, pn);
 	free_percpu(pn->lruvec_stat_cpu);
 	kfree(pn);
 }
@@ -4407,13 +4525,18 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 #endif
+
+	get_shrinkers_max_nr();
 	for_each_node(node)
-		if (alloc_mem_cgroup_per_node_info(memcg, node))
+		if (alloc_mem_cgroup_per_node_info(memcg, node)) {
+			put_shrinkers_max_nr();
 			goto fail;
+		}
 
 	memcg->id.id = idr_alloc(&mem_cgroup_idr, memcg,
 				 1, MEM_CGROUP_ID_MAX,
 				 GFP_KERNEL);
+	put_shrinkers_max_nr();
 	if (memcg->id.id < 0)
 		goto fail;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f02fe83537e..f63eb5596c35 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -172,6 +172,22 @@ static DECLARE_RWSEM(shrinker_rwsem);
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 static DEFINE_IDR(shrinkers_id_idr);
 
+static int expand_shrinker_id(int id)
+{
+	if (likely(id < shrinkers_max_nr))
+		return 0;
+
+	id = shrinkers_max_nr * 2;
+	if (id == 0)
+		id = BITS_PER_BYTE;
+
+	if (expand_shrinker_maps(shrinkers_max_nr, id))
+		return -ENOMEM;
+
+	shrinkers_max_nr = id;
+	return 0;
+}
+
 static int add_memcg_shrinker(struct shrinker *shrinker)
 {
 	int id, ret;
@@ -180,6 +196,11 @@ static int add_memcg_shrinker(struct shrinker *shrinker)
 	ret = id = idr_alloc(&shrinkers_id_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto unlock;
+	ret = expand_shrinker_id(id);
+	if (ret < 0) {
+		idr_remove(&shrinkers_id_idr, id);
+		goto unlock;
+	}
 	shrinker->id = id;
 	ret = 0;
 unlock:
