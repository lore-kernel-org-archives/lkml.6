Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx494nhZtf+ZtXmgfYlOgvFuwlKf/xrg9XnX1WJBLIDalSYQLh4+OKAuuqufEfVqzvHfOUjlT
ARC-Seal: i=1; a=rsa-sha256; t=1524483446; cv=none;
        d=google.com; s=arc-20160816;
        b=xh0T/qssc9kEypfsEdD3vKpNUY4eE+XMHG9IYLWCLBRAykM4ioMj+xK858Nz487O7K
         jwqmectjeszKqpPEWmrgao9W+aL3DPaxxmYsKumfn2BtM/jalF9HIMlz65BrLSU92NfH
         /6j8cZI7DXKCbczaE2ac8vIhVZ/BVglm5xx10khF2pizuGEetEIDtpvlZ0Iq5yAkB8Es
         fZTaJvHZH0O4vTGMUX39XC2Gys/TIk9lkvV8dAMSgvmAVp+LdJ5pyF2bggRq7q7ZnKbo
         LVO9QGjqGE2r3SqCnUuDegnOpIxL6pU5sXnD96BlGMmIwkE5OkF+lP78RXtkeU7BN+g9
         O8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=mVuW3ROyZieq/WsB46NrYZIqstlVktGvCekoKPANKa0=;
        b=bOMunxGWmWtQAOWzX1l8pZwLD7UAI8p+MxDb6pbN9R03oJr8+6zVQCohSwgOrSHCIb
         zvrW3Z2poXQY+aT/ceoWJiRSYmboNlijJgZL07TcptCFMzycMtx1u97T6bhp5FfT+o0k
         TX5tqY3BF6DMOAG5qjGZVe/F/pmlthiTecOA00YpOMoA/RKoDgYdFNtPH0U2VZsjA5CO
         5RqttWXOQ5xe6aSV+FTAh7eRqpI6x64G70KDdtlKUabwJ8J/51kht+DTwn77lKAQBmbl
         mQ1elML35e9pPUPyHgwpvZTgfI1JZpHMuKi/SjGuFYOK5qruq2ARbDcp12xr0enYrEVS
         QX5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="36315313"
Subject: Re: [PATCH 5/5] x86, pti: filter at vma->vm_page_prot population
To: Nadav Amit <namit@vmware.com>
References: <20180420222018.E7646EE1@viggo.jf.intel.com>
 <20180420222028.99D72858@viggo.jf.intel.com>
 <295DB0D1-CDFB-482C-93DF-63DAA36DAE22@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Arjan van de Ven <arjan@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
 Dan Williams <dan.j.williams@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "keescook@google.com" <keescook@google.com>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@kernel.org" <mingo@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <30d4fd5a-a82f-2a94-e8cb-ad9b7d2dc5e7@linux.intel.com>
Date: Mon, 23 Apr 2018 04:37:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <295DB0D1-CDFB-482C-93DF-63DAA36DAE22@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598305663974065245?=
X-GMAIL-MSGID: =?utf-8?q?1598536754234941673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/20/2018 06:21 PM, Nadav Amit wrote:
>> pgprot_t vm_get_page_prot(unsigned long vm_flags)
>> {
>> -	return __pgprot(pgprot_val(protection_map[vm_flags &
>> +	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
>> 				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
>> 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
>> +
>> +	return arch_filter_pgprot(ret);
>> }
>> EXPORT_SYMBOL(vm_get_page_prot);
> Wouldn’t it be simpler or at least cleaner to change the protection map if
> NX is not supported? I presume it can be done paging_init() similarly to the
> way other archs (e.g., arm, mips) do.

I thought about it, but doing it there requires getting the _timing_
right.  You have to do it before the protection map gets used but after
__supported_pte_mask is totally initialized.  This seemed more
straightforward, especially as a bug fix.

What you are talking about might be a good cleanup, though.
