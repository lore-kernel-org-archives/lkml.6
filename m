Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HTML_ATTACH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACE5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABB1208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABB1208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeH1JRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:17:13 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59515 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbeH1JRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:17:12 -0400
Received: from [192.168.0.5] (ip5f5bd167.dynamic.kabel-deutschland.de [95.91.209.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6F1B62012BACBD;
        Tue, 28 Aug 2018 07:27:13 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: How to debug outliers in `wb_wait_for_completion()` in `ksys_sync()`?
To:     linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <f3ca4798-0936-6d98-f1de-ce4903d6740b@molgen.mpg.de>
Date:   Tue, 28 Aug 2018 07:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A78CD9780485E46872063A3F"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A78CD9780485E46872063A3F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Using `sleepgraph.py` [1][2] to profile the suspend to RAM (STR) times, 
shows that `ksys_enter` takes a noticeable amount of time.

13 ms on a TUXEDO Book BU1406 with the NVMe device *SAMSUNG 
MZVKW512HMJP-00000*, which is quite good, and over a 60 ms on ASRock 
E350M1 with an SSD SanDisk device.

Adding `devicefilter: ksys_sync` to `config/suspend-callgraph.cfg`, and 
running `sudo ./sleepgraph.py -config config/suspend-callgraph.cfg`, the 
attached HTML output shows, that `iterate_supers` takes 6 to 7 ms twice.

•   `iterate_supers` (6.316 ms @ 388.944557)
•   `iterate_supers` (0.201 ms @ 388.950873)
•   `iterate_supers` (7.421 ms @ 388.951074)

Normally, `sync_inodes_one_sb` only takes microseconds, but once in both 
cases it takes several milliseconds.

•   sync_inodes_one_sb (0.001 ms @ 388.944660)
•   sync_inodes_one_sb (5.978 ms @ 388.944665)
•   sync_inodes_one_sb (0.001 ms @ 388.950645)

Please find an excerpt from the call graph from ftrace below, and note 
the time increase between 388.944751 and 388.950636.

>   388.944700 |   0) sleepgr-11355  |               |          wb_wait_for_completion() {
>   388.944701 |   0) sleepgr-11355  |               |            _cond_resched() {
>   388.944701 |   0) sleepgr-11355  |   0.064 us    |              rcu_all_qs();
>   388.944702 |   0) sleepgr-11355  |   0.664 us    |            } /* _cond_resched */
>   388.944702 |   0) sleepgr-11355  |   0.067 us    |            init_wait_entry();
>   388.944703 |   0) sleepgr-11355  |               |            prepare_to_wait_event() {
>   388.944703 |   0) sleepgr-11355  |   0.080 us    |              _raw_spin_lock_irqsave();
>   388.944704 |   0) sleepgr-11355  |   0.073 us    |              _raw_spin_unlock_irqrestore();
>   388.944704 |   0) sleepgr-11355  |   1.388 us    |            } /* prepare_to_wait_event */
>   388.944705 |   0) sleepgr-11355  |               |            schedule() {
>   388.944705 |   0) sleepgr-11355  |   0.085 us    |              rcu_note_context_switch();
>   388.944706 |   0) sleepgr-11355  |   0.064 us    |              _raw_spin_lock();
>   388.944707 |   0) sleepgr-11355  |   0.093 us    |              update_rq_clock();
>   388.944708 |   0) sleepgr-11355  |               |              deactivate_task() {
>   388.944708 |   0) sleepgr-11355  |               |                dequeue_task_fair() {
>   388.944708 |   0) sleepgr-11355  |               |                  dequeue_entity() {
>   388.944709 |   0) sleepgr-11355  |               |                    update_curr() {
>   388.944709 |   0) sleepgr-11355  |   0.095 us    |                      update_min_vruntime();
>   388.944710 |   0) sleepgr-11355  |   0.126 us    |                      cpuacct_charge();
>   388.944710 |   0) sleepgr-11355  |               |                      __cgroup_account_cputime() {
>   388.944711 |   0) sleepgr-11355  |   0.055 us    |                        cgroup_rstat_updated();
>   388.944711 |   0) sleepgr-11355  |   0.675 us    |                      } /* __cgroup_account_cputime */
>   388.944712 |   0) sleepgr-11355  |   2.779 us    |                    } /* update_curr */
>   388.944712 |   0) sleepgr-11355  |   0.121 us    |                    __update_load_avg_se();
>   388.944713 |   0) sleepgr-11355  |   0.118 us    |                    __update_load_avg_cfs_rq();
>   388.944713 |   0) sleepgr-11355  |   0.056 us    |                    clear_buddies();
>   388.944714 |   0) sleepgr-11355  |   0.066 us    |                    account_entity_dequeue();
>   388.944714 |   0) sleepgr-11355  |   0.050 us    |                    update_cfs_group();
>   388.944715 |   0) sleepgr-11355  |   6.127 us    |                  } /* dequeue_entity */
>   388.944715 |   0) sleepgr-11355  |               |                  dequeue_entity() {
>   388.944715 |   0) sleepgr-11355  |               |                    update_curr() {
>   388.944716 |   0) sleepgr-11355  |   0.097 us    |                      __calc_delta();
>   388.944716 |   0) sleepgr-11355  |   0.071 us    |                      update_min_vruntime();
>   388.944717 |   0) sleepgr-11355  |   1.473 us    |                    } /* update_curr */
>   388.944717 |   0) sleepgr-11355  |   0.142 us    |                    __update_load_avg_se();
>   388.944718 |   0) sleepgr-11355  |   0.100 us    |                    __update_load_avg_cfs_rq();
>   388.944719 |   0) sleepgr-11355  |   0.069 us    |                    clear_buddies();
>   388.944719 |   0) sleepgr-11355  |   0.098 us    |                    account_entity_dequeue();
>   388.944720 |   0) sleepgr-11355  |               |                    update_cfs_group() {
>   388.944720 |   0) sleepgr-11355  |   0.110 us    |                      reweight_entity();
>   388.944721 |   0) sleepgr-11355  |   0.847 us    |                    } /* update_cfs_group */
>   388.944721 |   0) sleepgr-11355  |   6.197 us    |                  } /* dequeue_entity */
>   388.944722 |   0) sleepgr-11355  |   0.053 us    |                  hrtick_update();
>   388.944722 |   0) sleepgr-11355  |   14.141 us   |                } /* dequeue_task_fair */
>   388.944723 |   0) sleepgr-11355  |   14.827 us   |              } /* deactivate_task */
>   388.944723 |   0) sleepgr-11355  |               |              pick_next_task_fair() {
>   388.944723 |   0) sleepgr-11355  |               |                update_blocked_averages() {
>   388.944724 |   0) sleepgr-11355  |   0.070 us    |                  _raw_spin_lock_irqsave();
>   388.944724 |   0) sleepgr-11355  |   0.090 us    |                  update_rq_clock();
>   388.944725 |   0) sleepgr-11355  |   0.120 us    |                  __update_load_avg_cfs_rq();
>   388.944726 |   0) sleepgr-11355  |   0.162 us    |                  __update_load_avg_se();
>   388.944727 |   0) sleepgr-11355  |   0.090 us    |                  __update_load_avg_cfs_rq();
>   388.944727 |   0) sleepgr-11355  |   0.081 us    |                  __update_load_avg_cfs_rq();
>   388.944728 |   0) sleepgr-11355  |               |                  update_rt_rq_load_avg() {
>   388.944728 |   0) sleepgr-11355  |   0.063 us    |                    __accumulate_pelt_segments();
>   388.944729 |   0) sleepgr-11355  |   0.785 us    |                  } /* update_rt_rq_load_avg */
>   388.944729 |   0) sleepgr-11355  |               |                  update_dl_rq_load_avg() {
>   388.944730 |   0) sleepgr-11355  |   0.066 us    |                    __accumulate_pelt_segments();
>   388.944730 |   0) sleepgr-11355  |   0.763 us    |                  } /* update_dl_rq_load_avg */
>   388.944731 |   0) sleepgr-11355  |   0.061 us    |                  _raw_spin_unlock_irqrestore();
>   388.944731 |   0) sleepgr-11355  |   7.452 us    |                } /* update_blocked_averages */
>   388.944731 |   0) sleepgr-11355  |               |                load_balance() {
>   388.944732 |   0) sleepgr-11355  |               |                  find_busiest_group() {
>   388.944732 |   0) sleepgr-11355  |   0.100 us    |                    update_nohz_stats();
>   388.944733 |   0) sleepgr-11355  |   0.057 us    |                    idle_cpu();
>   388.944734 |   0) sleepgr-11355  |   0.098 us    |                    update_nohz_stats();
>   388.944734 |   0) sleepgr-11355  |   2.407 us    |                  } /* find_busiest_group */
>   388.944735 |   0) sleepgr-11355  |   3.120 us    |                } /* load_balance */
>   388.944735 |   0) sleepgr-11355  |   0.065 us    |                __msecs_to_jiffies();
>   388.944736 |   0) sleepgr-11355  |               |                load_balance() {
>   388.944736 |   0) sleepgr-11355  |               |                  find_busiest_group() {
>   388.944736 |   0) sleepgr-11355  |   0.087 us    |                    update_nohz_stats();
>   388.944737 |   0) sleepgr-11355  |   0.063 us    |                    idle_cpu();
>   388.944738 |   0) sleepgr-11355  |   0.086 us    |                    update_nohz_stats();
>   388.944739 |   0) sleepgr-11355  |   0.068 us    |                    update_nohz_stats();
>   388.944739 |   0) sleepgr-11355  |   0.098 us    |                    idle_cpu();
>   388.944740 |   0) sleepgr-11355  |   0.094 us    |                    update_nohz_stats();
>   388.944741 |   0) sleepgr-11355  |   0.065 us    |                    idle_cpu();
>   388.944741 |   0) sleepgr-11355  |   5.160 us    |                  } /* find_busiest_group */
>   388.944742 |   0) sleepgr-11355  |   5.831 us    |                } /* load_balance */
>   388.944742 |   0) sleepgr-11355  |   0.062 us    |                __msecs_to_jiffies();
>   388.944743 |   0) sleepgr-11355  |   0.065 us    |                _raw_spin_lock();
>   388.944743 |   0) sleepgr-11355  |   20.205 us   |              } /* pick_next_task_fair */
>   388.944744 |   0) sleepgr-11355  |               |              pick_next_task_idle() {
>   388.944744 |   0) sleepgr-11355  |               |                put_prev_task_fair() {
>   388.944745 |   0) sleepgr-11355  |               |                  put_prev_entity() {
>   388.944745 |   0) sleepgr-11355  |   0.064 us    |                    check_cfs_rq_runtime();
>   388.944746 |   0) sleepgr-11355  |   0.713 us    |                  } /* put_prev_entity */
>   388.944746 |   0) sleepgr-11355  |               |                  put_prev_entity() {
>   388.944746 |   0) sleepgr-11355  |   0.068 us    |                    check_cfs_rq_runtime();
>   388.944747 |   0) sleepgr-11355  |   0.691 us    |                  } /* put_prev_entity */
>   388.944747 |   0) sleepgr-11355  |   2.633 us    |                } /* put_prev_task_fair */
>   388.944748 |   0) sleepgr-11355  |   0.094 us    |                __update_idle_core();
>   388.944748 |   0) sleepgr-11355  |   3.899 us    |              } /* pick_next_task_idle */
>   388.944749 |   0) sleepgr-11355  |               |              enter_lazy_tlb() {
>   388.944749 |   0) sleepgr-11355  |               |                switch_mm() {
>   388.944749 |   0) sleepgr-11355  |               |                  switch_mm_irqs_off() {
>   388.944750 |   0) sleepgr-11355  |   0.244 us    |                    load_new_mm_cr3();
>   388.944751 |   0) sleepgr-11355  |   0.955 us    |                  } /* switch_mm_irqs_off */
>   388.944751 |   0) sleepgr-11355  |   1.472 us    |                } /* switch_mm */
>   388.944751 |   0) sleepgr-11355  |   2.023 us    |              } /* enter_lazy_tlb */
>   388.950636 |   0) sleepgr-11355  |   0.103 us    |              finish_task_switch();
>   388.950638 |   0) sleepgr-11355  |   5932.632 us |            } /* schedule */
>   388.950638 |   0) sleepgr-11355  |               |            prepare_to_wait_event() {
>   388.950638 |   0) sleepgr-11355  |   0.068 us    |              _raw_spin_lock_irqsave();
>   388.950638 |   0) sleepgr-11355  |   0.053 us    |              _raw_spin_unlock_irqrestore();
>   388.950639 |   0) sleepgr-11355  |   0.866 us    |            } /* prepare_to_wait_event */
>   388.950639 |   0) sleepgr-11355  |               |            finish_wait() {
>   388.950639 |   0) sleepgr-11355  |   0.046 us    |              _raw_spin_lock_irqsave();
>   388.950640 |   0) sleepgr-11355  |   0.052 us    |              _raw_spin_unlock_irqrestore();
>   388.950640 |   0) sleepgr-11355  |   0.788 us    |            } /* finish_wait */
>   388.950640 |   0) sleepgr-11355  |   5939.443 us |          } /* wb_wait_for_completion */

