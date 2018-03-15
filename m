Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELvYAil6fRrgoxrzl1XyyFqeuOqOmPT/vOJCLMb+UfahP57ZtHe4UfyvaoGFSfmlZcCmZZwa
ARC-Seal: i=1; a=rsa-sha256; t=1521123691; cv=none;
        d=google.com; s=arc-20160816;
        b=R6YFqA7clBY2bLUCWN/NFCFvVxNWJ0LoAOk5GmEWowKJS294WPDbhbGSP3S7krHZhd
         R58YxUyWKWsUILCOM+WsEy3XN0JVOG6Z+K4rU7pymHKhQbtvwI1AWuFFKv1r/j/fvhMM
         8GdxE+4bMIJXgIjMHVRWeORv3+nQcNRWdsai8+hRyfhXJUfOdzuI7eNUhvRpuD94PF3Y
         CXi39zxiNcsOLFMiMndt/1ZA/chOdHVBFEPeFdcecMn5v2BmirD/33tvnA9cA1b0P9La
         NhKvj/dI3FBakabdVQTU5sw2AAiyswddt+4AMLq3IBMRTGHAu/is2wK6kt6L+s5lp7hD
         Nd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=QCCA00uxauAl1wsNsb0OIwtYQQ8VSuUzMLql8rwmLn0=;
        b=bkpURuQizxltCDgVWAV1XcJKOMnm27VQs3I3n5w5DUF2DXOlqQTBZt/BC/uA9SWsZp
         lK1eiKJ4oRyUNowL8VReSK3CEPTSA0uvpBPdIeHsRG3WY9tFWWUR2DQ16WI23wSOkHdP
         kBjhiDe90aSK2G6tRlI3ZmsLSSpsf/q39PEUwuk6znv1kpR29SEKEU64wj/BbqgTVFBt
         9b9Q7k0SupLYur96Hq+2heKl13T/uN0wZT236Y4AbDmqK9rln7UAGHWEbPWyBmPaQ2Vn
         BK4x+IuJMYX6GcBGskWfA3kOoeFQ616/be25Au4R5sFIXPrCSqfq1grrMiCuvHad8Yq4
         Ux/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 15 Mar 2018 15:21:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, srikar@linux.vnet.ibm.com,
	acme@kernel.org, ananth@linux.vnet.ibm.com,
	akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
	alexis.berlemont@gmail.com, corbet@lwn.net,
	dan.j.williams@intel.com, gregkh@linuxfoundation.org,
	huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
	jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
	kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
	kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
	milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
	naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com,
	pombredanne@nexb.com, rostedt@goodmis.org, tglx@linutronix.de,
	tmricht@linux.vnet.ibm.com, willy@infradead.org,
	yao.jin@linux.intel.com, fengguang.wu@intel.com
Subject: Re: [PATCH 5/8] trace_uprobe: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180315142120.GA19218@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595013795700977244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13, Ravi Bangoria wrote:
>
> @@ -1053,6 +1056,9 @@ int uprobe_mmap(struct vm_area_struct *vma)
>  	struct uprobe *uprobe, *u;
>  	struct inode *inode;
>
> +	if (uprobe_mmap_callback)
> +		uprobe_mmap_callback(vma);
> +
>  	if (no_uprobe_events() || !valid_vma(vma, true))
>  		return 0;

probe_event_enable() does

	uprobe_register();
	/* WINDOW */
	sdt_increment_ref_ctr();

what if uprobe_mmap() is called in between? The counter(s) in this vma
will be incremented twice, no?

> +static struct vm_area_struct *
> +sdt_find_vma(struct mm_struct *mm, struct trace_uprobe *tu)
> +{
> +	struct vm_area_struct *tmp;
> +
> +	for (tmp = mm->mmap; tmp != NULL; tmp = tmp->vm_next)
> +		if (sdt_valid_vma(tu, tmp))
> +			return tmp;
> +
> +	return NULL;

I can't understand the logic... Lets ignore sdt_valid_vma() for now.
The caller has uprobe_map_info, why it can't simply do
vma = find_vma(uprobe_map_info->vaddr)? and then check sdt_valid_vma().

Oleg.
