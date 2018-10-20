Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5192BC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 06:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22F6214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 06:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f8oILOYn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CRrcUNmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22F6214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeJTOmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 10:42:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeJTOmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 10:42:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D89F860316; Sat, 20 Oct 2018 06:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540017175;
        bh=KauYKAH5U7JGHNSWSnaT7rUGqKCw1oKiZpllrN3zkAU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f8oILOYnbfRDjOohJmhk9Qmswj8N/WnQIdzyPcDBKZ9X0LQrjwxiAw/wljYjV1Y/i
         5ip0iQnxM6QBs1IYo9UrkDIBjQJSDpj7bV1FepnSHd5GSbtlLMyyCp5Fxj5wyb85K1
         71Srs9BnU8ETCONDkTPK5wJwEH0QZbPSj/CnBUS0=
Received: from [192.168.43.47] (unknown [223.227.22.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1580460316;
        Sat, 20 Oct 2018 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540017174;
        bh=KauYKAH5U7JGHNSWSnaT7rUGqKCw1oKiZpllrN3zkAU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CRrcUNmE9fBLTF5clpSGtC76xyzSSSQZh3pyfcAqvGpMkwhZMgDBcb/6svlPiwGz3
         2dx7iAx0A/OhPn0dlwNzuMjdx9Yn0CK5ztAQijkSAJ175TPdwxFNHEU4tsgtlK9GVW
         39a+K2fYY9tEbaH5Fio2a/Be3LNK7djUYN0ve6/w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1580460316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 0/6] Tracing register accesses with pstore and dynamic
 debug
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
        Tingwei Zhang <tingwei@codeaurora.org>, tkjos@google.com
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20181020052535.GA155509@joelaf.mtv.corp.google.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <1d3ddbe3-d3ac-aa3e-fc9e-36739ddd0c91@codeaurora.org>
Date:   Sat, 20 Oct 2018 12:02:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181020052535.GA155509@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2018 10:55 AM, Joel Fernandes wrote:
> On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
>> Hi,
>>
>> This patch series adds Event tracing support to pstore and is continuation
>> to the RFC patch introduced to add a new tracing facility for register
>> accesses called Register Trace Buffer(RTB). Since we decided to not introduce
>> a separate framework to trace register accesses and use existing framework
>> like tracepoints, I have moved from RFC. Details of the RFC in link below:
>>
>> Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan@codeaurora.org/
>>
>> MSR tracing example given by Steven was helpful in using tracepoints for
>> register accesses instead of using separate trace. But just having these
>> IO traces would not help much unless we could have them in some persistent
>> ram buffer for debugging unclocked access or some kind of bus hang or an
>> unexpected reset caused by some buggy driver which happens a lot during
>> initial development stages. By analyzing the last few entries of this buffer,
>> we could identify the register access which is causing the issue.
> 
> Hi Sai,
> 
> I wanted to see if I could make some time to get your patches working. We are
> hitting usecases that need something like this as well. Basically devices
> hanging and then the ramdump does not tell us much, so in this case pstore
> events can be really helpful. This usecase came up last year as well.
> 
> Anyway while I was going through your patches, I cleaned up some pstore code
> as well and I have 3 more patches on top of yours for this clean up. I prefer
> we submit the patches together and sync our work together so that there is
> least conflict.
> 
> Here's my latest tree:
> https://github.com/joelagnel/linux-kernel/commits/pstore-events
> (note that I have only build tested the patches since I just wrote them and
> its quite late in the night here ;-))
> 

Hi Joel,

Thanks for looking into this. Sure, I will be happy to sync up with you 
on this. I can test your additional patches on top of my pstore patches. 
BTW, I'm still stuck at copying binary record into pstore and then 
extract it during read time. Seems like I'm missing something.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
