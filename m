Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413504-2-12399425425992594626
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413504; b=hlBPt4Vu5uan/MaqMlp62PIDS634lx5Du9Jb7K96cjOxzEX
    /9CLgF396GDSDJDtBSCLSrm0dDA6GeIHe8JSnTFbC4ySR71j1WGX1iJhsAIXVH4R
    2V+2qTx1qAxhdZf/PX3Gp477x5q6AZJlkH9d0od/lvedvC0EyuqmR36s6c75RpL9
    wquthWA/kMEAZamV7RJ9L1oZXJvJulyOqFz+8cS997sTTjU17RKbBypjCGRRK+go
    SISEkXYJ9WIKp0+0hsr1pEykSPU+PDNzpC4cOtqTJAoneJbyPHVleqdSu3yY6nUq
    KdFmfTf1u0XF3VvjqhwFJQPPwQrUo0NoriXvwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413504; bh=fsN9sDqWhjMhTV/gu8BQkWlU2B
    gz6r8LlvAmNpKVVDU=; b=HA2A4LWl4thLHfgiavXyI5GLblL/H1heNiIj+Ko+Y7
    xichpLoL33eu5xguQQPHlh9tjJiG/dnN/7PwMtm/jt9qW32BN7GX0+yzQDxXHFj+
    XtuAfE0ai+7MTejB8Jp2f1AFGMMhzNdmtML7Ayjklo/PAharmnlfHT7ZVxY7C6tS
    lYdmQsaFEt70VJcCYCOkS/q8q6Uqk3kIpEzUO7NF3arJ29wlafZwIJ2iAhmJ6eqA
    pyqB9TPAKhCO/hY7/izemG4iGNmJU2wWNLCkueJkwtnK091KSCyFv2Hp2CuAqh2j
    pxiWeyzvAXBC1WIkmXbEPdWvOXzyWAzdDtO02+6hV5Lw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935496AbeBWSyo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:54:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935511AbeBWSyn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 072/159] perf: Fix header.size for namespace events
Date: Fri, 23 Feb 2018 19:26:20 +0100
Message-Id: <20180223170752.315968001@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit 34900ec5c9577cc1b0f22887ac7349f458ba8ac2 ]

Reset header size for namespace events, otherwise it only gets bigger in
ctx iterations.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: e422267322cd ("perf: Add PERF_RECORD_NAMESPACES to include namespaces related info")
Link: http://lkml.kernel.org/n/tip-nlo4gonz9d4guyb8153ukzt0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6719,6 +6719,7 @@ static void perf_event_namespaces_output
 	struct perf_namespaces_event *namespaces_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u16 header_size = namespaces_event->event_id.header.size;
 	int ret;
 
 	if (!perf_event_namespaces_match(event))
@@ -6729,7 +6730,7 @@ static void perf_event_namespaces_output
 	ret = perf_output_begin(&handle, event,
 				namespaces_event->event_id.header.size);
 	if (ret)
-		return;
+		goto out;
 
 	namespaces_event->event_id.pid = perf_event_pid(event,
 							namespaces_event->task);
@@ -6741,6 +6742,8 @@ static void perf_event_namespaces_output
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
+out:
+	namespaces_event->event_id.header.size = header_size;
 }
 
 static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
