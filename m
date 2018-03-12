Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbeCLX30 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:29:26 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47871 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeCLX3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:29:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <87h8q7erlo.fsf@linutronix.de>
        <20180223150928.GC30522@ZenIV.linux.org.uk>
        <20180223174216.GD30522@ZenIV.linux.org.uk>
        <20180223201317.GG30522@ZenIV.linux.org.uk>
        <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
        <20180224002248.GH30522@ZenIV.linux.org.uk>
        <20180225073950.GI30522@ZenIV.linux.org.uk>
        <87bmgbnhar.fsf_-_@linutronix.de>
        <20180312191351.GN30522@ZenIV.linux.org.uk>
        <877eqhcab3.fsf@xmission.com>
        <20180312203916.GQ30522@ZenIV.linux.org.uk>
Date: Mon, 12 Mar 2018 18:28:30 -0500
In-Reply-To: <20180312203916.GQ30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Mon, 12 Mar 2018 20:39:17 +0000")
Message-ID: <87woygan6p.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evWsW-0004PY-NY;;;mid=<87woygan6p.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+RCrmjMDGPHDzCopy4lbBKsbJHvEEjCvg=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@ZenIV.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 508 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.6%), b_tie_ro: 2.1 (0.4%), parse: 1.32 (0.3%),
        extract_message_metadata: 25 (4.9%), get_uri_detail_list: 2.6 (0.5%),
        tests_pri_-1000: 12 (2.3%), tests_pri_-950: 2.3 (0.4%), tests_pri_-900: 1.93
        (0.4%), tests_pri_-400: 31 (6.1%), check_bayes: 29 (5.7%), b_tokenize: 11
        (2.2%), b_tok_get_all: 8 (1.5%), b_comp_prob: 4.1 (0.8%), b_tok_touch_all:
        2.6 (0.5%), b_finish: 0.85 (0.2%), tests_pri_0: 417 (82.0%),
        check_dkim_signature: 0.90 (0.2%), check_dkim_adsp: 4.8 (0.9%),
        tests_pri_500: 9 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent() breakage when used from shrink_dentry_list())
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Mon, Mar 12, 2018 at 03:23:44PM -0500, Eric W. Biederman wrote:
>
>> Of the two code paths you are concert about:
>> 
>> For path path_connected looking at s_root is a heuristic to avoid
>> calling is_subdir every time we need to do that check.  If the heuristic
>> fails we still have is_subdir which should remain accurate.  If
>> is_subdir fails the path is genuinely not connected at that moment
>> and failing is the correct thing to do.
>  
> Umm...  That might be not good enough - the logics is "everything's
> reachable from ->s_root anyway, so we might as well not bother checking".
> For NFS it's simply not true.

If I am parsing the code correctly path_connected is broken for nfsv2
and nfsv3 when NFS_MOUNT_UNSHARED is not set.   nfsv4 appears to make
a kernel mount of the real root of the filesystem properly setting
s_root and then finds the child it is mounting.

> We can mount server:/foo/bar/baz on /tmp/a, then server:/foo on /tmp/b
> and we'll have ->s_root pointing to a subtree of what's reachable at
> /tmp/b.  Play with renames under /tmp/b and you just might end up with
> a problem.  And mount on /tmp/a will be (mistakenly) considered to
> be safe, since it satisfies the heuristics in path_connected().

Agreed.

Which means that if you mount server:/foo/bar/baz first and then
mount server:/foo with an appropriate rename you might be able
to see all of server:/foo or possibly server:/

Hmm..

Given that nfs_kill_super calls generic_shutdown_super and
generic_shutdown_super calls shrink_dcache_for_umount
I would argue that nfsv2 and nfsv3 are buggy in the same
case, as shrink_dcache_for_umount is called on something
that is not the root of the filesystem's dentry tree.

Eric
