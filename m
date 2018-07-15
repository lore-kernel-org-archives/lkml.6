Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07143ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48F7208CC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QLSB0X8J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mj31qsHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48F7208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbeGOCmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:42:49 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45331 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731982AbeGOCmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:42:49 -0400
Received: by mail-yb0-f193.google.com with SMTP id h127-v6so14218873ybg.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DOQ6Kj/Eo9xfk2zMByIvlhHr/Gh8nSXLCEOmckhUYdA=;
        b=QLSB0X8Jau6GQjAkrtYSHdAMHCzePTWovUhplYQBRilCXKQkJxN9a039TsIBdei2Xn
         EKuHFnN86W5IdVC18R/xHJD1EMpU0lYN8NededACUc+00lDhxh+fK7S6EPsLPrbuR9X5
         ebJ19rPGMolZqdFe+Xb6Tzn16oBXDM9d52wdeShWiPe0LLT4roboXIFCsvB1573GRXI+
         BIVx7VM3CXqAaDKMzF7/IWvaPJ5vOTv9ybNwy5cUqIL5BpAuT8w/nis5s/F+1jNMhr+N
         4gUv5s4eAgHSxTmTBLJeV8cNs6/NgzVKRMOnfbSKLPNimB3DZcxBZ0NilR8QLhwiyo6y
         7DzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DOQ6Kj/Eo9xfk2zMByIvlhHr/Gh8nSXLCEOmckhUYdA=;
        b=mj31qsHnsiQtDfXv7ggklifaqw9X+Zb1VrLFh/ErCfRqmJ9iXvycB7xDFZGREy91Vz
         5ORbwJxA8lmgMuR2HRpmAOP52oR8N5D4RrtxXWnbvnbMRM0lxVSNHoTp1cy0gwHXK8Bm
         8DfnoOS6kRgRKAXFVDF4GVydMfY7MIRevS9Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DOQ6Kj/Eo9xfk2zMByIvlhHr/Gh8nSXLCEOmckhUYdA=;
        b=kP6TwlLhp2kcqz9BYgQL8rY1H9k0AOewApCaU0yLFUilysT+igVQBVCIb+49/UX0n6
         +q49rO28V9HRYwhQJJe4D+m5mBIBRObyDKz5R+8ieaA8+OWy8B/Vy6pgSPUFusZ4F9nJ
         A1lJZQcGLQupIS5/JDDKbPuxS5vr9wIUiIM+uLV/mvkCA2x2GkWWYrVwg/kAERLEMzW1
         Ir41BSafS3S6jNLz/Oz50+L8J5ClDGkCGTjW557J7ngzYRDSbTSftq9awgBHfp8ArSsV
         vcfidpCUBVcWlclSK2h4+MLNYK/iff738QgOWXmcr8wdxMFzxXHawXuA3IdZ0WO1PntP
         bUcw==
X-Gm-Message-State: AOUpUlG/rHpfRp4jjxmiDW50di2RkvkYLRY1xtAW4lDAb0lyIHKF3fWL
        tDXMbBtMUu6aaIl6o9RBCGyXh+HdfvXt4LyPMTXFpw==
X-Google-Smtp-Source: AAOMgpdGhA45ZB4OzdZ5JFvYR4FamkDylEgDER5pnTRVbVoNCgUmsogAR0dFFWvF+3BAnRSsEnGLGO1Xc/BnhcjGUXY=
X-Received: by 2002:a5b:b44:: with SMTP id b4-v6mr6452906ybr.463.1531621299101;
 Sat, 14 Jul 2018 19:21:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:21:38
 -0700 (PDT)
In-Reply-To: <1531505163-20227-4-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-4-git-send-email-zohar@linux.vnet.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:21:38 -0700
X-Google-Sender-Auth: 7Tba2dRe8pEuTH5jd55OA3MVX8k
Message-ID: <CAGXu5jKDE0mPzi8RUhsViEwjhZX1=M-xU4DEa70tk3i2tN+rPA@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] ima: based on policy require signed kexec kernel images
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> The original kexec_load syscall can not verify file signatures, nor can
> the kexec image be measured.  Based on policy, deny the kexec_load
> syscall.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
