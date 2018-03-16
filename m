Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214527-2-12512761197348849230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214526; b=XYir68Wd9LUWQtBu6zaSrMv1qyxovl7ImLAP7dKn9EPYDas
    XdD98hnSPqbS9GOaHvAFhPb+CC/g5U7bzdZnEP/0MpuG98YINqsDysy56eFWR/SQ
    omrT65eMDO237WR+FDauzI5I/LMw3OY/ad+fzveIj6RVmVcq3s1XC0lj9Z1RLY+g
    1AcgGPGC1SB3f42Fd8YtskZ39CvJp4R+V6aksOMitjIr/vRFyMP0LfakGnGfOjJn
    UrLpyff4M+sm4fMjkvZIAq4eno6AEmKkQgbP4OqPReuwRh9z7mc/0jb1aS+BGqGx
    5bFi4ZSXrfC+C4+LJXyy5eRsd/qy/if/hZ474zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214526; bh=v4W3jJw+ROkgwXHqKIzjdq24Cv
    hqsM8wSupBpy9Kzg4=; b=G7b3tF3jwKFzsPbEKdRaFam8EuaaCx3hP6MUmf+nap
    rOCF/cWpAZLKdkSfChWnuH2SUNgZzVqZu+r5ngZCnm65FJfEcH/b90+cOkrTJPOF
    lWaNuRYNLkhBCJD8gSt66X6VaHYeKm8+7pKA2XP4ykrI7CzLLwdAy+wfF3+lVaMg
    pKpSXYUMpRA1Ro4R7wxrFV0DiQEr6PzJ+fK4t0CgJG9LNI8bOYt7x6ApDw03hCd8
    ZcOwMhR3ei/AIf2YNMNLfDl2EIlJ3BT5q7QjivRqbomQqxmnJb9hZ0LEjKnb1RbR
    d1z0DjPH96AvIj5Czq82Iw/vHxEfDppOJLF1GhBdUTlw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S934078AbeCPPfH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:35:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934026AbeCPPfF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:35:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 007/109] ASoC: rt5651: Fix regcache sync errors on resume
Date: Fri, 16 Mar 2018 16:22:36 +0100
Message-Id: <20180316152330.232760180@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit 2d30e9494f1ea320aaaad0cff9ddd92c87eac355 upstream.

The ALC5651 does not like multi-write accesses, avoid them. This fixes:

rt5651 i2c-10EC5651:00: Unable to sync registers 0x27-0x28. -121

Errors on resume (and all registers after the registers in the error not
being synced).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/rt5651.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1694,6 +1694,7 @@ static const struct regmap_config rt5651
 	.num_reg_defaults = ARRAY_SIZE(rt5651_reg),
 	.ranges = rt5651_ranges,
 	.num_ranges = ARRAY_SIZE(rt5651_ranges),
+	.use_single_rw = true,
 };
 
 #if defined(CONFIG_OF)
