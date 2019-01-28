Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F42FC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336F52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548686718;
	bh=VmmjCE9nv23gtn5FhnfCZit8Inds2NxcQgpLgdIXFWA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WTwAYmCcBTVGPq5qQhJDzElKeXmx1CT03Nub1gGQKeCNtKx/JarURmX92OtGQWXTp
	 XxrcZex0H39gM7n4JFpzGiasGVwQOfNjdnOGdSR2a9rY+jfPfFnsIUTQAyN7jqHGrA
	 Ww0TBPIm1ljB96qIe4GcvNYIptroRm8T+BTWP/rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfA1OpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:45:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40948 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfA1OpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:45:16 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so13190382edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VmmjCE9nv23gtn5FhnfCZit8Inds2NxcQgpLgdIXFWA=;
        b=ptDeEMwrJ2Fs0kGjansFzmc0VXXKN0x0JmJfflPbBAJ6mhYRrBvuzYgeGkMarCtnAO
         0Blj/SYqkVSLkL9fpFxQY8AwkrCqIJ4GxE1NANdk6izwLTPMWIgmwDuZe95vuJqvsg30
         2bUeTAmKo0YH4IXi0MyKPMoVQkrX2pvr28yDEKLec9w+3SWLzUUHeXPFmdftnXGaUVEg
         Ntt3ZQuUrwaVlo8IYoJYNLUDIYS+/1ClALoCR35By8MTjofpm1Nunvp2X6wtGFwu2DpY
         wP77d655yHYrtm35/VQ9HrwX8S+fbYBRWkLJvTBMgPxX9h0EkYhOqPvKzSjBR9PcZqIi
         cW1g==
X-Gm-Message-State: AJcUukfsnkBxg/l9bADlu3xCwLHtdtacpcdvzyxl0LXhkS00NQLDRdzd
        zVo0slFGoEcQkBFJubykfNA=
X-Google-Smtp-Source: ALg8bN4zQOz65VeZcD/EvoZAlxOuVydw3aMLYl71U5hV9bAJy37VDh3kDv/DMgsa1BCH1aA2Xxwr4w==
X-Received: by 2002:a50:b205:: with SMTP id o5mr21305494edd.245.1548686714588;
        Mon, 28 Jan 2019 06:45:14 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j8sm2919064ejr.17.2019.01.28.06.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:45:13 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] mm, memory_hotplug: fix uninitialized pages fallouts.
Date:   Mon, 28 Jan 2019 15:45:04 +0100
Message-Id: <20190128144506.15603-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Mikhail has posted fixes for the two bugs quite some time ago [1]. I
have pushed back on those fixes because I believed that it is much
better to plug the problem at the initialization time rather than play
whack-a-mole all over the hotplug code and find all the places which
expect the full memory section to be initialized. We have ended up with
2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full
memory section") merged and cause a regression [2][3]. The reason is
that there might be memory layouts when two NUMA nodes share the same
memory section so the merged fix is simply incorrect.

In order to plug this hole we really have to be zone range aware in
those handlers. I have split up the original patch into two. One is
unchanged (patch 2) and I took a different approach for `removable'
crash. It would be great if Mikhail could test it still works for his
memory layout.

[1] http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1666948
[3] http://lkml.kernel.org/r/20190125163938.GA20411@dhcp22.suse.cz


