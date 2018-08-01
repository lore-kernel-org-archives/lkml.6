Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA18C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E4820894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DlGwH0Zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E4820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbeHAD5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:57:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40084 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732906AbeHAD5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:57:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id e13-v6so7010097pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 19:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pvviRZ7WwSU3+QBHH80fdvf+GvoZA2Vc4lTRK01495Y=;
        b=DlGwH0ZwWMqXgVyDlh1wLmtHm9Q0Qmq2Lbu3K5n40ablTBYR8jdYxRa6/tKcdg9FNd
         YUOMJ1qixo6IFlfDty2AlFU+kjnTJrm07PCxv15ICaCe7U2YuwSXv2HO/i5NW0vb9KTc
         Qe/9YTtGj+GA2j2AAvCP+Y1h9er8B5PK59avtkysnOMBKmRma30vEVE8SqTnAsxBwh4R
         AVICZLTsWG2Qaz4f9qhJz48n7vR8KOTN4s0tg8Y4sl3I6ydeclTBKpgVcGXZWI4PBohu
         sFvRBuYTtiSvzPcteKdhDEfTOWUpeq3EJsGS7oRUGyMF9QPuhJnncktmhmkEzoiwaIDk
         FxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pvviRZ7WwSU3+QBHH80fdvf+GvoZA2Vc4lTRK01495Y=;
        b=XqxrlT1btp3RTO1bYlrYBCb+WvDO8ZbvjnOTgLytP1fa8CH7s2dYmBPK778QZ2qGM/
         iwkLpy8l5jdngaXGmP5Ae/UOcBzBN841dYZAk1ZIXvKIgunayqB0pdyhJrzNEECdp+QP
         J1aeaGKj1+Ycz+4p6r5/eoGg04hLQco5o85r5Njxryk1pjNK9LNBrIVcCGXB2mm6soDY
         ecJAVEwmHcqpA2u6iuTawHZptYNHv9lTcHtRxmwlnfbSUiVTXnWNS/kw0fizngQGfIoC
         qD6ahl6XOKoTf3niszzqAa9PhXtCvyJcE0bI6gfxiSVI1TbSaBVVDih65ibhDXNg6cII
         tBjQ==
X-Gm-Message-State: AOUpUlESufO+j0aNrKaQLP5XnYA0ozP2Ex+xfyQFK7ZNDEwGZMWoiN8O
        YQyNKO6eTT9IJ0oYW4eQx7myHw==
X-Google-Smtp-Source: AAOMgpdrHa4MZ5LmL70SNkyE7dD50i5ZeqjkwiJv9wo2NLzoYrn0uqvYKLjFx7SfSA3yDrE2u2AHWg==
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr22965319pgm.227.1533089635119;
        Tue, 31 Jul 2018 19:13:55 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id r64-v6sm29328496pfk.157.2018.07.31.19.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 19:13:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fkge9-0006Ui-Lv; Tue, 31 Jul 2018 20:13:53 -0600
Date:   Tue, 31 Jul 2018 20:13:53 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] test_overflow: Add shift overflow tests
Message-ID: <20180801021353.GA31192@ziepe.ca>
References: <20180801000039.44314-1-keescook@chromium.org>
 <20180801000039.44314-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801000039.44314-3-keescook@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 05:00:38PM -0700, Kees Cook wrote:
> +	/* Overflow: high bit falls off. */
> +	/* 10010110 */
> +	err |= TEST_ONE_SHIFT(150, 1, u8, 0, true);
> +	/* 1000100010010110 */
> +	err |= TEST_ONE_SHIFT(34966, 1, u16, 0, true);
> +	/* 10000100000010001000100010010110 */
> +	err |= TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
> +	err |= TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
> +	/* 1000001000010000010000000100000010000100000010001000100010010110 */
> +	err |= TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);

This same idea should be repeated with signed outputs and check both
overflow past the end (<<2) and overflow into the signed bit (<<1)

        /* Overflow, high bit falls into the sign bit or off the end */
	/* 01001011 */
	err |= TEST_ONE_SHIFT(75, 1, s8, 0, true);
	err |= TEST_ONE_SHIFT(75, 2, s8, 0, true);

And also general type mismatch overflow:

	err |= TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
	err |= TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);

Thanks,
Jason
