Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C191FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9F82250D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9F82250D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeGBGYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:24:38 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25307 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeGBGYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:24:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=date:from:reply-to:to:cc:message-id:in-reply-to:references:subject:mime-version:content-type:user-agent; 
  b=pdG7D4setLlbcpm+n1LjzUs57WjM5f/OURfWcK/eLCVHzUkfPNrWX3MCIFbHIyJPyvT28zTlXpa0
    wznWYXHkMpMI8Jh5aCUNL8hQjBpzDA7dsuGpiKZulYyz1ZmU6dA1  
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1530512622384862.6200589557761; Sun, 1 Jul 2018 23:23:42 -0700 (PDT)
Received: from  [111.205.43.250] by mail.zoho.com
        with HTTP;Sun, 1 Jul 2018 23:23:42 -0700 (PDT)
Date:   Mon, 02 Jul 2018 14:23:42 +0800
From:   Huaisheng Ye <yehs2007@zoho.com>
Reply-To: yehs2007@zoho.com
To:     "\"Al Viro\"" <viro@ZenIV.linux.org.uk>
Cc:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <willy@infradead.org>, <ross.zwisler@linux.intel.com>,
        <vishal.l.verma@intel.com>, <jack@suse.com>, <chengnt@lenovo.com>,
        <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, "\"Huaisheng Ye\"" <yehs1@lenovo.com>
Message-ID: <16459a9432e.10c419704327.5268154349116077352@zoho.com>
In-Reply-To: <20180701192600.GT30522@ZenIV.linux.org.uk>
References: <20180701061848.7036-1-yehs2007@zoho.com>
 <20180701061848.7036-2-yehs2007@zoho.com> <20180701192600.GT30522@ZenIV.linux.org.uk>
Subject: Re: [PATCH 2/3] fs/ext2/inode: Fix a type cast error for fsdax
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 ---- On Mon, 02 Jul 2018 03:26:00 +0800 Al Viro <viro@ZenIV.linux.org.uk> wrote ---- 
 > On Sun, Jul 01, 2018 at 02:18:47PM +0800, Huaisheng Ye wrote: 
 > > From: Huaisheng Ye <yehs1@lenovo.com> 
 > >  
 > > The type of offset within struct iomap is loff_t, which represents 
 > > file offset of mapping. 
 > >  
 > > In ext2_iomap_begin, iomap->offset shall be given a type cast as 
 > > loff_t instead of u64. 
 >  
 > Why is it an error?  loff_t is uniformly typedefed to long long. 
 > In which case the second variant is different from the first one 
 > *and* does not step into nasal demon territory?

Sorry for my inaccuracy.
The type of iomap->offset is loff_t, is it better to cast first_block
to loff_t, then do the left shift operation?
 
 >  
 > > -    iomap->offset = (u64)first_block << blkbits; 
 > > +    iomap->offset = (loff_t)first_block << blkbits; 
 > 

---
Cheers,
Huaisheng

