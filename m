Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC4CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A872081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="nKJ4A+Zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A872081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeK2Kr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:27 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:56127 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeK2Kr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=cxFOWs3I/8LsI9MZgMEBkQ2cdyiU/r7dj/EsNHOBAaU=; b=nKJ4A+Zcb5HY
        HtiGwaELoPTR3ilzVHBO35645UYWkE1ZWZrzsBS1PCrHrJA3m3zFfdSZJ0a0Ri8Sg5++KrJHXgdee
        HjLrEc+B2oJuU2LBWv2vbeM+YMSdzhgre/2RQr5+7HN46XJx1YY0I/EhHh264PaE/8ISiEdx4hFMg
        FVi5C+oAo6cSeQB0hsZMUZw2Ld/ktXQebmsorbP48S16Zg5VCHnEzw6+0fA94pedA+CUv4PBqMCrh
        FrxgIfYCfz32aS0ar+5pOT+1Af55s+03+h7EDeLynrcD4NzdahLBisVPnQNNGTdRAlNwOtr5fJIde
        Ca1J9NllX98HaiOnpxsr3Q==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Un-000Fj9-AJ; Thu, 29 Nov 2018 00:43:54 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 8027DC1235;
        Thu, 29 Nov 2018 00:43:47 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 06/27] liblockdep: Add dummy print_irqtrace_events() implementation
Date:   Wed, 28 Nov 2018 15:43:04 -0800
Message-Id: <20181128234325.110011-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sZNRgMEdqx1YY92X890MUB602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aXcGYz2
 l3Ll2FYwbIPUv0EYq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18nXQzDvPzq7iERC
 6EDedzAj+cNwQ3D43FTA39dfhCtQkpPtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MUxAp6lp7UQayvhkcHnK3fh5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids that linking against liblockdep fails due to no
print_irqtrace_events() definition being available.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/lockdep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/lockdep/lockdep.c b/tools/lib/lockdep/lockdep.c
index 6002fcf2f9bc..348a9d0fb766 100644
--- a/tools/lib/lockdep/lockdep.c
+++ b/tools/lib/lockdep/lockdep.c
@@ -15,6 +15,11 @@ u32 prandom_u32(void)
 	abort();
 }
 
+void print_irqtrace_events(struct task_struct *curr)
+{
+	abort();
+}
+
 static struct new_utsname *init_utsname(void)
 {
 	static struct new_utsname n = (struct new_utsname) {
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

