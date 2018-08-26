Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7783DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 01:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E4021564
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 01:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gHtPG+sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E4021564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeHZFNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 01:13:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34804 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeHZFNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 01:13:04 -0400
Received: by mail-it0-f68.google.com with SMTP id x79-v6so8542846ita.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 18:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kwNeNv/r5nifJwO89x9xbhQqiPZE7wqM6QqYxWANgIA=;
        b=gHtPG+sl8Ni2vTkwr5rcYzOQLTdsIAd6oKvwpspfSCposMDxB3tYKY3qDK2Zj7+UhG
         WrD5/3F72FLkzjlTUkjUr2MLNHotiKaR5a6bSeFyAwWVPWj+KMMRBIoH2bYBEC5qHbEw
         t90QwtuSVf6D/CwQm3380NFlbuVvAtQNbbNEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwNeNv/r5nifJwO89x9xbhQqiPZE7wqM6QqYxWANgIA=;
        b=k4pI4OPYHWcB3dt/2VYkzV1N79FthzpctNM5BViOzOjY5F3zp1xoMokWRaJ6X9JFHN
         yte2+ZrEUIp9+k3V7kgKYAIHqcZGGK5cI6IZNcS7RJ4ACbEjgQGw5pgbW9loxgDdMQnH
         IdMW3iLOROC67F5bmwi7Qb+nqAE6g+rLqZFTOVcnfmQ/cBZtNB5C24GkNTNRkpBxk3PR
         6xbE1kAVUYoQMOId93BVncn5UId0itHiXWzBU/Kebht257HVWCFpI9G3x77JEABMSkO+
         iwTuls5mfWnLFWRE1Lh6c5IawWrFvUMCIzYK7XcdmhE/x1WWK3nlOeMJPpOVNwTiB3ne
         oe5A==
X-Gm-Message-State: APzg51Baz4G6vFJkiG6K6onJ5O/iEJAGrwFV2OjH46vJfhIUQ2ICMv6j
        nfe0ltxhKhPA+zZqqZ40nIZJyXmq5xU2GldnMp0=
X-Google-Smtp-Source: ANB0Vdb8MnSWi+r32CKLe0gfIejaz/KyI0Nh1zJ3vV1hvI01OSJed29PCLl7qGEryPUECqkufE855c9ythPi6fyJA5Y=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr2826351ite.123.1535247136688;
 Sat, 25 Aug 2018 18:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <e8622920d68c008edf72bcd93a8716fc59c2f55d.camel@intel.com>
In-Reply-To: <e8622920d68c008edf72bcd93a8716fc59c2f55d.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Aug 2018 18:32:05 -0700
Message-ID: <CA+55aFyQAZxhJsbh8G3U=EPdKyfmeLRGwkqaRUbfOV0e5T=vXw@mail.gmail.com>
Subject: Re: [GIT PULL]: libnvdimm updates for 4.19-rc1 v2 [2/2]
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 1:22 PM Jiang, Dave <dave.jiang@intel.com> wrote:
>
> Please pull to receive the libnvdimm dax-memory-failure series for v4.19-rc1. I have removed the
> offending ilog2() call and fixed up the patch accordingly.

Ok, not only does the code look fine now, I actually find this split
to have been much easier to look through, with the drivers split from
the memory-failure code. Please do this in the future too when you
have this kind of "driver changes and very core infrastructure
changes".

It may _look_ like more work to me when I do two pulls, but if they
are separated out sanely, it makes review so much easier that it's
actually less work overall. Thanks.

So pulled.

Well, this second one is not actually pulled quite yet - I'm still
doing the build tests for 1/2, but 2/2 has already passed my
sniff-test, so it's just waiting for the build tests to finish.

                Linus
