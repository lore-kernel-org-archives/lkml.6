Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeDQLxX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:53:23 -0400
Received: from mail-he1eur01on0108.outbound.protection.outlook.com ([104.47.0.108]:45078
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752510AbeDQLxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:53:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] fasync: Fix deadlock between task-context and
 interrupt-context kill_fasync()
To: Jeff Layton <jlayton@kernel.org>, bfields@fieldses.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com, longman@redhat.com,
        peterz@infradead.org, mingo@redhat.com
References: <152292939368.19745.13784475656016424647.stgit@localhost.localdomain>
 <1523965358.4779.25.camel@kernel.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3a586f4f-54f9-a7a4-002a-9062b1681e16@virtuozzo.com>
Date: Tue, 17 Apr 2018 14:53:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523965358.4779.25.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0055.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::44) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:j1CNQ2mFUtZRXVDu+TcKD2F2ZCJyQyUnqFUb9idkGeQ1lJgyt/kNC5DIGJgck3Rssnz5s9fje/Z8H4ASixsE6/qmaOk7doHXarN2Dv3aR4HkKmb2x5rA3EmkKdy2VlKQnBwTehXctNeeFIeHMZuMd5met4pmz71vPQ6ytGzTpWIpa/jrpgAYX689dac1jQN+mjWPMZ2K0sqv/A00zktj9G0Jkp2iWqcO+F11Rkr0PwJXSAC+cSYdiq/q3EooWqiC;25:5YKranSl8N/TBTlwIMRbWKQvA6m+ef718arXzlUD6pZHgZSRdu1+vmLvahFWSNXTA2huXRK0y75uSy5lQy5u0GiEWZHJ/zC8tWZ/zQnFcDXkjESxS4m5JDJRLfr2U6eCc1PnyYhsGdQ02PMEhPd4uzJjTTjN1d6Eh2WtxUxprTSTP64xgabYItboevCZey1LV1m2w2XayhhmVLBP+82qVYJ0cqUL12btVgSM04azfBjbkLeEcAcqAwd2stLvthAjuKPV6UHtMnsT3ISukZlq/XeqmTIGZLkVHU7MtLu830/sOMu2/JWW3AvoBLtWR5dPJPLk0Wd1h6A+tlxMdzCKNQ==;31:r37lPPF0Ln3tgu1toEEembMYG0/UjN5QJzR7olGd/5jRNN1I5NoCidnRHJ3OWCcPYbl7Y4m38AmNBOjOdlfN6wRbV/0DRvzmvOXdWQyVtjb2yWXFmY7wLUlTeAxj1SCJIaJpr3pHl8lWew4Qv3z3M86IgRrHAbpgOnOZ5O7O+ZhPtMiXRx1P3qhsGvcagbnXQ7ISlPkuMbSH0wxJofh/U3W9CHttx3bq0oLuOrn5YvE=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:V51/5PS8meamrbuU1Isr6MVsQ23AmtQXPSy89xtZUCd+jiqJllfyyuyzGSoNSJZAlvBCzvfirondjJ5wFHDchxbv41id0qFl7ttZpPCoIXH/AwlDbEMCPI78rEA/M2nVhkiqBu+Yl0M5FzdVXf9U0FGpB1tcnnGFrILKFTAaMEWVX0diEFuH3ayfMUYoUZ96ZsSLFVJ8KdG3Zenaob7hgp0+gl21ufgtBPHRi8Ckwfe2A3zVOMaFYLVaTFRYImPtuHRIZBaVzgpp9GEveKeoDTjLnO3DR4N2RC+PlyMlsu2GzVFAaGuE0vqRd924PprLO13ksxrmeNMiNKcVEUbgb2nqf/CMATMSisl+hH4MIUeeY4shJ45cMka3QsqTazrEa+Vu+Fd2h7RDeqGaDJmtIniFOH+1yW2iWEMNpB6cUP8JTWpHpbC56pOirZypsE+AIid+KL3eHdrIo+roFn89pF/zl0uaKe2dJihXChsdS2mNDyX4PT249D0UeRZelYGV;4:Mpxtz/sj5sZj1QM5RQdOE2eZBlpCwRiopOElLSf8eqto83VSP9+kgsM1RYuXrkJCyVRIOOwJyZO6uNVH1wai4Tz25sg2wrwwTPOhsD7Jixw+AVAdkjnMOQfRGbxq2FQoCyX5w06Z6qTgE1RRcEkLE8W7wW8tWDvbxXDyG1RDhzhkpDPTgxu13FM8aowWZDDgaVkib//Z0fvtbx1mnZJE1nUjpd6ov9DL/xG0+gjzThikn68PMJ0umGbPXBVrKVRlBEoQcg0DtPvrjGw9Zw3Utgf+rP/mK60NazCZ8aG4NliNvOVniZCcH9+c+iozHJsu
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337A8AB5EF4558B45577257CDB70@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(396003)(346002)(376002)(39850400004)(377424004)(199004)(189003)(956004)(77096007)(2616005)(186003)(97736004)(478600001)(59450400001)(446003)(229853002)(11346002)(65956001)(23676004)(316002)(65806001)(36756003)(106356001)(52116002)(68736007)(66066001)(16526019)(81156014)(53546011)(50466002)(2486003)(52146003)(105586002)(76176011)(386003)(55236004)(26005)(39060400002)(6246003)(6486002)(7736002)(16576012)(305945005)(86362001)(2906002)(5660300001)(31686004)(53936002)(6116002)(25786009)(230700001)(31696002)(3846002)(8936002)(64126003)(476003)(58126008)(47776003)(81166006)(65826007)(486006)(8676002)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6Y0ZPcTJ1R253ZHFKeE8zZnZPQVhOZllm?=
 =?utf-8?B?dnR5R201amVQVENIUkR1dVJnYXIwYkxtLzMzODh4M2ZaT3I1bUplM3FHMjFB?=
 =?utf-8?B?SXlvbVdFOVNSZk1CWmJSYU1zRGtCbGxLK3RqemdqTnVGemdLTE42QU95cVlp?=
 =?utf-8?B?ZTViRmFibVo3aDYwYVpSbU1jWlZ4NUxCTkhEQ2o4Kys5dVRpWlRWQkV1R2ZH?=
 =?utf-8?B?Mlcrc214UFl0TWJtOHNOeUdlTDBzMzh4YWt2aUVWdU44Z3c5YUVSNGNZbXh1?=
 =?utf-8?B?c1JpcG9kdDFBUDVoeXdyaUhnRWNKMk9VdXUrdy9WQ0hJN29uQnZJelVjZG5Y?=
 =?utf-8?B?YTkvZjV2Wm9URitHRk9OWHJQRTF6dzdCWlU3UFZvaXhlcjRQdVVyR1llZ1VM?=
 =?utf-8?B?d2ZPZFlic1RONWpydEJveStLWjhuNDUvNFdKZkpqTXU3OFo0enc0Y01tWWZw?=
 =?utf-8?B?V25Qdy9jeVFqTENDZ2lBUThUbi9jZ0J2aFNOWXFncFkvYmZveUZvcTVpWUxo?=
 =?utf-8?B?Rzg1Y2FicXdGQjk5cDNoWUFoRlduTHA1Q0x5bG5NUHBCaFN3VFBwakZvMVIx?=
 =?utf-8?B?WkNweFUrNmlhZ3JaR0Zuam1vd0pZN3llanUyMndZalc2ZmswWVl4L2FraUJO?=
 =?utf-8?B?Rk0zSlgxL21PNWFQVStrUm16SFpSWVFKcVRKZnM3bVFYYW5vTjIxSlBjV2JE?=
 =?utf-8?B?YVNFR282TGwraWhWV0VLam5jM1d5MENiLzRHdDF1cDJ4ZWpGWkZrU1BSd2dm?=
 =?utf-8?B?TVZhRWxvUG9PTVNsNmFpYTNhTGNVS1VGQjFjVXZzb2QrTU5Qb2RRQ0Juak9h?=
 =?utf-8?B?TGhPZGJmWUNRL2dTbDh2NEQwRlcyaG9oOHpweDBsMDVXMFZrWWpiSm05TlpF?=
 =?utf-8?B?d3lEam5aNTU0K09TVFVtUmh2dWpoekFPazU0b0hDbjJEZ2w3K1JNRExEVFYr?=
 =?utf-8?B?WWxwSlpENzVmMmJsajZJK1NKYllNcGthOGFZcWt1ODlUbUtxcGpzTHR2eTJB?=
 =?utf-8?B?dXRLcXBBUG5CcFAwM3lhRiszYUNMVlU1UkgxYld2QzVxTDBqTWVMUURROGsx?=
 =?utf-8?B?b0l6OFhBU2tUU1dGdWRURFpCekZ6cUVmWVRGeVRHNm50dUU4eHVwQkN0ZjF5?=
 =?utf-8?B?MEJuYU55a1hqdE5IYlVvbnlMc1U2WFlFTm1iaVdGeFRKYVdkWXlnOHJwL3dQ?=
 =?utf-8?B?ZjVjaCszTFRzd3pwU2JVTURoT29QUmg3cDEzZEVBa0laRzlFcFlXdFRaZXc1?=
 =?utf-8?B?WEdnQ0p6VEJmOUhvZmpiVUVZZGdVa0hpK2NVVk1tMDVoS2FEOXVNWFhyYXFm?=
 =?utf-8?B?YUl4QUdrTVZOZVV5cjVJenh6alBrN3VobUZrKzJiMlFvY2VQRnRYNnlLT3hX?=
 =?utf-8?B?R3g5K2RmbnY3TXlKN2FDMGsyZkJ3VnJSZ09lSHpUTUJ1alVFSmt2WDkyOWRl?=
 =?utf-8?B?L0R6VU5qUDE5ZUZXL3YyaDRYSjc3Q1JDWnV1TXl6THJYWDlrRGp2cnJxcEUr?=
 =?utf-8?B?bXhUcSs5NW40citKZWRibm1mV0JmNlBScTFOSjhCejdiMUZzQ2hYTWdmNUd6?=
 =?utf-8?B?ZXVtL21DQmppclRCQkozN1p1NnU2WnJXekxPMG1odkdZaUhleDRYakZITGZQ?=
 =?utf-8?B?UFF4VldNdWNNUGJJV0hUY3d0bGNDVncwSktYV0FSZjJja0VDQmtGL1h4SkNw?=
 =?utf-8?B?MWp5TTlXRTlnc2xQUXRjV05uM3ZYazA1RlZmVmo2OS9lM3dEbElSMTB3OXl5?=
 =?utf-8?B?M2hGM0doVlpsRGJqd2dtMWF0TUVkUHZseDc1dmFkM1FDMmtnUElDaHNwSkxN?=
 =?utf-8?B?bkV1QWpiaFhFblJQaG9LVlVDZGpZY1hvaVF1VjEzVWg2OEViSEs2dzJHZDFV?=
 =?utf-8?B?T2RzaldWMWlEWTBrcEYvaEo3UnpzdmphbTNrS3FFRTJUVkpuSHBPYW8rQTZp?=
 =?utf-8?B?b3ZWZXdGOUx2RzVPay9lTlQ2eFB5WXhGdWx2b2lwQlhqWXVaYjRNcyt2Wll2?=
 =?utf-8?B?cXp6VCt1RTZCQXZqaFJCQUFQbGNpZVltTHFNcFdBPT0=?=
