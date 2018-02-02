Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591603-2-15565204074437548617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591602; b=YSFBIZnZNsXoU8Lvsq/tXb2Jcsfm5c60g4Hpd/B54HzBozK
    /FeyOl7sAtmjls0RwI65ZoQce64u56ppuZLJDxbDIpMY2Q0KxMq5UP+7b/Gtw5tL
    64ZifoI2uFvF5CcD7UTil4da8OOdbMMlBDVGNQel+mnVWJkOZoFx/F1iODeffYN6
    Cbm/CTR1WV/Ve+ndMHR89zuckxUAr4cLnIYOLZkbetY2SHEAcARrJCx0niYYrlwj
    n1BVIkFIcTiwZKxAw/ogYDEP0y0qd8qrScu5nMaD+aCt8kXiq91B+Tnq3lnZPzSg
    pH8fcpQ5cB28ZcgiL6TbwUuzrI+IjmRHG4liyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591602; bh=UfyKHaUmyEab3o7p9g0O38fRcE
    k9BkJw5uxoorW75FA=; b=axZdrBUs6petkwiQJeCAS2bEssC2KYwHI5SsL0O7bw
    iuVDzNy0n2y4/NO1duAOorIgvyhHdiYoPfzEdKxQU8+/Z8TMxnHhvWl8jxkKub2x
    hoDa6TD5KqehYSqmZYGK/cL5a6xyX+3xd5hu5EgcDCQNP02X0rJZ50ORvrqKHWD4
    U/xcavjppH4w+lS/DBUSMK9/sIxovMbLBgVRIxroS+14oRDYQkq66PKTSqUoNCIY
    uMl9kqsvy5jCW3uxgZlrlTafcCY3Y51RIJEv7MnZsJOSR/CTa+kJP1fpKqzLa5t7
    0uJb8atNEiC9istx179rM5ow0SVFbkpCINhg/7xBMqiQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeBBRNV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:13:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeBBRNO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:13:14 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 104/156] kmemleak: add scheduling point to kmemleak_scan()
Date: Fri,  2 Feb 2018 17:58:05 +0100
Message-Id: <20180202140844.899537645@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>


[ Upstream commit bde5f6bc68db51128f875a756e9082a6c6ff7b4c ]

kmemleak_scan() will scan struct page for each node and it can be really
large and resulting in a soft lockup.  We have seen a soft lockup when
do scan while compile kernel:

  watchdog: BUG: soft lockup - CPU#53 stuck for 22s! [bash:10287]
 [...]
  Call Trace:
   kmemleak_scan+0x21a/0x4c0
   kmemleak_write+0x312/0x350
   full_proxy_write+0x5a/0xa0
   __vfs_write+0x33/0x150
   vfs_write+0xad/0x1a0
   SyS_write+0x52/0xc0
   do_syscall_64+0x61/0x1a0
   entry_SYSCALL64_slow_path+0x25/0x25

Fix this by adding cond_resched every MAX_SCAN_SIZE.

Link: http://lkml.kernel.org/r/1511439788-20099-1-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kmemleak.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1532,6 +1532,8 @@ static void kmemleak_scan(void)
 			if (page_count(page) == 0)
 				continue;
 			scan_block(page, page + 1, NULL);
+			if (!(pfn % (MAX_SCAN_SIZE / sizeof(*page))))
+				cond_resched();
 		}
 	}
 	put_online_mems();
