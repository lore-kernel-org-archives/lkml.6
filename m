Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELuPjbjjkP8KsXi7DQiO86TvRVd61DWvTA+CjeUtRyNHzdfxNUX+UIrmJythKpX4K8Y3krrP
ARC-Seal: i=1; a=rsa-sha256; t=1521125406; cv=none;
        d=google.com; s=arc-20160816;
        b=yu8SUztDtjAuZiUV2H+lbI+C3qKSjwjzVgFc1b9j9z1+mMQ7AvKuVRGG5UOKI1qed0
         L4KzMLuXy+H56WFNk9OJ622FCGIV+csF6WsgaSAOZqcFfGSMIEAbUZXaI5t5WgKlj8tD
         15icfwCv7v1c66XoE34/OaPjZaLcqyqMgnvqGJcdMZi69N1AhWo+dgl9wm5wBJOanvaU
         bcoKFzU4+mObu4fsGE0vc6/LMy7I3iee1k4PKxIUKISgrCfqZcoisfjjGwI/EaqJXu06
         YWvhiL7cyKtZPI2JfMtZyMUcYuLf1hC5ghP7O9AfdLGpW26cNGwby+ipX1DIs2qal5/u
         vebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=1H8im1OpeqPk6h5mGk5SkVA3NnKhJFl1d4Ih8YtORWE=;
        b=Cz7ofl1n+wUPoylLnBroFh0MaC3jyuME5yNRgxl+QRhF99DsgJLTBTR70bNAI7Qd7+
         PPipjSFEbLiJuovHboiOSXNZlIXkmifTeitfkMjIdYG5Mpxlt+JdPYOUJwWN7VBblyvf
         s05+S0U7DJI5jvoHUrQseY0twtjKxr9AfcK5RqlQE2+8sEfOZXjw4yuX5fQ/2+Wa3Hg7
         E0KtfShG/fL1SeLI7Hw32uYkjW5Am0CoPtmQzqD9hezl/JOAJLXAB8SCysK41wnQ0jXh
         e7ko6QOmeRV7ajHGyldRfAr5ug4Pqlx0H8XXfx0Z7vN8CSMJ6MPZ84Q+Zkk15K0oUiYM
         lV+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 15 Mar 2018 15:49:59 +0100
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
Subject: Re: [PATCH 6/8] trace_uprobe/sdt: Fix multiple update of same
 reference counter
Message-ID: <20180315144959.GB19643@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-7-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313125603.19819-7-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827186487084438?=
X-GMAIL-MSGID: =?utf-8?q?1595015593700773262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13, Ravi Bangoria wrote:
>
> For tiny binaries/libraries, different mmap regions points to the
> same file portion. In such cases, we may increment reference counter
> multiple times.

Yes,

> But while de-registration, reference counter will get
> decremented only by once

could you explain why this happens? sdt_increment_ref_ctr() and
sdt_decrement_ref_ctr() look symmetrical, _decrement_ should see
the same mappings?

Ether way, this patch doesn't look right at first glance... Just
for example,

> +static bool sdt_check_mm_list(struct trace_uprobe *tu, struct mm_struct *mm)
> +{
> +	struct sdt_mm_list *tmp = tu->sml;
> +
> +	if (!tu->sml || !mm)
> +		return false;
> +
> +	while (tmp) {
> +		if (tmp->mm == mm)
> +			return true;
> +		tmp = tmp->next;
> +	}
> +
> +	return false;

...

> +}
> +
> +static void sdt_add_mm_list(struct trace_uprobe *tu, struct mm_struct *mm)
> +{
> +	struct sdt_mm_list *tmp;
> +
> +	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> +	if (!tmp)
> +		return;
> +
> +	tmp->mm = mm;
> +	tmp->next = tu->sml;
> +	tu->sml = tmp;
> +}
> +

...

> @@ -1020,8 +1104,16 @@ void trace_uprobe_mmap_callback(struct vm_area_struct *vma)
>  		    !trace_probe_is_enabled(&tu->tp))
>  			continue;
>
> +		down_write(&tu->sml_rw_sem);
> +		if (sdt_check_mm_list(tu, vma->vm_mm))
> +			goto cont;
> +
>  		vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
> -		sdt_update_ref_ctr(vma->vm_mm, vaddr, 1);
> +		if (!sdt_update_ref_ctr(vma->vm_mm, vaddr, 1))
> +			sdt_add_mm_list(tu, vma->vm_mm);
> +
> +cont:
> +		up_write(&tu->sml_rw_sem);

To simplify, suppose that tu->sml is empty.

Some process calls this function, increments the counter and adds its ->mm into
the list.

Then it exits, ->mm is freed.

The next fork/exec allocates the same memory for the new ->mm, the new process
calls trace_uprobe_mmap_callback() and sdt_check_mm_list() returns T?

Oleg.
