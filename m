Return-Path: <oleg@redhat.com>
X-Google-Smtp-Source: AG47ELuuDWAiCGMHMsBnrx96piuULqIrz6CU9vv5do3xqSNOxlVzpaKmj9Y6tu40y1GuMdHUgIY4
ARC-Seal: i=1; a=rsa-sha256; t=1521222637; cv=none;
        d=google.com; s=arc-20160816;
        b=KJO5nO5TIQ9tjoT8uQDVZ89ikGHYIGYLxTzucACYEStdEZdsL/+FC6nlu47G2W5Xbz
         7TBjPpOC1Zd4fNT4j4BEv0xEF4D833662d1snDhY43wSSWkdU8NB3SdOgYZpGpRGN6xO
         ql3GHnqF+UzZLmHGgcCzTWLrD8kkEJeV/e9j07niWLw5AWf+Pjzg1YobItlb2VzQSQYa
         fJXlpjB6dfww7Ifa/LH/HveZrnEOdxcNKLR9ZG+209+w2CztCjupbDclJ50soahY5F9F
         pFKhv3aewvRXAkX7FA2AXkNHRWSX4HdPVgelX0CHLkiVFfezg1Ez/ryHl8ODor0pBlaH
         STaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=G49CLIrvhU/L2R75PTWrJILQu3VW3lWD0CCBRbmrR3E=;
        b=tz1210NfxXeY73jfCs5B+89GjhAW0KohBB+2IvsLp5JvoB0v/s54QRShUoWFIXKb0x
         bEyQar8gXxW+DUa8ufM5Cvs44ePBRAPInS604UU9wOq23CD7wuMQ/gR1uB/cUK53JssC
         RkB6Pn5CZn0j1pXQ/xxOoYxl7qyg54TuBLXIBGNFQwGNEhg57OTvS037MJirkPH8Czrq
         K0Qd0Td0SKC/0l5L8wr4phbKCvZ3Zs/vhr520P2IETo0xgxoEMjbEt/nyA7IZTL5GBf7
         n1T45ACymUWVwMcdyAoPxXeMDEEz+GbG4wo3VyiUkbhuMFkDpPfdys0CMDNqWbugP7YM
         ZsIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oleg@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=oleg@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Fri, 16 Mar 2018 18:50:30 +0100
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
Message-ID: <20180316175030.GA28770@redhat.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180313125603.19819-7-ravi.bangoria@linux.vnet.ibm.com>
 <20180315144959.GB19643@redhat.com>
 <c93216a4-a4e1-dd8f-00be-17254e308cd1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c93216a4-a4e1-dd8f-00be-17254e308cd1@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827186487084438?=
X-GMAIL-MSGID: =?utf-8?q?1595117548223200238?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16, Ravi Bangoria wrote:
>
> On 03/15/2018 08:19 PM, Oleg Nesterov wrote:
> > On 03/13, Ravi Bangoria wrote:
> >> For tiny binaries/libraries, different mmap regions points to the
> >> same file portion. In such cases, we may increment reference counter
> >> multiple times.
> > Yes,
> >
> >> But while de-registration, reference counter will get
> >> decremented only by once
> > could you explain why this happens? sdt_increment_ref_ctr() and
> > sdt_decrement_ref_ctr() look symmetrical, _decrement_ should see
> > the same mappings?

...

>     # strace -o out python
>       mmap(NULL, 2738968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fff92460000
>       mmap(0x7fff926a0000, 327680, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x230000) = 0x7fff926a0000
>       mprotect(0x7fff926a0000, 65536, PROT_READ) = 0

Ah, in this case everything is clear, thanks.

I was confused by the changelog, I misinterpreted it as if inc/dec are not
balanced in case of multiple mappings even if the application doesn't play
with mmap/mprotect/etc.

And it seems that you are trying to confuse yourself, not only me ;) Just
suppose that an application does mmap+munmap in a loop and the mapped region
contains uprobe but not the counter.

And this all makes me think that we should do something else. Ideally,
install_breakpoint() and remove_breakpoint() should inc/dec the counter
if they do not fail...

Btw, why do we need a counter, not a boolean? Who else can modify it?
Or different uprobes can share the same counter?

Oleg.
