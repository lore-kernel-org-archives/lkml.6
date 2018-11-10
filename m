Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C911AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E122081C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 07:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cb7ayRu7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E122081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeKJRZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 12:25:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbeKJRZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 12:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4t4fadnUuCptBN3q9MzFSAV2OikdFBZAaVlCPOzhBes=; b=Cb7ayRu7v6bWdML9g4uCTbkaZ
        Xbh3+7JOtB9KvqM1H+bKuC6wP74Ny+oNMSO6nq9py91BuGivMR0VDqSht8L4CYxd9fKRs8IMTxRV1
        ARUgs4LhWCsOLJI94dWGPy838nh3p383hhpEWoCXdR8NLzEObEbk88PMJF/yqpTsc9U/uuk+fEPGm
        L6U+9/1mpngs/KaHKMkt43njGHEOOUje/Y7o4SiK5DHYo1THU7HDPjGvgp3DxTObQO/z53Ym5crUp
        kyzezI5Ray0ehwSKV94sH0VxR8MOn+2m6idXUnuPAIA23A1svkYOg1Mi0ahn+rUlPfrP7skbn3LFF
        QSwQ/D/Jg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLNtW-0000gH-20; Sat, 10 Nov 2018 07:41:26 +0000
Date:   Fri, 9 Nov 2018 23:41:25 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH v11 2/3] ipc: Conserve sequence numbers in ipcmni_extend
 mode
Message-ID: <20181110074125.GB21824@bombadil.infradead.org>
References: <1541794292-19425-1-git-send-email-longman@redhat.com>
 <1541794292-19425-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541794292-19425-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 03:11:31PM -0500, Waiman Long wrote:
> The mixing in of a sequence number into the IPC IDs is probably to
> avoid ID reuse in userspace as much as possible. With ipcmni_extend
> mode, the number of usable sequence numbers is greatly reduced leading
> to higher chance of ID reuse.
> 
> To address this issue, we need to conserve the sequence number space
> as much as possible. Right now, the sequence number is incremented
> for every new ID created. In reality, we only need to increment the
> sequence number when one or more IDs have been removed previously to
> make sure that those IDs will not be reused when a new one is built.
> This is being done irrespective of the ipcmni mode.

That's not what I said.  Increment the sequence ID when the cursor wraps,
not when there's been a deletion.
