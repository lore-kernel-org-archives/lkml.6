Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B474C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388EB205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNaz88oH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAQP7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:59:54 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:45493 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQP7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:59:54 -0500
Received: by mail-pg1-f178.google.com with SMTP id y4so4613127pgc.12;
        Thu, 17 Jan 2019 07:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTVEfJLc3Je49Vz6HwyTrdSU+MIIkjQOGNQLsHBU0BU=;
        b=kNaz88oHYJDSodiTSryqub3c2wNNTeAakaePjluyE3P+klg7VP/8IEO2cOBPy838WI
         DBfrTSRFG6dY9wSBdiN4yltbOQ/qu2kQOi2L1Kx65CId7IBC08vjX0bv1ZoH0V1Qaxrq
         3YzrMWqMFXcTD4oU36nDRrZWrAvzv/X+t5jmmuwrIRKjGmNHdXBidd9tqlPkkzta6dS6
         yttGrf2N3z3uxtaY6ve+5NvS7z0LoYe6GiMRouA482FsR21SlvJ8zXO8h0zUEn+dGt2B
         E1HzS4fANkIWSZSrvndIeSMlZeQPU5qMF/ENIFEhETt3FjSmfY3e6a42D5sO7s1hdO8p
         7InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTVEfJLc3Je49Vz6HwyTrdSU+MIIkjQOGNQLsHBU0BU=;
        b=hhS1oQVXew4OfbO7iER6k4ltfTqAnXjuR4kzDAhib5YRbGNTa/vp4xKPN2n6huezmU
         ix3G+dYs6pTskBq0j2Y1N/WVCvrgiKW4UcV4iRLgs1HHnnMwOrWACh4cuTv0vS8HUmSZ
         7AKHpxrnlzzex9OQe0IUtb5Hpv+xObH2sO0TXzpCmbq865zIXfKcDsXcF4tZ8JdJGvId
         WOfhXjm1hfdejniGT9BlDpIB4jF/Q2lnu28I7aZsKd9x1CQlbLkdiIf3UI/VOlgHxRoC
         pc0/DA7lv3azeU2gANtF6GRYmCpqV0yubj3fGl5ZNiO+TfuC85rUPCgix4XETKb74ITb
         DZiQ==
X-Gm-Message-State: AJcUukernk0PfGGMAKY11S9GvZh9DQBLq0riiOiGqmyyZ0rB1Jj2nFQ/
        z0JHL6rqDPXIwQaX/Un0TaGRWL0AdiRSveF8LaI=
X-Google-Smtp-Source: ALg8bN5EeSpA7bvpaJ+1VNHULE1tIzHTyt9ubHfabbVHHRm0T0nA1gpQvaL7OmHFPlYo9NCU3oiDl4yX+ktSUnYhMOE=
X-Received: by 2002:a63:a112:: with SMTP id b18mr14030686pgf.440.1547740793429;
 Thu, 17 Jan 2019 07:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20190116162859.8028-1-colin.king@canonical.com> <20190117071048.GF4482@kadam>
In-Reply-To: <20190117071048.GF4482@kadam>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 17 Jan 2019 09:59:41 -0600
Message-ID: <CAH2r5mshYX38g9xydPZ=aWgz8EhQhamogyK3dNOF8uWBmAGGRw@mail.gmail.com>
Subject: Re: [PATCH][V2] cifs: fix memory leak of an allocated cifs_ntsd structure
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Thu, Jan 17, 2019 at 1:12 AM Dan Carpenter via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> Thanks, Colin!
>
> Reviewed-by: Dan Carpener <dan.carpenter@oracle.com>
>
> regards,
> dan carpenter
>
>


-- 
Thanks,

Steve
