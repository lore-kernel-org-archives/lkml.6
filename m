Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F796C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663512084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paQGspkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663512084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbeLLQhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:37:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54982 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbeLLQhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:37:12 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so9943107ita.4;
        Wed, 12 Dec 2018 08:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UsETcQtcyB+yXrCfIfD9AyjqMIdW2/VBalk+yDZfGF4=;
        b=paQGspkFXuwEE+z8FYPWEAponixarJB6Bas3l7M4UAJA+ajcZ5MMVCRmJvwqy7kBqt
         5v8JxA29gXacrcANB1DRS8POQLCfna9rYcqPR+mboLG8KTEaDWdYXNc5E30Py6CXjka/
         POKQ6T+XmuXjRy/p7hWCkToKO+1FeyuuCAtnP0xI8/1K7evcH0IaYqdIltq11Fh+YLOO
         rZ4mvb1QaQlVK9Ylf8hxjqDiLLWxx9eUvVM0bnJi7aM4XOkdI9p4QzHZ/2AubaukUEuF
         /3mronZjjgFF6mEmE4YLAi2Dx/dMwbt+MKTshATWj1Kmgx+OtOH6tUDfgvc3CbUr/CHD
         ysyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsETcQtcyB+yXrCfIfD9AyjqMIdW2/VBalk+yDZfGF4=;
        b=GEPrYZlW7NQhbdDyW5/EmYks9Od9vDpmJTXGStiU7+f+VLZyPpqGSYCEWaWcSZAc0V
         djrVpcUnAmsZJ4LuVuc/xGYm/RXeqra5Wll58ROM9ckPK0sVw9NKzpgwPu9C9LMzDgaa
         DGbCbuoG1VVnSKQQlOpUfPscxzuJCMsnsiw/0g7RY5kvy4Nu2lG0AGmSdy/cLgucpQRg
         ikxTa+PsIuCjuGgoCfyagtPLvVG6ZzcXUUoe5CGzp89CRJBewjiN1w8t8+TTrkkg7+qZ
         wT7QWrmj0ZpMVnSZo9Eel+KCUMXmEFPSRcnS4nLSgWyTF/IKW1JuuuY6HBzdyhYmqT6w
         iUlA==
X-Gm-Message-State: AA+aEWbCe1bQgLlqArd08ys+RDBjXSGwAryezi/27LbmV2Bra7QcfsHS
        P4SjJkB3fd0lY4LOB8y88Yxuw9Lh/+bxwLf70Ls=
X-Google-Smtp-Source: AFSGD/UwjJTqEWyc7+tUEBUK/lp/OuZPUKLIQJekDDi4Vca/BMio43VfWKPS+TFWdZA3+hiaIozHhtreFAqYoyTX3js=
X-Received: by 2002:a05:660c:250:: with SMTP id t16mr3519278itk.78.1544632630705;
 Wed, 12 Dec 2018 08:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20181209061428.19205-1-tiny.windzz@gmail.com> <201812110132.w5WK8nap%fengguang.wu@intel.com>
In-Reply-To: <201812110132.w5WK8nap%fengguang.wu@intel.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 13 Dec 2018 00:37:00 +0800
Message-ID: <CAEExFWtDh7yMx_+q2mhtHmMx_m8p+Xx8kfNkZf7wr1upvf=pNw@mail.gmail.com>
Subject: Re: [PATCH v3] Input: i8042 add i8042_is_mr_coffee() helper to avoid
 refconut leak
To:     lkp@intel.com
Cc:     kbuild-all@01.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer has been sent.

Thanks,
Yangtao
