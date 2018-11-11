Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E444CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A927C223D8
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xXTm1PjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A927C223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390787AbeKLIWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390708AbeKLIWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:36 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 036CD223C6;
        Sun, 11 Nov 2018 22:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975559;
        bh=N7b2qu9dQsclSlsQXY+aYpIMB+uH5q4owG5i1mPTW9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXTm1PjN+mVlCEiYkGHhPTPV8lzff78FGxLtpVw3WFjlo+499FoA8AsI1RJtkb0Wr
         vLFIPMQ6GWHLzr5eBmEZrFXObmCklJ4isojAfslQa2CwYlLitaxkunPnVrBCMnTyWs
         vVJJnwMCyO3GK0C0Cbo3aNm4LtqWLXKqq5L1Qvvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dr. Greg Wettstein" <greg@enjellic.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.14 117/222] tpm: Restore functionality to xen vtpm driver.
Date:   Sun, 11 Nov 2018 14:23:34 -0800
Message-Id: <20181111221658.218216842@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dr. Greg Wettstein <greg@wind.enjellic.com>

commit e487a0f52301293152a6f8c4e217f2a11dd808e3 upstream.

Functionality of the xen-tpmfront driver was lost secondary to
the introduction of xenbus multi-page support in commit ccc9d90a9a8b
("xenbus_client: Extend interface to support multi-page ring").

In this commit pointer to location of where the shared page address
is stored was being passed to the xenbus_grant_ring() function rather
then the address of the shared page itself. This resulted in a situation
where the driver would attach to the vtpm-stubdom but any attempt
to send a command to the stub domain would timeout.

A diagnostic finding for this regression is the following error
message being generated when the xen-tpmfront driver probes for a
device:

<3>vtpm vtpm-0: tpm_transmit: tpm_send: error -62

<3>vtpm vtpm-0: A TPM error (-62) occurred attempting to determine
the timeouts

This fix is relevant to all kernels from 4.1 forward which is the
release in which multi-page xenbus support was introduced.

Daniel De Graaf formulated the fix by code inspection after the
regression point was located.

Fixes: ccc9d90a9a8b ("xenbus_client: Extend interface to support multi-page ring")
Signed-off-by: Dr. Greg Wettstein <greg@enjellic.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[boris: Updated commit message, added Fixes tag]
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org # v4.1+
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---
 drivers/char/tpm/xen-tpmfront.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -203,7 +203,7 @@ static int setup_ring(struct xenbus_devi
 		return -ENOMEM;
 	}
 
-	rv = xenbus_grant_ring(dev, &priv->shr, 1, &gref);
+	rv = xenbus_grant_ring(dev, priv->shr, 1, &gref);
 	if (rv < 0)
 		return rv;
 


