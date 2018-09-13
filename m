Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCC8C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA0521471
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiRKGllz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA0521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeIMGVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 02:21:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42315 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeIMGVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 02:21:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so1794844plq.9;
        Wed, 12 Sep 2018 18:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=aJ9AQtKLGkwTUkHy8D91QUtCJepMIhmeG7CbI7IIaG4=;
        b=AiRKGllzq07MwbpT+mogc89yMZWpHvwAY60uc1a21TyUfz6C30Dpnju/Ei5WhlW8JU
         MSttF6YRB2Q+sdliZKBeApOqNR7CTwOgJ++nvi5bpOQMIvryKFeSwQkREvKP54RhdxtD
         tHCzvVJKfzke0wi9kTJ9tlZ7bY7kVLDm6CADV7w2UYAhRy05bMjudveDCw57InjviJ4A
         MXA93JhjXpbqc2RsP2uP0GcFF7gaeBqrA139edXtmmegaeMc1viPFW78ftkjX7q+hEZD
         9ttQQAZWmf0vpeU2flPgF49NwWmDDFt6kWq2tZR89mhTCv4F6cT1fiFw7pCEJJc36hXM
         udow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=aJ9AQtKLGkwTUkHy8D91QUtCJepMIhmeG7CbI7IIaG4=;
        b=nIADa/0NNm3qrJ9CWx9yMuDW48gMyyEEHr7Y0AT+2lQXEbrUhDGKr9Zj9MV2C9HFla
         R+DwSIBuh1w5l8Zugyz1sO+YpKdn0G8uAkDzs+NuvF7qdHuq3fizAcIW5MI1fKZsAjNz
         f44wQEZLLBg96DfhmWikzzBKOEFe1gPPfxGuBvxNDFrUznAH4oeOWcDAS3K9twB1UgfK
         +2jVStk25Tttf3scN1U5BKSw0NxjYxAg+bZRtdFZabl6E7gg0NBcYD0T2AEYxPhPebkF
         zy0HjVuTdungjhadZZa84kSOTuLwpVgXk1uLCxYhI+OylYsb+v6iruFuubwB58p7tk79
         0A4g==
X-Gm-Message-State: APzg51CrDmNLLifVKTBgqrRCjJg2vYPtRf4vlMH4Jcwys7SqpSfIrnEJ
        9WfA98XrJdnyWdGOnHgGWYU=
X-Google-Smtp-Source: ANB0VdZeRCkAUYw9y/sVp1tveQp+ij8W6YRcwmL2HA5paYa4xE+b3jPq/7Tw04QqRxOcItChUBY/QQ==
X-Received: by 2002:a17:902:9696:: with SMTP id n22-v6mr4913841plp.212.1536801237880;
        Wed, 12 Sep 2018 18:13:57 -0700 (PDT)
Received: from josh-ThinkPad-T460s (cpe-75-80-215-168.hawaii.res.rr.com. [75.80.215.168])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2646972pgf.58.2018.09.12.18.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 18:13:57 -0700 (PDT)
From:   Josh Abraham <j.abraham1776@gmail.com>
X-Google-Original-From: Josh Abraham <sinisterpatrician@gmail.com>
Date:   Wed, 12 Sep 2018 15:13:54 -1000
To:     boris.ostrovsky@oracle.com
Cc:     jgross@suse.com, aams@amazon.com, roger.pau@citrix.com,
        xen-devel@lists.xenproject.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, j.abraham1776@gmail.com
Subject: [PATCH] xen: fix GCC warning and remove duplicate
 EVTCHN_ROW/EVTCHN_COL usage
Message-ID: <20180913011354.GA19226@josh-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes duplicate macro useage in events_base.c.

It also fixes gcc warning:
variable ‘col’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>
---
 drivers/xen/events/events_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 08e4af04d6f2..e6c1934734b7 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -138,7 +138,7 @@ static int set_evtchn_to_irq(unsigned evtchn, unsigned irq)
 		clear_evtchn_to_irq_row(row);
 	}
 
-	evtchn_to_irq[EVTCHN_ROW(evtchn)][EVTCHN_COL(evtchn)] = irq;
+	evtchn_to_irq[row][col] = irq;
 	return 0;
 }
 
-- 
2.17.1

