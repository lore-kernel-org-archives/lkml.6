Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F4C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6D3218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogHYuNGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393186AbeLWENA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:13:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33986 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbeLWENA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:13:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so4301516plz.1;
        Sat, 22 Dec 2018 20:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXxqqQrIlwyQ/jY+OxMMUPrjCkPS3DIsvivXunDRR60=;
        b=ogHYuNGed/hJKBTtXBrgU/MkHSDywaJ3/s1LaxQXYRxGmDr/a6z0cTqKbVMOmRREhs
         twXfSjP2KwohZRlHGzblznpzkmneyG5hNg+lqaE5+Khfc7j8ZsAFQbrjyZX74BaAx0Ku
         ZDSMTOF3vFrc3p+EQCTJuwqEdznJW+Eew6+ukmEMzgWp9TZwmI3PESp8EgM6CRMknPLz
         9MF8vvSoT3FNO+i/wCCoPPDfGntAcMoXeAhvSaXG4p6cnntHmvSdVyMaMZ/p9U4yZg5a
         O9H1OtyPBD/6g7kV9hODgvCjA3KAbWPgGeKbLsA0ovuFKMC3FI74O/edG0S14h+XI+jz
         Ny4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXxqqQrIlwyQ/jY+OxMMUPrjCkPS3DIsvivXunDRR60=;
        b=Fo5JePkbGmto5lRsCQZF0/ZBUKuRcbSp3OerKQfqnoBypIVMZVxgo1oVBliLqQEfx+
         B2DchjHYDdHrWXwOn0PdMxMCP3+rnVedaZxj2wgDGyEfASZPxWDu78DzNfO0VxR7teLV
         TyPAY0bL8ITuBIl+P2wF5M6Jv1oXubMSQJT/hn7ftUidnmroPQcZeikE+Z6r759Iow3b
         3KRcDwI5xabJalQYXm9Z/aGqoqmrUbnmU3YDJVNQgoSiU3cegU3eLdrVDktfEJIDzUHP
         8bKz1UN54rIQSao3XgpE1A31C1fP0znAv5QmhrtIK/Z/UlJYt7W3ZsU+4KjOGzs1zyLU
         Tsbw==
X-Gm-Message-State: AJcUukezuiZEEX7X3C8KdzQZuUKo1NDVSgY3MLOD73cm9GS5UhkGxnJe
        Cnb8p27kil7RBzgHGBqG+jM=
X-Google-Smtp-Source: ALg8bN6jloCTXYeIWNVTZopZCUhCUoZ/XsXGPW5LBU/T/URl7F4zOuE9YWkizLSAxEH/joTOoaXl1A==
X-Received: by 2002:a17:902:b406:: with SMTP id x6mr8218400plr.329.1545538378275;
        Sat, 22 Dec 2018 20:12:58 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:76e6])
        by smtp.gmail.com with ESMTPSA id p67sm47036970pfg.44.2018.12.22.20.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 20:12:57 -0800 (PST)
Date:   Sat, 22 Dec 2018 20:12:55 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Miller <davem@davemloft.net>, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: core: Fix Spectre v1 vulnerability
Message-ID: <20181223041253.bxqru567rs32mecg@ast-mbp.dhcp.thefacebook.com>
References: <20181221204901.GA30045@embeddedor>
 <20181222.150722.1493687829239836271.davem@davemloft.net>
 <20181222235952.keue7a336sg7jfim@ast-mbp.dhcp.thefacebook.com>
 <20181222.184051.718127928973898182.davem@davemloft.net>
 <e1c8e69b-3417-6176-6b49-1b7a23febb21@embeddedor.com>
 <20181223030039.wrpytx7pwfcljdjm@ast-mbp.dhcp.thefacebook.com>
 <37df17ba-7fcf-ab04-fe9a-d2a6fc5b6b9c@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37df17ba-7fcf-ab04-fe9a-d2a6fc5b6b9c@embeddedor.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 09:37:02PM -0600, Gustavo A. R. Silva wrote:
> 
> Can't we have the case in which the code can be "trained" to read
> perfectly valid values for prog->len for quite a while, making the
> microcode come into place and speculate about:
> 
> 1013         if (flen == 0 || flen > BPF_MAXINSNS)
> 1014                 return false;
> 
> and then make flen to be greater than BPF_MAXINSNS?

Yes. The user space can train line 1013 to mispredict by passing
smaller flen N times and then passing large flen.
Why do you think it's exploitable?

Without the patch in the mispredicted path the cpu will do
if (0 < flen) condition and since flen is hot in the cache
it will happily execute the filter[0] load...
and about 12-20 u-ops later (depending on u-arch of cpu) when
branch predictor realizes that it's a miss, the cpu will ignore
the values computed in the shadow cpu registers used by speculative execution
and go back to the 'return false' execution path.
The side effect of bringing filter[0] value in L1 cache is still there.
The cpu is incapable to undo that cache load. That's what spectre1 is about.
Do you see how filter[0] value in cpu L1 cache is exploitable?

I took another look at the following patches:
"net: core: Fix Spectre v1 vulnerability"
"nfc: af_nfc: Fix Spectre v1 vulnerability"
"can: af_can: Fix Spectre v1 vulnerability"
and I have to say that none of them are necessary.
I'm not sure whether there were other patches that pretend to fix spectre1.

