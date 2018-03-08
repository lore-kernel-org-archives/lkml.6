Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2782356-1520539242-5-11880272943423723187
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520539242; b=Yqw5o8N8Zq7p3mZAE9Lc7hOD7zEm8e4ciHqH+yKujy0KeUE
    9zAqEVuaegdVAiwh2uU3XUMadH/buvtx6fcoq3nKGCAlY79GiQUMCO6gSIvJcyKR
    W2Vh/fFs4+ma9y+Bp3t8SbqBhm13Qi0Yrqlm4huksQp7uqLnNZB5n4nrbUfGWUVH
    WE961GQuDrXQMWGUoFyfxRmgxy1jk5SUu6l9+eUhqzho7zz5pNW/gEtlKrP0Ygmi
    zTuoP5H5hTKYbTrlnUIIUDJTsHOWzPkfksQXy5gFHbVW6Ff8Q0EN4EC3qEpO0WCd
    dB89i9cuRy6SVTez1Zn4Gqz9urED7ZFsr0CnSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520539242;
    bh=RGg8wESLv17NVUlDBQ5iQVVKi2EOLqPjFz9L3EAXW9c=; b=B3Jc6n8bgMLF
    +waanqAbBJpg0X9UeWICYB2RnfrlAgw62T33orXwkxkaGeGdfhU0XZq7SBMx8GsN
    2wqSGOnX5565BFBPBeg+m4duRqXd20hXs2z3sS++m6+9S60MUShA9rvimrN3s+qp
    1tghBeXWaiACHO3Apbx7cB0i49+9bT4dyoUBut6F0WDGsnXcwbwpbk4PcRk0AC41
    Rn8pA4+z/+9T1x9JJwAD88cWSpvH8frJLJiYPlX/Fzx6HlbylyQtDBjSIHzntXvU
    ofpScJk64xYhjD9GBqjcySORIoZArqX7JOtejDaN27eL1OBL53igA3K9dRYbL6bg
    9YWI29pw9w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbeCHUAk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 15:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbeCHTwN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83292177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/54] perf intel-pt: Fix timestamp following overflow
Date: Thu,  8 Mar 2018 16:50:08 -0300
Message-Id: <20180308195029.14991-34-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adrian Hunter <adrian.hunter@intel.com>

timestamp_insn_cnt is used to estimate the timestamp based on the number of
instructions since the last known timestamp.

If the estimate is not accurate enough decoding might not be correctly
synchronized with side-band events causing more trace errors.

However there are always timestamps following an overflow, so the
estimate is not needed and can indeed result in more errors.

Suppress the estimate by setting timestamp_insn_cnt to zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 5e4d0bbafc8b..f9157aed1289 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1378,6 +1378,7 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 	intel_pt_clear_tx_flags(decoder);
 	decoder->have_tma = false;
 	decoder->cbr = 0;
+	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;
 	return -EOVERFLOW;
-- 
2.14.3
