Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeBVWv3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:51:29 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:47966 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeBVWv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:51:27 -0500
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
        <20180221202908.17258-4-ebiederm@xmission.com>
        <CAOssrKeNLBeMkMrrCeRBO9Z80zFxCCEygKL3DErnQ9xBoLkH0g@mail.gmail.com>
        <87inao6dfa.fsf@xmission.com>
Date: Thu, 22 Feb 2018 16:50:58 -0600
In-Reply-To: <87inao6dfa.fsf@xmission.com> (Eric W. Biederman's message of
        "Thu, 22 Feb 2018 13:18:33 -0600")
Message-ID: <87mv004p0t.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eozi1-0005LG-Pt;;;mid=<87mv004p0t.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/1H/o22Ysfk4F/uPCt1KZCWdIhApLErs=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 264 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.3 (1.3%), b_tie_ro: 2.3 (0.9%), parse: 1.46 (0.6%),
        extract_message_metadata: 17 (6.6%), get_uri_detail_list: 2.9 (1.1%),
        tests_pri_-1000: 9 (3.4%), tests_pri_-950: 1.75 (0.7%), tests_pri_-900: 1.39
        (0.5%), tests_pri_-400: 25 (9.5%), check_bayes: 24 (8.9%), b_tokenize: 9
        (3.6%), b_tok_get_all: 6 (2.4%), b_comp_prob: 2.9 (1.1%), b_tok_touch_all:
        2.5 (1.0%), b_finish: 0.77 (0.3%), tests_pri_0: 196 (74.3%),
        check_dkim_signature: 0.61 (0.2%), check_dkim_adsp: 3.1 (1.2%),
        tests_pri_500: 4.4 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v6 4/5] fuse: Ensure posix acls are translated outside of init_user_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Miklos Szeredi <mszeredi@redhat.com> writes:
>
>> On Wed, Feb 21, 2018 at 9:29 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> Ensure the translation happens by failing to read or write
>>> posix acls when the filesystem has not indicated it supports
>>> posix acls.
>>
>> For the first iteration this is fine, but  we could convert the raw
>> xattrs as well, if we later want to, right?
>
> I will say maybe.  This is tricky.   The code would not be too hard,
> and the function to do the work posix_acl_fix_xattr_userns already
> exists in fs/posix_acl.c
>
> I don't actually expect that to work longterm.  I expect the direction
> the kernel internals are moving is that all filesystems that implement
> posix acls will be expected to implement .get_acl and .set_acl.
>
> I would have to reread the old thread that got us to this point with
> posix acls before I could really understand the backwards compatible
> fuse use case, and I would have to reread the rest of the acl processing
> in the kernel before I could recall exactly what makes sense.
>
> If there was an obvious way to whitelist xattrs that fuse can support
> for user namespaces I think I would go for that.  Just to avoid future
> problems with future xattrs.

I am remembering why this is such a sticky issue.

Today when a posix acl is read from user space the code does:
      posix_acl_to_xattr(&init_user_ns, ...) in posix_acl_xattr_get
      posix_acl_fix_xattr_to_user() in getxattr

Similary when a posix acl is written from user space the code does:
      posix_acl_fix_xattr_from_user() in setxattr
      posix_acl_from_xattr(&init_user_us, ...) in posix_acl_xattr_set

If every posix acl supporting filesystem in the kernel would use
posix_acl_access_xattr_handler and posix_acl_default_xattr_handler the
function posix_acl_fix_xattr_to_user and posix_acl_fix_xattr_from_user
and posix_acl_fix_xattr_userns could all be removed and the posix acl
handling could be that little bit simpler and faster.

So if we could figure out how to use the generic acl support for the old
brand of fuse filesystems that don't set FUSE_POSIX_ACL it would be much
easier to support them long term.

Eric
