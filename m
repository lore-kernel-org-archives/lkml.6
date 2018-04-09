Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeDINRj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:17:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750982AbeDINRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:17:37 -0400
Date: Mon, 9 Apr 2018 15:17:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, acme@kernel.org, ananth@linux.vnet.ibm.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        jolsa@redhat.com, kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com
Subject: Re: [PATCH v2 7/9] trace_uprobe/sdt: Fix multiple update of same
 reference counter
Message-ID: <20180409131730.GA25631@redhat.com>
References: <20180404083110.18647-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180404083110.18647-8-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404083110.18647-8-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04, Ravi Bangoria wrote:
>
> +static void sdt_add_mm_list(struct trace_uprobe *tu, struct mm_struct *mm)
> +{
> +	struct mmu_notifier *mn;
> +	struct sdt_mm_list *sml = kzalloc(sizeof(*sml), GFP_KERNEL);
> +
> +	if (!sml)
> +		return;
> +	sml->mm = mm;
> +	list_add(&(sml->list), &(tu->sml.list));
> +
> +	/* Register mmu_notifier for this mm. */
> +	mn = kzalloc(sizeof(*mn), GFP_KERNEL);
> +	if (!mn)
> +		return;
> +
> +	mn->ops = &sdt_mmu_notifier_ops;
> +	__mmu_notifier_register(mn, mm);
> +}

I didn't read this version yet, just one question...

So now it depends on CONFIG_MMU_NOTIFIER, yes? I do not see any changes in Kconfig
files, this doesn't look right...

Oleg.
