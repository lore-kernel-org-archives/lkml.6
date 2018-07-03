Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED63C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B81924718
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B81924718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeGCWtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:49:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbeGCWtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:49:16 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A95CCB2;
        Tue,  3 Jul 2018 22:49:16 +0000 (UTC)
Date:   Tue, 3 Jul 2018 15:49:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Norbert Manthey <nmanthey@amazon.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [build-check] scripts: add check_build script
Message-Id: <20180703154914.5d3e8f28e1d87e48180073e3@linux-foundation.org>
In-Reply-To: <1530623539-650-1-git-send-email-nmanthey@amazon.de>
References: <1530186789-28808-1-git-send-email-nmanthey@amazon.de>
        <1530623539-650-1-git-send-email-nmanthey@amazon.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 15:12:10 +0200 Norbert Manthey <nmanthey@amazon.de> wrote:

> This script performs build testing, by building several configurations
> several times. The script is introduced to improve the consistency of
> testing changes in the kernel configuration.
> 
> This version build randconfig 10 times, as well as allyesconfig,
> allnoconfig and allmodconfig. Depending on the used machine and system
> setup, the script might take a while to finish.
> 
> The script logs all the used config files, as well as the output of the
> build commands to a log directory "build_check_logs", so that this data
> can be retrieved after running the script.

I'm unable to even guess how many people will find this useful.

> +build ()
> +{
> +	local -r LOG_FILE="$1"
> +	local -i STATUS=0
> +
> +	make clean -j $(nproc) &> /dev/null
> +	make -j $(nproc) &>> "$LOG_FILE" || STATUS=$?
> +
> +	echo "build status: $STATUS" >> "$LOG_FILE"
> +	echo "[$SECONDS] build status: $STATUS"
> +	return "$STATUS"
> +}

The script never sets nproc.  So I guess this is a bare `make -j'. 
When I type that on my (quite beefy) workstation I get eleventy xillion
processes and the machine locks up.  Can't even wiggle the mouse. 
After a 20 minute nap (thanks!) it was still comatose so I hit the big
button (who writes this junk??).

So you might want to take an educated guess from /proc/cpuinfo here.
