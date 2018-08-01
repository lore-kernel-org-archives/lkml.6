Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B3FC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5BF20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DgaBJ7bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5BF20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbeHADQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:16:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732933AbeHADQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K6Q0esTeBAX3GlQ3ohpdsxtncjDiS1xv0xwzOifai4c=; b=DgaBJ7bw3yzChZPiuqBxfUHvic
        OhViqm4ht4YwwGUpU6rpZMtWexUXrzTCTv9tTv0H4Oop/IIVnDUBvSLBGtk7TSPlAlXd5Pl7Ace1y
        8oOb9nH7rJ0zAuUl3DM/55ZfePp1+J+cKmPN5T+xM+l6O1KnBIW1p7XgULz4RL0eyLQ+vC39B7smy
        9xuKq/iqaHRsD19sgg0HJ+2KTN/qUHfg1j2JG7Zzkt8gABrquWa1wt58D4vf5spcXuT9V1prunB1n
        awpOom3Yu0Wm2gA08wcBlYei2WWZcwyMbMnp+b8aQ5rD/5s+JzBs80Py6EXd0tjwX06rkLVkGyb9s
        3lwWvBHw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkg0y-0001Jt-D5; Wed, 01 Aug 2018 01:33:24 +0000
Subject: Re: Getting the instruction pointer on a per arch basis
To:     Nick Desaulniers <ndesaulniers@google.com>, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, tony.luck@intel.com, fenghua.yu@intel.com,
        msalter@redhat.com, jacquiot.aurelien@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com
Cc:     Pirama Arumuga Nainar <pirama@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Salyzyn <salyzyn@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, sparclinux@vger.kernel.org
References: <CAKwvOdku_BOi6m2ugaef6=8+VH_+KAHH-Ch+uZZqMr8WAKARCw@mail.gmail.com>
 <CAKwvOdn1Ri2VP9hNfKwQ3WMzL278e7-3DGusZc1cwQZbk9H6nw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <aa58e248-8d03-2932-8888-25497bcbdfc3@infradead.org>
Date:   Tue, 31 Jul 2018 18:33:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdn1Ri2VP9hNfKwQ3WMzL278e7-3DGusZc1cwQZbk9H6nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 04:09 PM, Nick Desaulniers wrote:
> + More maintainers and lists for visibility
> 

Ideally the linux-arch@vger.kernel.org mailing list would be sufficient,
but I doubt that it is.  :(

-- 
~Randy
