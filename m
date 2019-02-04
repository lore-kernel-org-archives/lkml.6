Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A772C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503CD2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="qhG5sqyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfBDPoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:44:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41947 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbfBDPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:44:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so92025pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 07:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hkJeADfIbKLZnzY/b7hJWPKZE9ezXovdEo35SD/Vi4s=;
        b=qhG5sqydfUHDn4TIjxjj/W/RdQOYD2wKtqcqLEl9WzvxaH1Hq5MhrOTwmW8BA7v6bv
         RlTVQVIdYBwGgrF4vtIeJpWlCnmWvnQdsjKh7IOyciXaAhjeTKN+MyEc01ykR1K8gbV4
         rtBxsemrsbk8sOF16Qpy+FaiIub6eg831M1x6+KcuAvbd9XiRruJrdQO21odT7+GlttQ
         Iw7MmDb32iqaHHONzPpaVwv5CaxshCGebo/QlKi4HcxaawtanH2btYSDZTAXmMG77d7u
         0nMHj67d+Bs59vo5/MFWMeaaWyx8itQsId8uXU9x+iWcPW9oL4ERk8kP8JTFNCUkbR7c
         J+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hkJeADfIbKLZnzY/b7hJWPKZE9ezXovdEo35SD/Vi4s=;
        b=olZsxNjurWevDN1pGGK7cwj/MEC8VBTlMCD4H06L20aqPwcIq0Sp+ZYOfAUqu4pnKb
         KMjyA9VrQ6xq1kD2qE6VHAtuSylA8yz/sW0+LAV1QZnFdB1HME+NdZa7QDBPaEgQesrO
         qNOoGF1tL7Kmwdut+a2tHrutIZyRdDYViWdza78Gkmq309BSP7PhxMcgXYwxFPedynuV
         G8UorqyxTggnrCgGuosBiFXHtzm6+/LhLOCejQFXqMDES0+0g9xB7myREhZ2DAv0jEjb
         U/PKldj0Ln87qLaPf3xt5ALrn8LLHyechzI4UvgUqZOzvo5sM5+ArSbuLF4i3LhNPMq7
         R85Q==
X-Gm-Message-State: AJcUukfOs8EW3uEShGRsuYeiRA1Vz9llg3SbEogu27WlCB7JEiimNuXR
        3yzy+gOfVWYvnQ9HyYBdgFOjMw==
X-Google-Smtp-Source: ALg8bN5ZRP/n3yl+dibz9kUWSISbr1/QuuC5I57vLToRWFL3AcLZNMCYX8l8jdyedRY9I9EwfMOaJw==
X-Received: by 2002:a62:28c9:: with SMTP id o192mr52688909pfo.57.1549295053958;
        Mon, 04 Feb 2019 07:44:13 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id z10sm637988pfg.120.2019.02.04.07.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 07:44:13 -0800 (PST)
Subject: Re: stable 3.18 backport: netlink: Trim skb to alloc size to avoid
 MSG_TRUNC
To:     linux-kernel@vger.kernel.org
Cc:     Ronen Arad <ronen.arad@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Safonov <dima@arista.com>,
        David Ahern <dsahern@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Li RongQing <lirongqing@baidu.com>, YU Bo <tsu.yubo@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>, netdev@vger.kernel.org
References: <20190201194211.44372-1-salyzyn@android.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <2f4f6669-bdcf-a9ec-2739-d1a2c4e5222d@android.com>
Date:   Mon, 4 Feb 2019 07:44:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190201194211.44372-1-salyzyn@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2019 11:41 AM, Mark Salyzyn wrote:
> if (alloc_size < nlk->max_recvmsg_len) {

if (alloc_min_size < nlk->max_recvmgs_len) {

-- Mark

