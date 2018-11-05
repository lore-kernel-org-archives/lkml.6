Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B6DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A77320869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NYiYLY0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A77320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeKFFNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:13:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43756 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeKFFNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=moq2FjQAi+Yv6iK21DRu7ITctBWf6IR9fdLkymtdLtY=; b=NYiYLY0Gyd2AOhXan9oQJJXK4s
        mJ7tvx31jJIkLyrODKP45D5e4qUa3bzV+UoZ3ZYqGCJ77SHFC/ID3YYu9DXOT0XJhmMJGREQozXzJ
        xeFz19Kc2cEscBl6wjvS8Mdg+7ZfEhT5He0lPGW5yBMI5EDUoXHcXXMYKgwziQQHkVhZjPt563zXp
        bFxXdQ1WWina1l0+9KK8UzzOLKo6m8G2LFxTXU0YaNpFSLo1GPyv+f41oBSKodleTrKDi2HUDq1K+
        aVu14v7m0CPrxmGINN+z3ajzL2uMBtXgSHvB2e82pHMO5hfh382RqzpeYVdQruTe0wR2SR83LiAco
        hjoT+GNw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJkuw-0000V0-Fg; Mon, 05 Nov 2018 19:52:10 +0000
Subject: Re: [PATCH v6 5/5] sidechannel: Linux Security Module for sidechannel
To:     Casey Schaufler <casey.schaufler@intel.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        dave.hansen@intel.com, deneen.t.dock@intel.com,
        kristen@linux.intel.com, arjan@linux.intel.com
References: <20181105190504.500-1-casey.schaufler@intel.com>
 <20181105190504.500-6-casey.schaufler@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <35bac572-14cc-d7c3-f788-1120c7431fb4@infradead.org>
Date:   Mon, 5 Nov 2018 11:52:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105190504.500-6-casey.schaufler@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On 11/5/18 11:05 AM, Casey Schaufler wrote:
> diff --git a/security/sidechannel/Kconfig b/security/sidechannel/Kconfig
> new file mode 100644
> index 000000000000..653033027415
> --- /dev/null
> +++ b/security/sidechannel/Kconfig
> @@ -0,0 +1,13 @@
> +config SECURITY_SIDECHANNEL
> +	bool "Sidechannel attack safety extra checks"
> +	depends on SECURITY
> +	default n

Please drop the "default n" since it is already the default value.

> +	help
> +	  Look for a variety of cases where a side-channel attack
> +	  could potentially be exploited. Instruct the switching
> +	  code to use the indirect_branch_prediction_barrier in
> +	  cases where the passed task and the current task may be
> +	  at risk.
> +
> +          If you are unsure how to answer this question, answer N.

Use tab + 2 spaces to indent the line above.
> +

thanx.
-- 
~Randy
