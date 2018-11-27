Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD4AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587A421104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Js77HRNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587A421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeK0LS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:18:57 -0500
Received: from m12-13.163.com ([220.181.12.13]:60905 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbeK0LS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=KB7KA
        YOGK0Ogit6Tq1AlE/dSKtlFSJeHLgNt3K5EFKM=; b=Js77HRNsjmGUu0itxDiGf
        hJx1mFuDKwZSCttFJOLpUDdAw3Oj5aXH3UtihAr4LRMh77v1305bouq0tupSbZMY
        qcK5eRNQrDhd7xaiq0dGDxYyTQZOvlcwEd1CmVwcF8XNiEuvFe8DAJw8JwraRtqX
        hH/dx5PVIdxscT9XQyEzlE=
Received: from bp (unknown [106.120.213.96])
        by smtp9 (Coremail) with SMTP id DcCowABHExVWjvxbbRf5Bw--.10268S2;
        Tue, 27 Nov 2018 08:22:47 +0800 (CST)
Date:   Tue, 27 Nov 2018 08:22:47 +0800
From:   PanBian <bianpan2016@163.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: read page index before freeing
Message-ID: <20181127002247.GA109273@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
 <3ebe6814-586e-77e8-52fa-47fb61d760f5@huawei.com>
 <20181126102841.GA94853@bp>
 <f8957864-fd65-6c45-de07-9e94459bed52@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8957864-fd65-6c45-de07-9e94459bed52@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: DcCowABHExVWjvxbbRf5Bw--.10268S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1DXw4kur17XrWDXFW7CFg_yoWkArg_Wa
        y0vrs7Aws8JF1fGanxtrW3GFZ5W3WUXw1rC3yFqrs3t3sxJ395X39rWwn5XFn7Jw4qyF43
        Crn0va1a9rnFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeGNt7UUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZxwLcletsIu-MgACsM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:07:08PM +0800, Chao Yu wrote:
> On 2018/11/26 18:28, PanBian wrote:
> > On Mon, Nov 26, 2018 at 05:13:53PM +0800, Chao Yu wrote:
> >> Hi Pan,
> >>
> >> On 2018/11/22 18:58, Pan Bian wrote:
> >>> The function truncate_node frees the page with f2fs_put_page. However,
> >>> the page index is read after that. So, the patch reads the index before
> >>> freeing the page.
> >>
> >> I notice that you found another use-after-free bug in ext4, out of
> >> curiosity, I'd like to ask how do you find those bugs? by tool or code review?
> > 
> > I found such bugs by the aid of a tool I wrote recently. I designed a method 
> > to automatically find paired alloc/free functions. With such functions, I
> > wrote two checkers, one to check mismatched alloc/free bugs, the other to
> > check use-after-free and double-free bugs.
> 
> Excellent! Do you have any plan to open its source or announce it w/ binary
> to linux kernel developers, I think w/ it we can help to improve kernel's
> code quality efficiently.

Yes. I am now writing a paper about the method. I will open the source code
as soon as I complete the paper and some optimizations.

Best,
Pan

