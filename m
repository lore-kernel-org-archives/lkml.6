Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1672AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73E82175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ia/cl/8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfBFMvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:51:14 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:36327 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfBFMvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1549457473; x=1580993473;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=c30j1jBoxCPs4EVxPhFuqO1NAS4gRcXcpTLiUyHbDBQ=;
  b=ia/cl/8sKM3DLQWMyQKmf2Ey6Is2IE2szNSXwihFyM3dyPOFlNLoLHfq
   laQ38RZTrjLQZUomSYWQv6F0KLcYf6WdL1PdTT/HIwBhOZxepRxQRi5WO
   xDEJYn2Hs4F1Xw0hBjNFnhAZOrkR/Ck+GreoArzqzvbaBuY+f6WtIHTSt
   U=;
X-IronPort-AV: E=Sophos;i="5.58,339,1544486400"; 
   d="scan'208";a="379949945"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2019 12:51:11 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x16CovSP070579
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
        Wed, 6 Feb 2019 12:51:00 GMT
From:   Julian Stecklina <jsteckli@amazon.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Julian Stecklina <js@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jschoenh@amazon.de,
        Dave Jiang <dave.jiang@intel.com>,
        Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] x86/boot: increase maximum number of avoided KASLR regions
References: <1548866403-13390-1-git-send-email-js@alien8.de>
        <1548866403-13390-2-git-send-email-js@alien8.de>
        <20190205144441.GS21801@zn.tnic>
Date:   Wed, 06 Feb 2019 13:50:57 +0100
In-Reply-To: <20190205144441.GS21801@zn.tnic> (Borislav Petkov's message of
        "Tue, 5 Feb 2019 15:44:41 +0100")
Message-ID: <ciirm8womdaxn2.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

>> @@ -213,7 +213,7 @@ static void mem_avoid_memmap(char *str)
>>  		i++;
>>  	}
>>  
>> -	/* More than 4 memmaps, fail kaslr */
>> +	/* Can't store all regions, fail kaslr */
>>  	if ((i >= MAX_MEMMAP_REGIONS) && str)
>>  		memmap_too_large = true;
>>  }
>> -- 
>
> Lemme add some of the folks from
> f28442497b5caf7bf573ade22a7f8d3559e3ef56 to Cc.
>
> It all looks arbitrary to me: first 4 unusable memmap regions, this
> patch raises it to 16. Why are we even imposing such a limit?

Because at this point, we are not in a good position to handle an
unlimited amount of regions.

As for the choice of "16", I took our usecase and multiplied it by two.
FWIW, this could be even larger.

Julian
