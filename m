Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669E3C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180B620892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 03:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544240537;
	bh=HpuI/iXOie6DYydNZ/GjJmWFzgjbhpYCqpYKVxtgqWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=epMqvc8wXvb99YHl11ypKMf94zhERQ8T83H6MLaUwSLOs67F4pCjaeayon3HIPn0p
	 xE/aABUMpWJEKWhNg28H2bWEyO33hH4XKgAzRgBCRJBPojkl1C2px4gMN154RvTXsf
	 dc9yJmOu+6OL9ovlDQTlfRoqvDWT3K0IpIvE1SIM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180B620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeLHDmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 22:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeLHDmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 22:42:15 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 130022083D;
        Sat,  8 Dec 2018 03:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544240534;
        bh=HpuI/iXOie6DYydNZ/GjJmWFzgjbhpYCqpYKVxtgqWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UI3CR0sc49v0mkEZPYfWWBW1aCxiNtmPLIPCf1wOmfmMItWL3rh/CrcypdrXFcFBT
         BBYmccDlq3z43NnWtuuKXkhH/hzjVonhw8y6TyfT4e/27aFGUwWes9iWH7RxlAmAnw
         9cWaVlm4mfZIUm1MsmxIK2pySbVY+sWZGSNYmNj4=
Date:   Sat, 8 Dec 2018 12:42:10 +0900
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
Message-Id: <20181208124210.7f46eb88544e2e3899713052@kernel.org>
In-Reply-To: <20181207170026.GA1379@Dell>
References: <20181206095648.GA8249@Dell>
        <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
        <20181208010120.c3eda9042912068aecc68317@kernel.org>
        <20181207170026.GA1379@Dell>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 18:00:26 +0100
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
> > 
> > Reported-by: Andrea Righi <righi.andrea@gmail.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> 
> [snip]
> 
> > +int kprobe_add_ksym_blacklist(unsigned long entry)
> > +{
> > +	struct kprobe_blacklist_entry *ent;
> > +	unsigned long offset = 0, size = 0;
> > +
> > +	if (!kernel_text_address(entry) ||
> > +	    !kallsyms_lookup_size_offset(entry, &size, &offset))
> > +		return -EINVAL;
> > +
> > +	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
> > +	if (!ent)
> > +		return -ENOMEM;
> > +	ent->start_addr = entry - offset;
> > +	ent->end_addr = entry - offset + size;
> 
> Do we need to take offset into account? The code before wasn't using it.

Yes, if we hit an alias symbol (zero-size), we forcibly increment address
and retry it. In that case, offset will be 1.

> 
> > +	INIT_LIST_HEAD(&ent->list);
> > +	list_add_tail(&ent->list, &kprobe_blacklist);
> > +
> > +	return (int)size;
> > +}
> > +
> > +/* Add functions in arch defined probe-prohibited area */
> > +int __weak arch_populate_kprobe_blacklist(void)
> > +{
> > +	unsigned long entry;
> > +	int ret = 0;
> > +
> > +	for (entry = (unsigned long)__kprobes_text_start;
> > +	     entry < (unsigned long)__kprobes_text_end;
> > +	     entry += ret) {
> > +		ret = kprobe_add_ksym_blacklist(entry);
> > +		if (ret < 0)
> > +			return ret;
> > +		if (ret == 0)	/* In case of alias symbol */
> > +			ret = 1;

Here, we incremented.

Thank you,

> > +	}
> > +	return 0;
> > +}
> > +
> >  /*
> >   * Lookup and populate the kprobe_blacklist.
> >   *
> > @@ -2104,26 +2142,20 @@ NOKPROBE_SYMBOL(dump_kprobe);
> >  static int __init populate_kprobe_blacklist(unsigned long *start,
> >  					     unsigned long *end)
> >  {
> > +	unsigned long entry;
> >  	unsigned long *iter;
> > -	struct kprobe_blacklist_entry *ent;
> > -	unsigned long entry, offset = 0, size = 0;
> > +	int ret;
> >  
> >  	for (iter = start; iter < end; iter++) {
> >  		entry = arch_deref_entry_point((void *)*iter);
> > -
> > -		if (!kernel_text_address(entry) ||
> > -		    !kallsyms_lookup_size_offset(entry, &size, &offset))
> > +		ret = kprobe_add_ksym_blacklist(entry);
> > +		if (ret == -EINVAL)
> >  			continue;
> > -
> > -		ent = kmalloc(sizeof(*ent), GFP_KERNEL);
> > -		if (!ent)
> > -			return -ENOMEM;
> > -		ent->start_addr = entry;
> > -		ent->end_addr = entry + size;
> > -		INIT_LIST_HEAD(&ent->list);
> > -		list_add_tail(&ent->list, &kprobe_blacklist);
> > +		if (ret < 0)
> > +			return ret;
> >  	}
> > -	return 0;
> > +
> > +	return arch_populate_kprobe_blacklist();
> >  }
> >  
> >  /* Module notifier call back, checking kprobes on the module */


-- 
Masami Hiramatsu <mhiramat@kernel.org>
