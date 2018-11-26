Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90878C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419CC2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S3VmWlKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419CC2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeKZVaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:30:15 -0500
Received: from m12-17.163.com ([220.181.12.17]:43797 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbeKZVaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=/lgGf
        ku1gWV1fcLw4wfxQkxc6DWHs5mkrsP+geSG0gU=; b=S3VmWlKco/m+z2ZOAc3uN
        HjTfSm/+FJRaGqZOMGv2adUlOA9MdCrJRAwWdjzIJaowyy+GE7o2q+1U0CruzcLO
        k9ntSOvSSCyzIo0T/jF0t4ra8O/ct0ZM42eKQATsq1kAq7bPGjbx6w50oqqeteL8
        AraC4DjeMKkluhBJLjb3gI=
Received: from bp (unknown [106.120.213.96])
        by smtp13 (Coremail) with SMTP id EcCowABnbo6izPtb_mTHBg--.38780S2;
        Mon, 26 Nov 2018 18:36:18 +0800 (CST)
Date:   Mon, 26 Nov 2018 18:36:19 +0800
From:   PanBian <bianpan2016@163.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: libxfs: move xfs_perag_put late
Message-ID: <20181126103619.GA95394@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1543052660-58625-1-git-send-email-bianpan2016@163.com>
 <20181126093139.cgojlmtubzuzdb23@hades.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126093139.cgojlmtubzuzdb23@hades.usersys.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: EcCowABnbo6izPtb_mTHBg--.38780S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1xXF45KrWkZry5Cw1kAFb_yoW3KrXEgr
        W2qrZ7Cw4vgr4SgF47Wr43XF45KF4UGw48Wr93XFWS934UJw4rC397Grn5Zwn5XrZrtr45
        uws8WaykJa429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnWlk3UUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQMLclaD0UQEogAAsN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:31:39AM +0100, Carlos Maiolino wrote:
> On Sat, Nov 24, 2018 at 05:44:20PM +0800, Pan Bian wrote:
> > The function xfs_alloc_get_freelist calls xfs_perag_put to drop the
> > reference. In this case, pag may be released. However,
> > pag->pagf_btreeblks is read and write after the put operation. This may
> > result in a use-after-free bug. This patch moves the put operation late.
> > 
> 
> The patch looks reasonable, can you detail more how did you find it? Via code
> inspection of you hit this user-after-free in some way?

I wrote a tool to check such bugs statically. It first scans the source code 
to extract paired alloc/free functions. Equipped with such functions, it
performs an intra-procedural data flow analysis to detect mismatched
alloc/free bugs and use-after-free bugs.

Best regards,
Pan Bian

