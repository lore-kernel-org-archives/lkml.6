Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A96C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4662154F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="U5Gp1aGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4662154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbeHORU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:20:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33736 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbeHORU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:20:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so1114933ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RpYCJOJBuPI6VUTj/r96n9THMA6NhemNuRpkTH24LUY=;
        b=U5Gp1aGhaKjQ+CTim4xRmXYXcZjDOLgXy6K+aEYmDqV7SPposBwwgpT2tplb0tVu5R
         S70B05GCTQaiJPcISPqzegKzBn635t7PXKMdDEzbQn+8yJ8KxI0hVFSl5BehtE9Eg4bc
         Y6wQ77Egt9S7fKvk9pb5JKlCOqZbcTCWleGrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RpYCJOJBuPI6VUTj/r96n9THMA6NhemNuRpkTH24LUY=;
        b=krn78VRRGrZENDcpA6jIbKg2AR1YJEBVTHiotN5KYMkd85FHB032BzWyQK2Xn6MPfj
         K28mmEKCchMc6HHJ6zsK5Y+kCCHo0Hyh3PQK3h1YcxEnf9mgYS1fmUBSlgK8RVW4K4Mm
         1EAxwbjTo8f9om8YcT+V7LxNdXe2tFBsCl9pQ9KXXjiJTLxPPXAOHnY9upXw9Jtxi5s0
         i3I17w/OZcX0zzJAljTNJUrQtVS7SKX93frRweTwyv2uJyCOtagD58sEXJGz5xpZNIS/
         m04sapXiYeAnwGTO+nIe2/Kt9L6US3CoGFdBjHeTTSl7gBXuIeh6IT8BvM+iP2yTElZh
         sZdQ==
X-Gm-Message-State: AOUpUlG3osrLCcWzaYb4nKjfHi6ACu8IG1RWm5/VTDXqxcW3+tLM/uuF
        J02bWZKWlFRPsYnKK+GMm5IEUg==
X-Google-Smtp-Source: AA+uWPxdL9lQUPCEjbT7XqDhLQvEDyuvtxR929DJoXE5PrrW4gn11Kw5bGAzkMInP+R8vFSaTWu0fQ==
X-Received: by 2002:a2e:1609:: with SMTP id w9-v6mr8672558ljd.120.1534343282158;
        Wed, 15 Aug 2018 07:28:02 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l3-v6sm4559597lfi.36.2018.08.15.07.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 07:28:01 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/3] Kbuild: Some fixdep tweaks
Date:   Wed, 15 Aug 2018 16:27:46 +0200
Message-Id: <20180815142749.18804-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches eliminate two (albeit tiny and shortlived) processes
from the cmd_and_fixdep rule, i.e. from every TU being
compiled. Whether the diffstat below is worth it I'll leave to Kbuild
maintainers to decide.

Rasmus Villemoes (3):
  Kbuild: refactor fixdep to use getopt()
  Kbuild: teach fixdep to optionally remove the depfile
  Kbuild: let fixdep do the renaming to .cmd

 scripts/Kbuild.include | 11 ++++------
 scripts/basic/fixdep.c | 56 ++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 15 deletions(-)

-- 
2.16.4

