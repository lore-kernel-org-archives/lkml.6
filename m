Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeDETS2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:18:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39991 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeDETS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:18:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Banerjee\, Debabrata" <dbanerje@akamai.com>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@free.fr>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20180405171502.14347-1-dbanerje@akamai.com>
        <31CF3F25-8A82-426B-BFA0-6225C39334F5@akamai.com>
Date: Thu, 05 Apr 2018 14:17:15 -0500
In-Reply-To: <31CF3F25-8A82-426B-BFA0-6225C39334F5@akamai.com> (Debabrata
        Banerjee's message of "Thu, 5 Apr 2018 18:23:16 +0000")
Message-ID: <87h8op79ac.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1f4AOt-0001kh-PZ;;;mid=<87h8op79ac.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+jbu2daZs2Df7HEVgV8YBCOa4hCwLF+gM=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Banerjee\, Debabrata" <dbanerje@akamai.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1215 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 3.7 (0.3%), b_tie_ro: 2.7 (0.2%), parse: 1.42 (0.1%),
        extract_message_metadata: 22 (1.8%), get_uri_detail_list: 3.6 (0.3%),
        tests_pri_-1000: 7 (0.6%), tests_pri_-950: 1.69 (0.1%), tests_pri_-900: 1.38
        (0.1%), tests_pri_-400: 30 (2.5%), check_bayes: 28 (2.3%), b_tokenize: 11
        (0.9%), b_tok_get_all: 8 (0.7%), b_comp_prob: 3.4 (0.3%), b_tok_touch_all:
        3.2 (0.3%), b_finish: 0.73 (0.1%), tests_pri_0: 316 (26.0%),
        check_dkim_signature: 0.66 (0.1%), check_dkim_adsp: 4.0 (0.3%),
        tests_pri_500: 828 (68.1%), poll_dns_idle: 819 (67.4%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] Fix /proc/[pid]/ns permissions
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Banerjee, Debabrata" <dbanerje@akamai.com> writes:

> Actually, this patch is incomplete. proc_ns_get_link() and
> proc_ns_readlink() gate on ptrace_may_access(task,
> PTRACE_MODE_READ_FSCREDS).  I'm not sure why this is here either. It
> seems problematic that after a user creates a pid namespace, that a
> user cannot tell anymore which namespace new pids belongs to,
> including the parent namespace after prctl(). Some mechanism is
> required here. If ns->inum from ns_get_name() is secret, then at least
> a flag if it is in your namespace.

> ﻿On 4/5/18, 1:15 PM, "Debabrata Banerjee" <dbanerje@akamai.com> wrote:
>
>     This seems like a bug since the original commit 6b4e306aa3dc. Having ns
>     directory be executable but not readable does not make sense. Further,
>     it breaks userspace when it needs to know which namespace it belongs
>     to. For example, setting a process to prctl(PR_SET_DUMPABLE, 0)
>     immediately hides the namespace from that user, breaking the latest
>     pgrep with namespace support.
>     
>     The main problem here is that unlike other namespaces, pid namespaces
>     appear flat as you follow the parents upwards in the heirarchy. It is
>     important to be able to tell that a process is in your namespace, a
>     child namespace, or an entirely different namespace. In the latter
>     case, the pid is already hidden from you, thus these permission don't
>     matter.

I agree there is an inconsistency on the directory permissions for
the ns directory that could reasonably be fixed.

prctl(PR_SET_DUMPABLE, 0) is an interesting.  Fundamentally it is about not
letting unprivileged tasks poke about with the process, and it is the
mechanism used by setuid/setgid exec.   If you are root in the user
namespace of the task or your uid created the user namespace or an
ancestor user namespace you should be able to inspect the process.

What happens with dumpable is also going to vary a little bit depending
on how recent your kernel is.  The dumpable status was not really
namespaced until recently.

There might also be some issues from yama or other lsms that love to
limit ptrace.  Though it sounds like your issue is the dumpability.

The check "ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)" is the
standard check for accessing anything even a little bit sensitive of
a process, and that seems appropriate here.

Eric

>     
>     CC: Eric W. Biederman <ebiederm@xmission.com>
>     CC: Daniel Lezcano <daniel.lezcano@free.fr>
>     
>     Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
>     ---
>      fs/proc/base.c | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
>     
>     diff --git a/fs/proc/base.c b/fs/proc/base.c
>     index d53246863cfb..2295ac0d8e1c 100644
>     --- a/fs/proc/base.c
>     +++ b/fs/proc/base.c
>     @@ -2922,7 +2922,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>      	DIR("fd",         S_IRUSR|S_IXUSR, proc_fd_inode_operations, proc_fd_operations),
>      	DIR("map_files",  S_IRUSR|S_IXUSR, proc_map_files_inode_operations, proc_map_files_operations),
>      	DIR("fdinfo",     S_IRUSR|S_IXUSR, proc_fdinfo_inode_operations, proc_fdinfo_operations),
>     -	DIR("ns",	  S_IRUSR|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
>     +	DIR("ns",	  S_IRUGO|S_IXUGO, proc_ns_dir_inode_operations, proc_ns_dir_operations),
>      #ifdef CONFIG_NET
>      	DIR("net",        S_IRUGO|S_IXUGO, proc_net_inode_operations, proc_net_operations),
>      #endif
>     -- 
>     2.16.2
>     
>     
