Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC180C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D57221479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D57221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJIWRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:17:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38784 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:17:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so945134pgq.5;
        Tue, 09 Oct 2018 07:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nq9GZPvKr4eCvweILtRVPCKDQEyys82xvpkFAbURPuk=;
        b=EULj8COzprlJYEpbqnqJCYpRA2GxWSSoqX2ub7PKDg75qYHJ6JHrMjx4zjKbp29i0c
         8ND0Q2xX6Fg9I+Sj1NGICCAoYBtslG0HND9wRbQM+TTnmUmZHbWuR2ohTBhAhutyaIVh
         DC4MjpkieEAXVvadTQNHyz61zYoCgL8iKN5SE44zb1+h2brr6NtyeiM3Dg6UEyF4munJ
         93oH2TVCFnU9CrcZSIYvpxE6UKazbZV+gSJ9JdmsoqRqe7aJspOd+LCpBiDtiXHh8TJJ
         X++FrKqJA5dadeGitniOjj5apac2DQdYn+R/us7yFnqhf0EZ6pzdj2POvYwdA1hjx5QR
         sLuw==
X-Gm-Message-State: ABuFfoh2n9igFMy4S/qaNCwUVG4V1v7uXbdRsB8HdzHe7v0LftKKLfB+
        QcO2t1RswmaQ3N+v4vV3IGQ=
X-Google-Smtp-Source: ACcGV61Ho4S+AM6FMbTDsHgGjj2y4pLOolIdDjB8+lgF2EVafYiogn3dTtcsLZ9ddxI+ZS4xsBqPqw==
X-Received: by 2002:a63:e05:: with SMTP id d5-v6mr25843252pgl.272.1539097193611;
        Tue, 09 Oct 2018 07:59:53 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o76-v6sm32462734pfi.162.2018.10.09.07.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 07:59:52 -0700 (PDT)
Message-ID: <1539097191.64374.44.camel@acm.org>
Subject: Re: [PATCH v3 03/24] drivers/block/z2ram: use ioremap_wt() instead
 of __ioremap(_PAGE_WRITETHRU)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date:   Tue, 09 Oct 2018 07:59:51 -0700
In-Reply-To: <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
         <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-09 at 13:51 +-0000, Christophe Leroy wrote:
+AD4 +AF8-PAGE+AF8-WRITETHRU is a target specific flag. Prefer generic functions.
+AD4 
+AD4 Acked-by: Geert Uytterhoeven +ADw-geert+AEA-linux-m68k.org+AD4
+AD4 Signed-off-by: Christophe Leroy +ADw-christophe.leroy+AEA-c-s.fr+AD4

Hi Geert,

All patches that have been applied to this driver since 2005 are API refactoring
patches. I haven't found any patches in the history of this driver that seem to
have been submitted by a user of this driver. Do you perhaps know whether anyone
is using this driver?

Thanks,

Bart.

