Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeD3MIs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 08:08:48 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39552 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeD3MIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 08:08:47 -0400
X-Google-Smtp-Source: AB8JxZqo+nk8py8iEHq5NsLHz+1yt5yJgP0E+3A+ZWdYOfLBnuS+MS91fUuHf6xmObAPyYDhebmEAQ==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: David.Panariti@amd.com, Oleg Nesterov <oleg@redhat.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
Date: Mon, 30 Apr 2018 14:08:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <874ljyu98e.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

sorry for the late response, was on vacation last week.

Am 26.04.2018 um 02:01 schrieb Eric W. Biederman:
> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>
>> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>>> On 04/25, Andrey Grodzovsky wrote:
>>>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>>>> able to exit immediately
>>>> and not wait for GPU jobs completion when the reason for reaching this code
>>>> is because of KILL
>>>> signal to the user process who opened the device file.
>>> Can you hook f_op->flush method?

THANKS! That sounds like a really good idea to me and we haven't 
investigated into that direction yet.

>> But this one is called for each task releasing a reference to the the file, so
>> not sure I see how this solves the problem.
> The big question is why do you need to wait during the final closing a
> file?

As always it's because of historical reasons. Initially user space 
pushed commands directly to a hardware queue and when a processes 
finished we didn't need to wait for anything.

Then the GPU scheduler was introduced which delayed pushing the jobs to 
the hardware queue to a later point in time.

This wait was then added to maintain backward compability and not break 
userspace (but see below).

> The wait can be terminated so the wait does not appear to be simply a
> matter of correctness.

Well when the process is killed we don't care about correctness any 
more, we just want to get rid of it as quickly as possible (OOM 
situation etc...).

But it is perfectly possible that a process submits some render commands 
and then calls exit() or terminates because of a SIGTERM, SIGINT etc.. 
In this case we need to wait here to make sure that all rendering is 
pushed to the hardware because the scheduler might need 
resources/settings from the file descriptor.

For example if you just remove that wait you could close firefox and get 
garbage on the screen for a millisecond because the remaining rendering 
commands where not executed.

So what we essentially need is to distinct between a SIGKILL (which 
means stop processing as soon as possible) and any other reason because 
then we don't want to annoy the user with garbage on the screen (even if 
it's just for a few milliseconds).

Constructive ideas how to handle this would be very welcome, cause I 
completely agree that what we have at the moment by checking PF_SIGNAL 
is just a very very hacky workaround.

Thanks,
Christian.

>
> Eric
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
