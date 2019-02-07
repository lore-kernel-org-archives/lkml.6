Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F890C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCCE21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kYBkFpDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBGOrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:47:25 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:44114 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGOrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:47:24 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190207144721epoutp016a3d5d90b3eba83d76f2f6eeea6e4707~BHEfjGHxY0218602186epoutp01Y;
        Thu,  7 Feb 2019 14:47:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190207144721epoutp016a3d5d90b3eba83d76f2f6eeea6e4707~BHEfjGHxY0218602186epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549550841;
        bh=jkeBw4rcxbZFyef6Ayrbbc1AtgC6olqg43Jn+SSYgHY=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=kYBkFpDWGKkqUEwqkfnPYy9GqThfdfd7dL5LShZd4Od8hLVDb2uwTyuVLQwR4Jofu
         oMDarTCyy8aKaCA5Uh3e9Ak/Ec5+WIMKWIPM3CkH/X3h7XVjDUQgwuPgNI7lCxiJUd
         tWyvKU7ZpiOhWUFmOizXYeRntDYJfFh1F8XJV8BA=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190207144720epcas1p37ed3d9d6600b17054f75ae28e93a20c9~BHEeiCrPe1322813228epcas1p3c;
        Thu,  7 Feb 2019 14:47:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.34.04288.8F44C5C5; Thu,  7 Feb 2019 23:47:20 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190207144719epcas1p386c5b383683c34874e6dbb1c5660fd9d~BHEdVq17x1574315743epcas1p3S;
        Thu,  7 Feb 2019 14:47:19 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-dc-5c5c44f8a33d
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 56.C7.04015.7F44C5C5; Thu,  7 Feb
        2019 23:47:19 +0900 (KST)
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMK00CST92RO690@mmp2.samsung.com>; Thu, 07 Feb 2019 23:47:19 +0900 (KST)
Subject: Re: [PATCH] ASoC: samsung: Prevent clk_get_rate() calls in atomic
 context
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <21b8ccd7-e379-b4aa-3257-c9644ce3664c@samsung.com>
Date:   Thu, 07 Feb 2019 15:47:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <20190207143214.GC6190@sirena.org.uk>
Content-type: text/plain; charset="windows-1252"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZdlhTX/eHS0yMwdJuHYsrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvFxRVfmBw4PTZ8bmLz2DnrLrvHplWd
        bB59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CV8fora8FFtopFvWwNjLtYuxg5OSQETCRmzTsF
        ZHNxCAnsYJRYc/cfC0hCSOA7o8T8fiOYoq5FPWwQRRsYJU7vuc8C4dxnlLh18C8zSJWwQIjE
        vN+dTCC2iICyxNXve8GKmAWuMkp8/DEPrIhNwFCi92gfI4jNK2AnseHLHrAGFgFViQUT1rKB
        2KICERKHe99B1QhK/Jh8D+wkTgEjiXlnHoHVMAsYSMyYcpgJwhaXOHb/JiOELS+xec1bZpDF
        EgK32STWTvrFCPGDi8S1c2uAHuUAsqUlLh21hQhXS+za3g1V38Eo0XJhOzNEwlri8PGLrBBD
        +STefe2B6uWV6GgTgijxkNj84iA0uLYzSpy/WTiBUWYWkrNnITl1FpJTZyE5dQEjyypGsdSC
        4tz01GLDAhO94sTc4tK8dL3k/NxNjOCkoWWxg3HPOZ9DjAIcjEo8vBe0Y2KEWBPLiitzDzFK
        cDArifBK2AOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8653cI4REkhPLEnNTk0tSC2CyTJxcEo1
        MPKYndUsLdt3dM18YbNgk8WWk6OYbi46GPe84lzW5a1fDDJfXTV+XeGtpKN4fO2SSXZX2u/l
        fAlKDmE583kPzz3rydObp8/b9W7uE1fbQ01bXmZc8TbY+1Vn/c6V2y6oRAeo2d/5t1eje7Wn
        a7CX4GQDDuUWx30neA3WNmqd+sHOOf/OvwuJf6cosRRnJBpqMRcVJwIADEBmsxYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t9jQd3vLjExBucniltcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktLq74wuTA6bHhcxObx85Zd9k9Nq3q
        ZPPo27KK0ePzJrkA1igum5TUnMyy1CJ9uwSujNdfWQsuslUs6mVrYNzF2sXIySEhYCLRtaiH
        rYuRi0NIYB2jxPaVa1ggnIeMElOX/2EEqRIWCJGY97uTCcQWEVCWuPp9L1gRs8BVRomrLdug
        2ncySqyZuQqsik3AUKL3aB9YN6+AncSGL3vA4iwCqhILJqxlA7FFBSIkPj7dxwRRIyjxY/I9
        FhCbU8BIYt6ZR0A1HEAb9CTuX9QCCTMLiEscu3+TEcKWl9i85i3zBEaBWUi6ZyF0zELSMQtJ
        xwJGllWMkqkFxbnpucVGBYZ5qeV6xYm5xaV56XrJ+bmbGIFxse2wVt8OxvtL4g8xCnAwKvHw
        XtCOiRFiTSwrrsw9xCjBwawkwithDxTiTUmsrEotyo8vKs1JLT7EKM3BoiTOezvvWKSQQHpi
        SWp2ampBahFMlomDU6qB0aBNf+m3L+9COs5cst3XOFPu9wKBCJHFV8+Grg5L/razrej2Hs30
        NkeDb3uN3rbJ2zYEcNjqzXw0PZSvVf4z26VbcR3uur3sN+t7c1QUrNtvcW4qPJr9pbWDbZFq
        rARzlrFoqvPHGrlpb+pfi/OWKPUkqSzmzYr1tjnvOf/dUcbzhltTOhiVWIozEg21mIuKEwHB
        bUKnhwIAAA==
X-CMS-MailID: 20190207144719epcas1p386c5b383683c34874e6dbb1c5660fd9d
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207142052epcas1p22f1dc03c371674434ff40150cf376b6a
References: <CGME20190207142052epcas1p22f1dc03c371674434ff40150cf376b6a@epcas1p2.samsung.com>
        <20190207142041.19394-1-s.nawrocki@samsung.com>
        <20190207143214.GC6190@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 15:32, Mark Brown wrote:
> On Thu, Feb 07, 2019 at 03:20:41PM +0100, Sylwester Nawrocki wrote:
> 
>> [   82.109780] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:908
>> [   82.117009] in_atomic(): 1, irqs_disabled(): 128, pid: 1554, name: speaker-test
>> [   82.124235] 3 locks held by speaker-test/1554:
>> [   82.128653]  #0: cc8c5328 (snd_pcm_link_rwlock){...-}, at: snd_pcm_stream_lock_irq+0x20/0x38

> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.

OK, let me trim the backtrace some more and resend.
