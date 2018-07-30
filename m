Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8547D160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3371D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/w3N8gP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3371D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeG3RSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:18:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeG3RSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8ztXLKv92fsz0q9bH9yPXuFZkcAoDO8YjzcW5OHSQ7Q=; b=M/w3N8gPwliXBoWPP04QB/4Jt
        Qf87XyVvU4wA0rTst0sRF107BVv8cVZXhuOCcO1P5j70dLspEcaUilosl85LbxGFcnETX07g8LM1l
        HdLcQoZX3Xf6wtBfjmfUMqMJkCqmvd1P/Tclx/++F7FNeWY6MqlYE+fVjOvhbQ2f0e7GqeTwXoi6c
        he0KXjtoLtg3DjnhLq/e7rwiK+rbr+Ov8ZUdA+HFiRVXTfmSos8uT5ajOqGOlpaJyAtTSncTKUP0R
        GicvvY1Wc/bGeF1LBnCi8nzw+k9uOZT7IU5tsDjiwfjCm3NS5nX98LQLnguxsYuhWuXeaXF02Lu9F
        V8xdCVMfw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkAKE-0005Wl-Pd; Mon, 30 Jul 2018 15:43:10 +0000
Date:   Mon, 30 Jul 2018 08:43:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ross Zwisler <ross.zwisler@linux.intel.com>, zwisler@kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v14 00/74] Convert page cache to XArray
Message-ID: <20180730154310.GA4685@bombadil.infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
 <20180619031257.GA12527@linux.intel.com>
 <20180619092230.GA1438@bombadil.infradead.org>
 <20180619164037.GA6679@linux.intel.com>
 <20180619171638.GE1438@bombadil.infradead.org>
 <20180627110529.GA19606@bombadil.infradead.org>
 <20180627194438.GA20774@linux.intel.com>
 <20180725210323.GB1366@bombadil.infradead.org>
 <20180727172035.GA13586@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727172035.GA13586@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:20:35AM -0600, Ross Zwisler wrote:
> Okay, the next failure I'm hitting is with DAX + XFS + generic/344.  It
> doesn't happen every time, but I can usually recreate it within 10 iterations
> of the test.  Here's the failure:

Thanks.  I've made some progress with this; the WARNing is coming from
a vm_insert_* mkwrite call.  Inserting sufficient debugging code has
let me determine we still have a zero_pfn in the page table when we're
trying to insert a new PFN.
