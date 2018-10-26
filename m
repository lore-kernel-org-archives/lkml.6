Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469B0ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EC72084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EC72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJZX6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:58:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36176 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJZX6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:58:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id z17-v6so698573pgv.3;
        Fri, 26 Oct 2018 08:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJ1QkkvYuevMWoHJWSkHbZ2EZBzIsp25VhHZ2Ne7YA0=;
        b=IfECETKIuE19C/mRfTAOPLL5xXh5TpKlYxBHNxY7vCDRchWGvgpN1plhkgU614A/9i
         L59agRdLvBK+UR4j0TNwaRssHZhSRSZQl7qzw3LPE+NEWUVQDyjImiDUPjB89JtvFN7l
         73k41JWWsolkDc+wEHZJmKzm4GcNnwr6rnKRnbuILdgwYpOHVB5LyZUKjdZo2+G3SRsU
         Vor3DadGesDlUmNFnPM6ElCmZBzHpAZ0RFAhWXg3ujfHnUyTfSTs4nHjjGzzmVuJ5Ewa
         7vxlVmYY9iF9sBsomk706mXhqxhjo8BMPfmRDoA94GvVc7wMMIcTs0jY9jJ07eUJ+oQ1
         5eOg==
X-Gm-Message-State: AGRZ1gKoAGE31YRMNNs/9NQ2VR684N3/HB9rVj52sL4SCA3c8u79vcEt
        Ag3wGW1M3MMfcT0dJPzjnuw=
X-Google-Smtp-Source: AJdET5c3jyZ87tNuoYuwzxj/34/zD1tdSupqhqXGD4v5SZKyz3XaiX29GCc/tD3qVA1jhTeQOGwK5g==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr3931893pgp.263.1540567283520;
        Fri, 26 Oct 2018 08:21:23 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d65-v6sm15668362pfe.42.2018.10.26.08.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 08:21:21 -0700 (PDT)
Message-ID: <1540567279.66186.99.camel@acm.org>
Subject: Re: [PATCH] floppy: Avoid memory access beyond the array bounds in
 setup_rw_floppy()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kyungtae Kim <kt0755@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc:     jikos@kernel.org, Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 26 Oct 2018 08:21:19 -0700
In-Reply-To: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
References: <CAEAjamtxZRiFUYb4re3jRf9naoSyJO7sskChfEgcBh-m-uEKWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-26 at 10:39 -0400, Kyungtae Kim wrote:
+AD4 setup+AF8-rw+AF8-floppy() writes some bytes of array cmd to the floppy disk
+AD4 controller, depending on cmd+AF8-count.
+AD4 Although the size of array cmd is fixed like 16, cmd+AF8-count can be much
+AD4 larger through raw+AF8-cmd+AF8-ioctl().
+AD4 Noticed there is no bound check for this, thereby leading to invalid
+AD4 memory access.

Against which kernel tree did you prepare this patch? Just above the code
you want to insert I found the following:

	if (ptr-+AD4-cmd+AF8-count +AD4 33) ...

Why does that statement compare cmd+AF8-count with 33? Is that comparison correct
or not? Anyway, I don't think it makes sense first to compare cmd+AF8-count against
33 and next to compare it against 16 ...

+AD4 +-       if (ptr-+AD4-cmd+AF8-count +AD4 ARRAY+AF8-SIZE(ptr-+AD4-cmd))
+AD4 +-               return -EINVAL+ADs

This comparison looks suspicious to me. Almost every comparison of the type
+ACI... +AD4 ARRAY+AF8-SIZE()+ACI I have seen so far was wrong and should be changed into
+ACI... +AD4APQ ARRAY+AF8-SIZE()+ACI instead.

Bart.
