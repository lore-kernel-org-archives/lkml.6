Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A18BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E572133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MbA2Hvjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E572133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIMQRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:17:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41021 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeIMQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:17:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180913110832euoutp017db7532b63765ad0927fae6e764bb6af~T8QdzUi3s0449604496euoutp01Y
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:08:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180913110832euoutp017db7532b63765ad0927fae6e764bb6af~T8QdzUi3s0449604496euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536836912;
        bh=H04Tj1ryn3rcXGl9E1Ay33D8/6C4zmV0cllpcAVGlqA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=MbA2HvjmZZNRoCkzUkaRvGL5R+a8eoNPbKXCtsKXRO+KuFdIlOeGPZe3rjLvzK8Hf
         GmdLX8knj27UnTyVJrsSJHdE7Ocr/pp15o7vWEpETootWmagJIMBaQdp0F9KOumNZD
         8OlqOF+kIbkBrigFlZAvYCRd5N2RJlN2/x99QYJs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180913110830eucas1p1e48320b0ecc36954d0bf77758925b73e~T8QcdOs7n2956029560eucas1p1h;
        Thu, 13 Sep 2018 11:08:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E2.AE.04441.E254A9B5; Thu, 13
        Sep 2018 12:08:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180913110829eucas1p2de1f7f14c8dcf186d4b829c22920365e~T8Qbh1iEV3205832058eucas1p2W;
        Thu, 13 Sep 2018 11:08:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180913110829eusmtrp12638a5da7a26df901b160b9afdcbd7a6~T8QbP_LcF2361723617eusmtrp1k;
        Thu, 13 Sep 2018 11:08:29 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-ef-5b9a452e615d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4F.85.04284.D254A9B5; Thu, 13
        Sep 2018 12:08:29 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913110828eusmtip18b880975b9c8b51b563ab8b9fe2a44e1~T8QaYmIcK0182501825eusmtip1U;
        Thu, 13 Sep 2018 11:08:28 +0000 (GMT)
Subject: Re: [PATCH v3 2/5] drm/dp: fix link probing for devices supporting
 DP 1.4+
