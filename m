Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519410903-2-13581483188591616103
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519410903; b=NsFjO31Kv3M3pSwXrj4f9mhy7OUrekVE+O2TOKew3iEeER+
    zUiVWRw3JGGtLcZ+WSWeSr83HS6Rpd9dp1qvpvvVFZTIKESpYzocTO+WSVepFlme
    x/STlmcM5qx9/6kqT1km3l+5o4d1431bMSJd/cW+HxUMFNIbByZ6Mxl5RGLlFzHI
    N+TEn4I/eQo23fKMRo2XXcV4o5oSs0/1Ix+qOsUPnYnPOKVpgFCO9JKRfj6MD7TB
    2w4LyyugZ6SxT/m0mxAf5oF3wjStHCOcg6oka2lZKN4jzQGH0LZClzFwErjHKmK1
    B3OX4qdaYXmHJA0Zep62ER0/PYnYsElJcMPuxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410903; bh=D86h9isstgexjECFBdL0YBbN4r
    +ZO93ZUJ1Na5bAxl4=; b=E6lQnQbSzFWrjz1YiTQAzWraLd7GfzGuHYGPlOj37m
    iQcVrFB7qq8oJDP5HXurIw4/XO4+dX70b5w1ImJB6YJc89GDMYHYaAnnzX3r5vcr
    E2Ftch9fb8J27q1KlLHatYEFX/XBBjeM203M1Br2IegTdSKOzgzXymowFtlv5BkI
    sEpmW/sdfhLhs1vqv47cruG1mj8y0Vr4u9D3MuHu8Jz/zSp32nntgadlYpBFjrqL
    +NnaIsvHA19VEdIgt785tOoIXnjPfE6nHfSgb7FmCgZYmJADvxrzTX2CsFIFLlQc
    eGdQRey4URyea7v7Y2BhyKRbONLWAUfiS04POqh7EwHw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753681AbeBWSe7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:34:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbeBWSe5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:34:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cai Li <cai.li@spreadtrum.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 052/193] clk: fix a panic error caused by accessing NULL pointer
Date: Fri, 23 Feb 2018 19:24:45 +0100
Message-Id: <20180223170334.152831819@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cai Li <cai.li@spreadtrum.com>


[ Upstream commit 975b820b6836b6b6c42fb84cd2e772e2b41bca67 ]

In some cases the clock parent would be set NULL when doing re-parent,
it will cause a NULL pointer accessing if clk_set trace event is
enabled.

This patch sets the parent as "none" if the input parameter is NULL.

Fixes: dfc202ead312 (clk: Add tracepoints for hardware operations)
Signed-off-by: Cai Li <cai.li@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/clk.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/trace/events/clk.h
+++ b/include/trace/events/clk.h
@@ -134,12 +134,12 @@ DECLARE_EVENT_CLASS(clk_parent,
 
 	TP_STRUCT__entry(
 		__string(        name,           core->name                )
-		__string(        pname,          parent->name              )
+		__string(        pname, parent ? parent->name : "none"     )
 	),
 
 	TP_fast_assign(
 		__assign_str(name, core->name);
-		__assign_str(pname, parent->name);
+		__assign_str(pname, parent ? parent->name : "none");
 	),
 
 	TP_printk("%s %s", __get_str(name), __get_str(pname))
