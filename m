Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeBVTFT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:05:19 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:51609 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeBVTFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:05:17 -0500
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
        <20180221202908.17258-1-ebiederm@xmission.com>
        <CAOssrKch20vj8phkjfjMe=07-8uQiuXfOuCTDjrMzPbkg6DoxA@mail.gmail.com>
Date: Thu, 22 Feb 2018 13:04:32 -0600
In-Reply-To: <CAOssrKch20vj8phkjfjMe=07-8uQiuXfOuCTDjrMzPbkg6DoxA@mail.gmail.com>
        (Miklos Szeredi's message of "Thu, 22 Feb 2018 11:13:36 +0100")
Message-ID: <87fu5s7sn3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eowAu-00005s-5B;;;mid=<87fu5s7sn3.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18LdLkw7Z6Z3tJ2ZJBQc1BVD39acSEkk1U=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15034 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 9 (0.1%), b_tie_ro: 7 (0.0%), parse: 1.13 (0.0%),
        extract_message_metadata: 13 (0.1%), get_uri_detail_list: 1.67 (0.0%),
        tests_pri_-1000: 5 (0.0%), compile_eval: 41 (0.3%), tests_pri_-950: 1.90
        (0.0%), tests_pri_-900: 1.72 (0.0%), tests_pri_-400: 28 (0.2%), check_bayes:
        26 (0.2%), b_tokenize: 7 (0.0%), b_tok_get_all: 8 (0.1%), b_comp_prob: 2.2
        (0.0%), b_tok_touch_all: 5 (0.0%), b_finish: 1.01 (0.0%), tests_pri_0: 323
        (2.2%), check_dkim_signature: 0.65 (0.0%), check_dkim_adsp: 8 (0.1%),
        tests_pri_500: 14647 (97.4%), poll_dns_idle: 14637 (97.4%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v6 1/5] fuse: Remove the buggy retranslation of pids in fuse_dev_do_read
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Wed, Feb 21, 2018 at 9:29 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> At the point of fuse_dev_do_read the user space process that initiated the
>> action on the fuse filesystem may no longer exist.  The process have been
>> killed or may have fired an asynchronous request and exited.
>>
>> If the initial process has exited the code "pid_vnr(find_pid_ns(in->h.pid,
>> fc->pid_ns)" will either return a pid of 0, or in the unlikely event that
>> the pid has been reallocated it can return practically any pid.  Any pid is
>> possible as the pid allocator allocates pid numbers in different pid
>> namespaces independently.
>>
>> The only way to make translation in fuse_dev_do_read reliable is to call
>> get_pid in fuse_req_init_context, and pid_vnr followed by put_pid in
>> fuse_dev_do_read.  That reference counting in other contexts has been shown
>> to bounce cache lines between processors and in general be slow.  So that is
>> not desirable.
>>
>> The only known user of running the fuse server in a different pid namespace
>> from the filesystem does not care what the pids are in the fuse messages
>> so removing this code should not matter.
>
> Shouldn't we at least zero out the pid in that case?

This is an explicit case of passing a file descriptor between pid
namespaces.  So I think there are plenty of buyer be ware signs out.
So I don't know if there are any real world advantages of zeroing the
pid.

I can see a case for using the pid namespace of the opener of /dev/fuse
instead of the pid namespace of the mounter of the fuse filesystem.
Although in practice I would be surprised if they were different.

I am very leary about caring during a read operation.  Caring about the
current processes during read/write tends to break caching, is error prone
as the need for this patch demonstrates, and is generally likely to be
slower than not caring.

So yes we can zero the pid.   I don't think it is wise to zero the pid
unless we zero the pid in fuse_req_init_context.

Eric