X-Microsoft-Antispam-Message-Info: 3zRHKECBGtHtC4MODPrRkKt0dUUenk2Tz55Gn5q5BhZNgbpJ/MP9X9D6lx5KgMMnr4z4gHtqLGrZZEXsbrkcrGbv3Uol9MlxOE8Op8BHLFwJKfesRqTJG0xrduiktiDNlfIBrA5b07AEc3otYXPFtbcqC7rxuDJ+iguQCLtkq/AioGfSwudY1lNeYX14QzRJ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:gsqbQ4agr4gRNTU+HwzgPB3JAX6ODabweKPhHCMO7vlCcNs8DcVkV1pP8sb25dAX990R1xKuFhtUtMvv8cYsXvx0oB/tshkQS6GHuZdrIrs06MiPXYnFv8E05hFh7bNWXwlz8dz6D1reoCDyo4pL1+51L9LVLTpk24taKaLmr/5Mijri/WPPPDjJ8woMkuspDerd2SPQphw2saNjEoVMO70z9xdGOdn1EXL4MQ1pyCYVB5htS52PK0+/fn0GPRwEowQZAViM9L9m9NbI/77yde4L60Vq7UCyakn9iAb2s1196z02gEcOiNALR+wnQK8USHOXyqH/+6MWUgu0RyS57U1iinQIgH9cOHSBBcMldRwRymbz7mZAFgTt3Yfg0Y27M7A8Zro9c3D6EwmPk4N2C5MqAlyV21bHWA1Vfd8mInXth/8R0ZZGI5tKAvLasr2i/tNOQJokgMPZYqOfAJC1ww==;5:65OvMjItRvZD7iiokaeJnYeWXcTkiLwC+VlGA+TtFF3dMgxOQoyONSVBLWnZPFT0sWBt+SOFwLmNF0lUMtQa+UUvw1k7SoMTqDc8Sr9AcNTUXvcjk75Gn/l+/y7egXvQM0Sf51gcdT/x2hgrGR8+4DrvBbIFP0qMngkuUYv9vTY=;24:ioikC0dB2PEqp96CkB6Eb+SxmVKD0zHch1Feq6m02k9Ym7ohfbL3M1bkKj459Riyx1hP7ibXfQXuIBQ8K9lbA7rM2v9zSHgH4Iev3s7m+VA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:oBKYJ2V1HOGz3c7ddySjn51UzJsReyc1HF1Mr1nVI9xJ7fNzaUU0ooLSeqLoUIMBA0zzZXNL0VK5TocjtSIglUxN4dJmthLZ/2KNhAbeDthgS6pF7Y9K2FgmjyJQV67gPkd5wXLdBobfEbZ/gHacaT8/Y7H1oQTT1fH1achld6hpuyfWrIbdCBNF8mSKRMemTwW1ye/Ms5vABb+oNz1cF1Q6Lg4cT81J6z/26q2cq6lpT0n8ebUKXS5mQRJQoBfn;20:l8tYknw/Yut+XYkQVdqHPgJWb0H9su15BR1ctUe5u79PDqQCXBAoRzbVRjFrJeuKC1amYUIiiBPm9Ok/v9rQoN2Nv5ys2CLZQRB88wJjX0c3MB3LvAfuObnVaQ6QAvgwPwHBdKwW1bwMOyDJ82KG/jifivL+ztXFJF/Ht3YnyyA=
X-MS-Office365-Filtering-Correlation-Id: cad3deb8-fa86-42c9-62b0-08d5a459cee3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 11:53:16.9252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad3deb8-fa86-42c9-62b0-08d5a459cee3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff,

