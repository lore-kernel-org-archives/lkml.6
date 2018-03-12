Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932366AbeCLUYe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:24:34 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58420 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeCLUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:24:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180223035814.GZ30522@ZenIV.linux.org.uk>
        <20180223040814.GA30522@ZenIV.linux.org.uk>
        <87h8q7erlo.fsf@linutronix.de>
        <20180223150928.GC30522@ZenIV.linux.org.uk>
        <20180223174216.GD30522@ZenIV.linux.org.uk>
        <20180223201317.GG30522@ZenIV.linux.org.uk>
        <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
        <20180224002248.GH30522@ZenIV.linux.org.uk>
        <20180225073950.GI30522@ZenIV.linux.org.uk>
        <87bmgbnhar.fsf_-_@linutronix.de>
        <20180312191351.GN30522@ZenIV.linux.org.uk>
Date: Mon, 12 Mar 2018 15:23:44 -0500
In-Reply-To: <20180312191351.GN30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Mon, 12 Mar 2018 19:13:51 +0000")
Message-ID: <877eqhcab3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evTzi-0005pj-CA;;;mid=<877eqhcab3.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18pzq83wG0ZPo11whsQArgLKWf8uVXgjl8=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@ZenIV.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 347 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 2.9 (0.8%), b_tie_ro: 1.96 (0.6%), parse: 0.81 (0.2%),
        extract_message_metadata: 12 (3.6%), get_uri_detail_list: 2.5 (0.7%),
        tests_pri_-1000: 6 (1.6%), tests_pri_-950: 0.97 (0.3%), tests_pri_-900: 0.77
        (0.2%), tests_pri_-400: 26 (7.4%), check_bayes: 25 (7.1%), b_tokenize: 8
        (2.4%), b_tok_get_all: 9 (2.6%), b_comp_prob: 2.7 (0.8%), b_tok_touch_all:
        3.1 (0.9%), b_finish: 0.50 (0.1%), tests_pri_0: 228 (65.9%),
        check_dkim_signature: 0.46 (0.1%), check_dkim_adsp: 3.3 (1.0%),
        tests_pri_500: 66 (19.1%), poll_dns_idle: 58 (16.6%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent() breakage when used from shrink_dentry_list())
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Tue, Feb 27, 2018 at 06:16:28AM +0100, John Ogness wrote:
>
>> If someone else has grabbed a reference, it shouldn't be added to the
>> lru list. Only decremented.
>> 
>> if (entry->d_lockref.count == 1)
>
> Nah, better handle that in retain_dentry() itself.  See updated
> #work.dcache.
>
> Note: another potentially fun thing in that branch is that I've
> finally decided to bite the bullet and make __d_move() preserve
> ->d_parent of target.
>
> Mainline:
> al@sonny:/tmp$ touch d
> al@sonny:/tmp$ sleep 100 >/tmp/a/b/c &
> [1] 16487
> al@sonny:/tmp$ ls -l /proc/16487/fd
> total 0
> lrwx------ 1 al al 64 Mar 12 11:33 0 -> /dev/pts/13
> l-wx------ 1 al al 64 Mar 12 11:33 1 -> /tmp/a/b/c
> lrwx------ 1 al al 64 Mar 12 11:33 2 -> /dev/pts/13
> al@sonny:/tmp$ mv /tmp/d /tmp/a/b/c 
> al@sonny:/tmp$ ls -l /proc/16487/fd
> total 0
> lrwx------ 1 al al 64 Mar 12 11:33 0 -> /dev/pts/13
> l-wx------ 1 al al 64 Mar 12 11:33 1 -> /tmp/c (deleted)
> lrwx------ 1 al al 64 Mar 12 11:33 2 -> /dev/pts/13
>
> With that branch:
> root@kvm1:/tmp# touch d
> root@kvm1:/tmp# sleep 100 >/tmp/a/b/c &
> [1] 2263
> root@kvm1:/tmp# ls -l /proc/2263/fd
> total 0
> lrwx------ 1 root root 64 Mar 12 11:33 0 -> /dev/pts/0
> l-wx------ 1 root root 64 Mar 12 11:33 1 -> /tmp/a/b/c
> lrwx------ 1 root root 64 Mar 12 11:33 2 -> /dev/pts/0
> root@kvm1:/tmp# mv /tmp/d /tmp/a/b/c
> root@kvm1:/tmp# ls -l /proc/2263/fd
> total 0
> lrwx------ 1 root root 64 Mar 12 11:33 0 -> /dev/pts/0
> l-wx------ 1 root root 64 Mar 12 11:33 1 -> '/tmp/a/b/c (deleted)'
> lrwx------ 1 root root 64 Mar 12 11:33 2 -> /dev/pts/0
>
> It doesn't come quite for free; cross-directory d_move()
> and d_exchange() callers are responsible for having both
> parents pinned (all of them do that, mostly since the usual
> sequence is "look parents up, lock_rename(), *then* look
> children up, then do renaming"; those that are not part of
> rename(2) are also OK) and d_splice_alias() has become potentially
> blocking in one case.  AFAICS, none of the callers is in
> locking environment that would not allow that.  Survives
> the local beating and doesn't seem to cause any performance
> regressions.
>
> What we get out of that is
> 	a) much saner semantics for d_move() et.al.
> 	b) saner behaviour of d_path() (see above)
> 	c) dentry can be IS_ROOT only if it has been
> such all along; that simplifies the hell out of analysis.
>
> FWIW, there's another trylock loop on dentries - one in
> autofs get_next_positive_dentry().  Any plans re dealing
> with that one?
>
> I'd spent the last couple of weeks (when not being too sick
> for any work) going through dcache.c and related code; hopefully
> this time I will get the documentation into postable shape ;-/
>
> There's an unpleasant area around the ->s_root vs. NFS.  There's
> code that makes assumptions about ->s_root that are simply not true
> for NFS.  Is path_connected() correct wrt NFS multiple imports from
> the same server? Ditto for mnt_already_visible() (that one might
> be mitigated at the moment, but probably won't last).  Eric, am
> I missing something subtle in there?

I don't have the entire context in my head.  But I don't think we
have problems today.

NFS before it uses paths from an unconnected root in the rest of
the vfs walks those paths backwards and makes the paths connect.
I don't remember where all of that code that performs those connections
but I do remember the code in fs/fhandle.c shares that code with nfs, to
perform the same operation in open_by_handle_at.

So I don't think the nfs peculiarities are actually relevant to
anything on an ordinary code path.


Of the two code paths you are concert about:

For path path_connected looking at s_root is a heuristic to avoid
calling is_subdir every time we need to do that check.  If the heuristic
fails we still have is_subdir which should remain accurate.  If
is_subdir fails the path is genuinely not connected at that moment
and failing is the correct thing to do.


For mnt_too_revealing the only filesystems under consideration are
proc and sysfs.   So nfs oddities are of no consequence.
mnt_too_revealing probably won't be extended to other filesystems.
Certainly nfs is not a candidate for having setting SB_I_USERNS_VISIBLE.


Al is that sufficient to address your concerns?

Eric
