Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0CBECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F232151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oQCkdoiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F232151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeJQRqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:46:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60028 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeJQRqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vrlzfuBdGYThbkt5/Dl0UF+Kh8QDAIWULWWa5+4RWMs=; b=oQCkdoiCCct0VLXVGE2dZoTlB
        BEyUtwVATal6prOLgWk6bvg3ESpkbSnjeC/xdu3bwylsTXofrT1JfblaFi6yTjn+c05dA9046X+bR
        8XCtflxOLEZYK0IJxTR9EP3sY6euwvm52iL+oXzdTqSZCyw+V0mU7cfAThZ+z8Ek7ebvQYlNlWwRH
        RPVE3qsMlzKRN0E0mSH/LClkbC5jben2L//OMucrLjaxfN/MFGUtiK1pfiSabaIqr0qQKBENubVvL
        EWeA0amZjfTGwCZQudI5SwRfeIi19+r8fVCoFoVkFz4g3g3AKPkbQ4NeRManRDtMi7RZc/VUm2g65
        YPX291IQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCiUd-0001zQ-Bf; Wed, 17 Oct 2018 09:51:55 +0000
Date:   Wed, 17 Oct 2018 02:51:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        jreck@google.com, john.stultz@linaro.org, tkjos@google.com,
        gregkh@linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>, dancol@google.com,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        minchan@google.com, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 1/2] mm: Add an F_SEAL_FS_WRITE seal to memfd
Message-ID: <20181017095155.GA354@infradead.org>
References: <20181009222042.9781-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009222042.9781-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:20:41PM -0700, Joel Fernandes (Google) wrote:
> One of the main usecases Android has is the ability to create a region
> and mmap it as writeable, then drop its protection for "future" writes
> while keeping the existing already mmap'ed writeable-region active.

s/drop/add/ ?

Otherwise this doesn't make much sense to me.

> This usecase cannot be implemented with the existing F_SEAL_WRITE seal.
> To support the usecase, this patch adds a new F_SEAL_FS_WRITE seal which
> prevents any future mmap and write syscalls from succeeding while
> keeping the existing mmap active. The following program shows the seal
> working in action:

Where does the FS come from?  I'd rather expect this to be implemented
as a 'force' style flag that applies the seal even if the otherwise
required precondition is not met.

> Note: This seal will also prevent growing and shrinking of the memfd.
> This is not something we do in Android so it does not affect us, however
> I have mentioned this behavior of the seal in the manpage.

This seems odd, as that is otherwise split into the F_SEAL_SHRINK /
F_SEAL_GROW flags.

>  static int memfd_add_seals(struct file *file, unsigned int seals)
>  {
> @@ -219,6 +220,9 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
>  		}
>  	}
>  
> +	if ((seals & F_SEAL_FS_WRITE) && !(*file_seals & F_SEAL_FS_WRITE))
> +		file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
> +

This seems to lack any synchronization for f_mode.
