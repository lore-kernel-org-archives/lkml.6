Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3882205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="JT1lPvgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfAQO3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:29:14 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:33620 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbfAQO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:29:13 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 43gRKM547Sz1y8k;
        Thu, 17 Jan 2019 15:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1547735351; bh=P2foAXieJGN1qz49gJJgSp8jtE8tajWr4Ms7C9SpmrI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=JT1lPvgtaLPNYXbcPe9LLOwRTnrlviEuvkZty2iQ2dbP7LjB22OZ2QsX5YQNDxW2A
         kgXY3Li9F4IpaowxlaW8KjQGB1oipg+tTDfcLAarTSVmfH6nODaJrK9v56eG2fxI+n
         /IKdxJxuHfww09VLzyHb/XcEg2mQ0wLpZySFo00xk63ox2aCdCG26/5dbGO+s9x/YQ
         7oyySm0KGOHUGbgF69dj84osL+SYtIFFA1iGuIkF+x6mq7epBQwsqunynB/Q2A4ed8
         lainPTxZj9UaQz4wFDKLGnaNF/nJCj7W4WaTWqlerbdARCVGN7/RShiPe6HvqyXaRY
         9gtpusLF8tR5w==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:638:a000:4142::ffff:149
Received: from [IPv6:2001:638:a000:4142::ffff:149] (faui49copter1.informatik.uni-erlangen.de [IPv6:2001:638:a000:4142::ffff:149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX188SGleHbMKBBfQbX1gXMtTcvMLbCKYBmE=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 43gRKK4stkz1xt6;
        Thu, 17 Jan 2019 15:29:09 +0100 (CET)
Subject: Re: [PATCH v2] tracing/uprobes: Fix output for multiple string
 arguments
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190116084021.34b0beee@gandalf.local.home>
 <20190116141629.5752-1-andreas.ziegler@fau.de>
 <20190117150107.17f2c0c37e41126120c5eebb@kernel.org>
 <b5defce3-b52a-db20-bfd1-81eec9972fab@fau.de>
 <20190117165807.64e95553ff397e7f73ba495b@kernel.org>
 <20190117092042.4f689462@vmware.local.home>
From:   Andreas Ziegler <andreas.ziegler@fau.de>
Message-ID: <5ceb9b3b-3f67-4e84-b029-6e6d8ccc0449@fau.de>
Date:   Thu, 17 Jan 2019 15:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117092042.4f689462@vmware.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 3:20 PM, Steven Rostedt wrote:
> On Thu, 17 Jan 2019 16:58:07 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
>> Ah, I got it.
>> Hmm, in that case, I have to update my patch in the previous mail.
>> Anyway,
>>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> So this patch is good to go? If so, I'll pull it in and start testing
> it.
> 
> I'm currently traveling (as you probably received my OoO emails), but I
> can still do a bit of work remotely.
> 
> -- Steve
> 
 From my side it's basically good to go, but I just realized that there 
is no "Fixes: " tag in it but the problem it fixes goes back to 
5baaa59ef09e ("tracing/probes: Implement 'memory' fetch method for 
uprobes") from 2013 (and is present in all current longterm and stable 
kernels)... should I add a tag and resend a v3?

Thanks,

Andreas
