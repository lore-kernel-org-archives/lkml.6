Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC65C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B678208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqS2kSML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B678208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933306AbeGIUfD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:35:03 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:41643 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932856AbeGIUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:35:01 -0400
Received: by mail-qk0-f172.google.com with SMTP id d22-v6so10403180qkc.8;
        Mon, 09 Jul 2018 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZlzgSFpkDoQcsrQ8lOA4YF6C/+wDIgtsnjQZ0XhGZKg=;
        b=LqS2kSMLt7xDucoVDEOkZScCWs3/3yMWLx0rKNRCCZ28Y+aeWkZkvsgXQ6yFW5kala
         YlULFpKQcAWlnoslhGmSO7K5YLS+cJhcSAfVnExooVQxBxR+YX0cbcXIiEyL2y205Ixa
         uc2XDORFfFvW657tbCWujk8prbGoXLypW13O1ufK0U3ajQ5oFDK24qMBhw+29Ql8ODwf
         AoS2XOQtaoOR7B6rAJtFV8VXcKpdbEAN8vjAh1doux7JiRqnfcDxGAKY+I1s3wvCMe5U
         uzOrXe2rq+elxgSc9+pc0G8S4G8JDwvdzpIH5Q8dvjXU+j+egl5g6HPAlsf2A8jWsAsF
         sw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZlzgSFpkDoQcsrQ8lOA4YF6C/+wDIgtsnjQZ0XhGZKg=;
        b=foMj/icp4atPD+hv6IXos0W4JL3YErsFzGFARKr/TqHSEkF1wHTsLOlYlXcb9O84cI
         KFN3swPqlTusGem7NulJWSCdPkvKBEEO2dELS/7SYIlly9MrVlOuPmT3anuDcD1QjRMV
         8DjxrLsdbzNmy2XWFbL/DdllXAqd7tdKXSyeTrI9cFnxAa4Ofc4A0NWGKFA2LSBJtF12
         mbecV/fQ4V35n2JLIAl2qHiVKk/B/TOfcN6hglYGx2Bn6xREpNoCwyDevU1BxW7XFL2F
         j8u6cs3Ius6v9xGAPh4bpcpqyg51dlG45Ec6Sh3CnOR9LYj76lJT+iY0S02V4jWkhZiw
         rNwg==
X-Gm-Message-State: APt69E1oNHBCZOhX0ynYNy58tPvynZELI9lGaZ2ZzWaaRZu2sFk0ihPC
        f6RGgui46WxMm073tZeOY//LXA==
X-Google-Smtp-Source: AAOMgpf2rtZHAVg/6DUZpECQf5cIIWKeUaYEZNPBhfKbynFZgId1kg7oeZ5afpnxA4SdbFqFTHakdQ==
X-Received: by 2002:a37:289e:: with SMTP id o30-v6mr18848706qko.432.1531168501124;
        Mon, 09 Jul 2018 13:35:01 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id e33-v6sm619445qte.54.2018.07.09.13.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 13:35:00 -0700 (PDT)
Date:   Mon, 9 Jul 2018 17:34:56 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
Message-ID: <20180709203455.fbmx45ehrsj6yjzr@eaf>
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf>
 <20180608152557.GB11958@amd>
 <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 09:43:26PM +0300, Anatoly Trosinenko wrote:
> And when I mount hfsplus_16mb_hang and perform `echo > /mnt/xyz`, it hangs.

I just sent you a patch for this final report. Let me know if it works
for you.
