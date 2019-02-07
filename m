Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FD5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C72218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="RMv41fVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGQoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:44:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33123 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfBGQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:44:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id f24-v6so480875ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 08:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MaJdyXbtST+oi2YkdRMDPor7bTOsnqXsbMtwI+h++Zk=;
        b=RMv41fVaW5y+UPMQ9xlLOa02KR0e/seEq4KkSgkDoBuZOhGYxDrkAXmCg3F+JurRFu
         GM+KoGk6BKg4tpE7KzANc2kVzcWdrfjSi3G+9qHql8NvI6S8Xh4pJeuKYtkw80oocUbc
         jnpAsv5Drjv2cNeboiUr1WfH9Vdug6T18/BZUw9GsG0urq0xHlpUR6cOAeIsieyX7Pmx
         yxb4ArOZF70VpPGDXXglnQ+a4Aon8XQDCvtsmTuCp3aQDu5dyXL+TvTDSEVaHaoPZ5Da
         1r8t7wBikvD3u0y0EDI/J8iWFEKQTuWwBHve4z+78Y8r6GewcIa/R+T+l91HSZ5yvJiz
         0Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MaJdyXbtST+oi2YkdRMDPor7bTOsnqXsbMtwI+h++Zk=;
        b=VgnWxx4DoUi3RTVUt4LRy0rSYsulDaNA6b2a+aCGdDEvUyGRohhhblTS4Td5MJxhmS
         ZLnxzWA+2TCWek/LP6iKtE9XC2g0KUJnQjsF5dhjqRFMcVXlItxQX3+NN76X8n1KymeX
         F5UrSYKr91rupEl4TAQGHYkngpZxnbPcYGve03hUYC7SPHDModTlwLeNL9Ri8kBYsMQ+
         Blkw48HS8G9qhYJPIyXgrhBzFIKZbb/4s87btVcOAHPYsmBwELJtewlTQDpsG1v0Vxso
         DQowoJ0CBQQT5EsFOpzAqlO14fLCBzf46KhdJ87EklXv0Z86ru8UIB/oP11kBv8E3V7e
         WBiA==
X-Gm-Message-State: AHQUAuaX2fRTsr9COd9wQPiogW4/aPl29byiChsboRSa/b0pguLARw/L
        KbNLOXejEh+WyASGF4Wqwu0uTM/1Tdg=
X-Google-Smtp-Source: AHgI3Ib1SITA/aqEq+DQVG4fSy+9AYyp9SeOptueNllYYXf1GELo2aD2/XPyL6vgcNCVkWMg1XT6Ug==
X-Received: by 2002:a2e:9b18:: with SMTP id u24-v6mr2080968lji.55.1549557849390;
        Thu, 07 Feb 2019 08:44:09 -0800 (PST)
Received: from [192.168.0.199] ([31.173.84.191])
        by smtp.gmail.com with ESMTPSA id c77sm2642932lfe.23.2019.02.07.08.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:44:08 -0800 (PST)
Subject: Re: [PATCH] xhci: Drop superfluous initialization in
 xhci_queue_ctrl_tx()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190207000331.7547-1-andrew.smirnov@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1683ed6e-c798-3a5b-341d-c0a7901887d0@cogentembedded.com>
Date:   Thu, 7 Feb 2019 19:43:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190207000331.7547-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 07.02.2019 3:03, Andrey Smirnov wrote:

> Simplify filed's initialization by directly assigning its final value

    field's.

> instead of initializing the variable to sero and then bitwise or-ing
> it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
[...]

MBR, Sergei
