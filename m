Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EA6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C4F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfARLfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:35:45 -0500
Received: from verein.lst.de ([213.95.11.211]:43011 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfARLfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:35:44 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7B0DF68CEB; Fri, 18 Jan 2019 12:35:43 +0100 (CET)
Date:   Fri, 18 Jan 2019 12:35:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Corentin Labbe <clabbe@baylibre.com>, hch@lst.de,
        m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, joro@8bytes.org
Subject: Re: [PATCH] dma-debug: add dumping facility via debugfs
Message-ID: <20190118113543.GA9481@lst.de>
References: <1547646265-9414-1-git-send-email-clabbe@baylibre.com> <2f43688f-9c08-a9c4-6175-caa3d2e40261@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f43688f-9c08-a9c4-6175-caa3d2e40261@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:10:13PM +0000, Robin Murphy wrote:
> It's a shame that this is pretty much a duplication of 
> debug_dma_dump_mappings(), but there seems no straightforward way to define 
> one in terms of the other :/

We could always play some macro magic, but I think that is worse than
duplicating a little bit of functionality.

Btw, the dev argument to debug_dma_dump_mappings is always NULL and
could be removed..

> (although given that we'd rather not have that weird external interface 
> anyway, maybe "now you can use debugfs instead" might be justification 
> enough for cleaning it up...)

One argument against that is the system might be in a shape where you
can't easily read a file when it is in that shape.  The argument for
that is that in many systems the full list of mappings might overwhelm
the kernel log.

Adding Joerg, who originally wrote the code in case he has an opinion.

>
>> +
>> +static int dump_open(struct inode *inode, struct file *file)
>> +{
>> +	return single_open(file, dump_read, inode->i_private);
>> +}
>> +
>> +static const struct file_operations dump_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = dump_open,
>> +	.read = seq_read,
>> +	.llseek = seq_lseek,
>> +	.release = single_release,
>> +};
>> +
>
> DEFINE_SHOW_ATTRIBUTE()?
>
> Robin.
>
>>   static int dma_debug_fs_init(void)
>>   {
>>   	dma_debug_dent = debugfs_create_dir("dma-api", NULL);
>> @@ -894,6 +936,11 @@ static int dma_debug_fs_init(void)
>>   	if (!filter_dent)
>>   		goto out_err;
>>   +	dump_dent = debugfs_create_file("dump", 0444,
>> +					dma_debug_dent, NULL, &dump_fops);
>> +	if (!dump_dent)
>> +		goto out_err;
>> +
>>   	return 0;
>>     out_err:
>>
---end quoted text---
