Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45126C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBE324A24
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Dwiu7D4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBE324A24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933849AbeF2KIs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:08:48 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48204 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeF2KIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:08:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180629100843euoutp02b489e6352098ee8522303f92a7af2a9e~8majbEW0G0358603586euoutp02b;
        Fri, 29 Jun 2018 10:08:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180629100843euoutp02b489e6352098ee8522303f92a7af2a9e~8majbEW0G0358603586euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530266923;
        bh=us0GR4qqmAHfOYIZPBTwt8hbmh02q9tWbI+2LKRqWrQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Dwiu7D4DgRGjllORycumMak8exFqgrtIyNa7H8y/YJk+rDdabKrYoE+WBXd//ssdf
         D1uX1gMXMYWK0R05sPm+sTOr9Uf9hTSuMlNYxu8HOqzOHt5BXlGbfGvJkLqW2GyJlV
         JphxrFKxoVwWP67N5j5gFaDBOD92Kin3tr8tAInk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180629100842eucas1p12b880a3a91a2ba9e284a55f9c20c3377~8maiiIRtZ2321223212eucas1p1e;
        Fri, 29 Jun 2018 10:08:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 71.83.17380.A25063B5; Fri, 29
        Jun 2018 11:08:42 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180629100842eucas1p2d1915918aae85f39ccfa577aef6baac8~8mah5UJjw1226012260eucas1p2y;
        Fri, 29 Jun 2018 10:08:42 +0000 (GMT)
X-AuditID: cbfec7f4-713ff700000043e4-da-5b36052a669e
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EE.77.04178.A25063B5; Fri, 29
        Jun 2018 11:08:42 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PB200IKQXIH5600@eusync1.samsung.com>; Fri, 29 Jun
        2018 11:08:42 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Gustavo Padovan <gustavo@padovan.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 0/3] console/fbcon: Add support for deferred console
 takeover
Date:   Fri, 29 Jun 2018 12:08:41 +0200
Message-id: <3340294.YySDL1Tsl7@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1dc75ca2113d9809299fbfb60be097758003b3f2.camel@padovan.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzneV0tVrNogwlNmhYLH95ltrjy9T2b
        xc4Hu9gt3hyfzmRxou8Dq8XlXXPYLP4//spqsa/jAZPF2s+P2R04PfZ+W8DisXPWXXaPln23
        2D3udx9n8tg5aS+Tx/t9V9k81m+5yuLxeZNcAEcUl01Kak5mWWqRvl0CV8atFVuZC/YqV2xv
        n8/YwHhLpouRk0NCwETixPwOxi5GLg4hgRWMEj2vDjBDOJ8ZJfZvvMQEU/Vr/2FGEFtIYBmj
        xJRNnhBFvxkl+ibNYwdJsAlYSUxsXwVWJCKgKTH11BY2EJtZYBWTxNfDdSC2sECYxOVjP8Bq
        WARUJY79vQXWywtU377/JCuILSrgJbFlXzvQYg4OTgFPif8PyyFKBCV+TL7HAjFSXmLf/qms
        ELaOxNlj6xgh7rzPJjHjLT9Iq4SAi8TMzz4QYWGJV8e3sEPYMhKdHQeZQM6XEJjOKPHm11IW
        CGc9o8SaM8egHraWOHz8ItQCPolJ26YzQwzllehoE4Io8ZC4ePooOyRM9jBKHN2hMYFRZhaS
        U2chOXUWklMXMDKvYhRPLS3OTU8tNspLLdcrTswtLs1L10vOz93ECEwep/8d/7KDcdefpEOM
        AhyMSjy8J66YRAuxJpYVV+YeYpTgYFYS4U1cbxotxJuSWFmVWpQfX1Sak1p8iFGag0VJnDdO
        oy5KSCA9sSQ1OzW1ILUIJsvEwSnVwLje4v6+1/M84mJfnH//4shcmYYHsS0nTgfmZNzZs0z/
        RqtD6KfnbStLH0t6fdETrletOXOsgPdk2Q+ZR8JS7B8ZPhn05rWaPDl4bu87pim6bKaTDU+J
        Tz1x5Os85W9W3lELnnU2pwadNea476tpwHvt4lGtJhWXl/sSOX+vUWLV7RJsMP467ZYSS3FG
        oqEWc1FxIgB1cCpBGgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t/xy7parGbRBqt3cFosfHiX2eLK1/ds
        Fjsf7GK3eHN8OpPFib4PrBaXd81hs/j/+Curxb6OB0wWaz8/Znfg9Nj7bQGLx85Zd9k9Wvbd
        Yve4332cyWPnpL1MHu/3XWXzWL/lKovH501yARxRXDYpqTmZZalF+nYJXBm3VmxlLtirXLG9
        fT5jA+MtmS5GTg4JAROJX/sPM4LYQgJLGCVO//LtYuQCsv8ySiw49RsswSZgJTGxfRWYLSKg
        KTH11BY2kCJmgTVMEoeeLmMBSQgLhElcPvYDrIhFQFXi2N9b7CA2L1BD+/6TrCC2qICXxJZ9
        7UxdjBwcnAKeEv8flkMs28coceHCaSaIekGJH5Pvgc1kFpCX2Ld/KiuErSWxfudxpgmM/LOQ
        lM1CUjYLSdkCRuZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgeG/7djPzTsYL20MPsQowMGo
        xMN74opJtBBrYllxZe4hRgkOZiUR3sT1ptFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJ
        CaQnlqRmp6YWpBbBZJk4OKUaGAsl2WsXLo25NFHW6sRelqa2szlFHzMeeV0MuFrEpnJhrcej
        ZPvX8qWZvV/vmSWH1j3liGzI+1/41kedKzZN5QJ3Kc83rzePuIK09/MdzrpxJ7RrySqPyr8z
        XPmNA2zPLXZwMTz6bMH+xU4pk0on8TqJHNR4cPR+1taXxybYLijlz3q5K2eCoxJLcUaioRZz
        UXEiAGJ9Q1h7AgAA
