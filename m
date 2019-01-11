Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72490C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4175D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1Fiekhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfAKCSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:18:54 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:41275 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfAKCSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:18:53 -0500
Received: by mail-pg1-f171.google.com with SMTP id m1so5642782pgq.8;
        Thu, 10 Jan 2019 18:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=2gYExETUN2qZwC6w1JQx2+NWPxWko9KH+Z2H35nmEJE=;
        b=u1FiekhvOHveaAYCfwOq67smYExLaWCUdYrbY/0Dd6JXouTsscGLqcV5A60W4rfUPc
         OWgg/FCUROxAVKmfDsvJVeqIhME7KuCtUt0t9BuPBMznv1UlgqBc0U+uEK9j2EW+mwpn
         6Grd1yxmlb31ucVRU6FvGAICNpYdy1EaPs2BdLFhH7+8045EILL/A+rDFxST76wvvWMD
         BFgjX1VVc8lhRmLazNApHjYyHpw8HJzKTfKpkTclNutZPuQNDNEqXZs0wOmcL9etijPP
         IkPvPvbWzOSvbn+PpiYTFeUDS4fzLMaLWB84z+by8tcOFbnipWIGHPnRMj++o5x3+ORZ
         u0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2gYExETUN2qZwC6w1JQx2+NWPxWko9KH+Z2H35nmEJE=;
        b=lJLAj7Pw5a/PeNn6ogUF1avRjxTEWxFnmM2x/WobR7lAeAqMAm2xVkQ7Rap96JFVq3
         CteF27W6toCZEW8LbfM71n2t62oYzkJMIMvNYQT0YmNn+7rAk7u97wIrHbTV8T6B4900
         Cti7nZ5ISCDVj3PVHzItZuLyqounofMa9Na93oXazYfGY13gUFU1MD/h6469DQD87IqY
         Qy8nDoA+K+venfivSya7U+QzEK1PUJtFpXiLnAq849yKPP66nH3fDhjnUdJrGpjB42CQ
         OShp+sJaF4MRXCSmDGBHiItvdvgAHekvK4aybaoczndZlGVWj7yY7OYIPZev4CKoQar4
         alnQ==
X-Gm-Message-State: AJcUukfjDDp90+8q7R7hfWMV2KErLNrlh5fTin23nileYcjtv4E0GZsM
        Ud3UGwqwMtKGPJWT7K/uBb9BdFdh
X-Google-Smtp-Source: ALg8bN7263cJX2eJSICz9VDiT3AM3OOLz6NVbIweqQVc01VNNFu6LgpB0ZuubTNyNuNJITzivFSJ6Q==
X-Received: by 2002:a63:4d0e:: with SMTP id a14mr11759125pgb.408.1547173131496;
        Thu, 10 Jan 2019 18:18:51 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.59? ([2402:f000:1:1501:200:5efe:a66f:473b])
        by smtp.gmail.com with ESMTPSA id n186sm104484746pfn.137.2019.01.10.18.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 18:18:50 -0800 (PST)
Subject: [BUG] net: huawei: hinic: a possible sleep-in-atomic-context bug in
 hinic_get_stats64
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     aviad.krawczyk@huawei.com, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e69f8fe7-6bb9-56b4-7053-9766b3a0f3da@gmail.com>
Message-ID: <9a6a88cc-7509-d54b-3465-36cb536cb795@gmail.com>
Date:   Fri, 11 Jan 2019 10:18:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <e69f8fe7-6bb9-56b4-7053-9766b3a0f3da@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep while holding a RCU lock.
The function call path (from bottom to top) in Linux-4.17 is:

[FUNC] down
drivers/net/.../hinic/hinic_main.c, 775: down in hinic_get_stats64
net/core/dev.c, 8278: [FUNC_PTR]hinic_get_stats64 in dev_get_stats
net/core/net-sysfs.c, 568: dev_get_stats in netstat_show
net/core/net-sysfs.c, 565: _raw_read_lock in netstat_show

Note that [FUNC_PTR] means a function pointer call.

This bug is found by my static analysis tool (DSAC-2) and checked by my
manual code review.

I do not know how to correctly fix this bug, so I just report it.
A possible way may be to replace up() and down()
with spin_lock() and spin_unlock().


Best wishes,
Jia-Ju Bai
