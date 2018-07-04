Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7C4C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710C5214FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUrkBc/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710C5214FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeGDQMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:12:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52423 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeGDQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:12:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id w16-v6so6699804wmc.2;
        Wed, 04 Jul 2018 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1+p9b+LCmWWXlgBO9U2gIRmHIMr9ZtDZ3wIWXvfh50g=;
        b=JUrkBc/ZMJp7DFVNXRgOWZ1b1JuahTQP0TI2l7WYBabfFjr9pGJRCGH7KcsySBR1KY
         CwvEzJxGmUD1kOrQahj7uLjWwn4Of43GZTTunHvHNObCoaZ13Aztc35pBxLksRjGA7gl
         jqCBQcTlzvNxJ/7xciqIpNqUKseloNR4YlakSZ3B+Hp7Qx+kB5NQdwoc4XxerJKeBLJD
         WxOtj4dkNEMJ5AnV7+N5ciaGL146mMRlyqQ859kHC6BnS1i/6Z3ihnYAEFtM7x0ISvPY
         FhV2wWii6oMtCNFsVxzNfbvdXqZU7GYXO2kDkISmnmYvp+FnKA9dV8CjxLDxVI6mpNjq
         UKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=1+p9b+LCmWWXlgBO9U2gIRmHIMr9ZtDZ3wIWXvfh50g=;
        b=YPrhorwKgL1Ghwvm/+PYUZuEjTsBKkQosnSXgVV55qiSzo4pbDqAmrUHTcsJtwLxmd
         vGNgs1bwo8hcBNMCoVosHeyoxt4GmXBG/YexU5HGCQKR5uCnlWpn1C+8GgoyZh+BBJbd
         Y61ZEkKiFSEa2QFvj6cqolssku2VU1zrLDuwDvII56yCEjw3JjpuEnMU9Dd9pm0DKQkV
         gRjxdJo8tjbJpRUAyTqIeA6B03trRVVqum5VCMqaRcxGYMxJEYqbaUX+am4dWYtOJV9j
         AkCWIkcLkLDu8sWDcRzkFxXe/lo91Z27yhaIkgRrGOYdtMN9oG6WSgDOpWCfAKEJi1TO
         6klA==
X-Gm-Message-State: APt69E0SJ+CzEDhSmvISi3c7iWLjf9dXjYyXAMg8GgepUGzjEqyc2vIN
        gBS0pEVJVpke3/CATi8bzRkkWVTm
X-Google-Smtp-Source: AAOMgpfho7rdN5SYlqWChorhK2K1iJMxsHAZOIhHjkRXX4M1QUcnPVUEj/n7suXqy/COz0/H+QczjA==
X-Received: by 2002:a1c:5752:: with SMTP id l79-v6mr1883304wmb.103.1530720722022;
        Wed, 04 Jul 2018 09:12:02 -0700 (PDT)
Received: from donizetti.redhat.com ([82.84.124.111])
        by smtp.gmail.com with ESMTPSA id z9-v6sm7607016wre.49.2018.07.04.09.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 09:12:01 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Subject: [PATCH] checkpatch: handle token pasting better
Date:   Wed,  4 Jul 2018 18:11:59 +0200
Message-Id: <20180704161159.30570-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mechanism to find possible type tokens can sometimes be confused and go into an
infinite loop.  This happens for example in QEMU for a line that looks like

         uint## BITS ##_t S = _S, T = _T;                            \
         uint## BITS ##_t as, at, xs, xt, xd;                        \

Because the token pasting operator does not have a space before _t, it does not
match $notPermitted.  However, (?x) is turned on in the regular expression for
modifiers, and thus ##_t matches the empty string.  As a result, annotate_values
goes in an infinite loop.

The solution is simply to remove token pasting operators from the string before
looking for modifiers.  In the example above, the string uintBITS_t will be
evaluated as a candidate modifier.  This works as long as people do not
write things like a##s##m (and fails safely with a false negative if
they do), and it fits nicely into sub possible.

For a similar reason, \# should be rejected always, even if it is not
at end of line or followed by whitespace.

Reported-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Fixes: 89a883530fe7 ("checkpatch: ## is not a valid modifier")
Cc: Joe Perches <joe@perches.com>
Cc: Andy Whitcroft <apw@canonical.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c05506e325..0cd8307575e6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1915,10 +1915,9 @@ sub possible {
 			else|
 			asm|__asm__|
 			do|
-			\#|
-			\#\#|
 		)(?:\s|$)|
-		^(?:typedef|struct|enum)\b
+		^(?:typedef|struct|enum)\b|
+		^\#
 	    )}x;
 	warn "CHECK<$possible> ($line)\n" if ($dbg_possible > 2);
 	if ($possible !~ $notPermitted) {
@@ -1928,7 +1927,7 @@ sub possible {
 		if ($possible =~ /^\s*$/) {
 
 		} elsif ($possible =~ /\s/) {
-			$possible =~ s/\s*$Type\s*//g;
+			$possible =~ s/\s*(?:$Type|\#\#)\s*//g;
 			for my $modifier (split(' ', $possible)) {
 				if ($modifier !~ $notPermitted) {
 					warn "MODIFIER: $modifier ($possible) ($line)\n" if ($dbg_possible);
-- 
2.17.1

