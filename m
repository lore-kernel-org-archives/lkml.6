Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753691AbeE3VJI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:09:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33102 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbeE3VJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:09:02 -0400
X-Google-Smtp-Source: ADUXVKKjFCzCJgSjh2nfnjStDwKAJcchxoRxQbmc9rFthVBvzrWlCJXjHkc2gRlyMMWlrjnVrKNRz2uY+7cM/Lh0I2g=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <8736y9lw08.fsf@xmission.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com> <8736y9lw08.fsf@xmission.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 May 2018 17:09:00 -0400
Message-ID: <CAHC9VhTL=jT+agnm5M5p7rRETSL4V+eu+fZ=7iooLdmRvoJcsA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] module: replace the existing LSM hook in init_module
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:25 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>> On Tue, May 29, 2018 at 2:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>>> Both the init_module and finit_module syscalls call either directly
>>> or indirectly the security_kernel_read_file LSM hook.  This patch
>>> replaces the direct call in init_module with a call to the new
>>> security_kernel_load_data hook and makes the corresponding changes in
>>> SELinux and IMA.
>>>
>>> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>>> Cc: Jeff Vander Stoep <jeffv@google.com>
>>> Cc: Paul Moore <paul@paul-moore.com>
>>> Cc: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>  kernel/module.c                   |  2 +-
>>>  security/integrity/ima/ima_main.c | 24 ++++++++++--------------
>>>  security/selinux/hooks.c          | 26 ++++++++++++++++++++------
>>>  3 files changed, 31 insertions(+), 21 deletions(-)

...

>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 02ebd1585eaf..e02186470fc5 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -4018,12 +4018,6 @@ static int selinux_kernel_module_from_file(struct file *file)
>>>         u32 sid = current_sid();
>>>         int rc;
>>>
>>> -       /* init_module */
>>> -       if (file == NULL)
>>> -               return avc_has_perm(&selinux_state,
>>> -                                   sid, sid, SECCLASS_SYSTEM,
>>> -                                       SYSTEM__MODULE_LOAD, NULL);
>>> -
>>>         /* finit_module */
>>>
>>>         ad.type = LSM_AUDIT_DATA_FILE;
>>> @@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
>>>                                 SYSTEM__MODULE_LOAD, &ad);
>>>  }
>>>
>>> +static int selinux_kernel_load_data(enum kernel_load_data_id id)
>>> +{
>>> +       u32 sid;
>>> +       int rc = 0;
>>> +
>>> +       switch (id) {
>>> +       case LOADING_MODULE:
>>> +               sid = current_sid();
>>> +
>>> +               /* init_module */
>>> +               return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
>>> +                                   SYSTEM__MODULE_LOAD, NULL);
>>> +       default:
>>> +               break;
>>> +       }
>>> +
>>> +       return rc;
>>> +}
>>
>> I'm not a fan of the duplication here.
>
> There are a couple of fundamental and strong differences here.
>
> selinux_kernel_load_data only has the current_sid to work with.
>
> selinux_module_data_from_file is all about the logic of how
> to get fsec or isec from the file and from the inode.
>
> For selinux and for every other lsm that uses the hooks that difference
> of whether or not you have a file leads to different logic and different
> code.  There is no meaningful sharing between the two cases.
>
> In selinux all of the meaningful sharing happens with calls to
> avc_has_perm(... SYSTEM__MODULE_LOAD, ...);
>
> So as far as I can see talking about duplication is unfounded there is
> none.

The duplication is the system:module_load access check (look at the
avc_has_perm() calls in selinux_kernel_module_from_file().  I believe
there is a readability/maintainability advantage to keeping them in
one function, and I would like it to stay that way.  If these
particular LSM hook(s) ever became performance critical (e.g. many
invocations a second) then I could see the value in separating them
out to eliminating some conditionals/branching, but as far as I can
tell that is not a problem at present.

I'm guessing your concern is more about the LSM hooks themselves and
not the individual implementations, in which case please see my last
response to Mimi.  I'm not opposed to two separate LSM hooks, I just
want to avoid moving the system:module_load checks out of
selinux_kernel_module_from_file(); which is independent of the number
of LSM hooks.

-- 
paul moore
www.paul-moore.com
