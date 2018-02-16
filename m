Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbeBPS1Z convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:27:25 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:46271 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbeBPS1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:27:22 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Enrico Weigelt <lkml@metux.net>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
        <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
Date: Fri, 16 Feb 2018 12:26:59 -0600
In-Reply-To: <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net> (Enrico
        Weigelt's message of "Tue, 13 Feb 2018 22:19:48 +0000")
Message-ID: <87po54x024.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1emkjA-00024z-BA;;;mid=<87po54x024.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+aT4oPeXGPmYpTzR5dJ44/BBNRp7NX1yA=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Enrico Weigelt <lkml@metux.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 463 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.7%), b_tie_ro: 2.00 (0.4%), parse: 1.33 (0.3%),
        extract_message_metadata: 29 (6.3%), get_uri_detail_list: 2.2 (0.5%),
        tests_pri_-1000: 12 (2.6%), tests_pri_-950: 2.1 (0.5%), tests_pri_-900: 1.68
        (0.4%), tests_pri_-400: 26 (5.7%), check_bayes: 25 (5.3%), b_tokenize: 9
        (2.0%), b_tok_get_all: 6 (1.4%), b_comp_prob: 3.7 (0.8%), b_tok_touch_all:
        2.1 (0.5%), b_finish: 0.76 (0.2%), tests_pri_0: 372 (80.4%),
        check_dkim_signature: 0.85 (0.2%), check_dkim_adsp: 4.5 (1.0%),
        tests_pri_500: 9 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: plan9 semantics on Linux - mount namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico Weigelt <lkml@metux.net> writes:

> On 13.02.2018 22:12, Enrico Weigelt wrote:
>
> CC @containers@lists.linux-foundation.org
>
>> Hi folks,
>>
>>
>> I'm currently trying to implement plan9 semantics on Linux and
>> yet sorting out how to do the mount namespace handling.
>>
>> On plan9, any unprivileged process can create its own namespace
>> and mount/bind at will, while on Linux this requires CAP_SYS_ADMIN.
>>
>> What is the reason for not allowing arbitrary users to create their
>> own private mount namespace ? What could go wrong here ?

suid root executables could be fooled.  An easy case is fooling
/bin/su into reading a different copy of /etc/shadow, and allowing
arbitrary changes between users.

>> IMHO, we could allow mount/bind under the following conditions:
>>
>> * the process is in a private mount namespace
>> * no suid-flag is honored (either force all mounts to nosuid or
>>    completely mask it out)
>> * only certain whitelisted filesystems allowed (eg. 9P and FUSE)
>>
>> Maybe that all could be enabled by a new capability.
>>
>>
>> any suggestions ?

User namespaces limit the contained processes to not having any
permissions outside of the user namespace.  While still allowing the
fully unix permission model inside user namespaces.

I am in the final stages of getting the changes in the vfs and in fuse
to allow unprivileged users to mount that filesystem.  plan9fs would
also be a candidate for that kind of treatment if it had a maintainer.

Eric
