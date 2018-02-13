Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeBMCSY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 21:18:24 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:57846 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeBMCSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 21:18:22 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <8a85cfae-0c26-e50c-9b26-582802a7f3eb@infradead.org>
Date: Mon, 12 Feb 2018 20:18:02 -0600
In-Reply-To: <8a85cfae-0c26-e50c-9b26-582802a7f3eb@infradead.org> (Randy
        Dunlap's message of "Mon, 12 Feb 2018 13:18:38 -0800")
Message-ID: <87tvul4opx.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1elQAm-000398-5b;;;mid=<87tvul4opx.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194rIrCHUsXmgJTrq6Td2e/fuQ4DRcBj6c=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Randy Dunlap <rdunlap@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 384 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (0.7%), b_tie_ro: 1.88 (0.5%), parse: 1.01 (0.3%),
        extract_message_metadata: 19 (4.9%), get_uri_detail_list: 1.57 (0.4%),
        tests_pri_-1000: 10 (2.6%), tests_pri_-950: 1.36 (0.4%), tests_pri_-900: 0.98
        (0.3%), tests_pri_-400: 19 (5.0%), check_bayes: 18 (4.7%), b_tokenize: 6
        (1.6%), b_tok_get_all: 6 (1.4%), b_comp_prob: 1.65 (0.4%), b_tok_touch_all:
        2.8 (0.7%), b_finish: 0.65 (0.2%), tests_pri_0: 141 (36.7%),
        check_dkim_signature: 0.47 (0.1%), check_dkim_adsp: 2.5 (0.7%),
        tests_pri_500: 186 (48.5%), poll_dns_idle: 180 (47.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] fs/signalfd: fix build error for BUS_MCEERR_AR
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build error in fs/signalfd.c by using same method that is used in
> kernel/signal.c: separate blocks for different signal si_code values.
>
> ./fs/signalfd.c: error: 'BUS_MCEERR_AR' undeclared (first use in this function)
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Do you want to me to pick this one up?  Or does it have another path
into mainline?

Eric

> ---
>  fs/signalfd.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> Applies to mainline 4.16-rc1.
>
> --- linux-next-20180212.orig/fs/signalfd.c
> +++ linux-next-20180212/fs/signalfd.c
> @@ -118,13 +118,22 @@ static int signalfd_copyinfo(struct sign
>  		err |= __put_user(kinfo->si_trapno, &uinfo->ssi_trapno);
>  #endif
>  #ifdef BUS_MCEERR_AO
> -		/* 
> +		/*
>  		 * Other callers might not initialize the si_lsb field,
>  		 * so check explicitly for the right codes here.
>  		 */
>  		if (kinfo->si_signo == SIGBUS &&
> -		    (kinfo->si_code == BUS_MCEERR_AR ||
> -		     kinfo->si_code == BUS_MCEERR_AO))
> +		     kinfo->si_code == BUS_MCEERR_AO)
> +			err |= __put_user((short) kinfo->si_addr_lsb,
> +					  &uinfo->ssi_addr_lsb);
> +#endif
> +#ifdef BUS_MCEERR_AR
> +		/*
> +		 * Other callers might not initialize the si_lsb field,
> +		 * so check explicitly for the right codes here.
> +		 */
> +		if (kinfo->si_signo == SIGBUS &&
> +		    kinfo->si_code == BUS_MCEERR_AR)
>  			err |= __put_user((short) kinfo->si_addr_lsb,
>  					  &uinfo->ssi_addr_lsb);
>  #endif
