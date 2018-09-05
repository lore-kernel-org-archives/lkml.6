Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F67C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDB0206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e2Jknqta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDB0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeIEVDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:03:49 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34781 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeIEVDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:03:49 -0400
Received: by mail-io0-f181.google.com with SMTP id c22-v6so6495686iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzh3ZMwejjs5E6SxvS+IcDFKL35bgf/KZnkDqIiY4OE=;
        b=e2JknqtawrGnvdCuTfDHg8c51MXq7x7j5x4pOEp8nFUdfBgjTDrJ4lZw1yC4ZFrDbG
         EgEzNoPS04wK1V8/N1mJ6AHeAqwOaonbXUJMXo92+yEn9SRm3dDS3pmpWZLfQooD72Cl
         dtP6m0+trbS6qkabi+87l+hihR4POyXdUhRus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzh3ZMwejjs5E6SxvS+IcDFKL35bgf/KZnkDqIiY4OE=;
        b=OOCfwLJvT0f8N6CBVQd1GSdWnkZL0+1C3pKiFDp6aATv8m7xQb2+WsW2BCHRgEYUB9
         0V+owXcAJ5RaE7svPLXTBwzTVXZvvxofZt2Tis4TBCwj/sEvOJw1Koxzdb51vuQ0LqZa
         V/X+OZKVmVMBreJNidDOadIsOcrvL7JRgeezgTPk3sYrjIl0aOG7AO1RTRMTjieA7uCc
         vbVUxR64rk7W7pmcmvmpHgFM0wjXkuIjQKevJtGFSC5BzFhAFoqOyzZQqAm0Z6y3gWS5
         oRw3zzXe0p5An1Ext8f3uHdvnHVLamkuu0UAJxXWagcn90MbjhlBqvgpq8mbfSRj+An7
         JaQQ==
X-Gm-Message-State: APzg51D9i0qb/ZiPCCNk/DjaKT/sqoAx0XnIRjBOOP0cmmmeBS2UZjux
        MNRMti1vi2WuGErXBu/H1Iqp84bKni4hleopEWI=
X-Google-Smtp-Source: ANB0VdbIMl7msF3yufMxxf0dQSbQ1ieqOAgANKdr/1IUsJyKidT8a/n7Eby7/d1KT+jFPqg2ECSoGr5zPo900VzUPkA=
X-Received: by 2002:a6b:7a49:: with SMTP id k9-v6mr27806995iop.238.1536165171764;
 Wed, 05 Sep 2018 09:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <1536137722.4813.66.camel@gmx.de> <178d6adc-2a79-99dc-daa8-fb0ed9f0afd1@kernel.dk>
 <yq15zzj3o99.fsf@oracle.com> <yq11sa73nzo.fsf@oracle.com>
In-Reply-To: <yq11sa73nzo.fsf@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Sep 2018 09:32:40 -0700
Message-ID: <CA+55aFzanD=T4hpO+D-LGqxuJ4CsVpNXrr6erQt7pA=iPAyDHg@mail.gmail.com>
Subject: Re: [regression/bisected] 4.19 cycle boot time IO stalls
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Galbraith <efault@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Bottomley <jejb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 9:31 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> > I reverted the two offending changes last week. James just hasn't sent
> > Linus a pull request yet...
>
> Actually, he did earlier today.

And I've just pulled and pushed it out, so it's in my public tree now.

Thanks,

           Linus
