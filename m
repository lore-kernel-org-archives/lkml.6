Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBCFC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC91C20836
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NDtkyT27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC91C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeIEB3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:29:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49494 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeIEB3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SqTaK0f+gPcLglrLxtx08/OQOZukSmXCToV/jY2maik=; b=NDtkyT27IBvTjW0MQLQByTyIe
        2v8+nVFjVGXqKB97SfemFixBc2lJa2d/0VlS9cZDBpt/waONewN+Z/1V+61uDgA3wWIxxcybcafU1
        VN8N0sTcLuTb+EKs11ceOeMZmNMAQ4GQfBcoy9zgNDXM2uZ/fWXIRu4nMkgtF8+s2zT+8S62/Q7qD
        U/GHIuyuxSc/n8/qV0ZIqkhNeeDqKh6RDaJ187aWKbmTPtNYJeOeiMeg3jCReb20ZKQ7r9bVcPg5x
        rZaFk7kFmmoq3fep1XZNZlMz1Nx+oiRe1LNzbDhduRGP9kRsSRisAzGz9PjHqwFDJF2M6He1/gswR
        ezDobFBYQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxIT7-0004vr-H7; Tue, 04 Sep 2018 21:02:37 +0000
Date:   Tue, 4 Sep 2018 14:02:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180904210237.GA12303@bombadil.infradead.org>
References: <20180904075347.GH11854@BitWizard.nl>
 <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180904161203.GD17478@fieldses.org>
 <20180904162348.GN17123@BitWizard.nl>
 <20180904185411.GA22166@fieldses.org>
 <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
 <20180904203534.yumaest6v5p6izln@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904203534.yumaest6v5p6izln@shells.gnugeneration.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 01:35:34PM -0700, Vito Caputo wrote:
> Implement a new class of swap space for backing dirty pages which fail
> to write back.  Pages in this space survive reboots, essentially backing
> the implicit commitment POSIX establishes in the face of asynchronous
> writeback errors.  Rather than evicting these pages as clean, they are
> swapped out to the persistent swap.

You not only need to track which index within a file this swapped page
belongs to but also which file.  And that starts to get tricky.  It may
or may not have a name; it may or may not have a persistent inode number;
it may or may not have a persistent fhandle.  If it's on network storage,
it may have been modified by another machine.  If it's on removable
storage, it may have been modified by another machine.

