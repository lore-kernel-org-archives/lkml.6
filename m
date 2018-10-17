Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F3ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B901E21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B901E21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeJQSia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:38:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726904AbeJQSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:38:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9HAdpJ7055957
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:43:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n61dqns6q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:43:22 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 17 Oct 2018 06:43:21 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Oct 2018 06:43:17 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9HAhGMv27000846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Oct 2018 10:43:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 804FBB2067;
        Wed, 17 Oct 2018 10:43:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40AEAB205F;
        Wed, 17 Oct 2018 10:43:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.161.7])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 17 Oct 2018 10:43:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2F1E716C1AF7; Wed, 17 Oct 2018 03:43:16 -0700 (PDT)
Date:   Wed, 17 Oct 2018 03:43:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Phy Bio <wisedd@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        peterz@infradead.org
Subject: Re: rcu: Kernel stack is corrupted in: perf_trace_rcu_dyntick
Reply-To: paulmck@linux.ibm.com
References: <CAHyWSemw6LYChaEZinFTFvA=kfJKqvWMfadVq5a=+j9TcCrewg@mail.gmail.com>
 <20181002224507.17606b35@vmware.local.home>
 <CAHyWSekpo2Z35OagJFOzzFijsNLYkFtdqdiWn8ra4k8o64TtkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHyWSekpo2Z35OagJFOzzFijsNLYkFtdqdiWn8ra4k8o64TtkQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101710-0064-0000-0000-00000361B4B0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009891; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103929; UDB=6.00571449; IPR=6.00883981;
 MB=3.00023791; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-17 10:43:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101710-0065-0000-0000-00003B02CE3F
