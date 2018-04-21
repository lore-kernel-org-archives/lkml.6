Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx49vxr5WzvdfDtrNOwqwA0TaQjcabrbFlVy0k0T2Ulxcmjjy/E/SpNTGmzvt4RBH2RaIf3Nl
ARC-Seal: i=1; a=rsa-sha256; t=1524324914; cv=none;
        d=google.com; s=arc-20160816;
        b=avgG4XH7td4GajkEvt9jU3szOHm4DeaDmN3fEa6Nn2KE8goNg01MVoxEVG7k6JZkDp
         DbmO4W7r4Spv6JPy2S8S3dM6Fqk866ZnDkIXaMn3Vg0krjUbW2Ku+c3EguvWaen1rNgu
         wTaL9BMnOH+I7uXjsLHA24+dlFsb8kn+dubyHvTQC/WAPra0isGVKMui+w0j+R8Eps3k
         A+7LOH5sZ6JeVyRsSkRaU4riLZ9GCNvOOpPwzMVP+ROWdsFcRA9YYKw5v7vRRPLacy4r
         /rOIabNtlhSR6V8cXGeb2WDdJCqIfPCszqBZuK8K2HxjD9/7g7HvkZE/KZ4wxCExxXoo
         C4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:from:references:to:subject
         :arc-authentication-results;
        bh=jly0znwIB4qa16gBYcKNJYFszfL4+Y+5OExRwcBkM3I=;
        b=EL5F8mMEvz2o8T4jZNB2SsnPUXlzWwiTWT25HUq9vrX1kL8kXGxGgZh/6aYmOcBfeg
         3LahcItvUUplVT/W2UwTwPiQ38F9PHUpRus3SVQxjbb7Bs+h6grfNNzB+WpEkIcrShjt
         gT0hriUnzqANPHGXUax+5DQZHEjxIVcW4eHl0W/ndvfOaFefT6yuEaULWEQN8izM7PTM
         //e3rgVvzmpwU4HkkCaUGVG6LQuhrz3ogsoY4gHv4P2vvRXft2HlQ7OXXc4ojL8G8igX
         vOEJ43gAodUcsv8+n0EZ96oUolZPF4v3uA8g4q2YHwIKT+yOf9Lor7cqt0fESa9KBj9j
         7eRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: INFO: rcu detected stall in n_tty_receive_char_special
To: dvyukov@google.com, gregkh@linuxfoundation.org, jslaby@suse.com
References: <883d24f7d4ccc52e19056928c5be@google.com>
 <001a113f8d5cab39bd0569e3482a@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Message-ID: <93a0c663-bbcf-0779-5606-6eeda644f8b9@I-love.SAKURA.ne.jp>
Date: Sun, 22 Apr 2018 00:34:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <001a113f8d5cab39bd0569e3482a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596979907220664835?=
X-GMAIL-MSGID: =?utf-8?q?1598370521243517003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dmitry Vyukov wrote:
> This looks somewhat similar to "INFO: rcu detected stall in __process_echoes":
> https://syzkaller.appspot.com/bug?id=17f23b094cd80df750e5b0f8982c521ee6bcbf40
> But I am not sure because stall stacks are somewhat different.

Yes, this will be the same one which can be reproduced using same reproducer
provided by syzbot. You can try below one like "while :; do echo -n .; ./a.out; done".

----------------------------------------
#include <fcntl.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	int fd[2];
	unsigned int zero = 0;
	char buf[128];
	int ptyno = 0;
	char c = 0;
	char data[64] = { };
	while (1) {
		fd[0] = open("/dev/ptmx", O_RDWR);
		ioctl(fd[0], TIOCSPTLCK, &zero);
		write(fd[0], data, sizeof(data));
		if (ioctl(fd[0], TIOCGPTN, &ptyno))
			break;
		sprintf(buf, "/dev/pts/%d", ptyno);
		fd[1] = open(buf, O_RDONLY);
		if (fd[1] == EOF)
			break;
		ioctl(fd[1], TIOCSTI, &c);
	}
	return 1;
}
----------------------------------------

Since tty subsystem is prone to race condition, same reproducer can hit
various different results.

