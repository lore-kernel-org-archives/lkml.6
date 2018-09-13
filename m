Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A94F81826
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EE321766
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BNH2QElS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EE321766
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIMWNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:13:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36578 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeIMWNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:13:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180913170235euoutp018a6f65ff5aec0b3e54c333f8835b69c5~UBFmHlMmG2271822718euoutp01T
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 17:02:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180913170235euoutp018a6f65ff5aec0b3e54c333f8835b69c5~UBFmHlMmG2271822718euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536858155;
        bh=GYuhDmQJ60QaiKsBn7abTMvijB3mk01YYQJ29RBluH4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BNH2QElSwVwhE5F/7jejmH63uinZwO3JZ7EFl+xZpu+DKxmnqDznHuCUpg89IDN5H
         8JDuxeB+PpSHXC/GmFdS2PqeutA6eFU9ONG5YBDgz4m6p1laH3RalQ2BN+11Yg3/UY
         O/jTODdr7JvWIyCLyhGo6SUnUqBvPisw3+g5ewSk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180913170234eucas1p2e9ddbe8afe4f260469a617dcfa2e8e19~UBFlF1rsk2999729997eucas1p2k;
        Thu, 13 Sep 2018 17:02:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7E.7D.04294.9289A9B5; Thu, 13
        Sep 2018 18:02:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180913170233eucas1p19e6cd20020f27bb4db0cd927bb9a3302~UBFkQTUaX2145421454eucas1p1M;
        Thu, 13 Sep 2018 17:02:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180913170233eusmtrp1b141e008271832e62f709a378d614d18~UBFj_64BZ2910929109eusmtrp1s;
        Thu, 13 Sep 2018 17:02:33 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-23-5b9a9829a55b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 79.FC.04284.8289A9B5; Thu, 13
        Sep 2018 18:02:33 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913170232eusmtip170e63e66f0e278af1e4f08e710d3d4fb~UBFjRlMdT2795327953eusmtip1D;
        Thu, 13 Sep 2018 17:02:32 +0000 (GMT)
