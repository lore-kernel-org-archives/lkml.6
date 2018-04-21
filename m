Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbeDUHu6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:50:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47440 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbeDUHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:50:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5686601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: luciano.coelho@intel.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: New sparse warning from min_t(): expression using sizeof(void)
Date: Sat, 21 Apr 2018 10:50:51 +0300
Message-ID: <87a7txf15w.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees&Linus,

after upgrading to v4.17-rc1 I started to see this sparse warning from
min_t():

drivers/net/wireless/ath/ath10k/wmi.c:4620:31: warning: expression using sizeof(void)

I counted 167 such warnings just from ath10k alone and Luca told me that
he sees similar sparse warnings with iwlwifi as well. My sparse is
pretty old (v0.5.0-44-g40791b94c56b) but Luca said updating sparse to
0.5.2 didn't help. I also see this with latest commit from Linus' tree
(83beed7b2b26).

After reverting these two commits the sparse warnings go away:

e9092d0d9796 Fix subtle macro variable shadowing in min_not_zero()
3c8ba0d61d04 kernel.h: Retain constant expression output for max()/min()

I had to revert e9092d0d9796 due to conflicts but it seems 3c8ba0d61d04
is the actual commit causing these warnings.

Is there any way to fix it? With ath10k I use sparse a lot and because
of these warnings sparse is now very annoying to use.

-- 
Kalle Valo
