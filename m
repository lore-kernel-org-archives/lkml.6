Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955485-2-10826258829213054422
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
    t=1520955485; b=mZxJ4aUBLKxToKscmYZ7AFAewbWGK9jiBQYjz6RpHSq3oXT
    i/HEg/ef8vh8C7Q1tYSNMmccYpaGfYFSARIQ+LGC/DB0Ey5MIc6KHUopdBjkEdAC
    JJixWsEp5jCUEeMWMwAygLxq0UaUqLgkG005/Hg3pqhf9gRJ2nCZv8q03CpetuoK
    1W4vrS6eVseloyC9ivghZoOcfq+RaNpmEa4WdeAkcXjKuvBImUtgiXazKFpDivUa
    hDkIYRc2QgJPnIuJbY2y9A/Zsu1/3Pb3m0hEPig2yEPUzQJtJ61hiGK2rPY8CcNj
    MasR90eVEySKLIeEclHuZhBim9Fmiwk+P4am04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955485; bh=Z91kvUldMRWCDs8XJid9y2FkpZ
    sraiyOMMzALwNIBV4=; b=HpQZ5t/i0vDOKoP+o5AIhuAY2CQyynzwslKuTNse+H
    V89ZaW9+1UquPsZO4iLGzc4hAb2Iet5itEdDuD8bOngh0rzYAnseN1me4yU1roS1
    b04k+fltfUKA1arqPVPWehxAxju5D6mo072GLdatgBjQT+PpjEcACYvec/pBhTKX
    caKwAbuIwywzgoEngJkothxIdKqgoPJloAZd2GX6NkbSZT+jCszQdrLoKBloB0Gl
    F+ZAbRZTG41t0FO36xHwbTyjSb9WvssvkJDzGmDycuUiMQwRGo4otyz4k+JdMJXq
    UHfifHLk4+2JQm4h2M1j6bJqqwSPRTgdkTlknUcNYivg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934377AbeCMPh3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:37:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932486AbeCMPhZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:37:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.14 052/140] drm/i915: Fix rsvd2 mask when out-fence is returned
Date: Tue, 13 Mar 2018 16:24:15 +0100
Message-Id: <20180313152501.755124343@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
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

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

commit b1b13780ab06ef8c770dd9cbe31dac549a11630e upstream.

GENMASK_ULL wants the high bit of the mask first. The current value
cancels the in-fence when an out-fence is returned.

Fixes: fec0445caa273 ("drm/i915: Support explicit fencing for execbuf")
Testcase: igt/gem_exec_fence/keep-in-fence*
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180214191827.8465-1-daniele.ceraolospurio@intel.com
Cc: <stable@vger.kernel.org> # v4.12+
(cherry picked from commit b6a88e4a804cf5a71159906e16df2c1fc7196f92)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -2408,7 +2408,7 @@ err_request:
 	if (out_fence) {
 		if (err == 0) {
 			fd_install(out_fence_fd, out_fence->file);
-			args->rsvd2 &= GENMASK_ULL(0, 31); /* keep in-fence */
+			args->rsvd2 &= GENMASK_ULL(31, 0); /* keep in-fence */
 			args->rsvd2 |= (u64)out_fence_fd << 32;
 			out_fence_fd = -1;
 		} else {
