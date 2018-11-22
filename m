Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D88C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025CC20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025CC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbeKVXvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:51:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbeKVXvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:51:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C06683622;
        Thu, 22 Nov 2018 05:11:50 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3B523F5CF;
        Thu, 22 Nov 2018 05:11:49 -0800 (PST)
Date:   Thu, 22 Nov 2018 13:11:44 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/2] scripts/decode_stacktrace: Only strip base path when
 a prefix of the path
Message-ID: <20181122131144.e5cxxtqzetawjji4@lakrids.cambridge.arm.com>
References: <20181122121440.74913-1-marc.zyngier@arm.com>
 <20181122121440.74913-3-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122121440.74913-3-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:14:40PM +0000, Marc Zyngier wrote:
> Running something like:
> 
> 	decodecode vmlinux .
> 
> leads to interested results where not only the leading "." gets stripped
> from the displayed paths, but also anywhere in the string, displaying
> something like:
> 
> 	kvm_vcpu_check_block (arch/arm64/kvm/virt/kvm/kvm_mainc:2141)
> 
> which doesn't help further processing.
> 
> Fix it by only stripping the base path if it is a prefix of the path.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  scripts/decode_stacktrace.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 64220e36ce3b..98a7d63a723e 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -78,7 +78,7 @@ parse_symbol() {
>  	fi
>  
>  	# Strip out the base of the path
> -	code=${code//$basepath/""}
> +	code=${code//^$basepath/""}

FWIW, you can do this using the usual POSIX shell string substitution:

	code=${code##$basepath}

[1] http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_06_02

Mark.
