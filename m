Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F30C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B4021470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="G4Tjuopy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B4021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeJDPYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:24:36 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:41447 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeJDPYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:24:36 -0400
Received: by mail-qt1-f175.google.com with SMTP id m15-v6so8942334qtp.8;
        Thu, 04 Oct 2018 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Etw5AdVS0moKLKdBsJGLIrgK6JI8wkHFQHItlrPBIjQ=;
        b=G4TjuopyKXCp03SqG6zC4UMMyX16aobxSM3bi5YyHYuVNigaIkCCO5IDby4SnFsSW3
         zkePxKM8XQquC0KSKkVg/zh13fyYJfP+QvUEPvVsRjtZ9S04ybcfEXdlRvkpFFEbPTt8
         EgZp5Fq9Ked0bXRi+6oCrCgYo7klL3AsKdddU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Etw5AdVS0moKLKdBsJGLIrgK6JI8wkHFQHItlrPBIjQ=;
        b=byBg+julGH0ciffWRePgXFV4vZn6u01oKqL4p6k7gSBVB7AS+Z34CR3/f6gTRRZkpT
         eMVwYKe9ZZ5LJ4AqzFhoYYhI3v2TpVNnrTqZt5gm+tIR/2SRkeshPwLNMGgv9H8b0Grd
         HZrShwR/3iJ6ChLYekj/CKF/l3t6ZOtTUpsdnKTtyNf6S0CGND9hjkzffCQhPe9m5XJ6
         XykdcfOp+y1Cw1OlHu5UCJmK/fJg7xMqPLbBr48Xa1GPevqYjQ2L5eBOGrUgemIRWJfg
         XwlOV5dDcLPLl3ZXBWXGq8BqxB5nOnUmuy6NqrSOn1BiqT2tm7Kdcmn/2dFj7OYa6J7v
         mI+g==
X-Gm-Message-State: ABuFfohFuUHub1C3NArcJvKOpsXdMek/9cxoZgqw1MncSUcvHIq/2dCe
        icUN4/m1Va4RE8zdoJYkKVktX9pZACpbls/S0AI=
X-Google-Smtp-Source: ACcGV62Tlywvq78my1oaDC8caZsVv0HGfxDv4AtuP35v19CHOL4acuIesZyuTFSVArhLO2THBo+xgmcqFQDyOksyd8o=
X-Received: by 2002:a0c:d032:: with SMTP id u47-v6mr4464538qvg.245.1538641948330;
 Thu, 04 Oct 2018 01:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com> <20181003223107.16133-5-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20181003223107.16133-5-jae.hyun.yoo@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 4 Oct 2018 10:32:17 +0200
Message-ID: <CACPK8XdTMfdw1Tu97oD7R7MXQKGHnA5A+SVfAA3RDkiTd_bawA@mail.gmail.com>
Subject: Re: [PATCH i2c-next v5 4/5] i2c: aspeed: Remove hard-coded bus
 timeout value setting
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018 at 00:31, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit removes hard-coded bus timeout value setting so that
> it can be set by i2c-core-base.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
