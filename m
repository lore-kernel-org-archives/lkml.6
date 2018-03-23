Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803200-2-18158142387114746769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803199; b=S29woD8SA0tZ07Zf1GcthWaiyym380456kg8fv7coXtjWAd
    LOVeUeEX4tIjajfqjDi4YpA7H4T4bgAZDTznsVfLtpNr7if2NNlfMKCWyRPkP800
    xzPWgotcJgq2E3S3imn5/S1o1xP2kEmjh45Vh+TJOZRpSqNl9qKcDYNDSStAE28g
    oIs0MOpQ5NzQyRoUemEArvYDccKbwX54+M2vKDUbwKdvNSE/PDxjSCQtIFgc1eTe
    v75AuqCirVPoy3FlkhlKp8BP8D37WxmVx140jWaZpILKErGe0AnxWKuPWn2zv28l
    dtIUvgVqybszMhoxfTvmMzSRlZhqYv8AHPXK6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803199; bh=gQZkRvVIhJXujqMIHSuGZhXzVS
    2r4LakbJ9tuxn26KA=; b=H/uiTPRN52DkloNrM17iZo8S1mk77uYZYoupx7yLUJ
    m5uzNXVuqnkcjaNCnB0fo8WIQdcuuwrVAeKxMWU12Ve/IsPYCUl0pRC6fyMRTIkV
    61CHDRw9D5111XUG1rBlm81ILXWAX+kB29wXmMxBSgrkSGdRqXOUlJiaVCn85vny
    G50cpI1sLaLsTgdQ9npzwsC6ynwRmut5C+aeHFkokJnNMA4zuG8x447R6E4/DPxb
    XOS0Zl9Ht4HF9ZgPiPE+y2C6AT81lrXs9O72xlwJJ+w19N8vDrWcZFjgJCK1d1CD
    lfvFK4Kq/BGt8cuZFyHgIHbh624Fp6cUppX+sa5xKSeg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933106AbeCWKMO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:12:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeCWKMM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 158/177] drm/omap: DMM: Check for DMM readiness after successful transaction commit
Date: Fri, 23 Mar 2018 10:54:46 +0100
Message-Id: <20180323094212.159460222@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>


[ Upstream commit b7ea6b286c4051e043f691781785e3c4672f014a ]

Check the status of the DMM engine after it is reported that the
transaction was completed as in rare cases the engine might not reached a
working state.

The wait_status() will print information in case the DMM is not reached the
expected state and the dmm_txn_commit() will return with an error code to
make sure that we are not continuing with a broken setup.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -298,7 +298,12 @@ static int dmm_txn_commit(struct dmm_txn
 				msecs_to_jiffies(100))) {
 			dev_err(dmm->dev, "timed out waiting for done\n");
 			ret = -ETIMEDOUT;
+			goto cleanup;
 		}
+
+		/* Check the engine status before continue */
+		ret = wait_status(engine, DMM_PATSTATUS_READY |
+				  DMM_PATSTATUS_VALID | DMM_PATSTATUS_DONE);
 	}
 
 cleanup:
