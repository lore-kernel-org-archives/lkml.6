Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01107C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC633218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWRo+F4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfADXrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 18:47:24 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43616 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfADXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 18:47:24 -0500
Received: by mail-qt1-f173.google.com with SMTP id i7so42153177qtj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 15:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pbKVstMfebZjLb/CGfjfJWNiL9b201Qe6P2FP4LPlQE=;
        b=dWRo+F4WG1gwqjGdfQ2vPjiSHctpLEVPY9JszMm7iaIZ3lBG/0kSCPL6fdF+kuBYLH
         g16VyeC24bkldt9gLeYprOcfLTq/ne3OrGyr76tG4abhRYEl5QcAukMcG4cS5YJ1QEl0
         0z/VKPopEYNjfCqj1fax3gZ870OtpYkxlDvJ5NmL/vUK/0RUw3BtqDks4dp1wFcijNJd
         9sfKN9Ex1ODAZrPzdvmhLPElwE01niXjExWfIiPMiJxGjzJ4HNTvKRTnCllFcrBZZtkI
         pg7nL49vUoIpAl8SPYB1q7yHytor0xk/Fsd7hd6GiDiLAtN5pkke5schKiKI6YNtzL2j
         kk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pbKVstMfebZjLb/CGfjfJWNiL9b201Qe6P2FP4LPlQE=;
        b=I3n1M3iWD2ByIqbDxW0dIFRsnq7a/sQv/VWRal3Bk+dixWzfLEQe3BvkeQUFqwZfXw
         XmCDUeDD9UQ/pNcPkK68OJDJhOxHkXawsKAAfOZeC+nazCl/BchbPHjhZKb0kSrvKOer
         m8qVDHT8BueroQeVQZDnIliD5XQkYnakNtMQI0Ssmghsy8Rem6t5nHngzq3VS6fScljz
         YDTuIEjMOK2xpd5lRbrw54JKxUbvXhc7jDGe+9ljN0kcSYrTv6lxgJ1dUMa350czK7E9
         udhNb1dsaGSpY/7KbS+CEcIeOfaiZp8wiTTEHsiC58ChTj2JJXsWFQoCc6nueN6CUKY7
         2gTw==
X-Gm-Message-State: AA+aEWaFGvkK7Rff1I4plZ0nsmkfzQSvZBM7SzFY8Jc1rUT9JPTvejGl
        djErq3oY0mNoIo3pbY7pRxuxY6zRh/tsldeVez4=
X-Google-Smtp-Source: AFSGD/WdcqITejWgJAaC7irKodmcAV1gwrs3EsZjF9erX+DiWvY/WJtIgZ9d182LPJhJqIPVjBArOyBwuMOaXlMFDVo=
X-Received: by 2002:ac8:35b1:: with SMTP id k46mr52801545qtb.141.1546645643447;
 Fri, 04 Jan 2019 15:47:23 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Kamil Kozar <dkk089@gmail.com>
Date:   Sat, 5 Jan 2019 00:47:12 +0100
Message-ID: <CANMdSOztZu2bsG+g=T-pThiHK9cNaMVq=tvTJ6kn2Tvu4CXJCQ@mail.gmail.com>
Subject: "flip_done timed out" messages causing huge increase in boot time
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, azhar.shaikh@intel.com,
        ville.syrjala@linux.intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
After upgrading the kernel to 4.20, I noticed that the boot time
increased from about 5 seconds to 25 seconds. My machine is an Asus
K53SV with an Intel i7-2630QM, i.e. Sandy Bridge. I have an external
display connected to it via HDMI. If the display is unplugged when
booting the machine, the boot time stays at its old value.
The kernel log shows two messages like this :

[   15.747206] [drm:drm_atomic_helper_wait_for_flip_done
[drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out
[   26.198968] [drm:drm_atomic_helper_wait_for_dependencies
[drm_kms_helper]] *ERROR* [CRTC:39:pipe A] flip_done timed out

Which are the only ones that don't appear in 4.19.2, where the boot
time was smaller. Bisecting the commits between these two versions
leads to commit 516a49cc19467e298d08a404f73a6e311f4548d1.

Let me know if you need more information.

Kind regards,
Daniel
