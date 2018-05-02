Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeEBNYC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:24:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751100AbeEBNYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:24:00 -0400
Subject: Re: [PATCH v6 0/8] ipc: Clamp *mni to the real IPCMNI limit &
 increase that limit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1524862838-8247-1-git-send-email-longman@redhat.com>
 <87po2ex0k6.fsf@xmission.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5aac35f0-77e3-5693-ddf0-a03695ff1192@redhat.com>
Date: Wed, 2 May 2018 09:23:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <87po2ex0k6.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2018 10:18 PM, Eric W. Biederman wrote:
>
>> The sysctl parameters msgmni, shmmni and semmni have an inherent limit
>> of IPC_MNI (32k). However, users may not be aware of that because they
>> can write a value much higher than that without getting any error or
>> notification. Reading the parameters back will show the newly written
>> values which are not real.
>>
>> Enforcing the limit by failing sysctl parameter write, however, may
>> cause regressions if existing user setup scripts set those parameters
>> above 32k as those scripts will now fail in this case.
> I have a serious problem with this approach.  Have you made any effort
> to identify any code that sets these values above 32k?  Have you looked
> to see if these applications actually care if you return an error when
> a value is set too large?

It is not that an application cares about if an error is returned or
not. Most applications don't care. It is that if an error is returned,
it means that the sysctl parameter isn't change at all instead of being
set to a large value and then internally clamped to a smaller number
which is still bigger than the original value. That is what can break an
application because the sysctl parameters may be just too small for the
application.

> Right now this seems like a lot of work to avoid breaking applications
> and or users that may or may not exist.  If you can find something that
> will care sure.  We need to avoid breaking userspace and causing
> regressions.  However as this stands it looks you are making maintenance
> of the kernel more difficult to avoid having to look to see if there are
> monsters under the bed.

I shall admit that it can be hard to find applications that will
explicitly need that as we usually don't have access to the applications
that the customers have. It is more a correctness issue where the
existing code is kind of lying about what can actually be supported. I
just want to make the users more aware of what the right limits are.

Cheers,
Longman
