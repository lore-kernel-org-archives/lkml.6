Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EqWoEXN+GVuaawAAmS7hNA
	; Thu, 07 Jun 2018 18:50:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC8E26074D; Thu,  7 Jun 2018 18:50:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb1bPCaj"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7665B601C3;
	Thu,  7 Jun 2018 18:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7665B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932502AbeFGSu1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932428AbeFGSuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:50:24 -0400
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EF07208B1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528397424;
        bh=DSpF0YzzhmUXYwyh9RmNB6WdmHLyUNES3xduCMDylXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zb1bPCajgPlDODF+UxSkNAJtIiUe6rIrhyLaDhNsnnjSTLmoF/bttDfHb9zEgxI0Y
         HBZXs/INMU/E2sUyOrNPpcsdTzSWNO/QAxdPPfczq4stKjebXK8YclNJjX7fFGQl6n
         MchJBMmPcC7ih/6CnLcEQttGiBnw2VXBIliKvL+w=
Received: by mail-wm0-f41.google.com with SMTP id e16-v6so19781282wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:50:24 -0700 (PDT)
X-Gm-Message-State: APt69E30F9j1wLWtS8tCyuTkWvrMxBx4eRizFM6fQ6GOJ/o4smEnUJLE
        8BgjC9c63aOw8LvX+JzEVzthw6ynrB0fRPciWpZG3A==
X-Google-Smtp-Source: ADUXVKKTFWpBTa5nDXjvC7B+SPBsLZukJspBBFwYRo6krt2G6R9OdfrgMbAmwnIc8IyKmUh32jqq3x+4f9gKkoHTlxI=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr2536456wma.21.1528397422410;
 Thu, 07 Jun 2018 11:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-11-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-11-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:50:10 -0700
X-Gmail-Original-Message-ID: <CALCETrXTyXYCDJxbCA+cbzZirmMKRQq8XSS4+Lyeo_QMywdxFw@mail.gmail.com>
Message-ID: <CALCETrXTyXYCDJxbCA+cbzZirmMKRQq8XSS4+Lyeo_QMywdxFw@mail.gmail.com>
Subject: Re: [PATCH 10/10] mm: Prevent munmap and remap_file_pages of shadow stack
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

blocking remap_file_pages() seems reasonable.  I'm not sure what's
wrong with munmap().
