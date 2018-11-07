Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F1EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3219820827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZP6YrUzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3219820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeKHAlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:41:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52489 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeKHAlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:41:49 -0500
Received: by mail-it1-f194.google.com with SMTP id t190-v6so17555409itb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VzTPwafaMZIoeoZRAErzMhggQ51vpWOhL3koJF7KPKc=;
        b=ZP6YrUzjmJGwuYB2LFHeoTrhPuBaFTP6YO4/Eslkk5uccAX+D603vGeg/vkXwEUKKR
         sTMPW03k8cf4uqJuCMRdy2rNhSUrw6ADnwph/lfIzVRd/wkxgiPwSWdJIrBaTOzeZd3p
         W6jeIAZfd6kxSMXZeergA3BwZiHACHigjeRCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VzTPwafaMZIoeoZRAErzMhggQ51vpWOhL3koJF7KPKc=;
        b=Nao+bdom0oW1JvCLj3p4tdRs92VXEOOvYXBmip+FxYIALAziuZV++2LgSUbzej6SCj
         lIIvNT9UbknLXuqIgHxlV39EaBc0OCx0pqClCygqsddBTjQKNf+uBbICwKTc20KHjB3r
         LrZi20Jkk28NCFrduil4DBMhLtbr0sOvgnlX1x2eoBhduG5fx3YuTXX5Zj1ThLgEChzx
         MBOPapTtmpKFi620NqeIKhpAIcZc9+DOsUy1l9Mvt1yg+XQeT9HHG/XnW5NlZpwPQm+N
         eAR/IKjBTEt6UJFVzUYdvLxhXBFJgu92PZjGyES3cTGjEmk5+6yaTJrM1vSWePU0HG0k
         cUrQ==
X-Gm-Message-State: AGRZ1gL56f92UTQongdyAQ+zQiNVWvtfJDmHyUAlpCyfZC4TvtpM3C/d
        Dym8cnD/fk/BtfXEHdYrY3uDiqAjnCXKOF+AgQZR7Q==
X-Google-Smtp-Source: AJdET5dm1hMR6ABy323siKAQcUWXR1M7jUlsiquitAkNfk8tkBWFI9TlcZpXmvhO0l/7F0vLGqyFVxws1sAQTMjoKNM=
X-Received: by 2002:a24:fe88:: with SMTP id w130-v6mr503117ith.69.1541603462989;
 Wed, 07 Nov 2018 07:11:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 07:11:01 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <000000000000c25cca0579982a05@google.com>
References: <000000000000c25cca0579982a05@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 16:11:01 +0100
Message-ID: <CAJfpegu3wunM+=psdDSsr1pQ23MJyKCSnz6LapHDg8nnFa+ASg@mail.gmail.com>
Subject: Re: INFO: task hung in fuse_sb_destroy
To:     syzbot <syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000cc46f5057a1486ca"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cc46f5057a1486ca
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
59fc453b21f7

--000000000000cc46f5057a1486ca
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-fix-leaked-notify-reply.patch"
Content-Disposition: attachment; 
	filename="fuse-fix-leaked-notify-reply.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jo7aw0hq0

LS0tCiBmcy9mdXNlL2Rldi5jIHwgICAgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgotLS0gYS9mcy9mdXNlL2Rldi5jCisrKyBiL2ZzL2Z1c2Uv
ZGV2LmMKQEAgLTE3NjgsOCArMTc2OCwxMCBAQCBzdGF0aWMgaW50IGZ1c2VfcmV0cmlldmUoc3Ry
dWN0IGZ1c2VfY29uCiAJcmVxLT5pbi5hcmdzWzFdLnNpemUgPSB0b3RhbF9sZW47CiAKIAllcnIg
PSBmdXNlX3JlcXVlc3Rfc2VuZF9ub3RpZnlfcmVwbHkoZmMsIHJlcSwgb3V0YXJnLT5ub3RpZnlf
dW5pcXVlKTsKLQlpZiAoZXJyKQorCWlmIChlcnIpIHsKIAkJZnVzZV9yZXRyaWV2ZV9lbmQoZmMs
IHJlcSk7CisJCWZ1c2VfcHV0X3JlcXVlc3QoZmMsIHJlcSk7CisJfQogCiAJcmV0dXJuIGVycjsK
IH0K
--000000000000cc46f5057a1486ca--
