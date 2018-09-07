Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6819C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C84C204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KQnsI+o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C84C204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIGJoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:44:10 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38641 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIGJoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:44:10 -0400
Received: by mail-it0-f67.google.com with SMTP id p129-v6so18393856ite.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 22:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30o5VfGACei7V3fO3VqN9EG6hn7D2neai4tXhR5nBrg=;
        b=KQnsI+o0PWSHnBQC6O9QkYIwvmwQMlVGRBO9DJ2quXf+7HcPSa8GWxUF0PHKgwuO4T
         j6GJXvpFeqD4kyBvsz11eJAAkA62KoAbeORwL8K7kaTTZ6Ig+EenYZsOJA6Gq6syxUhi
         VClYf44YBgW+9Sc6CBVThhtMB/8Z5niiVbfc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30o5VfGACei7V3fO3VqN9EG6hn7D2neai4tXhR5nBrg=;
        b=Vw+C2OjdyfKgc66jCj0Ba64287jepmSntfa2RPkeOK8Fsh2EMmcMMAOI56uYEpHwAe
         BvnYgguv7jHZBBn3o7j5LiDTzuzlynW/QR8KpkaZIQF4Klt82zNt/FLvvrELvOVm1pYF
         B7k5sEgcx6OpK+b2K17ib52/GT2fZbCZHm9kvepGq/S13Uq30I4rIq+mjtf4CubSCDAu
         8ar6majx9jtVA/8w5jGWF8V9SIp9Q4lYNjJZBCpNehX9m8UVDFbvDAODaQYQgiZ50nmg
         yyByXjH27MUuyzGxClzn8zcXMBlvt5uD+ro4c2FLeOVYyIvHQqKN1tiacift/zc9vpBr
         BnAw==
X-Gm-Message-State: APzg51AlOFNAT9OZjGab5KMBpL1M1l1US5C3LonTlWglCwsghYnTtUBZ
        UgFdJVVUAaWmyJrs5IsUko5OGfrqUF2nvmbDzrA=
X-Google-Smtp-Source: ANB0VdaNSSx8E2JTMw3U1AqT0gUEVl2tkh6/llHu5HuQAcEn4dAiZxL37Zbcqm4BG6pe0PqAesZZ7RL8TXEnDDymVZI=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr5285312jaa.10.1536296700207;
 Thu, 06 Sep 2018 22:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <1536223870-6324-1-git-send-email-dingxiang@cmss.chinamobile.com>
In-Reply-To: <1536223870-6324-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Sep 2018 22:04:49 -0700
Message-ID: <CA+55aFxuha1tQXcn+WtbOKzwwmtA8AORb04tMM=hk6jT3ntt3w@mail.gmail.com>
Subject: Re: [PATCH] vme: remove unneeded kfree
To:     dingxiang@cmss.chinamobile.com
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Staging subsystem List <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 1:51 AM Ding Xiang
<dingxiang@cmss.chinamobile.com> wrote:
>
> put_device will call vme_dev_release to free vdev, kfree is
> unnecessary here.

That does seem to be the case.  I think "unnecessary" is overly kind,
it does seem to be a double free.

Looks like the issue was introduced back in 2013 by commit
def1820d25fa ("vme: add missing put_device() after device_register()
fails").

It seems you should *either* kfree() the vdev, _or_ do put_device(),
but doing both seems wrong.

I presume the device_register() has never failed, and this being
vme-only I'm guessing there isn't a vibrant testing community.

Greg?

              Linus
