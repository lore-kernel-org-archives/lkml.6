Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED17C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AA520881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AA520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIMTjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:39:23 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35908 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeIMTjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:39:23 -0400
Received: by mail-yb1-f194.google.com with SMTP id d34-v6so3342424yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kbu2IFDMEsw+eWerzoXRdoCznU9d/1deqiHIyhgd71Q=;
        b=Xt1DF9n+TuiCrd9CfP6nTAFb/ZSrX/t/aOgzKc7xvu2EDJyW7NAbPz2XbQKFKyHj36
         pTCHrlvVebjCUfV6dAHGr0IyzK0zZ12SAWKvcNltgoAWIqggkoYOX//ZB9AAXLYblKAL
         VetbPX7ZF0Z2UrfHJNNqrnkdAD44+TziaeT2d6+d6gMdZuowN/xFeRu5HylWiCGWEaRs
         ItzqymAmyjbQ0unCLgqKjvuhwHqnigcuXFDsYlGsKq1sClIij2eom/C/ms5sb+bERyrx
         fVJ/7bXPxkyreM06Z31dixHxTLbRL1LP/w0bUiIUlMYYERcaqwSN0lO4jb70zXr0jMRG
         cDfw==
X-Gm-Message-State: APzg51DAjMTqIDL0upgQDfxtj72oPrCvbApws2OgC8qVPDQuFxwU6jwg
        L+W8kPRmQMZ1UpVqTO++zbEn+e7JPpE=
X-Google-Smtp-Source: ANB0VdZdOdN7QW5nwYgWW7HzBvDP+uTY+c2MrWMa/jBPVVx+xYTsuodA/BmUn4Gddq4uZom3OelEvA==
X-Received: by 2002:a25:1a85:: with SMTP id a127-v6mr3630683yba.507.1536848975626;
        Thu, 13 Sep 2018 07:29:35 -0700 (PDT)
Received: from laptop.jcline.org (075-177-179-204.res.spectrum.com. [75.177.179.204])
        by smtp.gmail.com with ESMTPSA id h10-v6sm1675046ywa.35.2018.09.13.07.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 07:29:34 -0700 (PDT)
Subject: Re: [PATCH] cpufreq: governor: Protect cpufreq governor_data
To:     Henry Willard <henry.willard@oracle.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
From:   Jeremy Cline <jcline@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jcline@redhat.com; keydata=
 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
 X/87hZ4pdW/aOXUAgQ==
Message-ID: <8c3a0da6-5a2b-d20a-fd9f-72c01a65d7b8@redhat.com>
Date:   Thu, 13 Sep 2018 10:29:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On 08/14/2018 08:01 PM, Henry Willard wrote:
> If cppc_cpufreq.ko is deleted at the same time that tuned-adm is,
> changing profiles, there is a small chance that a race can occur
> between cpufreq_dbs_governor_exit() and cpufreq_dbs_governor_limits()
> resulting in a system failure when the latter tries to use
> policy->governor_data that has been freed by the former.
> 
> This patch uses gov_dbs_data_mutex to synchronize access.
> 
> Signed-off-by: Henry Willard <henry.willard@oracle.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 1d50e97d49f1..43416ee55849 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -555,12 +555,20 @@ void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy)
>  
>  void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>  {
> -	struct policy_dbs_info *policy_dbs = policy->governor_data;
> +	struct policy_dbs_info *policy_dbs;
> +
> +	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit */
> +	mutex_lock(&gov_dbs_data_mutex);
> +	policy_dbs = policy->governor_data;
> +	if (!policy_dbs)
> +		goto out;
>  
>  	mutex_lock(&policy_dbs->update_mutex);
>  	cpufreq_policy_apply_limits(policy);
>  	gov_update_sample_delay(policy_dbs, 0);
>  
>  	mutex_unlock(&policy_dbs->update_mutex);
> +out:
> +	mutex_unlock(&gov_dbs_data_mutex);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);
> 

Fedora has gotten a report[0] of possible circular locking which looks
like might have been introduced by this patch.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1627950

User-provided log (attached to the bug report) is:

 ======================================================
 WARNING: possible circular locking dependency detected
 4.19.0-0.rc2.git3.1.fc30.x86_64 #1 Not tainted
 ------------------------------------------------------
 kworker/0:3/101 is trying to acquire lock:
 000000003b2babfd ((work_completion)(&wfc.work)){+.+.}, at:
__flush_work+0x28c/0x320

 but task is already holding lock:
 0000000084d461de (&policy_dbs->update_mutex){+.+.}, at:
