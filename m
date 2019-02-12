Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F640C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5202190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ZmeCzXbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfBLTbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:31:10 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:43328 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfBLTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:31:10 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 209F85C026A;
        Tue, 12 Feb 2019 20:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549999868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlRbHEOXyiu40U9NCbv3zqgTF73UAsRWJa7LCVDhGlQ=;
        b=ZmeCzXbAbdKcB+EezCMBjqPkU8P/iX6dt0PA+vkXqULIS2i6TcBnyrVh3IwsFD2mpzGJdQ
        FPmQ9WxidmZKbZEgWtaWrCg0GZaOz4IA68E6/8o06jbF+FvEc0ZeNPOYwgygkMmMxiM0kY
        rYZjDj1bfOsdoVu09IRnesL+O+xQdiQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Feb 2019 20:31:08 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     linux@armlinux.org.uk, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] ARM: convert to unified syntax
In-Reply-To: <nycvar.YSQ.7.76.1902101620430.2213@knanqh.ubzr>
References: <cover.1549753425.git.stefan@agner.ch>
 <nycvar.YSQ.7.76.1902101620430.2213@knanqh.ubzr>
Message-ID: <da23b2ceddf2a73e1c772b7994f52d2f@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.02.2019 22:24, Nicolas Pitre wrote:
> On Sun, 10 Feb 2019, Stefan Agner wrote:
> 
>> This patchset converts all assembly code to unified assembler
>> language (UAL) compatible assembly code. From what I can tell,
>> this mainly boils down to using conditional infixes instead of
>> postfixes.
>>
>> Most of the conversion has been done using the following regular
>> expression:
>>   find ./arch/arm/ -name "*.[hSc]" -exec sed -i -r \
>>     "s/^((\s*[._a-zA-Z0-9]*[\:\(])?\s*)([a-z]{3})(eq|ne|cs|hs|cc|lo|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)([a-z]{1,2})(\s)/\1\3\5\4\6/"
>> \
>>     {} \;
>>
>> The expression resulted in some false positives and missed some
>> instances where infix conditionals have been used. With this
>> changes applied, I compiled several kernel configurations
>> successfully and without a warning.
>>
>> The file arch/arm/probes/kprobes/test-arm.c is still using some
>> divided syntax assembler.
>>
>> This does not allow to use LLVM's integrated assembler just yet,
>> there is still some assembler which the integrated assembler does
>> not like (yet). But it is a big step towards that direction.
> 
> OK....
> 
> Please document why you added .syntax unified in the commit log of each 
> patch where this is added along with a link to the gcc PR.  Then you may 
> add Acked-by: Nicolas Pitre <nico@linaro.org> to the whole series.

Agreed, that is a good idea. Will send v3. Thanks for the Acks.

--
Stefan
