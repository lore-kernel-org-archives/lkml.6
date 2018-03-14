Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELtZSwNUclha3HjDrdP2p8d1uPCyrQ71lA6Yxg5GE9gF/gq+4Khv0cd9BhZpca2ugmmNnoTj
ARC-Seal: i=1; a=rsa-sha256; t=1521046791; cv=none;
        d=google.com; s=arc-20160816;
        b=g+g5hjk2CaLlDBjWYw0UyzhBQbifEK8kgnVNSAptipADkayb64SKd3smhTVJ7X8sdG
         NEn4E0NcR1XOes4wwN7O9IpFDKRmEG1IQYnfNXs/W/GwiXDIvBeq78q3NAaFOQxLw1eZ
         5SGV1NmLLri++LrDaIekKHhLyyj3cA89UCOfEskSl4thuca0OkXYrk3E7JP7EDwtGPWV
         RuR7tu6vhoNVxMYDTxM1dIL8IE5i0BdDkq1eiKKJaPddYQ23GIMkFsM0RX02EVAfsiPz
         XyRik1siLWUxZSBhs8SQjv9GqhSZDB6h4Ey+xcZ3kWR4MOzPu5kP0dpQtSYVPtJBNd3p
         mYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=fd7p1NL0ey9DoeCT5PnHLDV/IHyyTrP+nt2/gpIiCjE=;
        b=r2Cz9n2dHEks7rfacG+3vTJGZecgHe+lfJpAz0JZK+yxxyC+jMHJmO8j6RxfqvuSoX
         hpU4PPdPF5JKuleVdiVxHFgQe7xpayRpTQTS2aKsCbM5jCmUESohCJ4D0XqQQTdkHR2S
         MS+zSBGeOZylCRFenivx4GH7QWzRpaXMbehkJfNMCdO069SKJ9eAK4WGiGcPa85yu57R
         IV9d/htQ/xnHQ5dZgix5GQDF14hdIgASKifMJTAK7Zc1lhQJ0qQSMEikLSzYarnyxM0o
         12YKqoZHUgucvh9MVSWAkQzOZmofrDZFmAEXPpXGNh3/KF4kA29bp/NTIfuS7EITYHOC
         rbOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 14 Mar 2018 17:59:44 +0100
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
Message-ID: <20180314165943.GA5948@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1594933160270065515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13, Ravi Bangoria wrote:
>
> +static bool sdt_valid_vma(struct trace_uprobe *tu, struct vm_area_struct *vma)
> +{
> +	unsigned long vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
> +
> +	return tu->ref_ctr_offset &&
> +		vma->vm_file &&
> +		file_inode(vma->vm_file) == tu->inode &&
> +		vma->vm_flags & VM_WRITE &&
> +		vma->vm_start <= vaddr &&
> +		vma->vm_end > vaddr;
> +}

Perhaps in this case a simple

		ref_ctr_offset < vma->vm_end - vma->vm_start

check without vma_offset_to_vaddr() makes more sense, but I won't insist.



> +static void sdt_increment_ref_ctr(struct trace_uprobe *tu)
> +{
> +	struct uprobe_map_info *info;
> +	struct vm_area_struct *vma;
> +	unsigned long vaddr;
> +
> +	uprobe_start_dup_mmap();
> +	info = uprobe_build_map_info(tu->inode->i_mapping,
> +				tu->ref_ctr_offset, false);

Hmm. This doesn't look right.

If you need to find all mappings (and avoid the races with fork/dup_mmap) you
need to take this semaphore for writing, uprobe_start_dup_mmap() can't help.

Oleg.