[  524.349009] a.out           R  running task        0  4052      1 0x80000084
[  524.350879] Call Trace:
[  524.351816]  <IRQ>
[  524.352672]  sched_show_task+0x16b/0x230
[  524.353864]  show_state_filter+0x9d/0x190
[  524.355098]  sysrq_handle_showstate+0x7/0x10
[  524.356342]  __handle_sysrq+0x123/0x200
[  524.357566]  sysrq_filter+0x356/0x390
[  524.358710]  input_to_handler+0x4b/0xf0
[  524.359911]  input_pass_values.part.2+0x1ba/0x260
[  524.361267]  input_handle_event+0x11a/0x4f0
[  524.362504]  input_event+0x45/0x60
[  524.363601]  atkbd_interrupt+0x41a/0x6f0
[  524.364815]  serio_interrupt+0x3b/0x80
[  524.365975]  i8042_interrupt+0x1e8/0x3a0
[  524.367197]  ? _raw_spin_unlock_irq+0x24/0x40
[  524.368456]  __handle_irq_event_percpu+0x5b/0xc0
[  524.369797]  handle_irq_event_percpu+0x1b/0x50
[  524.371102]  handle_irq_event+0x2f/0x50
[  524.372245]  handle_edge_irq+0xcc/0x1a0
[  524.373433]  handle_irq+0x11/0x20
[  524.374519]  do_IRQ+0x52/0x100
[  524.375519]  common_interrupt+0xf/0xf
[  524.376648]  </IRQ>
[  524.377473] RIP: 0010:n_tty_receive_char_special+0x4d1/0xad0
[  524.379032] RSP: 0018:ffffc90006d2bd08 EFLAGS: 00000293 ORIG_RAX: ffffffffffffffd2
[  524.380957] RAX: ffffc90010f7d000 RBX: ffffc90010f7d000 RCX: 00000011c8d443f0
[  524.382783] RDX: 00000000000003ef RSI: ffff880126ce3800 RDI: 0000000000000000
[  524.384644] RBP: ffff880126ce3800 R08: 0000000000000012 R09: 0000000000000000
[  524.386479] R10: 0000000000000000 R11: ffffffff814184f3 R12: 0000000000000012
[  524.388300] R13: ffff880126ce3800 R14: 0000000a13a9e288 R15: 0000000000000012
[  524.390158]  ? n_tty_receive_buf_common+0x43/0xd00
[  524.391567]  ? n_tty_receive_char_special+0x4ea/0xad0
[  524.393052]  ? n_tty_receive_buf_common+0x43/0xd00
[  524.394464]  n_tty_receive_buf_common+0xa43/0xd00
[  524.395832]  tty_ioctl+0x3e7/0x910
[  524.397041]  ? trace_hardirqs_on_caller+0xe7/0x180
[  524.398512]  do_vfs_ioctl+0x8a/0x650
[  524.399666]  ? syscall_trace_enter+0x19e/0x250
[  524.400977]  ksys_ioctl+0x6b/0x80
[  524.402102]  __x64_sys_ioctl+0x11/0x20
[  524.403327]  do_syscall_64+0x4f/0x1f0
[  524.404494]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  524.660246] 7 locks held by a.out/4052:
[  524.661533]  #0: 00000000eb1b6dd2 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x1f/0x50
[  524.663752]  #1: 000000005920aabb (&o_tty->termios_rwsem/1){++++}, at: n_tty_receive_buf_common+0x43/0xd00
[  524.666284]  #2: 00000000fc85438a (&serio->lock){-.-.}, at: serio_interrupt+0x1f/0x80
[  524.668422]  #3: 00000000806da945 (&(&dev->event_lock)->rlock){-.-.}, at: input_event+0x32/0x60
[  524.670712]  #4: 000000005906d89a (rcu_read_lock){....}, at: input_pass_values.part.2+0x0/0x260
[  524.673017]  #5: 000000005906d89a (rcu_read_lock){....}, at: __handle_sysrq+0x0/0x200
[  524.675144]  #6: 00000000ed0ed6ec (tasklist_lock){.?.+}, at: debug_show_all_locks+0x37/0x190



