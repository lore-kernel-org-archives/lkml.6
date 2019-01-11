Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B969EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B6B20879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="b7Q0fp4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfAKBbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:31:00 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:35937 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfAKBa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:30:59 -0500
Received: by mail-qt1-f178.google.com with SMTP id t13so16461754qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 17:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/dqIRiiFfNrV+IaTn49SQBBQ9rg2xL0X8oGY/I2i1FE=;
        b=b7Q0fp4v9Ky6CWa9wtFHnjGQXrPmKF/LdCB8L23/u797bpcL9AvI5WVjH9VMDNETG9
         tr2uN0yLWSQb0rRudxVcz9XKCQzM/fx6WWYs1QdKMcZ1LVQehdc9h4+PWX0nh4bcO5Oy
         0TGWOSX/KcFeOflzQozrMCbYCJDos+DjSwqq3TO1t4dxOkt9J++HT27fTaPT75O0kr1f
         P5LotADoVl/gQDQqpNRnxukAdf3gPqUsHxzfRGi4uY23+WCBovfZSblXD7ZSuqInzjAM
         xDV3RwkoinJly/p55jTqYua1soDsyTQV0kyHleXQx2/StSmp+obylJNNn48rHjr66tX/
         s52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/dqIRiiFfNrV+IaTn49SQBBQ9rg2xL0X8oGY/I2i1FE=;
        b=a7E5c0GJyOp4Gnw3wRnCXSQP4YPJsdxVrKz5fQ08U9KgScvttX92xjIZZhxRMqMamD
         HxawWbQkAE35BXKJj+DnnbNn2tS1MviFjae4xSNslrhPbSBU0FgkcrEdJO0cfzm9SO0+
         udjbiy7X+2nyBwnz+EmmqTcK6Xj7joVTyNMyu/RFMA3zB2WnjD9USy0RVnFJsLZ9uzaj
         QrwkemCwT9VEvSCQJAmzLE8hU7tM/REvIvxz8WhRI1p3AWpZhPZFkINDhsKu5pp2wCwM
         ubSrT0HlfQLPRrtkwaoFoDo39P+EkiC5y4CEnfu6/1GKtOWKLBUbkuqUjP8WTt8jaPh4
         5WTw==
X-Gm-Message-State: AJcUukfDbi3IU/NWhauk//rmwhxDXGnAn+uI/mmASkrB8lHIomGfOtqC
        LnJAoUy9hXDB/BUrIKaVVewV7g==
X-Google-Smtp-Source: ALg8bN6HrtxvFbzQqS2G9XcOqrGKA7vzY/RaG9G5HsX5QFbAlkaSr889cBe2RvQYek+6dQQTJYHv+Q==
X-Received: by 2002:a37:7d05:: with SMTP id y5mr10813847qkc.310.1547170257376;
        Thu, 10 Jan 2019 17:30:57 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y4sm45679504qtc.47.2019.01.10.17.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 17:30:56 -0800 (PST)
Subject: Re: PROBLEM: syzkaller found / pool corruption-overwrite / page in
 user-area or NULL
To:     Esme <esploit@protonmail.ch>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <t78EEfgpy3uIwPUvqvmuQEYEWKG9avWzjUD3EyR93Qaf_tfx1gqt4XplrqMgdxR1U9SsrVdA7G9XeUZacgUin0n6lBzoxJHVJ9Ko0yzzrxI=@protonmail.ch>
 <1547150339.2814.9.camel@linux.ibm.com> <1547153074.6911.8.camel@lca.pw>
 <4u36JfbOrbu9CXLDErzQKvorP0gc2CzyGe60rBmZsGAGIw6RacZnIfoSsAF0I0TCnVx0OvcqCZFN6ntbgicJ66cWew9cOXRgcuWxSPdL3ko=@protonmail.ch>
 <1547154231.6911.10.camel@lca.pw>
 <hFmbfypBKySVyM6ITf55xUsPWifgqJy6MZ-kFJcYna61S-u2hoClrqr87QTF4F2LhW-K42T2lcCbvsEyGAL0dJTq5CndQBiMT6JnlW4xmdc=@protonmail.ch>
 <1547159604.6911.12.camel@lca.pw>
 <olV6qm38nrHhMMH3bq9cY3h60MaHsW5U9n6xn3_PVP1UkFNJBNbVuS-8P_FdCazGJX6GZX_Qqe2Nj8_hbLJsgto76Xo-gLQ8We-hsc_vRKk=@protonmail.ch>
From:   Qian Cai <cai@lca.pw>
Message-ID: <7416c812-f452-9c23-9d0c-37eac0174231@lca.pw>
Date:   Thu, 10 Jan 2019 20:30:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <olV6qm38nrHhMMH3bq9cY3h60MaHsW5U9n6xn3_PVP1UkFNJBNbVuS-8P_FdCazGJX6GZX_Qqe2Nj8_hbLJsgto76Xo-gLQ8We-hsc_vRKk=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/19 5:58 PM, Esme wrote:
> The console debug/stacks/info from just now.  The previous config, current kernel from github.
> --
> Esme
> 
> [   75.783231] kasan: CONFIG_KASAN_INLINE enabled
> [   75.785870] kasan: GPF could be caused by NULL-ptr deref or user memory access
> [   75.787695] general protection fault: 0000 [#1] SMP KASAN
> [   75.789084] CPU: 0 PID: 3434 Comm: systemd-journal Not tainted 5.0.0-rc1+ #5
> [   75.790938] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1ubuntu1 04/01/2014
> [   75.793150] RIP: 0010:rb_insert_color+0x189/0x1480

What's in that line? Try,

$ ./scripts/faddr2line vmlinux rb_insert_color+0x189/0x1480

What's steps to reproduce this?
