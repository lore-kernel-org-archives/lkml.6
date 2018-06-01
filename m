Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbeFAUVc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 16:21:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39623 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbeFAUV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 16:21:29 -0400
X-Google-Smtp-Source: ADUXVKL6p1vJIvYIdc9y0KcJ5qVpbyEkyPVtNPDdtODVgLHoDUrIqEgMu1X5QBZbnfD+zfXOY85JPKrnwXeEncbPplY=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CAHC9VhRTzB5+swKg7TaT00nMOmoTMoBCxRvBuwB5dRahntokQw@mail.gmail.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-9-stefanb@linux.vnet.ibm.com> <20180530124920.g5agxm75x4i6pw6n@madcap2.tricolour.ca>
 <35894dae-c9c6-aa65-da99-c0283d459878@linux.vnet.ibm.com> <CAHC9VhSnubpfY6=RF9ZHQS0js18xor2nF=REfd=ZKTxV-wabiA@mail.gmail.com>
 <85a2ad4d-6406-ad64-f440-7ab8289ceb2e@linux.vnet.ibm.com> <20180530233413.xz5bs3zb4jwmddpi@madcap2.tricolour.ca>
 <89c5f9c1-cdc4-6d2c-c187-04e94c2b8e75@linux.vnet.ibm.com> <CAHC9VhRTzB5+swKg7TaT00nMOmoTMoBCxRvBuwB5dRahntokQw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Jun 2018 16:21:27 -0400
