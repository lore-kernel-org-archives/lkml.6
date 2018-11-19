Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3DFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9438520C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W7h9zwi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9438520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405014AbeKTDsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:48:07 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44569 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404158AbeKTDsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:48:06 -0500
Received: by mail-ua1-f65.google.com with SMTP id d19so10974575uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7w9Kd8TLb5sv4+llwhl0uoRnD+tW7dYrfoNydvm5t04=;
        b=W7h9zwi71nRzlhxBZ4zlP2iPnciaCQVgVYQ2GqWYRR/0LAiL8Lnsj1219PEE/qrxUg
         6Qe3VRkPitnMElbvrIUUgY+Zl7LSpyrVStbmylMHGb4hhxpORQVqb1Ef9RgILjiupcF4
         XbQsQudzrRDryGwMgGsYTHViLEBM63+3DfEw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7w9Kd8TLb5sv4+llwhl0uoRnD+tW7dYrfoNydvm5t04=;
        b=KP9GmnPQiJLCxyjA3rX/DZUnP1Ab7xN8bdvH0pFL5bQFj4oU62eN796atZatLB2xeK
         ECM9Ld+AmcFkQnZy27/GEd0mJjy4YSWoPiQbZSz0R8Oduf1RW1MCuc9BoJDy2LA8k7cQ
         RCZQ/FT72Fevnw7MYU8w1EZQJBDlQFOi+3KucBgyCZsKwUl2cXsQ3DQhT2jDUpMGcShC
         e5wTWW2URMY8NSlyCFhZUgPSNpWbKU1u/ml87TmYOHaiVbme7X99TQdMXaIc+NyKKCXO
         KDZzbtWZ3Ey4fHHWiKvGz5s24s8XTG6kjkL8lNlFZhkvNtSHVbXBy0LbEmDFjEXS/uf1
         Lrpg==
X-Gm-Message-State: AGRZ1gJmfK8Ac0iC8yeMQs+AT7ezM82VxoxxxZG2kjYIkqLjYiXX/JfS
        xD1XNIWOWvVvk7NX/L4p7SMEKy0vYq0=
X-Google-Smtp-Source: AJdET5eHWWMU1RYntF/Fr4bpsfZvr76YrsvpBdV1sF0p6809jThARLUHBKwjhP80Xhc3ViBB16G9yg==
X-Received: by 2002:a9f:376c:: with SMTP id a41mr10043660uae.131.1542648222392;
        Mon, 19 Nov 2018 09:23:42 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id t10sm12432735ual.13.2018.11.19.09.23.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:23:41 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id r14so18207777vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:23:40 -0800 (PST)
X-Received: by 2002:a67:da93:: with SMTP id w19mr9746462vsj.144.1542648219867;
 Mon, 19 Nov 2018 09:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20181117031930.24011-1-broonie@kernel.org>
In-Reply-To: <20181117031930.24011-1-broonie@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 19 Nov 2018 09:23:24 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WTqUjivgD=v7u6fZfPt1vG-Dgv4kw7H3GvhMm7B3-vrA@mail.gmail.com>
Message-ID: <CAD=FV=WTqUjivgD=v7u6fZfPt1vG-Dgv4kw7H3GvhMm7B3-vrA@mail.gmail.com>
Subject: Re: [PATCH] regulator: Fix return value of _set_load() stub
To:     Mark Brown <broonie@kernel.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 16, 2018 at 7:21 PM Mark Brown <broonie@kernel.org> wrote:
>
> The stub implementation of _set_load() returns a mode value which is
> within the bounds of valid return codes for success (the documentation
> just says that failures are negative error codes) but not sensible or
> what the actual implementation does.  Fix it to just return 0.
>
> Reported-by: Cheng-Yi Chiang <cychiang@chromium.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/regulator/consumer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I had the same patch in my queue to send up.  Note that the
documentation of the function was changed in commit e39ce48f5362
("regulator: Rename regulator_set_optimum_mode") though that patch
didn't actually change the code in any significant way so presumably
the bug is from even before that.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
