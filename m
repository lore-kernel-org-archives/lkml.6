Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E78C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE25225BD9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE25225BD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933837AbeGBLSN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:18:13 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:33837 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933436AbeGBLSH (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:7:1>);
        Mon, 2 Jul 2018 07:18:07 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 02 Jul 2018 05:18:06 -0600
Message-Id: <5B3A09EA02000078001CFBB7@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Mon, 02 Jul 2018 05:18:02 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>, <tglx@linutronix.de>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <hpa@zytor.com>
Subject: Re: [Xen-devel] [PATCH] xen: setup pv irq ops vector earlier
References: <20180702100001.19953-1-jgross@suse.com>
In-Reply-To: <20180702100001.19953-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 02.07.18 at 12:00, <jgross@suse.com> wrote:
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1213,6 +1213,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
>  	pv_info = xen_info;
>  	pv_init_ops.patch = paravirt_patch_default;
>  	pv_cpu_ops = xen_cpu_ops;
> +	xen_init_irq_ops();

Isn't this still too late? xen_setup_machphys_mapping(), for example,
has a WARN_ON(), which implies multiple printk()s.

Jan


