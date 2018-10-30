Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D21BC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABED20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABED20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeJaIqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:46:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43484 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeJaIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:46:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id n10-v6so6430705pgv.10;
        Tue, 30 Oct 2018 16:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9ezdDz+iHf3FVQkdYu+XVu4WavCz9v1QKbnB9mRvE0=;
        b=sSmdxDaKswFdH8eJGhCZUNajwzkWcYgI2qUgJ6/V7Aupx1uaZxk+1jFELHe2nuklIv
         Bocin81uKZOI0/H4ied1xQ6nO6Wij4ih8xN+XU8GKDkC1ROP9APID7VG00ZCKgFsFS3s
         pEb3E/WpfgBmGGh0VK85RJh+YHn42idx/6FankVZrg6Z3ViCksIUFzAJrnLuVdXI7e2L
         HuUgQqoQ0CmI3G+PMZoW0kC9aXXTIi0/jVZfHZNR0UHdYDtR3X++avcpuun6M5w99kq2
         7L36Zt9RI2OJXjLBz9ir4KNQEBzx6+JyptGRS38rnX6WsXy0mdr4Kh6uvcOkw2LXVRJQ
         beYw==
X-Gm-Message-State: AGRZ1gJbFk4z+DwLZ+A9rEgx4XPH13p38xcMKX6VdryS4obMXMmG7fny
        LrvORehiCH656huqmICIx8M=
X-Google-Smtp-Source: AJdET5ccJTCFhld3gSY21D5EDHPGijUTxOvFVk+wEA0xLOWdYM4q+kZcIHb9M0ykklO+aQSgdgcXpw==
X-Received: by 2002:a63:a30a:: with SMTP id s10mr738791pge.234.1540943446157;
        Tue, 30 Oct 2018 16:50:46 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p87-v6sm16006681pfk.186.2018.10.30.16.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 16:50:44 -0700 (PDT)
Message-ID: <1540943443.196084.131.camel@acm.org>
Subject: Re: [PATCH 0/2] loop: Better discard for block devices
From:   Bart Van Assche <bvanassche@acm.org>
To:     Evan Green <evgreen@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Oct 2018 16:50:43 -0700
In-Reply-To: <20181030230624.61834-1-evgreen@chromium.org>
References: <20181030230624.61834-1-evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 16:06 -0700, Evan Green wrote:
+AD4 This series addresses some errors seen when using the loop
+AD4 device directly backed by a block device. The first change plumbs
+AD4 out the correct error message, and the second change prevents the
+AD4 error from occurring in many cases.

Hi Evan,

Can you provide some information about the use case? Why do you think that
it would be useful to support backing a loop device by a block device? Why
to use the loop driver instead of dm-linear for this use case?

Thanks,

Bart.

