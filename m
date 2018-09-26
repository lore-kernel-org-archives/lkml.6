Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5571CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E9D2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTpWKcug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E9D2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeI0EIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:08:10 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42998 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeI0EIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:08:10 -0400
Received: by mail-yw1-f66.google.com with SMTP id h134-v6so225845ywc.9;
        Wed, 26 Sep 2018 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dbJ9dw+j5Fkdnr648wIBTx+ZdirZClkdxE7IVB+KI3o=;
        b=kTpWKcugsz2WSk5J/CMOQfhXs41y/nv/oGhWf9ciPS2qcDGSpN5x7jYFGXhMxFtBOD
         LoXoQKsKlka4NYpDYz6Q2Qpi6Ho5/Q78KtgC/NQSGHhRCmDu1kXemZh98cVu0d8iN467
         bhrIk7q92kOWCg7zRX9MPIjE9jag0FEDlXEt2rmAKm5TArhBv8+aSm31GaDyaz3qpQBJ
         z38IYC2AfJPZCRKDDSwnYRmXs4RQpkbbb3TO2Kam8JhFFv7b/dNDnkjs/4c359RUSVmo
         tkr47jcPyNd0omnqFggDTTQX2/HbTc77exT+emHnMLSIOWDezBbdVWMD2RpR2mH6+Vy9
         TEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dbJ9dw+j5Fkdnr648wIBTx+ZdirZClkdxE7IVB+KI3o=;
        b=pfHEzBnuDQLR0dzC5t052oruuO24PmTlb0hUQbQicQd1ubkJU9z/xy+PpBbwp2kxWL
         M6ZEJgqkrTc2KmFhxDMxzSx3Y2Rdcb1llmo5na60O2dGQLvdlWghmG+w3voQ4Ao7aig8
         c/T8CTVJqHNQD49JplV0x2PNWPbWQANlIbYPehsmu4CDusohAsDkhNaqbpdoVaxOjM5z
         zVgAOCfbqRDeIyh2xITIyiuC9SStobfvZhZISsU6+2pfJihDG6lM1/behTLCh5FEzzNg
         8PQgFZ73+DmWGQoYKh8y7nLiZgoFB/jEwT51qOfyCvHDtt9FYwJ3kEcu6HWFiS6dxpEa
         gx3g==
X-Gm-Message-State: ABuFfogA4zKTONMsOU7c9Wcinq7zG3I34whEpCByMumtyzMsrotTdfaS
        sZdAbiZp95ABwo+ynPclUTE=
X-Google-Smtp-Source: ACcGV60AGhy3FVY1NMHadLhh14mt2L9rARTv81Jrst9WuKheOGEDdiDj9TU5LLksjYgqEi6KJt2V+w==
X-Received: by 2002:a81:31cc:: with SMTP id x195-v6mr4119034ywx.502.1537998789899;
        Wed, 26 Sep 2018 14:53:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::4:2c77])
        by smtp.gmail.com with ESMTPSA id k2-v6sm147812ywh.52.2018.09.26.14.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 14:53:09 -0700 (PDT)
Date:   Wed, 26 Sep 2018 14:53:07 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, len.brown@intel.com,
        dave.jiang@intel.com, rafael@kernel.org, vishal.l.verma@intel.com,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        dan.j.williams@intel.com
Subject: Re: [RFC workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Message-ID: <20180926215307.GA270328@devbig004.ftw2.facebook.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926215138.13512.33146.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Sep 26, 2018 at 02:51:38PM -0700, Alexander Duyck wrote:
> This patch provides a new function queue_work_near which is meant to
> schedule work on the nearest unbound CPU to the requested NUMA node. The
> main motivation for this is to help assist asynchronous init to better
> improve boot times for devices that are local to a specific node.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Why not just use unbound workqueues, which are NUMA-affine by default?
Are there big enough advantages?

Thanks.

-- 
tejun
