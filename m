Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5164C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1752089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1752089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJAX71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:59:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44879 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJAX71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:59:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so9692931pff.11;
        Mon, 01 Oct 2018 10:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2F0KBjPfuaBKDsO0Jh3P7CxhnUYNgsmykt8qK3Lf4dI=;
        b=YLGoayx0OBo+AHgme3N8EZRZirsZJ6c7Dfruxslglf7f8ZrFgMF/LqwL4d2lZkuUvB
         IkgOzDuIGdx/sMb9X/qz3yXG8wtzVlA8NUgjk+ieK2GyhkyeoatBptUa8ZIzMnvCeFap
         DfYZN3R+yw2lSqs+ybxvqpKWUI/uB4/9XWjR74odHBdGo7OTSYbEEefhJIFkc8wrkp8x
         3IUprMAABxXutevTTpxrCQAOcOezLi+D9rWvU54xRyhVtFZbkz2xnARcx38x6JAX+zYF
         tkQmXaJ8GC5EJNfZb6yn+fz4sLnJ1Hvq45Qg4QVskqYJYQbT0Cnmbo4t8HHNryrIKeb/
         su7A==
X-Gm-Message-State: ABuFfoigx5Az3I7fJhULy8ZEghQIhcvfsuRfz9k9mbwK4MDc9q3CNYfR
        AOaBvSHlccTUf+Cw/JWq98s=
X-Google-Smtp-Source: ACcGV63lz/53EfBxoXD9I54soUvUmCktusoob1e1EWoWAavOXoV8f8TB5Fy0Wp8UO2TFp/KOoG3xkA==
X-Received: by 2002:a62:9fc4:: with SMTP id v65-v6mr12324361pfk.130.1538414438757;
        Mon, 01 Oct 2018 10:20:38 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h7-v6sm6140540pfd.35.2018.10.01.10.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 10:20:38 -0700 (PDT)
Message-ID: <1538414437.171728.7.camel@acm.org>
Subject: Re: [PATCH RESEND] scsi: sg: Prevent potential double frees in sg
 driver
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nick Desaulniers <ndesaulniers@google.com>, hch@infradead.org
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Robb Glasser <rglasser@google.com>, evgreen@chromium.org,
        stable@vger.kernel.org
Date:   Mon, 01 Oct 2018 10:20:37 -0700
In-Reply-To: <CAKwvOdmtF-s4amu-zXbyUNe+jvCuC3hXUez6fVVq0sjuoYc3eg@mail.gmail.com>
References: <20181001161506.100284-1-evgreen@chromium.org>
         <CAKwvOdmtF-s4amu-zXbyUNe+jvCuC3hXUez6fVVq0sjuoYc3eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-01 at 10:12 -0700, Nick Desaulniers wrote:
+AD4 On Mon, Oct 1, 2018 at 9:16 AM Evan Green +ADw-evgreen+AEA-chromium.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 From: Robb Glasser +ADw-rglasser+AEA-google.com+AD4
+AD4 +AD4 
+AD4 +AD4 sg+AF8-ioctl could be spammed by requests, leading to a double free in
+AD4 +AD4 +AF8AXw-free+AF8-pages. This protects the entry points of sg+AF8-ioctl where the
+AD4 +AD4 memory could be corrupted by a double call to +AF8AXw-free+AF8-pages if multiple
+AD4 +AD4 requests are happening concurrently.
+AD4 +AD4 
+AD4 +AD4 Signed-off-by: Robb Glasser +ADw-rglasser+AEA-google.com+AD4
+AD4 +AD4 Signed-off-by: Nick Desaulniers +ADw-ndesaulniers+AEA-google.com+AD4
+AD4 +AD4 Signed-off-by: Evan Green +ADw-evgreen+AEA-chromium.org+AD4
+AD4 +AD4 Cc: stable+AEA-vger.kernel.org
+AD4 +AD4 
+AD4 +AD4 ---
+AD4 +AD4 Reposting this patch from last summer, as it looks like it fell in between
+AD4 +AD4 the cracks.
+AD4 
+AD4 Christoph, do you still feel strongly about: https://lkml.org/lkml/2017/8/5/75 ?

I don't know how Christoph feels about it, but serializing all SG I/O seems
like a regression to me. If one sg command hangs I usually try to send
another sg command to the same SCSI device from another shell to get more
information about the nature of the hang. Serializing all SG I/O would make
that impossible.

Bart.
