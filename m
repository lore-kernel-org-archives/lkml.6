Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B393DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3CB214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="dCLyTeGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfBKVTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:19:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47011 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfBKVTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:19:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so283877edy.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zab3FGYgNV415lD0tg/yzJunAbObk4ZwZX+bJm7C+/U=;
        b=dCLyTeGzv+NHlqa02h/25SLCmt5BF+5xqpw0XsS3Wthx0Y8AUffQ07kNOx5C+1shxP
         rUKxoqq/5Hf2nGeJYSYPdSvIU2du4mjW8ruIL2LNF8enLt3uqcEOABQ7cY7GhU6169s8
         hsMOPZ+C4GkjdfMo1HkTFfP5SFyxWFcAi5r6W4YLfBViKDvtyA6lqqpPmPuUPDxYY235
         0+1Q/2S18HDj7ve6BbEKS8PlWiLEH7aEHdyQSn+9tckwyqKAEFOTsGcw1l6IXE3hTc53
         tmpXyuoRPEF8nfzNfg4ENSVzgqUNHeyYyojHXaEUVkZ8GEQWIh1tW5XRKtE8MBuTPauu
         +rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zab3FGYgNV415lD0tg/yzJunAbObk4ZwZX+bJm7C+/U=;
        b=J0qf9zbMMO2mgUPz7YTBNFGwaqND1NN4gedy79kEVddl5mUU71tQNceSZyuP6WDmzx
         7Pi1PDtzuIQNNVaohINM1i2kc/kbs8xtn+DcFgtZlfaUPkgpGjOFF0EXgQLX7uOlOGmg
         N0NU2c5dqz3ko+hqDJW5bbQuq4LYENhzizts7Ieu0SAG0PrlYwfBUBSY3MoMRvxcQTv3
         ZWsxSBb7fOD+9UNEr/NmXKKJAVqG+H8alsMCAm6M0GODntvu6+xI+/fvNTKfeM8U/rvE
         Cb6JzCvKPkqtWh3bmoHOY+2EYbsT4U8/g6tdnV7F2FidyLR4Xu3E9AaBHhX8UhTde57R
         97vA==
X-Gm-Message-State: AHQUAuYHaDh7AbCLVPPIxV59lJ7ZRN30txKRmbZEIGwHKXeo9ieq770j
        8787/lIWYnPEjMKUGeWLfCIoWg==
X-Google-Smtp-Source: AHgI3IaJ1L15lTo49Zd+hmberKvBlsZPgQ6R6NnG6qgzoParwcTDRHWs12bZV+LS//F0wu9bSlFohw==
X-Received: by 2002:a50:b7d6:: with SMTP id i22mr162588ede.27.1549919961360;
        Mon, 11 Feb 2019 13:19:21 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:76e:9ed:e1af:663e:9c0b])
        by smtp.gmail.com with ESMTPSA id k14sm2461522ejb.8.2019.02.11.13.19.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Feb 2019 13:19:20 -0800 (PST)
Date:   Mon, 11 Feb 2019 22:19:19 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mcgrof@kernel.org, longman@redhat.com,
        linux@dominikbrodowski.net, keescook@chromium.org,
        joe.lawrence@redhat.com, ebiederm@xmission.com
Subject: Re: + sysctl-return-einval-if-val-violates-minmax.patch added to -mm
 tree
Message-ID: <20190211211917.kq2ahdkhoe36obhp@brauner.io>
References: <20190211210632.Nfd0f%akpm@linux-foundation.org>
 <20190211211716.GA31039@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211211716.GA31039@avx2>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 12:17:16AM +0300, Alexey Dobriyan wrote:
> On Mon, Feb 11, 2019 at 01:06:32PM -0800, akpm@linux-foundation.org wrote:
> 
> > @@ -2848,8 +2848,10 @@ static int __do_proc_doulongvec_minmax(v
> 
> > -			if ((min && val < *min) || (max && val > *max))
> > -				continue;
> > +			if ((min && val < *min) || (max && val > *max)) {
> > +				err = -EINVAL;
> 
> I was asked to return ERANGE in kstrto*().

I think we discussed ERANGE vs EINVAL and decided EINVAL because there
was precedence for other sysctls already.
