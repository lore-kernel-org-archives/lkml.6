Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeDSDo5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:44:57 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50993 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeDSDow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:44:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: linux-next@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20180419024641.24213-1-marcos.souza.org@gmail.com>
Date: Wed, 18 Apr 2018 22:43:26 -0500
In-Reply-To: <20180419024641.24213-1-marcos.souza.org@gmail.com> (Marcos Paulo
        de Souza's message of "Wed, 18 Apr 2018 23:46:38 -0300")
Message-ID: <87in8nsvxd.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f90V6-0001hn-Bg;;;mid=<87in8nsvxd.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19rFREcxdkexR+PPoMD+z+GR72bRnbjFSI=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marcos Paulo de Souza <marcos.souza.org@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 607 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.8 (0.5%), b_tie_ro: 1.89 (0.3%), parse: 1.33 (0.2%),
        extract_message_metadata: 5 (0.9%), get_uri_detail_list: 2.8 (0.5%),
        tests_pri_-1000: 6 (1.0%), tests_pri_-950: 2.1 (0.3%), tests_pri_-900: 1.63
        (0.3%), tests_pri_-400: 31 (5.1%), check_bayes: 29 (4.8%), b_tokenize: 12
        (2.0%), b_tok_get_all: 7 (1.1%), b_comp_prob: 4.0 (0.7%), b_tok_touch_all:
        2.7 (0.4%), b_finish: 0.81 (0.1%), tests_pri_0: 528 (87.0%),
        check_dkim_signature: 0.87 (0.1%), check_dkim_adsp: 4.7 (0.8%),
        tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] user_namespace: Replace gotos with return statements
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcos Paulo de Souza <marcos.souza.org@gmail.com> writes:

> Found while inspecting the code that handles the setgroups procfs
> file.

What perchance might be the advantage of introducing multiple exits
into proc_setgroups_write?

I strongly suspect that if you look at the generated code it will
be worse after your patch.


Eric

> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> ---
> Tested locally setting up a new userns, and setting setgroups as deny and allow,
> worked as before.
>
>  kernel/user_namespace.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 246d4d4ce5c7..64a01254ac6b 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1142,22 +1142,18 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
>  	struct user_namespace *ns = seq->private;
>  	char kbuf[8], *pos;
>  	bool setgroups_allowed;
> -	ssize_t ret;
>  
>  	/* Only allow a very narrow range of strings to be written */
> -	ret = -EINVAL;
>  	if ((*ppos != 0) || (count >= sizeof(kbuf)))
> -		goto out;
> +		return -EINVAL;
>  
>  	/* What was written? */
> -	ret = -EFAULT;
>  	if (copy_from_user(kbuf, buf, count))
> -		goto out;
> +		return -EFAULT;
>  	kbuf[count] = '\0';
>  	pos = kbuf;
>  
>  	/* What is being requested? */
> -	ret = -EINVAL;
>  	if (strncmp(pos, "allow", 5) == 0) {
>  		pos += 5;
>  		setgroups_allowed = true;
> @@ -1167,14 +1163,13 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
>  		setgroups_allowed = false;
>  	}
>  	else
> -		goto out;
> +		return -EINVAL;
>  
>  	/* Verify there is not trailing junk on the line */
>  	pos = skip_spaces(pos);
>  	if (*pos != '\0')
> -		goto out;
> +		return -EINVAL;
>  
> -	ret = -EPERM;
>  	mutex_lock(&userns_state_mutex);
>  	if (setgroups_allowed) {
>  		/* Enabling setgroups after setgroups has been disabled
> @@ -1194,12 +1189,11 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
>  
>  	/* Report a successful write */
>  	*ppos = count;
> -	ret = count;
> -out:
> -	return ret;
> +	return count;
> +
>  out_unlock:
>  	mutex_unlock(&userns_state_mutex);
> -	goto out;
> +	return -EPERM;
>  }
>  
>  bool userns_may_setgroups(const struct user_namespace *ns)
