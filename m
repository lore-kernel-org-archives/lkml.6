Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C411C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FC220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B7bv2mO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FC220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbeGXQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:48:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50006 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388321AbeGXQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:48:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180724154120euoutp02279feb7ee7417c1dd208e363c1b97359~EWFF2sCYU2936729367euoutp02d;
        Tue, 24 Jul 2018 15:41:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180724154120euoutp02279feb7ee7417c1dd208e363c1b97359~EWFF2sCYU2936729367euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532446880;
        bh=vECeDS2FB743aZ7yXU2ppK1Gznj45Jy9uSsVe2MLopk=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=B7bv2mO34QoDXR/cRo0yzoTQeu8TO9QcJs5PeeiwDFb7gEws03ciD2tLv2qGppbHc
         14q+dnBBRzQFa2ze8DUsJgpE1ijBVpQcP84Yy5K+SDnoN0qvMenC/7vUwE+ksFs5PI
         axYu7i8kTW1czPwQhmpVcAGl9AEtU5FlZm/XE70w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724154119eucas1p26a7023a375cdf66c03024417df35d5fc~EWFFGOPDt1624816248eucas1p2E;
        Tue, 24 Jul 2018 15:41:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 80.A9.04627.E98475B5; Tue, 24
        Jul 2018 16:41:19 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724154118eucas1p180ec17317f481006ff980de622c0304e~EWFEUoZDe1220812208eucas1p1s;
        Tue, 24 Jul 2018 15:41:18 +0000 (GMT)
X-AuditID: cbfec7f2-0edff70000021213-67-5b57489e3f27
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 31.49.04178.E98475B5; Tue, 24
        Jul 2018 16:41:18 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD0088LNKULZ90@eusync1.samsung.com>; Tue, 24 Jul
        2018 16:41:18 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] video: goldfishfb: fix memory leak on driver remove
Date:   Tue, 24 Jul 2018 17:41:17 +0200
Message-id: <2385463.SiM69ykDI2@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180706120422.14628-1-vasilyev@ispras.ru>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djP87rzPcKjDfZVWsz9uILF4srX92wW
        i9/5WCzv7mKxONH3gdXi8q45bBanZkxnsuien+PA4THj31RGjzuv/7J63O8+zuTx+shDFo/P
        m+QCWKO4bFJSczLLUov07RK4MrZ/n8lYMJul4uH9qSwNjHuYuxg5OSQETCRuP7jD1MXIxSEk
        sIJRYs23FWwQzmdGifczjsFVbdz0nBEisYxRouXeIVYI5zejxJN7nYwgVWwCVhIT21eB2SIC
        6hJTHzQxgxQxC7QwSczufM8OkhAW8JC4fnoLK4jNIqAq0bHjPNgKXgFNidbNU1lAbFEBL4kt
        +9qZQGxOAQuJ1VPXsEDUCEr8mHwPzGYWkJfYt38qK4StI3H22DpGiFP3sEksfBcBYbtIfP//
        gg3CFpZ4dXwLO4QtI9HZcRDsaQmB6YwSb34tZYFw1gND4MwxJogqa4nDxy9CbeCTmLRtOtCl
        HEBxXomONiGIEg+J7/c2MUOCoptR4ueXR2wTGGVmITl2FpJjZyE5dgEj8ypG8dTS4tz01GLD
        vNRyveLE3OLSvHS95PzcTYzAxHD63/FPOxi/Xko6xCjAwajEw/vBLjxaiDWxrLgy9xCjBAez
        kgjvIlGgEG9KYmVValF+fFFpTmrxIUZpDhYlcd44jbooIYH0xJLU7NTUgtQimCwTB6dUA2Nb
        +OXCopO65bf3vGCQfyde7tRgoW6XeXTLwoVuV1dJT3ZOsXvtZm64YJX01D/Ttn3fyCZg9tI5
        9SFruXTWTDZHi0NT1ZZxLG+pKPc+ejuJpSeJY9np/rOv+5UiNzu7rhKvnP7z/h1n4fumWotM
        mt8qH/U7L/Z7m13dutDrmp13Jx6VzkhvKFViKc5INNRiLipOBAAO85s2CAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t/xy7rzPMKjDSbc57GY+3EFi8WVr+/Z
        LBa/87FY3t3FYnGi7wOrxeVdc9gsTs2YzmTRPT/HgcNjxr+pjB53Xv9l9bjffZzJ4/WRhywe
        nzfJBbBGcdmkpOZklqUW6dslcGVs/z6TsWA2S8XD+1NZGhj3MHcxcnJICJhIbNz0nLGLkYtD
        SGAJo8T6OS9ZIJy/jBI7Dr9iBaliE7CSmNi+ihHEFhFQl5j6oIkZpIhZoIVJYs6Le2BFwgIe
        EtdPbwGzWQRUJTp2nAdbwSugKdG6eSoLiC0q4CWxZV87E4jNKWAhsXrqGqhtvYwSx3ufMEI0
        CEr8mHwPrIFZQF5i3/6prBC2lsT6nceZJjDyz0JSNgtJ2SwkZQsYmVcxiqSWFuem5xYb6hUn
        5haX5qXrJefnbmIEhvW2Yz8372C8tDH4EKMAB6MSD6+HY3i0EGtiWXFl7iFGCQ5mJRHeRaJA
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYxKP3Sknp+8
        5u5SlN+5QKMhju/W5qsX7rL1x2yPuaJsnlAQ/0e8SVWtsNq+4fLxb8EqvawdS8K49m6OUDV9
        /8FYoPBrltUPi+8zZbQ4jhbNcG98ZKljoHCH4Xh0646dZrMtZ3eeKbL6+vzWv5VPtyvVXWc/
        fnG75QPL9FkfV59ev2eSwVfBO95KLMUZiYZazEXFiQDq+aqdZwIAAA==
X-CMS-MailID: 20180724154118eucas1p180ec17317f481006ff980de622c0304e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180706120501epcas5p3a2db5a74c3b4b0d2c8e102fbe3943de6
References: <CGME20180706120501epcas5p3a2db5a74c3b4b0d2c8e102fbe3943de6@epcas5p3.samsung.com>
        <20180706120422.14628-1-vasilyev@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 06, 2018 03:04:22 PM Anton Vasilyev wrote:
> goldfish_fb_probe() allocates memory for fb, but goldfish_fb_remove() does
> not have deallocation of fb, which leads to memory leak on probe/remove.
> 
> The patch adds deallocation into goldfish_fb_remove().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

