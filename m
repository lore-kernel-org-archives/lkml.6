Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A33C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51F2208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQpVdwvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51F2208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935038AbeFRQ4H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:56:07 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40875 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932762AbeFRQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:56:04 -0400
Received: by mail-pg0-f66.google.com with SMTP id w8-v6so4777326pgp.7;
        Mon, 18 Jun 2018 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xV2obJqDZr7ZK8A5Pe3IjHCkdy5hJGZIRnd9+3+1rEY=;
        b=kQpVdwvNXsbGCgzw1ZMjrUcXoPK/+Tgudw3aDOkmQFJqD34ALBhRSgVmA4nkBidtMn
         PvQO+nGWCo+NjJm39Px0F8ucRtUePXDN+px/NVm0IvNupwKwcetcZtTFrIe0XjdBCKtU
         8/BIA5kuDB93WpGLXcWOkwA7hPmkniMt7vssSrxFiuk9FGMCR94jakeMDcgYOVZXuD5i
         7QIKtS63dZ+hg1bHz0lGobJpbx12CaRjw04nGoLZIZpqR1+FIS/tTPmIQnXyjnw1Pxx8
         7A9kVpApzHBxK3G3mdYDP+XX18acwTVexSmiVLoQZXwjdOFf17ROueeb0JkDIC36f4AQ
         wyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xV2obJqDZr7ZK8A5Pe3IjHCkdy5hJGZIRnd9+3+1rEY=;
        b=Zkd86R6XZnV+lUgjPhHk6WRkcQoZydOwQkQKy9aj5lvGbEjrL/tFcCRE5tNeN8onpj
         ZkVxVU7EA5WPEr8txD5980R8da0g3L/wr9f/qhnZRwS0N/J0W3P15As06Ve8797gpmpA
         KAekJ4EtPjJ4spYzooNSGNwzgnbVvvoA8awjtVxTldS9UdE+Ol67DR0OLhFOX53I/gmQ
         oqGLWU3RwZdbgMZ9oROPyNu39IHNUqrJVuhLUy2DTDcefWdoOahhenOAyI8hsg7oF8Fc
         0budjrkdNduByikqTwGBfUsJlPqjdq3pWCR3YFkHxiyo+dggFqF+kOXOAEjWi6ea6nsf
         J2oQ==
X-Gm-Message-State: APt69E0R6WaHOJPXqMvhq1R2hFq0oheSi7H1ASZ6KwZFRGCDFzVe/KNW
        +N4bDDr3DUEZ/iiCOZH6b0azK94Sf7+M3EPiqjQ7bQ==
X-Google-Smtp-Source: ADUXVKJVLEr8gRa92aHtR27d2uitjQPY65KFhY00xD/JUlKjH9ImVAc5tGFEBs6iRn9rSq5cQMTbDEHvowz6kaOK5W0=
X-Received: by 2002:a65:4a90:: with SMTP id b16-v6mr11634677pgu.136.1529340963725;
 Mon, 18 Jun 2018 09:56:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:80cc:0:0:0:0 with HTTP; Mon, 18 Jun 2018 09:55:43
 -0700 (PDT)
In-Reply-To: <20180618130737.GA13880@embeddedor.com>
References: <20180618130737.GA13880@embeddedor.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 18 Jun 2018 11:55:43 -0500
Message-ID: <CAH2r5muZJkx0eR0uAyuRBkkTf7-97x5oSMWPXdfb1TUK4rwGJw@mail.gmail.com>
Subject: Re: [smb3] unreachable code and memory leaks
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 8:07 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Hi Steve,
>
> While doing some static analysis I came across the following piece of code at fs/cifs/smb2pdu.c:2017:
>
> 2017                if (n_iov > 2) {
> 2018                        struct create_context *ccontext =
> 2019                            (struct create_context *)iov[n_iov-1].iov_base;
> 2020                        ccontext->Next =
> 2021                                cpu_to_le32(iov[n_iov-1].iov_len);
> 2022                }

Good catch - this is harmless (and experimental mount option) - cut
and paste - unneeded clause.
Fixing now


> Also, it seems there are multiple places in which memory allocated for *path* is leaking:
>
> 1946        else
> 1947                return -EIO;
>
> 1951        if (rc)
> 1952                return rc;
>
> 1987                if (rc) {
> 1988                        cifs_small_buf_release(req);
> 1989                        return rc;
> 1990                }

Cleaning that up now. Will post a patch - thx.


-- 
Thanks,

Steve
