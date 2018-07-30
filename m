Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5AD13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4EF20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4EF20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbeG3QNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:13:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34270 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeG3QNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:13:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so8564032wme.1;
        Mon, 30 Jul 2018 07:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1jqj50YtXDVfyXKeRyILu+4ShyBt2jy5XKqCQQ1xoDs=;
        b=qqMq0Nz5kdCqDC5TSA5yDUyyXk52yRDGsyEzpFpP72rC2AB1OeF5o3HoRfnUKSm9kw
         C3nCiZnkZW7gNkjDTiT5PC/5+5xjI3UaJRI7Z+9+qU2SaZMSUU7j8GAUQNxMB+6cLnsp
         g0J8KfM1XmykLTxsqwhIOYZIaZ2xvqu+9D473KdMB+jeP0HchVxwd5VlgjIl1RZOCWqw
         P1ZQo9B7qHEpSnmtechb4cYQD+10ACnW06Zh/VjQvZiiwI0FfY/LcPrc3i3v8HDBF07w
         9rapcbw6Srfg5Kj/p/3kn6bHziJxGtQkEAmXLvkjGxnfw/lzBe9ew7CfjZnMhCHn7GFE
         3V5g==
X-Gm-Message-State: AOUpUlHH0/mdq/Kmy4cPypR3YYr7rS6qr2KayQJbxwkQ1tcMbuhDB9IY
        HvqvXY7HmrDLMimkNTL2K/U=
X-Google-Smtp-Source: AAOMgpfMB0ODtdIzAUsFyeW/BlTdX0vKG9nEpcv6v4mk8+aVOgV3w2bTQD9U5VYxnDLrINj6pn9p8g==
X-Received: by 2002:a1c:e3d5:: with SMTP id a204-v6mr15343607wmh.20.1532961470553;
        Mon, 30 Jul 2018 07:37:50 -0700 (PDT)
Received: from localhost.localdomain (u-084-c050.eap.uni-tuebingen.de. [134.2.84.50])
        by smtp.gmail.com with ESMTPSA id 71-v6sm16599753wmq.17.2018.07.30.07.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:37:49 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk,
        Christian Brauner <christian@brauner.io>
Subject: [RFC PATCH 0/4] file: export functions for binder module
Date:   Mon, 30 Jul 2018 16:37:06 +0200
Message-Id: <20180730143710.14413-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

We currently plan on turning the Android binder and ashmem driver into a
module. We have seen more and more requests by users to be able to use
the binder and ashmem features without wanting to convince each distro
to enable it by default in their kernel. Debian already started to carry
patches for turning them into modules.
The main problem is that binder currently uses multiple functions that
are not exported and are pretty low-level. The most obvious ones that
fall into this category are __alloc_fd(), __fd_install(),
get_files_struct(), and put_files_struct(). Being an IPC mechanism
binder seems like a reasonable user of these functions.
I don't expect this patch to be mergeable but rather to kick-off a
discussion if we can either simply export them as they are or how we can
get supportable exports that allow access to struct files_struct.

Thanks!
Christian

Christian Brauner (4):
  file: export __alloc_fd()
  file: export __fd_install()
  file: export get_files_struct()
  file: export put_files_struct()

 fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.17.1

