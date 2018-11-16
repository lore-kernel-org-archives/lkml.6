Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4B3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEF4208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jzwp6Ain"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEF4208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389521AbeKPT7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:59:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeKPT7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FCzFxK9vog88Lm15soontLLK/k/+aS7WRTtxaf0OzZE=; b=Jzwp6AinINy6996LVllszl3ZO
        oCSMPYg7o0DIeNe5nbNYZ/WG51pAaIY2ZkpG0eFSgVtHxBVY2R+0ydSG2+JpaRcGXwdMcrvAr27ao
        Whln3/Q4quyXVOGISY2eOpEpayOLTZldY9Vb0J9JHwT9WWNRwhtDAF4KfzuBLC8We4YGQH5qsf3qo
        4iXbf2JqCpLQ2fQOMdr/taUyIPjzZmc3tOg0ZkvJHoR356fTq2yOJ5BaB+pc3lQHj8r9EMyDF1i45
        v72kTQeQxjNH6OpSBFI2L5CSWCYQJYJWX/U6nE22RLFQ0bTqhOy5tqFyjfrp8c/RfmCTNt+vDwdTS
        qa7oVf+Lg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNajS-0006GO-AT; Fri, 16 Nov 2018 09:48:10 +0000
Date:   Fri, 16 Nov 2018 01:48:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
Message-ID: <20181116094810.GA23053@infradead.org>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181111131445.GB25441@infradead.org>
 <20181111134241.GA2447@thunk.org>
 <20181112082013.GA9307@infradead.org>
 <79d7d4b2-e9b3-00b4-2ad0-789888f7ee36@redhat.com>
 <20181116093225.GA17033@infradead.org>
 <fa3ed175-13a3-bedf-ebf9-ddf46a2decd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3ed175-13a3-bedf-ebf9-ddf46a2decd5@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 10:45:11AM +0100, Paolo Bonzini wrote:
> Yeah, but looking at the command is what Ted wants.  The thing that we
> did in RHEL was a single sysfs bool that allows unfiltered access,
> because it was sort of enough and made the delta very small.  But for
> upstream I want to do it right, even if that means learning all that
> new-fangled BPF stuff. :)

So what is this magic command?

> I would even agree, however it's allowed right now and I would be
> surprised if no one was relying on it in good faith ("I'm just doing an
> INQUIRY, why do I need to open O_RDWR").  And indeed:
> 
> $ sudo chmod a+r /dev/sda
> $ strace -e openat sg_inq /dev/sda
> openat(AT_FDCWD, "/dev/sda", O_RDONLY|O_NONBLOCK) = 3

Well, not if we only did that for unprivileged opens.