Can these outliers be avoided? As this is in `schedule`, is it related 
to the used scheduler? At least the Intel Skylake i7-7500U CPU @ 2.70GHz 
processor with four threads in the TUXEDO laptop should have enough 
performance.

No scheduler seems to be used for the NVMe device.

     $ more 
/sys/devices/pci0000:00/0000:00:1d.0/0000:04:00.0/nvme/nvme0/nvme0n1/queue/scheduler
     [none]


Kind regards,

Paul


[1]: https://01.org/suspendresume
[2]: https://github.com/01org/pm-graph

--------------A78CD9780485E46872063A3F
Content-Type: application/x-7z-compressed;
 name="helmuth-N24-25BU_mem.html.7z"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="helmuth-N24-25BU_mem.html.7z"

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
OtwVR1gH1SBpwrN28qnToVSN7mypUhm8/i29Ptm2ts29yZR6IgymfmhlktVKE+M57KUjIx3J
klm4nwQr5Vy05bRE2KfvLuBm81nGJkJFsrdpvNJL74M2RifqMkLMDenZwcQHzzOzorAXA8uQ
koLCa7KsE53BeSEio4QvGnvwMmSiPa/bDFurXYHJz4tFUk8KQ1Ndx0RITt+xW4+0H8nSu2H3
8sEsKgNysdOO7jVFn3FmlJIe0fPIjKmPVpDqOJ0qmcMATWBe8dVzusopK3JqC9OSlFoV9IYc
JGF0xQnpEau+TMpcytLQK9TqYFYnUCxb05kKZeeqffXmolgbOgnJShnHe1INqfnNC9yYDYJ+
lxAildF33t89yO3FVoXAZlwQ/zm+720vrBTNGcX0RkjYeBvYXEs8bmDKuSrooxewSRL94eqq
mkzunQuDdyEJg2f9S+oILOG40SQ/1PGcvdq6N0RuYbmVi4ZuCK5zLn+Yfo1hZG1CoWKqwRZL
+DZ5je9fKI9zdDGCYHhsDpU6lNPDuAl2j8gHFa8X0R1s8n/sQd6dh0+WZtZnfzO2tlCNi3Me
d2vtW2bsQR3asJaZAQQGAAEJwDBtAAcLAQABIwMBAQVdAAAGAAzFQ+8ACAoB6pI73QAABQEZ
AQARgIkAcwB1AHMAcABlAG4AZAAtAGgAZQBsAG0AdQB0AGgALQBOADIANAAtADIANQBCAFUA
LQAxADgAMAA4ADIAOAAtADAANgA0ADAAMAAwAC0AYwBnAC8AaABlAGwAbQB1AHQAaAAtAE4A
MgA0AC0AMgA1AEIAVQBfAG0AZQBtAC4AaAB0AG0AbAAAABkCAAAUCgEAAJaJUYk+1AEVBgEA
IICkgQAA
--------------A78CD9780485E46872063A3F--