On 17.04.2018 14:42, Jeff Layton wrote:
> On Thu, 2018-04-05 at 14:58 +0300, Kirill Tkhai wrote:
>> I observed the following deadlock between them:
>>
>> [task 1]                          [task 2]                         [task 3]
>> kill_fasync()                     mm_update_next_owner()           copy_process()
>>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>>   send_sigio()                    <IRQ>                             ...
>>    read_lock(&fown->lock)         kill_fasync()                     ...
>>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
>>
>> Task 1 can't acquire read locked tasklist_lock, since there is
>> already task 3 expressed its wish to take the lock exclusive.
>> Task 2 holds the read locked lock, but it can't take the spin lock.
>>
>> Also, there is possible another deadlock (which I haven't observed):
>>
>> [task 1]                            [task 2]
>> f_getown()                          kill_fasync()
>>  read_lock(&f_own->lock)             spin_lock_irqsave(&fa->fa_lock,)
>>  <IRQ>                               send_sigio()                     write_lock_irq(&f_own->lock)
>>   kill_fasync()                       read_lock(&fown->lock)
>>    spin_lock_irqsave(&fa->fa_lock,)
>>
>> Actually, we do not need exclusive fa->fa_lock in kill_fasync_rcu(),
>> as it guarantees fa->fa_file->f_owner integrity only. It may seem,
>> that it used to give a task a small possibility to receive two sequential
>> signals, if there are two parallel kill_fasync() callers, and task
>> handles the first signal fastly, but the behaviour won't become
>> different, since there is exclusive sighand lock in do_send_sig_info().
>>
>> The patch converts fa_lock into rwlock_t, and this fixes two above
>> deadlocks, as rwlock is allowed to be taken from interrupt handler
>> by qrwlock design.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>>
>> I used the following program for testing:
>>
>> #include <unistd.h>
>> #include <stdlib.h>
>> #include <signal.h>
>> #include <fcntl.h>
>> #include <errno.h>
>> #include <stdio.h>
>>
>> #ifndef F_SETSIG
>> #define F_SETSIG 10
>> #endif
>>
>> void handler(int sig)
>> {
>> }
>>
>> main()
>> {
>> 	unsigned int flags;
>> 	int fd;
>>
>> 	system("echo 8 > /proc/sys/kernel/random/read_wakeup_threshold");
>> 	system("while :; do ls -R / > /dev/random 2>&1 ; echo 3 > /proc/sys/vm/drop_caches; done &");
>>
>> 	if (signal(SIGINT, handler) < 0) {
>> 		perror("Signal");
>> 		exit(1);
>> 	}
>>
>> 	fd = open("/dev/random", O_RDWR);
>> 	if (fd < 0) {
>> 		perror("Can't open");
>> 		exit(1);
>> 	}
>>
>> 	flags = FASYNC | fcntl(fd, F_GETFL);
>> 	if (fcntl(fd, F_SETFL, flags) < 0) {
>> 		perror("Setfl");
>> 		exit(1);
>> 	}
>> 	if (fcntl(fd, F_SETOWN, getpid())) {
>> 		perror("Setown");
>> 		exit(1);
>> 	}
>> 	if (fcntl(fd, F_SETSIG, SIGINT)) {
>> 		perror("Setsig");
>> 		exit(1);
>> 	}
>>
>> 	while (1)
>> 		sleep(100);
>> }
>> ---
>>  fs/fcntl.c         |   15 +++++++--------
>>  include/linux/fs.h |    2 +-
>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fcntl.c b/fs/fcntl.c
>> index 1e97f1fda90c..780161a11f9d 100644
>> --- a/fs/fcntl.c
>> +++ b/fs/fcntl.c
>> @@ -865,9 +865,9 @@ int fasync_remove_entry(struct file *filp, struct fasync_struct **fapp)
>>  		if (fa->fa_file != filp)
>>  			continue;
>>  
>> -		spin_lock_irq(&fa->fa_lock);
>> +		write_lock_irq(&fa->fa_lock);
>>  		fa->fa_file = NULL;
>> -		spin_unlock_irq(&fa->fa_lock);
>> +		write_unlock_irq(&fa->fa_lock);
>>  
>>  		*fp = fa->fa_next;
>>  		call_rcu(&fa->fa_rcu, fasync_free_rcu);
>> @@ -912,13 +912,13 @@ struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasy
>>  		if (fa->fa_file != filp)
>>  			continue;
>>  
>> -		spin_lock_irq(&fa->fa_lock);
>> +		write_lock_irq(&fa->fa_lock);
>>  		fa->fa_fd = fd;
>> -		spin_unlock_irq(&fa->fa_lock);
>> +		write_unlock_irq(&fa->fa_lock);
>>  		goto out;
>>  	}
>>  
>> -	spin_lock_init(&new->fa_lock);
>> +	rwlock_init(&new->fa_lock);
>>  	new->magic = FASYNC_MAGIC;
>>  	new->fa_file = filp;
>>  	new->fa_fd = fd;
>> @@ -981,14 +981,13 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>>  {
>>  	while (fa) {
>>  		struct fown_struct *fown;
>> -		unsigned long flags;
>>  
>>  		if (fa->magic != FASYNC_MAGIC) {
>>  			printk(KERN_ERR "kill_fasync: bad magic number in "
>>  			       "fasync_struct!\n");
>>  			return;
>>  		}
>> -		spin_lock_irqsave(&fa->fa_lock, flags);
>> +		read_lock(&fa->fa_lock);
> 
> Does this need to be read_lock_irq? Why is it ok to allow interrupts
> here?

Read locked rwlock can be taken for reading from IRQ once again even
if there is a writer pending, while spin lock can't:

void queued_read_lock_slowpath(struct qrwlock *lock)
{
        /*
         * Readers come here when they cannot get the lock without waiting
         */
        if (unlikely(in_interrupt())) {
                /*
                 * Readers in interrupt context will get the lock immediately
                 * if the writer is just waiting (not holding the lock yet),
                 * so spin with ACQUIRE semantics until the lock is available
                 * without waiting in the queue.
                 */
                atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
                return;
        }

So, when we replace spinlock with read_lock(), we don't need disable IRQs anymore.
All we need is to make write_lock always disable IRQs.

>>  		if (fa->fa_file) {
>>  			fown = &fa->fa_file->f_owner;
>>  			/* Don't send SIGURG to processes which have not set a
>> @@ -997,7 +996,7 @@ static void kill_fasync_rcu(struct fasync_struct *fa, int sig, int band)
>>  			if (!(sig == SIGURG && fown->signum == 0))
>>  				send_sigio(fown, fa->fa_fd, band);
>>  		}
>> -		spin_unlock_irqrestore(&fa->fa_lock, flags);
>> +		read_unlock(&fa->fa_lock);
>>  		fa = rcu_dereference(fa->fa_next);
>>  	}
>>  }
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index c6baf767619e..297e2dcd9dd2 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1250,7 +1250,7 @@ static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
>>  }
>>  
>>  struct fasync_struct {
>> -	spinlock_t		fa_lock;
>> +	rwlock_t		fa_lock;
>>  	int			magic;
>>  	int			fa_fd;
>>  	struct fasync_struct	*fa_next; /* singly linked list */
>>
> 
> I've no objection to the patch in principle, but I'm not as familiar
> with the fasync code as others here.

I took the reviewers list from MAINTAINERS and ./scripts/get_maintainer.pl,
don't have an ideas what else should be CCed.

Thanks,
Kirill
