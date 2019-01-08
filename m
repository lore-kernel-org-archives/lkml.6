Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C0CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD5E206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfAHNZj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:25:39 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34980 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfAHNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:25:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so4304970qtc.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3UWWckkKJ4sfOsFIYIGHQUPHPVYDi9tv7djYZQXeV3Y=;
        b=CvKV5/UW9lj/Da45JSNlZSKdUCCxpUdiwXGGz4k5mvHGX8khtumQ1Mps4Gmq9Jk9sv
         TvMLP2Wu3S3FxzHT3MUpjQqOmy7OVayn4kJZwUZYAaUKO++kNsrGCGeSoPLaiahuAg3J
         BjHLEjPxtEpnuf9NeRUYvp2DeZpodqpJb3tYe6kU6ZolanHcGR/uFffiGMYwuKrUL3O/
         ZlK4dm+cvHovqHTH5FXExWygDP/ot+QsGsgbSajL+emqktuDYYIdKqRxT0XqGPIlSSMk
         /zr1px8NJxjg4vRa0+ChcHBX4z02UmhHo2yIdRismJ7H9QzVXsg7URO/csXugJDqHwvw
         6pQA==
X-Gm-Message-State: AJcUukdHIBpAk+pHUkf7/AQNjQDozkoBDIU/uNAySzGuTUcMXMn+jpzd
        /m7QwjTm1cjKhcDvhRe6IwlKeG4jtUnFXrB+JFU=
X-Google-Smtp-Source: ALg8bN5bZrQvkaD4VFpt5nSeT/GFj4pYAYLkJ4DZSgEhtBK+GY3/flBYcztzRPs3GoU1m1+HrHyMoKWGsGU6n/679d4=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr1648090qta.152.1546953938293;
 Tue, 08 Jan 2019 05:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20190107092952.14691-1-geert@linux-m68k.org>
In-Reply-To: <20190107092952.14691-1-geert@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Jan 2019 14:25:21 +0100
Message-ID: <CAK8P3a35ZwkrE-zxRVbwvNEs4RZTuV+-eu3uRD2OaSnVnBG3EQ@mail.gmail.com>
Subject: Re: [PATCH] m68k/atari: Avoid VLA use in atari_switches_setup()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> With gcc 7.3.0:
>
>     arch/m68k/atari/config.c: In function ‘atari_switches_setup’:
>     arch/m68k/atari/config.c:151:2: warning: ISO C90 forbids variable length array ‘switches’ [-Wvla]
>       char switches[strlen(str) + 1];
>       ^~~~
>
> Replace the variable size by the maximum kernel command line size (512
> bytes), which is an upper limit for all suboptions.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Seems fine as long as COMMAND_LINE_SIZE never grows a lot. Some
architectures use 1024 or 2048, but m68k currently has 256 (you write
512 here).

     Arnd
