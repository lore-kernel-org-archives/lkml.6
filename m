Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeDENo0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:44:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52896 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeDENoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:44:24 -0400
X-Google-Smtp-Source: AIpwx4+0YH8WNTw0mk9gxu/rzq1lqdNUNMp5O1jle30LpQhrugKwP9wzyA/8Ylm/EcWqfORs9CRySe/DLBtu4uBNG2M=
MIME-Version: 1.0
In-Reply-To: <CAFd4ddyMvoWObq1728aE8r8MrQNEKsEuxGV+DJMhGH+8EtDaZQ@mail.gmail.com>
References: <20180404223251.28449-1-eric@anholt.net> <CAKMK7uGhm_ixQN3-WWmWK-mrdWRAfPZMuD-=fBEQxbtrMkdVFg@mail.gmail.com>
 <CADnq5_PdM5MhXMdqnfbQqVgbRT=nKS_1hTvSfLBkp_1sPcErWw@mail.gmail.com>
 <CAKMK7uGF81MDaCwxw+UKUUUGCLRqVzDdDQpMsJr2BC=4b7_5gA@mail.gmail.com> <CAFd4ddyMvoWObq1728aE8r8MrQNEKsEuxGV+DJMhGH+8EtDaZQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Apr 2018 09:44:22 -0400
Message-ID: <CADnq5_NPs8Oq3AGvVuNHg0KuD7B-8FzSA8SJ+AYfdEyrGFJGTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: Extend the documentation.
To: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 9:41 AM, Nayan Deshmukh
<nayan26deshmukh@gmail.com> wrote:
> On Thu, Apr 5, 2018 at 6:59 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Thu, Apr 5, 2018 at 3:27 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
>>> On Thu, Apr 5, 2018 at 2:16 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>>> On Thu, Apr 5, 2018 at 12:32 AM, Eric Anholt <eric@anholt.net> wrote:
>>>>> These comments answer all the questions I had for myself when
>>>>> implementing a driver using the GPU scheduler.
>>>>>
>>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>>
>>>> Pulling all these comments into the generated kerneldoc would be
>>>> awesome, maybe as a new "GPU Scheduler" chapter at the end of
>>>> drm-mm.rst? Would mean a bit of busywork to convert the existing raw
>>>> comments into proper kerneldoc. Also has the benefit that 0day will
>>>> complain when you forget to update the comment when editing the
>>>> function prototype - kerneldoc which isn't included anywhere in .rst
>>>> won't be checked automatically.
>>>
>>> I was actually planning to do this myself, but Nayan wanted to do this
>>> a prep work for his proposed GSoC project so I was going to see how
>>> far he got first.
>
> It is still on my TODO list. Just got a bit busy with my coursework. I
> will try to look at it during the weekend.

No worries.  Take your time.

>>
>> Awesome. I'm also happy to help out with any kerneldoc questions and
>> best practices. Technically ofc no clue about the scheduler :-)
>>
> I was thinking of adding a different rst for scheduler altogther. Will
> it be better to add it in drm-mm.rst itself?

I had been planning to add a separate file too since it's a separate
entity.  Do whatever you think works best.

Alex

>
>> Cheers, Daniel
>>> Alex
>>>
>>>> -Daniel
>>>>
>>>>> ---
>>>>>  include/drm/gpu_scheduler.h | 46 +++++++++++++++++++++++++++++++++----
>>>>>  1 file changed, 42 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>>>>> index dfd54fb94e10..c053a32341bf 100644
>>>>> --- a/include/drm/gpu_scheduler.h
>>>>> +++ b/include/drm/gpu_scheduler.h
>>>>> @@ -43,10 +43,12 @@ enum drm_sched_priority {
>>>>>  };
>>>>>
>>>>>  /**
>>>>> - * A scheduler entity is a wrapper around a job queue or a group
>>>>> - * of other entities. Entities take turns emitting jobs from their
>>>>> - * job queues to corresponding hardware ring based on scheduling
>>>>> - * policy.
>>>>> + * drm_sched_entity - A wrapper around a job queue (typically attached
>>>>> + * to the DRM file_priv).
>>>>> + *
>>>>> + * Entities will emit jobs in order to their corresponding hardware
>>>>> + * ring, and the scheduler will alternate between entities based on
>>>>> + * scheduling policy.
>>>>>  */
>>>>>  struct drm_sched_entity {
>>>>>         struct list_head                list;
>>>>> @@ -78,7 +80,18 @@ struct drm_sched_rq {
>>>>>
>>>>>  struct drm_sched_fence {
>>>>>         struct dma_fence                scheduled;
>>>>> +
>>>>> +       /* This fence is what will be signaled by the scheduler when
>>>>> +        * the job is completed.
>>>>> +        *
>>>>> +        * When setting up an out fence for the job, you should use
>>>>> +        * this, since it's available immediately upon
>>>>> +        * drm_sched_job_init(), and the fence returned by the driver
>>>>> +        * from run_job() won't be created until the dependencies have
>>>>> +        * resolved.
>>>>> +        */
>>>>>         struct dma_fence                finished;
>>>>> +
>>>>>         struct dma_fence_cb             cb;
>>>>>         struct dma_fence                *parent;
>>>>>         struct drm_gpu_scheduler        *sched;
>>>>> @@ -88,6 +101,13 @@ struct drm_sched_fence {
>>>>>
>>>>>  struct drm_sched_fence *to_drm_sched_fence(struct dma_fence *f);
>>>>>
>>>>> +/**
>>>>> + * drm_sched_job - A job to be run by an entity.
>>>>> + *
>>>>> + * A job is created by the driver using drm_sched_job_init(), and
>>>>> + * should call drm_sched_entity_push_job() once it wants the scheduler
>>>>> + * to schedule the job.
>>>>> + */
>>>>>  struct drm_sched_job {
>>>>>         struct spsc_node                queue_node;
>>>>>         struct drm_gpu_scheduler        *sched;
>>>>> @@ -112,10 +132,28 @@ static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
>>>>>   * these functions should be implemented in driver side
>>>>>  */
>>>>>  struct drm_sched_backend_ops {
>>>>> +       /* Called when the scheduler is considering scheduling this
>>>>> +        * job next, to get another struct dma_fence for this job to
>>>>> +        * block on.  Once it returns NULL, run_job() may be called.
>>>>> +        */
>>>>>         struct dma_fence *(*dependency)(struct drm_sched_job *sched_job,
>>>>>                                         struct drm_sched_entity *s_entity);
>>>>> +
>>>>> +       /* Called to execute the job once all of the dependencies have
>>>>> +        * been resolved.  This may be called multiple times, if
>>>>> +        * timedout_job() has happened and drm_sched_job_recovery()
>>>>> +        * decides to try it again.
>>>>> +        */
>>>>>         struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
>>>>> +
>>>>> +       /* Called when a job has taken too long to execute, to trigger
>>>>> +        * GPU recovery.
>>>>> +        */
>>>>>         void (*timedout_job)(struct drm_sched_job *sched_job);
>>>>> +
>>>>> +       /* Called once the job's finished fence has been signaled and
>>>>> +        * it's time to clean it up.
>>>>> +        */
>>>>>         void (*free_job)(struct drm_sched_job *sched_job);
>>>>>  };
>>>>>
>>>>> --
>>>>> 2.17.0
>>>>>
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>
>>>>
>>>>
>>>> --
>>>> Daniel Vetter
>>>> Software Engineer, Intel Corporation
>>>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
