Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752701AbeDEAAU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:00:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39828 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbeDEAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:00:18 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: alban.crequy@gmail.com, linux-kernel@vger.kernel.org
References: <20180404174909.GB2540@avx2>
Date: Wed, 04 Apr 2018 18:59:08 -0500
In-Reply-To: <20180404174909.GB2540@avx2> (Alexey Dobriyan's message of "Wed,
        4 Apr 2018 20:49:09 +0300")
Message-ID: <87k1tmed6b.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3sK8-0006gG-9a;;;mid=<87k1tmed6b.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+nHnl3DYLXyoJegb2k8iEmskhxhYZ9urY=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4956]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexey Dobriyan <adobriyan@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1152 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.5 (0.3%), b_tie_ro: 2.5 (0.2%), parse: 1.14 (0.1%),
        extract_message_metadata: 3.8 (0.3%), get_uri_detail_list: 1.26 (0.1%),
        tests_pri_-1000: 4.1 (0.4%), tests_pri_-950: 1.31 (0.1%), tests_pri_-900:
        1.00 (0.1%), tests_pri_-400: 16 (1.4%), check_bayes: 15 (1.3%), b_tokenize:
        4.4 (0.4%), b_tok_get_all: 5 (0.5%), b_comp_prob: 1.69 (0.1%),
        b_tok_touch_all: 2.2 (0.2%), b_finish: 0.67 (0.1%), tests_pri_0: 1106 (96.0%),
         check_dkim_signature: 0.53 (0.0%), check_dkim_adsp: 3.7 (0.3%),
        tests_pri_500: 6 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc mounts when not fully visible
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

>> The only option I have seen proposed that might qualify as something
>> general purpose and simple is a new filesystem that is just the process
>> directories of proc.
>
> While "mount -t pid" and "mount -t sysctl" are decades overdue, I don't
> think they cover everything.
>
> IIRC some gcc versions read /proc/meminfo on every invocation. Now
> imagine such program doesn't have a fallback if /proc/ doesn't exist
> (how many thousands such programs are there?) So user is going to ask
> for /proc with just /proc/meminfo only. At this point it is back to
> nearly full /proc.

To avoid falling susceptible to the kinds of checks in fs_fully_visible we
can only offer information about objects that root in the user namespace
has privilege over.  So "mount -t pid" good.  A "/proc/meminfo" bad.

Which in short means if "mount -t pid" isn't good enough.  There really
isn't anything the kernel can do.

Eric
