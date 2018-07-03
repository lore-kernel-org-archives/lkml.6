Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1792FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B836624768
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b6KgBlSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B836624768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeGCX1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:27:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeGCX1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oy4vdV+YyGDp8N8JejNSgfuzbZnkME9IlLzh2YFEx5U=; b=b6KgBlSU9XmMQ/7eqRHwAGkUn
        9ydqrpvOVrC9Crx1qDPccNc17aBXsjp05bT9vHQsa/Z5HjpANwJGog62y+8w80izimDxDw2SLJCjK
        2PEw095CHj56HEUv3l8LhElOQy5aOGuouF0hbBTHBWkO1W3skrfdX0CDg4AdfDfI/1EzowUMg+OVs
        q7hN2xnRH+ne4RyMjj+HWR7yMJB2mSEgEH63/Ev1IEqz3euWlM1LXiEOtzXmrYCes4kkrSDO8VjBF
        Lxo2AApybBgn2zpnSCHAc1XvFIxyRXPcKMWtCDpqdto1A0C+/s7wJoGlOssyC032OowAEVIAZTwJQ
        sWZLlrovQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faUhP-0007dT-9X; Tue, 03 Jul 2018 23:27:07 +0000
Subject: Re: [build-check] scripts: add check_build script
To:     Andrew Morton <akpm@linux-foundation.org>,
        Norbert Manthey <nmanthey@amazon.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org
References: <1530186789-28808-1-git-send-email-nmanthey@amazon.de>
 <1530623539-650-1-git-send-email-nmanthey@amazon.de>
 <20180703154914.5d3e8f28e1d87e48180073e3@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <01151c44-c3f7-c344-8e58-2e6b348960fb@infradead.org>
Date:   Tue, 3 Jul 2018 16:27:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703154914.5d3e8f28e1d87e48180073e3@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 03:49 PM, Andrew Morton wrote:
> On Tue, 3 Jul 2018 15:12:10 +0200 Norbert Manthey <nmanthey@amazon.de> wrote:
> 
>> This script performs build testing, by building several configurations
>> several times. The script is introduced to improve the consistency of
>> testing changes in the kernel configuration.
>>
>> This version build randconfig 10 times, as well as allyesconfig,
>> allnoconfig and allmodconfig. Depending on the used machine and system
>> setup, the script might take a while to finish.
>>
>> The script logs all the used config files, as well as the output of the
>> build commands to a log directory "build_check_logs", so that this data
>> can be retrieved after running the script.
> 
> I'm unable to even guess how many people will find this useful.

I expect that lots of us have similar scripts.

>> +build ()
>> +{
>> +	local -r LOG_FILE="$1"
>> +	local -i STATUS=0
>> +
>> +	make clean -j $(nproc) &> /dev/null
>> +	make -j $(nproc) &>> "$LOG_FILE" || STATUS=$?
>> +
>> +	echo "build status: $STATUS" >> "$LOG_FILE"
>> +	echo "[$SECONDS] build status: $STATUS"
>> +	return "$STATUS"
>> +}
> 
> The script never sets nproc.  So I guess this is a bare `make -j'. 
> When I type that on my (quite beefy) workstation I get eleventy xillion
> processes and the machine locks up.  Can't even wiggle the mouse. 
> After a 20 minute nap (thanks!) it was still comatose so I hit the big
> button (who writes this junk??).
> 
> So you might want to take an educated guess from /proc/cpuinfo here.

or use
nproc=`getconf _NPROCESSORS_ONLN`

or double it if you want to keep processes ready/waiting.

-- 
~Randy
