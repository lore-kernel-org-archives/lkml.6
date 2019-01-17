Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACAAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3746120657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS3z+AqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfAQSdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:33:03 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:40139 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfAQSdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:33:02 -0500
Received: by mail-pg1-f182.google.com with SMTP id z10so4806671pgp.7;
        Thu, 17 Jan 2019 10:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jch6Jk/fgU9tdmA1F6NEY/F2fv//KSKRfDrdN25ImuI=;
        b=kS3z+AqTFT/wJZGO53MCTbM6sycvDGRkY3i8vhoy/gNswAqxbWegcZp4SdYSxjPhbk
         7uHVwfAvFF0EFb4HLFMK897hjdwDwQ/aC/q6bPmYyjBpIa7YBofy312xOdfhOImO4MqE
         XrVjpCcVwISDpttFnA5WAVPKjeMsjEIpMM8C/a2UEMO7FCqlIPUPaqUe/odXxOR3fGsz
         85A2OkeCb7pHBLMJVG0tl4JkO/+tg7kUm93GmALmGLavManufl6Jx+dbx0ks0ddja96L
         XdSU5dZHhoD9CQlciSLLBvhwG8k/2DM9F+GqGB4Izl4kAgkbpopoZlejuvrSrLbZcQwJ
         O8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jch6Jk/fgU9tdmA1F6NEY/F2fv//KSKRfDrdN25ImuI=;
        b=AgmEXtyA57/fMDxGP8ElKNiFdXQfnTjssc5EO5jzjnnQXQHmFTSjkgVUpVxBmyu1tP
         djs6u/X9CKsMxh44cQl13dQSfwGeW6x12KBZEgH3DwGyImBd4WTFPxwQkcBxGBLwLtY9
         0sfh0sNiGUYkWtokJKwNYXf8PXiKhexqx5No0LrZXO+v4P56QswFDGqW+WNfjbKEbZRF
         tpOUDP47qOzGgZWLUJFwy5qcCEUayI4O1twKO0588p8ol5oV8cffMeNzxFeIok3ubXXn
         9JXOA2arnCxixLlPF3faQop1IsfaOLAc5I9VJFiYV/RmKLARsD/mH4/s0+Z7mmwMd3m5
         YQ7g==
X-Gm-Message-State: AJcUukcrmm19FKYRhSts0zx4EFRDcO0x42rfwpMBjx2C8utQsQ/Tvxpa
        KpU5Mv/fxw8glBRmN+2Bs10=
X-Google-Smtp-Source: ALg8bN7ZzZbuER8PYdCQh4qSJNmXlqX+aV4BMXjaspYtmubHGbt8Bv9dyygnrYyWjOEi970TCTEXRg==
X-Received: by 2002:a63:e001:: with SMTP id e1mr14530539pgh.39.1547749981938;
        Thu, 17 Jan 2019 10:33:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w128sm3620210pfw.79.2019.01.17.10.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 10:32:54 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:32:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: linux-next: Tree for Jan 16
Message-ID: <20190117183254.GA17361@roeck-us.net>
References: <20190116173838.042db659@canb.auug.org.au>
 <20190116203547.GA788@roeck-us.net>
 <20190117084902.GA20220@ming.t460p>
 <20190117103553.GB23565@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117103553.GB23565@ming.t460p>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 06:35:55PM +0800, Ming Lei wrote:
> > 
> > Hi Guenter,
> > 
> > Could you share me the .config?
> 
Any 32 bit configuration from affected architectures should work.

> From your dmesg log, looks the test is run on i386, so please
> feel free to try the following patch:
> 
> https://marc.info/?l=linux-kernel&m=154772088110800&w=2
> 
Is this still relevant ? Today's image is fine.

Thanks,
Guenter
