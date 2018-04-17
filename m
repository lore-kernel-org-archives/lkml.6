Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeDQJE1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:04:27 -0400
Received: from mail-db5eur01on0097.outbound.protection.outlook.com ([104.47.2.97]:26352
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751211AbeDQJEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:04:21 -0400
Subject: Re: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
To: jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, peterz@infradead.org,
        mingo@redhat.com
References: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a8ead09e-2a4d-b664-44f9-12f12262f093@virtuozzo.com>
Date: Tue, 17 Apr 2018 12:04:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0054.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::43) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:/i+YyQadahpbYvLGaSoKF8uLo6SHvyknQdXMu/n7NgViBUbDNocoblrxRgFQHSAGWbPI/cj/e9bCmgEdbtpNtyRI4vyq4azSzAI7GfBkliiu9E2lbLhgV6MxFIQmsyBjyB0urL9FMJcR96kkq/+k6oSYu7XuVIODJFossOPc2w1E47qUIeazh1v8lVzCRowDEReljEteeoPv5GpDTuHgjII1/X1ryYVKqMrxvr6ERGdvFyaxt43XIw+D4hAf6byd;25:Veteib6q6OVY8xPgEDf2BJQK5Hzjg2mPCHeyC9tI7B9+nULCPsvThsb/NJpoe0XWRBRQh2DYCr2TNbdyk/Ol4lzI4xjJbd+cshmFqJvnr1x3tz+eK78B3fYB/aNJa3UZ10rgb7JknXYci0sXPT1dxm9+3O1MLftvuuK2WRoMbyqqUfimfjMlUBIX/9ICwX+RcBjUEdkkkOG1BIy9Hh92LQJB4IAlmAbQpCam1l3oH7cWX6jko/DSDzXzlBL1hQs97W96FjWG0t4K5stXez0poGU6xb7DN2c65fuRKAt+J8GucHPX84P/t29fAV+o07m36IqAS8UHOve7ouOHW0VRPA==;31:fwiO3CBM1WhTmGq5FYtjp16CnzpWGTw92Misw1RFJRIfkVledmva2z6Eb6t9X+FT5EN7Bkz+TgFHoa7mSwlHIY14IMwdMz9Y8xhugSgF5/0KjT91+/4Y7Sqhe6Fpm8vUcc06ltTimRyL69qZPH6uk8ntbQObcWj41sy4QLLBmLUnBejOddeoNAQvEkC4wFg6KzlpRJPMCYQ0gnZdJ4tXfPO2U41GeTrN9T+GLp4Cy/Q=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:WKezcoXYwyYRWqxakfFZj5vnqP94kjiWOlrApJ5xvbohb253pL5Y5RleL2zmkS4p+sY6g29kd3CmKY8O6aPUdUb4es0fo4hO/fJbnhUwW9EvXxHg7kbUsjHRdAfVx4+EDu1KJcLNyanS+DphacYyvsuJczAKXgF9nCCvZkivUstRXd8pp6jfgfqTbVNUWQtVMX2HH3mR+XPopzhPVfImbuVyt6hzRVPTMGok+cC4bsF7eJCGDAfiMZ/2UT/pi0eMhlPRdrvgO3YgdR6nehEWJgkFP2lWpNRr7GDanAuDYlS7YPO24nzSl2jptZRWZNsKexMLcl5BF3BW1R2IM3IHQIANizxlm+xvQM3atrDNYn1BZoLTw533uNFSyZeczKk1NxObaYFWoZp4EfNWyHokEYjpqA3LI3T0+IOUiRwPtyMii5RJiQbeFCPu3WiogBNQuxwX9gIZJWEt0oXzhriMCW6DnoHgTcfui8wriqky9rRxsMZQ1VkjWA0J5aEwNdxG;4:XxFGwbtBpWeiswX1u1l/QiTTuXmF1eJut+FGwHnSh/BsACw3ri/WjL/XmwDcZ0Iv44Zo8QPSDYo3zuhN40/a5gsegzfPLvdygg7pnYW/A+IzwwLpwJ32DveNMs40CnTegrKrCOvrKmR6pq9ivQ33Zr42MR77edvhj1/xMzL2tz5B4y7B223aLCtfi4YA5xPemr3e8fKurK4jhfWcw2utan8H8A+AjfEV+CqzT7B60IFKNbZwbknmgcKvYpZT0RsB1ZU1vZjkTAj0KzKH5jrpNQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13392B6FDF5EA10AF5CA44F4CDB70@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501359)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(39850400004)(346002)(366004)(39380400002)(189003)(199004)(50466002)(97736004)(476003)(230700001)(65826007)(6666003)(3846002)(77096007)(6116002)(26005)(956004)(31686004)(2616005)(36756003)(478600001)(316002)(64126003)(7736002)(53936002)(186003)(305945005)(16526019)(6486002)(446003)(6246003)(66066001)(8936002)(486006)(105586002)(58126008)(106356001)(16576012)(11346002)(81156014)(81166006)(65806001)(5660300001)(65956001)(39060400002)(86362001)(52146003)(47776003)(53546011)(8676002)(31696002)(386003)(2906002)(2486003)(52116002)(76176011)(23676004)(59450400001)(25786009)(68736007)(55236004)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6ZkVsY3NWYWYwRWFhZnM1RExqYzZZRGF4?=
 =?utf-8?B?RlVycUc1bEFlN1BOdmpqcjkyWTYwOXI2bnpmUHhtRUhLTmZsSGxVV2NNR2d2?=
 =?utf-8?B?Q24rRHFFQ2xOT1QvNEFLOWc0U0RiWVkxaHMxOTZRU2E4VzlJc21SS2hUWmtw?=
 =?utf-8?B?RTBnUFo4S2VRRzZraDArdUpJNUVQMmJ3TXFiRWZpdms3UTZONGRKWDBNUGtE?=
 =?utf-8?B?UzRGTTdsMjhEd082R2M2TUg2UFlLdTdUcDhwbjNVVVNyaWZoU2xiWHVPRmcx?=
 =?utf-8?B?M0dTWStrSXZwSVJRaFpLVG4vK3VvQmV6b3pnRFZSMzNhcVV2bFk5SVBUbThw?=
 =?utf-8?B?cHd6MGxqaUlmU1RTMEpaSHZDRUZTeE5vQ2xUTUlWMENDeFc3ekdqSEJPT2VT?=
 =?utf-8?B?Sk9WWnkzTHRXYldhazFlU2NMMFNRWi9jZzJ4Y0xwekhmRERlWWJ6aTN5SSsw?=
 =?utf-8?B?bTMyTmhYaFZNcFcwdVgyVkhCUHFweUhQdGFTOUpFZnNxYW0yTmY1RjlVRzVi?=
 =?utf-8?B?NEdSRkoyU2k2TzJMMkFjLzZ2NnhDakF3aFEyZWZ2V29oVzVSNTF1TFRNcFFr?=
 =?utf-8?B?RTZLUWwwbnk5SDJsUzVJSkJ0WHFraEd5QzlqQWk2cDNzaThzdUdUd0VvaG1J?=
 =?utf-8?B?U1JNbXhWQTdFRmlGVmRmV210UEUzS083enJoZ0ZtNHNhai9hZHBDZ2lFTmFi?=
 =?utf-8?B?cVh0TGpydEUyTGFtUnFLU25kVVE1MEZxT0l1YmtlRVpQZFBOWEQwa1MvUndt?=
 =?utf-8?B?QzVzS1lITTFVNE5Pd21YdjYwZzRyWWxVZGhMaVNMUGtpQVRqU1puc2ZGREhK?=
 =?utf-8?B?MzFtbzA5M3JQRlh3cFZPQnJtcTNsUjBUSCtZSDFWdDBIaUtkRXRLSEErUklV?=
 =?utf-8?B?ZTE2dTRmeDltOEJ4YS91QU13bUFyaktsaktDY216UXUzeC9aaVFVcTdnU0gz?=
 =?utf-8?B?SVVlZ1JrN3ZadkVyV3kzUTg1STgwaFl6UW1LdFBEbU1aR3pWRTVYdVVKcW1T?=
 =?utf-8?B?QXdJMFhlWGdmdEdwcVUzYzJjOFVialRrUzlQTzQvTUVGR2laYjQrNE1vcjRt?=
 =?utf-8?B?SFYxaHNmWFJZYXhsMk1lNW9nckNJMEVaSy8xa3pqTkF3NEZCVHhwTkc4eW1S?=
 =?utf-8?B?VnMybmU1MmQ4bUMzSG9jSHA2Z0EvOW0wY3VIM3NzQTZ6NXVab1pVU1hXRXpr?=
 =?utf-8?B?QndYL2hSb0dDN21SZm8xSVhrMGFzdU5yZTdHUVFnYVlaNjNaUGlkYlMycmh6?=
 =?utf-8?B?dmdoTnY4OWNISkhPVjJpUnlDcWVoM3NGdGlNV21WamNYTm9LNmNvdzZDallV?=
 =?utf-8?B?TGFoZ0dnaGdvTXJEVGRzeXFNL0tBMmltL3h0SytzU2xLSHZCa0ZQdHluL3RM?=
 =?utf-8?B?aGY0RGdZWUxhQTgwSVN6cnpDUmVyNkYyckxZQ0NxbUZ2LzFJaVl6eU1saDlD?=
 =?utf-8?B?YmU3ajZSRUZZdWtmem5odzVoYUFua3ZZT2dzcFBJcDBlYTFmYWlCQ1ZIQzZr?=
 =?utf-8?B?cGMrcDJWdGpnREFkODIxUnQ3MEEyZVkvVnJLeTlyVWFXZFl2K1hPbGczeGdu?=
 =?utf-8?B?L2pnZ1N1ZXl3UUJ6WktsZURBa3VXQzh6bHVkbDFSajRsTUNGNWhwd2pmTVB4?=
 =?utf-8?B?aUtrV1dnK3A2SDZvVVFCanMzZmxxMUR3Si9aWGMybjZTcEwrV1BvaFBHSHlw?=
 =?utf-8?B?OUJLcVRpUVVFUFhZK3dGS3duUmZ5bFdLd1Jkalh6ZVlnK3dlb3ZGQk1ZZWhp?=
 =?utf-8?B?VENhVDFSVEhieUNOektiU2p3ZENySXJHZFNqOEJZVWVzQXBmZVM3TzJYVmVn?=
 =?utf-8?B?SUt2T1U5dVNvRmFhSDBOdmhwOElGQS9MaVM2NW9mVGJpUlpzWEgvbzBpT1Vi?=
 =?utf-8?B?b3diTGdEZHQ1Ry8vbkZkcFpMWHB4RGREdUt4bzBLaEpwZlhXQjVMNUtlTjZE?=
 =?utf-8?Q?Yqz2OU2QbkValeeZyBWxtX2/ImClyO84=3D?=
