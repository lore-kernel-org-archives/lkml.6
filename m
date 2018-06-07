Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ucSzFi6YGVu+fAAAmS7hNA
	; Thu, 07 Jun 2018 20:54:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1A5BC6074D; Thu,  7 Jun 2018 20:54:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0FKEzr9"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A345601C3;
	Thu,  7 Jun 2018 20:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A345601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeFGUyc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932516AbeFGUya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:54:30 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C0D7208A0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 20:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528404869;
        bh=gZqvDyTiIXVTFOWHjmKSy3cvdqggFCpFqWhSS5zfKGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g0FKEzr9SXgKkm8aOaTmcEU8w+QVKODvIIS6eQx9qVbmyd6jq84GTBiK+Po+gtiMh
         Qa05Tnd2vJ6t4H3Hp9bst1lhcvPS0uUODZEduFRw1OAoKGq83Vsak/FIHtnueddpkK
         FF9/A2aFMVysHqh5+u2IM5vISOF/iiWNOUFfm+ZE=
Received: by mail-wm0-f51.google.com with SMTP id n5-v6so21745013wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:54:29 -0700 (PDT)
X-Gm-Message-State: APt69E2GdCrAALWbxp+/q5qSolhz8F08nkAsrYJZJXx5l/NhcOKSxG3L
        R7CGgEMDZIKq/t8dKxjVPUm5vw0bt+hQmYHcpDfO7A==
X-Google-Smtp-Source: ADUXVKK29Zb7ztvSpMtp1mxhqVazOzUoVdE9DJQD1mXwtjA6pVLzfnCniIup3+uxsR2OIeITDX7rcbLt9NJQOMbjWCI=
X-Received: by 2002:a1c:b947:: with SMTP id j68-v6mr2479649wmf.144.1528404868084;
 Thu, 07 Jun 2018 13:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-10-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-10-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 13:54:16 -0700
X-Gmail-Original-Message-ID: <CALCETrU8fK1j=H_9xpJrrCSUTcadb8dfjJX-YZwiWDZZFmLxRQ@mail.gmail.com>
Message-ID: <CALCETrU8fK1j=H_9xpJrrCSUTcadb8dfjJX-YZwiWDZZFmLxRQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm: Prevent madvise from changing shadow stack
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Seems reasonable to me.
