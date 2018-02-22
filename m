Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933639AbeBVSPc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 13:15:32 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:54337 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933572AbeBVSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 13:15:30 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <878tbmf5vl.fsf@xmission.com>
        <20180221202908.17258-2-ebiederm@xmission.com>
        <CAOssrKeYuVj6ZWUrXp7R_d+wdoArnJ=mhRp22qE9JBW3x-7tfw@mail.gmail.com>
Date: Thu, 22 Feb 2018 12:15:00 -0600
In-Reply-To: <CAOssrKeYuVj6ZWUrXp7R_d+wdoArnJ=mhRp22qE9JBW3x-7tfw@mail.gmail.com>
        (Miklos Szeredi's message of "Thu, 22 Feb 2018 11:26:22 +0100")
Message-ID: <87eflc99i3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eovOy-0008QZ-17;;;mid=<87eflc99i3.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+rdQsGNLPsudJqu0NcswWQsKhFpeBCQY0=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 305 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.8 (1.2%), b_tie_ro: 2.7 (0.9%), parse: 0.73 (0.2%),
        extract_message_metadata: 10 (3.4%), get_uri_detail_list: 2.2 (0.7%),
        tests_pri_-1000: 4.5 (1.5%), tests_pri_-950: 1.07 (0.3%), tests_pri_-900:
        1.00 (0.3%), tests_pri_-400: 26 (8.7%), check_bayes: 25 (8.3%), b_tokenize: 8
        (2.5%), b_tok_get_all: 9 (2.8%), b_comp_prob: 2.1 (0.7%), b_tok_touch_all:
        4.2 (1.4%), b_finish: 0.80 (0.3%), tests_pri_0: 251 (82.3%),
        check_dkim_signature: 0.41 (0.1%), check_dkim_adsp: 2.9 (0.9%),
        tests_pri_500: 3.3 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v6 2/5] fuse: Fail all requests with invalid uids or gids
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Wed, Feb 21, 2018 at 9:29 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Upon a cursory examinination the uid and gid of a fuse request are
>> necessary for correct operation.  Failing a fuse request where those
>> values are not reliable seems a straight forward and reliable means of
>> ensuring that fuse requests with bad data are not sent or processed.
>>
>> In most cases the vfs will avoid actions it suspects will cause
>> an inode write back of an inode with an invalid uid or gid.  But that does
>> not map precisely to what fuse is doing, so test for this and solve
>> this at the fuse level as well.
>>
>> Performing this work in fuse_req_init_context is cheap as the code is
>> already performing the translation here and only needs to check the
>> result of the translation to see if things are not representable in
>> a form the fuse server can handle.
>>
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>>  fs/fuse/dev.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 0fb58f364fa6..216db3f51a31 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -112,11 +112,13 @@ static void __fuse_put_request(struct fuse_req *req)
>>         refcount_dec(&req->count);
>>  }
>>
>> -static void fuse_req_init_context(struct fuse_conn *fc, struct fuse_req *req)
>> +static bool fuse_req_init_context(struct fuse_conn *fc, struct fuse_req *req)
>>  {
>> -       req->in.h.uid = from_kuid_munged(&init_user_ns, current_fsuid());
>> -       req->in.h.gid = from_kgid_munged(&init_user_ns, current_fsgid());
>> +       req->in.h.uid = from_kuid(&init_user_ns, current_fsuid());
>> +       req->in.h.gid = from_kgid(&init_user_ns, current_fsgid());
>>         req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
>> +
>> +       return (req->in.h.uid != ((uid_t)-1)) && (req->in.h.gid != ((gid_t)-1));
>>  }
>>
>>  void fuse_set_initialized(struct fuse_conn *fc)
>> @@ -162,12 +164,13 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
>>                         wake_up(&fc->blocked_waitq);
>>                 goto out;
>>         }
>> -
>> -       fuse_req_init_context(fc, req);
>>         __set_bit(FR_WAITING, &req->flags);
>>         if (for_background)
>>                 __set_bit(FR_BACKGROUND, &req->flags);
>> -
>> +       if (unlikely(!fuse_req_init_context(fc, req))) {
>> +               fuse_put_request(fc, req);
>> +               return ERR_PTR(-EOVERFLOW);
>> +       }
>>         return req;
>>
>>   out:
>> @@ -256,9 +259,12 @@ struct fuse_req *fuse_get_req_nofail_nopages(struct fuse_conn *fc,
>>         if (!req)
>>                 req = get_reserved_req(fc, file);
>>
>> -       fuse_req_init_context(fc, req);
>>         __set_bit(FR_WAITING, &req->flags);
>>         __clear_bit(FR_BACKGROUND, &req->flags);
>> +       if (unlikely(!fuse_req_init_context(fc, req))) {
>> +               fuse_put_request(fc, req);
>> +               return ERR_PTR(-EOVERFLOW);
>> +       }
>
> I think failing the "_nofail" variant is the wrong thing to do.  This
> is called to allocate a FLUSH request on close() and in readdirplus to
> allocate a FORGET request.  Failing the latter results in refcount
> leak in userspace.   Failing the former results in missing unlock on
> close() of posix locks.

Doh!  You are quite correct.

Modifying fuse_get_req_nofail_nopages to fail is a bug.

I am thinking the proper solution is to write:

    static void fuse_req_init_context_nofail(struct fuse_req *req)
    {
            req->in.h.uid = 0;
            req->in.h.gid = 0;
            req->in.h.pid = 0;
    }

And use that in the nofail case.  As it appears neither flush nor
the eviction of inodes is a user space triggered action and as such
user space identifiers are nonsense in those cases.

I will respin this patch shortly.

Eric
