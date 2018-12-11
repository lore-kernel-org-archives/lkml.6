Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53469C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD3D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNozX/1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD3D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLKT5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:57:18 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:33243 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:57:18 -0500
Received: by mail-pg1-f171.google.com with SMTP id z11so7143117pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZP4GBqDZAb8jD/jVzZynJIv2l8hEYXUTyekAG8xbeO8=;
        b=XNozX/1QnENvqC7dHqKkpUQEunuHtpp6snA1ppqKTc/AlSHZuDQnQNInXR6dUqgW/+
         t2FeijAHTFdSVvla1CTue07Ub6DQoNf6/fF7sQplQrpD9cBSqRBNqB081c0NnaEWu/sn
         dpcWoS5wYYni1Ht44ounNjT1ZCLiYUbI32yYt1DkL2Rq/gWHa8p08JJ6GMGewXD2evEw
         Zi1SZX3CwTkNI6UssjHWmjCz6/+upIUvq8dWZDgtyuyTPgWQbmFsczw5V7NnXtUkV4HM
         Ln3JEhcqEOoVCVk2/rUeyBN9jGpEQfBVStT1+5d2/OloWK6IBYhtputoeMH81KZVMnel
         zVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ZP4GBqDZAb8jD/jVzZynJIv2l8hEYXUTyekAG8xbeO8=;
        b=ovhEDsR1xjLPBI+ImskAlMGtDleLk4+MBwiKQxSZ6eKp+WPuxuHx3AzbrH1S2JQb1o
         p009iq6e6vmh9ztQNd9nxGmzJEs6NL2kUmXZWWeQtRjSkaMq/x1P6Al4OAVJVo/+bKl2
         XXykgukXu49eZ4zBsYw6jHSzXKVD/ixF1wbUFzub6uS/DXvfUtJ0CHvOQtUZu1H4uRnD
         szUaIsO8/PQgkBD6Ul8Rfhg/+9aoYT/t5MSi1z4LAkke2UGtXScx4D8glLYAor1nowt9
         ZhkE5mXK3P2zoac9I46aic6vZHhPwUjfwQ+0hgkXAVMcnTxSp6S7LCG3xautdFNiFtTL
         VIYw==
X-Gm-Message-State: AA+aEWZ/sopDIxmb9xdchr6uUf9OQkZX7+p2EzlJRCmpr/kDnVw+wo9K
        dMusAn1tReog/v2glYCYAKA=
X-Google-Smtp-Source: AFSGD/UYDm+3WioEMPtu++a/66+qsfyH6Iw12etQpiuggvq7OtzUBF/ld5PdpwXujUdgkmwxXIis1Q==
X-Received: by 2002:a62:b511:: with SMTP id y17mr17738048pfe.199.1544558236840;
        Tue, 11 Dec 2018 11:57:16 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q199sm25479082pfc.97.2018.12.11.11.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:57:16 -0800 (PST)
Date:   Tue, 11 Dec 2018 11:57:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: working toolchain for c-sky
Message-ID: <20181211195715.GA32516@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can someone point me to a working c-sky toolchain ?

I tried several from https://github.com/c-sky/tools/, but they all fail
to build csky:defconfig with various error messages.

Thanks,
Guenter
