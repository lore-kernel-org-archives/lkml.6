Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B38E213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="czu55pSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfAJWd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:33:27 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:36587 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbfAJWd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:33:27 -0500
Received: by mail-qt1-f172.google.com with SMTP id t13so15841572qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9qoiFCTa+4CEViWe1tbFkHCZIHovA/zc787QU1XEFU=;
        b=czu55pSEhzvQtwWPRIOOLqlPojsj0fgwOmVYlNm3jDHAqqKQS/NrapHkg2NbisDI/s
         sn9Uh18HXtg0dK7oDkXT0y399QCQoB0uNJ6rPFMEgL79ncIkufNvGIF1k/d+w6CeQHZ7
         00Lk93HDS+cRbhhzWvEvliHcCnR2cyvytcdhmh4F9Nbt/3Bzm0108mIH+2pKw4Ce019m
         naxjrnF+f5H0eneOB+hIb6i7eBqJFPdbtD6VrlcTMUTH1oAJv/1tvmKDFcvW2Dxm8DKz
         98ieXjVDnaUcwRnjouPIPVFQF1EVDNSBBaoTwkqTaVeBSSAvNhrbW++d0/i5j69rQqjF
         86cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9qoiFCTa+4CEViWe1tbFkHCZIHovA/zc787QU1XEFU=;
        b=AI8yHgKZlg7yC6B9BSsvkZGvB5Upku+qANcpKbXtA8lSH3zfpqhPrLAII57r7oXsru
         +1nERDZFcExB1utqKd0BfR53yVsP1ZcVnzvTExYWfGLrY/OKBtkV3DEJ5uy8Tl4qwHNk
         b9EUuohD+OQWzjzPWjb2VFdfPhi1MgFvPuFihxI0elQdk6t8z+Lu6fmSEOdIcDjTbQEN
         /00ii1K/6F7CmSXW7oysLwG5CwGCtczNWJ6okIp78yLN9yzyquG2wxhTOVWANWbbWabU
         l9wtqWy1z7/HhrAD4qthm/y2wrak+YVlyE29GGSBv2Aci2mNEMCfAfExMJ7+1TJI+qIQ
         EFyw==
X-Gm-Message-State: AJcUukdGtUKTsFHw6uVPbx6LX+Qs+UiIpiWHGS1zv1NBBeN5rAiJrQDJ
        cCOfdy+Ld7BjS75NoHprERYxlXXorPBgbw==
X-Google-Smtp-Source: ALg8bN7rW7MWjyiCO0xojQk/waEuZTxto6KEDZike+X8N+8My2jNkLH/Qpzwocssog/lkmhL9Wl9zw==
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr11693764qvb.218.1547159606191;
        Thu, 10 Jan 2019 14:33:26 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d193sm47864814qka.91.2019.01.10.14.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:33:25 -0800 (PST)
Message-ID: <1547159604.6911.12.camel@lca.pw>
Subject: Re: PROBLEM: syzkaller found / pool corruption-overwrite / page in
 user-area or NULL
From:   Qian Cai <cai@lca.pw>
To:     Esme <esploit@protonmail.ch>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Date:   Thu, 10 Jan 2019 17:33:24 -0500
In-Reply-To: <hFmbfypBKySVyM6ITf55xUsPWifgqJy6MZ-kFJcYna61S-u2hoClrqr87QTF4F2LhW-K42T2lcCbvsEyGAL0dJTq5CndQBiMT6JnlW4xmdc=@protonmail.ch>
References: <t78EEfgpy3uIwPUvqvmuQEYEWKG9avWzjUD3EyR93Qaf_tfx1gqt4XplrqMgdxR1U9SsrVdA7G9XeUZacgUin0n6lBzoxJHVJ9Ko0yzzrxI=@protonmail.ch>
         <1547150339.2814.9.camel@linux.ibm.com> <1547153074.6911.8.camel@lca.pw>
         <4u36JfbOrbu9CXLDErzQKvorP0gc2CzyGe60rBmZsGAGIw6RacZnIfoSsAF0I0TCnVx0OvcqCZFN6ntbgicJ66cWew9cOXRgcuWxSPdL3ko=@protonmail.ch>
         <1547154231.6911.10.camel@lca.pw>
         <hFmbfypBKySVyM6ITf55xUsPWifgqJy6MZ-kFJcYna61S-u2hoClrqr87QTF4F2LhW-K42T2lcCbvsEyGAL0dJTq5CndQBiMT6JnlW4xmdc=@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 21:35 +0000, Esme wrote:
> The repro.report is from a different test system, I pulled the attached config
> from proc (attached);
> 

So, if the report is not right one. Where is the right crash stack trace then
that using the exact same config.?
