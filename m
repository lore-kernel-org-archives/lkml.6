Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PzpbJ6avGVs+UQAAmS7hNA
	; Thu, 07 Jun 2018 22:21:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 12BC46089E; Thu,  7 Jun 2018 22:21:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 87D25602FC;
	Thu,  7 Jun 2018 22:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87D25602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeFGWVe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:21:34 -0400
Received: from www62.your-server.de ([213.133.104.62]:45276 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbeFGWVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:21:32 -0400
Received: from [178.197.248.12] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fR3HY-0005jF-8h; Fri, 08 Jun 2018 00:21:24 +0200
Subject: Re: [PATCH] xsk: Fix umem fill/completion queue mmap on 32-bit
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        geert@linux-m68k.org
Cc: David Miller <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>, ast@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org,
        Netdev <netdev@vger.kernel.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1528378654-1484-1-git-send-email-geert@linux-m68k.org>
 <CAJ+HfNiciU0+4zd3ppapH12Gg_SFf9oUWTy+yafJSxCX8Mv-Dg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <67dd01ce-2aa8-6e33-326e-6b57b3c6d67b@iogearbox.net>
Date: Fri, 8 Jun 2018 00:21:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAJ+HfNiciU0+4zd3ppapH12Gg_SFf9oUWTy+yafJSxCX8Mv-Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24642/Thu Jun  7 22:39:10 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 06:34 PM, Björn Töpel wrote:
> Den tors 7 juni 2018 kl 15:37 skrev Geert Uytterhoeven <geert@linux-m68k.org>:
>>
>> With gcc-4.1.2 on 32-bit:
>>
>>     net/xdp/xsk.c:663: warning: integer constant is too large for ‘long’ type
>>     net/xdp/xsk.c:665: warning: integer constant is too large for ‘long’ type
>>
>> Add the missing "ULL" suffixes to the large XDP_UMEM_PGOFF_*_RING values
>> to fix this.
>>
>>     net/xdp/xsk.c:663: warning: comparison is always false due to limited range of data type
>>     net/xdp/xsk.c:665: warning: comparison is always false due to limited range of data type
>>
>> "unsigned long" is 32-bit on 32-bit systems, hence the offset is
>> truncated, and can never be equal to any of the XDP_UMEM_PGOFF_*_RING
>> values.  Use loff_t (and the required cast) to fix this.
>>
>> Fixes: 423f38329d267969 ("xsk: add umem fill queue support and mmap")
>> Fixes: fe2308328cd2f26e ("xsk: add umem completion queue support and mmap")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
[...]
> 
> Thanks Geert!
> 
> Acked-by: Björn Töpel <bjorn.topel@intel.com>

Applied to bpf, thanks everyone!
