Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbeBZVvx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:51:53 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:37338 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBZVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:51:51 -0500
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
        <87inao6dfa.fsf@xmission.com> <87mv004p0t.fsf@xmission.com>
        <CAOssrKd+c0Mx+=S-+zr1QS8a37Pm=VGki=FVR+LXQZBsk3byqA@mail.gmail.com>
        <87zi3v1zga.fsf@xmission.com>
Date: Mon, 26 Feb 2018 15:51:16 -0600
In-Reply-To: <87zi3v1zga.fsf@xmission.com> (Eric W. Biederman's message of
        "Mon, 26 Feb 2018 10:35:17 -0600")
Message-ID: <87lgff1ktn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eqQgX-0003Ox-BZ;;;mid=<87lgff1ktn.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19wiORoqZ4ShUda4JKFCt7F8hUGmUp64t4=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 195 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (1.3%), b_tie_ro: 1.79 (0.9%), parse: 1.02 (0.5%),
        extract_message_metadata: 10 (5.2%), get_uri_detail_list: 1.21 (0.6%),
        tests_pri_-1000: 6 (2.9%), tests_pri_-950: 1.13 (0.6%), tests_pri_-900: 0.96
        (0.5%), tests_pri_-400: 19 (9.7%), check_bayes: 18 (9.2%), b_tokenize: 6
        (2.9%), b_tok_get_all: 6 (3.1%), b_comp_prob: 1.85 (1.0%), b_tok_touch_all:
        2.5 (1.3%), b_finish: 0.64 (0.3%), tests_pri_0: 145 (74.4%),
        check_dkim_signature: 0.64 (0.3%), check_dkim_adsp: 2.4 (1.3%),
        tests_pri_500: 7 (3.5%), rewrite_mail: 0.00 (0.0%)
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
>> On Thu, Feb 22, 2018 at 11:50 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>
>>> So if we could figure out how to use the generic acl support for the old
>>> brand of fuse filesystems that don't set FUSE_POSIX_ACL it would be much
>>> easier to support them long term.
>>
>> Simplest and most robust way seems to be to do everything the same (as
>> with FUSE_POSIX_ACL) but tell the vfs not to cache the acl.
>
> Good point.  That sounds like for the !fc->posix_acl case we just
> need a careful use of "forget_all_cached_acls(inode)".
>
> I will take a quick look at that, and see if that is easy/sufficient to
> cover the legacy fuse case.  Otherwise I will go with what I already
> have here.
>
> That feels like a better path.  And internally I would call what is
> today fc->posix_acl fc->cached_posix_acl.  To better convey the intent.
> Fingers crossed.

It looks like simply setting
"inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE;" is the secret
sauce needed to disable caching in the legacy case and make everything
work.

I had to tweak the calls to forget_all_cached_acls so that won't clear
the ACL_DONT_CACHE status but otherwise that was an absolutely trivial
change to combine those two code paths.

I will post my updated patches shortly.

Eric
