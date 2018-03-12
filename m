Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeCLC6V (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 22:58:21 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:38458 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932437AbeCLC6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 22:58:20 -0400
X-Google-Smtp-Source: AG47ELut6sQDwlKqD3yQXxJbimwljBsI6aBW4UwIfo6B/lLEVo0d9VH9wxdjjF/bbIJbBddhcFKOcw==
To: LKML <linux-kernel@vger.kernel.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Possible memory leak in acpi_ut_create_internal_object_dbg() in
 4.16-rcX
Message-ID: <002b1e6f-f1e8-c9e9-0083-a2bb8fb26c42@lwfinger.net>
Date: Sun, 11 Mar 2018 21:58:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running kernel 4.16-rcX, kmemleak complains about a leak of one object. This is
linux-ubqc:~ # echo scan > /sys/kernel/debug/kmemleak
linux-ubqc:~ # cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8802263b2630 (size 72):
   comm "swapper/0", pid 1, jiffies 4294892345 (age 8143.468s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 0e 14 01 00 00 05 00 00  ................
     00 00 00 00 00 00 00 00 b8 01 1d 26 02 88 ff ff  ...........&....
   backtrace:
     [<00000000a4d7a095>] acpi_ut_create_internal_object_dbg+0x4d/0x10e
     [<0000000091af3dcd>] acpi_ds_build_internal_object+0xed/0x1cd
     [<00000000c23098e0>] acpi_ds_build_internal_package_obj+0x1e6/0x32d
     [<00000000130427ae>] acpi_ds_eval_data_object_operands+0x178/0x218
     [<0000000096a9eea7>] acpi_ds_exec_end_op+0x429/0x6b7
     [<00000000bf84c466>] acpi_ps_parse_loop+0x919/0x9b1
     [<0000000038521867>] acpi_ps_parse_aml+0x1a2/0x4af
     [<00000000f5588116>] acpi_ds_execute_arguments+0x184/0x1c3
     [<000000004cdf7505>] acpi_ds_get_package_arguments+0xf8/0x124
     [<00000000d3e97ad0>] acpi_ns_init_one_object+0xca/0x133
     [<000000006c8e6828>] acpi_ns_walk_namespace+0x134/0x283
     [<00000000d83f628d>] acpi_walk_namespace+0xf5/0x13d
     [<0000000031cfada2>] acpi_ns_initialize_objects+0x103/0x1fe
     [<00000000001d0e25>] acpi_initialize_objects+0x47/0xd4
     [<000000005e2d42df>] acpi_init+0xc7/0x340
     [<000000000ef98997>] do_one_initcall+0x4e/0x18d

Using gdb to find the offending source line returns:

99              /* Allocate the raw object descriptor */
100
101             object =
102                 acpi_ut_allocate_object_desc_dbg(module_name, line_number,
103                                                  component_id);
104             if (!object) {
105                     return_PTR(NULL);
106             }
107
108             switch (type) {

My suspicion is that this is a false positive, and a kmemleak_not_leak() call is 
likely appropriate, but that decision should be made at a higher level. I am not 
sure why kmemleak is triggering on this. Most of the relevant code is more than 
10 years old.

Although leaking a single object is not serious, I prefer to eliminate it to 
ensure that every leak mentioned in the logs is something that I need to 
address. This is particularly important when I am debugging a driver.

Thanks,

Larry
