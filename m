Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756060AbeEaSDB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:03:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59814 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755879AbeEaSCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:02:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
        <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
        <87h8oqhagl.fsf@xmission.com>
        <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
        <71d8d32b-0f59-d418-0ee4-fcc7782646ae@gmail.com>
Date: Thu, 31 May 2018 13:02:33 -0500
In-Reply-To: <71d8d32b-0f59-d418-0ee4-fcc7782646ae@gmail.com> (Michael
        Kerrisk's message of "Fri, 27 Apr 2018 14:15:01 +0200")
Message-ID: <871sdrem9y.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fORuJ-000223-8P;;;mid=<871sdrem9y.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19WchxKttDi/S7kD0ycYLhtnoaRbn2X8TM=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15033 ms - load_scoreonly_sql: 0.83 (0.0%),
        signal_user_changed: 6 (0.0%), b_tie_ro: 3.2 (0.0%), parse: 0.96 (0.0%),
        extract_message_metadata: 17 (0.1%), get_uri_detail_list: 2.4 (0.0%),
        tests_pri_-1000: 4.9 (0.0%), tests_pri_-950: 1.71 (0.0%), tests_pri_-900:
        1.43 (0.0%), tests_pri_-400: 30 (0.2%), check_bayes: 29 (0.2%), b_tokenize:
        12 (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob: 3.7 (0.0%), b_tok_touch_all:
        2.9 (0.0%), b_finish: 0.72 (0.0%), tests_pri_0: 205 (1.4%),
        check_dkim_signature: 0.82 (0.0%), check_dkim_adsp: 3.7 (0.0%),
        tests_pri_500: 14760 (98.2%), poll_dns_idle: 14752 (98.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:

> On 04/05/2018 09:02 AM, Konstantin Khlebnikov wrote:
>> On 05.04.2018 01:29, Eric W. Biederman wrote:
>>> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>>>
>>>> On 04/04/2018 12:11 PM, Konstantin Khlebnikov wrote:
>>>>> Each process have different pids, one for each pid namespace it belongs.
>>>>> When interaction happens within single pid-ns translation isn't required.
>>>>> More complicated scenarios needs special handling.
>>>>>
>>>>> For example:
>>>>> - reading pid-files or logs written inside container with pid namespace
>>>>> - attaching with ptrace to tasks from different pid namespace
>>>>> - passing pids across pid namespaces in any kind of API
>>>>>
>>>>> Currently there are several interfaces that could be used here:
>>>>>
>>>>> Pid namespaces are identified by inode number of /proc/[pid]/ns/pid.
>>>
>>> Using the inode number in interfaces is not an option.  Especially not
>>> withou referencing the device number for the filesystem as well.
>> 
>> This is supposed to be single-instance fs,
>> not part of proc but referenced but its magic "symlinks".
>> 
>> Device numbers are not mentioned in "man namespaces".
>
> Thanks for the heads-up!
>
> That was a bug in the man-page. ioctl_ns(2) already says the right thing.
> Now I patches namespaces(7), as below.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

For the changes to namespaces.7.  I suspect you have already applied
them by now, but if not.

Eric


> Cheers,
>
> Michael
>
> diff --git a/man7/namespaces.7 b/man7/namespaces.7
> index 725ebaff6..3c155de7e 100644
> --- a/man7/namespaces.7
> +++ b/man7/namespaces.7
> @@ -154,11 +154,14 @@ In Linux 3.7 and earlier, these files were visible as hard links.
>  Since Linux 3.8,
>  .\" commit bf056bfa80596a5d14b26b17276a56a0dcb080e5
>  they appear as symbolic links.
> -If two processes are in the same namespace, then the inode numbers of their
> +If two processes are in the same namespace,
> +then the device IDs and inode numbers of their
>  .IR /proc/[pid]/ns/xxx
>  symbolic links will be the same; an application can check this using the
> +.I stat.st_dev
> +and
>  .I stat.st_ino
> -field returned by
> +fields returned by
>  .BR stat (2).
>  The content of this symbolic link is a string containing
>  the namespace type and inode number as in the following example:
