Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7EAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327EB214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B42KzEOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfAJPKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:10:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46232 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbfAJPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:10:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190110151044euoutp02701c0ceea115f2c6a4e2db6e405c0057~4hU6dNBMZ0091500915euoutp02M
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:10:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190110151044euoutp02701c0ceea115f2c6a4e2db6e405c0057~4hU6dNBMZ0091500915euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547133044;
        bh=4JEigMfbNQ5WSKWZ+sqcGxd1mMIKthpbpm38EX2s9yc=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=B42KzEOxo2QQvg2Ph0GxJe4rnK7V8NkoDbChYfVcISLdCg0g2EcXq7lglyWVmmkeO
         zf7QZbUkqb4IRaGZJrn6zH07EUpPf1YIzYOEvn1OhrRBerZwAd+xD7g9BVKsRtHGdv
         9tVNpsh9JirZPKOxwQ/ygNwakFewTDMqQCIRLXDU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190110151044eucas1p280eb0c99a0cfba9f41dfb8c25d3a4ee6~4hU6E3kYF0785107851eucas1p2k;
        Thu, 10 Jan 2019 15:10:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.46.04806.370673C5; Thu, 10
        Jan 2019 15:10:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190110151043eucas1p2ae1a4572a5e65d564d1952552fe7f216~4hU5RS_qw0785207852eucas1p2R;
        Thu, 10 Jan 2019 15:10:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190110151043eusmtrp13859993a3280bdd5f98675b68b2dbfce~4hU4-ug2d0085400854eusmtrp1h;
        Thu, 10 Jan 2019 15:10:43 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-89-5c376073236f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5F.3F.04284.370673C5; Thu, 10
        Jan 2019 15:10:43 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190110151042eusmtip13cbdfa1ed0b64c0d5aec126c661c0e22~4hU4uzmf60320703207eusmtip1e;
        Thu, 10 Jan 2019 15:10:42 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] Fix stack memory disclosure
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        linux-fbdev@vger.kernel.org,
        Security Officers <security@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <c0a93d03-f150-6363-2df7-b2dec8a8638a@samsung.com>
Date:   Thu, 10 Jan 2019 16:10:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKiKA79mnTwCxTKsXBBKAvaoaX=CH61pLXdxtWQvUhhuQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzned2SBPMYg5mfGC3OdOdanOj7wGpx
        edccNourfzsYLa49mcriwOoxu+Eii8emVZ1sHuc38np83iQXwBLFZZOSmpNZllqkb5fAlXH4
        yyOWgo+8FU+mXGdpYFzC3cXIySEhYCJxum0eexcjF4eQwApGiduzJjJCOF8YJY58nMAG4Xxm
        lNgx4zo7TMu/r9uZQWwhgeWMEnvXqEMUvWeU+HB/GhtIgk3ASmJi+ypGEFtYwEDi2ZYGJhBb
        REBV4vulZmaQBmaBGYwS2563sXYxcnDwCthJzP9bB1LDAlTT+PM7WFhUIEKi/4w6SJhXQFDi
        5MwnLCA2p0CgxJqb38BsZgF5ie1v54CNlBDoZ5d48e8DE8ShLhJbfq9jgbCFJV4d3wL1gIzE
        6ck9LBAN0xkl3vxaCuWsZ5RYc+YYVLe1xOHjF8GuYBbQlFi/Sx8i7CixpP8nO0hYQoBP4sZb
        QYgj+CQmbZvODBHmlehoE4KoVpPYsGwDG8zarp0rmSFsD4nfczrZJzAqzkLy2iwk78xC2LuA
        kXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYCI5/e/41x2M+/4kHWIU4GBU4uHt8DWP
        EWJNLCuuzD3EKMHBrCTCe2e5WYwQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZ
        qakFqUUwWSYOTqkGxuVSc3fMS9vXc+rq/ddJ3kpFTPm1h7N44k5o/DGNza996SZzpjVBXHYP
        6/FWzTxfL6NryXytFsFP6zcXN0+wfRI2fyF/iqvUOr4ptWouHiq9+x1sov/Mff9s+sZg3tvd
        SsZF/6yXrkr9tGdfaPO/tTmv/G6+mfgtt0t+7r2wKoNY93i+8JvGSizFGYmGWsxFxYkAKnus
        LiADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7rFCeYxBncOslqc6c61ONH3gdXi
        8q45bBZX/3YwWlx7MpXFgdVjdsNFFo9NqzrZPM5v5PX4vEkugCVKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Pwl0csBR95K55Muc7SwLiEu4uR
        k0NCwETi39ftzF2MXBxCAksZJTYfucTUxcgBlJCROL6+DKJGWOLPtS42iJq3jBKHnz9iB0mw
        CVhJTGxfxQhiCwsYSDzb0sAEYosIqEp8v9QMNfQKo8Tkv2dYQRxmgRmMEr2XZrKBbOAVsJOY
        /7cOpIEFqKHx53dWEFtUIELi1sMOFhCbV0BQ4uTMJ2A2p0CgxJqb38BsZgF1iT/zLjFD2PIS
        29/OYZ7AKDgLScssJGWzkJQtYGRexSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERgj24793LyD
        8dLG4EOMAhyMSjy8Hb7mMUKsiWXFlbmHGCU4mJVEeO8sN4sR4k1JrKxKLcqPLyrNSS0+xGgK
        9MREZinR5Hxg/OaVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDU
        efP7p9iPsp+avM80BX9G3IpmnKCx0inC/Uz5vflsk7fuz/q5bO6Gt2WH0j2FTCvnfOkMie9f
        /32Z9yt5Q55NXy4yaXlN4GkX2cKe9ofhzfWL+W/0ju1ekimZ3PDfRCdvVV/Qs6z7PVm8t/wV
        rAw16iaqnlsckFX3ZVpd+2875rdLIidelxBVYinOSDTUYi4qTgQAC9YXwqcCAAA=
