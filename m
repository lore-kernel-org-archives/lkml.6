Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELucoJB4UqpEhqz+8/Goj4RAJHDkwShE5peAA1L4tuBd0gsueKoN+dH240mBQDBIbSMKhUi9
ARC-Seal: i=1; a=rsa-sha256; t=1521124251; cv=none;
        d=google.com; s=arc-20160816;
        b=Kz8nvRtqfw6FUsTceUn8iWYYhgRc+ZP5VDhdt3iBa8Ci3WnbjreF+6SR/+xrANQuxW
         ADabte523zkIDefAJsXm1Hc7wdrk47VPBU746ucNyUw9BrZbDELmiX9POVIfn4fCZKlL
         QINVb7a7xSGmyhQwviBgIxmMRTKSUiKSCCg4teM94kGgogUQayLe1FYvFrBEgfVIdaLa
         rn+KweUSbk5C23tR+r/3ohzo3692ZMryEQNm8SXzbPbmaLd5JEg6Mb+h8I8q6QFWlmYF
         O2QbeDmaPszF7bojlwhj4isBAwI+WGfCPuh+Nfx2pcN/kMPZDTGtN8hk9guYBwoRj/J7
         MqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=S+8/4aWzDnxSh8CQ3Gynj9atr7wQPoq35FsQGOpztoU=;
        b=ZDKSYMz+F9kIyTqfLxu4PRr5w//R5Row6SovHIZBHfg4Pb+PQHvtKw/omJUYUll7cm
         m3Ode0jAbItu8GD8lW5pINVsZw7Nky1VsmbFtSvG+n0+Di7dv+KypS5FTGCofNNrOFzI
         gzNqh0FPb/nLHFbnTIyHovg4TQL6Pb2pajq/7GRikppL9wUP6avtReUX8/rjIqc8f0TQ
         dikSlkY1sXJO/J8RENMXO8kvtB8FBmCbfpvomkkszgg1dadWKB5p3vxCgQ9fHd/5S+KV
         OG6iqHdIVUx7swejaQU1vKVl6JNZ7oJe+9K75rTD5B84E6qZGuBG5si23jnRBIbAkxE+
         VKow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 15 Mar 2018 15:30:45 +0100
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
Message-ID: <20180315143044.GA19643@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
 <20180315142120.GA19218@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315142120.GA19218@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595014383310666425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/15, Oleg Nesterov wrote:
>
> > +static struct vm_area_struct *
> > +sdt_find_vma(struct mm_struct *mm, struct trace_uprobe *tu)
> > +{
> > +	struct vm_area_struct *tmp;
> > +
> > +	for (tmp = mm->mmap; tmp != NULL; tmp = tmp->vm_next)
> > +		if (sdt_valid_vma(tu, tmp))
> > +			return tmp;
> > +
> > +	return NULL;
>
> I can't understand the logic... Lets ignore sdt_valid_vma() for now.
> The caller has uprobe_map_info, why it can't simply do
> vma = find_vma(uprobe_map_info->vaddr)? and then check sdt_valid_vma().

Note to mention that sdt_find_vma() can return NULL but the callers do
vma_offset_to_vaddr(vma) without any check.

Oleg.