X-Microsoft-Antispam-Message-Info: mdeV3Wqmgh4UICDmQWK5OzFvB/XsUTpu9V+g8CMsfF+n9yJYJzYlsJ4EEjTeJ36MoIfLToWTfdjF4YAgt/9DgFjRkYheykXvvNGBNlTKUo6Sgsc7aileoW48Q1P6reIlWE9xlrmSn/m11oVgx/1gpAGqQVL+UKSt2HgnH7BKIpHiJBm0aAOdRSOnz4ZIOqCE
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:Y7LR0W5GBjl/zGKe5qmQG+0bnZN5XiRO3eRyO0uisffwhclv88LYbbM5g0wssUs5UNgHv1FCzDnKiDBOmhq1NIm+rqVnfIxQXIEnpckFMfCb8ah7KrgoFK9Hf66cvbCtp94yye1e4T1ZpbwUq5iuuQDY288nIWpJ/wG+3/Sm7bl6yu4s00Ls4jKgzIQkkoIxDV8ZaOSpDJ2oU6Cf4+e+HZ5REsmq0hJ/CT6KQLM0WzITLBcVMCFjg54jasdRA61l+kgDKldCJZSwx5tAsWgbT4gcfV2Dm9y3CVHAxkxJGRpK8sOE5vW9K7gxfllpFq5Gl2PYRLjgRXfdJ2yoz2s5Rlq9n2nQEZs2/BqyKAgfdAkFal/iK/8FV52N3Bmyp+XD4JckTzoCdCj8Eq0JMrRwGOikc4yBGwtjTFHF1p7/PgehN1SCBeEHFcDDXM7/cwt7UISoqKIfn0Aju0SzaWcsIQ==;5:PfdpBTXDqQR0x3rtQDhfUws5or9QmvvqBrcDkSKGNnNZiN8ijHNQJJ6lfcfnuN5VY92Wds/dE8KjNJQtib8idbWnGr4QPIMcIcI9PLM9HrYy0djVOGwn47mVWNCGSEGkUg5Sri1bdYT0CzojMMoAeFbwmS2cWVgyiaZqX9jvVH4=;24:znnQze9obGVYiGr21FlGdBp0Guol0c1FswwgS2kn3986p28WasiJlgJpfpSvBcc40EXrMZXtMds2y5RmF4vg0cfZmzTg9hrgpt15oE+BEiA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:AahzOxvmRxt1VhztkQEHKzjTjeLz0+zWuQZ19JF+33cxoSQOiTToSMfNJuh38J0NeHufL8w1SBjcA6BIvsbqVQ8gpAW7ky/A/HvVaRcTddsuwjPVk2/32jo6ZZ99mQ7FJCiUucr4MkCJ9F7SNZTTdWFpWDG2Xm3xXI+oj69XrUiwXp4q1m4xqCH+dqo+K+e9EOFhtjbhFpMwgon+r9JExdOlm4U31RqxmOP9DLq3fPCK8RCifUi/vzwRVXbfw4pa;20:z4uon4N3R41bLXHmDg44fj5hZBIr1UcKardlDwgLBpArG8t7uBtTxJEcFJwR7RXVlBMr74oPIG2+AALx3vG3ZkQe4w1cbROCNwqJG6CL6SwPlZRI4MccmJG2sT9HK1v5uM6QoVzNA3Nb1W1DA8UIt+Jt851xaDzf2s5QHfhrVzc=
X-MS-Office365-Filtering-Correlation-Id: ebb396ed-9d73-4d89-9667-08d5a4423289
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 09:04:16.1873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb396ed-9d73-4d89-9667-08d5a4423289
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

