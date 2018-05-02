Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeEBPLE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:11:04 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47117 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeEBPLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:11:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1524862838-8247-1-git-send-email-longman@redhat.com>
        <87po2ex0k6.fsf@xmission.com>
        <5aac35f0-77e3-5693-ddf0-a03695ff1192@redhat.com>
Date: Wed, 02 May 2018 10:06:20 -0500
In-Reply-To: <5aac35f0-77e3-5693-ddf0-a03695ff1192@redhat.com> (Waiman Long's
        message of "Wed, 2 May 2018 09:23:58 -0400")
Message-ID: <87tvrqf66r.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDtME-0001R3-PZ;;;mid=<87tvrqf66r.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX197ZQRt4m6unuOQhcFCgJcaz7Cz5NNmowE=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Waiman Long <longman@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2691 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.5 (0.1%), b_tie_ro: 2.7 (0.1%), parse: 0.68 (0.0%),
        extract_message_metadata: 3.2 (0.1%), get_uri_detail_list: 1.63 (0.1%),
        tests_pri_-1000: 2.8 (0.1%), tests_pri_-950: 1.21 (0.0%), tests_pri_-900:
        1.00 (0.0%), tests_pri_-400: 37 (1.4%), check_bayes: 36 (1.3%), b_tokenize: 5
        (0.2%), b_tok_get_all: 11 (0.4%), b_comp_prob: 1.70 (0.1%), b_tok_touch_all:
        13 (0.5%), b_finish: 0.71 (0.0%), tests_pri_0: 2204 (81.9%),
        check_dkim_signature: 0.38 (0.0%), check_dkim_adsp: 2006 (74.5%),
        tests_pri_500: 431 (16.0%), poll_dns_idle: 426 (15.8%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v6 0/8] ipc: Clamp *mni to the real IPCMNI limit & increase that limit
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> On 05/01/2018 10:18 PM, Eric W. Biederman wrote:
>>
>>> The sysctl parameters msgmni, shmmni and semmni have an inherent limit
>>> of IPC_MNI (32k). However, users may not be aware of that because they
>>> can write a value much higher than that without getting any error or
>>> notification. Reading the parameters back will show the newly written
>>> values which are not real.
>>>
>>> Enforcing the limit by failing sysctl parameter write, however, may
>>> cause regressions if existing user setup scripts set those parameters
>>> above 32k as those scripts will now fail in this case.
>> I have a serious problem with this approach.  Have you made any effort
>> to identify any code that sets these values above 32k?  Have you looked
>> to see if these applications actually care if you return an error when
>> a value is set too large?
>
> It is not that an application cares about if an error is returned or
> not. Most applications don't care. It is that if an error is returned,
> it means that the sysctl parameter isn't change at all instead of being
> set to a large value and then internally clamped to a smaller number
> which is still bigger than the original value. That is what can break an
> application because the sysctl parameters may be just too small for the
> application.

Agreed that is a possibility.  The other possibility is like your
customer they will try to use all of the increased number of shared
memory segments it won't work and they will fail, and it will be
mysterious and weird.

I took a quick look to see if cargo culting bad settings was a common
thing and all I could see were examples of people setting the limits
to numbers smaller than 4096.

>> Right now this seems like a lot of work to avoid breaking applications
>> and or users that may or may not exist.  If you can find something that
>> will care sure.  We need to avoid breaking userspace and causing
>> regressions.  However as this stands it looks you are making maintenance
>> of the kernel more difficult to avoid having to look to see if there are
>> monsters under the bed.
>
> I shall admit that it can be hard to find applications that will
> explicitly need that as we usually don't have access to the applications
> that the customers have. It is more a correctness issue where the
> existing code is kind of lying about what can actually be supported. I
> just want to make the users more aware of what the right limits are.

You presume the kernel is lying to applications.  I admit the kernel
can lie to applications.  I don't see any evidence that the kernel is
actually doing so.  So far (to me) it looks like a large number of sysv
shared memory segments is not particulalry common.

So I would not be at all surprised if no regressions would be generated
if you simply deny setting the value past the maximum.

Eric
