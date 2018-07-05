Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A639C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F36F240F4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNjoAjrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F36F240F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeGEH6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:58:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38299 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeGEH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:58:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id j33-v6so679800wrj.5;
        Thu, 05 Jul 2018 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wIMVKDcKmn9q5ut++JsrEmvxXXw2vPlHNgRjmBOmZyw=;
        b=YNjoAjrdQrrt+F1K+Ad/I7Xix6GNJg1AlwClRC4BPw+MmqjO5xHzC4n471Xhe276TY
         CR+bG9Na1zK8W9opCX02s44PzR2Qoc1YDKLE2CTORiXam4QYMGqmTPKLgte1ZFMiTTVl
         V8SrpC0EwLMJ56pwO0OOWWKU8RJy/NBH08LmbefWe+f/hCo/UfzTS97eDarjVjGHhTzS
         zJr4iTcwknjbIfsAX51kVEd/ExzAm6f7u/OquImtA3qxHmtyfULKlDvmNR5a49hmdpLY
         AgEA7dYOED4yTjmSOxxKHqt3Ten1/yagc6TMKPyjHqbWoNiyuYnZt1h1BpOWI7iQeNqO
         IRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wIMVKDcKmn9q5ut++JsrEmvxXXw2vPlHNgRjmBOmZyw=;
        b=O5DGI+2xUnWbko8JTWhlFsxzHhvXG4bjX9qGIoBLYI7hdCsGufSpQt2Upr/AsAPxVP
         OhrtC+ZjYFsHVbIjY7/2UA12KFtoNJqnLBzHIYoT5SbHC5o9YAxmb6xaR9YsZoUJY1Od
         hdEQZMSImMgitMfoujX3dRII8PEPmWkxn1y+orFVmHTluWh5j5JoXHTvuORpgOI7XDGF
         PLJBK0+o0eMIgTw5aWngCenC9VdLATNwwFycl6lUWSgPj7x91qFVrH5XsZsM/XDWsN/X
         l+iRd+oPcgQ0cfrmSl22YJ/x6L2odRdZ8Kc9NGSr79NjXLoiAQJpYVnXIsjJK9Chhx8d
         FkEA==
X-Gm-Message-State: APt69E1ODo3R4njriasi0XhomA4tXmFtDvPXHVkhKYxGWk2kWnKQ9BmE
        WKdtvzCMIf5OdPVxJmyGVxc=
X-Google-Smtp-Source: AAOMgpd0MIiHnhcX1T+TkTSElrPJ2Xe+dWkHxUlrlqTmKHgQMZvZ2GAxIEUvxC/Hm8+GUKYBZ0JUmQ==
X-Received: by 2002:adf:9883:: with SMTP id w3-v6mr4035400wrb.9.1530777498681;
        Thu, 05 Jul 2018 00:58:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 189-v6sm11227952wmy.25.2018.07.05.00.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 00:58:17 -0700 (PDT)
Date:   Thu, 5 Jul 2018 09:58:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>, linux-crypto@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        tglx@linutronix.de, luto@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
Message-ID: <20180705075815.GA20903@gmail.com>
References: <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
 <20180624071105.GA29407@gmail.com>
 <20180624104449.GA20159@avx2>
 <20180625072438.GA19063@gmail.com>
 <20180625131932.sge43esxdb5ejoxg@treble>
 <20180626064930.GB25879@gmail.com>
 <20180626123154.unjji5glpokedwal@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626123154.unjji5glpokedwal@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > So that's still incomplete in that doesn't analyze the 32-bit build yet, right?
> 
> We could do INT3s on 64-bit and NOPs on 32-bit.
> 
> Or, possibly even better, we could just keep NOPs everywhere and instead
> make objtool smart enough to detect function fallthroughs.  That should
> be pretty easy, actually.  It already does it for C files.
> 
> Something like the below should work, though it's still got a few
> issues:
> 
>   a) objtool is currently disabled for crypto code because it doesn't
>      yet understand crypto stack re-alignments (which really needs
>      fixing anyway); and
> 
>   b) it complains about the blank xen hypercalls falling through.  Those
>      aren't actual functions anyway, so we should probably annotate
>      those somehow so that objtool ignores them anyway.
> 
> I'm a bit swamped at the moment but I can fix those once I get a little
> more bandwidth.  I at least verified that this patch caught the crypto
> missing RETs.

Great, I'd be perfectly fine with such an approach.

Also, if we have that then we could re-apply Alexey's patch and switch to INT3 
(only on 64-bit kernels) without any trouble, because objtool should detect any 
execution flow bugs before the INT3 could trigger, right?

I.e. any INT3 fault would show a combination of *both* an objtool bug and a 
probable code flow bug - which I suspect would warrant crashing the box ...

Thanks,

	Ingo
