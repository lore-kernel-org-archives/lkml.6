Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeBVTTE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:19:04 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:37192 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeBVTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:19:02 -0500
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
Date: Thu, 22 Feb 2018 13:18:33 -0600
In-Reply-To: <CAOssrKeNLBeMkMrrCeRBO9Z80zFxCCEygKL3DErnQ9xBoLkH0g@mail.gmail.com>
        (Miklos Szeredi's message of "Thu, 22 Feb 2018 12:40:18 +0100")
Message-ID: <87inao6dfa.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eowOS-0001Y1-KQ;;;mid=<87inao6dfa.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+SFVSLBzenQTZACdnxye1HsPTEJHh/H5A=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4945]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 380 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.6%), b_tie_ro: 1.59 (0.4%), parse: 0.72 (0.2%),
        extract_message_metadata: 9 (2.4%), get_uri_detail_list: 1.03 (0.3%),
        tests_pri_-1000: 6 (1.5%), tests_pri_-950: 1.17 (0.3%), tests_pri_-900: 1.01
        (0.3%), tests_pri_-400: 18 (4.7%), check_bayes: 17 (4.4%), b_tokenize: 5
        (1.4%), b_tok_get_all: 6 (1.5%), b_comp_prob: 1.77 (0.5%), b_tok_touch_all:
        2.1 (0.6%), b_finish: 0.51 (0.1%), tests_pri_0: 335 (88.1%),
        check_dkim_signature: 0.45 (0.1%), check_dkim_adsp: 2.8 (0.7%),
        tests_pri_500: 4.8 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v6 4/5] fuse: Ensure posix acls are translated outside of init_user_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Wed, Feb 21, 2018 at 9:29 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Ensure the translation happens by failing to read or write
>> posix acls when the filesystem has not indicated it supports
>> posix acls.
>
> For the first iteration this is fine, but  we could convert the raw
> xattrs as well, if we later want to, right?

I will say maybe.  This is tricky.   The code would not be too hard,
and the function to do the work posix_acl_fix_xattr_userns already
exists in fs/posix_acl.c

I don't actually expect that to work longterm.  I expect the direction
the kernel internals are moving is that all filesystems that implement
posix acls will be expected to implement .get_acl and .set_acl.

I would have to reread the old thread that got us to this point with
posix acls before I could really understand the backwards compatible
fuse use case, and I would have to reread the rest of the acl processing
in the kernel before I could recall exactly what makes sense.

If there was an obvious way to whitelist xattrs that fuse can support
for user namespaces I think I would go for that.  Just to avoid future
problems with future xattrs.

Eric
