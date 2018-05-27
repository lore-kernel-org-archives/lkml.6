Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033005AbeE0SaO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 14:30:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:53659 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeE0SaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 14:30:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180525101455.GI4828@sirena.org.uk>
Date: Sun, 27 May 2018 13:29:55 -0500
In-Reply-To: <20180525101455.GI4828@sirena.org.uk> (Mark Brown's message of
        "Fri, 25 May 2018 11:14:55 +0100")
Message-ID: <876039uf30.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fN0Qh-0002bt-78;;;mid=<876039uf30.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+oOol4SMsdzN3Y0zFausRl+lY8eUGUouU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3024]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Mark Brown <broonie@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 400 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.8%), b_tie_ro: 2.0 (0.5%), parse: 1.20 (0.3%),
        extract_message_metadata: 4.5 (1.1%), get_uri_detail_list: 1.93 (0.5%),
        tests_pri_-1000: 6 (1.5%), tests_pri_-950: 2.0 (0.5%), tests_pri_-900: 1.60
        (0.4%), tests_pri_-400: 27 (6.8%), check_bayes: 25 (6.3%), b_tokenize: 10
        (2.4%), b_tok_get_all: 6 (1.6%), b_comp_prob: 3.7 (0.9%), b_tok_touch_all:
        2.6 (0.6%), b_finish: 0.80 (0.2%), tests_pri_0: 327 (81.6%),
        check_dkim_signature: 0.84 (0.2%), check_dkim_adsp: 5.0 (1.2%),
        tests_pri_500: 6 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux-next: manual merge of the userns tree with the arm tree
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> Hi Eric,
>
> Yesterday's linux-next merge of the userns tree got a conflict in:
>
>   arch/arm/mm/fault.c
>
> between commit:
>
>   8d9267cedb9e1d8edb8 ("ARM: spectre-v2: harden user aborts in kernel space")
>
> from the arm tree and commit:
>
>   3eb0f5193b497083391 ("signal: Ensure every siginfo we send has all bits initialized")
>
> from the userns tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Mark.  Did you get a bounce from this email?

I saw this when perusing lkml but I did not receive a copy of this
directly to myself.

Eric

> diff --cc arch/arm/mm/fault.c
> index 3b1ba003c4f9,32034543f49c..000000000000
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@@ -163,9 -163,8 +163,11 @@@ __do_user_fault(struct task_struct *tsk
>   {
>   	struct siginfo si;
>   
> + 	clear_siginfo(&si);
> + 
>  +	if (addr > TASK_SIZE)
>  +		harden_branch_predictor();
>  +
>   #ifdef CONFIG_DEBUG_USER
>   	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
>   	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
