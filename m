Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0424BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC21214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcOifEtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC21214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJJOkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:40:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46031 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeJJOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:40:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so4404671wrw.12;
        Wed, 10 Oct 2018 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDkf9ydA4tV3w9hXNhB0fao345XSfMJR7wTVa1zjQLw=;
        b=dcOifEtlMFG/xkeN8UH25OCR9WOtrq+lxICSeGE/XjxgvQmq+5NMHOCrWlIwd+dADO
         Nt76CiCJJzaBmWDvgciFZxC+rs3jF5wzjJmD+4FSbpavRnJc0Z65B+ktJwLonbFRJkfp
         dNswUL7rMiXHVJjAL6eV+bgwZ3pkwK0QK8B7FPM3HYvKBj5peDcP5yE+56ujFhVZ774N
         zdUaGF86AeJ3TVQD3kambD5YwHcHY9VJfe8vIGKD5N/FR5STrvpHNEoP0tZYYZj/4JZw
         IVZfrUr013j70ufwqeEBNF+Cm7i99st++SQzYWfu3cwskzNyi0WG2Vs2qFyK6ynRxaK+
         WlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDkf9ydA4tV3w9hXNhB0fao345XSfMJR7wTVa1zjQLw=;
        b=TVIcaTMudMpNMrekuVBGx7qWKdia52MtL7Wj2IAlc6/t4rYqINbRYMZLMcnlWEzkke
         Yxfq76o7fAJSSSdK7wR4t9NtyiLpizJ9U9mBmWG9+9f7VnYWZNV8Nid+h/aH25UigpXE
         fzN7DDA7K2OgaVkv6yjszt6lzQA7BQdslhRoJOfQLrDCcZJSjIBzw7bRQI8k9GLQZg4k
         HwGX+5DHzlE1+Z98c8dD4FcJYoYfjp2AvHw4VyL6703+7/XWIklGBgqMu4GrB23bhY3C
         fvH/n0C5EJdbl1rG8WCIGwAecX5ycQBMQG1bEoyCxaKtyIwEshifSo6aKXFeAlDsBR+K
         kPFw==
X-Gm-Message-State: ABuFfojncuiFy4hmn+qzZ1n8VnkF5rH2UMGN6mgIGzdyAuSpOS4ooCT0
        mOyfPYsLeNrNdqS20DdiOGg=
X-Google-Smtp-Source: ACcGV60w9DJCPGv1G2FwDh4IX67uaWSwdnYFcSBDU+PaCY6Q/vdMaRSn8AUBAgV070xJKK0kJZ9ieA==
X-Received: by 2002:adf:db45:: with SMTP id f5-v6mr22802350wrj.237.1539155961782;
        Wed, 10 Oct 2018 00:19:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x139-v6sm27452707wme.3.2018.10.10.00.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 00:19:21 -0700 (PDT)
Date:   Wed, 10 Oct 2018 09:19:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-doc@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, corbet@lwn.net,
        boris.ostrovsky@oracle.com,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 0/3] x86: make rsdp address accessible via boot params
Message-ID: <20181010071918.GA103159@gmail.com>
References: <20181010061456.22238-1-jgross@suse.com>
 <20181010062352.GC37224@gmail.com>
 <12afa65a-9e07-bb2c-5621-85074ea37135@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12afa65a-9e07-bb2c-5621-85074ea37135@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> You can just dive into the discussion we had back in February:

That was half a year and a thousand commits ago! ;-)

> https://lore.kernel.org/lkml/20180213163244.j2zuxyhs4kbfhwgj@gmail.com/
> 
> The scheme I have used in V5 of the series is the one you agreed to use
> back then.
> 
> A quick summary of the problem you mentioned:
> 
> There are some downstream variants of grub2 with a patch breaking the
> boot protocol by writing garbage past the end of setup_header. Adding
> a new field at the end of setup_header (here: rsdp_address) resulted in
> those grub2 variants clobbering the preset value of 0.
> 
> The solution is to let grub2 report back the used boot protocol version
> with setting a flag "I am reporting back my version". The kernel now is
> capable to know which fields of setup_header are known to grub2 and can
> act accordingly.
> 
> The related grub2 patch series is under review right now.

Ok, that's reassuring - that's all the context I needed.

Would it help grub2 review+integration if we applied this to -tip and staged
it there until the Grub patches are accepted, or can I consider those changes
as grub2 upstream accepted?

I'd like to help make it happen, let me know what the best route is.

Thanks,

	Ingo
