Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753513AbeDSMup (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:50:45 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:35872
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751865AbeDSMui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:50:38 -0400
Authentication-Results: mojatatu.com; dkim=none (message not signed)
 header.d=none;mojatatu.com; dmarc=none action=none header.from=virtuozzo.com;
Subject: [bisected] Stack overflow after fs: "switch the IO-triggering parts
 of umount to fs_pin" (was net namespaces kernel stack overflow)
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: Alexander Aring <aring@mojatatu.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
References: <CAOHTApjPwWDxHmGrfMwFvszWubfjJ7YfBgZL-DQ0mdv00UtQEQ@mail.gmail.com>
 <ef45eb94-4480-0683-ccc0-eb1efaf7e96c@virtuozzo.com>
Message-ID: <d6e6f694-1bd9-7f3e-eaa8-1947c47f523f@virtuozzo.com>
Date: Thu, 19 Apr 2018 15:50:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ef45eb94-4480-0683-ccc0-eb1efaf7e96c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::23) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:VKquLYKDJwDG2DsWGe50F4xzGpygP6lnBQr2s28DNqWrwo3RatSw/R0ztHRve+zJf/8UxbgUp8AVasJ4PGVL1Y/A1DeUEP5pOrcoUVzo4ETmioy3+25CZCfyFaSBsX28lVyW2ExNkcG8jM1rIfIe7Im6fbCrmVrRU2pczf16pxT6ordWJQ07vjTKqTx5i1YiEGwuJLJJTOSlz7B4Kt3trntxOyU6vH4T0iBnz31zHLktWcdMIVS5Kp3Q9Tz4F4UO;25:opvqyYa/luq+vP5AP+8dvs+IT2T+YHD1zJMZCLEe/aodMSEAIGIM/zYpuYyDnx9PQbGE07xqwFtasucnx5SCoIA3Wsg/nPVbLE/zudFAu8TPczyCqHLCMzLOrxFoLQEtT3f+qdvilyE7LsFgzywXBV4v7lAiJbyJQKd61/irVqZBCXHtXUBcJpyJjhmrOnawQGrGvtEAi4/Vl+ak+lo/7dZ/Rzp2PihgKXkoHpKLmC7w7/b9cYGUBdvUMxpOA3IcMydfB9cA/P5TuEAcE+uAdk0FILdFidzxQII1uFgPHjS355Hf6T2Clh2Nne8TqJuMeFF/dR9hZ5XjAcpW0m9wtA==;31:1v1LU73gOmIy/VRkSq2wZG3+twcVq82B9eoxBblFuswcawlnJtYr6k9gguSV4N2uNIRBKijhsJfgqGmGeY7/dlgIRf5cBMqd2xncuXye1g6Cxiig8c9LuA7kCnel6VmeDf2C/wXJSEf9Lczo/XpikMwnwCPfU+F76d7/gCC4wsTG0ZgnHQurcz34+6PLHCQ29+/OO+GKSo2+avjQvKqLgeDlJOvnMQPkiKiTQUSLa6E=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:OEgmcejMVaEXB01t7kptrsrqa/iEsrqvqQppJFVNEaZafYuSinOyzgS01n66r4jSMROWDDvzImcpUiOM3aojIDpFbvrawl/XMIVVVvvtGTnhV7BVHdH3GL41PE0IkLQDvP6KKERAIgAFaknrolGu67ZPJA2d3XGUnPVvvtFGtE76goJvTMzMa+A61j+urzfgE4ITGnDWetDvSLIflIf1ajZ8Qb2ppukUZXmOU5vegjq7xJBEDGMfpsCur9yC9bCDbtZn6UFi6lwwKMD95EjC4Gvd4j8W477fZ+q4auxDpJ99cqBRjKJy+2NLShGBgpFuVltf/CkBPYOV+eZ7UuoP+sUweRqOzwC+XnzXuBHYta0WCG+vHQdO7+ZdoM9yLpVbjWsn4bF2xGOt8Kr1bHFWbU5yjkcMR0KO2q9U7hkC8f8hEgi9fMPutrnL408vSBN758ElLYEkKs7q82s022jwp8b1+7FMutnv55fOXOFJtSnA/xMpeZ9Ag6md8axlHoEf;4:usUAf2DW99enFQcuCRYLy4J6f0kmpLE/5SbCRxHzkrxZ0GzCDeecyd1/V1fIYfWaGeWjgcbn6+dagkCEP3hsdfySO1LH2YBhXJ7yZ5gxJguaOfo9VAnCypb7BGHhmylQHgycVmIlAXn1OBbmS/72c+ATBgSVdPksDjGu4nffW4/z3rYlJ+8lK/ZuRJSzZsfIVLQL1XeBrY7WsgXYwc/qECclCP8b/Y0KfJicQe7kmEyCP7eEVNDSlExmvHyd5M4rA1AVZzSGsW4wO5CyJGtG4gPxRPzwC3zLEhdRqh6zh89VR1C/n5GMR/KtStJMNa7t
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342634E57D13046C69C334ACDB50@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(230824228335337);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39850400004)(39380400002)(377424004)(76176011)(16526019)(11346002)(2616005)(186003)(8936002)(36756003)(16576012)(31686004)(53936002)(52146003)(23676004)(305945005)(1857600001)(316002)(7736002)(110136005)(66066001)(8676002)(47776003)(2486003)(25786009)(956004)(81166006)(52116002)(230700001)(478600001)(5660300001)(45080400002)(3846002)(6116002)(4326008)(77096007)(26005)(476003)(6666003)(53546011)(55236004)(2906002)(6486002)(59450400001)(50466002)(65826007)(446003)(31696002)(575784001)(386003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6NjZ0T3JMYmFBN2p5MVZnanI2dzl1elp6?=
 =?utf-8?B?NjVrKzVPa0xWOGhUKzMyVHRRdEs5ZDBjcFA1cTE3WmgvRHVFL0d2ejB3Vks5?=
 =?utf-8?B?RVU3cnFGZjRhUDdqeThaNWwyNk1oNTNjbUFxdjQ2NjdFN0VacTBQNGJtam0r?=
 =?utf-8?B?TTU4dlZ2U2RXRUcrSEtPemZMR0F6NUo2MUVxcVhRWEE5Y2hEdnNQeURhMXEy?=
 =?utf-8?B?QXY3TFR3aUZrTXptdkJKK0p1OHBBU2k3RWZ6b1ZNeEZReVVqTyt5SVlENXp3?=
 =?utf-8?B?MFBMSHJYQ0NOaEhoV3dVS1M1aDJzTE1waHBQcm84MHdROGo1cEhSTnZGTW9k?=
 =?utf-8?B?MFpPUHRvQitSNTNYNEx4OTBTKzZVNDFDVnVlWmw3Q01uaGtaeVMrRngrU2Ey?=
 =?utf-8?B?dGh4WlhCdGlteFY4R2V4NTlFKzhHRHowT0Z0RklQTnovMWtzaDJkTDhudG5a?=
 =?utf-8?B?V0ZyQWZ2emJNMnNLSjlBRGJWRWpyeU9RUy9WekxXeXlXKzN3VVNOMnJkeEtp?=
 =?utf-8?B?Uks5S1RCaUF0dERTbFJNcm9mUms0bDNiUjBQSWNYWDNtQUxRVFpaQUluRWZF?=
 =?utf-8?B?MlRqZnZUSUZyTUNUSE5qVzN0Z0JEeHZnbmIzUHd5WGVrU0ZZUXNUWFZnK0pk?=
 =?utf-8?B?NUZaWE9QdHg4eGZmMUJEd25RazZIaVZROHplaUhwUTFEOEJwSEZZOC9obW4w?=
 =?utf-8?B?WWNVOUpaQytQdEZMV201YVMvNXlmQ1NsaytwdnczbUhmbmZDNER0amJ0dXJE?=
 =?utf-8?B?Vk9ONFdXUUhVbTQ4dW1xdStXalZWcGRDdGZSSlZkNW1acDNQc2g4aEd6UDFH?=
 =?utf-8?B?eld0NmJDNjd5aU1CSElXU2hjWkhMQXVLZjBBMVN6RnI4Z1JOWmQrVHBZaTZN?=
 =?utf-8?B?K2ZKWnNCc1NSUkl4eUNLRW11dG1ReHo5WTJmK3M0RmxzYkM2b0ZsdThGUzlJ?=
 =?utf-8?B?aTA0UWNwTmZMdmNLYjdwV1Nlck5JRURTWnpMMFg0MDhwODJuOFZIYkFHSmsz?=
 =?utf-8?B?bFU1QkdFRW5oNkY2RU1oS3FvTTNHeEhrZGJTdUs0clQyWlJaQ3NhTG8ydmVo?=
 =?utf-8?B?OGc5azIxM2RaM3QycmJPekh5K1hkTEs3Z0VqRnZpVE5rVFJ0akU0alJMb2V1?=
 =?utf-8?B?Z0RrQUE3Rkg1d2lqL3BUZi9Bc2gvR0ZzdU5GbERldHlVTmVyem1GVjlialU3?=
 =?utf-8?B?d0ZZR2ptc3diUEZZZ1ZXZGFHWmtLblF4eFFGYkVQeU9IZ3ovMDJRd3dZVjlE?=
 =?utf-8?B?TERGM0I5MHpMRmZvL01yanJFMmhIZkQ4eVJLWTZySlpObmpCdXg4blpSNDg1?=
 =?utf-8?B?c3lhTTVSSzdJbVBYcXhxWHZUaEx6VTRRSGJFc1UvT1ZaTHpTTGdnQnI1YlZ0?=
 =?utf-8?B?UjFIV1FWanE1S3hCdG13WVhqZjF2TUd2c1lCckxtQ3dCdWhuWWNzUGRwVThN?=
 =?utf-8?B?RU1uaG9ZQWtsVE9zY1JjWjBXTGVJTnpuVlg3U2lTM1c1Y2NnMGZHTHduSkxv?=
 =?utf-8?B?ZzdnelU1dkNmR1ZOOWxHaHhCN1Rscno1UGxRSUhzUFk5WUg4T3B2WDd4Mzhs?=
 =?utf-8?B?cndpcnVna2NJUWZtMVJ1TXNLVDNpRTF2bmJqOU1zNVlNNnhLTmpxRnhVa2p3?=
 =?utf-8?B?TWVtVmpzSlNmY1VNRDJzcld0N05BMUlFMWlPL2x5Yzh1eUNvc1U1NU1tSlpP?=
 =?utf-8?Q?5vohmZLG/LUDU3aav6Bp1ufOYdNbJZrcwyRMHKkgg?=
X-Microsoft-Antispam-Message-Info: n8r737uF6tCvT3HRXcTrzOLoEDmHzGUVkodNAHjKo9PeJkEyxxiu2hW3z4Y0JceQXtKMnW7Tcqbi8w72T7ELZWh29rLs9kR9EZ84I6NdefXsLZNJEH4ZDKDJr7D6MSU0YYIuaYGd3If6gX1ceCu82CaRgFASip+iuXCbudJRV52aMpRdEx/49ZNX0BCEyYYI
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:yr1v+mqqnN5oh+dRecNQnmg18oJyTEUqz0ptmtR/kvyKS+j9prm9JWVMtP7y4KqOtWWmwY6PCPetVlj8wweyT7/BBof0+nTG9VuDN93LomeHHIpSQ0HcxAAo1yybfX5KKVTCPwmWvmUDi4ZU+sooHfiE7F2OfdnkrAsTeH667LsL4VrkqTvB22K8z3Gn1VFuRTjQ+S01Gx6+WqXkOvaIriLLRwF7RFoVbqRCxiidELvT2vvqsKXLwa58J1EjZbGCvZpDgf4kErRWW8/oi9KAySEydNVj4hU/cxVYu3OlI9iYE4iwZXfRsuIBvJ2RJH6bcSA4avZus0ALxE8zqjZwyVh4akmg8zX/dMI50C6+16mRTqr1loI1uAcx4P6fetXVd2m7jqXJ5vfp/q/ZMFiVsJbggDGqUADMlwnzL1/fASWFnG3/OORG9KRHVmkQJOMJrVkgVh3J+UUmpHGC8DTtEQ==;5:bKele2IJByC58rVXNLiAstuxY3OapP9mGLnAbl4oT5mjyFlsK7XtiYPm4Fc6d8yqfXOB8H+v41w9R9E3iG7KRrkkgpYmKc/se62DI+S+fyhIjVl7IpiDxK2kIRidyrlBWh46Qzo1chPNQ8wfc/ZE47j+NIAOqFmH1coOf+eAhls=;24:Rzh14IuwhPtNVSdrWCjGIDYM9aPv0xyazfMYagInOZCerw+L4aE+dvKmuOyyTrxDrYA37D/iWYc+WVj4gvpjMVy4y6imPvRU+ekDSs7VNOo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:gI9LVMwGCs5M88FHi2hEr9OFU3zowtBnz/M24FJWJphNZVhwAsreX6ygIL/4+0/5QzfYIStISE/ooo/kF5/jm/CTn1ugis7Vpk5NpCjLvmOMxd6UAwVbIGNisX24uNoQxcRYb2m1+Q+6Yqm4/I25fMoWD8MuiZtVBtLVLP5hKAP02S6i1NPCQ5Fhu7GZfYMZZIfv/FDOFSa67eJp8grGJQ+9ThxXbztnFDWaOStoTMExw++TgCsf9nVVBoDKF2Au;20:nMwdSL4E5/xIHTNVHjEmHP5OUx0Nm6Cfk/t5A0g7wc4xZFMn2S17T8TA1cN9UO/P9bXc7FpYz2Qn4DrQlXd1qy3Rq7y+bwBMK1OAKfT01EXt3rT2HXkpVFMOGPqDTu3Bjzw9pra2vQE9a51b6zkcY9wb9QWXN59XZE0gw2Bo2Ww=
X-MS-Office365-Filtering-Correlation-Id: 2a0815a2-8a1e-45af-312e-08d5a5f42491
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 12:50:34.2047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0815a2-8a1e-45af-312e-08d5a5f42491
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Al,

commit 87b95ce0964c016ede92763be9c164e49f1019e9 is the first after which the below test crashes the kernel:

    Author: Al Viro <viro@zeniv.linux.org.uk>
    Date:   Sat Jan 10 19:01:08 2015 -0500

    switch the IO-triggering parts of umount to fs_pin
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

$modprobe dummy

$while true
 do
     mkdir /var/run/netns
     touch /var/run/netns/init_net
     mount --bind /proc/1/ns/net /var/run/netns/init_net

     ip netns add foo
     ip netns exec foo ip link add dummy0 type dummy
     ip netns delete foo
done

[   22.058349] ip (3249) used greatest stack depth: 8 bytes left
[   22.182195] BUG: unable to handle kernel paging request at 000000035bb1f080
[   22.183065] IP: [<ffffffff810718e4>] kick_process+0x34/0x80
[   22.183065] PGD 0 
[   22.183065] Thread overran stack, or stack corrupted
[   22.183065] Oops: 0000 [#1] PREEMPT SMP 
[   22.183065] CPU: 1 PID: 3255 Comm: ip Not tainted 3.19.0-rc5+ #111
[   22.183065] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[   22.183065] task: ffff88007c475100 ti: ffff88007b3cc000 task.ti: ffff88007b3cc000
[   22.183065] RIP: 0010:[<ffffffff810718e4>]  [<ffffffff810718e4>] kick_process+0x34/0x80
[   22.183065] RSP: 0018:ffff88007b3cfcf8  EFLAGS: 00010293
[   22.183065] RAX: 0000000000012900 RBX: ffff88007c475100 RCX: ffff88007b20e7b8
[   22.183065] RDX: 000000007b3cc028 RSI: ffffffff819b05f8 RDI: ffffffff819cb999
[   22.183065] RBP: ffff88007b3cfd08 R08: ffffffff81cbf688 R09: ffff88007d3d0810
[   22.183065] R10: ffff88007fc933c8 R11: 0000000000000000 R12: 000000007b3cc028
[   22.183065] R13: ffff88007c475100 R14: 0000000000000000 R15: 00007fff7793a448
[   22.183065] FS:  00007fc987546700(0000) GS:ffff88007fc80000(0000) knlGS:0000000000000000
[   22.183065] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   22.183065] CR2: 000000035bb1f080 CR3: 0000000001c11000 CR4: 00000000000006e0
[   22.183065] Stack:
[   22.183065]  ffff88007c3b67b8 ffff88007b3cfd98 ffff88007b3cfd18 ffffffff81066b05
[   22.183065]  ffff88007b3cfd38 ffffffff81176f4c ffff88007b3cfd48 ffff88007c3b68a0
[   22.183065]  ffff88007b3cfd48 ffffffff8117777f ffff88007b3cfd68 ffffffff81177a49
[   22.183065] Call Trace:
[   22.183065]  [<ffffffff81066b05>] task_work_add+0x45/0x60
[   22.183065]  [<ffffffff81176f4c>] mntput_no_expire+0xdc/0x150
[   22.183065]  [<ffffffff8117777f>] mntput+0x1f/0x30
[   22.183065]  [<ffffffff81177a49>] drop_mountpoint+0x29/0x30
[   22.183065]  [<ffffffff81188df6>] pin_kill+0x66/0xf0
[   22.183065]  [<ffffffff81082c60>] ? __wake_up_common+0x90/0x90
[   22.183065]  [<ffffffff81188ed9>] group_pin_kill+0x19/0x40
[   22.183065]  [<ffffffff811761d8>] namespace_unlock+0x58/0x60
[   22.183065]  [<ffffffff81178cae>] drop_collected_mounts+0x4e/0x60
[   22.183065]  [<ffffffff8117a3ed>] put_mnt_ns+0x2d/0x50
[   22.183065]  [<ffffffff81068b0a>] free_nsproxy+0x1a/0x80
[   22.183065]  [<ffffffff81068c68>] switch_task_namespaces+0x58/0x70
[   22.183065]  [<ffffffff81068c8b>] exit_task_namespaces+0xb/0x10
[   22.183065]  [<ffffffff8104eb57>] do_exit+0x2c7/0xc00
[   22.183065]  [<ffffffff8104f50a>] do_group_exit+0x3a/0xa0
[   22.183065]  [<ffffffff8104f57f>] SyS_exit_group+0xf/0x10
[   22.183065]  [<ffffffff817ad092>] system_call_fastpath+0x12/0x17

Kirill

On 19.04.2018 01:08, Kirill Tkhai wrote:
> Hi, Alexander!
> 
> On 18.04.2018 22:45, Alexander Aring wrote:
>> I currently can crash my net/master kernel by execute the following script:
>>
>> --- snip
>>
>> modprobe dummy
>>
>> #mkdir /var/run/netns
>> #touch /var/run/netns/init_net
>> #mount --bind /proc/1/ns/net /var/run/netns/init_net
>>
>> while true
>> do
>>     mkdir /var/run/netns
>>     touch /var/run/netns/init_net
>>     mount --bind /proc/1/ns/net /var/run/netns/init_net
>>
>>     ip netns add foo
>>     ip netns exec foo ip link add dummy0 type dummy
>>     ip netns delete foo
>> done
> 
> Fast answer is the best, so I tried your test on my not-for-work computer.
> There is old kernel without asynchronous pernet operations:
> 
> $uname -a
> Linux localhost.localdomain 4.15.0-2-amd64 #1 SMP Debian 4.15.11-1 (2018-03-20) x86_64 GNU/Linux
> 
> After approximately 15 seconds of your test execution it died :(
> (Hopefully, I executed it in "init 1" with all partitions RO as usual).
> 
> There is no serial console, so I can't say that the first stack is exactly
> the same as you see. But it crashed. So, it seems, the problem have been
> existing long ago.
> 
> Have you tried to reproduce it in older kernels or to bisect the problem commit?
> Or maybe it doesn't reproduce on old kernels in your environment?
> 
>> --- snap
>>
>> After max ~1 minute the kernel will crash.
>> Doing my hack of saving init_net outside the loop it will run fine...
>> So the mount bind is necessary.
>>
>> The last message which I see is:
>>
>> BUG: stack guard page was hit at 00000000f0751759 (stack is
>> 0000000069363195..0000000073ddc474)
>> kernel stack overflow (double-fault): 0000 [#1] SMP PTI
>> Modules linked in:
>> CPU: 0 PID: 13917 Comm: ip Not tainted 4.16.0-11878-gef9d066f6808 #32
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> RIP: 0010:validate_chain.isra.23+0x44/0xc40
>> RSP: 0018:ffffc900002cbff8 EFLAGS: 00010002
>> RAX: 0000000000040000 RBX: 0e58b88e1d4d15da RCX: 0e58b88e1d4d15da
>> RDX: 0000000000000000 RSI: ffff8802b25ee2a0 RDI: ffff8802b25edb00
>> RBP: 0e58b88e1d4d15da R08: 0000000000000000 R09: 0000000000000004
>> R10: ffffc900002cc050 R11: ffff8802b1054be8 R12: 0000000000000001
>> R13: ffff8802b25ee268 R14: ffff8802b25edb00 R15: 0000000000000000
>> FS:  0000000000000000(0000) GS:ffff8802bfc00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: ffffc900002cbfe8 CR3: 0000000002024000 CR4: 00000000000006f0
>> Call Trace:
>>  ? get_max_files+0x10/0x10
>>  __lock_acquire+0x332/0x710
>>  lock_acquire+0x67/0xb0
>>  ? lockref_put_or_lock+0x9/0x30
>>  ? dput.part.7+0x17/0x2d0
>>  _raw_spin_lock+0x2b/0x60
>>  ? lockref_put_or_lock+0x9/0x30
>>  lockref_put_or_lock+0x9/0x30
>>  dput.part.7+0x1ec/0x2d0
>>  drop_mountpoint+0x10/0x40
>>  pin_kill+0x9b/0x3a0
>>  ? wait_woken+0x90/0x90
>>  ? mnt_pin_kill+0x2d/0x100
>>  mnt_pin_kill+0x2d/0x100
>>  cleanup_mnt+0x66/0x70
>>  pin_kill+0x9b/0x3a0
>>  ? wait_woken+0x90/0x90
>>  ? mnt_pin_kill+0x2d/0x100
>>  mnt_pin_kill+0x2d/0x100
>>  cleanup_mnt+0x66/0x70
>> ...
>>
>> I guess maybe it has something to do with recently switching to
>> migrate per-net ops to async.
>>
>> - Alex
> 
> Kirill
> 
