Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02D3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF2A2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK2VKXZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBSE2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:28:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43468 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfBSE2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:28:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id m10so90373plt.10;
        Mon, 18 Feb 2019 20:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Flg/+ZfQEFy9WlcVKcsTaAYK8RQK8eswjMJOnTsSPHQ=;
        b=iK2VKXZk9fZNY0CvUxqjx1itRIiafqAaN9Ozx9irtTjYn19o/m3WeQH0AbBEnU55ra
         j7QQOMPVP40UzjM1TNliWOyD7jH+5qmZGhHP/I4SHdmPI7YQ7uFoXvACfaveI+J5/Irp
         9nPXfuF1s5jPBqq9ynckaweQHlzEFxUFBCfTWCD6iuPLI8/0xF4y3kcv0x8F1mBScWZz
         TgJlzqpSzZvmr0Pm8/2HsPyOxoMGDU5hA8a3iSE3++9uX82d/Na7Qblbq5VZgjW59CYZ
         DqjFH5nxdTW131Vbbu6BGKJrfiP1opzeX7htzfyzp9VQ74cZmEA+geeGN/hgRo9N8+KV
         QCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Flg/+ZfQEFy9WlcVKcsTaAYK8RQK8eswjMJOnTsSPHQ=;
        b=YVd/w20H19DHHvXYb9tVCZCqyg6sx1poIPvi/0Mj3BimUpAnJ9fQcNkGIKtmQ1fRD3
         3ZSkOYsD2Wf5OiIbZRIVPlbW/+FbOJ9WfiNXAPPsT6oLyOQtHZuUF4LU8IDvUUpJrMUY
         OWBZCGO7ITaMsqCGSahoDn4FHKC4KrmDvAd9w+X42rpCuf9geem3bON7bxAhVtZklsYG
         /RZbgElU6lm83N/getD8XG6RZHFmC/98jvirkZMdWll2hu/Zoobu0siqC4nmCAak/XS5
         r7N5axMhM97w56LEfX/wzwEfsiSQBhsfM1CY9j6iFwhbZJyKSFuevOnQH44rgfYhgeFx
         yRRQ==
X-Gm-Message-State: AHQUAuYQyhesUlfbpjjp6/xA9YY3F5/jXJ1VmIeXebg0w06ZEHGdNKMH
        jUIQaWyPW/OKC7IY8SUyrUM=
X-Google-Smtp-Source: AHgI3IbAahr+qJ/YOmTInMfd2VLO9rrXaCw/NDyM5HwBBi4HN67Wt7aT363XbV/K9m93FNeH6VAh2w==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr29610458pld.184.1550550528778;
        Mon, 18 Feb 2019 20:28:48 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:a364])
        by smtp.gmail.com with ESMTPSA id c5sm26008703pfa.40.2019.02.18.20.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 20:28:47 -0800 (PST)
Date:   Mon, 18 Feb 2019 20:28:44 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190219042843.x4rf526x4x6dprli@ast-mbp.dhcp.thefacebook.com>
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
 <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAThSm1n1B_Ss0gRDZ3H-DWj2bvpZ+6Ui2jEo4Pt9YynEA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:14:11PM +0900, Masahiro Yamada wrote:
> 
> I was able to compile it in-tree
> but it makes the incremental build extremely slow.
> 
> (Here, the incremental build means
> "make" without changing any code after the full build.)
> 
> Before this patch, "make -j8" took 11 sec on my machine.
> 
> After this patch, x86_64_defconfig + CONFIG_IKHEADERS_PROC=y
> takes 53 sec for me since kernel/kheaders_data.txz is regenerated
> every time even when you did not touch any source file.
> 
> We should take time for careful review and test.
> 
> Please give me more time for thorough review.

Thanks for taking a look. All are very valid points.
Incremental build is must have.

