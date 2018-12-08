Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A331C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48EF20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544240947;
	bh=9OmH9ZXqtw3frSj3RoK8S9X5vqtPfpoJlTo3k5sBb9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wsLKVjbCyFeswpCJ8ZVmoWdNSUgiB0GjwYtQ/lm5DTIMP7rtUjzhVKcC66wIv5Oq8
	 3BJi/+bC8NYalp1tXgC8k6mBHaMVc6V9z6hW8V1hYgC0rhVdSpm/OzAo+dXSF1CMoV
	 xDYUdHq7WQQZY72c57k4b7PZM0MsgbSxG8a9y+cw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48EF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLHDtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 22:49:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeLHDtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 22:49:04 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E97C2083D;
        Sat,  8 Dec 2018 03:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544240942;
        bh=9OmH9ZXqtw3frSj3RoK8S9X5vqtPfpoJlTo3k5sBb9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gkEeU+F1Pe1UYalXlMHsaUavGFYFujLV9ZAOS9ljHVkse9mEMHpNkahaUhgkxL2fD
         a5Vaihnt8Briw1/86MDYUX+kHNV2FVn49I48h5+8FcFuu0mwQAGHdF0cpKNgmyKb1k
         2psfvxp9lnMN5MuZQPLKcxYeBWHtTbsp6QioXrO4=
Date:   Sat, 8 Dec 2018 12:48:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: x86_64: blacklist non-attachable interrupt
 functions
Message-Id: <20181208124859.7318e32abfab4cc6dc2da3a8@kernel.org>
In-Reply-To: <20181207175805.GA1369@Dell>
References: <20181206095648.GA8249@Dell>
        <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
        <20181208010120.c3eda9042912068aecc68317@kernel.org>
        <20181207175805.GA1369@Dell>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 18:58:05 +0100
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Sat, Dec 08, 2018 at 01:01:20AM +0900, Masami Hiramatsu wrote:
> > Hi Andrea and Ingo,
> > 
> > Here is the patch what I meant. I just ran it on qemu-x86, and seemed working.
> > After introducing this patch, I will start adding arch_populate_kprobe_blacklist()
> > to some arches.
> > 
> > Thank you,
> > 
> > [RFC] kprobes: x86/kprobes: Blacklist symbols in arch-defined prohibited area
> > 
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Blacklist symbols in arch-defined probe-prohibited areas.
> > With this change, user can see all symbols which are prohibited
> > to probe in debugfs.
> > 
> > All archtectures which have custom prohibit areas should define
> > its own arch_populate_kprobe_blacklist() function, but unless that,
> > all symbols marked __kprobes are blacklisted.
> 
> What about iterating all symbols and use arch_within_kprobe_blacklist()
> to check if we need to blacklist them or not.

Sorry, I don't want to iterate all ksyms since it may take a long time
(especially embedded small devices.)

> 
> In this way we don't have to introduce an
> arch_populate_kprobe_blacklist() for each architecture.

Hmm, I had a same idea, but there are some arch which prohibit probing
extable entries (e.g. arm64.) For correctness of the blacklist, I think
it should be listed (not entire the function body).
I also rather like to remove arch_within_kprobe_blacklist() instead.

Thank you,

> 
> Something like the following maybe.
> 
> Thanks.
> 
> [RFC] kprobes: blacklist all symbols in arch-defined prohibited area
> 
> From: Andrea Righi <righi.andrea@gmail.com>
> 
> Blacklist symbols in arch-defined probe-prohibited areas.
> With this change, user can see all symbols which are prohibited
> to probe in debugfs.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> ---
>  kernel/kprobes.c | 55 +++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 90e98e233647..e67598dd7468 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2093,6 +2093,35 @@ void dump_kprobe(struct kprobe *kp)
>  }
>  NOKPROBE_SYMBOL(dump_kprobe);
>  
> +static int kprobe_blacklist_add(unsigned long entry)
> +{
> +	struct kprobe_blacklist_entry *ent;
> +	unsigned long offset = 0, size = 0;
> +
> +	if (!kernel_text_address(entry) ||
> +	    !kallsyms_lookup_size_offset(entry, &size, &offset))
> +		return -EINVAL;
> +
> +	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
> +	if (!ent)
> +		return -ENOMEM;
> +	ent->start_addr = entry;
> +	ent->end_addr = entry + size;
> +	INIT_LIST_HEAD(&ent->list);
> +	list_add_tail(&ent->list, &kprobe_blacklist);
> +
> +	return 0;
> +}
> +
> +static int arch_populate_kprobe_blacklist(void *data, const char *name,
> +					  struct module *mod,
> +					  unsigned long entry)
> +{
> +	if (arch_within_kprobe_blacklist(entry))
> +		kprobe_blacklist_add(entry);
> +	return 0;
> +}
> +
>  /*
>   * Lookup and populate the kprobe_blacklist.
>   *
> @@ -2104,24 +2133,22 @@ NOKPROBE_SYMBOL(dump_kprobe);
>  static int __init populate_kprobe_blacklist(unsigned long *start,
>  					     unsigned long *end)
>  {
> -	unsigned long *iter;
> -	struct kprobe_blacklist_entry *ent;
> -	unsigned long entry, offset = 0, size = 0;
> +	unsigned long entry, *iter;
> +	int ret;
>  
> +	/* Blacklist all arch_within_kprobe_blacklist() symbols */
> +        mutex_lock(&module_mutex);
> +	kallsyms_on_each_symbol(arch_populate_kprobe_blacklist, NULL);
> +        mutex_unlock(&module_mutex);
> +
> +	/* Add explicitly blacklisted symbols */
>  	for (iter = start; iter < end; iter++) {
>  		entry = arch_deref_entry_point((void *)*iter);
> -
> -		if (!kernel_text_address(entry) ||
> -		    !kallsyms_lookup_size_offset(entry, &size, &offset))
> +		ret = kprobe_blacklist_add(entry);
> +		if (ret == -EINVAL)
>  			continue;
> -
> -		ent = kmalloc(sizeof(*ent), GFP_KERNEL);
> -		if (!ent)
> -			return -ENOMEM;
> -		ent->start_addr = entry;
> -		ent->end_addr = entry + size;
> -		INIT_LIST_HEAD(&ent->list);
> -		list_add_tail(&ent->list, &kprobe_blacklist);
> +		if (ret < 0)
> +			return ret;
>  	}
>  	return 0;
>  }


-- 
Masami Hiramatsu <mhiramat@kernel.org>
