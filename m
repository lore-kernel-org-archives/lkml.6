Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeBESL7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:11:59 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38381 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeBESLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:11:51 -0500
X-Google-Smtp-Source: AH8x227loabYtBLmwEXprSfRBwdY7OYF7XbDB1ch06cX2LGjRQtowinmDDI8/vTa76fc810s20XqVwx/S3M98vxw4BU=
MIME-Version: 1.0
In-Reply-To: <20180202101951.GS19535@localhost.localdomain>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
 <1517503869-3179-2-git-send-email-mathieu.poirier@linaro.org> <20180202101951.GS19535@localhost.localdomain>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 5 Feb 2018 11:11:49 -0700
Message-ID: <CANLsYkyJb9F14SBSatLHCwThWaO0dcMSddsCB_kHHAeEdunEtw@mail.gmail.com>
Subject: Re: [PATCH V2 1/7] sched/topology: Adding function partition_sched_domains_locked()
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        "luca.abeni" <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 February 2018 at 03:19, Juri Lelli <juri.lelli@redhat.com> wrote:
> Hi Mathieu,
>
> On 01/02/18 09:51, Mathieu Poirier wrote:
>> Introducing function partition_sched_domains_locked() by taking
>> the mutex locking code out of the original function.  That way
>> the work done by partition_sched_domains_locked() can be reused
>> without dropping the mutex lock.
>>
>> This patch doesn't change the functionality provided by the
>> original code.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>
> [...]
>
>> +/*
>> + * Call with hotplug lock held
>
> Is this the one that we can actually check if it's locked with
>
> lockdep_assert_cpus_held()
>
> ?

Hi Juri,

You are correct - we could call lockdep_assert_cpus_held() but in my
opinion it would be in a separate patch and probably outside the scope
of this work.  The sole purpose of this patch is to get the
locking/unlocking operations of mutex sched_domains_mutex out of
function partition_sched_domains_locked().

Mathieu

>
>> + */
>> +void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>> +                          struct sched_domain_attr *dattr_new)
>> +{
>> +     mutex_lock(&sched_domains_mutex);
>> +     partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
>>       mutex_unlock(&sched_domains_mutex);
>>  }
>
> Best,
>
> - Juri
