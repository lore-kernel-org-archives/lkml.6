Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11D5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75DE2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPKwImnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75DE2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJIC75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:59:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33101 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJIC75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:59:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id q50so16966942otd.0;
        Mon, 08 Oct 2018 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHTsvgCUuFlv8IYRv4qxALN9KaMm1UYd1v05Iq9bi3s=;
        b=hPKwImnSw9yzipLYz/ySvhWvarrT/hV1G5fd8k82crbbcnOxRwhHem/VFddaedjEf0
         eZGzed1cD65f6VsERHTKu5/M59ycFFkpYxJb3X13hU9eBQD4FgnJ72GVTDjIBuhi8i2s
         3HVBpIOZ87bCVtzxKmyJ6GVd547wGN12iBb001O6NdscMlbG9DBYq3SvsYeVHWw+EcFz
         F6rBIUlBxypfgglL375xXyxU1U1vxndHKfKUMTg5eG1yk+8JB8yGzdOlJTqweHAgE1po
         KuYoUOPPAJms1Z6ilAw0X1HhhgqwS7LQ1aPFcWiJs45jrVejqunICJ4ebc4g0zyJQFhT
         NYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHTsvgCUuFlv8IYRv4qxALN9KaMm1UYd1v05Iq9bi3s=;
        b=T7RdL5He+CUHHTFyBpNy+dtN+8AilJUJ7RJ9KH3c3nX/wAbgyhC3kLl1ofJOZf+lQh
         JBDFVnRoREpSUMF5/K1HiPU31inaW27zODTRnyOl9ijggeiFDmURJMiwbsclnEIB+PCB
         OT4bDam/kgz357j3F0QCXf40bIkYGujOxFJ2HwwiQxCsZ7kgRMk8z7HCp4XUnIJrkSSH
         PRvJaAFMFRXExtohwKPQCJByTDon8mFQOMS2fMJ9rOFBmTjr17ogvHkKLM5y5sYVHbVu
         qIDGnL4lrgdKQF1yXR7gGTPhy86ryag7yABDSSeQ+p4UGXZBn/436aVUFbDgQ4Zb/Vgd
         1Hjg==
X-Gm-Message-State: ABuFfohA98TQ93ZnnIPAtfiI0H3ofPGFBEpOVMqnMIgC5U36jk8EMDVr
        0keS3stsV33CUL5Hi01Ns5w+M+pJEeeQYsk+RP0z+A==
X-Google-Smtp-Source: ACcGV61DbGNFzz5GgTEoK+h21y/As1BWqIIgYJw9kR0kNvMDhYcaNEDGuFrRoCe3tTk1bATrzKcK1nQxwzjlHlD0RJY=
X-Received: by 2002:a9d:1ea5:: with SMTP id n34mr4201366otn.160.1539027994026;
 Mon, 08 Oct 2018 12:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181008175605.067676667@linuxfoundation.org> <20181008175609.656421529@linuxfoundation.org>
In-Reply-To: <20181008175609.656421529@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 8 Oct 2018 20:45:57 +0100
Message-ID: <CADVatmODtvLS=1Bb2Oi-o2_fQOFAykhiAXLk08x30pNmFDseDA@mail.gmail.com>
Subject: Re: [PATCH 4.14 66/94] dm thin metadata: try to avoid ever aborting transactions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, ejt@redhat.com,
        Mike Snitzer <snitzer@redhat.com>,
        alexander.levin@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Greg,

On Mon, Oct 8, 2018 at 8:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Joe Thornber <ejt@redhat.com>
>
> [ Upstream commit 3ab91828166895600efd9cdc3a0eb32001f7204a ]

This has been fixed by a later commit 013ad043906b ("dm thin metadata:
fix __udivdi3 undefined on 32-bit")


-- 
Regards
Sudip
