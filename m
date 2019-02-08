Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4501C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921522147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uN0PHAwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBHFJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:09:27 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44160 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBHFJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:09:26 -0500
Received: by mail-ed1-f43.google.com with SMTP id y56so1723375edd.11;
        Thu, 07 Feb 2019 21:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Xpmvty5nL0sZvatl2VW477OUNsqZQSbd+CWBQl8OdMU=;
        b=uN0PHAwubKZo7UxNHzhh3y9dkX63+kZjKJbMOrJHnivyBSOsLVxVu9nSyFCL1pONVm
         qQwMNnfumfOwJ5Yzyl7vOJc+tUROTfu41IHRGeJk7vnshGFSd8FhujwlwWygcBcrGhk9
         uSR+2cL23ohOw9alPirGPnYEKzM27QFQ4LQFCEhrrGPR30nGSt9oWzKP1ml1Ksz1GHbp
         oILb0fITlvQGtEzl1ohSb4zLcpPR/NhNXLbUNzXaU/WgdVhdx9YR7/BtSuRKe92HNMYW
         Y+2XG6J0jRpoGkAA7Yfxzub9RLXpZk6gyoSZx3aNe9R9TE5SgKhUSaoz++xsAYnR1jBO
         V31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Xpmvty5nL0sZvatl2VW477OUNsqZQSbd+CWBQl8OdMU=;
        b=QOwyr8AXSYj/gpMWCuUkkiHxH5UFr93LTlMNfgC1EquJeRQEr7/ztQr86bIPKk6lou
         vYbch4VI3efH2D9jpuq4OjhQ7VsuyehYVdn06fmNYXAm6mmIoflm4Go5MfWELdnoVgOb
         gAntSIDh4F2aj7eAMHJQNOG3xPmF3/5r075f+EycgUBMSkbOEXc7uPDmewTyQ+0INnmq
         b/yZGU858z3A4S6+m9TG25Dh0TkbuF5R60BfP7NYlg2fFrdw2qnf828NIqkXxb8bkYI2
         tq/bWecFBUSSzKIRiN3d10RxtSMjW0b0DZtnzi2EyYAIDpHq5THB+hHzqkWX54Pbn6ZC
         mmnA==
X-Gm-Message-State: AHQUAuacK+HTaoKFtu8bxTosEg7lc0H26+lKiZqTVPcCJZpl+W8wi5Jr
        HLKep8tbZ13B7YCOO2qI+ITsjaWIKRNiww==
X-Google-Smtp-Source: AHgI3IadcQDrsMgUubSnH74vNHukdMaRIlUvI5F5jStrmwdBd9qvuH9LZk8yhqsa9GKZuwS0MRmBUg==
X-Received: by 2002:a05:6402:754:: with SMTP id p20mr315195edy.258.1549602564280;
        Thu, 07 Feb 2019 21:09:24 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id v2sm336792edr.46.2019.02.07.21.09.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Feb 2019 21:09:23 -0800 (PST)
Date:   Thu, 7 Feb 2019 22:09:21 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sasha Neftin <sasha.neftin@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     Aaron Brown <aaron.f.brown@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Clang warning in drivers/net/ethernet/intel/igc/igc_ethtool.c
Message-ID: <20190208050921.GA8758@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After commit 8c5ad0dae93c ("igc: Add ethtool support"), Clang warns:

drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: warning: variable 'igc_priv_flags_strings' is not needed and will not be emitted [-Wunneeded-internal-declaration]
static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
                  ^
1 warning generated.

igc_priv_flags_strings is only used in an ARRAY_SIZE macro, which is a
compile time evaluation, so no reference to it is being emitted in the
final assembly. Is it actually needed and was forgotten to be used
somewhere or could it be eliminated so that Clang no longer warns?

Thanks,
Nathan
