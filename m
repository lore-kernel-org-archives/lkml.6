Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68671C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240B82173D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=compulab.co.il header.i=@compulab.co.il header.b="Z+Az6oH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240B82173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=compulab.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeHYVef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 17:34:35 -0400
Received: from softlayer.compulab.co.il ([50.23.254.55]:40488 "EHLO
        compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeHYVef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 17:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=compulab.co.il; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CZnftNgWxmzwvVAVEzd8UaIx+2Uf9l4+kAQwLIKznFI=; b=Z+Az6oH/jlQTBn/TxlsTdqegLo
        NdrLcUKEMlIY1eCkE9vrdAkcaewUCYDt+3mtj5+LW4nSxV6bIwevbpo93JhqS++4C5nhAtLCyHm45
        aTZLTKXrz/E7SYbRS8H0dC17L7ACFfafpBL76mU7+W02TLxoYaRPq1btgXEPpydnO0D9y9LvOM4/X
        n9lE3S34740xQXPyVaPaL6+9GEZ4+xslJGmvQjxT8nTJMeGKF5ISxbW8/ugeeuKwCuBbxHjpelJld
        kipT4nPSVYYNSt1gZh9I8RvTEXu1MVKS4OkJ4BTedsr2EU0Cnf93vQoBAFO0irSSLl4EJHzfgRd7Z
        7WUnJ3Lw==;
Received: from [37.142.126.90] (port=47232 helo=zimbra-mta.compulab.co.il)
        by softlayer.compulab.co.il with esmtp (Exim 4.87)
        (envelope-from <kirill.kapranov@compulab.co.il>)
        id 1ftclz-0004pT-6F; Sat, 25 Aug 2018 20:54:55 +0300
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id CB726481186;
        Sat, 25 Aug 2018 20:54:53 +0300 (IDT)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oZl8dHaTJMvb; Sat, 25 Aug 2018 20:54:53 +0300 (IDT)
Received: from localhost (localhost [127.0.0.1])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 8B187481187;
        Sat, 25 Aug 2018 20:54:53 +0300 (IDT)
X-Virus-Scanned: amavisd-new at zimbra-mta.compulab.co.il
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
        by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3u17ch25vSrc; Sat, 25 Aug 2018 20:54:53 +0300 (IDT)
Received: from [192.168.11.10] (lifshitz-linux.compulab.local [192.168.11.10])
        by zimbra-mta.compulab.co.il (Postfix) with ESMTPSA id 51659481186;
        Sat, 25 Aug 2018 20:54:53 +0300 (IDT)
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180821095303.27664-1-geert+renesas@glider.be>
 <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
 <20180823102121.GC5207@sirena.org.uk>
From:   Kirill Kapranov <kirill.kapranov@compulab.co.il>
Organization: CompuLab Ltd.
Message-ID: <a1bba27e-a287-c162-a238-eeae1e84d63c@compulab.co.il>
Date:   Sat, 25 Aug 2018 20:54:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823102121.GC5207@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - softlayer.compulab.co.il
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - compulab.co.il
X-Get-Message-Sender-Via: softlayer.compulab.co.il: acl_c_recent_authed_mail_ips_text_entry: kirill.kapranov@compulab.co.il|compulab.co.il
X-Authenticated-Sender: softlayer.compulab.co.il: kirill.kapranov@compulab.co.il
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For DT systems the dynamically allocated IDs start at the maximum
> positive ID and work down so in practice it is vanishingly unlikely that
> there will be a collision as idiomatic static DT IDs would be low
> integers.

Yes, this algorithm seems really bullet-proof. However, it isn't 
actually used now. The ID allocation algorithm using  atomic_dec_return 
call had been introduced 2006-01-08 as [1]. It was being used in the 
mainline kernel (with some improvements) up to 2017-08-16, when it has 
been replaced with the newer algorithm using Linux idr, accordingly [2].

Since idr_alloc call works incrementally, the situation of a 'fixed' ID 
squatting by a driver with 'dynamic ID' seems more than possible.
Therefore it would be justified to use a hardcoded constant 
SPI_DYN_FIRST_BUS_NUM (that was introduced in [2] and eliminated in 
[3]), but with a sufficiently greater value of the constant.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.18&id=8ae12a0d85987dc138f8c944cb78a92bf466cea0 

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.18&id=9b61e302210eba55768962f2f11e96bb508c2408
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.18&id=42bdd7061a6e24d7b21d3d21973615fecef544ef

