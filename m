Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2B1C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 12:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F502054F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 12:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F502054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeJ0Uwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 16:52:49 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:28359 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbeJ0Uws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 16:52:48 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 970F17FA3C;
        Sat, 27 Oct 2018 12:11:53 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [IPv6:2610:1c1:1:6074::16:84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id EFE708F0CF;
        Sat, 27 Oct 2018 12:11:52 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id DAADCCBF2; Sat, 27 Oct 2018 12:11:52 +0000 (UTC)
Date:   Sat, 27 Oct 2018 12:11:52 +0000
From:   Ed Maste <emaste@freebsd.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     David Drysdale <drysdale@google.com>, linux-kernel@vger.kernel.org
Subject: : [PATCH v2 1/3] namei: implement O_BENEATH-style AT_* flags
Message-ID: <20181027121152.GA70269@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027075348.GN32577@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the proposed semantic of O_BENEATH with absolute paths -- I
> believe you don't have an openat(2) on FreeBSD (but please feel free to
> correct me)?

openat(2) is necessary for capability mode (since open(2) is not permitted),
but it turns out it was actually added to FreeBSD earlier than that - the
work was done by a student in the 2007 Google Summer of Code.

From the proposed man page change:
| If the specified path is absolute, O_BENEATH
| allows arbitrary prefix that ends up in the starting directory,
| after which all further resolved components must be under it.

For open, and openat(AT_FDCWD), cwd is used as the top / starting directory.

Once the absolute path traverses the "top" directory in namei all
components must remain within.  The proposed patch allows paths that perhaps
enter, exit, and re-enter the hierarchy -- for example, if /a/b is the top
then /c/d/../../a/b/file would be allowed.

(If you're interested in taking a look the proposed change is available at
https://reviews.freebsd.org/D17714 )

In capability mode absolute paths will always be disallowed.
