Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3868AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FB72147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FB72147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbeGMHEX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:04:23 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:49396 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbeGMHEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:04:23 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6D6or7h016333
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Jul 2018 15:50:53 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6D6orbh017692;
        Fri, 13 Jul 2018 15:50:53 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6D6mFY1019146;
        Fri, 13 Jul 2018 15:50:53 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-1931052; Fri, 13 Jul 2018 15:49:18 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0319.002; Fri,
 13 Jul 2018 15:49:18 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v5 06/11] mm, memory_failure: Collect mapping size in
 collect_procs()
Thread-Topic: [PATCH v5 06/11] mm, memory_failure: Collect mapping size in
 collect_procs()
Thread-Index: AQHUE+EV4wHT8Yr900u++c7tuoi4FaSMLJkA
Date:   Fri, 13 Jul 2018 06:49:16 +0000
Message-ID: <20180713064916.GB10034@hori1.linux.bs1.fc.nec.co.jp>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153074045526.27838.11460088022513024933.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153074045526.27838.11460088022513024933.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <91675B8EB5C02F4A93C6F4133359C60B@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:40:55PM -0700, Dan Williams wrote:
> In preparation for supporting memory_failure() for dax mappings, teach
> collect_procs() to also determine the mapping size. Unlike typical
> mappings the dax mapping size is determined by walking page-table
> entries rather than using the compound-page accounting for THP pages.
> 
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me.

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
>  mm/memory-failure.c |   81 +++++++++++++++++++++++++--------------------------
>  1 file changed, 40 insertions(+), 41 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 9d142b9b86dc..4d70753af59c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -174,22 +174,51 @@ int hwpoison_filter(struct page *p)
>  EXPORT_SYMBOL_GPL(hwpoison_filter);
>  
>  /*
> + * Kill all processes that have a poisoned page mapped and then isolate
> + * the page.
> + *
> + * General strategy:
> + * Find all processes having the page mapped and kill them.
> + * But we keep a page reference around so that the page is not
> + * actually freed yet.
> + * Then stash the page away
> + *
> + * There's no convenient way to get back to mapped processes
> + * from the VMAs. So do a brute-force search over all
> + * running processes.
> + *
> + * Remember that machine checks are not common (or rather
> + * if they are common you have other problems), so this shouldn't
> + * be a performance issue.
> + *
> + * Also there are some races possible while we get from the
> + * error detection to actually handle it.
> + */
> +
> +struct to_kill {
> +	struct list_head nd;
> +	struct task_struct *tsk;
> +	unsigned long addr;
> +	short size_shift;
> +	char addr_valid;
> +};
> +
> +/*
>   * Send all the processes who have the page mapped a signal.
>   * ``action optional'' if they are not immediately affected by the error
>   * ``action required'' if error happened in current execution context
>   */
> -static int kill_proc(struct task_struct *t, unsigned long addr,
> -			unsigned long pfn, struct page *page, int flags)
> +static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
>  {
> -	short addr_lsb;
> +	struct task_struct *t = tk->tsk;
> +	short addr_lsb = tk->size_shift;
>  	int ret;
>  
>  	pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory corruption\n",
>  		pfn, t->comm, t->pid);
> -	addr_lsb = compound_order(compound_head(page)) + PAGE_SHIFT;
>  
>  	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
> -		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)addr,
> +		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
>  				       addr_lsb, current);
>  	} else {
>  		/*
> @@ -198,7 +227,7 @@ static int kill_proc(struct task_struct *t, unsigned long addr,
>  		 * This could cause a loop when the user sets SIGBUS
>  		 * to SIG_IGN, but hopefully no one will do that?
>  		 */
> -		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)addr,
> +		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
>  				      addr_lsb, t);  /* synchronous? */
>  	}
>  	if (ret < 0)
> @@ -235,35 +264,6 @@ void shake_page(struct page *p, int access)
>  EXPORT_SYMBOL_GPL(shake_page);
>  
>  /*
> - * Kill all processes that have a poisoned page mapped and then isolate
> - * the page.
> - *
> - * General strategy:
> - * Find all processes having the page mapped and kill them.
> - * But we keep a page reference around so that the page is not
> - * actually freed yet.
> - * Then stash the page away
> - *
> - * There's no convenient way to get back to mapped processes
> - * from the VMAs. So do a brute-force search over all
> - * running processes.
> - *
> - * Remember that machine checks are not common (or rather
> - * if they are common you have other problems), so this shouldn't
> - * be a performance issue.
> - *
> - * Also there are some races possible while we get from the
> - * error detection to actually handle it.
> - */
> -
> -struct to_kill {
> -	struct list_head nd;
> -	struct task_struct *tsk;
> -	unsigned long addr;
> -	char addr_valid;
> -};
> -
> -/*
>   * Failure handling: if we can't find or can't kill a process there's
>   * not much we can do.	We just print a message and ignore otherwise.
>   */
> @@ -292,6 +292,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>  	}
>  	tk->addr = page_address_in_vma(p, vma);
>  	tk->addr_valid = 1;
> +	tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
>  
>  	/*
>  	 * In theory we don't have to kill when the page was
> @@ -317,9 +318,8 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>   * Also when FAIL is set do a force kill because something went
>   * wrong earlier.
>   */
> -static void kill_procs(struct list_head *to_kill, int forcekill,
> -			  bool fail, struct page *page, unsigned long pfn,
> -			  int flags)
> +static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
> +		unsigned long pfn, int flags)
>  {
>  	struct to_kill *tk, *next;
>  
> @@ -342,8 +342,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill,
>  			 * check for that, but we need to tell the
>  			 * process anyways.
>  			 */
> -			else if (kill_proc(tk->tsk, tk->addr,
> -					      pfn, page, flags) < 0)
> +			else if (kill_proc(tk, pfn, flags) < 0)
>  				pr_err("Memory failure: %#lx: Cannot send advisory machine check signal to %s:%d\n",
>  				       pfn, tk->tsk->comm, tk->tsk->pid);
>  		}
> @@ -1012,7 +1011,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>  	 * any accesses to the poisoned memory.
>  	 */
>  	forcekill = PageDirty(hpage) || (flags & MF_MUST_KILL);
> -	kill_procs(&tokill, forcekill, !unmap_success, p, pfn, flags);
> +	kill_procs(&tokill, forcekill, !unmap_success, pfn, flags);
>  
>  	return unmap_success;
>  }
> 
> 
