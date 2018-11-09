Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6653CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042A820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRbbfGg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042A820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeKIQ7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:59:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36718 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbeKIQ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:59:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id v70-v6so536059wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 23:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t4/Z93NpSjWRXYVjkJMcRprWEQbJMh3hbotZAHtoic8=;
        b=sRbbfGg/BBreaLfD5mxRjQ34xhes+LY2xD5w+ViNGrm9wIAI1C+E6RWar6/Z9UAPc+
         yXzKP/xwFt/ZtCVx9H+t/4yVD0jJSwqp/mkZMsDAlA0ho4htei/Aed3WxfskpjLA6TkD
         moTGfw6stzf0GNAekxPNfAEe6O9IXy90FnWjTPUbvvDb9JJnqENmGsnH8B4FcnPa/sd4
         bmf30dzHzE66O0MnixBwUkHffN/9e6NiSxImnW3NhSLzPtykyxL960YcJgNdeCl7H865
         ysyexVEjMT8DVFC0MyzE60NHD55p6j7ez/alqYQ8IDOUahhGmVdQmr5n0n+oB8BgnF29
         shiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t4/Z93NpSjWRXYVjkJMcRprWEQbJMh3hbotZAHtoic8=;
        b=T8MF5N7OlaFm5IgmGiP0Z3YAICTF4eseoloQNYjOxEuEwvEbzrs7XUSHmixwgD3dz/
         NjbJJw8ZmH2AQQ2P6auXZj3YGdrx6jBcYPUi8UjXS/HQvT5S7jT1CqHwJDQFN8CmiBZH
         zii8YPefUbeOnigleG2yCAM07/0UmuO1KzNKi/iTXeRWutOQbIBJi72jqu6vqf1S8Dxx
         IfiAWhwaKEAv2ZfO2BvA1rGlOnBwgP7/Er1MObfIOckUu6j0pt0+Cj6NaARilEMntbId
         hoXmGz262Fg0cZHklJKBSK3W3G05c7czzkc8BwKM+uSR61OjG2Fpreunq61RRB6DawIN
         j56A==
X-Gm-Message-State: AGRZ1gITilEPmV5o4U5fw9/6upD/TilnRbJoyggFKIS6wMb0YnWAaxo9
        VArXv3vAveak9OJVHvxheZc=
X-Google-Smtp-Source: AJdET5c8kmZhZX38caQp5QjMOFqcRR5YF80l/gxTzI3PVF/Fy9Djl/UvPSyMsZ/otTs7ikcqYyuQ/A==
X-Received: by 2002:a1c:1189:: with SMTP id 131-v6mr3667075wmr.87.1541748018907;
        Thu, 08 Nov 2018 23:20:18 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h189-v6sm2434376wma.10.2018.11.08.23.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 23:20:18 -0800 (PST)
Date:   Fri, 9 Nov 2018 08:20:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org,
        hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        QEMU Developers <qemu-devel@nongnu.org>,
        Philip Li <philip.li@intel.com>, zhijianx.li@intel.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
Message-ID: <20181109072015.GA86700@gmail.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
 <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
 <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Li Zhijian <lizhijian@cn.fujitsu.com> wrote:

> > If the kernel initrd creation process creates an initrd which
> > is larger than 2GB and also claims that it can't be placed
> > with any part of it above 2GB, then that sounds like a bug
> > in the initrd creation process...
> 
> Exactly, it's a real problem.
> 
> Add x86 maintainers and LKML:
> 
> The background is that QEMU want to support up to 4G initrd. but linux header (
> initrd_addr_max field) only allow 2G-1.
> Is one of the below approaches reasonable:
> 1) change initrd_addr_max to 4G-1 directly simply(arch/x86/boot/header.S)?
> 2) lie QEMU bootloader the initrd_addr_max is 4G-1 even though header said 2G-1
> 3) any else

A 10 years old comment from hpa says:

  initrd_addr_max: .long 0x7fffffff
                                        # (Header version 0x0203 or later)
                                        # The highest safe address for
                                        # the contents of an initrd
                                        # The current kernel allows up to 4 GB,
                                        # but leave it at 2 GB to avoid
                                        # possible bootloader bugs.

To avoid the potential of bugs lurking in dozens of major and hundreds of 
minor iterations of various Linux bootloaders I'd prefer a real solution 
and extend it - because if there's a 2GB initrd for some weird reason 
today there might be a 4GB one in two years.

The real solution would be to:

 - Extend the boot protocol with a 64-bit field, named initrd_addr64_max 
   or such.

 - We don't change the old field - but if the new field is set by new
   kernels then new bootloaders can use that as a new initrd_addr64_max
   value. (or reject to load the kernel if the address is too high.)

 - The kernel build should also emit a warning when building larger than 
   2GB initrds, with a list of bootloaders that support the new protocol.

Or something along those lines.

Thanks,

	Ingo
