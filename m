Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049F3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFABD2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqnD5G1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfAVTX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:23:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33680 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVTX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:23:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so11966258plo.0;
        Tue, 22 Jan 2019 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X217PoeUPCaMIxFqSwvf/RBoB6yzbl8wahFM54PaqHg=;
        b=bqnD5G1c0c1KjedIkTzfRDvuVhk3qpr/6Bs9YbZQMzlYGq1czciDSue5DyPhBaviVp
         wzyhuWFo78ITldPIILtmUyp5x0nCiwOYXGr42zoIXw0tW1sAvccsEdcBDpdspVNlnZOz
         j8W52IhxTdnZLcDaH0aAO7aGYwkkD45uXeaNftnhfOl6+yF6R29+eQE+CRcWgy76BC6k
         y4BYyqgC4yemtEMYVaI/+qgjl9yev+NwiTxCv9OJgyzkXjJQw3jSD9/aKb4zKdTVVz04
         ZrfPgT+5f5b5hTv3nLVyjuOecg12GXt0fIKQTiboso4266zQGgOdelmnr9YCS8c4K4Ks
         mhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X217PoeUPCaMIxFqSwvf/RBoB6yzbl8wahFM54PaqHg=;
        b=C5TQV/FjfPOPpnz0AdGLZcu3se3KAklLLeZB6ZKEbp66zEdPGjM7vJUSr9ApRLL9Dz
         h+29fsz+rUTRu9g3yOYk6nwBL3yPzX5165b+Hz/oXt+V84XNLjPuw4obbmraBeB1y1V0
         GR6LKLqycvMDhSA+izOjZnP0q8QvkpndyDsj1jzSU6n9IsbPzhhPIQApwnp6wOUn6lCv
         M4VKhzGX21tHYUPm68/O6WI84nnYT89Xp6+CRnAuIq+nreHlydmULGO6jo50mxJO9YoK
         Int5r+qHr17BsfmOogX5g7ImhZW5+XZlclLKxeFv5QO4tb8nm4NhYXdBOTTtYIEGCSx5
         MbBg==
X-Gm-Message-State: AJcUukfJXwCx+jXr9Vav4sBlXiytyxj74t5uOiyyOYKeIh2PBu5vL9r8
        jjcDIzUIFq7GWjRquq8EkVQ=
X-Google-Smtp-Source: ALg8bN7ztquefiK8mdIVp7O2T+2w1atgfhiKTBmE+i2q5StmfsmVElMeG+qQ3foyo8Dg08qLNxQS7w==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr35949119plb.182.1548185038096;
        Tue, 22 Jan 2019 11:23:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u123sm24681449pfb.1.2019.01.22.11.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 11:23:57 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:23:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/99] 4.19.17-stable review
Message-ID: <20190122192351.GB2224@roeck-us.net>
References: <20190121134913.924726465@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:47:52PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.17 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan 23 13:48:56 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
