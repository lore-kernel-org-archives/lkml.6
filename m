Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3854C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613392086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WXwdWzVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613392086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeJPSDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:03:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44743 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPSDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:03:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so20714259edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7uNAYnPgtJw6+YBx+gk0ePVXOLp/I6yrYK+l3EJU2jI=;
        b=WXwdWzVHTGMCY4OXxsMyFnMLS9XkX5c0Gn+uXZwToIQLIygL6KW4tQkAYZRpfUXU4E
         ZtH9Voup2uDfcTjnx8ToO4esR/HdpDZ+fvG/ELfNuSiGVd98XpzyzPohqUN3FsKzNEB6
         U7BNsoD7zxMEAJjDOGEkFiGocWInwsFwlJwYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7uNAYnPgtJw6+YBx+gk0ePVXOLp/I6yrYK+l3EJU2jI=;
        b=LErI+WTp3S9xuS4uJG/5U6vWcmyYQgC2UlID1ZX1cEAWnyd+G6wliRyr532hEDzXRS
         3/OS5A6VhNE3OcU5ba0T163oPlk2uAOtzB5/TRJ2GUcR4DD8ZFSnYeGSA/WRBW5ZVuhl
         u7g07z2U8y7VEwu3UNZyD5LGqlgWXuhAeWQE7Va/i0rfyrmGmGYg4U0UbiDdMpGf5wBu
         sFNpS++GV+sTj75G+Zq+eklSHAxwcSN4MB0rxIe0Jmmi64AWtkqi5jSrmWbB6qdfnLCc
         dge3qTDJFjxjQPA9skun0HXFFjaqHC1qYpvB1IxUpQuUDx0f1NrHv6AVd8BseVydqb5J
         p33Q==
X-Gm-Message-State: ABuFfogBpLlFZ4vvqCQHukd7RWQeQsaxaJ8AwFQl11J4snonpjwiA1uE
        oePRmfsGB3OzwL7MDFu1zjb5NaPVSTw=
X-Google-Smtp-Source: ACcGV60fWXSgBJigXXwOwhW30R5OH/I8FemFRQDVk/qfVRUPcavLduDklSmhK/0Np4QzIESMRs0f5Q==
X-Received: by 2002:aa7:d3d4:: with SMTP id o20-v6mr29283648edr.193.1539684829534;
        Tue, 16 Oct 2018 03:13:49 -0700 (PDT)
Received: from [172.26.255.55] ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id r55-v6sm7780646edd.80.2018.10.16.03.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 03:13:49 -0700 (PDT)
Subject: Re: [PATCH v6 1/1] ns: add binfmt_misc to the user namespace
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        containers@lists.linux-foundation.org,
        Dmitry Safonov <dima@arista.com>
References: <20181010161430.11633-1-laurent@vivier.eu>
 <20181010161430.11633-2-laurent@vivier.eu>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <97280bb2-933e-9281-bd91-99748e1dd653@rasmusvillemoes.dk>
Date:   Tue, 16 Oct 2018 12:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010161430.11633-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-10 18:14, Laurent Vivier wrote:

> +	/* create a new binfmt namespace
> +	 * if we are not in the first user namespace
> +	 * but the binfmt namespace is the first one
> +	 */
> +	if (READ_ONCE(ns->binfmt_ns) == NULL) {
> +		struct binfmt_namespace *new_ns;
> +
> +		new_ns = kmalloc(sizeof(struct binfmt_namespace),
> +				 GFP_KERNEL);
> +		if (new_ns == NULL)
> +			return -ENOMEM;
> +		INIT_LIST_HEAD(&new_ns->entries);
> +		new_ns->enabled = 1;
> +		rwlock_init(&new_ns->entries_lock);
> +		new_ns->bm_mnt = NULL;
> +		new_ns->entry_count = 0;
> +		/* ensure new_ns is completely initialized before sharing it */
> +		smp_wmb();
> +		WRITE_ONCE(ns->binfmt_ns, new_ns);
> +	}

If ns->binfmt_ns can really change under us (given you use READ_ONCE),
what prevents two instances of this code running at the same time, in
which case one of them would leak its new_ns instance? Also, there
doesn't seem to be any smp_rmb() buddy to that wmb(), I don't think
that's implied by READ_ONCE() in binfmt_ns().

Rasmus