To:     Damian Kos <dkos@cadence.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     pgaj@cadence.com, ltyrala@cadence.com, stelford@cadence.com,
        jartur@cadence.com, piotrs@cadence.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 13 Sep 2018 13:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535451894-2518-3-git-send-email-dkos@cadence.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUURjlvm2e0thzNOejxWgoQiPLaLlRhEHBoyKtEEx/5JQvNdfmuWQR
        bVQuabmUzmhjYWbZSDluNbmEDY17LmULhUNqkJNFmVaWLeMz8t+555zv+86By5IKPTObDY+O
        EzTR6kgV40hVP/resdRrsy5oeWmGG07vaCbwyeRhGheaO2j8um81fjL6kcH3rCYZ/v3GRuPL
        WUdx/tNahFMyr8mwsb+Xxj2mAgZ/tv4m8dsfK/DVT1UULn7WReD65xcpfENfgXB5Qz2NT9eZ
        Zfh1thnh9wMG5OPGG/QGxOsNR3hDio3gezLSCT4/WUvzxtIUhq8Zs9K8vnkH35dmIfiKa8f4
        e1l1BG8xvZTxE7oGiq/p1ZP8iNHdb2ag4/oQITI8QdAs2xDsGNYx6Bs7wh5qMQrHkUmWihxY
        4FZCW984SkWOrIK7geBOihbZBQX3BcGP1mBJGEHQ9lRL/JsYOmUhJaEEwbfT7TLpMYxgsPzE
        5LgL5w9fa3spu+DK6WjonshnUhHLklw4XGo7aPcwnAdMVLyYpCluEaRp59npWVwAmK1XJ9fI
        OWdo1g5QduzA+UB6TydtxyQ3H05V5ZMSVsLLgULCfgo4KwuN3wYJaTgBam0FlJR6E9iyM6c6
        u8CQpXIKz4XW7HNTnmNwUvuElBYlI2gqKmEkYR08tHTRUn4PuG1aJtEb4exwO2mngXOC58PO
        Uh4nyKrOnaLlkHxGIbkXQF97FSlhJRR3jjIXkEo3raVuWjPdtGa6/3evIKoUKYV4MSpUEL2j
        hUQvUR0lxkeHeu2LiTKiv7+29Zfl81002r23EXEsUs2Q5y3WBilodYKYFNWIgCVVrvLzProg
        hTxEnXRY0MTs0cRHCmIjmsNSKqXcyXN/kIILVccJEYIQK2j+qQTrMPs4Ki12mzk41vLKtvBn
        ka3IP3FL5f3rvf7teajfIaP6fdlY2e766gOVrmHFZIhvgF/5u8zEF167KDfBLzdx/GFNbs7c
        nIY2bULErTrftTFbjdvcH6xRFn543B84v0RMi+u52VyWHTq0aqG4acv9nXjk6GFzQM7ST0fy
        nP3cZU3b69KXeKooMUzt7UlqRPUfP5BkqbEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+927u12l4W2a/pAeckHsoVt3pvsZJUJEvxB6Ej0kauhFLeds
        d1aWPdSE1EydSWyrrXdRg3DDZ2nhk5VZaloNRE17aRZlVmJp6gr878v5nM85HDg0KXNQ/nRi
        sp7XJauTWLGn6MlEc3dIyDpTzIqCCW+U3+okUOaZYQpZG1op1N0Tjl6MfhGjqt5qCZp8M0Sh
        S4bjyNz5AKCcousSZO/volBH9UUx+tY7SaJ340p05WuZCN142Uag2lclInTb4gCo9GEthbJr
        GiSou7gBoE8DNhDli20WG8AW2zFsyxkicMe5fAKbzxgpbL+TI8YVP3opbHFuwT15zQR2XD+J
        qww1BG6udknwH9NDEa7ospB4xL5os9du+WqdNlXPByRoBf0aNoZDSjkXgeTKlRFyLlS1Z5Uy
        jFVEro7jkxIP8TpF5D55QuvbTSkj9JHHdv4UqJbkAg8aMivhYFYzmQs8aRlzA8Cb/UOEG/jB
        +9Zh0p294e+uXLG7aQjAJ64i0TTwZrbDQfPjGeDDWCjYcvrjDCCZRHhl5JfEbTgBPD8+CKaB
        mFkK/zhei6ezlImEpYWuqXU0LWICYZ5x4XR5PrMT3r31gXK3zINO48DMTA8mCuZ3PKfc84Pg
        b0s76c6LYVaZ+V/2g64BK1EIZKZZummWYpqlmGYpl4HoDvDhUwVNvEbg5IJaI6Qmx8tjtRo7
        mHqY8qYxRyVoL91WBxgasHOlH1hjjIxSHxLSNHUA0iTrIy2IMsXIpHHqtKO8TrtXl5rEC3Ug
        bOq2ItJ/fqx26v2S9Xu5ME6FIjhVqCo0HLF+0mcr0nbLmHi1nj/A8ym87r9H0B7+p0BwXu3o
        iQVk0JK6ls6SbF9pZXwADrxQxWXuKFTMubb1c99R83tjyl3G0JHu+eha46MNB89O9NXbitMl
        hqJt+qYMm6Hk9fKBEm0cfXXMhYO+R61fa914+Gd9r5czQcW2gX5l9P722qe2vvpd+onoL9Z7
        HpW3yhVZGZ8UwRpLI72LFQkJam4ZqRPUfwFEO99+RgMAAA==
Message-Id: <20180913110829eucas1p2de1f7f14c8dcf186d4b829c22920365e~T8Qbh1iEV3205832058eucas1p2W@eucas1p2.samsung.com>
X-CMS-MailID: 20180913110829eucas1p2de1f7f14c8dcf186d4b829c22920365e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180828102609epcas4p4946d20a22c2ccc6b6157dd9ca954db70
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180828102609epcas4p4946d20a22c2ccc6b6157dd9ca954db70
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
        <CGME20180828102609epcas4p4946d20a22c2ccc6b6157dd9ca954db70@epcas4p4.samsung.com>
        <1535451894-2518-3-git-send-email-dkos@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2018 12:24, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
>
> DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
> DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from DP_DPCD_REV
> to DP_ADAPTER_CAP should be retrieved starting from DP_DPCD_REV_EXTENDED.
> All registers are copied except DP_DPCD_REV, DP_MAX_LINK_RATE and
> DP_DOWNSTREAMPORT_PRESENT which represent the "true capabilities" of DPRX
> device.
>
> Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT might
> falsely return lower capabilities to "avoid interoperability issues with some
> of the existing DP Source devices that malfunction when they discover the
> higher capabilities within those three registers.".
>
> Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved and read 0
> so it's safe to check against it even if DP revision is <1.4
>
> Signed-off-by: Damian Kos <dkos@cadence.com>

Here and in next patches signed-off-by of the author is missing.

With that fixed:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


