Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506EFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08DE2747D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RXaJ26Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08DE2747D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966315AbeF1Nuf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:50:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36553 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965845AbeF1Nuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:50:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180628135029euoutp013ea551d36cb09652a6abcf9c52153931~8Vy5Pf-TA1356713567euoutp01R;
        Thu, 28 Jun 2018 13:50:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180628135029euoutp013ea551d36cb09652a6abcf9c52153931~8Vy5Pf-TA1356713567euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530193829;
        bh=EgBA0G+5gluxM6/j9Fejie7NDUrOzDeN2O83J/kArAI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=RXaJ26SmxDW6wzOViHri9zgugeL9Wievbls7uNpIM8wmxIikK40Gwb3nEElrNBFTJ
         h63Hst037q1wGnYkO5z4iwfWrRRfgk27f6HlwMH4r7GPhyUjNZ98U1A5ymqW96VHXe
         Rxjo9vbqAlqgZeE5V1E2qn5tiSIdFjyoh7TeSPUs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180628135029eucas1p27e4bbc3a615443413744f0a000769068~8Vy4iaztI2110721107eucas1p2c;
        Thu, 28 Jun 2018 13:50:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EA.17.10409.4A7E43B5; Thu, 28
        Jun 2018 14:50:28 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180628135028eucas1p1329e9e77d121cfb6280f3c2e24b1fe39~8Vy36qoQc2161421614eucas1p1X;
        Thu, 28 Jun 2018 13:50:28 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-d0-5b34e7a43325
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.1D.04178.4A7E43B5; Thu, 28
        Jun 2018 14:50:28 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PB1006HKD43QVA0@eusync1.samsung.com>; Thu, 28 Jun
        2018 14:50:28 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v5 0/3] console/fbcon: Add support for deferred console
 takeover
Date:   Thu, 28 Jun 2018 15:50:26 +0200
Message-id: <2462549.rLSfW9kX99@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180628090351.15581-1-hdegoede@redhat.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduznOd0lz02iDbbt1bNY+PAus8WVr+/Z
        LN4cn85kcaLvA6vF5V1z2Cz+P/7KarGv4wGTxdrPj9kdODz2flvA4rFz1l12j5Z9t9g97ncf
        Z/J4v+8qm8f6LVdZPD5vkgtgj+KySUnNySxLLdK3S+DKuNt0nqnglFDFzQ0TmRoY+/i7GDk5
        JARMJLZ1/2bqYuTiEBJYwSjx+N0qdgjnM6PE9j8TmWGq5n+cCVW1jFFi9v8ONgjnN6PEkSXn
        WUCq2ASsJCa2r2IEsUUE1CWmdvSAFTELtDJJXOq7CjZKWCBM4vKxH2BFLAKqEu1r5oHFeQU0
        JX7M2gsWFxXwktiyr50JxOYUsJTYuWARC0SNoMSPyffAbGYBeYl9+6eyQtg6EmePrWMEWSYh
        cJ1N4knbDSaIu10kpt5byg5hC0u8Or4FypaR6Ow4yATRMJ1R4s2vpSwQznpGiTVnjkF1W0sc
        Pn4RagWfxKRt04FO5QCK80p0tAlBlHhIXDx9FGyokEAPUO9WuQmMMrOQHDsLybGzkBy7gJF5
        FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmDKOP3v+NcdjPv+JB1iFOBgVOLhPXHFJFqI
        NbGsuDL3EKMEB7OSCO+nvUAh3pTEyqrUovz4otKc1OJDjNIcLErivHEadVFCAumJJanZqakF
        qUUwWSYOTilg9Fvqx85eFnBWNfLs1Av8k1oq7z4y4Ds4aX+lpsfHw6HBqmvsFzdYFn33lv2p
        1MtxgG1PrL99w8p3N37uP8eRrLnizFe+2sM7Jk21+vL7Oqts3McpjLs1rEo0mW031LlO6jo2
        U2IF29JdWSZO4U35LQbb5Ketv2/45O7GScZBDL8cZlxXEnNRVmIpzkg01GIuKk4EAKU/AggV
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsVy+t/xy7pLnptEG0yYI2yx8OFdZosrX9+z
        Wbw5Pp3J4kTfB1aLy7vmsFn8f/yV1WJfxwMmi7WfH7M7cHjs/baAxWPnrLvsHi37brF73O8+
        zuTxft9VNo/1W66yeHzeJBfAHsVlk5Kak1mWWqRvl8CVcbfpPFPBKaGKmxsmMjUw9vF3MXJy
        SAiYSMz/OJOpi5GLQ0hgCaPE43+32CGcv4wSLxomM4FUsQlYSUxsX8UIYosIqEtM7ehhAyli
        Fmhnkpg75yA7SEJYIEzi8rEfYEUsAqoS7WvmMYPYvAKaEj9m7QWLiwp4SWzZ1w42lFPAUmLn
        gkUsENv6GCUePfjDCNEgKPFj8j0WEJtZQF5i3/6prBC2lsT6nceZJjDyz0JSNgtJ2SwkZQsY
        mVcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEhvu2Yz8372C8tDH4EKMAB6MSD++JKybRQqyJ
        ZcWVuYcYJTiYlUR4P+0FCvGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBa
        BJNl4uCUamAMe/V+k+S23tAlc+P+clcr79pZPfvoDZM/qs+jPs3J7TvkericteBE6fOT2+1P
        XXo6fYbDydAXc19+f+G71PDQk9dxs+1/vr44ScN3vth53813Ft99XRZ2IW2aRybb5/0/Zr+3
        jdkh8LFmiQOL/pqs5kNrN3+V5z/somKqtqXFu/baRwO/unXTjiixFGckGmoxFxUnAgBnBNpx
        cwIAAA==