Message-Id: <20181017104316.GM2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 04:45:48PM +0800, Phy Bio wrote:
> I will be very happy, if the source code can help you analyze this problem.
> 
> The source code is in the following:
> 
> #define _GNU_SOURCE
> 
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
> 
> unsigned long long procid;
> 
> static void sleep_ms(uint64_t ms)
> {
>   usleep(ms * 1000);
> }
> 
> static uint64_t current_time_ms(void)
> {
>   struct timespec ts;
>   if (clock_gettime(CLOCK_MONOTONIC, &ts))
>     exit(1);
>   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
> 
> #define BITMASK_LEN(type, bf_len) (type)((1ull << (bf_len)) - 1)
> 
> #define BITMASK_LEN_OFF(type, bf_off, bf_len)                                  \
>   (type)(BITMASK_LEN(type, (bf_len)) << (bf_off))
> 
> #define STORE_BY_BITMASK(type, addr, val, bf_off, bf_len)                      \
>   if ((bf_off) == 0 && (bf_len) == 0) {                                        \
>     *(type*)(addr) = (type)(val);                                              \
>   } else {                                                                     \
>     type new_val = *(type*)(addr);                                             \
>     new_val &= ~BITMASK_LEN_OFF(type, (bf_off), (bf_len));                     \
>     new_val |= ((type)(val)&BITMASK_LEN(type, (bf_len))) << (bf_off);          \
>     *(type*)(addr) = new_val;                                                  \
>   }
> 
> static void kill_and_wait(int pid, int* status)
> {
>   kill(-pid, SIGKILL);
>   kill(pid, SIGKILL);
>   int i;
>   for (i = 0; i < 100; i++) {
>     if (waitpid(-1, status, WNOHANG | __WALL) == pid)
>       return;
>     usleep(1000);
>   }
>   DIR* dir = opendir("/sys/fs/fuse/connections");
>   if (dir) {
>     for (;;) {
>       struct dirent* ent = readdir(dir);
>       if (!ent)
>         break;
>       if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>         continue;
>       char abort[300];
>       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                ent->d_name);
>       int fd = open(abort, O_WRONLY);
>       if (fd == -1) {
>         continue;
>       }
>       if (write(fd, abort, 1) < 0) {
>       }
>       close(fd);
>     }
>     closedir(dir);
>   } else {
>   }
>   while (waitpid(-1, status, __WALL) != pid) {
>   }
> }
> 
> #define SYZ_HAVE_SETUP_TEST 1
> static void setup_test()
> {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setpgrp();
> }
> 
> #define SYZ_HAVE_RESET_TEST 1
> static void reset_test()
> {
>   int fd;
>   for (fd = 3; fd < 30; fd++)
>     close(fd);
> }
> 
> static void execute_one(void);
> 
> #define WAIT_FLAGS __WALL
> 
> static void loop(void)
> {
>   int iter;
>   for (iter = 0;; iter++) {
>     int pid = fork();
>     if (pid < 0)
>       exit(1);
>     if (pid == 0) {
>       setup_test();
>       execute_one();
>       reset_test();
>       exit(0);
>     }
>     int status = 0;
>     uint64_t start = current_time_ms();
>     for (;;) {
>       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
>         break;
>       sleep_ms(1);
>       if (current_time_ms() - start < 5 * 1000)
>         continue;
>       kill_and_wait(pid, &status);
>       break;
>     }
>   }
> }
> 
> void execute_one(void)
> {
>   *(uint32_t*)0x20000180 = 2;
>   *(uint32_t*)0x20000184 = 0x70;
>   *(uint8_t*)0x20000188 = 0x87;
>   *(uint8_t*)0x20000189 = 0;
>   *(uint8_t*)0x2000018a = 0;
>   *(uint8_t*)0x2000018b = 0;
>   *(uint32_t*)0x2000018c = 0;
>   *(uint64_t*)0x20000190 = 0;
>   *(uint64_t*)0x20000198 = 0;
>   *(uint64_t*)0x200001a0 = 0;
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 0, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 1, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 2, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 3, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 4, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 5, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 6, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 7, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 8, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 9, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 10, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 11, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 12, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 13, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 14, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 15, 2);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 17, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 18, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 19, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 20, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 21, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 22, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 23, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 24, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 25, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 26, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 27, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 28, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 29, 35);
>   *(uint32_t*)0x200001b0 = 0;
>   *(uint32_t*)0x200001b4 = 0;
>   *(uint64_t*)0x200001b8 = 0;
>   *(uint64_t*)0x200001c0 = 0;
>   *(uint64_t*)0x200001c8 = 0;
>   *(uint64_t*)0x200001d0 = 0;
>   *(uint32_t*)0x200001d8 = 0;
>   *(uint32_t*)0x200001dc = 0;
>   *(uint64_t*)0x200001e0 = 0;
>   *(uint32_t*)0x200001e8 = 0;
>   *(uint16_t*)0x200001ec = 0;
>   *(uint16_t*)0x200001ee = 0;
>   syscall(__NR_perf_event_open, 0x20000180, 0, -1, -1, 0);
>   *(uint32_t*)0x20000140 = 0x66;
>   syscall(__NR_ioctl, -1, 0x2283, 0x20000140);
>   *(uint32_t*)0x20000180 = 6;
>   *(uint32_t*)0x20000184 = 0x70;
>   *(uint8_t*)0x20000188 = 0x59;
>   *(uint8_t*)0x20000189 = 0;
>   *(uint8_t*)0x2000018a = 0;
>   *(uint8_t*)0x2000018b = 0;
>   *(uint32_t*)0x2000018c = 0;
>   *(uint64_t*)0x20000190 = 0;
>   *(uint64_t*)0x20000198 = 0;
>   *(uint64_t*)0x200001a0 = 0;
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 0, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 1, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 2, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 3, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 4, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 5, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 6, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 7, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 8, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 9, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 10, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 11, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 12, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 13, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 14, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 15, 2);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 17, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 18, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 19, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 20, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 21, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 22, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 23, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 24, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 25, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 26, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 27, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 28, 1);
>   STORE_BY_BITMASK(uint64_t, 0x200001a8, 0, 29, 35);
>   *(uint32_t*)0x200001b0 = 0;
>   *(uint32_t*)0x200001b4 = 0;
>   *(uint64_t*)0x200001b8 = 0x20000140;
>   *(uint64_t*)0x200001c0 = 0;
>   *(uint64_t*)0x200001c8 = 0;
>   *(uint64_t*)0x200001d0 = 0;
>   *(uint32_t*)0x200001d8 = 0;
>   *(uint32_t*)0x200001dc = 0;
>   *(uint64_t*)0x200001e0 = 0;
>   *(uint32_t*)0x200001e8 = 0;
>   *(uint16_t*)0x200001ec = 0;
>   *(uint16_t*)0x200001ee = 0;
>   syscall(__NR_perf_event_open, 0x20000180, -1, 0, -1, 0);
> }
> int main(void)
> {
>   syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
>   for (procid = 0; procid < 8; procid++) {
>     if (fork() == 0) {
>       loop();
>     }
>   }
>   sleep(1000000);
>   return 0;
> }

