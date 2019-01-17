Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28573C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CB120859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547753074;
	bh=GhGLCiF6RO1ihila8yK6LTYa0FgMIwc4MLI6jXGV47M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vgZX7+1ytrDUfGme/f5esGgYJltHq9aik8TtwzTuABaUMHwYokMdfE0Q2ZitbaW59
	 uRsdDD2l6rMiDtTMEBcE9U+Z03heuJdkJ3FrevnVcuNiqnm4ciLoYYdDXTEIl8QrU8
	 XmaQXZnBUqniIbkLjOu1OXcKGV2nG+Zrthn09mJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfAQTYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbfAQTYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:24:31 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC62D20873
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 19:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547753071;
        bh=GhGLCiF6RO1ihila8yK6LTYa0FgMIwc4MLI6jXGV47M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lZPLJGcOG2gJuNAQXP+07tunpQeoZyTnZMnVwX/kL+y2Lwabwf3U5BZ3WWZ2645tL
         8NtsfPzMD28PUKRgj1LFocyVjL7Jrz/YbFi4t9Bp4cgYgyzhtlv4ochYq8XPivSrLw
         q2sPpd7MreugOwMdXx+4nibXFmLl/OMjPM0CwI4Q=
Received: by mail-wr1-f46.google.com with SMTP id t27so12312234wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:24:30 -0800 (PST)
X-Gm-Message-State: AJcUukdHfo8AupABweM1QZNaU7ziOj2SMeJkZlF4JfIMyVopaGvWjljM
        uLMX40XVCcKY9iHQVtAOas7m/Q9+eMgHC3qDnu6qIg==
X-Google-Smtp-Source: ALg8bN7TF8NVdypXCEsspe0qgIs0n2ybzY4aEelIqXy/tTUhBcJ73CGqA4HWTSVU4ZOSjPe6++fwvXmSlxSdFZVmv0Q=
X-Received: by 2002:adf:8323:: with SMTP id 32mr12804417wrd.176.1547753069183;
 Thu, 17 Jan 2019 11:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20190117120728.3811-1-bp@alien8.de>
In-Reply-To: <20190117120728.3811-1-bp@alien8.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 17 Jan 2019 11:24:17 -0800
X-Gmail-Original-Message-ID: <CALCETrUbiuYoDzLcHm+pXYyVJWcffiY76eu6UxuaDxtOk765pw@mail.gmail.com>
Message-ID: <CALCETrUbiuYoDzLcHm+pXYyVJWcffiY76eu6UxuaDxtOk765pw@mail.gmail.com>
Subject: Re: [PATCH] x86/traps: Have read_cr0() only once in the #NM handler
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:07 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> ... instead of twice in the code. In any case, CR0 ends up being read
> once anyway:
>
> 1. The CONFIG_MATH_EMULATION case does so and exits.
> 2. The normal case does it once too.
>


Reviewed-by: Andy Lutomirski <luto@kernel.org>
