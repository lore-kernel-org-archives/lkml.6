Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5C4ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313D120685
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e9lQkjfj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S0hFV8KW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313D120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeIRLzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:55:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIRLzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:55:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F033C60C8E; Tue, 18 Sep 2018 06:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537251877;
        bh=VAQjts6g5++OWkwxoNdabJ+ffnqQFVPuY2RbyedWesI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e9lQkjfj+QCVwuE/viFSRtD0rbF/DMIJjpE/QloORwtxGCftKB3f6iWlIcPfBZQHc
         XyBpYaJPYlsazAuvhxZ3wrJ6LG4sbPmCVCWPof4ZcgKZDessICtvzHzSotrFUukLzw
         k4kx7DBKcvo31j4wvhoO2LPRKVQZ65g0PVizptqY=
Received: from [10.79.129.80] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44C2960213;
        Tue, 18 Sep 2018 06:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537251872;
        bh=VAQjts6g5++OWkwxoNdabJ+ffnqQFVPuY2RbyedWesI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S0hFV8KWs8z23bkfO4K3j5KvVQJqPG9TM9MAS2gJKPOHgD6G0c1pCt7fp9DKH4+wp
         btdt+4DnHGS6BF90Ealp0RuVmcmZmavVsupYUOKaO0oijxexIqY80GwnSzR6g6q26b
         JB0PSZmNEBhrzd1dkQuxh5MhwiM81tkCf2nYzUSI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44C2960213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>, robh@kernel.org
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <141901b8-0a9a-2e7a-f7a4-cdefd157f4c6@codeaurora.org>
 <20180917190454.3cfbe7e3@gandalf.local.home>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <a041a44b-91cc-8b98-0147-ce983ae83cf2@codeaurora.org>
Date:   Tue, 18 Sep 2018 11:54:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917190454.3cfbe7e3@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2018 4:34 AM, Steven Rostedt wrote:
> On Sun, 16 Sep 2018 12:37:52 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> Hi,
>>
>> Anyone here?
> 
> You also just caught me from coming back from a trip. I'm looking at
> your patches now.
> 
> -- Steve
> 

Thanks Steve, I just thought you guys might have missed the patch.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
