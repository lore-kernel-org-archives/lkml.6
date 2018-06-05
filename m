Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751766AbeFEFsV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 01:48:21 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34969 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeFEFsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 01:48:18 -0400
X-Google-Smtp-Source: ADUXVKLh5jBQu4JsKhjoihSMF5aRxqaF30UXvyGBk09duSzv1Uis5UnZyOp9uv8k+Dt0GxGRfMF7XvbbL5YZ2wYEN6M=
MIME-Version: 1.0
X-Originating-IP: [202.83.97.154]
In-Reply-To: <d3ff641eb0e84e25a9e1470743b3483b@ausx13mpc120.AMER.DELL.COM>
References: <CAMVG2svkh9AcLKg+A4M7+XuvdROcx4vOcZQwnTTwqLuBU-vaXw@mail.gmail.com>
 <d3ff641eb0e84e25a9e1470743b3483b@ausx13mpc120.AMER.DELL.COM>
From: Daniel J Blueman <daniel@quora.org>
Date: Tue, 5 Jun 2018 13:48:17 +0800
Message-ID: <CAMVG2st4QArJ-pC4+De2tKcL6tZzfhL3V0y+XC6NL4WMWg-ciA@mail.gmail.com>
Subject: Re: 4.14.44: BUG_ON(!list_empty(&sem->wait_list));
To: Mario.Limonciello@dell.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Jared.Dominguez@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 June 2018 at 05:47,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: Daniel J Blueman [mailto:daniel@quora.org]
>> Sent: Thursday, May 31, 2018 9:21 PM
>> To: Linux Kernel; linux-acpi@vger.kernel.org
>> Cc: Limonciello, Mario; Dominguez, Jared
>> Subject: 4.14.44: BUG_ON(!list_empty(&sem->wait_list));
>>
>> Plugging in a USB-C power source on my Dell XPS 9550 trips an ACPI
>> BUG_ON [1], reproducible with mainline 4.14.44, suggesting other
>> threads are waiting for semaphore acquisition due to
>> "BUG_ON(!list_empty(&sem->wait_list))".
>>
>> This is the current 1.7.0 BIOS with Ubuntu 18.04 userspace, plugging
>> in an LG 27UD88 (also with the current firmware) monitor USB-C
>> connection which apparently advertises 60W charging (x1,
>> PowerDelivery, DisplayPort alternative mode, data). The same issues
>> reproduce on a Dell Precision 5510 with Ubuntu 16.04, the shipped
>> kernel and 4.14.44.
>>
>> I can enable ACPI debugging if useful? Perhaps ACPI_DB_MUTEX or other
>> levels would be appropriate?
>
> I think most useful would be if this can still reproduce with 4.17.

Fair suggestion!

I can achieve 100% reproducibility of the same backtrace on a clean
Ubuntu 18.04 install with 4.17 mainline [1]:

1. disable grub 'quiet' parameter, disconnect charger and power off laptop to S5
2. power on laptop from S5
3. suspend via closing lid
4. resume by opening lid
5. connect LG 27UD88 via USB-C
6. wait 20s
7. disconnect LG 27UD88
8. run 'systemctl poweroff'
9. observe the same backtrace from acpi_os_delete_semaphore

I don't observe the issue when using an Apple 87W USB-C Power Adapter,
so it may reproduce on other monitors advertising USB-C DisplayPort
alternate mode.

Thanks,
  Daniel

[1] http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17/linux-image-unsigned-4.17.0-041700-generic_4.17.0-041700.201806041953_amd64.deb

>> kernel BUG at /home/kernel/COD/linux/drivers/acpi/osl.c:1201
>> invalid opcode: 0000 [#1] SMP PTI
>> Modules linked in: [...]
>> CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 4.14.44-041444-generic
>> #201805251612
>> Hardware name: Dell Inc. XPS 15 9550/, BIOS 1.7.0 02/23/2018
>> task: ffff9bc2ab6b9740 task.stack: ffffbOca80034000
>> RIP: 0010:acpi_os_delete_semaphore+0x6d/0x70
>> RSP: 0018:ffffbOca80037be8 EFLAGS: 00010283
>> RAX: ffffbOca83f8fc40 RBX: ffff9bc238b5dbe0 RCX: 0000000000000000
>> RDX: ffff9bc238b5dbe8 RSI: 0000000000000000 RDI: ffff9bc238b5dbe0
>> RBP: ffff9bc2adlc0990 ROB: ffff9bc2bdc25f20 R09: ffff9bc29ee56300
>> R10: ffffe03bd2796440 R11: ffff9bc2ad183fa0 R12: ffff9bc22f1321e0
>> R13: 0000000000000001 R14: 0000000000000001 R15: ffff9bc22f132eb0
>> FS: 00007fc03886f940(0000) GS:ffff9bc2bdc00000(0000)
>> knlGS:0000000000000000
>> CS: 0010 DS: 0000 ES: 0000 CRO: 0000000080050033
>> CR2: 00007ffc645e70f8 CR3: 000000049e120001 CR4: 00000000003606f0
>> Call Trace:
>> acpi_ex_system_reset_event+0x3f/0x65
>> acpi_ex_opcode_1A_OT_0R+0x70/0xfa
>> acpi_ds_exec_end_op+0x15d/0x71b
>> acpi_ps_parse_loop+0x929/0x9d6
>> ? acpi_ds_result_push+0x82/0x1d2
>> acpi_ps_parse_aml+0x1a2/0x4af
>> acpi_ps_execute_method+0x1ef/0x2ab
>> acpi_ns_evaluate+0x2e4/0x41d
>> acpi_evaluate_object+0x1cb/0x38e
>> acpi_enter_sleep_state_prep+0xae/0x13a
>> acpi_sleep_prepare.part.2+0x2e/0x40
>> acpi_power_off_prepare+0xf/0x20
>> [38871.1925361 kernel_power_off+0x42/0x70
>> SYSC_reboot+0x12f/0x210
>> ? handle_mm_fault+0xea/0x1e0
>> [38871.1925861 ? do_writev+0x5e/0xf0
>> ? do_writev+0x5e/0xf0
>> do_syscall_64+0x6e/0x120
>> entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>> RIP: 0033:0x7fc03839b373
>> RSP: 002b:00007ffc645e70f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
>> RAX: ffffffffffffffda RBX: 000000004321fedc RCX: 00007fc03839b373
>> ROX: 000000004321fedc RSI: 0000000028121969 RDI: 00000000fee1dead
>> RBP: 00007ffc645e7160 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000002 R11: 0000000000000202 R12: 00007ffc645e7168
>> R13: 0000000000000000 R14: 0000001b00000004 R15: 00007ffc645e7458
>> Code: b8 00 04 00 00 48 c7 c1 c3 91 28 ab 48 c7 c2 20 91 28 ab be of
>> 04 00 00 bf 00 00 00 01 03 41 85 04 00 58 eb b0 b8 01 10 00 00 c3 <Of>
>> Ob 90 Of if 44 00 00 80 3d 74 CO 97 01 00 41 54 55 53 Of 84
>> RIP: acpi_os_delete_semaphore+0x6d/0x70 RSP: ffffb0ca80037be8
-- 
Daniel J Blueman
