Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A657ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33DB20831
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaYsnxrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33DB20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJ0EPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:15:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46617 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJ0EPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:15:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id i4-v6so2415504wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e6XmZzdDNPzCNgUyMQ7IB8jb40seiXRj9ywej+3F6+0=;
        b=qaYsnxrLj2gO651wSoheri+95kwm+qYpY8UiNxavC5vxa9443oSb4YlkDCd+kFafqH
         0V5YqsT3O+F4HX/gxdoSVyv0yFE/iYn2lYyjYt8xAX8B9ae3zX2eOUCsJUXLLC+MC9xU
         k3ZY8Tk8jQ4No434o+h42rAPYM5Utb2n0D0bPxCbRo4WqEPu1qyE+QAyuOZY1wXzdLLL
         aFyVSmYIQIuC2lskRWqFJJXAgh+A6LtOUsTGpl68T7iJbu8dcQzFshDoVHS4ga5LyNTE
         59MiVC2gYbCV4xl1ggevmWdAteyPvvUmkQv99XnHX1RpWOAIljkrstNkgdp7vBqI4ZSp
         uUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e6XmZzdDNPzCNgUyMQ7IB8jb40seiXRj9ywej+3F6+0=;
        b=rZWRZRIjWrPEcq9Yd0aEkO54RNGMKYScO/Vi1kBKZCErtWP2XcsQuSOP8BmH4Zc+PX
         Zfewwx0v4qpYp7UcbB8dowWJLMszAkpmQkPpy2d7d7dedPSVSMQYY7pgKjb0GDfE3Ief
         WLuT36SbeOYUJxxDBsGzzRwXb6mS70uAjpOt6nbqOriSiptLY+TYp0oooLW9YOxpEiuL
         xOLtCBjyeccWPtF4RDkpkyWQDsHMt5mHOdrXeeB3bw5jx0DH/SUqNJnPEhMLFgOTJhN1
         CSdEFE5X3sskKZTaZ0fdCtc0sew0WXVIROZ3m/bzgxrqSbPySarRFMQFfeTMnCVi0Q3p
         YqDw==
X-Gm-Message-State: AGRZ1gLrCblsoDC8u5zbFH6bx9MmGR4FSK/u/pjei6tWbdQryd+Jr0FY
        ZxKYMjDoIYRI7Qq/WPSVG+s=
X-Google-Smtp-Source: AJdET5cqWqlrm/OmMjuC/Zi2Tpy2kJJ5K3m+d1OCa+kIbi6AZACeIFpNYfWkntmgwXEACxIM9KFjew==
X-Received: by 2002:adf:f204:: with SMTP id p4-v6mr6428803wro.142.1540582608134;
        Fri, 26 Oct 2018 12:36:48 -0700 (PDT)
Received: from localhost.localdomain ([87.71.39.51])
        by smtp.googlemail.com with ESMTPSA id u191-v6sm4484261wmd.31.2018.10.26.12.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 12:36:47 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     carmeli.tamir@gmail.com
Subject: [PATCH] scheduler: wait: Added missing include freezer.h
Date:   Fri, 26 Oct 2018 15:35:51 -0400
Message-Id: <1540582551-44028-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function 'wait_event_freezable' calls '__wait_event_freezable' that
uses 'try_to_freeze', which is defined in freezer.h.
This causes a compilation error for callers of 'wait_event_freezables',
forcing them to include also freezer.h.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 include/linux/wait.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index ed7c122..75061ee 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -4,6 +4,7 @@
 /*
  * Linux wait queue related types and methods
  */
+#include <linux/freezer.h>
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
-- 
2.7.4

