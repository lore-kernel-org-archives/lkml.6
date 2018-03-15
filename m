Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELuTIbf1/3kL6fww+XRceWLsA0TldieFpnWKKDgXehfF87HxsEVG3zY6MiCk3KnOc4l1bfnW
ARC-Seal: i=1; a=rsa-sha256; t=1521126123; cv=none;
        d=google.com; s=arc-20160816;
        b=B+C82gR8YN8yk3ethPGLaZYEBEcIxiVeBXKcEXVLDjkLAo054dVea+yXWXVgFlZogO
         lsuKERkjZu0KRTgUo4OTOrbMkFJ2Bo9qynlCBLB+bIu1x4EiQuO+o9M4s0preED+VtrE
         jU5ulRNWQ2wf66+gegavBka21sIp1J67WOuPOV8z3etsX1RxRemfidDKYyh6Afle0mGg
         L8A64fA/jLAOdQ9MUBkk99iowI52fZ2k9pPSMYnueVIqFtOL208LQhPLYuTxSq/D4AZn
         wz26gptRX2ECA0pNrw/JC6ZuRvz3CvMZaLk68mNiM2I7x/egXZI+neWSwVtkr6IJbBVa
         gCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=juktfdYig9egC4zWyHjQHa9RfLgyEow4spAkeKP5gM0=;
        b=lip9ql2HbKmaMcbCADVN2vBf3WpqhkGBtsL5g3qK1oxCk31STilUWpJT/KRcU8ot5I
         Kor9Sc6hcR6wihs+dBGgt5CZoXZU5eUtvUUqP8ccFVMD8sRiLa5IpB1nW1OQwsdfi169
         Ks3i07CPJob4gMt6eUOK+e1Jl28/IYPsIk2tPds+NrcmBpMrHmY9Kv4oc6c78nU8LPbZ
         y/afGfEBsp6RzKatG2ZZiHfgF4krxnnAcTXYwwo64IFd7KpVD9xJDMugIFKeip1WmG0Y
         MrvUkVYvo65TpQecwG0xBZZSn3/dhRR2Jf8P/l/aEyy0TfqmEo/6Km4vTi13HTCrCvkU
         17DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 15 Mar 2018 16:01:57 +0100
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
Message-ID: <20180315150156.GA19767@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595016346576100567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13, Ravi Bangoria wrote:
>
> +sdt_update_ref_ctr(struct mm_struct *mm, unsigned long vaddr, short d)
> +{
> +	void *kaddr;
> +	struct page *page;
> +	struct vm_area_struct *vma;
> +	int ret = 0;
> +	unsigned short orig = 0;
> +
> +	if (vaddr == 0)
> +		return -EINVAL;
> +
> +	ret = get_user_pages_remote(NULL, mm, vaddr, 1,
> +		FOLL_FORCE | FOLL_WRITE, &page, &vma, NULL);
> +	if (ret <= 0)
> +		return ret;
> +
> +	kaddr = kmap_atomic(page);
> +	memcpy(&orig, kaddr + (vaddr & ~PAGE_MASK), sizeof(orig));
> +	orig += d;
> +	memcpy(kaddr + (vaddr & ~PAGE_MASK), &orig, sizeof(orig));
> +	kunmap_atomic(kaddr);

Hmm. Why memcpy? You could simply do

	kaddr = kmap_atomic();
	unsigned short *ptr = kaddr + (vaddr & ~PAGE_MASK);
	*ptr += d;
	kunmap_atomic();

Oleg.
