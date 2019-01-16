Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493EEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104D020840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8CIbspX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfAPTfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:35:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36669 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbfAPTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:35:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so3292124wmc.1;
        Wed, 16 Jan 2019 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrPxhlb7BOJm1W7LMJvNRL/533q63zubHmBUiRd9GLQ=;
        b=S8CIbspX5gnYj1jBCbD6i8haBFAzTm703HD3EVRQgiB4BVEGWCzcMKdlC7U8y3zWfL
         jws219DtEoZWcvO6zpoggZuF60N4Dx+tbTl5pB9fxZENtz4F6D+2/O6TibMdgZXse4Iy
         xSDicTJiCoCTo7N80DjbqmZkFtI70Jv9rp44KnGynWzYxwWx6hmgDfhJ0gNg822keWWL
         bC3CA/w/VBVtPYxt+4xlh6frnjwf3QHrqSLlmFufoJo0rQnZB+ZePAcYmR04Aa3mLMlE
         zcr5MBEWu958pj7m9qiwRlJLuZgDRCfY6k5GYnh03bup3TzADDzJpfaD4m5mEjYi+BJ5
         rAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VrPxhlb7BOJm1W7LMJvNRL/533q63zubHmBUiRd9GLQ=;
        b=i3FLq12jeoMk5zaQuiJLcbbzwMETgYTqdQ7V5PZoIqqOfMAY/re/JwBiyz7ME/reln
         07+a3jqPEwTmR+1G45eCw+xyFT1ZR1kI+bJkZ1as6Z6xN0AqwIPiGtwbHECfnJlLNA2m
         PLtNkVaBKEHIQanhexP//kmn/mKzflY6bmY3gb8V/Q+xjkyzPzFtULsizNABKOE2zIEv
         zgLjc1zdxXXLLrVBXNigp+2Ui2N6Y3BhE8Bsh2BRpL9Me1jmtdxzDi6eG3NIWqbZ61To
         gKC5lD454J++whHyOhcncxckS8jSZIaBklS0TpS57HoUOn/sjgCCLtkpIrqbq0Qa2kDd
         hFiA==
X-Gm-Message-State: AJcUukfk/S4ubhugkJMoB828S5/jB3bZWvNFZ6T4yLzLI8aM6pUT/B0e
        PLOY3zcTp2gqh1GCtXH4M10=
X-Google-Smtp-Source: ALg8bN58U+pvifKrPjXAVGpYOpEa/oAKq0mY7joYckoWSY9ecDGHU0BekgUtq42J3ZjK7D/ghnXHFQ==
X-Received: by 2002:a1c:7f0c:: with SMTP id a12mr8491973wmd.89.1547667349817;
        Wed, 16 Jan 2019 11:35:49 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id x186sm40123976wmg.41.2019.01.16.11.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:35:49 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 0B41611423A3; Wed, 16 Jan 2019 20:35:43 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] bpf: Correctly annotate implicit fall through in bpf_base_func_proto
Date:   Wed, 16 Jan 2019 20:35:41 +0100
Message-Id: <20190116193542.32558-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114202941.16183-2-malat@debian.org>
References: <20190114202941.16183-2-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warnings (W=1).

To preserve as much of the existing comment only change a ‘:’ into a ‘,’.
This is enough change, to match the regular expression expected by GCC.

This commit remove the following warning:

  net/core/filter.c:5310:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: reword the patch subject, remove a typo

 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2b3b436ef545..d9076e609fca 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5309,7 +5309,7 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_trace_printk:
 		if (capable(CAP_SYS_ADMIN))
 			return bpf_get_trace_printk_proto();
-		/* else: fall through */
+		/* else, fall through */
 	default:
 		return NULL;
 	}
-- 
2.19.2

