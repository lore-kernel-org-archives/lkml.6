Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0068BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B298621473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXq/xD8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B298621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLCJPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:15:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35725 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLCJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:15:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so6864639qka.2;
        Mon, 03 Dec 2018 01:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=au0ozQYB9v9Nr6rwBYifgOrIDfqVwrdrjUaUbvgAN18=;
        b=NXq/xD8FBoaCXNjzhryLK+Ya5Jk4rBQ5BCHf54jhCxFstiLJIfPPI69DycuAlpXnFU
         ufHWcIjErL8hrCrLv6487EriL/urHKKnXPlo8xsJvjm+Xb3AAEbFKhi0MIS4LjeflVGo
         quZqo4qnE11Hj6xopCnaVwRaZK9BzAmGJSFUE9HzunPcnjS7LZwmsXm5uUFRe0aVbsn3
         8Neqyp8eoQZix0RrgcQ0wbEMnbOf5PrTYTAfbEfWqaLegTJXS6Vt7hZW2PwQQO/HFnvX
         uEA6W3TylWHK6fcKDenBEWUp+N8A8kPmnq3A8Y+KX4Yo6J6mWI1qfPSTo8VDor4fu4YK
         vs+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=au0ozQYB9v9Nr6rwBYifgOrIDfqVwrdrjUaUbvgAN18=;
        b=Ztm5nRSeQFWnM87k6PhPUBDHa1YLdzHSGcS97nzxUlvD1FwAgKy/8rzZak75dqlXB3
         nmmRFuZlydem7vPW3HDPqp2y3jrnjwnlkzlq7G8rFHOL5OWa2oyhaemflC2jSz3D74tW
         NmHwS1P0/dERbur7i8H58J4IDdiv9dJ71Lo9ut8pWNiKAFuEA0ZYSmb9vWJ2mDQ4gMJ8
         Bjx89UU85XLWNBkCL387A/5FbAe6iyMtXfUBEicMZZfMqH6IrINsIXsnCXbqbLJBeZyd
         HgQyiwX3ll9PTD4EYsfNSxcxnRxfRE/moVNbrJZwqj1LbGhUHGkjER9STkBlksHpQJz6
         /L8w==
X-Gm-Message-State: AA+aEWYUZ6H2VooKQfoxb9mOtiwygEorz9edjUtJEcvEDpZx3+yvGHm+
        idul+4pu2iNxpXauhzvZuFI+N+L4tV2jifYN5l8=
X-Google-Smtp-Source: AFSGD/WOBreSGrN6SCqYSZRjqo0afun+ZVhGIX3LLziP0Sg+v8MYF1UH9QMv47y2X07vMW2d5HEAhMecr9KTpevzWzU=
X-Received: by 2002:a37:4792:: with SMTP id u140mr14410717qka.301.1543828528217;
 Mon, 03 Dec 2018 01:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-10-chenyu56@huawei.com>
In-Reply-To: <20181203034515.91412-10-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 11:15:17 +0200
Message-ID: <CAHp75VcU_vP_GEhn2-wvE_LRL2xtsY45kzjCRYU+BAnTcYDA4A@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] usb: dwc3: Registering a role switch in the DRD code.
To:     chenyu56@huawei.com
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:47 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> The Type-C drivers use USB role switch API to inform the
> system about the negotiated data role, so registering a role
> switch in the DRD code in order to support platforms with
> USB Type-C connectors.

> +       pr_info("%s:set role %d\n", __func__, role);

Noise!

> +       return role;
> +

Redundant blank line.

> +}

-- 
With Best Regards,
Andy Shevchenko
