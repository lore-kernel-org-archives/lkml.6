Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54D3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54D3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbeGTUJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:09:02 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46323 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388006AbeGTUJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:09:02 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fgavx-0001an-Gt; Fri, 20 Jul 2018 20:19:21 +0100
Message-ID: <1532114359.21552.41.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 095/105] udf: Detect incorrect directory size
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Jan Kara <jack@suse.cz>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 20 Jul 2018 20:19:19 +0100
In-Reply-To: <20180701153156.210980281@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
         <20180701153156.210980281@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-01 at 18:02 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jan Kara <jack@suse.cz>
> 
> commit fa65653e575fbd958bdf5fb9c4a71a324e39510d upstream.
> 
> Detect when a directory entry is (possibly partially) beyond directory
> size and return EIO in that case since it means the filesystem is
> corrupted. Otherwise directory operations can further corrupt the
> directory and possibly also oops the kernel.
[...]
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -150,6 +150,9 @@ struct fileIdentDesc *udf_fileident_read
>  			       sizeof(struct fileIdentDesc));
>  		}
>  	}
> +	/* Got last entry outside of dir size - fs is corrupted! */
> +	if (*nf_pos > dir->i_size)
> +		return NULL;
>  	return fi;
>  }
>  

Is the same check needed when iinfo->i_alloc_type ==
ICBTAG_FLAG_AD_IN_ICB?

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
