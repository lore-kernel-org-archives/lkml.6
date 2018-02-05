Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeBEUtA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:49:00 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41089 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeBEUsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:48:53 -0500
X-Google-Smtp-Source: AH8x226oebPPczl5TsmMBCXZPLeR0b8myJmONGQ4Tyiv0JJDBQ90HLHhFoAH5gA4kE5iA2F/z3gYyw==
Date: Mon, 5 Feb 2018 13:48:49 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Luca Abeni <luca.abeni@santannapisa.it>
Cc: peterz@infradead.org, lizefan@huawei.com, mingo@redhat.com,
        rostedt@goodmis.org, claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/7] sched/deadline: fix cpusets bandwidth accounting
Message-ID: <20180205204849.GA2621@xps15>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
 <20180202141750.5652d2b7@luca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202141750.5652d2b7@luca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 02:17:50PM +0100, Luca Abeni wrote:
> Hi Mathieu,
> 
> On Thu,  1 Feb 2018 09:51:02 -0700
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> 
> > This is the follow-up patchset to [1] that attempt to fix a problem
> > reported by Steve Rostedt [2] where DL bandwidth accounting is not
> > recomputed after CPUset and CPU hotplug operations.  When CPU hotplug and
> > some CUPset manipulation take place root domains are destroyed and new ones
> > created, loosing at the same time DL accounting information pertaining to
> > utilisation.  Please see [1] for a full description of the approach.
> 
> I do not know the cgroup / cpuset code too much, so I have no useful
> comments on your patches... But I think this patchset is a nice
> improvemnt respect to the current situation.
> 
> [...]
> > A notable addition is patch 7/7 - it addresses a problem seen when hot
> > plugging out a CPU where a DL task is running (see changelog for full
> > details).  The issue is unrelated to this patchset and will manifest
> > itself on a mainline kernel.
> 
> I think I introduced this bug with my reclaiming patches, so I am
> interested.
> When a cpu is hot-plugged out, which code in the kernel is responsible
> for migrating the tasks that are executing on such CPU?

sched_cpu_deactivate()
    cpuset_cpu_inactive()
        cpuset_update_active_cpus()
            cpuset_hotplug_workfn()
                hotplug_update_tasks_legacy()
                    hotplug_update_tasks()
                        set_cpus_allowed_ptr()
                            __set_cpus_allowed_ptr()


> I was sure I
> was handling all the relevant codepaths, but this bug clearly shows
> that I was wrong.

I remember reviewing your patchset and I too thought you had tackled all the
cases.  In function __set_cpus_allowed_ptr() you'll notice two cases are
handled, i.e the task is running or suspended.  I suspect the former to be the
culprit but haven't investigated fully.

Regards,
Mathieu
                                


> 
> 
> 			Thanks,
> 				Luca