X-CMS-MailID: 20180628135028eucas1p1329e9e77d121cfb6280f3c2e24b1fe39
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180628090357epcas5p28361ab4b3ce11c179a167548f4851983
References: <CGME20180628090357epcas5p28361ab4b3ce11c179a167548f4851983@epcas5p2.samsung.com>
        <20180628090351.15581-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 28, 2018 11:03:48 AM Hans de Goede wrote:
> Hi All,
> 
> Here is v5 of my patch-set, to delay fbcon taking over the console (and
> binding to fbdev devices) until there actually is some text output to the
> console. This is intended for use with the "quiet" cmdline option, in
> combination with a bootloader which leaves the vendor's logo /
> EFI bootgraphics put up by the firmware intact on the EFI framebuffer.
> 
> The end goal here is a boot where the firmware shows its boot graphics
> and these stay in place for a couple of seconds until the GUI loads and
> the GUI then smoothly takes over the framebuffer without any distruptions.
> 
> Bartlomiej, I believe that this patch-set is ready for merging now and
> the first patch has Petr's ack, so can we get this merged now?

Done, thanks for patches (also for reviews & acks).

> Also please create an inmutable (or topic) branch for this, so that the
> drm people can merge it into drm-tip for additional testing.

Daniel,

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/ib-fbdev-drm-v4.19-deferred-console-takeover

for you to fetch changes up to 83d83bebf40132e2d55ec58af666713cc76f9764:

  console/fbcon: Add support for deferred console takeover (2018-06-28 15:20:30 +0200)

----------------------------------------------------------------
Immutable branch between fbdev and drm for the v4.19 merge window
(contains the deferred console takeover feature)

----------------------------------------------------------------
Hans de Goede (3):
      printk: Export is_console_locked
      fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
      console/fbcon: Add support for deferred console takeover

 Documentation/fb/fbcon.txt       |  7 ++++
 drivers/video/console/Kconfig    | 11 ++++++
 drivers/video/console/dummycon.c | 67 ++++++++++++++++++++++++++++----
 drivers/video/fbdev/core/fbcon.c | 83 ++++++++++++++++++++++++++++++++++++++++
 include/linux/console.h          |  5 +++
 kernel/printk/printk.c           |  1 +
 6 files changed, 166 insertions(+), 8 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

