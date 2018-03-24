Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeCXPWB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 11:22:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41841 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbeCXPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 11:21:59 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
Date: Sat, 24 Mar 2018 10:20:52 -0500
In-Reply-To: <cover.1521888444.git.rahul.lakkireddy@chelsio.com> (Rahul
        Lakkireddy's message of "Sat, 24 Mar 2018 16:26:32 +0530")
Message-ID: <87muyxlctn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezkzO-0005n5-5U;;;mid=<87muyxlctn.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19bEikqnTxQxDJpI0Q0p4k/1dMUePOJOws=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4983]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1055 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 3.5 (0.3%), b_tie_ro: 2.2 (0.2%), parse: 1.60 (0.2%),
        extract_message_metadata: 43 (4.1%), get_uri_detail_list: 7 (0.7%),
        tests_pri_-1000: 23 (2.1%), tests_pri_-950: 2.2 (0.2%), tests_pri_-900: 1.81
        (0.2%), tests_pri_-400: 47 (4.5%), check_bayes: 45 (4.3%), b_tokenize: 20
        (1.9%), b_tok_get_all: 11 (1.1%), b_comp_prob: 6 (0.6%), b_tok_touch_all: 3.2
        (0.3%), b_finish: 0.80 (0.1%), tests_pri_0: 916 (86.9%),
        check_dkim_signature: 1.10 (0.1%), check_dkim_adsp: 5 (0.5%), tests_pri_500:
        10 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next v2 0/2] kernel: add support to collect hardware logs in crash recovery kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On production servers running variety of workloads over time, kernel
> panic can happen sporadically after days or even months. It is
> important to collect as much debug logs as possible to root cause
> and fix the problem, that may not be easy to reproduce. Snapshot of
> underlying hardware/firmware state (like register dump, firmware
> logs, adapter memory, etc.), at the time of kernel panic will be very
> helpful while debugging the culprit device driver.
>
> This series of patches add new generic framework that enable device
> drivers to collect device specific snapshot of the hardware/firmware
> state of the underlying device in the crash recovery kernel. In crash
> recovery kernel, the collected logs are exposed via /sys/kernel/crashdd/
> directory, which is copied by user space scripts for post-analysis.
>
> A kernel module crashdd is newly added. In crash recovery kernel,
> crashdd exposes /sys/kernel/crashdd/ directory containing device
> specific hardware/firmware logs.

Have you looked at instead of adding a sysfs file adding the dumps
as additional elf notes in /proc/vmcore?

That should allow existing tools to capture your extended dump
information with no code changes, and it will allow having a single file
core dump for storing the information.

Both of which should mean something that will integrate better into
existing flows.

The interface logic of the driver should be essentially the same.


Also have you tested this and seen how well your current logic captures
the device information?


>
> The sequence of actions done by device drivers to append their device
> specific hardware/firmware logs to /sys/kernel/crashdd/ directory are
> as follows:
>
> 1. During probe (before hardware is initialized), device drivers
> register to the crashdd module (via crashdd_add_dump()), with
> callback function, along with buffer size and log name needed for
> firmware/hardware log collection.
>
> 2. Crashdd creates a driver's directory under /sys/kernel/crashdd/<driver>.
> Then, it allocates the buffer with requested size and invokes the
> device driver's registered callback function.
>
> 3. Device driver collects all hardware/firmware logs into the buffer
> and returns control back to crashdd.
>
> 4. Crashdd exposes the buffer as a file via
> /sys/kernel/crashdd/<driver>/<dump_file>.
>
> 5. User space script (/usr/lib/kdump/kdump-lib-initramfs.sh) copies
> the entire /sys/kernel/crashdd/ directory to /var/crash/ directory.
>
> Patch 1 adds crashdd module to allow drivers to register callback to
> collect the device specific hardware/firmware logs.  The module also
> exports /sys/kernel/crashdd/ directory containing the hardware/firmware
> logs.
>
> Patch 2 shows a cxgb4 driver example using the API to collect
> hardware/firmware logs in crash recovery kernel, before hardware is
> initialized.  The logs for the devices are made available under
> /sys/kernel/crashdd/cxgb4/ directory.
>
> Thanks,
> Rahul
>
> RFC v1: https://lkml.org/lkml/2018/3/2/542
> RFC v2: https://lkml.org/lkml/2018/3/16/326
>
> ---
> v2:
> - Added ABI Documentation for crashdd.
> - Directly use octal permission instead of macro.
>
> Changes since rfc v2:
> - Moved exporting crashdd from procfs to sysfs. Suggested by
>   Stephen Hemminger <stephen@networkplumber.org>
> - Moved code from fs/proc/crashdd.c to fs/crashdd/ directory.
> - Replaced all proc API with sysfs API and updated comments.
> - Calling driver callback before creating the binary file under
>   crashdd sysfs.
> - Changed binary dump file permission from S_IRUSR to S_IRUGO.
> - Changed module name from CRASH_DRIVER_DUMP to CRASH_DEVICE_DUMP.
>
> rfc v2:
> - Collecting logs in 2nd kernel instead of during kernel panic.
>   Suggested by Eric Biederman <ebiederm@xmission.com>.
> - Added new crashdd module that exports /proc/crashdd/ containing
>   driver's registered hardware/firmware logs in patch 1.
> - Replaced the API to allow drivers to register their hardware/firmware
>   log collect routine in crash recovery kernel in patch 1.
> - Updated patch 2 to use the new API in patch 1.
>
>
> Rahul Lakkireddy (2):
>   fs/crashdd: add API to collect hardware dump in second kernel
>   cxgb4: collect hardware dump in second kernel
>
>  Documentation/ABI/testing/sysfs-kernel-crashdd   |  34 ++++
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h       |   4 +
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c |  25 +++
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.h |   3 +
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  |  12 ++
>  fs/Kconfig                                       |   1 +
>  fs/Makefile                                      |   1 +
>  fs/crashdd/Kconfig                               |  10 +
>  fs/crashdd/Makefile                              |   3 +
>  fs/crashdd/crashdd.c                             | 233 +++++++++++++++++++++++
>  fs/crashdd/crashdd_internal.h                    |  24 +++
>  include/linux/crashdd.h                          |  24 +++
>  12 files changed, 374 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-crashdd
>  create mode 100644 fs/crashdd/Kconfig
>  create mode 100644 fs/crashdd/Makefile
>  create mode 100644 fs/crashdd/crashdd.c
>  create mode 100644 fs/crashdd/crashdd_internal.h
>  create mode 100644 include/linux/crashdd.h
