Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F7AC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C61F20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="l3m2rX27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C61F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeLMT4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:56:00 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54892 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeLMT4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:56:00 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so5529747ita.4;
        Thu, 13 Dec 2018 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TsKo232A90Q/y11IqC0AmQfyKdijRKOvwm3OJEXsKlg=;
        b=l3m2rX27q6sVM+8YWa0xbbDWX6k5XCv7TWdyvaoN7/fnNVmTY070aKfgCNcc0/+fS2
         cPGlM4kSq6eOIheixxHuzV+ni80lHnr9r42oF0/AYrmckzdV9caFcED57E3hl6GVfK8f
         bKedDZg3Xx49m6d0ZyBbu348ffBa3SspIZuvHfxOE5hueAUNP99icNDYHQTSKlie9xZL
         1MVGaPT4kxlShQDLWdOic0D/wKESM0uPE3An5B5szOshGNWwRL/DVfzAn/TPquYnThnn
         3Drq7ARpAgmaGkFdg1LkuI40cGL83CizPhYFUFkjrYanrGvZ34Ke5IRY0xakeEZazTC4
         mdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TsKo232A90Q/y11IqC0AmQfyKdijRKOvwm3OJEXsKlg=;
        b=eUcRz3YT3Z/5g0UKbm3QuiUZ4gaH1ejCuyO81FwGD7PTrCuE4SNQm5ZzhS+YtJ1k6g
         KJqFF6B04hg7YCCjtlzl/5V7IFzi94Einn4+MjeIvP2auWFbkrxENLel5+8E927ETCwz
         FithsSz2lyAmFffcdreIjFcuteS18S6sAH7O5hLo62oQ6aIjUCVKi1TmImOapGVHsotw
         59ynCmvgctOysqR9H2NOtVHeQAATL1zZVoEzEzxZ0hx4wgNG/fHcYWr7fbSWQx9FjQ2D
         2ZQWhwPAsseKPnWNJ+cRJwYaH7mO3ggwrWOBs9mBCRIEE5Es6Hmtc9W//aYLDdLkJ3GA
         w3xQ==
X-Gm-Message-State: AA+aEWYritsoG9hhiB+9/MCBwaJqlhPoSvbIgJctz2GACyJ14sxnhLf/
        4qmGgNNfRTisqTECIjzLiVXNnp9w7YGvkF8O8NE=
X-Google-Smtp-Source: AFSGD/Wby55pQNi6tcE/0ISvmvqBhzPOn+PvbcS3I6bSbkklVrOLaCMeJ6kZCqEs3kbE3W4bc/nnHrlQeo5La3iY614=
X-Received: by 2002:a24:4648:: with SMTP id j69mr693247itb.56.1544730959317;
 Thu, 13 Dec 2018 11:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20181210171318.16998-1-vgoyal@redhat.com> <20181210171318.16998-16-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-16-vgoyal@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Dec 2018 11:55:47 -0800
Message-ID: <CAA9_cmdLvFqG_Us5ZoBopj2ssWzxVbyNqf4XcgmY+=D_gARWDA@mail.gmail.com>
Subject: Re: [PATCH 15/52] fuse: map virtio_fs DAX window BAR
To:     vgoyal@redhat.com
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 9:22 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> Experimental QEMU code introduces an MMIO BAR for mapping portions of
> files in the virtio-fs device.  Map this BAR so that FUSE DAX can access
> file contents from the host page cache.

FUSE DAX sounds terrifying, can you explain a bit more about what this is?

> The DAX window is accessed by the fs/dax.c infrastructure and must have
> struct pages (at least on x86).  Use devm_memremap_pages() to map the
> DAX window PCI BAR and allocate struct page.

PCI BAR space is not cache coherent, what prevents these pages from
being used in paths that would do:

   object = page_address(pfn_to_page(virtio_fs_pfn));

...?
