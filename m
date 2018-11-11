Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE4FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA0B2175B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMITRQUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA0B2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbeKLITP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387540AbeKLITO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:14 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FE0421104;
        Sun, 11 Nov 2018 22:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975358;
        bh=Xdf2SShCXnmpJQeLTkPGSjKGdXV9G36dV0Gc9quASYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMITRQUYVcCgx4cC0c0ylQ6fxoj7sMHglF4W33c0YlAgr4FEYqNmJbXn8d/8FH0KD
         3DPTEXO3tZG4MXaMQpPVBdY+fF+YdiAVfeBZM9t95i7sZrrK2Mhcb4TjB9ofYRwBj1
         I1kucPnmGj8NTeKRgp+JpyGsasiJ6SRxRvP0PJWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Arcari <darcari@redhat.com>,
        Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 025/350] mailbox: PCC: handle parse error
Date:   Sun, 11 Nov 2018 14:18:09 -0800
Message-Id: <20181111221708.227024338@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Arcari <darcari@redhat.com>

commit afd0b1fb22269f48d68fdf269891c653818c8047 upstream.

acpi_pcc_probe() calls acpi_table_parse_entries_array() but fails
to check for an error return.  This in turn can result in calling
kcalloc() with a negative count as well as emitting the following
misleading erorr message:

[    2.642015] Could not allocate space for PCC mbox channels

Fixes: 8f8027c5f935 (mailbox: PCC: erroneous error message when parsing ACPI PCCT)
Signed-off-by: David Arcari <darcari@redhat.com>
Reviewed-by: Al Stone <ahs3@redhat.com>
Cc: 4.18+ <stable@vger.kernel.org> # 4.18+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mailbox/pcc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -461,8 +461,11 @@ static int __init acpi_pcc_probe(void)
 	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
 			sizeof(struct acpi_table_pcct), proc,
 			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
-	if (count == 0 || count > MAX_PCC_SUBSPACES) {
-		pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
+	if (count <= 0 || count > MAX_PCC_SUBSPACES) {
+		if (count < 0)
+			pr_warn("Error parsing PCC subspaces from PCCT\n");
+		else
+			pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
 		return -EINVAL;
 	}
 


