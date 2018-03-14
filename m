Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELvhlHWYKfPaM1Dazz/6ExD8UsVFPzlwkU18ZhEVNlgBY/EksQTSD2tQMk30a5xYY59Puj2j
ARC-Seal: i=1; a=rsa-sha256; t=1521028100; cv=none;
        d=google.com; s=arc-20160816;
        b=IeTd2jqcZZYpxwofAt9WipEwwVc74imh2nXBR/+3Doo0a/xApDn7d3cvOo+G27GODB
         IJDotPO+p5c5QmG1O4l5NTE+qV3JOc11O1QHff7r7s2taZ9jmG3BqK2oCbHpHs8uKAPX
         gxdlmqB2SuICQzXNelU6J6NO4xiVABmZUA7/PB0c82wm8pgvmL/f2NsjO3SYgNaIJdxo
         mMDADZx8uGRHZBt6j0jC26oxal9hb1A4H8NHy3u/Wr7Ak+izPDIwxILQxiGbcyWZk2BO
         p3FZAe6pnQ+d+D4xtml4wUqSHhlWK55XD1xfINcOoIStg70jWtW6pilFjpDWR5WNF+PW
         vPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=t4+MeAEYakD50rNX18LEvjkh6zowXVOg8yCN98TvmPY=;
        b=qr/jcAUzrp/eUYGwREpuKhD8jsXOuhgKltij0syvddSmfgo65Zh35Jo69mFwQftm0Y
         AOsV046JS0hbw3nO+QRAe8O0lef0g8CA8gzVveDLzllpE2pdRD+tm0O8JFsH0JjDieDq
         MTXW+DNdRU0LFwPpnK2mZH2H6ppGWoFwFDn3TC4WLRmsI7P9njmAmMSjArxPo5+Xor4a
         H0xpE9G/AvHLaZW2d34nM2z3/qszuBQdKOlybyylTHd+nHSosEOdWCG3xdvKwsyjOFnA
         IQhuSbIqZZ8z9IolAMrtLl5OCpc2IKLDFZLWaKoIWSm9pnRJJi6ZrRcDxUzJxINKti7W
         a2Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Wed, 14 Mar 2018 11:48:15 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	james.morse@arm.com, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org, toshi.kani@hpe.com
Subject: Re: [PATCH v1 2/4] ioremap: Invalidate TLB after huge mappings
Message-ID: <20180314114814.mzgwlzkwzxijiv54@lakrids.cambridge.arm.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-3-git-send-email-cpandya@codeaurora.org>
 <20180314104823.yumqomzmbu3cj442@lakrids.cambridge.arm.com>
 <a278b3ca-b54f-ee5e-5828-b8859eea5cc6@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a278b3ca-b54f-ee5e-5828-b8859eea5cc6@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902270765090574?=
X-GMAIL-MSGID: =?utf-8?q?1594913561847610559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:50:35PM +0530, Chintan Pandya wrote:
> On 3/14/2018 4:18 PM, Mark Rutland wrote:
> > On Wed, Mar 14, 2018 at 02:18:23PM +0530, Chintan Pandya wrote:
> > As has been noted in previous threads, the ARM architecture requires a
> > Break-Before-Make sequence when changing an entry from a table to a
> > block, as is the case here.
> > 
> > The means the necessary sequence is:
> > 
> > 	1. Make the entry invalid
> > 	2. Invalidate relevant TLB entries
> > 	3. Write the new entry
> > 
> We do this for PTEs. I don't see this applicable to PMDs.

The architecture requires this for *all* levels of page table, when
certain changes are made. Switching an entry from a table to block (or
vice versa) is one of those changes, and this definitely applies to
PMDs.

> Because,
> 
> 1) To mark any PMD invalid, we need to be sure that next level page
>    table (I mean all the 512 PTEs) should be zero. That requires us
>    to scan entire last level page. A big perf hit !

This is in ioremap code. Under what workload does this constitute a perf
hit?

Regardless, so long as we mark the pmd entry invalid before the TLB
invalidation, we don't need to touch the next level table at all. We
just require a sequence like:

	pmd_clear(*pmdp);
	flush_tlb_kernel_range(pmd_start_addr, pmd_end_addr);
	pmd_set_huge(*pmdp, phys, prot);


> 2) We need to perform step 1 for every unmap as we never know which
>    unmap will make last level page table empty.

Sorry, I don't follow. Could you elaborate on the problem?

> Moreover, problem comes only when 4K mapping was followed by 2M
> mapping. In all other cases, retaining valid PMD has obvious perf
> gain. That's what walk-cache is supposed to be introduced for.

Retaining a valid PMD in the TLB that *differs* from a valid PMD in the
page tables is a big problem.

The architecture requires BBM, as this permits CPUs to allocate PMDs
into TLBs at *any* time, even if there's already PMD in the TLB for a
given address.

Thus, CPUs can allocate *both* valid PMDs into the TLBs. When this
happens, a TLB lookup can:

1) return either of the PMDs.

2) raise a TLB conflict abort.

3) return an amalgamation of the two entries (e.g. provide an erroneous
   address).

Note that (3) is particularly scary:

* The CPU could raise an SError if the amalgamated entry is junk.

* If a memory access hits an amalgamated entry, it may use the wrong
  physical address, attributes, or permissions, resulting in a number of
  potential problems.

* If the amalgamated entry looks like a partial walk, the TLB might try
  to perform a walk starting at the physical address in the amalgamated
  entry. This would cause page table walks to access bogus addresses,
  allocating junk into TLBs, and may result in SErrors or other aborts.

> > Whereas above, the sequence is
> > 
> > 	1. Write the new entry
> > 	2. invalidate relevant TLB entries
> > 
> > Which is insufficient, and will lead to a number of problems.
> I couldn't think of new problems with this approach. Could you share
> any problematic scenarios ?

Please see above.

> Also, my test-case runs fine with these patches for 10+ hours.

While this may happen to work on particular platforms, it is not
guaranteed per the architecture, and will fail on others.

Thanks,
Mark.
