Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70ABC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD1A218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549201241;
	bh=efKSAv+bSsJZMNsE0GWKK2oN/hhEhocd2QepQeO6KqQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rnV2GEQxymNhgaHXNwc7RenrvTVjWPRaqd6tVipdD/34ovVFoTGUwF3SJudNSM2IL
	 2ltlspBFJG9wGLzRpsueYHgAM/4RumQDi4KcNTWd3NeooeJjrknSLeG1wq356+ZX3d
	 easht7qvq7KvS1xjgJ0r1TgvzeWyDHcI26Lo8tB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfBCNkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:40:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57420 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfBCNkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TyQKCi2tTMc8wrgKrsjpwvUK/Cwk76yLh7YD66O1Frs=; b=F6KHG0cMsjIvG90QykS5MOmF0
        kTOu26a/lvMlLYt6fHb5YrJEy1E9ODsKEO2Hzktx/YdOWexsUqDpT+cPH7VpiKB2lrgtd3HVJjk2E
        gzj+n2k8kLkjvrKT1IfybL8wbIwdBlQBkAqMpDpKgp83VvE16Ds0fYZQPleXGnjoflTIE=;
Received: from [2001:67c:1810:f055:877d:5801:eba7:24a1] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gqI0b-0000WI-0t; Sun, 03 Feb 2019 13:40:29 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8932D440082; Sun,  3 Feb 2019 13:40:26 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] Make fsgsbase test more stable
Date:   Sun,  3 Feb 2019 14:40:15 +0100
Message-Id: <20190203134017.9375-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to make the fsgsbase test in the x86 kselftest
report a stable result.  On some Intel systems there are intermittent
failures in this testcase which have been reported and discussed
previously with the initial report and last meaningful discussion having
been about a year ago:

   https://lore.kernel.org/lkml/20180126153631.ha7yc33fj5uhitjo@xps/

with the analysis concluding that this is a hardware issue affecting a
subset of systems but no fix has been merged as yet.  In order to at
least make the test more solid for use in automated testing this series
modifies it to execute the test often enough to reproduce the problem
reliably, at least for the systems I have access to.

Mark Brown (2):
  selftests/x86/fsgsbase: Indirect output through a wrapper function
  selftests/x86/fsgsbase: Default to trying to run the test repeatedly

 tools/testing/selftests/x86/fsgsbase.c | 79 +++++++++++++++++++-------
 1 file changed, 58 insertions(+), 21 deletions(-)

-- 
2.20.1

