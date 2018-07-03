Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01593C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB9C22412
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY1DUZL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB9C22412
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeGCDba (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:31:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40040 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932198AbeGCDb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:31:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id x5-v6so283354pgp.7;
        Mon, 02 Jul 2018 20:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fmhlNGqpsms94A+yO4Dz3lNwY65W+QS7UUjovlY4MU=;
        b=ZY1DUZL0iFPZeFA/BALX6GI9QhAoP4Zza1X8co/kYvjz3j8A+VSWajJhy5A5MiiNrb
         uizCY3JwrvO687knnQA0Y6V/Wzexv4IDErBj5Qj3edAAoSwmn0Di7mGj8Dlq0lbiw+Oi
         1K1X9oSQgg2pOab/MuhnisTPW/8QNESlUXsjEi0YzgMMLMgytu4lv476zhspTrt98/cF
         EqQ/7+NicuSdlW3ctqWCAZQAr2y+0pZ4ox9ye0sZNOiL9FLrfTGq0nfaau7ncssLheOx
         MXc34pbYXqtahiYwoNJ0lfolUS1Ey9s+hz4osrM17MiBca8FrV0g2cjULILZLPAM9nTJ
         d8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fmhlNGqpsms94A+yO4Dz3lNwY65W+QS7UUjovlY4MU=;
        b=NRkTNc0sCrV8/Opzoeo8i7AqfFUicCUXqHmfXsP2x6iP+zHpHXwR3jZu9Rtl+JxOkM
         B40PEeBCJ6MQpcm7YRkmy8qn7pcKh6z7WkM7GF/pLnS9Tfpe4l8iz5SfrHcA/uDmnsV5
         x/IqGo4nqNSILoeZf1MDKVFNtBBfuDMNwESnWG1vWPvGUqN6p7DdLvppwv9C62xrszX4
         d+fCF+uS2aT91Nu3Wtvrse8cGx/1NalUclwKmFZmd3iadRUwcObiP/nlcFw4EtAkDlVU
         mwo5T6+KyW89orM4+I1FpsRnPBN15FN5XoDSBCtr5OUBzMXP8AMf5jeWifYKi3EQRDsm
         3Hiw==
X-Gm-Message-State: APt69E38J2f/O4aoA5wBM3D2PhuaPHhIaCVU2oMHKUhxNdheSjDGJzDN
        fD/HgQO3gjMD0vcCPLZuRY8=
X-Google-Smtp-Source: ADUXVKLs39JxmD2qUJUkLpeQ44xTm0/WThU3y51u3ChcmX7Ut4B2BxAVznAIbs9CbWcUWMUUu4NIyg==
X-Received: by 2002:a65:660c:: with SMTP id w12-v6mr23577197pgv.404.1530588689040;
        Mon, 02 Jul 2018 20:31:29 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id q77-v6sm187821pfk.152.2018.07.02.20.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 20:31:28 -0700 (PDT)
Date:   Tue, 3 Jul 2018 13:31:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        stewart@linux.vnet.ibm.com, benh@kernel.crashing.org,
        svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v2 2/2] powernv/cpuidle: Use parsed device tree values
 for cpuidle_init
Message-ID: <20180703133122.245109d0@roar.ozlabs.ibm.com>
In-Reply-To: <1530541401-19726-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1530541401-19726-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
        <1530541401-19726-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Jul 2018 19:53:21 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> Export pnv_idle_states and nr_pnv_idle_states so that its accessible to
> cpuidle driver. Use properties from pnv_idle_states structure for powernv
> cpuidle_init.
>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
