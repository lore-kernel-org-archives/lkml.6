Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755442AbeE3C02 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 22:26:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:32977 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeE3C0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 22:26:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Paul Moore <paul@paul-moore.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
        <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
Date: Tue, 29 May 2018 21:25:59 -0500
In-Reply-To: <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
        (Paul Moore's message of "Tue, 29 May 2018 18:39:54 -0400")
Message-ID: <8736y9lw08.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNqoN-0000px-AP;;;mid=<8736y9lw08.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19pRN8LDg7lDOvTVW9C0IK9asCE498CwCo=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Paul Moore <paul@paul-moore.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15030 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.5 (0.0%), b_tie_ro: 1.67 (0.0%), parse: 0.94 (0.0%),
        extract_message_metadata: 16 (0.1%), get_uri_detail_list: 3.7 (0.0%),
        tests_pri_-1000: 3.2 (0.0%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900:
        0.99 (0.0%), tests_pri_-400: 33 (0.2%), check_bayes: 32 (0.2%), b_tokenize:
        13 (0.1%), b_tok_get_all: 10 (0.1%), b_comp_prob: 3.1 (0.0%),
        b_tok_touch_all: 4.7 (0.0%), b_finish: 0.61 (0.0%), tests_pri_0: 357 (2.4%),
        check_dkim_signature: 0.82 (0.0%), check_dkim_adsp: 4.5 (0.0%),
        tests_pri_500: 14612 (97.2%), poll_dns_idle: 14600 (97.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v4 8/8] module: replace the existing LSM hook in init_module
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Tue, May 29, 2018 at 2:02 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>> Both the init_module and finit_module syscalls call either directly
>> or indirectly the security_kernel_read_file LSM hook.  This patch
>> replaces the direct call in init_module with a call to the new
>> security_kernel_load_data hook and makes the corresponding changes in
>> SELinux and IMA.
>>
>> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> Cc: Jeff Vander Stoep <jeffv@google.com>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  kernel/module.c                   |  2 +-
>>  security/integrity/ima/ima_main.c | 24 ++++++++++--------------
>>  security/selinux/hooks.c          | 26 ++++++++++++++++++++------
>>  3 files changed, 31 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index ce8066b88178..b97c642b5b4d 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
>>         if (info->len < sizeof(*(info->hdr)))
>>                 return -ENOEXEC;
>>
>> -       err = security_kernel_read_file(NULL, READING_MODULE);
>> +       err = security_kernel_load_data(LOADING_MODULE);
>>         if (err)
>>                 return err;
>>
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 3dae605a1604..0ff1d8152f6e 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -441,17 +441,6 @@ static int read_idmap[READING_MAX_ID] = {
>>   */
>>  int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>>  {
>> -       bool sig_enforce = is_module_sig_enforced();
>> -
>> -       if (!file && read_id == READING_MODULE) {
>> -               if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
>> -                   (ima_appraise & IMA_APPRAISE_ENFORCE)) {
>> -                       pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
>> -                       return -EACCES; /* INTEGRITY_UNKNOWN */
>> -               }
>> -               return 0;       /* We rely on module signature checking */
>> -       }
>> -
>>         if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
>>                 if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
>>                     (ima_appraise & IMA_APPRAISE_ENFORCE)) {
>> @@ -490,9 +479,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>>                 return 0;
>>         }
>>
>> -       if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
>> -               return 0;
>> -
>>         /* permit signed certs */
>>         if (!file && read_id == READING_X509_CERTIFICATE)
>>                 return 0;
>> @@ -521,6 +507,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>>   */
>>  int ima_load_data(enum kernel_load_data_id id)
>>  {
>> +       bool sig_enforce;
>> +
>>         if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
>>                 return 0;
>>
>> @@ -536,6 +524,14 @@ int ima_load_data(enum kernel_load_data_id id)
>>                         pr_err("Prevent firmware sysfs fallback loading.\n");
>>                         return -EACCES; /* INTEGRITY_UNKNOWN */
>>                 }
>> +               break;
>> +       case LOADING_MODULE:
>> +               sig_enforce = is_module_sig_enforced();
>> +
>> +               if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
>> +                       pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
>> +                       return -EACCES; /* INTEGRITY_UNKNOWN */
>> +               }
>>         default:
>>                 break;
>>         }
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 02ebd1585eaf..e02186470fc5 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4018,12 +4018,6 @@ static int selinux_kernel_module_from_file(struct file *file)
>>         u32 sid = current_sid();
>>         int rc;
>>
>> -       /* init_module */
>> -       if (file == NULL)
>> -               return avc_has_perm(&selinux_state,
>> -                                   sid, sid, SECCLASS_SYSTEM,
>> -                                       SYSTEM__MODULE_LOAD, NULL);
>> -
>>         /* finit_module */
>>
>>         ad.type = LSM_AUDIT_DATA_FILE;
>> @@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
>>                                 SYSTEM__MODULE_LOAD, &ad);
>>  }
>>
>> +static int selinux_kernel_load_data(enum kernel_load_data_id id)
>> +{
>> +       u32 sid;
>> +       int rc = 0;
>> +
>> +       switch (id) {
>> +       case LOADING_MODULE:
>> +               sid = current_sid();
>> +
>> +               /* init_module */
>> +               return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
>> +                                   SYSTEM__MODULE_LOAD, NULL);
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return rc;
>> +}
>
> I'm not a fan of the duplication here.

There are a couple of fundamental and strong differences here.

selinux_kernel_load_data only has the current_sid to work with.

selinux_module_data_from_file is all about the logic of how
to get fsec or isec from the file and from the inode.

For selinux and for every other lsm that uses the hooks that difference
of whether or not you have a file leads to different logic and different
code.  There is no meaningful sharing between the two cases.

In selinux all of the meaningful sharing happens with calls to
avc_has_perm(... SYSTEM__MODULE_LOAD, ...);

So as far as I can see talking about duplication is unfounded there is
none.

> If we must have a new LSM hook
> for this, can we at least have it call
> selinux_kernel_module_from_file() so we have all the kernel module
> loading logic/controls in one function?  Yes, I understand there are
> differences between init_module() and finit_module() but I like
> handling them both in one function as we do today.

Except even today the actual logic is not shared in a single function.
The only thing that happens in a single function is a switch statement
that calls different functions.

So what is the point of having a ``common'' function?

Eric
