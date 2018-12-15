Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47C4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 23:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672482084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 23:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImSjZc82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeLOXqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 18:46:19 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42815 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeLOXqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 18:46:18 -0500
Received: by mail-wr1-f47.google.com with SMTP id q18so8798345wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 15:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ur3OrEYEaa0mAi6x8eqwycgKnxHDFZEOEatPjpOzPak=;
        b=ImSjZc82C+JryYGStXKneUA5AyHKJG5nADjxbxSivcCQlJQ3Qg+bgbqadDpJa0j4Cj
         WppabI5m4EqeGoODq6VzdMHtKoO+WL/DtVyMsXbQ7VKrCQGWppvUd7AM2duthF+yucUp
         EHYgo68QnkzaaqBAW+kto28rFBQh8+i1zYSCZulUB2xCMXeOb1qrSMaNzKT97KWF258N
         4Ezt3dIDBfUoG6g6tKuvd8KqcWkvNNei6O1NLY715rz2WfEI/GmbJpRigDhbG8Y473j4
         Fg+ZFtFFiws2i3sgqClrXB5GxsbgZ3oOyiy0lwIvwDzR/iRpK3ZPh2Up8bYWYc///Zws
         DUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ur3OrEYEaa0mAi6x8eqwycgKnxHDFZEOEatPjpOzPak=;
        b=L+UnLfXHT8iIk/WTRqsMS36usMgb04Qv9bUz7gmiHlB2Io/jqJHSVylqZZOZEMmW4S
         fwQNR5JBMIPSN3pW35hQC1IY9lg3Nvgzbr8hxznRzzSDsWYid6i4cxEET/etcSYluGLv
         gB0hQ/9cpyRTONmz0RnshQO56FRgES/bnHTMqChDlkKAtdF9LWxe4or+W063S/9Bk7yG
         faZx82DxnsGp9ToJkvv0oFLtyFW00BCkTdgnXmZZPZOF8qlENdDIYV5F+bAt0e8hCHxJ
         W8Tc6W7L63t7k4SM1yExC50GpXB9RAzy5xeyrfy8og00fkMc1lfdcqRTsFZ/NRA+IAYu
         ZzKw==
X-Gm-Message-State: AA+aEWZ/CBSoJvmy3Tj8VL6YBsmbo8r2C9K6In/xV7gMFNu7LOWhGAgq
        9swDVNZqL8uaLKNENeUY+ybFja4SoZSgjGjkwOk=
X-Google-Smtp-Source: AFSGD/VW9Z++cs34LftNytHkTkh86DDBqQDVE8lU/88JXJEShzKUbMI3V0NxjhCqKps2eH044A6iUc1gGzetKMdlbOo=
X-Received: by 2002:adf:c452:: with SMTP id a18mr6527262wrg.145.1544917576854;
 Sat, 15 Dec 2018 15:46:16 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Sun, 16 Dec 2018 00:46:05 +0100
Message-ID: <CACna6ryhfaOFS4qjZoLjJqcu5LQd05_jDndL5+GpADTHhu3_7Q@mail.gmail.com>
Subject: Problem with late AMD microcode reload/feedback
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to reload AMD Ryzen Mobile (fam17h) microcode doing:
echo 1 > /sys/devices/system/cpu/microcode/reload

The problem is I don't get any feedback. No error for the "echo"
command, no a single new line in the "dmesg". I have no idea if
microcode has been reloaded or not.

I did a quick pr_info based debugging and I noticed that:
1) load_microcode_amd() calls __load_microcode_amd() and gets UCODE_OK
2) load_microcode_amd() calls find_patch(0) and gets a NULL

because of that NULL load_microcode_amd() doesn't return UCODE_NEW.

Seeing above I've decided to debug find_patch(). It seems to be
calling __find_equiv_id(0) which returns 0.

The last step was debugging __find_equiv_id() and find_equiv_id(). It
seems that find_equiv_id() gets sig 8458000 that doesn't exists in the
equiv_cpu_table:
[19.736770] microcode: [find_equiv_id] sig:8458000
[19.736772] microcode: [find_equiv_id] equiv_table->installed_cpu:8392466
[19.736775] microcode: [find_equiv_id] equiv_table->installed_cpu:8392578

Has my microcode been updated? Is there a way to improve that
microcode loading code? Is find_patch(0) returning a NULL expected or
maybe a bug?

--=20
Rafa=C5=82
