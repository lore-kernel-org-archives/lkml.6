Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754879AbeEaLvS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:51:18 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54149 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754822AbeEaLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:51:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        NeilBrown <neilb@suse.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180531064736.lnisb55eajwjynvk@kili.mountain>
Date: Thu, 31 May 2018 06:51:07 -0500
In-Reply-To: <20180531064736.lnisb55eajwjynvk@kili.mountain> (Dan Carpenter's
        message of "Thu, 31 May 2018 09:47:36 +0300")
Message-ID: <878t80f3h0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOM6q-0000xF-To;;;mid=<878t80f3h0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+FdEYNKe0lc6M4k6SYMtK+UMth9uJJ5Y4=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4957]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Dan Carpenter <dan.carpenter@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 213 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.4 (1.6%), b_tie_ro: 2.3 (1.1%), parse: 1.42 (0.7%),
        extract_message_metadata: 21 (9.7%), get_uri_detail_list: 1.92 (0.9%),
        tests_pri_-1000: 11 (5.3%), tests_pri_-950: 1.84 (0.9%), tests_pri_-900: 1.54
        (0.7%), tests_pri_-400: 22 (10.4%), check_bayes: 21 (9.7%), b_tokenize: 8
        (3.9%), b_tok_get_all: 5 (2.5%), b_comp_prob: 2.2 (1.0%), b_tok_touch_all:
        2.8 (1.3%), b_finish: 0.74 (0.3%), tests_pri_0: 138 (64.7%),
        check_dkim_signature: 0.63 (0.3%), check_dkim_adsp: 3.8 (1.8%),
        tests_pri_500: 9 (4.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] autofs: small cleanup in autofs_getpath()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> We don't set "*name" so it's slightly nicer to just pass "name" instead
> of "&name".
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

This seems like an obvious and reasonable cleanup.

> diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
> index 8c858126c751..f6385c6ef0a5 100644
> --- a/fs/autofs/waitq.c
> +++ b/fs/autofs/waitq.c
> @@ -179,7 +179,7 @@ static void autofs_notify_daemon(struct autofs_sb_info *sbi,
>  }
>  
>  static int autofs_getpath(struct autofs_sb_info *sbi,
> -			  struct dentry *dentry, char **name)
> +			  struct dentry *dentry, char *name)
>  {
>  	struct dentry *root = sbi->sb->s_root;
>  	struct dentry *tmp;
> @@ -189,7 +189,7 @@ static int autofs_getpath(struct autofs_sb_info *sbi,
>  	unsigned seq;
>  
>  rename_retry:
> -	buf = *name;
> +	buf = name;
>  	len = 0;
>  
>  	seq = read_seqbegin(&rename_lock);
> @@ -395,7 +395,7 @@ int autofs_wait(struct autofs_sb_info *sbi,
>  	if (IS_ROOT(dentry) && autofs_type_trigger(sbi->type))
>  		qstr.len = sprintf(name, "%p", dentry);
>  	else {
> -		qstr.len = autofs_getpath(sbi, dentry, &name);
> +		qstr.len = autofs_getpath(sbi, dentry, name);
>  		if (!qstr.len) {
>  			kfree(name);
>  			return -ENOENT;
