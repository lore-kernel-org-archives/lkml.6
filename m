Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC0ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341B22086E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jILwH7H/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341B22086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeIQAaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 20:30:08 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52476 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeIQAaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 20:30:08 -0400
Received: by mail-it0-f67.google.com with SMTP id h3-v6so8528587ita.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vnHN2N+iFyb6CBh41tRctbH6AFOCp5gQpiUJ2i4aFi8=;
        b=jILwH7H/cNgpjA+uRSg7uElplQv+eF+NT/r3iVeTPKGEQ2EzVq9IOvO/Flk7nnduw7
         ZE9LAEBmekziZ/Kv3R+i9YeApvwKy+k6w1prXKgVX2ehcz7ovUTHOJYEahsqi6Kp+N4u
         eVDSwQVsCbQdyBFrFnO7hjvZtKwmq6Wbyhjks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vnHN2N+iFyb6CBh41tRctbH6AFOCp5gQpiUJ2i4aFi8=;
        b=N6zlzFRTulUa9sK3uzzu+cIYWZm5/rSBQes68o/SLQ2VguxmalXvtvcJ0wXuYSEYqK
         N6kfL/ImT7Vw1rgIdGkBusf4oopBNo64Az5txUHWpc63t41kX5yo4bOaOvhXj9D31KFi
         eE2J/4zC35NdT1qDYvzlaM0lFidmJ+RR+BT8tYAGOTOky1t4hsysL+QPwab9iNM3mlr4
         uAsK5JibFXxTznU9WosL6lp3IzFSVbBVmu+wVO9uJk2+gHCfpQX+yW/BrP8l8/ttk8Ur
         rZpzrHY1IcTe/lRO9F0EWmfO2G7UUmXKGqA/ueS6PLjF/TYD8Q221FbKlJMo29LiA89n
         6ciA==
X-Gm-Message-State: APzg51Adzdbsk3glafBzsIc+ATp0JAXcsddgD+R04IlVQ2nfbMUcyaq+
        Cu2b9t9Y/0Lm/zp0fxj1JMstpg==
X-Google-Smtp-Source: ANB0VdZij05kDseCG6zivOWk4/uvGQbR8Ah2nkPUbz5tw3lFyU34d+uB7BNLfeNHY4p9MbGheNClYg==
X-Received: by 2002:a24:f846:: with SMTP id a67-v6mr10165728ith.13.1537124773731;
        Sun, 16 Sep 2018 12:06:13 -0700 (PDT)
Received: from holly.lan ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id o8-v6sm4632636ioh.56.2018.09.16.12.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 12:06:12 -0700 (PDT)
Date:   Sun, 16 Sep 2018 12:06:10 -0700
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, stable@vger.kernel.org,
        me@tobin.cc
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
Message-ID: <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
> On a powerpc 8xx, 'btc' fails as follows:
> 
> Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
> kdb> btc
> btc: cpu status: Currently on cpu 0
> Available cpus: 0
> kdb_getarea: Bad address 0x0
> 
> when booting the kernel with 'debug_boot_weak_hash', it fails as well
> 
> Entering kdb (current=0xba99ad80, pid 284) due to Keyboard Entry
> kdb> btc
> btc: cpu status: Currently on cpu 0
> Available cpus: 0
> kdb_getarea: Bad address 0xba99ad80
> 
> On other platforms, Oopses have been observed too, see
> https://github.com/linuxppc/linux/issues/139
> 
> This is due to btc calling 'btt' with %p pointer as an argument.
> 
> This patch replaces %p by %px to get the real pointer value as
> expected by 'btt'
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: <stable@vger.kernel.org> # 4.15+

Would a Fixes: be better here?
Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")

No blame attached to Tobin, but the fixes makes it super clear what
changed and why this breaks kdb (which was not explicitly called out
the patch description).


Daniel.

> ---
>  kernel/debug/kdb/kdb_bt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
> index 6ad4a9fcbd6f..7921ae4fca8d 100644
> --- a/kernel/debug/kdb/kdb_bt.c
> +++ b/kernel/debug/kdb/kdb_bt.c
> @@ -179,14 +179,14 @@ kdb_bt(int argc, const char **argv)
>  				kdb_printf("no process for cpu %ld\n", cpu);
>  				return 0;
>  			}
> -			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
> +			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>  			kdb_parse(buf);
>  			return 0;
>  		}
>  		kdb_printf("btc: cpu status: ");
>  		kdb_parse("cpu\n");
>  		for_each_online_cpu(cpu) {
> -			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
> +			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
>  			kdb_parse(buf);
>  			touch_nmi_watchdog();
>  		}
> -- 
> 2.13.3
> 
