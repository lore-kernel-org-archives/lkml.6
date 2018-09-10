Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70559C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F400E206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NKs9RrQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F400E206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeIJHmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:42:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44446 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeIJHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z1Nwqfdt88dHF7ZC/NCDGGjZrZLPYEOeUlsxoH6d5H4=; b=NKs9RrQ6HoPkD0XAWyWUrlKq+0
        CO4EPggFHOI6aU++DEnHrgy+OZY1Pp3CFTxqC2EQyPeaAsiwq8lF1fZIB23ZNPoz5kdBYjbGYzhqM
        g6cEHiOvFDyIKmKHUG2yPR7ETpdwt2FgZ9gxG61YtmnwZueLSDCN/gQooxxZlcIcKkEARi4C0Hlp2
        sGZMwY0WjB/XraCziySgFfJXuci8ClUY2kZS6kIZ9Ukl/aUepiuODnifht1ET7k3onxnBnt1zNGXa
        oS5beX8L46/5euzsOFNbbNyr8v5DWCU3q/RWEVgzVncAwNMfnErHOsnYoKN4zpsi9fsFkaSecg7hr
        5VuTFJ3Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzCHl-0007bk-Sa; Mon, 10 Sep 2018 02:50:46 +0000
Subject: Re: [RFC 60/60] cosched: Add command line argument to enable
 coscheduling
To:     =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180907214047.26914-61-jschoenh@amazon.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bbe78114-37a4-e87d-028c-8498f27cd4a0@infradead.org>
Date:   Sun, 9 Sep 2018 19:50:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180907214047.26914-61-jschoenh@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/18 2:40 PM, Jan H. Schönherr wrote:
> Add a new command line argument cosched_max_level=<n>, which allows
> enabling coscheduling at boot. The number corresponds to the scheduling
> domain up to which coscheduling can later be enabled for cgroups.
> 
> For example, to enable coscheduling of cgroups at SMT level, one would
> specify cosched_max_level=1.
> 
> The use of symbolic names (like off, core, socket, system) is currently
> not possible, but could be added. However, to force coscheduling at up
> to system level not knowing the scheduling domain topology in advance,
> it is possible to just specify a too large number. It will be clamped
> transparently to system level.
> 
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> ---
>  kernel/sched/cosched.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cosched.c b/kernel/sched/cosched.c
> index eb6a6a61521e..a1f0d3a7b02a 100644
> --- a/kernel/sched/cosched.c
> +++ b/kernel/sched/cosched.c
> @@ -162,6 +162,29 @@ static int __init cosched_split_domains_setup(char *str)
>  
>  early_param("cosched_split_domains", cosched_split_domains_setup);
>  

> +
> +early_param("cosched_max_level", cosched_max_level_setup);
> +

Hi,
Please document both of these kernel parameters in
Documentation/admin-guide/kernel-parameters.txt.

thanks,
-- 
~Randy
