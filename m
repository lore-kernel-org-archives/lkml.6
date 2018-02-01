Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeBAQaF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:30:05 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:39461 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeBAQaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:30:03 -0500
X-Google-Smtp-Source: AH8x227Pb102pA+9v9cqX4J4ZgnyPf2HHKOJBkZLeTAz9WMQbWvmfzCxdu6i+EWP/EyOylkg397TzEGxNmdBj0gQoaA=
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 1 Feb 2018 17:29:42 +0100
X-Google-Sender-Auth: 6yjJ4dpHnQPDHsT_7ltRl4tIFQg
Message-ID: <CA+7wUsz+Ud6+LFVdVs7-pPMSJmW-7opXCqs2NuYP3=enYxoD4A@mail.gmail.com>
Subject: cocci script for detecting alloc_apertures mem leak
To: Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi cocci gurus,

I am wondering if coccinelle can handle detection of kzalloc mem leak
(within alloc_apertures call) ? Typically:

$ cat drivers/video/fbdev/vesafb.c
static int vesafb_probe(struct platform_device *dev)
[...]
  info->apertures = alloc_apertures(1);

but then:

static void vesafb_destroy(struct fb_info *info)
{
  struct vesafb_par *par = info->par;

  fb_dealloc_cmap(&info->cmap);
  arch_phys_wc_del(par->wc_cookie);
  if (info->screen_base)
    iounmap(info->screen_base);
  release_mem_region(info->apertures->ranges[0].base,
info->apertures->ranges[0].size);
}

For reference:

$ cat include/linux/fb.h
static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
  struct apertures_struct *a = kzalloc(sizeof(struct apertures_struct)
    + max_num * sizeof(struct aperture), GFP_KERNEL);


Thanks for comments,
