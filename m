Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B11020989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JtTVm0Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B11020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeKZVW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:22:59 -0500
Received: from m12-15.163.com ([220.181.12.15]:41827 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbeKZVW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ux+U8
        wyUJnkvXwjYrMNcav6pS2oNKzFZtSrs7WkdOFA=; b=JtTVm0TjolTbTmSGG8VHN
        h7vKf5cFivxQvl2KIgpFi0eDQM2gO/svMYz3Ffz2cQHRSaxYKjcBerttX+GwUJ4f
        racV8kM6Q6iG87RxEIYOJCVwFfYkZh3lGQRxLQXeuHZ4MjrOh9aBXEavqvrtVtxu
        SLiyOp/50Rxl/Ot7otRjTk=
Received: from bp (unknown [106.120.213.96])
        by smtp11 (Coremail) with SMTP id D8CowADHSyXYyvtbY+obAA--.923S2;
        Mon, 26 Nov 2018 18:28:41 +0800 (CST)
Date:   Mon, 26 Nov 2018 18:28:41 +0800
From:   PanBian <bianpan2016@163.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: read page index before freeing
Message-ID: <20181126102841.GA94853@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1542884326-74903-1-git-send-email-bianpan2016@163.com>
 <3ebe6814-586e-77e8-52fa-47fb61d760f5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ebe6814-586e-77e8-52fa-47fb61d760f5@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: D8CowADHSyXYyvtbY+obAA--.923S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4rAw13Xr4ftF4ruFWfKrg_yoWxKrc_WF
        WvqrZ7Aw4kJF1fGanxGrW3Xr4FgF45Xw4kCrWrtr4ft3yrJ3yDX3srJw1DXFn7Ww42ya47
        CFn0ya10kwnrujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe_9N7UUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDhkLclXlpmw9vAAAsV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:13:53PM +0800, Chao Yu wrote:
> Hi Pan,
> 
> On 2018/11/22 18:58, Pan Bian wrote:
> > The function truncate_node frees the page with f2fs_put_page. However,
> > the page index is read after that. So, the patch reads the index before
> > freeing the page.
> 
> I notice that you found another use-after-free bug in ext4, out of
> curiosity, I'd like to ask how do you find those bugs? by tool or code review?

I found such bugs by the aid of a tool I wrote recently. I designed a method 
to automatically find paired alloc/free functions. With such functions, I
wrote two checkers, one to check mismatched alloc/free bugs, the other to
check use-after-free and double-free bugs.

Best regards,
Pan Bian

