Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E93BECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005E72098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005E72098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIYCmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:42:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33360 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbeIYCmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:42:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id i10-v6so11019669qtp.0;
        Mon, 24 Sep 2018 13:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nN8BHrtI6KL/+GnW9cBbHpIBYl14RtMLWXSvPS5awJM=;
        b=hDAV7kb57V3TQB+v/d3UH9Er+jrCU4/8e8bX61/BskmLWXpCyEeoi8/XROEMouLigg
         kRHQQ1tOHD2FNvxT58jJocUnLxL2mHSAicDomBB9r3dw3UsplrHcQebcApRuzQ6PSy9z
         NHCfegBmGxo8ycOVsO/IcEVKuh+tF0Z/hhSdjEmAnjIwuEu8UMQ8y3tj9Aj0WLXtdEnP
         ZOKKjb79wDhSUXe0YDU4pUUhimVMW6Uwzf86AZPT4hQlzLKA4rDd6dwwfIIACrciP0HV
         wvwQOUzvwF4nbBb3A0BuZBktcgcP4aSSkJNWOrSlik1bVNE0ZpjAlPayGyqE0HIu+xcl
         gC7g==
X-Gm-Message-State: ABuFfojktpJx1O6hA8uMpr8y52kidaLlGq3J0oQTwqJtWQThhWFJCEjY
        yaQk9cyn8gepDRt284qJfeotzAe4G+51Cq+zWoM=
X-Google-Smtp-Source: ACcGV60Cq7V951ROI5ufSpavt6URtLjWVOYNw925LOw6m9tZuKS/fNzTLBu2ZESMkqMCTl9KKDWuHmxUUHd1KxykkQM=
X-Received: by 2002:ac8:7254:: with SMTP id l20-v6mr438595qtp.213.1537821500277;
 Mon, 24 Sep 2018 13:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537276837.git.ren_guo@c-sky.com> <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537276837.git.ren_guo@c-sky.com>
In-Reply-To: <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537276837.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Sep 2018 22:38:04 +0200
Message-ID: <CAK8P3a0RDiP_R8+Lo9-nwiRS3k1NrtcsCFLi0Ww0TJGoAdb3iQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] csky/dma: bugfix dma_sync_for_cpu/device
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 3:48 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> ref: https://lkml.org/lkml/2018/5/18/1068
>
>         map             for_cpu         for_device      unmap
> TO_DEV  writeback       none            writeback       none
> TO_CPU  invalidate      invalidate*     invalidate      invalidate*
> BIDIR   writeback       invalidate      writeback       invalidate
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Same comment as for the other patch: Explain why the original
version is wrong first. When giving a reference to some other
discussion, use the "Link" tag above your Signed-off-by line.
To point to a discussion on lkml, lore.kernel.org is the
recommended archive, so it would become

Link: https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/

       Arnd
