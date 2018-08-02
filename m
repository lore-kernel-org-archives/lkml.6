Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC21C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325E52152A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejSVGXUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325E52152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732583AbeHBQ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:57:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53106 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbeHBQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:57:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so2896551wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=f6F1wJTvM/cY1CCNj4oB3UopwT/JxjrwqzdRy8cS9w8=;
        b=ejSVGXUtQl2zQSW8/V9O8LVn6QXXe3AB2TYK3668PToSu2LalXLFk1g120wrMTM8AQ
         /JkgPXAX4KeTNlTDW+LTVWOMs4JJHpnqd9NimF+EwZTWfO1aXA8qGzuvmge+xfYJnKwb
         mWZezzFcbccX6fuiOrorpUXPGo8EDQPC+KEys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f6F1wJTvM/cY1CCNj4oB3UopwT/JxjrwqzdRy8cS9w8=;
        b=koJYtc94bYs5lMEyaNCV7+djXUoPucWasqRBlJdlL7IiFtuX74td4JR03UciVlG2A4
         pFtq9diSOUX57GgSQ/e9GRJ6dK3P360WFPbJtrpmWD/CI28+CYukEON9CLfv2PzbLYrm
         V9KhU3NTCQLyVj1DTphcasw90ER5+XVVpWwCcdHAc9+V8JHbkHehO3ViNMhnDUg8sCt5
         b+O2N/mks+u3iUK+u2/FjhOJjjZrojW36kzMhJ3Ot66GuYf4uJPNgGIwRQ88kCFiG2np
         xflcQpBoxjAHi8INBugX+inNk+Jrwc7jf0iGN3R3jW9mAyOtDaNEEudhxJvIWXtJ7PyQ
         h0nA==
X-Gm-Message-State: AOUpUlEJeVDnSnHAwJihk399nBhDty42HjizZFOF0kcGB9XArXUx9JCt
        NdD8QVjCUexeYGXDt0ekVeYAbOsh2r8=
X-Google-Smtp-Source: AAOMgpdFE7GSZFRMZQs2lvpMDHq3UFB1/rv/N1/3nmOtPUsw8pwYzRdJFyVLo4g8l10be4W7L3+NOA==
X-Received: by 2002:a1c:b84e:: with SMTP id i75-v6mr2169873wmf.158.1533222352501;
        Thu, 02 Aug 2018 08:05:52 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm2497517wmf.41.2018.08.02.08.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 08:05:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org, stefan.wahren@i2se.com,
        guillaume.tucker@collabora.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] ASoC: core: remove support for card rebind using component framework
Date:   Thu,  2 Aug 2018 16:03:35 +0100
Message-Id: <20180802150338.24538-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM based audio components get registered inside the component framework
bind callback. However component framework has a big mutex lock taken for
every call to component_add, component_del and bind, unbind callbacks.

This can lead to deadlock situation if we are trying to add new/remove
component within a bind/unbind callbacks. Which is what was happening
with bcm2837 rpi 3.

Revert this change till we sort out the mutex issue.

Thanks,
srini

Srinivas Kandagatla (3):
  ASoC: apq8096: remove auto rebinding
  ASoC: smd845: remove auto rebinding
  ASoC: core: remove support for card rebind using component framework

 include/sound/soc.h      |  7 ------
 sound/soc/qcom/apq8096.c |  2 --
 sound/soc/qcom/sdm845.c  |  2 --
 sound/soc/soc-core.c     | 62 ------------------------------------------------
 4 files changed, 73 deletions(-)

-- 
2.16.2

