Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C02AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C5122419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPJFXIyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C5122419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbeKMGkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:40:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33640 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMGkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:40:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id f19-v6so9699871wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=duKWO5VKJPJgWScnPSfDuF6Y0cBlEnRFNE5HynVc6k0=;
        b=JPJFXIyZNUemMFrMMuwtE4ZLxxpwBb5r5wJM2wnQg4z9RkK/db21+mKlQ0ybl7fYW/
         o6bIwypRb7HycLBotHW5UZqjOh+oj2mr+vMxvbtmjo5jYfB8kHPzVIdUuQ8er5gwm9TS
         8zfnLesjo8heQK+ctIOVNsRJ6G1X9eFcbS3aGjP13Zh9RjbMOXtZ17jX/Ec7mCtrfF4J
         Rn0ob7OQRuQWo+YZPeIKRzsoo90zQU8bsj2STCuokCzoFW6862bVreKSuSGRPRTxRHTw
         Kt5Y1/bNMXxGlUzhCOqTQL9QxF7m2d17lDjWSRYaHW8bftuTeorKJTG4f4wmUuGmWo4W
         7VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=duKWO5VKJPJgWScnPSfDuF6Y0cBlEnRFNE5HynVc6k0=;
        b=jDAIEgbEWhgs+F7IhkDxSj0FOx5cYLxf1haaHheykMb+5a3efdTU5T/1rF7UP5RSXC
         TgnINkObTmINmk3Pi8RLyaAerYcvYH6xIqjWjOsXcU4gli/h3Q5ioL1Unj+tPFxNjgfv
         Okkbl/z7fckP8s4Bsy/xwNaFG4Yc3t56kueLTEh3ENI+KcBqRDDBTNPbf0JOlRnIjXxu
         vIGlDl9+iKLNRlQnpwq57Y8kp2ol7gijfk+VHAm7AUc+Dlye97p5q7Xx0M6ykeLjzkSN
         1fMkEmrZCYyrj19xqyMyO2PotNxBXYQVRaCjMMHXRHNoYtVM8lTdEqH8hG/dZSlLSlcK
         +fZQ==
X-Gm-Message-State: AGRZ1gJaHISwbNLyNxuAGLMhOmDaq635n+/Sg2/n+jPhsTTCigwDTQzj
        0lA63S1gVohjczbwC2bC3Is=
X-Google-Smtp-Source: AJdET5fQkWFSvXmsehW30+xiJfOyd6KpGSmVfbRYO6375ZGWsqjgbvYwp6k948gMpRcWcI6PSVzLwQ==
X-Received: by 2002:a1c:730b:: with SMTP id d11-v6mr933340wmb.107.1542055520508;
        Mon, 12 Nov 2018 12:45:20 -0800 (PST)
Received: from localhost ([95.239.98.134])
        by smtp.gmail.com with ESMTPSA id f18-v6sm9606355wre.57.2018.11.12.12.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:45:19 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Cristian Sicilia <sicilia.cristian@gmail.com>
Subject: [PATCH 0/3] Clean up some syntax issue on unzip_vle.c
Date:   Mon, 12 Nov 2018 21:43:56 +0100
Message-Id: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will do some syntax fix on unzip_vle.c file.
The first patch will produce the removeal of all comparison
with NULL constant prepending not operator for equals comparision.
The second patch move the constant comparison to the right side.
The third align some parameter with the previous parenthesis.

Cristian Sicilia (3):
  staging: erofs: unzip_vle.c: Replace comparison to NULL.
  staging: erofs: unzip_vle.c: Constant in comparison on right side
  staging: erofs: unzip_vle.c: Align parameter to the parentesis

 drivers/staging/erofs/unzip_vle.c | 105 +++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 52 deletions(-)

-- 
2.7.4

