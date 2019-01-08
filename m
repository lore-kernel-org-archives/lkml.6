Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F371C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECFE2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dweQddJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfAHNHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:07:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38240 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfAHNHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:07:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so4144652ede.5;
        Tue, 08 Jan 2019 05:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0f6UrB9eG21FaH2qt7/MrkB3ozAkq3ZrkwxB3DCW1Wg=;
        b=dweQddJSTgfG2jf5zVDQ05buiubqIyUjzDqRYBohwDIf3yztOpQVWJ7y/QnnG7RsmY
         9c0n1J8PlWyHTBJ0Av7aHCqAL/mlPY4fU1gKMVsBIQoIViQm9fFtJP1vFw8BPBjs9uO4
         j0Bt8eQqw2ffa8IQXRG45yloEK0l0oc7g58rtc68rPbBZa2MXQ3u2WjXNDz+LwohDdJ8
         hCWQhdZBkrJut4mORWPFeuz+TWJeiuZ2lRBr8LnoZQeGbV0kGd/7hBZ6nmsxkl1kmsiM
         87w1G1QkAwAr3fefyBL52N8CjLAWDPEFK9aSUQiRJ7gNkfTCk5U3U2JI7h7B95iv8wvX
         GQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0f6UrB9eG21FaH2qt7/MrkB3ozAkq3ZrkwxB3DCW1Wg=;
        b=eMDLb/lTnHAWz6x9sAD4RCl4vAemRKwuA3Fi11TYdz/4qqZXCFaT8m8TkkblAUyhw3
         t5SmI85ri+/ix55PLoocNKTMGLVMn99RdRyC7mkeSvBMvUlGoiVUZ28DykkkZg/QGH3N
         JhJUIRzj/QzsaNXY16/72Nc7vCufRDXaRxAfNFlkXVjL0DNCcYFZucqzSdIC0KPjz4ke
         Tvl7NlgBqqNBX5puol2qgRgs9gGKYD/2mcjLNUi9GgeE7XuNG03oLQJwoJyOe8WDWb2o
         bCxw2XWA6vtYRF2UhTkRndOjIT9a+SqkqoGTTcmrdx53WhEiuTRHRdA+xpbmv4EDHfNO
         Xjdw==
X-Gm-Message-State: AJcUukc7/B02u1PsbKhVqI3VU8aN+qcRn5WBKUzHB6S92ZsYkWQfPicV
        AihOAaZgAMJITrZMLKc0xyB4xn0b
X-Google-Smtp-Source: ALg8bN4sHcePagvPrtspfImXlfZ1dS4PwFE2WtpOpqA/2URVr0XhuP6TDoj5IVr4t3YZACNcA8mDMQ==
X-Received: by 2002:a50:b623:: with SMTP id b32mr1982034ede.55.1546952870836;
        Tue, 08 Jan 2019 05:07:50 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id l41sm29979633eda.83.2019.01.08.05.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 05:07:50 -0800 (PST)
Date:   Tue, 8 Jan 2019 14:07:47 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] rmmod g_mass_storage result to segmentation fault
Message-ID: <20190108130747.GA13437@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When running an imx_defconfig on a imx6q-sabrelite, rmmod g_mass_storage lead to the following crash:
[  143.952834] Internal error: Oops: 817 [#1] SMP ARM
[  143.957639] Modules linked in: dmatest psmouse serport da9063_wdt wl12xx wl18xx wlcore wlcore_sdio brcmfmac brcmutil mwifiex_sdio mwifiex_pcie mwifiex rtl8150 pegasus cdc_eem i2c_algo_pca i2c_algo_pcf echainiv bnep crc_ccitt libcrc32c crc7 isofs nls_iso8859_15 udf crc_itu_t msdos binfmt_misc gspca_main uvcvideo adv7180 snd_usb_audio snd_hwdep snd_usbmidi_lib usb_f_uac2 usb_f_hid usb_f_uac1 u_audio usb_f_obex usb_f_eem usb_f_printer usb_f_uvc usb_f_ecm usb_f_midi snd_rawmidi usb_f_ecm_subset usb_f_ss_lb usb_f_serial usb_f_ncm g_ffs usb_f_fs g_zero g_audio g_mass_storage(-) usb_f_mass_storage usb_f_rndis u_ether usb_f_acm u_serial libcomposite configfs usb_wwan usbserial imx_vdoa videobuf2_vmalloc [last unloaded: g_ncm]
[  144.021308] CPU: 3 PID: 9158 Comm: rmmod Not tainted 5.0.0-rc1-next-20190108 #1
[  144.028623] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  144.035170] PC is at usb_gadget_unregister_driver+0xac/0xd4
[  144.040748] LR is at 0x1242afc4
[  144.043895] pc : [<c079af08>]    lr : [<1242afc4>]    psr: 60000013
[  144.050166] sp : ed0e7f48  ip : a54b4ce2  fp : 00000000
[  144.055396] r10: 00000081  r9 : ed0e6000  r8 : c01011c4
[  144.060626] r7 : 00000081  r6 : bec49b98  r5 : bf12916c  r4 : c129176c
[  144.067159] r3 : 00000200  r2 : 00000100  r1 : 00000200  r0 : 00000100
[  144.073693] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  144.080833] Control: 10c5387d  Table: 3d33404a  DAC: 00000051
[  144.086585] Process rmmod (pid: 9158, stack limit = 0x2ac398d3)
[  144.092510] Stack: (0xed0e7f48 to 0xed0e8000)
[  144.096877] 7f40:                   bf129200 c120c908 bec49b98 c01c965c 616d5f67 735f7373
[  144.105063] 7f60: 61726f74 b6006567 00000017 c01175c8 b6f114c8 ed0e7fb0 bec49e14 000a1a98
[  144.113249] 7f80: bec49b7c c0117aec ffffffff c33d43a5 000278d4 c33d43a5 000278d4 616d5f67
[  144.121435] 7fa0: 735f7373 c0101000 000278d4 616d5f67 bec49b98 00000880 00000000 bec49e18
[  144.129621] 7fc0: 000278d4 616d5f67 735f7373 00000081 00000000 00000000 b6faf000 00000000
[  144.137807] 7fe0: bec49b90 bec49b80 000277b8 b6eb52f0 60000010 bec49b98 00000000 00000000
[  144.146006] [<c079af08>] (usb_gadget_unregister_driver) from [<c01c965c>] (sys_delete_module+0x130/0x1dc)
[  144.155586] [<c01c965c>] (sys_delete_module) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[  144.163855] Exception stack(0xed0e7fa8 to 0xed0e7ff0)
[  144.168914] 7fa0:                   000278d4 616d5f67 bec49b98 00000880 00000000 bec49e18
[  144.177100] 7fc0: 000278d4 616d5f67 735f7373 00000081 00000000 00000000 b6faf000 00000000
[  144.185283] 7fe0: bec49b90 bec49b80 000277b8 b6eb52f0
[  144.190344] Code: e5953070 e595206c e3a00c01 e3a01c02 (e5823004) 
[  144.196538] ---[ end trace 86952e6cc74d8e8b ]---
Segmentation fault

Regards