Does this problem ever happen without the kretprobe in place?

							Thanx, Paul

> Steven Rostedt <rostedt@goodmis.org> 于2018年10月3日周三 上午10:45写道：
> >
> > On Sat, 29 Sep 2018 17:22:13 +0800
> > 王晓东 <wisedd@gmail.com> wrote:
> >
> > > Hi there,
> > >
> > > We would like to report a kernel stack corrupted problem we identified
> > > in the perf_trace_rcu_dyntick function of tracing events subsystem.
> > > And the problem was founded by syzkaller.  We has tested the PoC on
> > > the lasted master branch of kernel(4.19.0-rc5+).
> > >
> > > The crash log generated with KASAN enabled:
> > >
> > > root@pc:~# ./perf_trace_rcu_dyntick
> > > [  582.069938] Kernel panic - not syncing: stack-protector: Kernel
> > > stack is corrupted in: perf_trace_rcu_dyntick+0x355/0x4f0
> > > [  582.069938]
> > > [  582.071341] CPU: 6 PID: 3417 Comm: perf_trace_rcu_ Not tainted 4.19.0-rc5+ #1
> > > [  582.072134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> > > [  582.073103] Call Trace:
> > > [  582.073364]  <IRQ>
> > > [  582.073614]  dump_stack+0x8c/0xce
> > > [  582.074039]  panic+0x1cb/0x3aa
> > > [  582.074427]  ? refcount_error_report+0x296/0x296
> > > [  582.075003]  ? timerqueue_del+0x71/0x130
> > > [  582.075553]  ? perf_trace_rcu_dyntick+0x355/0x4f0
> > > [  582.076063]  ? __stack_chk_fail+0x6/0x20
> > > [  582.076763]  ? perf_trace_rcu_dyntick+0x355/0x4f0
> > > [  582.077369]  __stack_chk_fail+0x1f/0x20
> > > [  582.077877]  perf_trace_rcu_dyntick+0x355/0x4f0
> > > [  582.078442]  ? rcu_gp_is_expedited+0xa0/0xa0
> > > [  582.078993]  ? rcu_gp_is_expedited+0xa0/0xa0
> > > [  582.079525]  ? check_preempt_curr+0x1c2/0x2a0
> > > [  582.080059]  ? sched_clock_cpu+0x18/0x160
> > > [  582.080551]  rcu_nmi_enter+0x1f0/0x2f0
> > > [  582.081036]  ? rcu_gp_is_expedited+0xa0/0xa0
> > > [  582.081507]  irq_enter+0xf/0x80
> > > [  582.081914]  smp_apic_timer_interrupt+0x1b/0x2d0
> > > [  582.082480]  apic_timer_interrupt+0xf/0x20
> > > [  582.082984]  </IRQ>
> > > [  582.083219] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
> > > [  582.087816] Code: e8 35 0b 20 00 48 8b 14 24 e9 fe fe ff ff 48 89
> > > df e8 24 0b 20 00 e9 d9 fe ff ff 4c 89 e7 e8 17 0b 20 00 e9 ab fe ff
> > > ff 90 90 <65> 48 8b 04 25 40 dd 01 00 65 8b 15 70 03 8f 63 81 e2 00 01
> > > 1f 00
> > > [  582.090289] RSP: 0018:ffff8800651bf9e0 EFLAGS: 00000206 ORIG_RAX:
> > > ffffffffffffff13
> > > [  582.091238] RAX: 0000000000000000 RBX: ffffffff9eed12a5 RCX: ffffffff9c6ca1b6
> > > [  582.092873] RDX: 0000000000000005 RSI: ffffffff9ee31d71 RDI: ffffffff9eed12a4
> > > [  582.093934] RBP: 0000000000000078 R08: ffffed000d38dfb2 R09: ffffed000d38dfb1
> > > [  582.095102] R10: 000000007350a3ba R11: ffff880069c6fd8f R12: ffff8800651bfa6e
> > > [  582.096444] R13: 0000000000000001 R14: dffffc0000000000 R15: 000000000000006a
> > > [  582.097414]  ? kallsyms_expand_symbol.constprop.11+0x176/0x250
> > > [  582.098518]  kallsyms_expand_symbol.constprop.11+0x12e/0x250
> > > [  582.099707]  kallsyms_lookup_name+0xbe/0x1d0
> > > [  582.100369]  ? kallsyms_on_each_symbol+0x210/0x210
> > > [  582.101436]  ? snprintf+0xbd/0xf0
> > > [  582.102029]  ? vsprintf+0x30/0x30
> > > [  582.102805]  ? kasan_kmalloc+0xa9/0xd0
> > > [  582.103489]  ? alloc_trace_kprobe+0x6c0/0x930
> > > [  582.104073]  kprobe_on_func_entry+0x57/0xb0
> >
> > I'm curious to what kretprobe was used.
> >
> > -- Steve
> >
> > > [  582.105421]  register_kretprobe+0x89/0xc10
> > > [  582.105930]  ? set_print_fmt+0x32/0xa0
> > > [  582.106376]  __register_trace_kprobe.part.10+0x14e/0x2e0
> > > [  582.106980]  create_local_trace_kprobe+0x29c/0x3f0
> > > [  582.107487]  perf_kprobe_init+0x15f/0x210
> > > [  582.107912]  perf_kprobe_event_init+0xc4/0x140
> > > [  582.108377]  perf_try_init_event+0xcb/0x290
> > > [  582.108817]  perf_event_alloc+0x1476/0x2020
> > > [  582.109264]  ? find_get_context.isra.106+0x690/0x690
> > > [  582.109922]  ? __alloc_fd+0x1a3/0x4e0
> > > [  582.120002]  __do_sys_perf_event_open+0x222/0x1f40
> > > [  582.123049]  ? avc_has_perm_noaudit+0x340/0x340
> > > [  582.131226]  ? perf_event_set_output+0x5f0/0x5f0
> > > [  582.134395]  ? handle_mm_fault+0x103/0x350
> > > [  582.138102]  ? ksys_ioctl+0x61/0x90
> > > [  582.140234]  do_syscall_64+0x9a/0x2c0
> > > [  582.142674]  ? prepare_exit_to_usermode+0xbc/0x150
> > > [  582.146856]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [  582.151127] RIP: 0033:0x446159
> > > [  582.152816] Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00
> > > 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> > > 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 08 fc ff c3 66 2e 0f 1f 84 00 00
> > > 00 00
> > > [  582.167257] RSP: 002b:00007fffc2b023d8 EFLAGS: 00000246 ORIG_RAX:
> > > 000000000000012a
> > > [  582.171375] RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000446159
> > > [  582.175760] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000020000180
> > > [  582.176487] RBP: 00007fffc2b025b0 R08: 0000000000000000 R09: 0000000000000000
> > > [  582.177189] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000406e40
> > > [  582.177898] R13: 0000000000406ed0 R14: 0000000000000000 R15: 0000000000000000
> > > [  583.353322] Shutting down cpus with NMI
> > > [  583.354285] Kernel Offset: 0x1b400000 from 0xffffffff81000000
> > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > [  583.356743] Rebooting in 86400 seconds..
> > >
> > >
> > > This bug could be easily reproduced by running the PoC(generated by
> > > syzkaller, and transformed to C Source code).
> > >
> > > For any further information, please feel free to contact us at
> > > wisedd@gmail.com. We would be more than happy to provide other
> > > information of this problem.
> >
> 

