Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773BBC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C73256AB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C73256AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeGAT3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 15:29:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60940 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeGAT3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 15:29:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fZhyy-0008PD-Vj; Sun, 01 Jul 2018 19:26:01 +0000
Date:   Sun, 1 Jul 2018 20:26:00 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        willy@infradead.org, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, jack@suse.com, chengnt@lenovo.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH 2/3] fs/ext2/inode: Fix a type cast error for fsdax
Message-ID: <20180701192600.GT30522@ZenIV.linux.org.uk>
References: <20180701061848.7036-1-yehs2007@zoho.com>
 <20180701061848.7036-2-yehs2007@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701061848.7036-2-yehs2007@zoho.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 02:18:47PM +0800, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> The type of offset within struct iomap is loff_t, which represents
> file offset of mapping.
> 
> In ext2_iomap_begin, iomap->offset shall be given a type cast as
> loff_t instead of u64.

Why is it an error?  loff_t is uniformly typedefed to long long.
In which case the second variant is different from the first one
*and* does not step into nasal demon territory?

> -	iomap->offset = (u64)first_block << blkbits;
> +	iomap->offset = (loff_t)first_block << blkbits;
