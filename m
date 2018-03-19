Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELsAvi5pxP0tE75mKda2Fy+OwjteALvQn/F1CPbYORQxOQQfXSV0n/WBj9J0EkQTCIuTfYbV
ARC-Seal: i=1; a=rsa-sha256; t=1521467184; cv=none;
        d=google.com; s=arc-20160816;
        b=OAK7l2SDCeZ50K4KexH9IDMGLaX2H+SKxGpbxnPcIdfWRnkjuvN/GLvDd9CNYiwNoA
         shx+U+htTq0p9owu6gUxn8s5N+OQeMIXqRyLMtqa5ikYO7JidKJjYTPHtCRYQkU03A57
         dpgYUvSX61mheutpUUubad7YXRupuYNECMMj8nu3LBzBd/vxVpNnHjttf53QTPXgmkr6
         eBwFsi65RBH6qaeMYicIXV10v/PApir+aDNKp8N94UTyDoHnCreZvS/pLZE+0V24Dpcd
         Rai9FUsZ3h/D/Fmt30P8AAkIFveZ/UqPMO4vNSAgM2SZk0c/V3s6aNG3IcyE3TGXB6HH
         Dx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nH1FLNfX807odzViuvvbju9MeqQtpTmv5DttGTUtxlI=;
        b=K0ZQIB1GTWmB+bull/v/bakiVESDZY9avcM8KQxy6vt3nmQuNIJXZyzvfTfJyExNaI
         91Rzc2DTyAVh+f/MRKqw+80aTPmqupfaCtOO4WWxif985HjOp0oBQ7nC23Jjsoc68QEB
         dEl/ED+iRajv/tuqHjYOkIcM03VJbibBJ9J2eFBg41ZRVEO3kvL5/GCumJKchSkKW6Hf
         2I181ML23V12XKnUxgT1ELzcsgdL3Ci3fpR6PypVG1xfg/7lM/UC+Nk18icz/IMOdA6/
         UL0/AJTKVcBdggzZBJe7TXq9KiMftDXi1kDAGvyzkgWrPpJysGqF6NLQ0o2AlF3YpKQd
         0GbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Mon, 19 Mar 2018 14:46:18 +0100
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
Message-ID: <20180319134618.GB12554@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
 <20180314165943.GA5948@redhat.com>
 <9cb068f7-0996-6e24-a95b-771006559318@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb068f7-0996-6e24-a95b-771006559318@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595373974120278787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19, Ravi Bangoria wrote:
>
> Hi Oleg,
> 
> On 03/14/2018 10:29 PM, Oleg Nesterov wrote:
> > On 03/13, Ravi Bangoria wrote:
> >> +static bool sdt_valid_vma(struct trace_uprobe *tu, struct vm_area_struct *vma)
> >> +{
> >> +	unsigned long vaddr = vma_offset_to_vaddr(vma, tu->ref_ctr_offset);
> >> +
> >> +	return tu->ref_ctr_offset &&
> >> +		vma->vm_file &&
> >> +		file_inode(vma->vm_file) == tu->inode &&
> >> +		vma->vm_flags & VM_WRITE &&
> >> +		vma->vm_start <= vaddr &&
> >> +		vma->vm_end > vaddr;
> >> +}
> > Perhaps in this case a simple
> >
> > 		ref_ctr_offset < vma->vm_end - vma->vm_start
> >
> > check without vma_offset_to_vaddr() makes more sense, but I won't insist.
> >
> 
> I still don't get this. This seems a comparison between file offset and size
> of the vma. Shouldn't we need to consider pg_off here?

Indeed, I am stupid ;)

Oleg.
