Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELu2BrbRT0UMoB4u67WaFAUaqLxP6CurUrlMz1mv/fueXvT+3clrjvKA9YiZPKCQAqfWvlnr
ARC-Seal: i=1; a=rsa-sha256; t=1521216984; cv=none;
        d=google.com; s=arc-20160816;
        b=xx7XTSHaI264TEwmbXoVqcdbCs/bOx9M6b/2sAzTXVufwF+NiGmvIiRbrOVHLeA8AK
         kZoeFt9MaKj+xHEY99xFOM+e7Q/sTNE6Rj6qq6VFFWF/bhHNlngvItSNAH4TEbHuFmS/
         EKA9sR5pMs1eg5EExLD7Nq+TLayMZzyw9nnvFPVydqPqzb4WAJB5RBvK/yi542M1Mctz
         bUUg8ab3U9KwigV0WvrzLMP84LVhH7Prz8pjnHj5HNVu1fZZWCyT1yR7qA7bGA6DQl5d
         R9BleoVVnxsfrWV3HGYBmkDVCi2BtOjJZEalXhci/VWOHbk5f4EOEhV/WSXsbKVRoZfi
         Ma5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ND6BKpDQPRQBFJWURR1nfqutljIrmhQgCQuFhuDe7FM=;
        b=k1O0aFviLJlJ3nkYujG7R7GSsdf+YwGkZObZi7bGe+KXFPqeHmyVDu9pbgkGNh7Dis
         2VKmKkKh4pazM7ZZLJhH78KmD5D4gfD5u2FSYTZR7mff9IbZ2aH6JSGW0abX+G2EvXoz
         d5FkkYZpxjvlTC43MKTmboueCqa83oeHCCi8aYkM4d+VV6/D+FU0gAlHRykhG+thqXAb
         P1z1vBfDjyCrzrWtnEHNPEPUOFMrhW6AqPQ/BFn2ohzQMvJbBoxsbs2cjX7YW/H7KihY
         HaSJquGA+Isnwm6k/gp4QC82Z2VaOyPB/k6cAKXagixCzVI9kwdBTJyw9Z4ECLSjl2x1
         utIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Fri, 16 Mar 2018 17:16:17 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, mhiramat@kernel.org,
	peterz@infradead.org, srikar@linux.vnet.ibm.com, acme@kernel.org,
	ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
	corbet@lwn.net, dan.j.williams@intel.com,
	gregkh@linuxfoundation.org, huawei.libin@huawei.com,
	hughd@google.com, jack@suse.cz, jglisse@redhat.com,
	jolsa@redhat.com, kan.liang@intel.com,
	kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
	kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
	milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
	naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com,
	pombredanne@nexb.com, tglx@linutronix.de,
	tmricht@linux.vnet.ibm.com, willy@infradead.org,
	yao.jin@linux.intel.com, fengguang.wu@intel.com
Subject: Re: [PATCH 5/8] trace_uprobe: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180316161616.GA28249@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
 <20180315124816.6aa3d4e2@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315124816.6aa3d4e2@vmware.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595111620796540352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/15, Steven Rostedt wrote:
>
> On Tue, 13 Mar 2018 18:26:00 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
> > +static void sdt_increment_ref_ctr(struct trace_uprobe *tu)
> > +{
> > +	struct uprobe_map_info *info;
> > +	struct vm_area_struct *vma;
> > +	unsigned long vaddr;
> > +
> > +	uprobe_start_dup_mmap();
>
> Please add a comment here that this function ups the mm ref count for
> each info returned. Otherwise it's hard to know what that mmput() below
> matches.

You meant uprobe_build_map_info(), not uprobe_start_dup_mmap().

Yes, and if it gets more callers perhaps we should move this mmput() into
uprobe_free_map_info()...

Oleg.


--- x/kernel/events/uprobes.c
+++ x/kernel/events/uprobes.c
@@ -714,6 +714,7 @@ struct map_info {
 static inline struct map_info *free_map_info(struct map_info *info)
 {
 	struct map_info *next = info->next;
+	mmput(info->mm);
 	kfree(info);
 	return next;
 }
@@ -783,8 +784,11 @@ build_map_info(struct address_space *map
 
 	goto again;
  out:
-	while (prev)
-		prev = free_map_info(prev);
+	while (prev) {
+		info = prev;
+		prev = prev->next;
+		kfree(info);
+	}
 	return curr;
 }
 
@@ -834,7 +838,6 @@ register_for_each_vma(struct uprobe *upr
  unlock:
 		up_write(&mm->mmap_sem);
  free:
-		mmput(mm);
 		info = free_map_info(info);
 	}
  out:
