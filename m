Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2889AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C7420857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=autistici.org header.i=@autistici.org header.b="lK57cBQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C7420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=autistici.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbeG0BNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:13:24 -0400
Received: from confino.investici.org ([212.103.72.250]:46542 "EHLO
        confino.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbeG0BNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:13:23 -0400
X-Greylist: delayed 1362 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2018 21:13:22 EDT
Received: from evasione.investici.org (evasione-vpn.investici.org [172.16.1.11])
        by confino.investici.org (Postfix) with ESMTP id B90F462467;
        Thu, 26 Jul 2018 23:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
        s=stigmate; t=1532647894;
        bh=h0CFW0+0tSXq93ON/wN7r8IEuc6EkVs53kzdTeB4V94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=lK57cBQtDoheRTxRAPMeQJRgkYdECaDYn1ciXvXQBS4pSD35BbQHJvC/5AO3If7H+
         4HID6rV0vxJdyZMXVZLVymPEjq5WAN7ph5YkbE9Y2RukIArGw7beRwsnyhHKryqdcC
         lIElm6YngZxOTNYTNrWZh1XTPsMjativ6qpMR+cg=
Received: from [94.242.250.200] (evasione [94.242.250.200]) (Authenticated sender: rodia@autistici.org) by localhost (Postfix) with ESMTPA id 552F5C006B;
        Thu, 26 Jul 2018 23:31:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 23:31:34 +0000
From:   rodia@autistici.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf c2c report: Fix crash for empty browser
In-Reply-To: <20180726193046.GC20438@kernel.org>
References: <20180724062008.26126-1-jolsa@kernel.org>
 <20180726193046.GC20438@kernel.org>
Message-ID: <c5cb64016f7da6c2abdef4a05ea74425@autistici.org>
X-Sender: rodia@autistici.org
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-26 19:30, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 24, 2018 at 08:20:08AM +0200, Jiri Olsa escreveu:
>> Do not try to display entry details if there's
>> not any. Currently this ends up in crash:
>>   $ perf c2c report
>>   perf: Segmentation fault
> 
> How to replicate this?
> 
> I tried:
> 
> $ perf record sleep 1
> $ perf c2c report
> 
> But it didn't segfault

Similarly I have tried :
$ perf record sleep 1
$ perf c2c report
Then Press `d` to show the cache-line contents.
This replies the segfault on my machine (4.17.8-1).
The patch mentioned above should solve it, even tough I am not sure as I 
haven't been able to recompile the kernel.

The segfault by itself seems to be due to the report logic, as it did 
not expect to report on an empty browser.
What has stepped me back is that application which I have been testing 
with rely on multiple threads instantiated through pthread, which should 
be counted in user-level threads right? But they still seem to return an 
empty browser.

When instead c2c is runned system-wide, with an application running on 
multiple threads like firefox or julia, cache hits are measured and also 
they are traced back in the source code.

Anyway, thanks for your support!
