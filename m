Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66659C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18751208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wwxz6uOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18751208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756721AbeFOXJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:09:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51771 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeFOXJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:09:05 -0400
Received: by mail-it0-f68.google.com with SMTP id n7-v6so4872548itn.1;
        Fri, 15 Jun 2018 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjHm1RDGvK+d81PIAOpBXuy1jNwfkFS3Esx0ryO77+M=;
        b=Wwxz6uOVbMvYXRTXUsk4HxKBc7KkCRz3z1Nx7pz7/UFronEgjajIxMxt8kGln42WZv
         3vefJAkogPcHqJVp73+MigLTC0RIIonBfj8g4lrzfEpNILVbMD8NxJ8tkjuhva6WNPsW
         N03AFsPPCmDrEjctuNgCL++rhbx/70St0pzt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjHm1RDGvK+d81PIAOpBXuy1jNwfkFS3Esx0ryO77+M=;
        b=NqIYatW7wO6Ow739Xzd/AyTT1Pf9p94jo+qbWYLw0xjeVYdfR3FuRRIdMXC0PLCyvU
         keASl6E6W26j1L3zvqaKMhcGrTlgjNvhYPzBRhptvXa0pcWoB20Qpu0oPDxRlqXiIu+0
         daJTysCvvijMzIGkQhlkTX06XWYSVX+fHZxvpK6hT10iL6pzIpt8N7kcacOZIm0uaLdd
         Ldr9iEb6tEA0v5i2Ts61G7zWJ85TrlJzCKKvCf1mTbWOO+n5TFi28QQqNhDPBCFxbkun
         eot5cwJ0yhxUdWC3I9u9oljlX2E4K6i3AK0uFfiXnViMRpnuWd1k6X0xXTGxQAVrBO2Q
         6tyA==
X-Gm-Message-State: APt69E0vlgsOfjdQI8zYKiojXDVtS1DthBOf6HW7DwAHctgaDuRcAU2n
        ulsEJRchWA1dYbFJtuEZYCYDaPKdz+W00uaIYG4=
X-Google-Smtp-Source: ADUXVKK4p+ql7SiHiBMSkxPc1p6ARKjNVNymsD7gVHUYjO/8IfiJRj+1P5ywdDN7vGtjGCi7+JUOVAua+dhNvNkPSNg=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr2897923itd.16.1529104144426;
 Fri, 15 Jun 2018 16:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com> <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Jun 2018 08:08:53 +0900
Message-ID: <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
To:     wei.w.wang@intel.com
Cc:     virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 2:08 PM Wei Wang <wei.w.wang@intel.com> wrote:
>
> This patch adds a function to get free pages blocks from a free page
> list. The obtained free page blocks are hints about free pages, because
> there is no guarantee that they are still on the free page list after
> the function returns.

Ack. This is the kind of simple interface where I don't need to worry
about the MM code calling out to random drivers or subsystems.

I think that "order" should be checked for validity, but from a MM
standpoint I think this is fine.

                Linus
