Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806716-2-13634442893530255672
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
    t=1521806716; b=YaRnX28KBBElwB6hnBksw/QvcTbe+xpWDkvxSyE4Tltt2ON
    45Hmvmk19FzsRsSJ9gM4i+JgpNJvqiGJ1HxiYVm4k8pvu6yHrfeKlk+GjyO+Rj64
    VQMuhs2Lb2DsUTAfYlzUTYUb0c0+KfYCZLhsUOg8pLOa11bcYfpEbjd4bglD53bR
    TEW2pk15BV4T4l6EgHaJXiOzDHfKu9bnfhM260XvuHEskc0wu7mVd/em5jnyAZXi
    k3/nnvRGgcqc1yq9Py0B9P1MK+YMqm+MVNcCd8Y2CeC26oIwEFajVulmhXpTtx/6
    1ZxD6dg910lIt22Fu7o5UEZ9/Py1F6spGV/Pw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806716; bh=OH3iyzhLzvqisTeF8JNDuqmRBd
    pOeJom6NZUOVsuTss=; b=aC1v1AKlnNBvpsjmOHHbGZrECmzJk6ZJ+0nB60zf4I
    Ha5vvVS8VRqUAYf9Wol8KHBYacPp1HEphIqTFMXvAIrvWFZhyN/uOZaRKF5Ad5JH
    NXfOYIpjXRNYGuOV5QgEQ5R8QlCjhcS8G0yZRwGdYY0leGqsQZkQQSKD/ULPOz7y
    QPA/TqyYc2gSmkEU204uh6QjFSSiQXbJTGah1DG0ts7D912EKzNbqHjPfeQmfeCb
    Sz44C8A1bq2WuWep3e6HZ9oXb8LJBctJeCrF3ZBGArzBeusIJfD0wwoCs701jWIe
    9xJNsNl0PcM/q/XIeyoZMjC66iQSbl1lhe7ouOstOdnQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1752892AbeCWJ7S (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeCWJ7Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gary R Hook <gary.hook@amd.com>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 75/84] hwrng: core - Clean up RNG list when last hwrng is unregistered
Date: Fri, 23 Mar 2018 10:54:29 +0100
Message-Id: <20180323095423.243279414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
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

From: Gary R Hook <gary.hook@amd.com>


[ Upstream commit 0e4b52942b1c76f89e0dcb829f72e123d0678f54 ]

Commit 142a27f0a731 added support for a "best" RNG, and in doing so
introduced a hang from rmmod/modprobe -r when the last RNG on the list
was unloaded.

When the hwrng list is depleted, return the global variables to their
original state and decrement all references to the object.

Fixes: 142a27f0a731 ("hwrng: core - Reset user selected rng by writing "" to rng_current")
Signed-off-by: Gary R Hook <gary.hook@amd.com>
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/hw_random/core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -306,6 +306,10 @@ static int enable_best_rng(void)
 		ret = ((new_rng == current_rng) ? 0 : set_current_rng(new_rng));
 		if (!ret)
 			cur_rng_set_by_user = 0;
+	} else {
+		drop_current_rng();
+		cur_rng_set_by_user = 0;
+		ret = 0;
 	}
 
 	return ret;
