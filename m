Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72275C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2465120855
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lr69Y0ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2465120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeLISf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:35:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37268 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeLISf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:35:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so6412920lfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 10:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmNcep1cd97uMd2VMhlkDHPCuLWOufiAEQoEz8rf1pk=;
        b=Lr69Y0lyVnIMxRpSvjXqN+O1I2U9D/IMD/K2rAIofUoe+VVDqDjfa9XfVNAck4G7c3
         74c4Yk+HScJKwJhgppqJ7G4JwuRpFTeaHkWnxDihzchWhM5eXrEh+XAGqYxnUHE/fh/4
         B1LEgrkpLPAkm8Iqsl9Rr2WnHOz4flOdKRJaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmNcep1cd97uMd2VMhlkDHPCuLWOufiAEQoEz8rf1pk=;
        b=lcxxVfq5Dy8ITu7APgqWDWjpHDGs2jiPc5OdzXrVFegT/BC8gjSJgLLfR4V0dkAS6z
         wWvjrrWpRLyz4DdOnT9f7UQNAba/91xC9UmcP7pgG0jBDV09XOf7egjj1HWI2BunBGY0
         yjQ5w0S4O8bgaPAf2x96JT1hI/ChmEk3h4MxHVm/wuOMm45CTc6Y3BwkEP36+GuFlOjR
         Z2MLp/q2at8o8mD4roWYpm8jVGKxdfqWtSX79f+AZGB9IEONJ95A5nobt5g9SLHEuCou
         6X86YgDWzi2fJm6DJQ6V1Fx084VU5sibvEKKSXuzUjRJ75uXpUx22cy9dpV4ugRVm2Wx
         qwRQ==
X-Gm-Message-State: AA+aEWZUE9XPqLLJjC9XmCBaeeq+7XNh6LT6W3ss9GmNWFDkHIRLV3Qf
        00qKjXxvIDPTq16CdZN4ANYWAKx3XTg=
X-Google-Smtp-Source: AFSGD/Xn5phg6a8Ns3CRdf9junrSKjbfAcvSXvig2HmZj37SB56Yob4cXNEBP14ejySRQcv5xj4djw==
X-Received: by 2002:a19:d90c:: with SMTP id q12mr4989076lfg.24.1544380524377;
        Sun, 09 Dec 2018 10:35:24 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 15-v6sm1885433lje.18.2018.12.09.10.35.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:35:23 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id f23so6355195lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 10:35:23 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr4949471lfa.106.1544380522888;
 Sun, 09 Dec 2018 10:35:22 -0800 (PST)
MIME-Version: 1.0
References: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com>
 <CAHk-=wgAONwr6pMn+D2OsMZjAB5zNaMWSW5KdTM+L72gGnhV2Q@mail.gmail.com> <CAPcyv4jznHRB=BCsm8Y3d-uqDy_OWHSgTsPZoPK-L80FiQftFg@mail.gmail.com>
In-Reply-To: <CAPcyv4jznHRB=BCsm8Y3d-uqDy_OWHSgTsPZoPK-L80FiQftFg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Dec 2018 10:35:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5We7PFBqon-Jy1A59CVoGv2kJMJPixPOxm2Bq4JZX7g@mail.gmail.com>
Message-ID: <CAHk-=wi5We7PFBqon-Jy1A59CVoGv2kJMJPixPOxm2Bq4JZX7g@mail.gmail.com>
Subject: Re: [GIT PULL] dax fixes for 4.20-rc6
To:     dan.j.williams@intel.com
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 10:27 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> I can send a cleanup, do you want one immediately, or is post -rc6 ok?

post-rc6 is fine, I'd rather have the patch tested anyway,

                 Linus