almost two weeks passed, while there is no reaction.

Jeff, Bruce, what is your point of view?

Just to underline, the problem is because of rw_lock fairness, which does not
allow a reader to take a read locked lock in case of there is already a writer
called write_lock(). See queued_read_lock_slowpath() for the details. This makes
rw_lock fair, and it does not allow readers to occupy the lock forever without
a possibility for writers to take it.

Kirill

On 05.04.2018 14:58, Kirill Tkhai wrote:
> I observed the following deadlock between them:
> 
> [task 1]                          [task 2]                         [task 3]
> kill_fasync()                     mm_update_next_owner()           copy_process()
>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>   send_sigio()                    <IRQ>                             ...
>    read_lock(&fown->lock)         kill_fasync()                     ...
>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
> 
> Task 1 can't acquire read locked tasklist_lock, since there is
> already task 3 expressed its wish to take the lock exclusive.
> Task 2 holds the read locked lock, but it can't take the spin lock.
> 
> Also, there is possible another deadlock (which I haven't observed):
> 
> [task 1]                            [task 2]
> f_getown()                          kill_fasync()
>  read_lock(&f_own->lock)             spin_lock_irqsave(&fa->fa_lock,)
>  <IRQ>                               send_sigio()                     write_lock_irq(&f_own->lock)
>   kill_fasync()                       read_lock(&fown->lock)
>    spin_lock_irqsave(&fa->fa_lock,)
> 
> Actually, we do not need exclusive fa->fa_lock in kill_fasync_rcu(),
> as it guarantees fa->fa_file->f_owner integrity only. It may seem,
> that it used to give a task a small possibility to receive two sequential
> signals, if there are two parallel kill_fasync() callers, and task
> handles the first signal fastly, but the behaviour won't become
> different, since there is exclusive sighand lock in do_send_sig_info().
> 
> The patch converts fa_lock into rwlock_t, and this fixes two above
> deadlocks, as rwlock is allowed to be taken from interrupt handler
> by qrwlock design.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> I used the following program for testing:
> 
> #include <unistd.h>
> #include <stdlib.h>
> #include <signal.h>
> #include <fcntl.h>
> #include <errno.h>
> #include <stdio.h>
> 
> #ifndef F_SETSIG
> #define F_SETSIG 10
> #endif
> 
> void handler(int sig)
> {
> }
> 
> main()
> {
> 	unsigned int flags;
> 	int fd;
> 
> 	system("echo 8 > /proc/sys/kernel/random/read_wakeup_threshold");
> 	system("while :; do ls -R / > /dev/random 2>&1 ; echo 3 > /proc/sys/vm/drop_caches; done &");
> 
> 	if (signal(SIGINT, handler) < 0) {
> 		perror("Signal");
> 		exit(1);
> 	}
> 
> 	fd = open("/dev/random", O_RDWR);
> 	if (fd < 0) {
> 		perror("Can't open");
> 		exit(1);
> 	}
> 
> 	flags = FASYNC | fcntl(fd, F_GETFL);
> 	if (fcntl(fd, F_SETFL, flags) < 0) {
> 		perror("Setfl");
> 		exit(1);
> 	}
> 	if (fcntl(fd, F_SETOWN, getpid())) {
> 		perror("Setown");
> 		exit(1);
> 	}
> 	if (fcntl(fd, F_SETSIG, SIGINT)) {
> 		perror("Setsig");
> 		exit(1);
> 	}
> 
> 	while (1)
> 		sleep(100);
> }
> ---
>  fs/fcntl.c         |   15 +++++++--------
>  include/linux/fs.h |    2 +-
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 1e97f1fda90c..780161a11f9d 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -865,9 +865,9 @@ int fasync_remove_entry(struct file *filp, struct fasync_struct **fapp)
>  		if (fa->fa_file != filp)
>  			continue;
>  
> -		spin_lock_irq(&fa->fa_lock);
> +		write_lock_irq(&fa->fa_lock);
>  		fa->fa_file = NULL;
> -		spin_unlock_irq(&fa->fa_lock);
> +		write_unlock_irq(&fa->fa_lock);
>  
>  		*fp = fa->fa_next;
>  		call_rcu(&fa->fa_rcu, fasync_free_rcu);
> @@ -912,13 +912,13 @@ struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasy
>  		if (fa->fa_file != filp)
>  			continue;
>  
> -		spin_lock_irq(&fa->fa_lock);
> +		write_lock_irq(&fa->fa_lock);
>  		fa->fa_fd = fd;
> -		spin_unlock_irq(&fa->fa_lock);
> +		write_unlock_irq(&fa->fa_lock);
>  		goto out;
>  	}
>  
> -	spin_lock_init(&new->fa_lock);
> +	rwlock_init(&new->fa_lock);
>  	new->magic = FASYNC_MAGIC;
>  	new->fa_file = filp;
>  	new->fa_fd = fd;
> @@ -981,14 +981,13 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>  {
>  	while (fa) {
>  		struct fown_struct *fown;
> -		unsigned long flags;
>  
>  		if (fa->magic != FASYNC_MAGIC) {
>  			printk(KERN_ERR "kill_fasync: bad magic number in "
>  			       "fasync_struct!\n");
>  			return;
>  		}
> -		spin_lock_irqsave(&fa->fa_lock, flags);
> +		read_lock(&fa->fa_lock);
>  		if (fa->fa_file) {
>  			fown = &fa->fa_file->f_owner;
>  			/* Don't send SIGURG to processes which have not set a
> @@ -997,7 +996,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>  			if (!(sig == SIGURG && fown->signum == 0))
>  				send_sigio(fown, fa->fa_fd, band);
>  		}
> -		spin_unlock_irqrestore(&fa->fa_lock, flags);
> +		read_unlock(&fa->fa_lock);
>  		fa = rcu_dereference(fa->fa_next);
>  	}
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c6baf767619e..297e2dcd9dd2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1250,7 +1250,7 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
>  }
>  
>  struct fasync_struct {
> -	spinlock_t		fa_lock;
> +	rwlock_t		fa_lock;
>  	int			magic;
>  	int			fa_fd;
>  	struct fasync_struct	*fa_next; /* singly linked list */
> 