X-CMS-MailID: 20190110151043eucas1p2ae1a4572a5e65d564d1952552fe7f216
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190108234243epcas4p3b9ec45a771e71a0c3a3af7eeea93905d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190108234243epcas4p3b9ec45a771e71a0c3a3af7eeea93905d
References: <20190106075408.58405-1-vlad@tsyrklevich.net>
        <CGME20190108234243epcas4p3b9ec45a771e71a0c3a3af7eeea93905d@epcas4p3.samsung.com>
        <CAGXu5jKiKA79mnTwCxTKsXBBKAvaoaX=CH61pLXdxtWQvUhhuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/09/2019 12:41 AM, Kees Cook wrote:
> On Sat, Jan 5, 2019 at 11:51 PM Vlad Tsyrklevich <vlad@tsyrklevich.net> wrote:
>>
>> Using [1] for static analysis I found that the OMAPFB_QUERY_PLANE,
>> OMAPFB_GET_COLOR_KEY, OMAPFB_GET_DISPLAY_INFO, and OMAPFB_GET_VRAM_INFO
>> cases could all leak uninitialized stack memory--either due to
>> uninitialized padding or 'reserved' fields.
>>
>> Fix them by clearing the shared union used to store copied out data.
>>
>> [1] https://github.com/vlad902/kernel-uninitialized-memory-checker
>>
>> Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Fixes: b39a982ddecf ("OMAP: DSS2: omapfb driver")

Thanks.

> Since this driver is orphaned (according to MAINTAINERS), I think this
> fix should go via Bart's tree. Bart, can you take this?

Sure, I will merge it tomorrow (I plan to send fbdev fixes pull request to
Linus next week).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> -Kees
> 
>> Cc: security@kernel.org
>>
>> ---
>>  drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
>> index 53f93616c..8e23160ec 100644
>> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
>> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
>> @@ -609,6 +609,8 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
>>
>>         int r = 0;
>>
>> +       memset(&p, 0, sizeof(p));
>> +
>>         switch (cmd) {
>>         case OMAPFB_SYNC_GFX:
>>                 DBG("ioctl SYNC_GFX\n");
>> --
>> 2.17.0
