Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeCMVIM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:08:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932472AbeCMVGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:06:15 -0400
Subject: Re: [PATCH v4 4/6] ipc: Clamp msgmni and shmmni to the real IPCMNI
 limit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-5-git-send-email-longman@redhat.com>
 <87woyfyh57.fsf@xmission.com>
 <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com>
 <87o9jru3bf.fsf@xmission.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <935a7c50-50cc-2dc0-33bb-92c000d039bc@redhat.com>
Date: Tue, 13 Mar 2018 17:06:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <87o9jru3bf.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 04:29 PM, Eric W. Biederman wrote:
> Waiman Long <longman@redhat.com> writes:
>
>> On 03/13/2018 02:17 PM, Eric W. Biederman wrote:
>>> Waiman Long <longman@redhat.com> writes:
>>>
>>>> A user can write arbitrary integer values to msgmni and shmmni sysctl
>>>> parameters without getting error, but the actual limit is really
>>>> IPCMNI (32k). This can mislead users as they think they can get a
>>>> value that is not real.
>>>>
>>>> Enforcing the limit by failing the sysctl parameter write, however,
>>>> can break existing user applications.
>>> Which applications examples please.
>>>
>>> I am seeing this patchset late but it looks like a whole lot of changes
>>> to avoid a theoretical possibility.
>>>
>>> Changes that have an impact on more than just the ipc code you are
>>> patching.
>>>
>>> That makes me feel very uncomfortable with these changes.
>>>
>>> Eric
>> This patchset is constructed to address a customer request that there is
>> no easy way to find out the actual usable range of a sysctl parameter.
>> In this particular case, the customer wants to use more than 32k shared
>> memory segments. They can put in a large value into shmmni, but the
>> application didn't work properly because shmmni was internally clamped
>> to 32k without any visible sign that a smaller limit has been imposed.
>>
>> Out of a concern that there might be customers out there setting those
>> sysctl parameters outside of the allowable range without knowing it,
>> just enforcing the right limits may have the undesirable consequence of
>> breaking their existing setup scripts. I don't have concrete example of
>> what customers are doing that, but it  won't look good if we wait until
>> the complaints come in.
>>
>> The new code won't affect existing code unless the necessary flag is
>> set. So would you mind elaborating what other impact do you see that
>> will affect other non-IPC code in an undesirable way?
> The increase in size of struct ctl_table.  Every caller is affected.
> Plus it increases everyone's cognitive load to figure out what is
> this flags field as they fill out ctl_table.

As said earlier, there is a way to add the new flags without increasing
the size of the structure. The flags was originally a uint16_t which
won't increase the size of the structure. It was changed in v4 to
provide more space for future extension. I am going to change it back to
uint16_t. It can certainly be changed again in the future if we really
need more than 16 bits.

> Just introducing a proc_dointvec_minmax_clamped follows the existing
> pattern and it makes it easier for everyone who both read the code.

It was the approach that was taken in my v1 patch. I changed it to use a
flag in v2 as it is more general. It also make it easier to extend the
feature in the future. Adding more proc_handlers also has the same issue
of increasing cognitive load of what proc_handler to use in the
ctl_table. This is the side effect of adding more complexity and there
is no way to work around it.

> It strikes me as quite peculiar that the response to bug report where
> the complaint is an error is not given, is to continue the current
> behavior without giving an error.
The customer actually has 2 requests. First, it is to make it easier to
figure out what are the real ranges of some of the sysctl parameters.
Secondly, they want to increase the IPCMNI limit to more than 32k. This
patch tries to address the first one. I will leave the second one to a
future patch once this one is done. As said before, the reason for
adding a clamping mode is to avoid regression. If you guys strongly
believe that this is not an issue at all, I am fine going along and
enforce the limit by failing invalid value.

I am also working on a follow-up patch to add an iteration API to dump
out the the ranges of relevant sysctl parameters that allow range of
values. That will require using a flag to annotate ctl_table entries
that have ranges.

> Arguably the simplest fix here would be to kill IPCMNI entirely.  Assign
> the shmids from a sequence counter.  And place those structures in a
> rbtree indexed by shmni.  There are 32bit fields but I don't think we
> must keep the low 16bits for an index into an array and the high 16bits
> as the actual sequence number.

Yes, that is on my to-do list.

Cheers,
Longman
