Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86A7C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E1221EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RmAByoZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E1221EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeHIXeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:34:22 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38642 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeHIXeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:34:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id r3-v6so6626286ywc.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmgkmGYPVQMjcc62pVV/RXIRRnmQP+YI7wT1PZOI4AE=;
        b=RmAByoZ3VB2R06qKvmM0wF9e6LWJsK37EL46qHsJOA6XFXzTJJGO3+TwGRFBy3NAfx
         AsidcPRx6xB7ajkGZ3Em5SGfAn8I85GzW03rKUJZjZHkK3y4xBfr6WnhtmuMwcmDdm0v
         MvdNdXNI2aHzKACUOSyheqovPxobjn+mQyA9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmgkmGYPVQMjcc62pVV/RXIRRnmQP+YI7wT1PZOI4AE=;
        b=DIgdjUtD//3OTZDQnV3hUSRVQ/9yZJ6tzY4CG/e0o6oGlZ+q1ZKC+cjjtU8vn9YcoJ
         QWNfkeYjn6QrlkYiKGtNZxvnPiF/cV22xAw5F4hlSIt+h1ewJtp5VgH6XcSTaHXZyiQh
         zSTZo3Kq2pNFQFuvsayO6EDep+t9QB97r8Zcp2BXa/sP38NiwgcAT2Ya8TjiaeixoRUn
         4kqKhp4bsujnP5+AHZ8H5EU+rrwJJFPTlfi+A1CIGeaRE+605Jt4oXfO/aZ0GLK3W3AX
         aaJqrLFB0bb3V/rPk4GShY4F6UzO4T+gxXk686QY37mT0t5qq6oMM+s2kBtMY0OxhvXz
         6iaQ==
X-Gm-Message-State: AOUpUlFvlmubJN3PvcgV9IJg9LJIFH9Muh1Lpvd8+FVkw9wEcLQg4QY6
        R9+VOjKYUiMm5yw/7TtVrmUMoe3SC/DhGE3P+w0fukx9
X-Google-Smtp-Source: AA+uWPwAnjrFL1z0Pw9dr6H5TMB4o85IDkNabGlia7WN7PZaO20t0KjTePpZzhNcu2IRnsfoB4tykA1C7YuKAz42S/A=
X-Received: by 2002:ab0:2089:: with SMTP id r9-v6mr2575138uak.71.1533848865192;
 Thu, 09 Aug 2018 14:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180809171722.144325-1-swboyd@chromium.org> <20180809171722.144325-8-swboyd@chromium.org>
In-Reply-To: <20180809171722.144325-8-swboyd@chromium.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 9 Aug 2018 14:07:31 -0700
Message-ID: <CAODwPW8eg2WOh9-Raeb8Q65E-5D7RDheDU8e+H68FHGa0MS37A@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] firmware: coreboot: Request table region for
 exclusive access
To:     swboyd@chromium.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 10:17 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Call request_mem_region() on the entire coreboot table to make sure
> other devices don't attempt to map the coreboot table in their drivers.
> If drivers need that support, it would be better to provide bus APIs
> they can use to do that through the mapping created in this file.
>

Does this prevent userspace from mapping this region via /dev/mem? If
so, let's please not do it to not break compatibility with existing
tools. (I guess an alternative would be to rewrite 'cbmem' to use
/sys/bus/coreboot/devices if available to get its coreboot table
information. But we'd still need to maintain the old path for
backwards compatibility anyway, so that would really just make it more
complicated.)
