Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755166AbeEXXXr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:23:47 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55763 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755009AbeEXXXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:23:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>, linux-kernel@vger.kernel.org
References: <87o9h6554f.fsf@xmission.com> <20180524214617.GG7712@thunk.org>
Date: Thu, 24 May 2018 18:23:30 -0500
In-Reply-To: <20180524214617.GG7712@thunk.org> (Theodore Y. Ts'o's message of
        "Thu, 24 May 2018 17:46:17 -0400")
Message-ID: <87y3g8y6x9.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLza6-0004Rk-SE;;;mid=<87y3g8y6x9.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WYB662eNH9el1nNyMBlGe1bdN46kmgvI=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4951]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;"Theodore Y. Ts'o" <tytso@mit.edu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1497 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.2%), b_tie_ro: 2.1 (0.1%), parse: 1.17 (0.1%),
        extract_message_metadata: 10 (0.7%), get_uri_detail_list: 3.0 (0.2%),
        tests_pri_-1000: 9 (0.6%), tests_pri_-950: 3.0 (0.2%), tests_pri_-900: 2.3
        (0.2%), tests_pri_-400: 35 (2.4%), check_bayes: 33 (2.2%), b_tokenize: 13
        (0.8%), b_tok_get_all: 8 (0.5%), b_comp_prob: 5 (0.3%), b_tok_touch_all: 2.7
        (0.2%), b_finish: 1.08 (0.1%), tests_pri_0: 1397 (93.3%),
        check_dkim_signature: 1.40 (0.1%), check_dkim_adsp: 5 (0.4%), tests_pri_500:
        11 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 0/6] Wrapping up the vfs support for unprivileged mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> On Wed, May 23, 2018 at 06:22:56PM -0500, Eric W. Biederman wrote:
>> 
>> Very slowly the work has been progressing to ensure the vfs has the
>> necessary support for mounting filesystems without privilege.
>
> What's the thinking behind how system administrators and/or file
> systems would configure whether or not a particular file system type
> will be allowed to be mounted w/o privilege?

The mechanism is .fs_flags in file_system_type.   If the FS_USERNS_MOUNT
flag is set then root in a user namespace (AKA an unprivileged user)
will be allowed to mount to mount the filesystem.

There are very real concerns about attacking a filesystem with an
invalid filesystem image, or by a malicious protocol speaker.  So I
don't want to enable anything without the file system maintainers
consent and without a reasonable expecation that neither a system wide
denial of service attack nor a privilege escalation attack is possible
from if the filesystem is enabled.

So at a practical level what we have in the vfs is the non-fuse specific
bits that enable unprivileged mounts of fuse.  Things like handling
of unmapped uid and gids, how normally trusted xattrs are dealt with,
etc.

A big practical one for me is that if either the uid or gid is not
mapped the vfs avoids writing to the inode.

Right now my practical goal is to be able to say: "Go run your
filesystem in userspace with fuse if you want stronger security
guarantees."  I think that will be enough to make removable media
reasonably safe from privilege escalation attacks.

There is enough code in most filesystems that I don't know what our
chances of locking down very many of them are.  But I figure a few more
of them are possible.

Eric
