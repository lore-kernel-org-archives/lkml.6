Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D30C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0410321780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="iQRuf5sU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0410321780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeKOFzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:55:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48154 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeKOFzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oCv4Lw9q0VTIhKfZpW+pK6HgBb+FJlUzjgZm/83nV8o=; b=iQRuf5sUdc6pxqq+oMLCY+4ib
        658kuRHLSss/mEJoJvPQltxKcaIh21KSs0JwWDHPS1wmf19n6oOtSVAktpwCO3diQ84Nmg0OYfbxc
        J2FsMCz/2RcfIawwh/vzRCqmKbLw5Q4TA+0eBUT0JW/aUMY6pwY7+Q/YG89F5dBYoJ28w=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gN1Bd-0004Kb-Bb; Wed, 14 Nov 2018 19:50:53 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EFED2440078; Wed, 14 Nov 2018 19:50:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH RFC 0/2] Make fsgsbase test more stable
Date:   Wed, 14 Nov 2018 11:50:41 -0800
Message-Id: <20181114195043.8021-1-broonie@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to make the fsgsbase test in the x86 kselftest
report a stable result.  On some Intel systems there are intermittent
failures in this testcase which have been reported and discussed 
previously:

   https://lore.kernel.org/lkml/20180126153631.ha7yc33fj5uhitjo@xps/

with the analysis concluding that this is a hardware issue affecting a
subset of systems but no fix has been merged as yet.  In order to at
least make the test more solid for use in automated testing this series
modifies it to execute the test often enough to reproduce the problem
reliably.

I'm not happy with this since it doesn't fix the actual problem, the
code isn't particularly clean and it makes the execution time for the
selftests much longer - my main goal here is to restart the discussion
of the test failure, I don't think merging this is a great idea.

Mark Brown (2):
      selftests/x86/fsgsbase: Indirect output through a wrapper function
      selftests/x86/fsgsbase: Default to trying to run the test repeatedly

 tools/testing/selftests/x86/fsgsbase.c | 79 +++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 21 deletions(-)


