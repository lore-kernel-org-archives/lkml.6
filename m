Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C85C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D23D2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DegN4F0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D23D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbeKFGNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:13:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44748 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeKFGNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EX65ZqpYm5TG7BdnK2QxcpseC01FJqY+W5b4z8PLEZw=; b=DegN4F0UCijvUMdTai7btmPpC/
        mV/f4hk0M+gON1xBfoHYzkrcbmri/vIW8lIorwCXvrDr3E3RzcvUhBxKyozGiMjD+p/5vqOUNsk7x
        W8iyibQ2aDBFp/McLCOx72Tj8pRJvhqoiL2xz1r9nB2aPfXLk0q5EEyqJK+m4mAOgXi2EgNMfVNEo
        U3CaK71bNObpjGcjJ4MRR5rwZ4cH0zU1LlmAhoA+emZgQHFtgmanFHWOCYjUYZkoth29ZpLJGVVn6
        nJVmhdu45lLKCN+cPxUhT1HwzCKqJuJ+PcaBoT2zQATkVgT4ogiBxZ6E6+hIETkx78IhmS4GfPO5I
        Jfle7LNw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJlqS-0000rr-AY; Mon, 05 Nov 2018 20:51:36 +0000
Subject: Re: [RFC PATCH v4 02/13] ktask: multithread CPU-intensive kernel work
To:     Daniel Jordan <daniel.m.jordan@oracle.com>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        steven.sistare@oracle.com, tim.c.chen@intel.com, tj@kernel.org,
        vbabka@suse.cz
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-3-daniel.m.jordan@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <736b23a4-cb32-7926-101a-9b6555e59b5e@infradead.org>
Date:   Mon, 5 Nov 2018 12:51:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105165558.11698-3-daniel.m.jordan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 8:55 AM, Daniel Jordan wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index 41583f468cb4..ed82f76ed0b7 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -346,6 +346,17 @@ config AUDIT_TREE
>  	depends on AUDITSYSCALL
>  	select FSNOTIFY
>  
> +config KTASK
> +	bool "Multithread CPU-intensive kernel work"
> +	depends on SMP
> +	default y
> +	help
> +	  Parallelize CPU-intensive kernel work.  This feature is designed for
> +          big machines that can take advantage of their extra CPUs to speed up
> +	  large kernel tasks.  When enabled, kworker threads may occupy more
> +          CPU time during these kernel tasks, but these threads are throttled
> +          when other tasks on the system need CPU time.

Use tab + 2 spaces consistently for help text indentation, please.

> +
>  source "kernel/irq/Kconfig"
>  source "kernel/time/Kconfig"
>  source "kernel/Kconfig.preempt"


-- 
~Randy