X-CMS-MailID: 20180629100842eucas1p2d1915918aae85f39ccfa577aef6baac8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180628090357epcas5p28361ab4b3ce11c179a167548f4851983
References: <CGME20180628090357epcas5p28361ab4b3ce11c179a167548f4851983@epcas5p2.samsung.com>
        <2462549.rLSfW9kX99@amdc3058>
        <1dc75ca2113d9809299fbfb60be097758003b3f2.camel@padovan.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gustavo,

On Thursday, June 28, 2018 07:44:38 PM Gustavo Padovan wrote:
> Hi Bartlomiej,
> 
> On Thu, 2018-06-28 at 15:50 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday, June 28, 2018 11:03:48 AM Hans de Goede wrote:
> > > Hi All,
> > > 
> > > Here is v5 of my patch-set, to delay fbcon taking over the console
> > > (and
> > > binding to fbdev devices) until there actually is some text output
> > > to the
> > > console. This is intended for use with the "quiet" cmdline option,
> > > in
> > > combination with a bootloader which leaves the vendor's logo /
> > > EFI bootgraphics put up by the firmware intact on the EFI
> > > framebuffer.
> > > 
> > > The end goal here is a boot where the firmware shows its boot
> > > graphics
> > > and these stay in place for a couple of seconds until the GUI loads
> > > and
> > > the GUI then smoothly takes over the framebuffer without any
> > > distruptions.
> > > 
> > > Bartlomiej, I believe that this patch-set is ready for merging now
> > > and
> > > the first patch has Petr's ack, so can we get this merged now?
> > 
> > Done, thanks for patches (also for reviews & acks).
> > 
> > > Also please create an inmutable (or topic) branch for this, so that
> > > the
> > > drm people can merge it into drm-tip for additional testing.
> > 
> > Daniel,
> > 
> > The following changes since commit
> > 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
> > 
> >   Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/bzolnier/linux.git tags/ib-fbdev-drm-v4.19-
> > deferred-console-takeover
> > 
> > for you to fetch changes up to
> > 83d83bebf40132e2d55ec58af666713cc76f9764:
> > 
> >   console/fbcon: Add support for deferred console takeover (2018-06-
> > 28 15:20:30 +0200)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between fbdev and drm for the v4.19 merge window
> > (contains the deferred console takeover feature)
> > 
> > ----------------------------------------------------------------
> > Hans de Goede (3):
> >       printk: Export is_console_locked
> >       fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
> >       console/fbcon: Add support for deferred console takeover
> > 
> >  Documentation/fb/fbcon.txt       |  7 ++++
> >  drivers/video/console/Kconfig    | 11 ++++++
> >  drivers/video/console/dummycon.c | 67 ++++++++++++++++++++++++++++
> > ----
> >  drivers/video/fbdev/core/fbcon.c | 83
> > ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/console.h          |  5 +++
> >  kernel/printk/printk.c           |  1 +
> >  6 files changed, 166 insertions(+), 8 deletions(-)
> 
> Pulled into drm-misc-next, thanks

Please also apply fixup branch:

The following changes since commit 83d83bebf40132e2d55ec58af666713cc76f9764:

  console/fbcon: Add support for deferred console takeover (2018-06-28 15:20:30 +0200)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/ib-fbdev-drm-v4.19-deferred-console-takeover-fixup

for you to fetch changes up to 334bb8972a131e604a741e9b284d8867190c723e:

  console: dummycon: export dummycon_[un]register_output_notifier (2018-06-29 11:46:19 +0200)

----------------------------------------------------------------
Immutable branch between fbdev and drm for the v4.19 merge window
(contains build fixup for the deferred console takeover feature)

----------------------------------------------------------------
Hans de Goede (1):
      console: dummycon: export dummycon_[un]register_output_notifier

 drivers/video/console/dummycon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 45ad925..0254251 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -38,11 +38,13 @@ void dummycon_register_output_notifier(struct notifier_block *nb)
 	if (dummycon_putc_called)
 		nb->notifier_call(nb, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(dummycon_register_output_notifier);
 
 void dummycon_unregister_output_notifier(struct notifier_block *nb)
 {
 	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
 }
+EXPORT_SYMBOL_GPL(dummycon_unregister_output_notifier);
 
 static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {


Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

