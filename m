Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B9C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 15:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8FD213A2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bI2U1ryc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8FD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeHSStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 14:49:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeHSStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 14:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jbwhBKgVvMW0+roR0Gcl3dLd4LoGTGafgVwP75EjvF4=; b=bI2U1ryc+Yarr4ew2oWCh1cE4
        Cvf0gjQS562rDh7QoCLF7v5UW/QdWqQIcmorVYeyR+KIZQMQB2+ZM/fK7ca1Hg70fFXF8BSxXYa85
        Fl1OSpLzVfGFxUpzoEDluPPpmCfNFgRDXmIDmgs2jVhm3UBTw/TuS6KbhbWMF4wyCz8sALPIHQTFa
        I+oO0s1pP6iioiipQLyAHFVA1IR3eC6Ki0utnBKoB8iSZ48ru5uP5dHjhc443mdsws8WyBQ3CTNeK
        06bOVMkmA00mkLb+s/9ZOFyUEzlTPvgm5q84nmzShZhkImnQgxyxvzXqjCnfEos7mska0R5XyolXn
        H045HIsTQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frPmD-0005Wc-1C; Sun, 19 Aug 2018 15:38:01 +0000
Subject: Re: make *config regression: pkg-build
To:     Meelis Roos <mroos@linux.ee>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
References: <alpine.LRH.2.21.1808191406030.12334@math.ut.ee>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <177f25ad-de40-ce3f-987f-ac34c2559be4@infradead.org>
Date:   Sun, 19 Aug 2018 08:37:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1808191406030.12334@math.ut.ee>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19/2018 04:15 AM, Meelis Roos wrote:
> Just tried to run 'make menuconfig' on v4.18-10568-g08b5fa819970 and 
> found a bad surprise:
> 
> 'make *config' requires 'pkg-config'. Please install it.
> make[1]: *** [scripts/kconfig/Makefile:219: scripts/kconfig/.mconf-cfg] Error 1
> 
> This is clearly a regression - I have libncurses devele pakcage 
> installed in the default system location (as do 99%+ on actuall 
> develeopers proobably) and in this case, pkg-config is useless. 
> pkg-config is needed only when libraries and headers are installed in 
> non-default locations but it is bad to require installation of 
> pkg-config on all the machines where make menuconfig would be possibly 
> run (for example, I have a aboult 100 machine kernel testbed with 
> self-hosted kernel compilation and machine-specific kernel 
> configurations that ocassionally need tweaking).
> 
> I notice 4.18 complained it can not find pkg-config but still worked. 
> This is clearly better than now.
>
> If we want to support developers with libraries in non-default 
> locations, why not - but the common case of system include path should 
> work without any trouble or warnings. For exaple, test if compilation 
> against ncurses works, and if not retry it with pkg-config (and error 
> out if it does not give working result).
> 

Hi,
This is due to my patch: 4ab3b80159d4db63b902ef635d4b5e882911b2da.

Yamada-san, any ideas?  Feel free to just revert it.

thanks,
-- 
~Randy
