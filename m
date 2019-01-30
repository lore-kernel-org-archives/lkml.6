Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F685C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29D821852
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548839549;
	bh=m2Amwt5xRuAF/BtRiYoVPKvt+0oNJQzkx+zBwAntzV0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=msrm3FrYwESwWDPf5JAAuDsUjEDA1P20hSuVM2pAWb291l9ACymZ9RuKOMlIPI15t
	 Xb+Pb+MiatAjYai3m1h0gcflurVpCMXyAjfnHRf73Qu6uKKtrJ6UXJ7VDu/uoimeoh
	 kvJC9IczbeINsuuixJDmD3H60BxVImJi1tUrtAIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfA3JM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:12:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39274 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:12:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so25130132wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m2Amwt5xRuAF/BtRiYoVPKvt+0oNJQzkx+zBwAntzV0=;
        b=q+X95maS8v9Vb/2vjxKtu6Kje9MnLFk9jVGalYI0XdAEfM1kHnNLRWRmfogHkHPNin
         Og1YhgkA8IE+GSjUfAk1Ily4Mi4GQbukv8hXUg29q3+f8T9zBRcYi2M2yivFKMYlXpyU
         qOfaxBdwgTMaNXNrmhGmtJMGjq6bWu0NyMbrd1A7W0nm4sKBuZ07Yp3JalXffg/B4CqV
         O64+6UWQCB3ppDedeYysNKB8SViB8/vpl8FBAoijAZBLU04M86ENNH11Xk+I3EcpKupJ
         wZf4WVbE+KAEFn8nSoWn7dWFyI8TbmQkONJ0I2kS1eYV3pu4CS7bgC3AstBTwKDviXLr
         Sfnw==
X-Gm-Message-State: AJcUukcsw8rnhImaI+zcjd5CdGyKYSnrPWL6r7DuP+g2IRMr7dG2ia6j
        tnXmbwvanCrweZoFpuVKGIQ=
X-Google-Smtp-Source: ALg8bN4o3NSnbRORIiG4pA/Fv1evNFjLo0o4MeeOLg8R2mbOHP9LIlrcP7bYQJHQ8zV9o1nuBHk5MQ==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr30456657wrm.239.1548839546420;
        Wed, 30 Jan 2019 01:12:26 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-142-190.eurotel.cz. [37.188.142.190])
        by smtp.gmail.com with ESMTPSA id l19sm1491875wme.21.2019.01.30.01.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:12:25 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] mm, memory_hotplug: fix uninitialized pages fallouts.
Date:   Wed, 30 Jan 2019 10:12:15 +0100
Message-Id: <20190130091217.24467-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this is the second version of the series. v1 was posted [1]. There are
no functional changes since v1. I have just fixed up the changelog of
patch 1 which had a wrong trace (c&p mistake). I have also added
tested-bys and reviewed-bys.

Mikhail has posted fixes for the two bugs quite some time ago [2]. I
have pushed back on those fixes because I believed that it is much
better to plug the problem at the initialization time rather than play
whack-a-mole all over the hotplug code and find all the places which
expect the full memory section to be initialized. We have ended up with
2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full
memory section") merged and cause a regression [3][4]. The reason is
that there might be memory layouts when two NUMA nodes share the same
memory section so the merged fix is simply incorrect.

In order to plug this hole we really have to be zone range aware in
those handlers. I have split up the original patch into two. One is
unchanged (patch 2) and I took a different approach for `removable'
crash. It would be great if Mikhail could test it still works for his
memory layout.

[1] http://lkml.kernel.org/r/20190128144506.15603-1-mhocko@kernel.org
[2] http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com
[3] https://bugzilla.redhat.com/show_bug.cgi?id=1666948
[4] http://lkml.kernel.org/r/20190125163938.GA20411@dhcp22.suse.cz


