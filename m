Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F01C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E2620841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKiQZpZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E2620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJIFSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:18:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34188 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIFSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:18:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12-v6so21527689otl.1;
        Mon, 08 Oct 2018 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uu7g0rxS0TYcE4wHo7x3IOjoXGAMpnDjSqud//QPvFE=;
        b=DKiQZpZMK+t3Cbg9Q/q0xjOJoGhMfUx5E4ETayRYOxCqMH0wQS2mQuPFix3PL57QZ3
         b/77bjH453Vl0rDcf7lK6ZITOJ/ZaXWan363dKVcs3nmm1tVAc830nKF3sY7zr1KmKSJ
         383llQQjI1CoDDnsdQynkrdN59io0xaZPT570agKZ7TuTEDT4kuloNafW/KDVlnxWSp0
         LQcKVfyJKLrjubQwoYt/AcHed8GfTwbb2GRNOG75lJdUPYnGnG/tANVg9tRwwJjAZFDZ
         /x5EKcmB5WwTQcMXT1llq9mgrmmM8LoKk3PiWSqtTdObQJO/T3q5ClZbYqJxFa2OO1wF
         Nz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uu7g0rxS0TYcE4wHo7x3IOjoXGAMpnDjSqud//QPvFE=;
        b=JutWw0cAO1S4HStqBKbS63Z0AuV6JILW3pnRqk31dyBKJezWClmnaaGb4z/hSAtESs
         r1DH+WbTrMWZwDotouEsiOPp63UOQGXji0mDhBnE2WKq6JvzKQJW7TSpMOiJGb1RnA8h
         n6YpF4kp9SmuuQLrXUsBrTTHE5i1J4AUr0nQNX+TxVXylT5QMF8fg65626VR1Iwo++lK
         9uc8+n3r9Pgw7R1EsnsgYaKdFTHJzKprLrixHPRm9/MddJJHBN+iNZV37HKBSx8AWQJ7
         aQtup4ZEVC6aHFn7IPW90c1B4D1ZdD7O0qirSAilrAnVhOKiv/bn/ulhkCMZMTECwDUc
         DypQ==
X-Gm-Message-State: ABuFfojzcKtw6OtMYeStalh/BHyJ50V+wAvy6NNw/n34E9XAu1yXwdJJ
        urqOcF1iqDJZ23Ox2xz8G2DLk6k5R/dFvZPrpMc=
X-Google-Smtp-Source: ACcGV62/GFhy/GoIrCs8/fw6ff27lcc/5Ql34u6GIppYAKGh9PVnutwpvvQV2KDfHPEvBg/L726GFEWjKu0BWSFGJ2M=
X-Received: by 2002:a9d:7d06:: with SMTP id v6mr6719105otn.196.1539036290286;
 Mon, 08 Oct 2018 15:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181008220227.vbn4wzi34n577yyg@renatolg>
In-Reply-To: <20181008220227.vbn4wzi34n577yyg@renatolg>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 8 Oct 2018 19:04:45 -0300
Message-ID: <CAOMZO5A7zW9FPOmqNBVquj2ysR6V3kok3RXsbUuCfg1WjvAjeg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: adt7316: fix parenthesis alignment
To:     renatogeh@gmail.com
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Renato,

On Mon, Oct 8, 2018 at 7:02 PM Renato Lui Geh <renatogeh@gmail.com> wrote:
>
> This patch fixes most "Alignment should match open parenthesis" check
> warnings found by checkpatch.pl in the addac/adt7316 driver.
> ---

You missed your Signed-off-by tag, which is also reported by checkpatch.pl :-)
