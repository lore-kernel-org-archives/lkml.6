Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA72C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBF1246F9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBF1246F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeGDEHh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:07:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeGDEHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:07:36 -0400
Received: from [192.168.86.59] (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 520A1A95;
        Wed,  4 Jul 2018 04:07:36 +0000 (UTC)
Date:   Tue, 03 Jul 2018 21:07:32 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180704102120.591e1074@canb.auug.org.au>
References: <1530186789-28808-1-git-send-email-nmanthey@amazon.de> <1530623539-650-1-git-send-email-nmanthey@amazon.de> <20180703154914.5d3e8f28e1d87e48180073e3@linux-foundation.org> <01151c44-c3f7-c344-8e58-2e6b348960fb@infradead.org> <20180704102120.591e1074@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [build-check] scripts: add check_build script
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     Norbert Manthey <nmanthey@amazon.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org
From:   Andrew Morton <akpm@linux-foundation.org>
Message-ID: <9A8BFC66-8723-4E33-B82F-BDF0DBE8133C@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 3, 2018 5:21:20 PM PDT, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>Hi all,
>
>On Tue, 3 Jul 2018 16:27:06 -0700 Randy Dunlap <rdunlap@infradead.org>
>wrote:
>>
>> On 07/03/2018 03:49 PM, Andrew Morton wrote:
>> > On Tue, 3 Jul 2018 15:12:10 +0200 Norbert Manthey
><nmanthey@amazon.de> wrote:
>> >> +build ()
>> >> +{
>> >> +	local -r LOG_FILE="$1"
>> >> +	local -i STATUS=0
>> >> +
>> >> +	make clean -j $(nproc) &> /dev/null
>> >> +	make -j $(nproc) &>> "$LOG_FILE" || STATUS=$?
>> >> +
>> >> +	echo "build status: $STATUS" >> "$LOG_FILE"
>> >> +	echo "[$SECONDS] build status: $STATUS"
>> >> +	return "$STATUS"
>> >> +}  
>> > 
>> > The script never sets nproc.  So I guess this is a bare `make -j'. 
>> > When I type that on my (quite beefy) workstation I get eleventy
>xillion
>> > processes and the machine locks up.  Can't even wiggle the mouse. 
>> > After a 20 minute nap (thanks!) it was still comatose so I hit the
>big
>> > button (who writes this junk??).
>> > 
>> > So you might want to take an educated guess from /proc/cpuinfo
>here.  
>> 
>> or use
>> nproc=`getconf _NPROCESSORS_ONLN`
>> 
>> or double it if you want to keep processes ready/waiting.
>
>I have a program called nproc on my system.  It is part of coreutils.

Ohdoh, I misread, sorry. 
