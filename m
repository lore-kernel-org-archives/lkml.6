Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeBSW5Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 17:57:24 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:51303 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeBSW5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 17:57:22 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Dongsu Park <dongsu@kinvolk.io>, lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <61a37f0b159dd56825696d8d3beb8eaffdf1f72f.1512041070.git.dongsu@kinvolk.io>
        <CAOssrKeSTY1pAhpmegFWdGh7irNbT4veG5JaYFj8Q1JjMynadw@mail.gmail.com>
Date: Mon, 19 Feb 2018 16:56:56 -0600
In-Reply-To: <CAOssrKeSTY1pAhpmegFWdGh7irNbT4veG5JaYFj8Q1JjMynadw@mail.gmail.com>
        (Miklos Szeredi's message of "Wed, 14 Feb 2018 13:28:12 +0100")
Message-ID: <87mv04mvuv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1enuN6-00028G-Kb;;;mid=<87mv04mvuv.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19p8dqWSB+bJ3PmBuoZvZQPIEgJRBx/rwk=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 271 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 4.0 (1.5%), b_tie_ro: 2.9 (1.1%), parse: 1.40 (0.5%),
        extract_message_metadata: 23 (8.6%), get_uri_detail_list: 2.8 (1.0%),
        tests_pri_-1000: 12 (4.4%), tests_pri_-950: 1.75 (0.6%), tests_pri_-900: 1.48
        (0.5%), tests_pri_-400: 22 (8.2%), check_bayes: 21 (7.7%), b_tokenize: 8
        (2.9%), b_tok_get_all: 6 (2.2%), b_comp_prob: 2.4 (0.9%), b_tok_touch_all:
        2.3 (0.8%), b_finish: 0.71 (0.3%), tests_pri_0: 137 (50.7%),
        check_dkim_signature: 0.56 (0.2%), check_dkim_adsp: 3.0 (1.1%),
        tests_pri_500: 63 (23.2%), poll_dns_idle: 54 (20.1%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 07/11] fs: Allow CAP_SYS_ADMIN in s_user_ns to freeze and thaw filesystems
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
>> From: Seth Forshee <seth.forshee@canonical.com>
>>
>> The user in control of a super block should be allowed to freeze
>> and thaw it. Relax the restrictions on the FIFREEZE and FITHAW
>> ioctls to require CAP_SYS_ADMIN in s_user_ns.
>
> Why is this required for unprivileged fuse?
>
> Fuse doesn't support freeze, so this seems to make no sense in the
> context of this patchset.

This isn't required to support fuse.  It is a relaxation in permissions
so it isn't strictly necessary for anything.

Until just recently Seth and I work working through the vfs looking at
what we need in general for unprivileged mounts.  With fuse as our focus
but we were not limiting ourselves to fuse.

I have been putting off relaxation of permissions like this because they
are not necessary for safety.  But in general they do make sense.

In practice I think all we need to worry about for fuse is the last 4 patches.


Eric