Message-ID: <CAHC9VhTpiNMThXxAgaYsafmz-36NZvtpZr9bvttbnHthFiLtNw@mail.gmail.com>
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from "audit" actions
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 4:13 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jun 1, 2018 at 4:00 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> On 05/30/2018 07:34 PM, Richard Guy Briggs wrote:
>>>
>>> On 2018-05-30 17:38, Stefan Berger wrote:
>>>>
>>>> On 05/30/2018 05:22 PM, Paul Moore wrote:
>>>>>
>>>>> On Wed, May 30, 2018 at 9:08 AM, Stefan Berger
>>>>> <stefanb@linux.vnet.ibm.com> wrote:
>>>>>>
>>>>>> On 05/30/2018 08:49 AM, Richard Guy Briggs wrote:
>>>>>>>
>>>>>>> On 2018-05-24 16:11, Stefan Berger wrote:
>>>>>>>>
>>>>>>>> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
>>>>>>>> the IMA "audit" policy action.  This patch defines
>>>>>>>> AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
>>>>>>>>
>>>>>>>> With this change we now call integrity_audit_msg_common() to get
>>>>>>>> common integrity auditing fields. This now produces the following
>>>>>>>> record when parsing an IMA policy rule:
>>>>>>>>
>>>>>>>> type=UNKNOWN[1806] msg=audit(1527004216.690:311): action=dont_measure
>>>>>>>> \
>>>>>>>>      fsmagic=0x9fa0 pid=1613 uid=0 auid=0 ses=2 \
>>>>>>>>      subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
>>>>>>>>      op=policy_update cause=parse_rule comm="echo"
>>>>>>>> exe="/usr/bin/echo" \
>>>>>>>>      tty=tty2 res=1
>>>>>>>>
>>>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>>>>>> ---
>>>>>>>>     include/uapi/linux/audit.h          | 3 ++-
>>>>>>>>     security/integrity/ima/ima_policy.c | 5 +++--
>>>>>>>>     2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>>>>>>>> index 4e61a9e05132..776e0abd35cf 100644
>>>>>>>> --- a/include/uapi/linux/audit.h
>>>>>>>> +++ b/include/uapi/linux/audit.h
>>>>>>>> @@ -146,7 +146,8 @@
>>>>>>>>     #define AUDIT_INTEGRITY_STATUS            1802 /* Integrity
>>>>>>>> enable
>>>>>>>> status */
>>>>>>>>     #define AUDIT_INTEGRITY_HASH      1803 /* Integrity HASH type */
>>>>>>>>     #define AUDIT_INTEGRITY_PCR       1804 /* PCR invalidation msgs
>>>>>>>> */
>>>>>>>> -#define AUDIT_INTEGRITY_RULE       1805 /* policy rule */
>>>>>>>> +#define AUDIT_INTEGRITY_RULE       1805 /* IMA "audit" action policy
>>>>>>>> msgs  */
>>>>>>>> +#define AUDIT_INTEGRITY_POLICY_RULE 1806 /* IMA policy rules */
>>>>>>>>       #define AUDIT_KERNEL                2000    /* Asynchronous
>>>>>>>> audit
>>>>>>>> record. NOT A REQUEST. */
>>>>>>>>     diff --git a/security/integrity/ima/ima_policy.c
>>>>>>>> b/security/integrity/ima/ima_policy.c
>>>>>>>> index 3aed25a7178a..a8ae47a386b4 100644
>>>>>>>> --- a/security/integrity/ima/ima_policy.c
>>>>>>>> +++ b/security/integrity/ima/ima_policy.c
>>>>>>>> @@ -634,7 +634,7 @@ static int ima_parse_rule(char *rule, struct
>>>>>>>> ima_rule_entry *entry)
>>>>>>>>           int result = 0;
>>>>>>>>           ab = integrity_audit_log_start(NULL, GFP_KERNEL,
>>>>>>>> -                                      AUDIT_INTEGRITY_RULE);
>>>>>>>> +                                      AUDIT_INTEGRITY_POLICY_RULE);
>>>>>>>
>>>>>>> Is it possible to connect this record to a syscall by replacing the
>>>>>>> first parameter (NULL) by current->context?
>>>>>
>>>>> We're likely going to need to "associate" this record (audit speak for
>>>>> making the first parameter non-NULL) with others for the audit
>>>>> container ID work.  If you do it now, Richard's patches will likely
>>>>> get a few lines smaller and that will surely make him a bit happier :)
>>>>
>>>> Richard is also introducing a local context that we can then create and
>>>> use
>>>> instead of the NULL. Can we not use that then?
>>>
>>> That is for records for which there is no syscall or user associated.
>>>
>>> In fact there is another recent change that would be better to use than
>>> current->audit_context, which is the function audit_context().
>>> See commit cdfb6b3 ("audit: use inline function to get audit context").
>>>
>>>> Steven seems to say: "We don't want to add syscall records to everything.
>>>> That messes up schemas and existing code. The integrity events are 1
>>>> record
>>>> in size and should stay that way. This saves disk space and improves
>>>> readability."
>>>>
>>>>>> We would have to fix current->context in this case since it is NULL. We
>>>>>> get
>>>>>> to this location by root cat'ing a policy or writing a policy filename
>>>>>> into
>>>>>> /sys/kernel/security/ima/policy.
>>>>>
>>>>> Perhaps I'm missing something, but current in this case should point
>>>>> to the process which is writing to the policy file, yes?
>>>>
>>>> Yes, but current->context is NULL for some reason.
>>>
>>> Is it always this way?  If it isn't, which it should not be, we should
>>> find out why.  Well, we should find out why this is NULL anyways, since
>>> it shouldn't be.
>>
>>
>> When someone writes a policy for IMA into securityfs, it's always NULL.
>> There's another location where IMA uses the current->audit_context, and
>> that's here:
>>
>> https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_api.c#L323
>>
>> At this location we sometimes see a (background) process with an
>> audit_context but in the majority of cases it's current->audit_context is
>> NULL. Starting a process as root or also non-root user, with the appropriate
>> IMA audit policy rules set, we always see a NULL audit_context here.
>
> What does your audit configuration look like?
>
> Depending on your configuration a NULL audit_context can be expected,
> see audit_dummy_context().  I believe the default Fedora audit config
> will leave you with a NULL audit_context for all processes.  I also
> believe that unless you explicitly set "audit=1" on the kernel command
> line the init/systemd process will have a NULL audit_context (there
> was actually a range of kernels where even setting "audit=1" wouldn't
> be sufficient due to a bug we fixed a little while ago).
>
> Look at the audit_alloc() function, it is called when a new process is
> fork'd and is responsible for allocating a new audit_context.  If the
> currently loaded audit config dictates that auditing is to be disabled
> for this new process (state == AUDIT_DISABLED) then an audit_context
> is not allocated and current->context remains NULL.

I should also add that a NULL current->context is not necessarily a
problem, assuming that it is the proper result of the loaded audit
configuration.  If current->context is NULL then the audit records
that are generated by that process will not be accompanied/associated
with a matching SYSCALL record ... which is okay since the
configuration explicitly blocked the creation of the SYSCALL record.
If current->context is non-NULL, then the audit records will be
associated with the matching SYSCALL record because that is the Right
Thing To Do.

While the exact details are still TBD, I expect there to be slight
changes to how this is all implemented in the upcoming audit container
ID work.  The impact on the IMA code should be minimal/nothing if you
are already passing current->context back into the audit subsystem.

-- 
paul moore
www.paul-moore.com
