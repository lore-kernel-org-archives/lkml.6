Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeC1Sda (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:33:30 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51954 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeC1Sd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:33:28 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180328184125.3dbcfbf5@canb.auug.org.au>
Date: Wed, 28 Mar 2018 13:32:25 -0500
In-Reply-To: <20180328184125.3dbcfbf5@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 28 Mar 2018 18:41:25 +1100")
Message-ID: <87efk4aw5i.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f1Ft0-0001Ep-DF;;;mid=<87efk4aw5i.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+amowMDpnpG+9+v+hA0ZYWAFFwnR4B44I=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Stephen Rothwell <sfr@canb.auug.org.au>
X-Spam-Relay-Country: 
X-Spam-Timing: total 727 ms - load_scoreonly_sql: 0.22 (0.0%),
        signal_user_changed: 10 (1.4%), b_tie_ro: 8 (1.1%), parse: 1.80 (0.2%),
        extract_message_metadata: 31 (4.3%), get_uri_detail_list: 2.6 (0.4%),
        tests_pri_-1000: 11 (1.6%), tests_pri_-950: 2.8 (0.4%), tests_pri_-900: 2.2
        (0.3%), tests_pri_-400: 33 (4.5%), check_bayes: 30 (4.2%), b_tokenize: 11
        (1.5%), b_tok_get_all: 8 (1.2%), b_comp_prob: 4.5 (0.6%), b_tok_touch_all:
        2.7 (0.4%), b_finish: 0.85 (0.1%), tests_pri_0: 335 (46.1%),
        check_dkim_signature: 1.08 (0.1%), check_dkim_adsp: 4.9 (0.7%),
        tests_pri_500: 293 (40.3%), poll_dns_idle: 279 (38.4%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: linux-next: build failure after merge of the userns tree
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Eric,
>
> After merging the userns tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>
> In file included from include/linux/sched.h:16:0,
>                  from arch/powerpc/lib/xor_vmx_glue.c:14:
> include/linux/shm.h:17:35: error: 'struct file' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>  bool is_file_shm_hugepages(struct file *file);
>                                    ^~~~
>
> and many, many more (most warnings, but some errors - arch/powerpc is
> mostly built with -Werror)
>
> Maybe caused by commit
>
>   1a5c1349d105 ("sem: Move struct sem and struct sem_array into ipc/sem.c")
>
> I have appplied the following fix patch for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 28 Mar 2018 18:36:27 +1100
> Subject: [PATCH] fix up for struct file no longer being available in shm.h
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied.  With the addition of:

> I dug through this and I discovered that the error was caused by the
> removal of struct shmid_kernel from shm.h when building on powerpc.
> Except for observing the existence of "struct file *shm_file" in
> struct shmid_kernel I have no clue why the structure move would
> cause such a failure.  I suspect shm.h always needed the forward
> declaration and someting had been confusing gcc into not issuing the
> warning. --EWB
> 
> Fixes: a2e102cd3cdd ("shm: Move struct shmid_kernel into ipc/shm.c")

Has anyone ever seen anything like that?

Eric
