Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D5C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243FB21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DmapE2TU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243FB21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbeJFIR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 04:17:27 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39337 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJFIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 04:17:27 -0400
Received: by mail-pf1-f174.google.com with SMTP id c25-v6so5507733pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 18:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kkkU9e6NPdzWlq+30NnrBK3elbGcUFsjA5IRWacg35w=;
        b=DmapE2TUzmc3Z6DEB7tymyPxhkSegI3cgbwecwz9zh9u9wlyli32femmPWMl+EGTHy
         Ifihsl9HZIXk7n062XWCRPIdD8TWOXtOCVFPgHymyvNIZMZwepYq9Q6gxHDvl65MNtmw
         RzRCvfwG5iEbSh97ZIvC0rmMyEca1IqeJyY8t4TSj/cXlZPSQz2TLIgEv7QLZHyd0hS3
         wkch7jwq+8an0TjOLu8H21e6WJf+wDEItrrJ7iOo5O9+E1Hvfl/5oUaTKC5cjyyVeV7X
         aTd6EkBN0z6UVWCn5VYESmp6JOtxogNtRgyHVwPf3ZiEDsvUw4xtNHA14u5eiHIy9MLM
         eAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kkkU9e6NPdzWlq+30NnrBK3elbGcUFsjA5IRWacg35w=;
        b=FtU5za7t7gVTAj4KmidX27ExQMEXuUiqWNsedLT4d+RY1jivtOrdxwptaD/caQw0A2
         mMWvCpjta0AV7nraS4/wpfnSUv/py089YVgCS6n8HSmbUdfUTLJH9CHi5tnfug36gmCK
         sW7KKeH917pt1o4JlrsAmrMD9tDinHdCegycijwY3XlGEgUMDlfLNKIUMflOoPaxQjPK
         aQOE/Zq3xL3s+Cwg8buTkNrJ3ssZYyeFV9v5rEy9Eoxqf+Q///BjFPtUKS8h0Pc7VZHZ
         cOcA3UF6DvFV+AQ4JjtvPJmOQ7V6bN33Vqiyh9ijnA3xtP6BuoobkhzyVkaiDJ0g+DsZ
         LH5A==
X-Gm-Message-State: ABuFfogsavQJWwsN6UNUUocjm+HNy96/vb9EEJFNbP3wnnGrbUrTvMbj
        g7hJdieeJWY8pWks990CqMdDWUk8mRQ=
X-Google-Smtp-Source: ACcGV63r0ikAEGMOAxu5X0gW1kEShgGiPHOZoICu2OViKvWK0OP+2t8c87y/LwDoXW1ek+7KBeRV/w==
X-Received: by 2002:a62:ccd4:: with SMTP id j81-v6mr14800582pfk.76.1538788568829;
        Fri, 05 Oct 2018 18:16:08 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id z70-v6sm11859792pgd.64.2018.10.05.18.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 18:16:07 -0700 (PDT)
Subject: Re: [PATCH v9 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-8-logang@deltatee.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <485de371-0e84-6f20-7f3b-cec5635b87fe@kernel.dk>
Date:   Fri, 5 Oct 2018 19:16:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181004212747.6301-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/18 3:27 PM, Logan Gunthorpe wrote:
> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> supports targeting P2P memory. This will be used by P2P providers and
> orchestrators (in subsequent patches) to ensure block devices can
> support P2P memory before submitting P2P backed pages to submit_bio().

Nit pick, but the subject line still says that it checks support
for requests. This patch just adds the ability to flag support
in the queue.

-- 
Jens Axboe

