Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FF9C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2B224E14
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="StAISmw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2B224E14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeGBPTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:19:31 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:36568 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeGBPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:19:29 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4376424E0448;
        Mon,  2 Jul 2018 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530544769; bh=LXO4zPhQ899l1W9jNxs+V/ZW/l1nLEpIs/vcIFd4OM8=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=StAISmw5Dt1I/bl/a3/H0BMoTwjH+N93f5Xy1qbJGZ0sridMHEqMr2GkMZZrMkLG+
         HQroIOb4htl067QZta2r0CUEP+BmFPau6oTDDj15H2o4u6EX+0ttEfl6BMqECouQi3
         T71EYheZaxUAnKXvYee3BZ7Ck9j244dr+3dofLh+6maWzPL8RE2WXfTz8CXq7Cmaen
         OsDhaZvG+Hcwug09WN/SK58GV7oSzwqVxX/ICVKvfi0jRJr5cqlgCZzwzrDg8FHr4P
         u5E6HU9p0rlvqOtLK+KRB9TWmpCHfRirUXhcJST3ItV8sHqAJUZT9hEwbcLcQfw4jC
         lTVT8HQtYi9ug==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id C3E533C8F;
        Mon,  2 Jul 2018 08:19:28 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 2 Jul 2018 08:19:28 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 2 Jul 2018 17:19:26 +0200
Received: from [10.0.2.15] (10.107.19.20) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 2 Jul
 2018 17:19:25 +0200
Subject: Re: [PATCH] net: stmmac_tc: use 64-bit arithmetic instead of 32-bit
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Jose Abreu" <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20180702120932.GA13079@embeddedor.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <32c70751-9083-5c59-1e0e-c4ba69c18d80@synopsys.com>
Date:   Mon, 2 Jul 2018 16:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180702120932.GA13079@embeddedor.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.20]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-2018 13:09, Gustavo A. R. Silva wrote:
> Add suffix UL to constant 1024 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> u64 (64 bits, unsigned) and  following expressions are currently
> being evaluated using 32-bit arithmetic:
>
> qopt->idleslope * 1024 * ptr
> qopt->hicredit * 1024 * 8
> qopt->locredit * 1024 * 8
>
> Addresses-Coverity-ID: 1470246 ("Unintentional integer overflow")
> Addresses-Coverity-ID: 1470248 ("Unintentional integer overflow")
> Addresses-Coverity-ID: 1470249 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>

Acked-by: Jose Abreu <joabreu@synopsys.com>

Thanks!

Best Regards,
Jose Miguel Abreu