[  122.170234] a.out           R  running task        0  2818      1 0x80000084
[  122.172442] Call Trace:
[  122.173402]  <IRQ>
[  122.174271]  sched_show_task+0x16b/0x230
[  122.175512]  show_state_filter+0x9d/0x190
[  122.176693]  sysrq_handle_showstate+0x7/0x10
[  122.177924]  __handle_sysrq+0x123/0x200
[  122.179122]  sysrq_filter+0x356/0x390
[  122.180237]  input_to_handler+0x4b/0xf0
[  122.181385]  input_pass_values.part.2+0x1ba/0x260
[  122.182769]  input_handle_event+0x11a/0x4f0
[  122.184131]  input_event+0x45/0x60
[  122.185191]  atkbd_interrupt+0x41a/0x6f0
[  122.186350]  serio_interrupt+0x3b/0x80
[  122.187502]  i8042_interrupt+0x1e8/0x3a0
[  122.188668]  __handle_irq_event_percpu+0x5b/0xc0
[  122.189966]  handle_irq_event_percpu+0x1b/0x50
[  122.191384]  handle_irq_event+0x2f/0x50
[  122.192522]  handle_edge_irq+0xcc/0x1a0
[  122.193679]  handle_irq+0x11/0x20
[  122.194754]  do_IRQ+0x52/0x100
[  122.195764]  common_interrupt+0xf/0xf
[  122.196875] RIP: 0010:__do_softirq+0xa0/0x233
[  122.198102] RSP: 0018:ffff88013fc03f68 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffd3
[  122.200212] RAX: ffff8801379bad80 RBX: 00000000ffffffff RCX: 0000000000000000
[  122.202019] RDX: 0000000000000d84 RSI: ffff8801379bb5b8 RDI: ffff8801379bad80
[  122.203886] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  122.205670] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  122.207536] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
[  122.209307]  ? common_interrupt+0xa/0xf
[  122.210533]  ? __do_softirq+0x9a/0x233
[  122.211711]  ? clockevents_program_event+0x76/0xe0
[  122.213047]  irq_exit+0xdc/0xe0
[  122.214156]  smp_apic_timer_interrupt+0x4d/0x80
[  122.215446]  apic_timer_interrupt+0xf/0x20
[  122.216671]  </IRQ>
[  122.217497] RIP: 0010:echo_char+0x29/0x90
[  122.218744] RSP: 0018:ffffc90006787d00 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
[  122.220616] RAX: ffffc90006959000 RBX: ffffc90006959000 RCX: 000000019b8c0c19
[  122.222449] RDX: 0000000000000000 RSI: ffff880138ee1800 RDI: 0000000000000000
[  122.224247] RBP: ffff880138ee1800 R08: 0000000000000012 R09: 0000000000000000
[  122.226116] R10: 0000000000000000 R11: ffffffff814184f3 R12: 0000000000000012
[  122.227921] R13: ffff880138ee1800 R14: 00000000d59f6933 R15: 0000000000000012
[  122.229862]  ? n_tty_receive_buf_common+0x43/0xd00
[  122.231235]  n_tty_receive_char_special+0x4ea/0xad0
[  122.232622]  ? n_tty_receive_buf_common+0x43/0xd00
[  122.234084]  n_tty_receive_buf_common+0xa43/0xd00
[  122.235449]  tty_ioctl+0x3e7/0x910
[  122.236565]  ? trace_hardirqs_on_caller+0xe7/0x180
[  122.237993]  do_vfs_ioctl+0x8a/0x650
[  122.239157]  ? syscall_trace_enter+0x19e/0x250
[  122.240467]  ksys_ioctl+0x6b/0x80
[  122.241633]  __x64_sys_ioctl+0x11/0x20
[  122.242809]  do_syscall_64+0x4f/0x1f0
[  122.243969]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  122.624858] 7 locks held by a.out/2818:
[  122.626110]  #0: 00000000d2e12ac0 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x1f/0x50
[  122.628238]  #1: 00000000c1852a2e (&o_tty->termios_rwsem/1){++++}, at: n_tty_receive_buf_common+0x43/0xd00
[  122.630579]  #2: 00000000019e0dd4 (&serio->lock){-.-.}, at: serio_interrupt+0x1f/0x80
[  122.632634]  #3: 00000000165952ed (&(&dev->event_lock)->rlock){-.-.}, at: input_event+0x32/0x60
[  122.634823]  #4: 0000000013aedeb2 (rcu_read_lock){....}, at: input_pass_values.part.2+0x0/0x260
[  122.637122]  #5: 0000000013aedeb2 (rcu_read_lock){....}, at: __handle_sysrq+0x0/0x200
[  122.639133]  #6: 0000000094121093 (tasklist_lock){.?.+}, at: debug_show_all_locks+0x37/0x190



[  701.099036] a.out           D    0  4365      1 0x80000082
[  701.100533] Call Trace:
[  701.101735]  ? __schedule+0x278/0x750
[  701.103178]  ? _raw_spin_unlock_irq+0x24/0x40
[  701.104611]  schedule+0x34/0x80
[  701.105755]  rwsem_down_write_failed+0x10a/0x230
[  701.107228]  ? call_rwsem_down_write_failed+0x13/0x20
[  701.108781]  call_rwsem_down_write_failed+0x13/0x20
[  701.110544]  ? n_tty_flush_buffer+0x14/0x50
[  701.111905]  down_write+0x3b/0x50
[  701.113148]  ? n_tty_flush_buffer+0x14/0x50
[  701.114550]  n_tty_flush_buffer+0x14/0x50
[  701.115962]  tty_ldisc_hangup+0x2a/0x1d0
[  701.117270]  __tty_hangup+0x13f/0x2b0
[  701.118820]  tty_release+0xf0/0x500
[  701.120450]  ? lock_acquire+0x43/0x60
[  701.122099]  __fput+0x95/0x1d0
[  701.123377]  task_work_run+0x84/0xa0
[  701.124632]  do_exit+0x2cc/0xac0
[  701.125713]  ? syscall_trace_enter+0x19e/0x250
[  701.127039]  do_group_exit+0x38/0xb0
[  701.128469]  __x64_sys_exit_group+0xf/0x10
[  701.129795]  do_syscall_64+0x4f/0x1f0
[  701.130946]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  701.635816] 4 locks held by a.out/4365:
[  701.637551]  #0: 0000000051b314cc (&tty->legacy_mutex){+.+.}, at: tty_release+0x4d/0x500
[  701.639958]  #1: 00000000fcddaa23 (&tty->legacy_mutex/1){+.+.}, at: __tty_hangup+0x5c/0x2b0
[  701.642259]  #2: 000000005a4dd91b (&tty->ldisc_sem){++++}, at: tty_ldisc_ref+0x15/0x50
[  701.645185]  #3: 00000000997a5bc4 (&o_tty->termios_rwsem/1){++++}, at: n_tty_flush_buffer+0x14/0x50



