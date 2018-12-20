Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76419C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F06217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qoPByeRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeLTQmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:42:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbeLTQmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AsrGz4wyhV6a5LoNUZXjMxkoDjCYbgsfI12XBltVZow=; b=qoPByeRzbhFBCAixECZW50A9F
        6DZbytuPCbBaBtCZ/lv1zSa1FHdsJqGCcRAn8I9n3KRtxGj/iPoAlTUjkrChc1lPh3+OlEMvWY9fr
        DOZ0bcqeIJcLJmBZv7Y4Z5XhRwg9w9HUL73GGDEcgWZnPjin/hCZK4Imd92Ke44zRp0oTxHYgLZXA
        T5pieI3NNYfamVUwIUH9G75Ac0khWpumPucyNPYUv/4UxiaUvU4JzJFBKF7tIr1EIWmpIWFNaYEIX
        eeRDsvAsHUK/GnZnz8QkHGNuKoL8vArLk0hLeO2FeCbz3HrfVlTKeaJqlwS5F0IOrNP8JgUP49ZQE
        S73tHFVIA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga1On-0002fi-FJ; Thu, 20 Dec 2018 16:42:15 +0000
Subject: Re: [PATCH 0/1] RFC: Revamp admin-guide/tainted-kernels.rst to make
 it more comprehensible
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181217152043.9989-1-linux@leemhuis.info>
 <20181217112437.5fe868eb@lwn.net>
 <8f67a8ca-bf64-c537-843a-b03bcfc3dace@infradead.org>
 <96fc8865-c54f-5c6c-f6c8-d7a5a12735e6@leemhuis.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e77c03ff-a84b-4020-34a4-fc9fa5f1eccb@infradead.org>
Date:   Thu, 20 Dec 2018 08:42:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <96fc8865-c54f-5c6c-f6c8-d7a5a12735e6@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 7:23 AM, Thorsten Leemhuis wrote:
> Hi! Am 17.12.18 um 22:06 schrieb Randy Dunlap:
>> On 12/17/18 10:24 AM, Jonathan Corbet wrote:
>>> Here's an idea if you feel like improving this: rather than putting an
>>> inscrutable program inline, add a taint_status script to scripts/ that
>>> prints out the status in fully human-readable form, with the explanation
>>> for every set bit.
>> And some people prefer not adding tools that use python, perl, etc.
> 
> Yeah, I know :-/ On twitter @apexo (thx!) suggested these two:
> 
> dc -e"[00000000000000]n2o$(cat /proc/sys/kernel/tainted)p"|fold
> -w1|tac|nl| grep  -m 18 '.'
> 
> (echo -n 000000000000000;(echo obase=2;cat
> /proc/sys/kernel/tainted)|bc)|fold -w1|tac|nl| grep -m 18 '.'
> 
> But it needs bc, which often is not installed by default  :-/ Any as you
> mentioned already: using Perl (
> 
> perl -e 'printf("%016b\n",<STDIN>)' < /proc/sys/kernel/tainted |fold
> -w1|tac|nl
> 
> ) also has it downsides. Having something that works in plain bash/sh
> would be great...
> 
> Nevertheless: I'm still inclined to put a one liner decode command into
> tainted-kernels.rst so people can decode the file easily even if they do
> not have attached script at hand.
> 
>> E.g., I use this shell script (named 'chktaint', which could probably
>> be done better):
> 
> Many thx. Find a slightly improved version attached that directly prints
> the reason. I assume that's more like what Jonathan had in mind. The
> script now is also capable of decoding a value retrieved from
> /proc/sys/kernel/tainted on another system.

Thorsten:

- drop the trailing spaces on multiple lines
- s/follwing/following/


thanks.
-- 
~Randy