dbs_work_handler+0x2b/0x70

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #5 (&policy_dbs->update_mutex){+.+.}:
        cpufreq_dbs_governor_limits+0x31/0x80
        cpufreq_start_governor+0x65/0xa0
        cpufreq_set_policy+0x2b7/0x330
        cpufreq_init_policy+0x76/0xe0
        cpufreq_online+0x535/0x6b0
        cpufreq_add_dev+0x6b/0x80
        subsys_interface_register+0xf3/0x150
        cpufreq_register_driver+0x11e/0x230
        powernowk8_init+0x134/0x18f [powernow_k8]
        do_one_initcall+0x5d/0x2be
        do_init_module+0x5a/0x210
        load_module+0x2134/0x2400
        __do_sys_init_module+0x150/0x1a0
        do_syscall_64+0x60/0x1f0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #4 (gov_dbs_data_mutex){+.+.}:
        cpufreq_dbs_governor_init+0x117/0x240
        cpufreq_init_governor+0x62/0xe0
        cpufreq_set_policy+0x1ca/0x330
        cpufreq_init_policy+0x76/0xe0
        cpufreq_online+0x535/0x6b0
        cpufreq_add_dev+0x6b/0x80
        subsys_interface_register+0xf3/0x150
        cpufreq_register_driver+0x11e/0x230
        powernowk8_init+0x134/0x18f [powernow_k8]
        do_one_initcall+0x5d/0x2be
        do_init_module+0x5a/0x210
        load_module+0x2134/0x2400
        __do_sys_init_module+0x150/0x1a0
        do_syscall_64+0x60/0x1f0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #3 (&policy->rwsem){+.+.}:
        cpufreq_policy_free+0xba/0x140
        cpufreq_online+0xec/0x6b0
        cpufreq_add_dev+0x6b/0x80
        subsys_interface_register+0xf3/0x150
        cpufreq_register_driver+0x11e/0x230
        0xffffffffc05fc25a
        do_one_initcall+0x5d/0x2be
        do_init_module+0x5a/0x210
        load_module+0x2134/0x2400
        __do_sys_init_module+0x150/0x1a0
        do_syscall_64+0x60/0x1f0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #2 (subsys mutex#7){+.+.}:
        subsys_interface_register+0x73/0x150
        cpufreq_register_driver+0x11e/0x230
        0xffffffffc05fc25a
        do_one_initcall+0x5d/0x2be
        do_init_module+0x5a/0x210
        load_module+0x2134/0x2400
        __do_sys_init_module+0x150/0x1a0
        do_syscall_64+0x60/0x1f0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #1 (cpu_hotplug_lock.rw_sem){.+.+}:
        apply_workqueue_attrs+0x12/0x50
        __alloc_workqueue_key+0x303/0x480
        scsi_host_alloc+0x3be/0x450
        ata_scsi_add_hosts+0xc9/0x150
        ata_host_register+0x120/0x1d0
        ata_host_activate+0xc1/0x140
        svia_init_one+0x6c7/0x7f6 [sata_via]
        local_pci_probe+0x41/0x90
        work_for_cpu_fn+0x16/0x20
        process_one_work+0x27d/0x5c0
        worker_thread+0x3c/0x390
        kthread+0x120/0x140
        ret_from_fork+0x3a/0x50

 -> #0 ((work_completion)(&wfc.work)){+.+.}:
        __flush_work+0x2ac/0x320
        work_on_cpu+0x9b/0xd0
        powernowk8_target+0x33/0x50 [powernow_k8]
        __cpufreq_driver_target+0x2d2/0x580
        od_dbs_update+0xbb/0x190
        dbs_work_handler+0x3a/0x70
        process_one_work+0x27d/0x5c0
        worker_thread+0x3c/0x390
        kthread+0x120/0x140
        ret_from_fork+0x3a/0x50

 other info that might help us debug this:
 Chain exists of:
   (work_completion)(&wfc.work) --> gov_dbs_data_mutex -->
&policy_dbs->update_mutex
  Possible unsafe locking scenario:
        CPU0                    CPU1
        ----                    ----
   lock(&policy_dbs->update_mutex);
                                lock(gov_dbs_data_mutex);
                                lock(&policy_dbs->update_mutex);
   lock((work_completion)(&wfc.work));

  *** DEADLOCK ***
 3 locks held by kworker/0:3/101:
  #0: 000000009eaebf60 ((wq_completion)"events"){+.+.}, at:
process_one_work+0x1f3/0x5c0
  #1: 00000000ac2fb241 ((work_completion)(&policy_dbs->work)){+.+.}, at:
process_one_work+0x1f3/0x5c0
  #2: 0000000084d461de (&policy_dbs->update_mutex){+.+.}, at:
dbs_work_handler+0x2b/0x70

 stack backtrace:
 CPU: 0 PID: 101 Comm: kworker/0:3 Not tainted
4.19.0-0.rc2.git3.1.fc30.x86_64 #1
 Hardware name: Acer Aspire T135/K8VM800MAE, BIOS R01-A3 06/27/2005
 Workqueue: events dbs_work_handler
 Call Trace:
  dump_stack+0x85/0xc0
  print_circular_bug.isra.36.cold.55+0x15c/0x195
  __lock_acquire+0x139a/0x16c0
  ? __lock_acquire+0x112b/0x16c0
  lock_acquire+0x9e/0x180
  ? __flush_work+0x28c/0x320
  __flush_work+0x2ac/0x320
  ? __flush_work+0x28c/0x320
  ? native_sched_clock+0x3e/0xa0
  ? mark_held_locks+0x57/0x80
  ? queue_work_on+0x5d/0x90
  ? lockdep_hardirqs_on+0xed/0x180
  work_on_cpu+0x9b/0xd0
  ? work_is_static_object+0x10/0x10
  ? write_new_fid+0xe0/0xe0 [powernow_k8]
  powernowk8_target+0x33/0x50 [powernow_k8]
  __cpufreq_driver_target+0x2d2/0x580
  od_dbs_update+0xbb/0x190
  dbs_work_handler+0x3a/0x70
  process_one_work+0x27d/0x5c0
  worker_thread+0x3c/0x390
  ? process_one_work+0x5c0/0x5c0
  kthread+0x120/0x140
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x3a/0x50
 clocksource: timekeeping watchdog on CPU0: Marking clocksource 'tsc' as
unstable because the skew is too large:
 clocksource:                       'acpi_pm' wd_now: 61cb7c wd_last:
5e7744 mask: ffffff
 clocksource:                       'tsc' cs_now: 2b9d83ad41 cs_last:
299dc3ef91 mask: ffffffffffffffff
 tsc: Marking TSC unstable due to clocksource watchdog
 TSC found unstable after boot, most likely due to broken BIOS. Use
'tsc=unstable'.
 sched_clock: Marking unstable (55064379271, 12383389)<-(55179340298,
-102501740)
 clocksource: Switched to clocksource acpi_pm


Cheers,
Jeremy
