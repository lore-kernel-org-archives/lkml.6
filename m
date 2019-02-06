Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AC3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B89218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549434864;
	bh=8n6QqFWUm4PF36DztZ+21JdP3DjtjAhAYDljNN0KqMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PLTVL+JJXJBTziZEaVjJ47LSVxlIBJGyZIsJHiBk+dnAc/4gdZz1Spdf2Idop5JvC
	 PqO10VzJI6/wHnU0bEV2AlOiG5+EXednd+RcMYmcdpCNC2aJg7gknxe2ycnQWvl76j
	 tUNiax7MegizoS/zsDz6f573i/t9G2V5k0zOKDfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfBFGeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:34:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFGeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:34:22 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979972175B;
        Wed,  6 Feb 2019 06:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549434862;
        bh=8n6QqFWUm4PF36DztZ+21JdP3DjtjAhAYDljNN0KqMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xv4hmUu6tyxi5hqIxEISPEBx2lBMoRylc9ZfJl7JrIPXTFGNCLz3JcnHjq19AFSuC
         ctDXGfbDaTeqOswi1cO3ycjeU8ckabrgfdsPflUL5glP+EY8Xs5ImXhoJSOXBZZ5I4
         0aWQQ0QhaTdQ7xYiUbZYrC34aBbyoznTMYO6kkdo=
Date:   Wed, 6 Feb 2019 15:34:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 8/9] jump_label: Batch updates if arch supports it
Message-Id: <20190206153418.722cc7f4a83d0e48c8dca552@kernel.org>
In-Reply-To: <a36bfdbc63c5848adfaa1a466a90b62391fd2289.1549308412.git.bristot@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
        <a36bfdbc63c5848adfaa1a466a90b62391fd2289.1549308412.git.bristot@redhat.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Feb 2019 20:59:01 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -407,6 +407,7 @@ bool jump_label_can_update_check(struct jump_entry *entry, bool init)
>  	return 0;
>  }
>  
> +#ifndef HAVE_JUMP_LABEL_BATCH
>  static void __jump_label_update(struct static_key *key,
>  				struct jump_entry *entry,
>  				struct jump_entry *stop,
> @@ -419,6 +420,34 @@ static void __jump_label_update(struct static_key *key,
>  		}
>  	}
>  }
> +#else
> +static void __jump_label_update(struct static_key *key,
> +				struct jump_entry *entry,
> +				struct jump_entry *stop,
> +				bool init)
> +{
> +	for_each_label_entry(key, entry, stop) {
> +
> +		if (!jump_label_can_update_check(entry, init))
> +			continue;
> +
> +		if (arch_jump_label_transform_queue(entry,
> +						    jump_label_type(entry)))
> +			continue;
> +
> +		/*
> +		 * Queue's overflow: Apply the current queue, and then
> +		 * queue again. If it stills not possible to queue, BUG!
> +		 */
> +		arch_jump_label_transform_apply();
> +		if (!arch_jump_label_transform_queue(entry,
> +						     jump_label_type(entry))) {
> +			BUG();

Please do not relay on BUG(), since in both case (applied or not),
jump_label is not critical for normal operation. I think you should use
WARN_ONCE() here and lock the jump_label so that root user can report it
to us :)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
