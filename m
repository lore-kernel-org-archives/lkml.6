Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3ABC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5262081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5262081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbeLCFBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:01:12 -0500
Received: from mail.hallyn.com ([178.63.66.53]:54516 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbeLCFBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:01:12 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 7120D64A; Sun,  2 Dec 2018 23:01:08 -0600 (CST)
Date:   Sun, 2 Dec 2018 23:01:08 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.ws>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v9 2/4] seccomp: switch system call argument type to void
 *
Message-ID: <20181203050108.GB31406@mail.hallyn.com>
References: <20181203032827.27978-1-tycho@tycho.ws>
 <20181203032827.27978-3-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203032827.27978-3-tycho@tycho.ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 08:28:25PM -0700, Tycho Andersen wrote:
> The const qualifier causes problems for any code that wants to write to the
> third argument of the seccomp syscall, as we will do in a future patch in
> this series.
> 
> The third argument to the seccomp syscall is documented as void *, so
> rather than just dropping the const, let's switch everything to use void *
> as well.
> 
> I believe this is safe because of 1. the documentation above, 2. there's no
> real type information exported about syscalls anywhere besides the man
> pages.
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

Though I'm not entirely convinced there will be no ill effects of changing
the argument type.  I'll feel comfortable when Michael and Paul say it's
fine :)

> CC: Christian Brauner <christian@brauner.io>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> ---
>  include/linux/seccomp.h | 2 +-
>  kernel/seccomp.c        | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index e5320f6c8654..b5103c019cf4 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -43,7 +43,7 @@ extern void secure_computing_strict(int this_syscall);
>  #endif
>  
>  extern long prctl_get_seccomp(void);
> -extern long prctl_set_seccomp(unsigned long, char __user *);
> +extern long prctl_set_seccomp(unsigned long, void __user *);
>  
>  static inline int seccomp_mode(struct seccomp *s)
>  {
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 96afc32e041d..393e029f778a 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -924,7 +924,7 @@ static long seccomp_get_action_avail(const char __user *uaction)
>  
>  /* Common entry point for both prctl and syscall. */
>  static long do_seccomp(unsigned int op, unsigned int flags,
> -		       const char __user *uargs)
> +		       void __user *uargs)
>  {
>  	switch (op) {
>  	case SECCOMP_SET_MODE_STRICT:
> @@ -944,7 +944,7 @@ static long do_seccomp(unsigned int op, unsigned int flags,
>  }
>  
>  SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
> -			 const char __user *, uargs)
> +			 void __user *, uargs)
>  {
>  	return do_seccomp(op, flags, uargs);
>  }
> @@ -956,10 +956,10 @@ SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
>   *
>   * Returns 0 on success or -EINVAL on failure.
>   */
> -long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
> +long prctl_set_seccomp(unsigned long seccomp_mode, void __user *filter)
>  {
>  	unsigned int op;
> -	char __user *uargs;
> +	void __user *uargs;
>  
>  	switch (seccomp_mode) {
>  	case SECCOMP_MODE_STRICT:
> -- 
> 2.19.1
