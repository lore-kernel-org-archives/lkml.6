Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C58C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19725219F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dds.mil header.i=@dds.mil header.b="VCdbRcZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19725219F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dds.mil
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeHKW4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 18:56:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40328 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeHKW4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 18:56:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so6384715edq.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dds.mil; s=ddsmail;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LcNWrfTv4aBkmjrm5jdJhkNlfmcxrQ8wohPuD+EwlzM=;
        b=VCdbRcZuNwvQFvZ7FyXdJTw0VqoWg4+zGzw87cy6dHujwg377eAWraApcnuNU4WSq+
         HK5sIT8e2g2soZM2UyWdn9I8tTexMTS7b+wQBIjcAJhGZypmMmGIi2ijYuotYVVmmWJe
         5BXFRlKE5W//+XXYWaTNiVlkp2gJcqVbl08ZE54CPzxwurMNvyCK8roRK9X7GUm/4Lar
         3fduN4IdLlul5kH+zZ0RMIFQE9ELho1izmGPTpzjQe1QG8PwA8N4HKNTa3Sis6SfUDMW
         Zi80H7BxbfBoLElZR+uHf5V1X6F7wqbGPhghyu7Din49K/FD8hI7fDgimqVA2kUETy33
         rZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LcNWrfTv4aBkmjrm5jdJhkNlfmcxrQ8wohPuD+EwlzM=;
        b=KFqrEBV+KzFb/5+Cf3lMgJcG/HHBE9IJRsM6IBu5eBbc8plVFlqp181ZGdMCKeC8PO
         r8MfzEsTCDbf8FeoM5U7tjT2ddDUWnv6R6anjDnyytj9C76FvnBuYu304aJHkmgBD4tl
         fpSjnKT5H98sJqx9KrpoC4GEEQhbLwX3zUbXH7olCnDduI4mpkN5amvyZWBMfE3qCov7
         kCN1t3uPGXdLCdzPjxCAQfvaUAbkgnS8Y2B60WGzyG1IeahU5QureV3UEhfxxKbwlNmN
         pWj7CE1KgyuDAiUNwf2gMwqKetSMxVVYoXx8DrKOqy8CIcm1AifJ+uvWDpLjmgiG+F4w
         yuSA==
X-Gm-Message-State: AOUpUlEMUohmIu7mYcHQchUueK9bYkSqa2732kQpV2+0YfYwzQOxRdJK
        fmSBgtwmAPHWz4LNzbfrwXbSiJQ/XMsAukFKLori3Q==
X-Google-Smtp-Source: AA+uWPzObTY4yn8yuLddA4SSGzWxlnRDzZg7Di24+vBXlHAMdfMKJWJUUEKRFY2tsiR2DXwo8QGu+w2xCS4tjjJzAKA=
X-Received: by 2002:a50:f577:: with SMTP id w52-v6mr14522312edm.230.1534012211792;
 Sat, 11 Aug 2018 11:30:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:aed3:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 11:29:41
 -0700 (PDT)
In-Reply-To: <CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com>
References: <CAO-sURTngN_mnpJp9rvutpDfz80Nq4K8JOH4fnZG2NaTafkx+g@mail.gmail.com>
 <CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>
 <20180810165735.GT4692@linux.intel.com> <20180810214433.GA15044@linux.intel.com>
 <CA+i0qc5Z95QD4Pb8XYGnj+=gVfGJWARqrRN8zej0zDUrcDYW5w@mail.gmail.com>
From:   Harlan Lieberman-Berg <harlan@dds.mil>
Date:   Sat, 11 Aug 2018 14:29:41 -0400
Message-ID: <CAO-sURRBXW77tk-Vq4vZr5q3GJt643o80jC35PpjUx649L=+cg@mail.gmail.com>
Subject: Re: Fwd: PROBLEM: tpm_cpg can't request region with AMD/Dell fTPM
To:     Tomas Winkler <tomasw@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 5:42 AM, Tomas Winkler <tomasw@gmail.com> wrote:
> What platform is this? This is not regular 0xfed40000 address space. I
> guess this is BYT or CHT.  It's better to get dmideoce dump as well.

Hello Tomas, Jarkko, all,

I'm not sure what's up with that.  I've updated the firmware to the
latest version (with no fix, sadly), and re-dumped the ACPI tables.
They now process correctly through isl v20180629.  I've also saved the
output of dmidecode for you.

https://gist.github.com/hlieberman-gov/83fa708d41051bafccc553cf0147db4f

Sincerely,
-- 
Harlan Lieberman-Berg
Defense Digital Service