[  264.159739] a.out           R  running task        0  8464      1 0x80000084
[  264.159739] Call Trace:
[  264.159739]  <IRQ>
[  264.159739]  sched_show_task+0x16b/0x230
[  264.159739]  show_state_filter+0x9d/0x190
[  264.159739]  sysrq_handle_showstate+0x7/0x10
[  264.159739]  __handle_sysrq+0x123/0x200
[  264.159739]  sysrq_filter+0x356/0x390
[  264.159739]  input_to_handler+0x4b/0xf0
[  264.159739]  input_pass_values.part.2+0x1ba/0x260
[  264.159739]  input_handle_event+0x11a/0x4f0
[  264.159739]  input_event+0x45/0x60
[  264.159739]  atkbd_interrupt+0x41a/0x6f0
[  264.159739]  serio_interrupt+0x3b/0x80
[  264.159739]  i8042_interrupt+0x1e8/0x3a0
[  264.159739]  ? _raw_spin_unlock_irq+0x24/0x40
[  264.159739]  __handle_irq_event_percpu+0x5b/0xc0
[  264.159739]  handle_irq_event_percpu+0x1b/0x50
[  264.159739]  handle_irq_event+0x2f/0x50
[  264.159739]  handle_edge_irq+0xcc/0x1a0
[  264.159739]  handle_irq+0x11/0x20
[  264.159739]  do_IRQ+0x52/0x100
[  264.159739]  common_interrupt+0xf/0xf
[  264.159739]  </IRQ>
[  264.159739] RIP: 0010:__process_echoes+0xc4/0x260
[  264.159739] RSP: 0018:ffffc90003257d18 EFLAGS: 00000296 ORIG_RAX: ffffffffffffffd3
[  264.159739] RAX: 0000000000000004 RBX: 00000009abab4dd2 RCX: 00000009abab4dce
[  264.159739] RDX: fffffff65454b232 RSI: ffff880137fed800 RDI: 0000000000000000
[  264.159739] RBP: ffffc90003305000 R08: 0000000000000000 R09: 0000000000000001
[  264.159739] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  264.159739] R13: ffff880137fed800 R14: 0000000000001f00 R15: 0000000000000000
[  264.159739]  ? __process_echoes+0x14c/0x260
[  264.159739]  n_tty_receive_buf_common+0x4b6/0xd00
[  264.159739]  tty_ioctl+0x3e7/0x910
[  264.159739]  ? trace_hardirqs_on_caller+0xe7/0x180
[  264.159739]  do_vfs_ioctl+0x8a/0x650
[  264.159739]  ? syscall_trace_enter+0x19e/0x250
[  264.159739]  ksys_ioctl+0x6b/0x80
[  264.159739]  __x64_sys_ioctl+0x11/0x20
[  264.159739]  do_syscall_64+0x4f/0x1f0
[  264.159739]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[  264.159739] 8 locks held by a.out/8464:
[  264.159739]  #0: 000000000a54adcf (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x1f/0x50
[  264.159739]  #1: 000000002abad3ab (&o_tty->termios_rwsem/1){++++}, at: n_tty_receive_buf_common+0x43/0xd00
[  264.159739]  #2: 00000000705a196b (&ldata->output_lock){+.+.}, at: n_tty_receive_buf_common+0x4a4/0xd00
[  264.159739]  #3: 000000008434776a (&serio->lock){-.-.}, at: serio_interrupt+0x1f/0x80
[  264.159739]  #4: 00000000710258a9 (&(&dev->event_lock)->rlock){-.-.}, at: input_event+0x32/0x60
[  264.159739]  #5: 000000004b5299a2 (rcu_read_lock){....}, at: input_pass_values.part.2+0x0/0x260
[  264.159739]  #6: 000000004b5299a2 (rcu_read_lock){....}, at: __handle_sysrq+0x0/0x200
[  264.159739]  #7: 00000000082c04ee (tasklist_lock){.?.+}, at: debug_show_all_locks+0x37/0x190
