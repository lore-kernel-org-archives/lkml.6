Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3A220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3A220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeLLOZv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:25:51 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:46458 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeLLOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:25:51 -0500
Received: by mail-qt1-f180.google.com with SMTP id y20so20583163qtm.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 06:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vU/yUexu1CsHnx9wDhHHrayCuiSjyGBloT6TQP9FbVk=;
        b=KcHtl6+2maq/ZFPaoHnECIAtzP+TPgBO/wlGF0OvYnsnJufQvalHWg+8Bd5STi2pQb
         bSSU0en7oz74eA0QaoLANxqEl3TbKcdI04U1i3j2QsgPvw2VgLfnzqrJ1CrcKC+JmXdE
         fNnpnBNrTOa7kuYqOgU6RZ/t0VQmDGHkHVZzT3TFP5tIQlG+uQqaEyhqsNxYvXD3z8f/
         rYff7yFbEo5pdtuleDIlpF6hzHEDNAuH1uc2HHY5B32XGaqmctEuj+S6az+0FUeqfuuq
         jKGZpw3I4KIPu3erZ5e0Vrf7BjcEwcYzuuhaG1WP9TGOyLay72OP6mddZc6n28Elvula
         /quQ==
X-Gm-Message-State: AA+aEWabcEO4Jztka70KjtI4Xw/QBpJrV4TCOllonZgoZRaHaQZNx5mj
        nJtUs/f+o31CKAV6qaFP5QtiS3XowXozCTZc+P1BJQ==
X-Google-Smtp-Source: AFSGD/WXfuCUEfWqknXmsM60n1B5YobrcTaG6qOD86cJil93TDSiiV1llPknDe4z1E5VxohnENV17SiiM/6lsIqYLoE=
X-Received: by 2002:a0c:96c9:: with SMTP id b9mr18479485qvd.238.1544624750166;
 Wed, 12 Dec 2018 06:25:50 -0800 (PST)
MIME-Version: 1.0
References: <6E2F161C-046B-4D5F-B831-B1308A554C40@canonical.com>
In-Reply-To: <6E2F161C-046B-4D5F-B831-B1308A554C40@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 12 Dec 2018 15:25:38 +0100
Message-ID: <CAO-hwJ+fshPj7xbJoBvK8uGrhfKCdFSmzicmmOyMJS0cdzAapQ@mail.gmail.com>
Subject: Re: Elantech SMBus support regression
To:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for the late reply. I was always meaning to fix this the proper
way but couldn't dedicate a full day of work to go to the bottom of
elan_i2c.

Meanwhile, I am thinking at simply having a blacklist of devices that
we know are not working well (P52, L480, L580 and P72).

Could you get the value of /sys/bus/serio/devices/serio1/firmware_id
from all of these laptops?
I know the P52 is LEN2131, but I don't seem to find the other PNPIds.

Cheers,
Benjamin

On Thu, Nov 22, 2018 at 5:22 AM Kai Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Benjamin,
>
> It appears the Elantech SMBus support breaks some users’ touchpad.
>
> Please have a look at [1] [2], thanks!
>
> [1] https://bugs.launchpad.net/bugs/1803600
> [2] https://bugs.archlinux.org/task/59714
>
> Kai-Heng
