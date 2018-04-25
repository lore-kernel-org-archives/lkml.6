Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbeDYNgn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:36:43 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40340 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbeDYNgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:36:42 -0400
X-Google-Smtp-Source: AB8JxZpAeXLikyWip8OK51yShS/qqvw2G6U0hOD/mJZW6MZIgzhnoKvvLLKCEkFJbHirjWBJGVuBiOqVejc2u/akAzM=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:5635:0:39d2:f87e:2033:9f6]
In-Reply-To: <20180425132228.GC7592@redhat.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net> <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com> <20180424214027.GG25142@phenom.ffwll.local>
 <20180425132228.GC7592@redhat.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 25 Apr 2018 15:36:40 +0200
X-Google-Sender-Auth: msQsoQ86FzeXydmHxlHbsdE4w-M
Message-ID: <CAKMK7uF7LumuFWw3Xezw+QYDEhz6pFrJueZqFvSnmmoynYqpgQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, David.Panariti@amd.com,
        Eric Biederman <ebiederm@xmission.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 3:22 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 04/24, Daniel Vetter wrote:
>>
>> wait_event_killabel doesn't check for fatal_signal_pending before calling
>> schedule, so definitely has a nice race there.
>
> This is fine. See the signal_pending_state() check in __schedule().
>
> And this doesn't differ from wait_event_interruptible(), it too doesn't
> check signal_pending(), we rely on schedule() which must not block if the
> caller is signalled/killed.
>
> The problem is that it is not clear what should fatal_signal_pending() or
> even signal_pending() mean after exit_signals().

Uh, I was totally thrown off in all the wait_event* macros and somehow
landed in the _locked variants, which all need to recheck before they
drop the lock, for efficiency reasons. See do_wait_intr().

Sorry for the confusion.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
