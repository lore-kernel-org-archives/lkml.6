Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0A575C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40EA208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C4VcTKfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40EA208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935918AbeFMOo2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:44:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935659AbeFMOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gytpz5v+1VuiNmO3PtrD+QFBfJEzK8sXBUI1oTl8xs4=; b=C4VcTKfRKagLNAq0hXQg/84jj
        4bSTMHluCufWMx6ohJ+G6zovGa10iGez/2AMiTW2zyUYfmxDmZAt/AEwh8ZG7756mSeESd0v/kDHp
        0nVgYN9pQvPs/D/iGDQoWQzGHLsHaly9JsBWox0BS/2nd0Usu1TS0Hnl8T45nmFs9QUuscP+XDNYr
        nCEZY3hD/EOAgc5gdy4QburdnRvgIuYGypEeO4nA2pKhdUDAji3L4WRG1TejiimdUGc8SB83foM5+
        WU+rAYrc46EBh0JAanBawsX7MTJJJQZvluogdYszno78iuawE8l/XkMURq8YFOXD5USyaaPOGinF6
        wWz3XbRyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT70O-0007It-HQ; Wed, 13 Jun 2018 14:44:12 +0000
Date:   Wed, 13 Jun 2018 07:44:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 11/30] block: implement bio_pages_all() via
 bio_for_each_segment_all()
Message-ID: <20180613144412.GB4693@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-12-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609123014.8861-12-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that we have a single, dubious user of bio_pages_all I'd rather
see it as an opencoded bio_for_each_ loop in the caller.
