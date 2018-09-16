Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A786FECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62607208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AllStu1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62607208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeIPFwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:24 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59519 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbeIPFwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:23 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 877bb772;
        Sun, 16 Sep 2018 00:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=czv06GiudKWfeGob8B2GZxWqBms=; b=AllStu
        1bSLaC+vjx12KFw0e/flUUY4T+UdMyPY9Tkg2S4ExYzfKgbBxq3QzOKGJzlfMMmF
        NB08EkY3szrEbTHjBGJnX76wSnQyM0Ktr6Tn1xqjseUOY2fujnJOl4+/GR1M7X67
        AYdc3VRcWuBMSV8Cn9jMWP4f6sJFc0bMLvOZwc6Gw9nGp5ianKuCrJHunEj3xzwA
        UUQpQMmyyo13CuKTZU93EaVREk2W2krj1vtjSDE1+HcREWw++xpzLxp/laJ8YHnY
        tkbbBtVGxmo50CsjM8S7Mr8ftIQmhp+2mq3zzyNIMLUh1aIgF3XtEJrzUWVTv8Ck
        Py+Q1Nv11Vb6TXyg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f9448249 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 16 Sep 2018 00:14:12 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id u20-v6so7965230otk.10;
        Sat, 15 Sep 2018 17:31:26 -0700 (PDT)
X-Gm-Message-State: APzg51DT3q+FKNJvSZfKpt0IcI6qf2AYSazb1D5WydCuCj/KlRoR+v7a
        fNshQjn0fBd6yi1MkBEa0dgmdedvNtKBz1/9oPE=
X-Google-Smtp-Source: ANB0VdaNp3agZkbIof6ox6hhSGIetyP5GGR3BF4hu8HJ6jgPHxCL9CaMnWs6DsF5HDvQ5tXly+2JsG1d+yikxYZDsOE=
X-Received: by 2002:a9d:3a34:: with SMTP id j49-v6mr8397815otc.317.1537057885315;
 Sat, 15 Sep 2018 17:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180914162240.7925-18-Jason@zx2c4.com> <201809160719.qunccnIZ%fengguang.wu@intel.com>
In-Reply-To: <201809160719.qunccnIZ%fengguang.wu@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 16 Sep 2018 02:31:14 +0200
X-Gmail-Original-Message-ID: <CAHmME9o=tbcG-EQNOfOhn-uDY8K7AWktdXTFdynBmLVmZ28vbA@mail.gmail.com>
Message-ID: <CAHmME9o=tbcG-EQNOfOhn-uDY8K7AWktdXTFdynBmLVmZ28vbA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 17/20] crypto: port Poly1305 to Zinc
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Mr. Ro Bot,

Another one of your robot friends also caught this, and the offending
code has been removed for v5.

Thanks for botting,
Jason
