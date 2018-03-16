Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELv6RocNDMNGW7Wf+njikJpCli5NfftZ9EESPWQ4cVOY2p5LlPWJKNAqVbPnwOFm9KXgnQcR
ARC-Seal: i=1; a=rsa-sha256; t=1521200366; cv=none;
        d=google.com; s=arc-20160816;
        b=JDbf4hBjZFob/nG7GzWrQASoLdeJ1HGnGujmhkmhpn4yTgWKgORwBio8f2Cfqbi61D
         ErS53GzAMChx/yYkTzwPQXD4it7SoccXCGbxRLhkd51xj8HotOo6J8UnCJRoO2ca7EKm
         pinQtrwsgraXlbVinw1gJGxdS2ihAZOaNL5GsWoe5znirbCH1T7omD+qd/+fiZX4sYdG
         I9EemKVekHyW0Y6tC89wrd6390OWaiMGV/lImacXwgYNgGy0F2LCEDN8ushUD/gWgIC1
         LisSR3mDUWSwckc3cWjoeAuEAfyzwytNL8nJp70JXKgdeHMZWp/95U9msK1oqdNNT/2w
         ubFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=GdMnHymNFeiWWVqcy3elW84k/sBKHQB0N13i3OfnrGk=;
        b=mPe/QjpIs3UEVPbAcscrHQ1z79nY0BFg7+8/bnjwkbqhl4OOCiWNPQAMG+ziCg33RP
         3rOWna9q8fqAPai7o1r/1HKd16HiMws8jNl+RaJ5oAQQDTzF+Vd0JKjEHVzq9VzsvVvO
         YE5YTn7EGH3YmMW4WHq7JPgWfw441XSCCp/rdszyIZObKgQjmCxfHp8HABdVGVC6RdtO
         2Ex+SYdZvTcpLgJ16NRweCA/D2zO2bU3kahhyFfEZCPUl5CUpdLV4f+1/LovZHietEC4
         KsHjIthUlp6lReJRD4L+c5jI/QJyMrj4ESTxc9RgkVnRQ69Vd0mh56OUBSDHfGZiZ9hQ
         jFog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Fri, 16 Mar 2018 12:39:18 +0100
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
Message-ID: <20180316113917.GA21303@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
 <20180315142120.GA19218@redhat.com>
 <20180315143044.GA19643@redhat.com>
 <3b303a2d-35dd-9178-fc03-de9f2d588797@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b303a2d-35dd-9178-fc03-de9f2d588797@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1595094195351289726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16, Ravi Bangoria wrote:
>
> On 03/15/2018 08:00 PM, Oleg Nesterov wrote:
> > Note to mention that sdt_find_vma() can return NULL but the callers do
> > vma_offset_to_vaddr(vma) without any check.
>
> If the "mm" we are passing to sdt_find_vma() is returned by
> uprobe_build_map_info(ref_ctr_offset), sdt_find_vma() must
> _not_ return NULL.

Not at all.

Once build_map_info() returns any mapping can go away. Otherwise, why do
you think the caller has to take ->mmap_sem and use find_vma()? If you
were right, build_map_info() could just return the list of vma's instead
of list of mm's.

Oleg.
