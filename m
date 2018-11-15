Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88491C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8DA2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vl8j+NuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8DA2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeKOMRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:17:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37868 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:17:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so2279281plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 18:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=49XnI6arT3v1CXSoUHRBjliSSvBvOE3PSXedAJX9RgE=;
        b=Vl8j+NuXm7IDyt/0WCP0xu45sw5GqnDLbNanJ3DwiP6tjnwbZqxMUoYOG608UMoQpy
         7TqC+enn2OVpTqKP8+hnsl7B4tmzXTTqaSLs9FBFySk+zO5xFdWG6abZjtVYncXfVSvc
         qs+DPFwLTEKjLruxSu/IcX5qpemqnX4LTeGEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=49XnI6arT3v1CXSoUHRBjliSSvBvOE3PSXedAJX9RgE=;
        b=levBx1LxKSnb4FeoQRdli9yxiSuzddgajILIAEeCdgAoo54hH6gNjzpsj7CUm1HjjF
         c3kffmyVwYpARh6KWeDT3ZoMX1tRp9Y+dlqX3gA40xZB5tgpKaqyKDvg+FNfbnyg4tSB
         xmrVXj9R7x4xSxqefXJ4dkE3Hv950oafkkmTe+mVwLfkgnoUz46f/MmK5egJLeMnzuq8
         lmbFuNqs1/sQ14GithA6apF96Cuax8jZ0Wd06FWkUTvWRKCuCD1TPOGeiNv1G5e2ZovX
         HeCRGxOrhrApIq5cFApn+xmePMzupGB2QuAXTrvyHVMl+C6GXl9DKrYP/2wir1ipccNv
         xugw==
X-Gm-Message-State: AGRZ1gKKyVxjDHcJ7frXK/uyf0O4WUW6Z5LuZ9tCB8DjQwb1xJaTAvUW
        XckGcb47I6X7/rY5crIqLuEhyw==
X-Google-Smtp-Source: AJdET5cD6xRTR7Kzvn+ky+fl2bnBePtCZU1bW7xnNj2OODp8rswbNy1Q5kTTdAOfsy99PtlDkiypxA==
X-Received: by 2002:a17:902:8604:: with SMTP id f4-v6mr1298021plo.206.1542247881596;
        Wed, 14 Nov 2018 18:11:21 -0800 (PST)
Received: from google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id h17-v6sm36555915pfj.125.2018.11.14.18.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 18:11:20 -0800 (PST)
Date:   Wed, 14 Nov 2018 18:11:18 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     yamada.masahiro@socionext.com
Cc:     Alexander Kapshuk <alexander.kapshuk@gmail.com>, sky@genki.is,
        yamada.masahiro@socionext.com,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        schwab@linux-m68k.org
Subject: [PATCH v3] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
Message-ID: <20181115021116.GA195691@google.com>
References: <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
 <20181111.174140.002789201@genki.is>
 <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
 <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
 <20181113000938.GA16783@google.com>
 <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
 <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
 <20181113190335.GA50985@google.com>
 <878t1w7hzi.fsf@igel.home>
 <CA+ASDXMuovgar22Z=sTcY=EV4KFtpwpjgdFOqvqAUYZEykzcWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXMuovgar22Z=sTcY=EV4KFtpwpjgdFOqvqAUYZEykzcWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

git-diff-index does not refresh the index for you, so using it for a
"-dirty" check can give misleading results. Commit 6147b1cf19651
("scripts/setlocalversion: git: Make -dirty check more robust") tried to
fix this by switching to git-status, but it overlooked the fact that
git-status also writes to the .git directory of the source tree, which
is definitely not kosher for an out-of-tree (O=) build. That is getting
reverted.

Fortunately, git-status now supports avoiding writing to the index via
the --no-optional-locks flag, as of git 2.14. It still calculates an
up-to-date index, but it avoids writing it out to the .git directory.

So, let's retry the solution from commit 6147b1cf19651 using this new
flag first, and if it fails, we assume this is an older version of git
and just use the old git-diff-index method.

It's hairy to get the 'grep -vq' (inverted matching) correct by stashing
the output of git-status (you have to be careful about the difference
betwen "empty stdin" and "blank line on stdin"), so just pipe the output
directly to grep and use a regex that's good enough for both the
git-status and git-diff-index version.

Cc: Genki Sky <sky@genki.is>
Cc: Christian Kujau <lists@nerdbynature.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v1 -> v2:
 * handle empty (non-dirty) results properly, where
     echo "${empty_variable}" | grep -qv "${something_else}"
   always has a 0 exit status (a blank line is an inverted match for any
   non-blank expression). Just pipe directly to grep instead, with a
   hopefully-not-too-permissive regex to handle both versions.
 * actually tested with dirty and non-dirty trees this time

v2 -> v3:
 * switch to extended regex (-E), instead of relying on GNU extension
   (\?)
---
 scripts/setlocalversion | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 71f39410691b..365b3c2b8f43 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -73,8 +73,16 @@ scm_version()
 			printf -- '-svn%s' "`git svn find-rev $head`"
 		fi
 
-		# Check for uncommitted changes
-		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
+		# Check for uncommitted changes.
+		# First, with git-status, but --no-optional-locks is only
+		# supported in git >= 2.14, so fall back to git-diff-index if
+		# it fails. Note that git-diff-index does not refresh the
+		# index, so it may give misleading results. See
+		# git-update-index(1), git-diff-index(1), and git-status(1).
+		if {
+			git --no-optional-locks status -uno --porcelain 2>/dev/null ||
+			git diff-index --name-only HEAD
+		} | grep -qvE '^(.. )?scripts/package'; then
 			printf '%s' -dirty
 		fi
 
-- 
2.19.1.930.g4563a0d9d0-goog
