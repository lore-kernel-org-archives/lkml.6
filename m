Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7CC43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D64218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546634167;
	bh=JKx3cZD1oZYappQUp47+Xy5vkaB31SxGgskwAGCBHX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rFOVj+Tkg6omJhvga0J7DnM3RmOZabloMn7efvRCv/wwM2dAsIysRK0EMZak/CMUh
	 Jp9zXI6/y5XSUo08rItgqGLFV++4AGhxsnrNK0boVi1bkLDqhVVBOMPuKSwMT3RONk
	 COLKS72cN5ZUk6dq8xIi96mFOIrEpEBlV+g9SIAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfADUgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:36:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfADUgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:36:05 -0500
Received: from localhost (unknown [104.132.1.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33776218D3;
        Fri,  4 Jan 2019 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546634165;
        bh=JKx3cZD1oZYappQUp47+Xy5vkaB31SxGgskwAGCBHX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=11UqKqZawsTWTxk3xN49tBeJXkunuRY5RsBOewIyEqoRHmwtutI1tCutZsrwF4dls
         tHz89j/xAWjjLU1vhOjx/OI/i6OvjKGT25Yw2OIiwCCy74kUDqjjGxSnxBJpBCtSHx
         QeOfcP1R6QvEMnWcymDmenMqotMUNyFEqa9K4lXs=
Date:   Fri, 4 Jan 2019 12:36:04 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: wait on atomic writes to count
 F2FS_CP_WB_DATA
Message-ID: <20190104203604.GC57873@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190104042025.31982-1-jaegeuk@kernel.org>
 <3e50bcd6-1730-c28d-2d28-7a8e57f456cf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e50bcd6-1730-c28d-2d28-7a8e57f456cf@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04, Chao Yu wrote:
> On 2019/1/4 12:20, Jaegeuk Kim wrote:
> > Otherwise, we can get wrong counts incurring checkpoint hang.
> > 
> > IO_W (CP:  -24, Data:   24, Flush: (   0    0    1), Discard: (   0    0))
> > 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Good catch! ;)
> 
> I can understand this condition, but for other new developer who reads this
> commit, it will be a little hard to understand situation here.
> 
> How about explaining a little more about problem here, maybe:
> 
> Thread A			Thread B		
> - f2fs_write_data_pages
>  -  __write_data_page
>   - f2fs_submit_page_write
>    - inc_page_count(F2FS_WB_DATA)
>      type is F2FS_WB_DATA due to file is non-atomic one
> - f2fs_ioc_start_atomic_write
>  - set_inode_flag(FI_ATOMIC_FILE)
> 				- f2fs_write_end_io
> 				 - dec_page_count(F2FS_WB_CP_DATA)
> 				   type is F2FS_WB_DATA due to file becomes
> 				   atomic one
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks, added the comment. :P

> 
> Thanks,
> 
