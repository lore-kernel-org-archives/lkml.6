Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90561C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E89F21925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yqwZX+ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfBODrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:47:25 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41589 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfBODrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:47:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so9466205qtp.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 19:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wE+3Ji0lIUUtQUWa2u/PMxfoCPxtSZUNLG8hQWwDVrU=;
        b=yqwZX+ejnGADwhi7L7vco3QTMSii8Q3pAbe5w6fs/vt1zjo0KwozAapaVPNC7EFUgI
         oYFkb9JNH5woya8yeq9RxISahyqKFMzo1eTImHyv4ggkOR8jr3ehndWm2acJJZZqKnmr
         lT6SOWdnCiVpt9pjFq25YrjphGxEphPj6GMp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wE+3Ji0lIUUtQUWa2u/PMxfoCPxtSZUNLG8hQWwDVrU=;
        b=Z5ScShhD9RPeOmEb/orbuAGv1/1hqvSYLhF/adW7ou2KTvHlZjhBFFXv9GpBgrK8fq
         fcY7RWOr69yIB+gELmn5RuPQ3g/3vZUC8l90Tb53oymZQcPr6trUdMRC516j40M83J0C
         r0ydOC1biaB4SnbA+uG5YKZj6Yt2qr4BR45UWIrsdjWcFawYR3VjcDNBqqG2ff77Bak5
         qozF3Ha+3kckq11IvvnHHhmj8ttMTrPthIs8s2c8BUcsK0DFkJ8BB7NPa8zXXudZyBVp
         +zeTCc9I9XFMstrekCP+nFngiR/slhELCrxOH8emNjmopXF1FlShGSeQdhcCKUv39i1B
         FA9w==
X-Gm-Message-State: AHQUAuY3GvI4FqGsnZmtvfwfCEp7CgYcwo2FxB96feHjCiBFf6QXPu/2
        54BY8GciAqh1tvMFqxsjECrLaw==
X-Google-Smtp-Source: AHgI3IZQZ/AKEZo5PCXNIgmeZoyI0NZJRsaIVrpe/VADmtKmtUI+/Sfdftdhxy52stkLdupqj6vXPA==
X-Received: by 2002:ac8:67d3:: with SMTP id r19mr5786483qtp.196.1550202442794;
        Thu, 14 Feb 2019 19:47:22 -0800 (PST)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id o5sm2172644qkb.66.2019.02.14.19.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 19:47:21 -0800 (PST)
Date:   Thu, 14 Feb 2019 22:47:20 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>,
        karim.yaghmour@opersys.com, Kees Cook <keescook@chromium.org>,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yhs@fb.com
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190215034720.GA230433@google.com>
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 07:19:29PM -0800, Alexei Starovoitov wrote:
> On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > Introduce in-kernel headers and other artifacts which are made available
> > as an archive through proc (/proc/kheaders.txz file). This archive makes
> > it possible to build kernel modules, run eBPF programs, and other
> > tracing programs that need to extend the kernel for tracing purposes
> > without any dependency on the file system having headers and build
> > artifacts.
> > 
> > On Android and embedded systems, it is common to switch kernels but not
> > have kernel headers available on the file system. Raw kernel headers
> > also cannot be copied into the filesystem like they can be on other
> > distros, due to licensing and other issues. There's no linux-headers
> > package on Android. Further once a different kernel is booted, any
> > headers stored on the file system will no longer be useful. By storing
> > the headers as a compressed archive within the kernel, we can avoid these
> > issues that have been a hindrance for a long time.
> 
> The set looks good to me and since the main use case is building bpf progs
> I can route it via bpf-next tree if there are no objections.
> Masahiro, could you please ack it?
> 

Yes, eBPF is one of the usecases. After this, I am also planning to send
patches to BCC so that it can use this feature when compiling C to eBPF.

Thanks!

 - Joel

