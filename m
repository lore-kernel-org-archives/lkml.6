Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E720C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D935C20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+nCmQhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D935C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeLIWc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:32:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37621 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeLIWc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:32:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id p17so6630098lfh.4;
        Sun, 09 Dec 2018 14:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aSbfvJCmqfAHFgKylE3VLr16VVPfdibM9zf2CTitOJM=;
        b=E+nCmQhIR90wXfefO8VAiow2e+ZE4h5e7a9+Ojvj5ehWOC+O3j5fyoGILntutdpY9j
         WxsyufQda/KjhthwOR3eQTjRqrPpTCCdC5508U64mVuUFVHAvjt1joLZDIvEft++jcxj
         PKc3Oqcf4yczvNyDdyCwAxBXSVZVxTS9oSoqkC4+DFOQTyPXEsJWtqzX/l9e309Iv42l
         4fu/wFvFQPZ66GK+glSu33qYxnUEA5lkkuBLBKxFWqU+7hF/fzGzsPgLxOTn6vIipj0x
         52MayLG6Jtl09NsZ4IC20ClEmirN1Ovf0/+qW93H/kPWIeJvJI4wifLbGmXn7ee2QbMZ
         SmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aSbfvJCmqfAHFgKylE3VLr16VVPfdibM9zf2CTitOJM=;
        b=pQgWg+w3Svc60KlvRxdNtBIXER8fIMopUWUTOD6BMWGJYH9vtmmuqqt392RjUxznaq
         c3NDBr4U8po0EraSMTwVbIyQvPTP9n4PGfQgeIpoGPcQwbGES2Kfn323bLGnoi3fZmeY
         crqqRFut+9c4o4+9treeaXNvToS2p835MeUb7+XNNXkYhbUEGDcI9GBWS0x8KmsZ3Fi/
         a1yjrmNkafhv8cXMOoJBWlj0eWxuLSGk2SSmkGk/OGlbHdrXmb9FjZMabZxlZ1gnYMcJ
         poeCh6POQEUTh3rJGW4vpWW/0NUs8TlsL73jC4naA7BBrO5xBbStKOxoIJFrz8FP/nD0
         O5bA==
X-Gm-Message-State: AA+aEWY3ansIu6Zf4kT4LDpoRMvLXmhCY77ojF13kCyfsNvkpFHuKAUR
        3dCSjNis2Bs2l8SuEtDDbPb49YADaHs=
X-Google-Smtp-Source: AFSGD/WFKokiYX7TjyI9VrqlGnl+hh1Ja1bpLTqVArL0KU/M6D6yteT6DL1kBUR2K2oLdqf7OJLZBw==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr5342648lff.141.1544394743398;
        Sun, 09 Dec 2018 14:32:23 -0800 (PST)
Received: from [192.168.10.160] (91-159-62-226.elisa-laajakaista.fi. [91.159.62.226])
        by smtp.gmail.com with ESMTPSA id x29-v6sm1820387ljb.97.2018.12.09.14.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 14:32:22 -0800 (PST)
Subject: Re: [PATCH 2/6] __wr_after_init: write rare for static allocation
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181204121805.4621-1-igor.stoppa@huawei.com>
 <20181204121805.4621-3-igor.stoppa@huawei.com>
 <CALCETrVvoui0vksdt0Y9rdGL5ipEn_FtSXVVUFdH03ZC93cy_A@mail.gmail.com>
 <20181206094451.GC13538@hirez.programming.kicks-ass.net>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <d9382720-3c39-5f10-afcd-dc17727fe4dc@gmail.com>
Date:   Mon, 10 Dec 2018 00:32:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206094451.GC13538@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 11:44, Peter Zijlstra wrote:
> On Wed, Dec 05, 2018 at 03:13:56PM -0800, Andy Lutomirski wrote:
> 
>>> +       if (op == WR_MEMCPY)
>>> +               memcpy((void *)wr_poking_addr, (void *)src, len);
>>> +       else if (op == WR_MEMSET)
>>> +               memset((u8 *)wr_poking_addr, (u8)src, len);
>>> +       else if (op == WR_RCU_ASSIGN_PTR)
>>> +               /* generic version of rcu_assign_pointer */
>>> +               smp_store_release((void **)wr_poking_addr,
>>> +                                 RCU_INITIALIZER((void **)src));
>>> +       kasan_enable_current();
>>
>> Hmm.  I suspect this will explode quite badly on sane architectures
>> like s390.  (In my book, despite how weird s390 is, it has a vastly
>> nicer model of "user" memory than any other architecture I know
>> of...).  I think you should use copy_to_user(), etc, instead.  I'm not
>> entirely sure what the best smp_store_release() replacement is.
>> Making this change may also mean you can get rid of the
>> kasan_disable_current().
> 
> If you make the MEMCPY one guarantee single-copy atomicity for native
> words then you're basically done.
> 
> smp_store_release() can be implemented with:
> 
> 	smp_mb();
> 	WRITE_ONCE();
> 
> So if we make MEMCPY provide the WRITE_ONCE(), all we need is that
> barrier, which we can easily place at the call site and not overly
> complicate our interface with this.

Ok, so the 3rd case (WR_RCU_ASSIGN_PTR) could be handled outside of this 
function.
But, since now memcpy() will be replaced by copy_to_user(), can I assume 
that also copy_to_user() will be atomic, if the destination is properly 
aligned? On x86_64 it seems yes, however it's not clear to me if this is 
the outcome of an optimization or if I can expect it to be always true.


--
igor
