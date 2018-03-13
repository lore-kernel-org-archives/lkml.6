Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeCMUaq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:30:46 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38016 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeCMUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:30:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Waiman Long <longman@redhat.com>
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
Date: Tue, 13 Mar 2018 15:29:40 -0500
In-Reply-To: <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com> (Waiman Long's
        message of "Tue, 13 Mar 2018 14:39:07 -0400")
Message-ID: <87o9jru3bf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evqZ1-0003CD-20;;;mid=<87o9jru3bf.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+GkcpPTKMEhzyL0cV4+Uwq7OONzQkEr+k=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Waiman Long <longman@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15018 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.0 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 0.81 (0.0%),
        extract_message_metadata: 3.6 (0.0%), get_uri_detail_list: 2.1 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.21 (0.0%), tests_pri_-900:
        0.98 (0.0%), tests_pri_-400: 24 (0.2%), check_bayes: 23 (0.2%), b_tokenize: 8
        (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob: 2.6 (0.0%), b_tok_touch_all:
        2.4 (0.0%), b_finish: 0.55 (0.0%), tests_pri_0: 214 (1.4%),
        check_dkim_signature: 0.48 (0.0%), check_dkim_adsp: 3.2 (0.0%),
        tests_pri_500: 14761 (98.3%), poll_dns_idle: 14755 (98.2%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v4 4/6] ipc: Clamp msgmni and shmmni to the real IPCMNI limit
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> On 03/13/2018 02:17 PM, Eric W. Biederman wrote:
>> Waiman Long <longman@redhat.com> writes:
>>
>>> A user can write arbitrary integer values to msgmni and shmmni sysctl
>>> parameters without getting error, but the actual limit is really
>>> IPCMNI (32k). This can mislead users as they think they can get a
>>> value that is not real.
>>>
>>> Enforcing the limit by failing the sysctl parameter write, however,
>>> can break existing user applications.
>> Which applications examples please.
>>
>> I am seeing this patchset late but it looks like a whole lot of changes
>> to avoid a theoretical possibility.
>>
>> Changes that have an impact on more than just the ipc code you are
>> patching.
>>
>> That makes me feel very uncomfortable with these changes.
>>
>> Eric
>
> This patchset is constructed to address a customer request that there is
> no easy way to find out the actual usable range of a sysctl parameter.
> In this particular case, the customer wants to use more than 32k shared
> memory segments. They can put in a large value into shmmni, but the
> application didn't work properly because shmmni was internally clamped
> to 32k without any visible sign that a smaller limit has been imposed.
>
> Out of a concern that there might be customers out there setting those
> sysctl parameters outside of the allowable range without knowing it,
> just enforcing the right limits may have the undesirable consequence of
> breaking their existing setup scripts. I don't have concrete example of
> what customers are doing that, but it  won't look good if we wait until
> the complaints come in.
>
> The new code won't affect existing code unless the necessary flag is
> set. So would you mind elaborating what other impact do you see that
> will affect other non-IPC code in an undesirable way?

The increase in size of struct ctl_table.  Every caller is affected.
Plus it increases everyone's cognitive load to figure out what is
this flags field as they fill out ctl_table.

Just introducing a proc_dointvec_minmax_clamped follows the existing
pattern and it makes it easier for everyone who both read the code.



It strikes me as quite peculiar that the response to bug report where
the complaint is an error is not given, is to continue the current
behavior without giving an error.


Arguably the simplest fix here would be to kill IPCMNI entirely.  Assign
the shmids from a sequence counter.  And place those structures in a
rbtree indexed by shmni.  There are 32bit fields but I don't think we
must keep the low 16bits for an index into an array and the high 16bits
as the actual sequence number.

Except for the checkpoint/restart case which is aguably much too
specific about how these ids are assigned that would give much more
freedom and allow people the number of shm segments that they actually
want to use.


For a further complication I don't expect you can get away with changing
the size or the fields in struct ctl_table in the kernel your customers
are running.


So please use a new function not flags it will simplify everyone's life.
If you can please actually fix this so you can have more shmids that
would be the really classy thing todo.

Eric
