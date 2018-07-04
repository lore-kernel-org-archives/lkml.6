Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFE0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E23321757
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3kkqigt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E23321757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeGDO0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:26:47 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:44006 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeGDO0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:26:45 -0400
Received: by mail-oi0-f49.google.com with SMTP id b15-v6so11045180oib.10;
        Wed, 04 Jul 2018 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F5xRe5R/t21dJbdu2rcTwgkJ+h7QmZKAPBui5BjTGL0=;
        b=u3kkqigt1UzBW2UDwcPo1bjFZCSibOl9wavkqi2Y38kHjIeGw25Qda5tgpUSFdoVUQ
         jxmMC+8OZKahsG3ygRM/4zO/HzCPWpNufoUZCd16xjGXZzDVeJZxhX6hhJt1E2D5eYNV
         vjqhpP5dktL7VtjoWHw+WQxcOV40Ne6k0f8ZKrenVUDlLdNhZmmwaiwWtCHcdslD5Apq
         kRtN8nUmXZcZMObAl667mvyH/+A/YNZsHxVguxjh9ZiBQKfWhQ3llGuUHRQceGGiIN4D
         dM7PAsGZx5Uinh/yn4zqTrDTKM0YkRu18wFKpauFZNz4PIT+DJD2mljrrmuD5CZZLtij
         TgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F5xRe5R/t21dJbdu2rcTwgkJ+h7QmZKAPBui5BjTGL0=;
        b=op+XbidYf4kKMzx44qOfS/TDh6eHEUxGOl0vaIgfha+uEmOf/Q/ClEH13G4C21DV3x
         b/TMiVnm/Y9UCNKh1Nbg/D0A3jqSIeyoh4xv1AQUKiielt+mp2Z/rKQXHOolMKg/ndyo
         yg9KuZxL6j7grB0QGwthfF/akALOoU6TwC4ePM6sI7jbXeqNZaieCC7pY21IpyV4CrZl
         5UnBTCK1m4w+XrHlEL2/FmEieSsuZp6XNJCFtvLbOdJiX45/+Rg/EMXMjXoxbCj5e3dr
         owBaANh327GCOrRpE0I980xew9j4WeSOX5mM2Iz45sAdnur0fr4PIei1x+SsFqPGg/Td
         eMXg==
X-Gm-Message-State: APt69E0SPpJH0BSdzLuLqukvivIpNpADg1kjlIb7PunfSUOTNS3Ls7S2
        TIKP0+8bZDoAH+wS8HsUTVgJP0vUixaXQVlAoq4=
X-Google-Smtp-Source: AAOMgpcurhjjBixJt6SJOgm4SQXBlrNEvhCdPBNCrxq/zXN6B4vUoh8KG0ezZIe+X4U1M3sTr8SBFI+EDAVMBYWdWgQ=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr2670052oif.9.1530714404343;
 Wed, 04 Jul 2018 07:26:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 07:26:43 -0700 (PDT)
In-Reply-To: <CAMty3ZCLwqBs46z5TJ+rqtuWA+-ickBf94jrJpy+b-QA1pYGDw@mail.gmail.com>
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180531190659.xdp4q2cjro33aihq@pengutronix.de> <CAMty3ZCeR3uEx8oy18-Ur7ma7pciKUf_myDk6_SpWvxc6DvygQ@mail.gmail.com>
 <CAOMZO5AOpOSAx=L4tOU1Na6hm8Tex3PHNxCYDB81C0+NPHzTZQ@mail.gmail.com>
 <20180703184117.GC5611@w540> <CAMty3ZCWztkM2oEaKQRVmMkA0C1V6b9Oj59DBX9XAWAybZbRAw@mail.gmail.com>
 <CAMty3ZCLwqBs46z5TJ+rqtuWA+-ickBf94jrJpy+b-QA1pYGDw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 4 Jul 2018 11:26:43 -0300
Message-ID: <CAOMZO5BmEZ4dbtm3ZsT86ZoOMj-8oMKOZSmskUJf4n6LGkkFSg@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     jacopo mondi <jacopo@jmondi.org>,
        Philipp Zabel <pza@pengutronix.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Discussion of the development of and with GStreamer 
        <gstreamer-devel@lists.freedesktop.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Wed, Jul 4, 2018 at 3:57 AM, Jagan Teki <jagan@amarulasolutions.com> wrote:

> I have similar issue, it doesn't work.

What is the error? Is it still the LP11 timeout?

Does this error go away if you undo the changes from commit 476dec012f4c654 ?
