Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218676-2-7974669758702729849
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
    t=1519218676; b=XPmGfsqZc9l/8/pQWl8XmCyRoRBrryK111i5J8oWJWuXUyi
    oezb7V33AAW4HfpQvHWDAYf0j2vtI33kXUdCwCnQKG6V4NQMu5N03z9o0aYNyQrJ
    cq+AFmImP0XR5aoAHmaRy08vdigtg6BQxeGgaOjKFwSiq6KthX0A0znCGvRUilBJ
    1rs8CK35b7BrjHAiGJROF75weZTlHDlRdn9JvrqzVElYXqlmD8Gbqt1qz8s0JAWw
    flnTS5OaSq6HLiogemoOq3rtlV/SV5m/IIL2Zdk2HTwyuv/P4zdc8vAwwf9djPyP
    1WCKId29ClagmSlbh6PQ/ZtbPYM3UomNr82kg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218676; bh=3WF27ibOTssIxDxpMzhHALqjHU
    3hhHIOwk1ZwXwkSNE=; b=DebNKRAgfalKD/1bK2t6MEXIhpszkXO95yyaIYb3z+
    8z62BCbGQzP+KqvZw9xMaq3W+c9CxhRwlgDpW/xnFYRMxtF+brcPjGNO/nsG1C1r
    3RnXzFwt5DhPIZ+QwyID+iPlWzYIW2gRQEWeVtVm+5r5nlI7OH38wCgRIFtdsNH4
    QX+diyqdlvAwGXj78NHMoXyNedprNJkW7iUYbs4xJaT6DwKolcp5V8yhAiF8dfAe
    xL/Yzu+mLQX24N52QFmY0WbtUESpdH3OxlykITOGK7GZ6qs3vwWgwhj8qHXrtvEm
    nqBPStbi9abqyWS6XW4N870A/C9gIMubTrwdYDmPe2Ow==
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
        id S936296AbeBUNLL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:11:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936292AbeBUNLK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:11:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Packard <keithp@keithp.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.15 094/163] drm: Check for lessee in DROP_MASTER ioctl
Date: Wed, 21 Feb 2018 13:48:43 +0100
Message-Id: <20180221124535.525590662@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Packard <keithp@keithp.com>

commit 761e05a702f5d537ffcca1ba933f9f0a968aa022 upstream.

Don't let a lessee control what the current DRM master is set to;
that's the job of the "real" master. Otherwise, the lessee would
disable all access to master operations for the owner and all lessees
under it.

This matches the same check made in the SET_MASTER ioctl.

Signed-off-by: Keith Packard <keithp@keithp.com>
Fixes: 2ed077e467ee ("drm: Add drm_object lease infrastructure [v5]")
Cc: <stable@vger.kernel.org> # v4.15+
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180119015159.1606-1-keithp@keithp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_auth.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -230,6 +230,12 @@ int drm_dropmaster_ioctl(struct drm_devi
 	if (!dev->master)
 		goto out_unlock;
 
+	if (file_priv->master->lessor != NULL) {
+		DRM_DEBUG_LEASE("Attempt to drop lessee %d as master\n", file_priv->master->lessee_id);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	ret = 0;
 	drm_drop_master(dev, file_priv);
 out_unlock:
