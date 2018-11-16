Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC7FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95861208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j4CO4YKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95861208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbeKPToA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:44:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeKPTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gTOHMOgDgIt+FDacDVfbF70kBQv2VWQ17SzLI5mmeHY=; b=j4CO4YKje4Xy1/kL18npqk+HK
        Z6AqzNINVVv5T5z6nX/BU0nD6aT3V3RhEJrlWMU0UtXWvNtQ758DQ8OVOWF8oIdKIVCe/9EqRsmOj
        RTWOzY+t+X4OkNQv+Z0M11oCF9cIx78oHT5XV4NsJHYP3XCsLiCOvmDa2L+ppT74Qqg/DpZA+S0SM
        kQmXR3vkQwkhzInM6gm0NCKZwkjjGp87T9j9HPMc1MFz6h7xXE+nRWISdSe7nFmOKDR+yqwpqFRUm
        t9JG6HZmolbE/wdPuPQi/cg9bY7WX3zxytwNi0fyYWFUUtY/RLQhHa2n8/jb02znyk/NW1cLTQYp+
        0wOZB2huw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNaUD-0008Gy-FI; Fri, 16 Nov 2018 09:32:25 +0000
Date:   Fri, 16 Nov 2018 01:32:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
Message-ID: <20181116093225.GA17033@infradead.org>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181111131445.GB25441@infradead.org>
 <20181111134241.GA2447@thunk.org>
 <20181112082013.GA9307@infradead.org>
 <79d7d4b2-e9b3-00b4-2ad0-789888f7ee36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d7d4b2-e9b3-00b4-2ad0-789888f7ee36@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:17:29AM +0100, Paolo Bonzini wrote:
> > Well, that's what we have the security_file_ioctl() LSM hook for so that
> > your security model can arbitrate access to ioctls.
> 
> Doesn't that have TOC-TOU races by design?

If you want to look at the command - yes.  If you just want to filter
read vs write vs ioctl, no.

> Also, what about SG_IO giving write access to files that are only opened
> read-only (and only have read permissions)?

Allowing SG_IO on read-only permissions sounds like a reall bad idea,
filtering or not.
