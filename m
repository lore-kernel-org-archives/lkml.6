Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F902C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456FB20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FcUEBftW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456FB20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIDGhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:37:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeIDGhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SwYoOGTJwPltXecgxvvFyCWLNUO+6wrT3VFzYnirq90=; b=FcUEBftWkg8yZudRxA/nXSTAi
        sq6mmY/0m8yA+p6ym4U3wJ24RQRzQhZBNpD2bBVAIYXkH8z7WHuQfNxgIOVxhzyqAW7asvEY258iJ
        uI0gFe8A0U9rXLY5pFt7xMiSZ4MBCprbTNnSkIA2mLirT9k8S91at0XgWSA5O3tjtNaP5JkkVc1np
        PkTP2PqX39TutDJod9r94SN5DeDXg94lDmm3uhWYYNvtyaW7WRN0YbUpqOQozTM4FgI7RrT7GCsTU
        gREakDcDgplU/NdrQbXfxVa4JsEyFstTnF/X97JmCL3gOU1Y+1poqauBDrrZf27OWwc5ASA5W8ubU
        slktM+RwA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fx0qp-0001OF-Qv; Tue, 04 Sep 2018 02:13:55 +0000
Date:   Mon, 3 Sep 2018 19:13:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Subject: Re: [PATCH v2] fs: Convert return type int to vm_fault_t
Message-ID: <20180904021355.GA17153@bombadil.infradead.org>
References: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
 <20180830163352.5a96cc721ce069bed95fdbe8@linux-foundation.org>
 <CAFqt6zZckYhLJuJr9TSw2KOZrt6qD25xDctuvbKfm0jyBoPycA@mail.gmail.com>
 <20180903172843.9bf312c738ce8a434dd9c242@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903172843.9bf312c738ce8a434dd9c242@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 05:28:43PM -0700, Andrew Morton wrote:
> > > I'm beginning to feel vm_fault_t exhaustion.  Please remind me what
> > > benefit we're going to get out of all this churn?

Hi Andrew,

The primary benefit is to help driver writers.  At the moment, there
is nothing to stop them returning -ENOMEM instead of VM_FAULT_NOMEM.
There were one or two examples of this in the tree, but I think they're
all gone now.

Secondarily, there are a number of places which translate between error
codes and vm_fault codes.  Those places are reduced as a result of these
patches, if not entirely eliminated yet.  There was some pretty extreme
cargo-culting of errno to vm_fault switch statements, particularly in
the DRM drivers.

There were also several places which were just ignoring the return value
of vm_insert_foo(), and as a result of this audit, those have been fixed.
Those errors are going to be rare, but can cause inappropriate decisions
to be made by the OOM killer.

Now that I think about it, vmf_insert_foo() should probably get marked
with __must_check to prevent those kinds of errors from being introduced
again.
