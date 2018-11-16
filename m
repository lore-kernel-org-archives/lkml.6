Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76972C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D98120883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0Lt9kkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D98120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbeKQIwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:52:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeKQIwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:52:46 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154562086B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542407912;
        bh=noP3MWRg5zGi1G4xuhxMXMPCIyE0ynShV3lO353HebA=;
        h=From:Date:Subject:To:From;
        b=V0Lt9kkXKAys0Hlr74eCSjx/pR2xryov2sMWq8hxbl1t6lGwdDi/6G6f+IaAoDbSo
         Cj2AYsIImKP0peEDHeQZLAPaMNGxuGbutUp8ZAz4Em8l5X5HazOixqdO1ASfLeYhup
         egnY7IQquabxRkctMmK4G4KowbmB/8RG1HNARmbM=
Received: by mail-oi1-f171.google.com with SMTP id r127-v6so20947392oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 14:38:32 -0800 (PST)
X-Gm-Message-State: AGRZ1gL5e6C3jDsXk1ocfNICrFef5gXWpaAc0aZ1/guXRp1ot3m2Chsz
        LODuMProiwUB/MCEpjdZVctD6pFmlfnhEzntjUg=
X-Google-Smtp-Source: AJdET5dp1uJaQP34fJUeVGvUI+k4siqnXvRJ+C7cz97XXcFfIW4DDmJw1tpG+LrQvJSWvfejpt0qmVQcw5shRvVOkGY=
X-Received: by 2002:aca:6155:: with SMTP id v82-v6mr1920463oib.270.1542407911428;
 Fri, 16 Nov 2018 14:38:31 -0800 (PST)
MIME-Version: 1.0
From:   Timur Tabi <timur@kernel.org>
Date:   Fri, 16 Nov 2018 16:37:55 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXYPeb90DzGnHr+c7jhfbZA7z7wiYMzDxgMP4nmuoYaiQ@mail.gmail.com>
Message-ID: <CAOZdJXXYPeb90DzGnHr+c7jhfbZA7z7wiYMzDxgMP4nmuoYaiQ@mail.gmail.com>
Subject: Enable tracing only for one function and its children?
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to enable ftrace tracing only for one specific function
and all the functions it calls?  Then when the function returns,
disable tracing until the next time?

When I pass the function name only to set_ftrace_filter, it literally
only traces that function, which doesn't help me.  I tried setting
writing "nvidia_ioctl:traceon" to set_ftrace_filter, but that just
gave me an "invalid argument" error.  And even if that did work, I
don't know what function to use for :traceoff.
