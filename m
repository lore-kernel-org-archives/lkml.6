Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933780AbeCGWXB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:23:01 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42591 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754553AbeCGWW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:22:57 -0500
X-Google-Smtp-Source: AG47ELsnzxYxYHa5c15eC/n+Xr9zzVNsBoCyxfsqVKWbjUx3vD7rSJkOQFkWN46TH6RtvP6HNKp7je1glzEahbuKkh4=
MIME-Version: 1.0
In-Reply-To: <6326ecfe-83f9-13d8-d59a-58d567726b07@schaufler-ca.com>
References: <cover.1520407240.git.sargun@sargun.me> <3646ff78915fcbadbc660257d92921e5442553e0.1520407240.git.sargun@sargun.me>
 <ad43c9ed-9314-1787-911a-f4b206bc5cff@schaufler-ca.com> <CAMp4zn8gtb7G28F8D_=npc6a7wwp3QMyvXrNKL0LA=EeFxRiKw@mail.gmail.com>
 <6326ecfe-83f9-13d8-d59a-58d567726b07@schaufler-ca.com>
From: Sargun Dhillon <sargun@sargun.me>
Date: Wed, 7 Mar 2018 14:22:14 -0800
Message-ID: <CAMp4zn-4Gkk=sopA52CBFBZvLQLweDOhZ9fvnyQYiE0g0Y3tsg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] security: Refactor LSM hooks into an array and enum
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 12:23 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/7/2018 11:18 AM, Sargun Dhillon wrote:
>> On Wed, Mar 7, 2018 at 9:45 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 3/6/2018 11:23 PM, Sargun Dhillon wrote:
>>>> This commit should have no functional change. It changes the security hook
>>>> list heads struct into an array. Additionally, it exposes all of the hooks
>>>> via an enum. This loses memory layout randomization as the enum is not
>>>> randomized.
>>> Please explain why you want to do this. I still dislike it.
>>>
>> Do you dislike it because of the loss of randomization, or some other reason?
>
> I dislike a huge array of untyped function pointers.
> I dislike the loss of type checking in security.c
>
Ok, I can go back to that. My previous approach was using two
list_heads, but people suggested otherwise. Would you be okay with the

>> The reason for not just having a second list_heads is that it's
>> somewhat ugly having to replicate that structure twice -- once for
>> dynamic hooks, and once for 'static' hooks.
>
> There was discussion about this some time ago. In the case
> where you don't allow dynamic hooks, you mark the lists ro_after_init
> whereas in the case with them you don't, but use the locking.
>
>
Why expose the compiled-in hooks to being RW? To me, having two
list_heads seems better, because you have the built-in ones be read
only, and the ones at load time be read/write. In fact, we could
protect the r/w with pmalloc?

>> Instead, we have one enum that LSMs can use and two arrays of heads
>> rather than an entire unrolled set of list_heads.
>
> But how is this better? What is the advantage?
>
>>
>> If we had a way to randomize this, would it make you comfortable?
>>
>
