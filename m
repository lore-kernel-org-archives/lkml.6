Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3991C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6410A2083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6410A2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJEC5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:57:44 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:43461 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJEC5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:57:44 -0400
Received: by mail-pl1-f171.google.com with SMTP id 30-v6so5698733plb.10;
        Thu, 04 Oct 2018 13:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/PUdVBkYEiRB0NoRa3qumHSwhJXB0XyWPqQ1ZhNVNRw=;
        b=ftjbVllVcXvVwZbb62qLTrkBgspIeNkT5gCg0eF0yT/97vCvH3tXSvyXHZud3qgu3l
         /981QhpI9ESV4MHBYOChxQidHhV37wZ7y9adRvAoux3qEsrjLktProTknk9L7tXjV8mL
         jJcKh0gdrpktFRBsG9n0t/3c2t7CMhaNRgIq6DO/P0l2hddPjR61Y0xgZXvYBS1O0tGE
         mXV30PezQ9Ys7sxemEh56P6cH8eatTaB3GTCW1cA5J/s0DItOthFRzid648DJwvUV3UR
         /lDHyy8Mivn6S4hA1MOSGFzttoKJYv/RTNLdmLKnjHL2Vj7lsr5jz3PC6NWKuKUxv3rz
         /MLA==
X-Gm-Message-State: ABuFfoiC7xaja74ReNBu6u15sEKxFgEtqlBBONsPRNmFPZPa++W6WATB
        EhkM7bY+lagK/gTxVbiINKR2AZE0
X-Google-Smtp-Source: ACcGV63FFrwv3Tgoc7QY6Di53jrim+qk+adZL6RpPRs3EB3n2pXgy6ftYN7h86HuCoeGp2rzMrEpHA==
X-Received: by 2002:a17:902:9696:: with SMTP id n22-v6mr8233550plp.212.1538683374365;
        Thu, 04 Oct 2018 13:02:54 -0700 (PDT)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id v63-v6sm6738002pgd.69.2018.10.04.13.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 13:02:53 -0700 (PDT)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 04 Oct 2018 13:02:49 -0700
Date:   Thu, 4 Oct 2018 13:02:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, Petr Vorel <pvorel@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Felix Fietkau <nbd@nbd.name>, kconfig-sat@googlegroups.com
Subject: [ANN] init-kconfig - easy way to embrace Linux's kconfig
Message-ID: <20181004200249.GL5238@garbanzo.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every now and then a project is born, and they decide to use Linux's
kconfig to enable configuration of their project. As it stands we *know*
kconfig is now used in at least over 12 different projects [0]. I myself
added kconfig to one as well years ago. Even research reveals that
kconfig has become one of the leading industrial variability modeling
languages [1] [2].

What is often difficult to do though is to start off using kconfig and
integrating it into a project. Or updating / syncing to the latest
kconfig from upstream Linux.

I had yet another need to use kconfig for another small project so
decided to make a clean template others can use and help keep it in sync.
This is a passive fork which aims to keep in sync with the Linux
kernel's latest kconfig to make it easier to keep up to date and to
enable new projects to use and embrace kconfig on their own.  The goal
is *not* to fork kconfig and evolve it separately, but rather keep in
sync with the evolution of kconfig on Linux to make it easier for
projects to use kconfig and also update their own kconfig when needed.

This may also be useful if folks want to test R&D code on a smaller
compartamentalized codebase.

If you find this useful and you'd like to help keep it in sync, send
patches my way as the kernel's kconfig evolves. The code is up on
gitlab [3].

Do we want to document this option on Linux in case folks want to try
and embrace kconfig on their own for other projects?
  
[0] http://www.eng.uwaterloo.ca/~shshe/kconfig_semantics.pdf
[1] http://gsd.uwaterloo.ca/sites/default/files/vm-2013-berger.pdf
[2] http://gsd.uwaterloo.ca/sites/default/files/ase241-berger_0.pdf
[3] https://gitlab.com/mcgrof/init-kconfig

  Luis
