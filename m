Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9564AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682D320868
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfAGC3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:29:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfAGC3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:29:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2062E2D7E3;
        Mon,  7 Jan 2019 02:29:35 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22A60100034A;
        Mon,  7 Jan 2019 02:29:28 +0000 (UTC)
Date:   Mon, 7 Jan 2019 10:29:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        akpm@linux-foundation.org, dyoung@redhat.com,
        linux-doc@vger.kernel.org, k-hagio@ab.jp.nec.com,
        anderson@redhat.com
Subject: Re: [PATCH 2/2 v5] kdump,vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
Message-ID: <20190107022925.GF30750@MiWiFi-R3L-srv>
References: <20190107014734.9730-1-lijiang@redhat.com>
 <20190107014734.9730-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107014734.9730-3-lijiang@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 07 Jan 2019 02:29:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/19 at 09:47am, Lianbo Jiang wrote:
> For AMD machine with SME feature, makedumpfile tools need to know
> whether the crash kernel was encrypted or not. If SME is enabled
              ^ crashed
> in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
                           ^ crashed
> contains the memory encryption mask, so need to remove the sme mask
                                        "makedumpfile needs" or
                                       in makedumpfile need to remove...
> to obtain the true physical address.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 4c8acdfdc5a7..bc4108096b18 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -352,10 +352,13 @@ void machine_kexec(struct kimage *image)
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> +	u64 sme_mask = sme_me_mask;
> +
>  	VMCOREINFO_NUMBER(phys_base);
>  	VMCOREINFO_SYMBOL(init_top_pgt);
>  	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>  			pgtable_l5_enabled());
> +	VMCOREINFO_NUMBER(sme_mask);
>  
>  #ifdef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(node_data);
> -- 
> 2.17.1
> 
