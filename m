Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELsVtHPzjL5rtqbbpARA7OcugQW9ViQKhRA99IX9Z1qm0uYnSK3SZxQGACZJgHF+1Ifcemt6
ARC-Seal: i=1; a=rsa-sha256; t=1521466858; cv=none;
        d=google.com; s=arc-20160816;
        b=DvQ0DTtxmc+PHCKQzUJ02as5l+A4Tx3F7FzUOJqRnpuyBruytI5QsePYVjez7co0em
         zWGbxTH9wiJxIRv9gcJdqyX/u57yz7n3/mHuFACOSjP4LPJgq4MoRmYoNIBzXvAamhQN
         CTXpp0iGGCy7JVNT57dEZ2K0OamhRIIKKYua2ha8rhbvl1gOKe1TDq4BIqJghkFfptoV
         oGE1Ik2Qoq+YpASsvY3jCAg5OZvLa+TrHfvScHjCsQdgMQpFp3Pz0JEuuDLRdgXejXfB
         QAnLq3b5mDqCeqBqpMqMtIHcf6CHRIg8vGTLoLTbWsjcQUQXKdgrU7c5nZCIipeqgn57
         lOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=wryYs1ra+RvF7T1IeuVppV7o0Yap3iQnXlFiwMwM4lc=;
        b=JG3Ngu+z3s7e7w/630KeBQZ4oPmrDDOmAhDuvok/IZUFKbaUQO7mzpQcqHeRwVFb9V
         DJNJy0mg/xKE1L1bMere/gy8FvseuwGEauir6M3TZb7RFcuucJHHdokVC+rJEXOkvV63
         au0wwawooafC2sfanei2ZOH1z2du7DGnkUyh5ARGv8+8ol3d1NM1+zmcYlr9URvXRq3E
         PzJfKw8ZIYo5uHEZVPSRyOdUn1909rLGhhkkqrmVQzfk23mLi1sREqPiUoj1SwFowd+g
         Kr/iGiIs2okvITtfzTpfIah3IGkBlYH8AMBaLYrvRUEdm0FEEymXpBnvfnBqj8rF/nvr
         Sl3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Mon, 19 Mar 2018 14:40:51 +0100
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
Message-ID: <20180319134050.GA12554@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-7-ravi.bangoria@linux.vnet.ibm.com>
 <20180315144959.GB19643@redhat.com>
 <c93216a4-a4e1-dd8f-00be-17254e308cd1@linux.vnet.ibm.com>
 <20180316175030.GA28770@redhat.com>
 <4b337afd-fc5e-6110-888b-d4fa36a797ee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b337afd-fc5e-6110-888b-d4fa36a797ee@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827186487084438?=
X-GMAIL-MSGID: =?utf-8?q?1595373633012176527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ravi,

On 03/19, Ravi Bangoria wrote:
>
> On 03/16/2018 11:20 PM, Oleg Nesterov wrote:
> >
> > And it seems that you are trying to confuse yourself, not only me ;) Just
> > suppose that an application does mmap+munmap in a loop and the mapped region
> > contains uprobe but not the counter.
>
> this is fine because ...

Yes, I guess I tried to say "counter but not uprobe" but possibly I was actually
confused.

> Our initial design was to increment counter in install_breakpoint() but
> uprobed instruction gets patched in a very early stage of binary loading
> and vma that holds the counter may not be mapped yet.

Yes, yes, I understand this is not that simple...

> > Btw, why do we need a counter, not a boolean? Who else can modify it?
> > Or different uprobes can share the same counter?
>
> Yes, multiple SDT markers can share the counter.

OK, thanks.

Oleg.
