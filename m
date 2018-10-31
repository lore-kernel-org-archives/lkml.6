Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A5AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A702080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G+8SmVdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A702080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeKAHlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:41:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36075 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeKAHlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:41:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id s15-v6so16380573lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4rz/d53SntqIttGtUQMOIo+ViX3YhIwcQ73uOg7yI8=;
        b=G+8SmVdTMwjMuEd6atjNepDL8+k8LJfQ6zLG9K/2ghoyTUtFUurPqD16jVm2Nwvb7j
         N8GEp8NRI6GmcDnuL2qcMQmqPTkr8Vuk53tTEaHf8pNi+FddDo8wNoSJq7Cq3EgUXih3
         1nxM8GVpOD3h/wRy69XyxznxGHfmuiGfsBikM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4rz/d53SntqIttGtUQMOIo+ViX3YhIwcQ73uOg7yI8=;
        b=oy/vnBiX8/gifQm64QOelhsw+NkEEW9u9BwilohxoXL4XHe8pcpyPCKC7u9MPFRzf/
         rg8w5U0EFen1XgElOv/ajKcAO7aesK4s0rR4wCXVZJebCnklHb05PvyfLtxvbIgId8Eo
         NSK3ZPxk/QANQACj5qwhAwK8Hc1BGIecgRCXB83nokG3xo0oYVhKFise17vrG1UVT9dt
         wAFV8Csl39x9PKL2BOveSO/Lkc3Zp5AmJ629+6otHPw2MCwyyZwMnNkDi25RKcRkmnTd
         Fm2Tnso3bZtkWE8Kvwy+Hpkw5K+C9Z6pIaFJbH6/BhkLTVRlJDOgIpv1JsGeKamOKtOg
         pbnw==
X-Gm-Message-State: AGRZ1gK+hRoKgDwT+cojT7by+eI8DIWyxiVh0m1jJ+Ju3YthLCYf4UYS
        /NeJpzUP/8qgufq6k315Wh+TxnbK4u0V4A==
X-Google-Smtp-Source: AJdET5dQiDv/Bio4gfN6HvPunRtruTZMr6oFVCNgi2rQLMCFIqpdreeiLnxHIUH34qnNap9NQt8UBA==
X-Received: by 2002:a2e:4745:: with SMTP id u66-v6mr3167527lja.37.1541025705681;
        Wed, 31 Oct 2018 15:41:45 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t77-v6sm4754128lfi.63.2018.10.31.15.41.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 15:41:44 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s15-v6so16380523lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:41:44 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr3551313ljj.6.1541025704224;
 Wed, 31 Oct 2018 15:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <08ac040dae0417c7ef5ed6f5e2e2614bd14e4134.camel@redhat.com>
In-Reply-To: <08ac040dae0417c7ef5ed6f5e2e2614bd14e4134.camel@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 15:41:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_6_vOW7n4BzXQS6ECb7fg2hSdy9ZkzJwYnO3LEHtPaQ@mail.gmail.com>
Message-ID: <CAHk-=wi_6_vOW7n4BzXQS6ECb7fg2hSdy9ZkzJwYnO3LEHtPaQ@mail.gmail.com>
Subject: Re: [GIT PULL] c6x changes for 4.20
To:     msalter@redhat.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:59 PM Mark Salter <msalter@redhat.com> wrote:
>
> c6x changes for 4.20

Pulled,

            Linus
