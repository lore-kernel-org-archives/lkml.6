Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD8D2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD8D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbeLCExc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:53:32 -0500
Received: from mail.hallyn.com ([178.63.66.53]:54380 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLCExc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:53:32 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 9DC12F46; Sun,  2 Dec 2018 22:53:29 -0600 (CST)
Date:   Sun, 2 Dec 2018 22:53:29 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Tycho Andersen <tycho@tycho.ws>
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
Subject: Re: [PATCH v9 1/4] seccomp: hoist struct seccomp_data recalculation
 higher
Message-ID: <20181203045329.GA31406@mail.hallyn.com>
References: <20181203032827.27978-1-tycho@tycho.ws>
 <20181203032827.27978-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203032827.27978-2-tycho@tycho.ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 08:28:24PM -0700, Tycho Andersen wrote:
> In the next patch, we're going to use the sd pointer passed to
> __seccomp_filter() as the data to pass to userspace. Except that in some
> cases (__seccomp_filter(SECCOMP_RET_TRACE), emulate_vsyscall(), every time
> seccomp is inovked on power, etc.) the sd pointer will be NULL in order to
> force seccomp to recompute the register data. Previously this recomputation
> happened one level lower, in seccomp_run_filters(); this patch just moves
> it up a level higher to __seccomp_filter().
> 
> Thanks Oleg for spotting this.
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> CC: Christian Brauner <christian@brauner.io>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> ---
>  kernel/seccomp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index f2ae2324c232..96afc32e041d 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -188,7 +188,6 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>  static u32 seccomp_run_filters(const struct seccomp_data *sd,
>  			       struct seccomp_filter **match)
>  {
> -	struct seccomp_data sd_local;
>  	u32 ret = SECCOMP_RET_ALLOW;
>  	/* Make sure cross-thread synced filter points somewhere sane. */
>  	struct seccomp_filter *f =
> @@ -198,11 +197,6 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>  	if (WARN_ON(f == NULL))
>  		return SECCOMP_RET_KILL_PROCESS;
>  
> -	if (!sd) {
> -		populate_seccomp_data(&sd_local);
> -		sd = &sd_local;
> -	}
> -
>  	/*
>  	 * All filters in the list are evaluated and the lowest BPF return
>  	 * value always takes priority (ignoring the DATA).
> @@ -658,6 +652,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  	u32 filter_ret, action;
>  	struct seccomp_filter *match = NULL;
>  	int data;
> +	struct seccomp_data sd_local;
>  
>  	/*
>  	 * Make sure that any changes to mode from another thread have
> @@ -665,6 +660,11 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
>  	 */
>  	rmb();
>  
> +	if (!sd) {
> +		populate_seccomp_data(&sd_local);
> +		sd = &sd_local;
> +	}
> +
>  	filter_ret = seccomp_run_filters(sd, &match);
>  	data = filter_ret & SECCOMP_RET_DATA;
>  	action = filter_ret & SECCOMP_RET_ACTION_FULL;
> -- 
> 2.19.1
