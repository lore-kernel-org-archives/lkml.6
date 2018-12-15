Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA1AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 04:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCCE21720
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 04:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="f/VIC+1T";
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="f/VIC+1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeLOE0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 23:26:46 -0500
Received: from fallback19.mail.ru ([185.5.136.251]:40148 "EHLO
        fallback19.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeLOE0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 23:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=gHWilZXwmIaxBCh8At7Sm2m5nO1VjLmwJKRhvYmYfH0=;
        b=f/VIC+1TcT8QAE4nEJhPTmBka6bJ2td197K1tIVLSrrAMgg3HkXOPvwZJGw4JGfgrmyJT2e69yIjM+z/NjTT2y6d/1a8yzgEl3OPzJcjO+LT2tfqZC8wtf3hYn4EVGJw64/Ug/eTF5Tit+2tJfWhN9RjIgo/KTsLPtlGN+ShI1U=;
Received: from [10.161.22.25] (port=35626 helo=smtp55.i.mail.ru)
        by fallback19.m.smailru.net with esmtp (envelope-from <hsiangkao@mail.ru>)
        id 1gY1XH-0003tX-6V; Sat, 15 Dec 2018 07:26:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=gHWilZXwmIaxBCh8At7Sm2m5nO1VjLmwJKRhvYmYfH0=;
        b=f/VIC+1TcT8QAE4nEJhPTmBka6bJ2td197K1tIVLSrrAMgg3HkXOPvwZJGw4JGfgrmyJT2e69yIjM+z/NjTT2y6d/1a8yzgEl3OPzJcjO+LT2tfqZC8wtf3hYn4EVGJw64/Ug/eTF5Tit+2tJfWhN9RjIgo/KTsLPtlGN+ShI1U=;
Received: by smtp55.i.mail.ru with esmtpa (envelope-from <hsiangkao@mail.ru>)
        id 1gY1X6-0002tM-Tc; Sat, 15 Dec 2018 07:26:33 +0300
Subject: Re: [PATCH] fix page_count in ->iomap_migrate_page()
To:     zhangjun <openzhangj@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1544766961-3492-1-git-send-email-openzhangj@gmail.com>
From:   Gao Xiang <hsiangkao@mail.ru>
Message-ID: <5cd9ea0d-4c1c-fd4d-4e29-0ee71ef272a0@mail.ru>
Date:   Sat, 15 Dec 2018 12:26:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1544766961-3492-1-git-send-email-openzhangj@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-77F55803: 2D1AD755E866B1545A78504BD2AC294197136A761B2823857E542801713FBE4405C1285266A94049DDFFE3E209DD0CE2
X-7FA49CB5: 0D63561A33F958A5E68EA868D5A25C82E0EB97D96B59FAB579AB476A5B52DF078941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249F4758F8EC3E027ED3AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE7C2A068104F3A7B7DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE73DEA34A08CDCEBD42CE28773137D0E5575ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57C2F2A386D11C4599BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-Sender: 9E70C8A5DC8B9FA35C638186A660B4210083070E12C409938ED47622CF4997EA15C3726575FFF9165830A20E6128BAFC3DCCF50608321A3F9401603B12496480D097E3B5155233E99519AC401C0EBED5AF001EC47C67348C67EA787935ED9F1B
X-Mras: OK
X-77F55803: 5241C2F38277A35D7F9F52485CB584D7271FD7DF62800FDC772EEC4791B6B4B4CE6A79F788DCE7ED0E8E8074D63AECC30D07EB58AC8C092E
X-7FA49CB5: 0D63561A33F958A56AA9F5276B0FAE209255962346DBE5FFCF2BBD2E1F86A9808941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: A5480F10D64C9005EBA3FDA8F7473FBDB63F05FFFA1EE59BCE6A79F788DCE7ED44CC085085D1A8495830A20E6128BAFC3DCCF50608321A3F9401603B12496480D097E3B5155233E99519AC401C0EBED5AF001EC47C67348C67EA787935ED9F1B
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/14 13:56, zhangjun wrote:
> IOMAP uses PG_private a little different with buffer_head based
> filesystem.
> It uses it as marker and when set, the page counter is not incremented,
> migrate_page_move_mapping() assumes that PG_private indicates a counter
> of +1.
> so, we have to pass a extra count of -1 to migrate_page_move_mapping()
> if the flag is set.
> 
> Signed-off-by: zhangjun <openzhangj@gmail.com>
> ---

I found that it fixed in
https://patchwork.kernel.org/patch/10684835/
and has been merged in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61c6de667263184125d5ca75e894fcad632b0dd3

It seems it has been corrected by Piotr.

Thanks,
Gao Xiang