Subject: Re: [PATCH v2 02/24] drivers/video/fbdev: use ioremap_wc/wt()
 instead of __ioremap()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Thu, 13 Sep 2018 19:02:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <2f980cf32a05415662272cf052c2b9e2a94c756f.1536692743.git.christophe.leroy@c-s.fr>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRj27Tl79rTa+izyDkZaQ6pRpB/fyBgNY85gRn6YkR2y6kijzc6e
        dl0bq+SyaCuD2lkVVliXTRlqXWdRCrEijVHMJLlEyD2i3VPDv+d5n+eZ93lnXpZS/pGOZFPT
        M3h9uiZNxcjp8zU/GiaFFVrVkzvs00jb22KanGyxMORDVg5FdmRLyMMvXQwpak0l9tcziDv7
        moRUtDVJyeUnEeRW7gcpaXTZGFK6tQ/1fOuVknMmN0N+vGqmiTn3MENO3Tgim6nkHv2sk3E5
        lu8Md796MHf4tYnmqq0tMq7yeDi3u3OrlGu8a+Ceuytp7tmuWglXad/M3Ss8hLiz76sk3EFX
        LuK6K8bEBy6RT0/m01KNvD5qxnL5qvqSS1LdLdm6j5ZDMhOyMWbkxwKOgbqdPTIzkrNKfBxB
        wWMbLZLPCK64simRdCPoeXlNMhDpKc7rF44h2HN1u0QkXQgevLf0KSw7FCeCzTHBGxiGI6HB
        nO/zUPgNDaaaQt9yBk+D/O0O5MU0Hg8dZ+yMNzscLwbLnVDvWIGHQF3RC9qL/fAyqHhR4sMU
        DoYL72y+EoCrWPjeaJKJASOY8woosels8FwppUU8FN7UnpOJeDTc3rubFsMHEHT+PNpPnAhO
        3anpvzMWrtd6pN5GFA4DpytKHMfBPnezryjgAGh+N0QsFAAF5w9Q4lgBO7YpRfcEKC8rZwbW
        mqtP9Fs48HwV8lCI9b8rrf9dZv23thRRDjSCNwjaFF6ITufXRgoarWBIT4lMWqOtQH1vebu3
        9nMVcv1a4UaYRSp/RWFokVop1RiF9Vo3ApZSDVM4F1nVSkWyZv0GXr8mUW9I4wU3GsXSqhGK
        gPCVaiVO0WTwq3lex+sHVAnrN9KE1AlPY4Y7xmsNCxNiy/yPRlz0fGpvTXAmnTB0JLcuDasf
        mzl1weLOyLkhz51bbtycE5fT2h4Y7z/R3tAWPg/FBg8KClZlZ+o2nYzY2H16T32JOmZcTl1W
        vKX9t58xs2v/rI2eqLi5kG8s1waVzptfJk9Kbeht0rVolmJDlqosWudQ0cIqzZRwSi9o/gLw
        gBmdkgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42I5/e/4XV3NGbOiDR4+YrR4/Hoei8Xqu/1s
        Fh+aWpktOpqZLK58fc9mMfNepsWSl3YWh5oPMFlsenyN1WLvLW2LE30fWC0u75rDZrGgBcj6
        /f0fq8WWhkNsFj9f3GCx6OpbxGax5shidgchj6u/TrJ7tPb/YPO4sJPbY9HLBhaPnbPusnts
        XqHl0fOmhdXj8tlSjweHNrN43O8+zuSxeUm9x/kZCxk9Nr7bweQxd1cfo8fnTXIB/FF6NkX5
        pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gafm72EtOMFe
        8bF/IXsD4xy2LkZODgkBE4nf8yYwdzFycQgJLGWUWHtqEnsXIwdQQkbi+PoyiBphiT/Xutgg
        at4yStx4O48FJCEsEC/x+OA9RhBbREBP4lzXRCaIokeMEg9PvGQBcZgF3rBIPFx5DKyDTcBK
        YmL7KkaQDbwCdhKvN5uBhFkEVCWer1sCdpGoQITErYcdYOW8AoISJ2c+AbM5BeIkNj2ZD2Yz
        C6hL/Jl3iRnClpfY/nYO8wRGwVlIWmYhKZuFpGwBI/MqRpHU0uLc9NxiQ73ixNzi0rx0veT8
        3E2MwDSw7djPzTsYL20MPsQowMGoxMP7QmlmtBBrYllxZe4hRgkOZiUR3vWhs6KFeFMSK6tS
        i/Lji0pzUosPMZoCPTGRWUo0OR+YovJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqem
        FqQWwfQxcXBKNTBOWxhx5Jupl8bOmQ9tfyuaJqtf3HbdxZxdc2fJ1t1bXdYruHLN+27pE+O7
        PWhl0ufX75vMZJ3lGeO9tl2bNWE3W9m2wH9hv1fN/b6iUZPReXHft/qdh7u3zA67n62axLPl
        ZX3mc8OPNvbxSqtUIgtYXAsln+X/8d+4jTE84dxyj3T/B25h3xOUWIozEg21mIuKEwFwTVba
        GQMAAA==
Message-Id: <20180913170233eucas1p19e6cd20020f27bb4db0cd927bb9a3302~UBFkQTUaX2145421454eucas1p1M@eucas1p1.samsung.com>
X-CMS-MailID: 20180913170233eucas1p19e6cd20020f27bb4db0cd927bb9a3302
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180912155824epcas5p17cd1e14fa1cb246362ec47b15248cf71
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180912155824epcas5p17cd1e14fa1cb246362ec47b15248cf71
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
        <CGME20180912155824epcas5p17cd1e14fa1cb246362ec47b15248cf71@epcas5p1.samsung.com>
        <2f980cf32a05415662272cf052c2b9e2a94c756f.1536692743.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/12/2018 05:58 PM, Christophe Leroy wrote:
> _PAGE_NO_CACHE is a platform specific flag. In addition, this flag
> is misleading because one would think it requests a noncached page
> whereas a noncached page is _PAGE_NO_CACHE | _PAGE_GUARDED
> 
> _PAGE_NO_CACHE alone means write combined noncached page, so lets
> use ioremap_wc() instead.
> 
> _PAGE_WRITETHRU is also platform specific flag. Use ioremap_wt()
> instead.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

After reading patch #1 this one LGTM.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/video/fbdev/chipsfb.c    |  3 +--
>  drivers/video/fbdev/controlfb.c  |  5 +----
>  drivers/video/fbdev/platinumfb.c |  5 +----
>  drivers/video/fbdev/valkyriefb.c | 12 ++++++------
>  4 files changed, 9 insertions(+), 16 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
