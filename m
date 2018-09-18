Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5AFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9ED2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9ED2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeIRRqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:46:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58542 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeIRRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:46:36 -0400
Received: from localhost (unknown [147.67.4.98])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 28651CEA;
        Tue, 18 Sep 2018 12:14:15 +0000 (UTC)
Date:   Tue, 18 Sep 2018 14:14:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 0/8] staging: erofs: error handing and more tracepoints
Message-ID: <20180918121413.GA499@kroah.com>
References: <1536936030-62362-1-git-send-email-gaoxiang25@huawei.com>
 <20180918111953.GA3585@kroah.com>
 <aab26d0e-f8dc-cc83-46eb-7a93a833eaae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aab26d0e-f8dc-cc83-46eb-7a93a833eaae@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 08:02:30PM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2018/9/18 19:19, Greg Kroah-Hartman wrote:
> > On Fri, Sep 14, 2018 at 10:40:22PM +0800, Gao Xiang wrote:
> >> In order to avoid conflicts with cleanup patches, Chao and I think
> >> it is better to send reviewed preview patches in the erofs mailing list
> >> to the community in time.
> >>
> >> So here is reviewed & tested patches right now, which clean up and
> >> enhance the error handing and add some tracepoints for decompression.
> >>
> >> Note that in this patchset, bare use of 'unsigned' and NULL comparison are
> >> also fixed compared with the preview patches according to the previous
> >> discussion in the staging mailing list.
> > 
> > I applied this, but I need to go delete it as this patch series adds a
> > build warning to the system:
> > 
> > In file included from drivers/staging/erofs/unzip_vle.h:16:0,
> >                  from drivers/staging/erofs/unzip_vle.c:13:
> > drivers/staging/erofs/unzip_vle.c: In function ‘z_erofs_map_blocks_iter’:
> > drivers/staging/erofs/internal.h:303:34: warning: ‘pblk’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> >  #define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
> >                                   ^
> > drivers/staging/erofs/unzip_vle.c:1574:20: note: ‘pblk’ was declared here
> >   erofs_blk_t mblk, pblk;
> >                     ^~~~
> > 
> > Please fix that up and resend.
> 
> strange... my compiler (4.8.4) and huawei internal CI don't report that,
> and this patchset has been in Chao's tree for a while, I don't get any report so far...
> 
> I just looked into that code again and it seems a false warning since
> 1) this code is heavily running on the products and working fine till now.
> 2) pblk gets a proper value before unzip_vle.c:1690 map->m_pa = blknr_to_addr(pblk);
> 
> so I think I need to silence this warning for now and check if there is a really issue....

Don't just silent the warning.  Usually gcc now properly detects where
there really is a problem, it should not be a false-positive.  And in
looking at the code, it does seem that pblk could not be set if one of
the different case statements is taken and then exact_hitted: is jumped
to, right?

Or is gcc just being "dumb" here?  What about clang, have you tried
building it with that compiler as well?

thanks,

greg k-h
