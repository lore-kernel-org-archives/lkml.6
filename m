Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6430ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6723E20890
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rjxOAJq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6723E20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbeGXRUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:20:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39326 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388414AbeGXRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:20:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180724161320euoutp01d47676c6214bbf3f98c6e023f7fb8326~EWhCo5HeX2680226802euoutp01d;
        Tue, 24 Jul 2018 16:13:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180724161320euoutp01d47676c6214bbf3f98c6e023f7fb8326~EWhCo5HeX2680226802euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532448800;
        bh=9NjPjHNyAp5q1q8wXIIvc9k1Ku3ZWrTFJ0T2jWSkkto=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=rjxOAJq3ZUQnG/NpKCdHFWk+1kYPwSrUTdJVCy/IhiLFvdfnYjFjOHNBjaFsxSt3d
         /TBc4t4copYcka6qbSGm4eFl8kfhr54WfV1EaZKfXgjHh80ViDBoF1IqkMvog02sF9
         3lNHHJkJBgXZIc8dR6qAMfEg748XyFzWNPTVj1/E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724161320eucas1p1c48122b89109d3228843051dd4d38a1f~EWhCPyKP_0299202992eucas1p1X;
        Tue, 24 Jul 2018 16:13:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EE.61.05751.020575B5; Tue, 24
        Jul 2018 17:13:20 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724161319eucas1p2a196c398e21593fe8623c2ac6991a638~EWhBoEsjc1910019100eucas1p2G;
        Tue, 24 Jul 2018 16:13:19 +0000 (GMT)
X-AuditID: cbfec7f4-c47ff70000001677-fc-5b5750207996
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 92.19.04183.F10575B5; Tue, 24
        Jul 2018 17:13:19 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD00868P27DK00@eusync4.samsung.com>; Tue, 24 Jul
        2018 17:13:19 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v2] console: Replace #if 1 with a bool to ignore
Date:   Tue, 24 Jul 2018 18:13:19 +0200
Message-id: <1582481.BL9yPUoula@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180712092938.22e33641@gandalf.local.home>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djP87oKAeHRBs9mcVjMWb+GzeL/tonM
        Fle+vmezeHN8OpPFib4PrBaXd80BSjz+ymqxr+MBk8WjCZOYLNZ+fsxuseXNRFYHbo+93xaw
        eOycdZfdo2XfLXaPEzN+s3jc7z7O5PF+31U2j/VbrrJ4bD5d7fF5k1wAZxSXTUpqTmZZapG+
        XQJXxoOld1gLLnBW7Di+j6mB8Qt7FyMnh4SAicS7p0fZuhi5OIQEVjBKrNkxkwUkISTwmVFi
        7TLVLkYOsKKvJ9ghapYxShxZ94QFwvnNKLH/yhVGkAY2ASuJie2rwGwRAQ2JlgXPwQYxCxxk
        lmhemwliCwu4SMw+O5MVxGYRUJWYff4AG8gCXgFNiSndwSBhUQEviS372plAbE4BS4mPr2aA
        2bwCghI/Jt+DGikvsW//VFYIW0fi7LF1jCD3SAh8ZpPo3jWVCeIzF4kLuxexQNjCEq+Ob4H6
        WEbi8uRuFoiG6YwSb34thXLWA71/5hhUt7XE4eMXoVbwSUzaNp0ZEhS8Eh1tQhAlHhILGlZB
        g66HUaJ76Rq2CYwys5BcOwvJtbOQXLuAkXkVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZG
        YHI5/e/4lx2Mu/4kHWIU4GBU4uH9aBceLcSaWFZcmXuIUYKDWUmEd5EoUIg3JbGyKrUoP76o
        NCe1+BCjNAeLkjhvnEZdlJBAemJJanZqakFqEUyWiYNTqoGxPcd/cdSvFstQrctu1VoiETdD
        5LPiHhzQ1LT6cvvs6ZJN90WcddsSHKR9cg+Uv4re0F3DGVQ9x39roc3dlPcGs05ZGvyunzz1
        xJ2XzKnt3O6n69c/MOPjsl6Sr/jPdZbR7TPPJn1OEDT8tH/yygsVObW79DWuNQjO7b+xTU2+
        +rJOa1jz2ztKLMUZiYZazEXFiQCfYl8QKgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xa7ryAeHRBhfmalnMWb+GzeL/tonM
        Fle+vmezeHN8OpPFib4PrBaXd80BSjz+ymqxr+MBk8WjCZOYLNZ+fsxuseXNRFYHbo+93xaw
        eOycdZfdo2XfLXaPEzN+s3jc7z7O5PF+31U2j/VbrrJ4bD5d7fF5k1wAZxSXTUpqTmZZapG+
        XQJXxoOld1gLLnBW7Di+j6mB8Qt7FyMHh4SAicTXE0AmJ4eQwBJGicXr0rsYuYDsv4wSs65M
        ZQJJsAlYSUxsX8UIYosIaEi0LHjOAlLELHCYWaL/5zewhLCAi8TsszNZQWwWAVWJ2ecPsIEs
        4BXQlJjSHQwSFhXwktiyrx1sJqeApcTHVzOYIJb1MUp8nbAWLMErICjxY/I9FhCbWUBeYt/+
        qawQtpbE+p3HmSYw8s9CUjYLSdksJGULGJlXMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbG
        tmM/t+xg7HoXfIhRgINRiYfXwzE8Wog1say4MvcQowQHs5II7yJRoBBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbGcDGGLEPGfUfivvKqieefZLo189W/
        kAsqH47/u7dfRlN93qzy29GbbjDtO871p9go+oPyIXv+PfeEs9M89J9ttGRaK/4v+1AUb80r
        DZPjcr93h18qC6/edCU4YlK3zdxwSclzV63XNjAcOLH+24Kr29SqRE81XDka+Ob0KZbuLu1m
        71shD9I+KLEUZyQaajEXFScCAOUcNCaIAgAA
X-CMS-MailID: 20180724161319eucas1p2a196c398e21593fe8623c2ac6991a638
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180712132944epcas4p3091e1c7a7aa1bd4da95750908012e616
References: <CGME20180712132944epcas4p3091e1c7a7aa1bd4da95750908012e616@epcas4p3.samsung.com>
        <20180712092938.22e33641@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 12, 2018 09:29:38 AM Steven Rostedt wrote:
> 
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> There's been discussion on the fb list about the addition of
> WARN_CONSOLE_UNLOCKED() inside the fb code. The complaint is that when
> the fb module is loaded with lockless_register_fb the console lock is
> not taken for debugging reasons. With the addition of
> WARN_CONSOLE_UNLOCK() within the fb code, this causes the console to
> fill up with warnings when trying to debug the fb driver.
> 
> There's also a #if 1 that enables the warning which was added before
> git history, and we look down on constant #if's in the kernel nowadays
> anyway.
> 
> Remove the #if 1 and add a ignore_console_lock_warning boolean that can
> be set by drivers to ignore the warning in order to do debugging.
> 
> Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

