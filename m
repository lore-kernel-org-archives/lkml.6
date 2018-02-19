Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeBSXKT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:10:19 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:52614 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeBSXKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:10:17 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alban Crequy <alban@kinvolk.io>
Cc: Dongsu Park <dongsu@kinvolk.io>, LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <877etbcmnd.fsf@xmission.com>
        <CANxcAMvwwiPXBTKmTM9sEo8Y1T--V7fNaFqzHfyEvwvaYQV60A@mail.gmail.com>
        <CADZs7q438szfwd-kaaRDnpDFrmno3zy7Zq+6EsnotW8bS0vrTA@mail.gmail.com>
Date: Mon, 19 Feb 2018 17:09:51 -0600
In-Reply-To: <CADZs7q438szfwd-kaaRDnpDFrmno3zy7Zq+6EsnotW8bS0vrTA@mail.gmail.com>
        (Alban Crequy's message of "Thu, 18 Jan 2018 15:58:41 +0100")
Message-ID: <87inaslgow.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1enuZc-0004MJ-4K;;;mid=<87inaslgow.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++3tYHyrQJtR+KTLPbPhBiEytY3F7bILY=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4037]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alban Crequy <alban@kinvolk.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 188 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (2.4%), b_tie_ro: 3.2 (1.7%), parse: 1.06 (0.6%),
        extract_message_metadata: 12 (6.5%), get_uri_detail_list: 1.45 (0.8%),
        tests_pri_-1000: 7 (3.7%), tests_pri_-950: 1.03 (0.5%), tests_pri_-900: 0.89
        (0.5%), tests_pri_-400: 26 (13.8%), check_bayes: 25 (13.2%), b_tokenize: 4.8
        (2.5%), b_tok_get_all: 9 (4.9%), b_comp_prob: 1.58 (0.8%), b_tok_touch_all:
        2.9 (1.6%), b_finish: 0.92 (0.5%), tests_pri_0: 129 (68.5%),
        check_dkim_signature: 0.38 (0.2%), check_dkim_adsp: 3.0 (1.6%),
        tests_pri_500: 3.7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5 00/11] FUSE mounts from non-init user namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alban Crequy <alban@kinvolk.io> writes:

> Hi Eric,
>
> Do you have some cycles for this now that it is the new year?
>
> A review on the associated ima issue would also be appreciated:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1587678.html

It has taken me longer than I expected but I do have time now.  I am
moving through these patches and issues a little slowly I do intend to
get us through the fuse issues this development cycle if at all
possible.

I think for starters we should restrict ourselves to the last 4 patches
aka (8, 9, 10, 11).

In particular we should concentrate on
[8/11] fuse: Support fuse filesystems outside of init_user_ns
[9/11] fuse: Restrict allow_other to the superblock's namespace or a descendant

The tricky issues are handled in the vfs, and I think the remaining
tricky issues are evm and ima.  Which are close enough to be resolved
that we can count them as resolved.

Once we have 8 & 9 reviewed and merged we can double check there isn't
some silly reason not to set FS_USERNS_MOUNT on fuse and then enable it.

I would like to double check and ensure there are not silly issues with
posix acls or anything else in the vfs.  But I think except for a silly
oversight we are good.

I should probably also add a patch that adds to
Documentation/filesystems that explains what the vfs does for
unprivileged mounts.  So that I can point people working on filesystems
and are thinking about enabling user namespace mounts at the
documentation for what the vfs does.  That would also provide a good
checklist to ensure the way the vfs handles things is sufficient for
fuse.

As for the earlier patches that enable things.  Overall they are
good.  They are slightly dangerous as they enable more code paths
to unprivileged users.  But mostly I think they are not immediately
necessary and as such a distraction to getting this code in.

That said once we get the fuse bits reviewed merged I will be more than
happy to merge the relaxation of permission checks that we can perform
now that s_user_ns exists.

Eric
