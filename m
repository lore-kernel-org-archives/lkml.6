Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1369C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 07:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD9A2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 07:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfASHQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 02:16:24 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44424 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfASHQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 02:16:23 -0500
Received: by mail-qt1-f181.google.com with SMTP id n32so17764742qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 23:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=K7muGxWLC+as0Ps/LPlVCpjx56rRCs1E9OCFoQtoAG0=;
        b=FwBIzyV5hodMmtubNsDy8dBwN5K22koD58Ve1EDdd+H978BF2eNWTYkZso7RSfoo9P
         ytzsuhTa8Ol1u+ZCvRWSsMUpRqalaPCSBuwsCuALCPKS5KZc0Pbt/JDydqWT4XHO3phK
         4ZSYXa8Hk+K9xZiedkR61ayQvo7NuPWU/hXr0qvnVUnJnh3L8pXoAVgo8330lUA8XRO1
         WmSu0BHhY0eM5GYCy09gXLfZH7ALDlhX1bWBqXatzyWqsA0NgmnCp5/tbXugsVeZpFs5
         xNKV/7yVcRhvIRre5kqvkC2wXHaKj8SFOJbdjH8s9gH/L0d92OycyjzIouv56yxtq0ar
         UoyQ==
X-Gm-Message-State: AJcUukc3w8RCBAEWRbavRdbnG+I3bN8DpgPIdIcuHBiyeKNwHPgTzXOy
        rnXQqVyL4yt0k2k4cgNaH3S5oeUSHTY=
X-Google-Smtp-Source: ALg8bN4wkcvZnspnQMvoLzQRvYzj80UXVKi+tHB6Isf61QGDMr1QLR/P1bgoukAkBUAPuCQCFUSM5w==
X-Received: by 2002:a0c:d992:: with SMTP id y18mr19075551qvj.161.1547882182936;
        Fri, 18 Jan 2019 23:16:22 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id 20sm66975101qtp.54.2019.01.18.23.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 23:16:22 -0800 (PST)
Date:   Sat, 19 Jan 2019 00:16:21 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Subject: Question about out_unmap section of map_sg in amd_iommu.c
Message-ID: <20190119071621.xh5s3rkqiabgjwo4@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



  out_unmap:
          pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",
                 dev_name(dev), npages);

          for_each_sg(sglist, s, nelems, i) {
                  int j, pages = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);

                  for (j = 0; j < pages; ++j) {
                          unsigned long bus_addr;

                          bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
                          iommu_unmap_page(domain, bus_addr, PAGE_SIZE);

                          if (--mapped_pages)
                                  goto out_free_iova;

Is this condition correct?  My thought is this was meant to break out of the loop early if
all the mapped pages have been unmapped. So if (--mapped == 0) instead?

                  }
          }
