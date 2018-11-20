Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C2C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A16206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A16206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeKUAMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:12:50 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44320 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKUAMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:12:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so1928490edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pm9BFsTZwttpokAoTBqiBJjRdorII9/av+J2UcJN2SQ=;
        b=cGfmwIMh3H9zJKuRlWajW+WP3hSzWXPM9EH9S6Qj9gPNeFOhXcIMLle+ioQizp3cwM
         PWADBp3eGI/1obW8GaygJF9jQhc/X0Hi4GfY886uCn1OWyeGJGQP19+3gldMU4REw/ZL
         W4aSqiaGWYnR14uqWvV/Xb944cgD96oLq1Yrmxo66pbWusc6+BTOcWQ9xrp1p1+63W2O
         laajhzYUKOUjYRKZnO6fg+x0L7Q72AG5EhDo1W19Poa3lHVppJ7EUxgs46689PyIl2kO
         NVFPy3k6PUUcfx2WmTgg1BfhcMV/RqHGvcPdck+ZLqgNGbua9/BgRsZWXg0UkX5dzUk1
         WyTQ==
X-Gm-Message-State: AA+aEWbvEyPIvGV0vvtMlXstlKHXsZojy9ITRCPgvzv5v7yHgxlfbUEg
        OvdKMrLHC4EeWAtbL44tnpM=
X-Google-Smtp-Source: AFSGD/XKJcgq7UxS8sK4BF9W5DdSiizRqG1frM+FYHacR/P/cQdpf8YXqg3zL15b4TxtJ8tl730Q2Q==
X-Received: by 2002:aa7:d394:: with SMTP id x20mr2279753edq.193.1542721415022;
        Tue, 20 Nov 2018 05:43:35 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 49sm8428786edz.59.2018.11.20.05.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:43:33 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 0/3] few memory offlining enhancements
Date:   Tue, 20 Nov 2018 14:43:20 +0100
Message-Id: <20181120134323.13007-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been chasing memory offlining not making progress recently. On
the way I have noticed few weird decisions in the code. The migration
itself is restricted without a reasonable justification and the retry
loop around the migration is quite messy. This is addressed by patch 1
and patch 2.

Patch 3 is targeting on the faultaround code which has been a hot
candidate for the initial issue reported upstream [1] and that I am
debugging internally. It turned out to be not the main contributor
in the end but I believe we should address it regardless. See the patch
description for more details.

[1] http://lkml.kernel.org/r/20181114070909.GB2653@MiWiFi-R3L-srv


