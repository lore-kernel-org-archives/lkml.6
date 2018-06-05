Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeFEM2N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:28:13 -0400
Received: from www62.your-server.de ([213.133.104.62]:48653 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeFEM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:28:12 -0400
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_csum_update
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+efae31b384d5badbd620@syzkaller.appspotmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000b2a7ea056dc54779@google.com>
 <CACT4Y+a7hZ0x16PnyJxrb7akBRNr-TDR8Cvn01G27HmAKVE_vg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <19725a6e-5ef1-cebe-4a9e-6d95b03e64e7@iogearbox.net>
Date: Tue, 5 Jun 2018 14:28:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a7hZ0x16PnyJxrb7akBRNr-TDR8Cvn01G27HmAKVE_vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 07:36 AM, Dmitry Vyukov wrote:
> On Mon, Jun 4, 2018 at 1:36 AM, syzbot
> <syzbot+efae31b384d5badbd620@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    0512e0134582 Merge tag 'xfs-4.17-fixes-3' of git://git.ker..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17eb2d7b800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=968b0b23c7854c0b
>> dashboard link: https://syzkaller.appspot.com/bug?extid=efae31b384d5badbd620
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=162c6def800000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fe3db7800000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+efae31b384d5badbd620@syzkaller.appspotmail.com
>>
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in ____bpf_csum_update net/core/filter.c:1679
>> [inline]
>> BUG: KASAN: slab-out-of-bounds in bpf_csum_update+0xb4/0xc0
>> net/core/filter.c:1673
>> Read of size 1 at addr ffff8801d9235b50 by task syz-executor507/4513
>>
>> CPU: 0 PID: 4513 Comm: syz-executor507 Not tainted 4.17.0-rc7+ #78
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>>  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
>>  ____bpf_csum_update net/core/filter.c:1679 [inline]
>>  bpf_csum_update+0xb4/0xc0 net/core/filter.c:1673
> 
> /\/\/\/\/\
> 
> Are there any known bugs with unwind through bpf functions?

Looks like you don't have kallsyms export enabled, here's a syzkaller diff
to get jit images exposed, then it should work:

diff --git a/tools/create-image.sh b/tools/create-image.sh
index 9f82482..395a2a0 100755
--- a/tools/create-image.sh
+++ b/tools/create-image.sh
@@ -23,6 +23,7 @@ echo 'SELINUX=disabled' | sudo tee $DIR/etc/selinux/config
 echo "kernel.printk = 7 4 1 3" | sudo tee -a $DIR/etc/sysctl.conf
 echo 'debug.exception-trace = 0' | sudo tee -a $DIR/etc/sysctl.conf
 echo "net.core.bpf_jit_enable = 1" | sudo tee -a $DIR/etc/sysctl.conf
+echo "net.core.bpf_jit_kallsyms = 1" | sudo tee -a $DIR/etc/sysctl.conf
 echo "kernel.softlockup_all_cpu_backtrace = 1" | sudo tee -a $DIR/etc/sysctl.conf
 echo "kernel.kptr_restrict = 0" | sudo tee -a $DIR/etc/sysctl.conf
 echo "kernel.watchdog_thresh = 60" | sudo tee -a $DIR/etc/sysctl.conf

Cheers,
Daniel
