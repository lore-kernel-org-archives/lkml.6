Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbeBPWBU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 17:01:20 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:53747 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeBPWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 17:01:16 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Dongsu Park <dongsu@kinvolk.io>, lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <ac3d34002d7690f6ca5928b57b7fc4d707104b04.1512041070.git.dongsu@kinvolk.io>
        <CAOssrKcZeAHsRz7P_dxh==QAKnp7HeSTh4vWY2tgbWa1ZD918g@mail.gmail.com>
Date: Fri, 16 Feb 2018 16:00:53 -0600
In-Reply-To: <CAOssrKcZeAHsRz7P_dxh==QAKnp7HeSTh4vWY2tgbWa1ZD918g@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 13 Feb 2018 14:18:21 +0100")
Message-ID: <87a7w8siga.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1emo4A-0007Df-R6;;;mid=<87a7w8siga.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+VcUCbGjfe3uW9Gr3iZI1PbL00vgAlhU=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 260 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.0 (1.6%), b_tie_ro: 1.79 (0.7%), parse: 0.78 (0.3%),
        extract_message_metadata: 12 (4.7%), get_uri_detail_list: 1.50 (0.6%),
        tests_pri_-1000: 6 (2.5%), compile_eval: 0.14 (0.1%), tests_pri_-950: 1.13
        (0.4%), tests_pri_-900: 0.96 (0.4%), tests_pri_-400: 34 (13.2%), check_bayes:
        33 (12.7%), b_tokenize: 11 (4.2%), b_tok_get_all: 14 (5.3%), b_comp_prob: 3.3
        (1.3%), b_tok_touch_all: 2.4 (0.9%), b_finish: 0.65 (0.2%), tests_pri_0: 191
        (73.4%), check_dkim_signature: 0.55 (0.2%), check_dkim_adsp: 4.3 (1.6%),
        tests_pri_500: 6 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 03/11] fs: Allow superblock owner to change ownership of inodes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
>> From: Eric W. Biederman <ebiederm@xmission.com>
>>
>> Allow users with CAP_SYS_CHOWN over the superblock of a filesystem to
>> chown files.  Ordinarily the capable_wrt_inode_uidgid check is
>> sufficient to allow access to files but when the underlying filesystem
>> has uids or gids that don't map to the current user namespace it is
>> not enough, so the chown permission checks need to be extended to
>> allow this case.
>>
>> Calling chown on filesystem nodes whose uid or gid don't map is
>> necessary if those nodes are going to be modified as writing back
>> inodes which contain uids or gids that don't map is likely to cause
>> filesystem corruption of the uid or gid fields.
>
> How can the filesystem be corrupted if chown is denied?
>
> It is not clear to me what the purpose of this patch is or what the
> exact usecase this is fixing.

It isn't a fix and we can delay this one and similar patches
that enable things until we are certain all of the necessary
restrictions are in place.  This is not essential for safely getting
fully unprivileged mounting of fuse to work.

The overall strategy has been to handle as many of the generic concerns
at the vfs level as possible to separate filesystem concerns and generic
concerns.

In this case the generic concern is what happens when the uid is read
from the filesystem and it gets mapped to INVALID_UID and then the inode
for that file is written back.

That is a trap for the unwary filesystem implementation and not a case
that I think anyone will actually care about.  It is just not useful
to mount a filesystem and to not map some of it's ids.   So the generic
vfs code just denies writes to files like show with uid of INVALID_UID
or gid of INVALID_GID.  Just to ensure that problems don't show up.

This patch gets through those defenses.

Eric
