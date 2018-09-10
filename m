Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA46FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CAF204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CAF204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeIJNZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:25:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727714AbeIJNZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:25:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1726B818B136;
        Mon, 10 Sep 2018 08:32:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F09F63AF9;
        Mon, 10 Sep 2018 08:32:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
References: <20180910045227.9895-1-viro@ZenIV.linux.org.uk> <20180910044937.GJ19965@ZenIV.linux.org.uk>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     dhowells@redhat.com, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/8] start unifying termios convertors
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3017.1536568354.1@warthog.procyon.org.uk>
Date:   Mon, 10 Sep 2018 09:32:34 +0100
Message-ID: <3018.1536568354@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 10 Sep 2018 08:32:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 10 Sep 2018 08:32:36 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> wrote:

> +static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
> +						 struct ktermios *k)
> +{
> +	int err;
> +	err  = put_user(k->c_iflag, &u->c_iflag);
> +	err |= put_user(k->c_oflag, &u->c_oflag);
> +	err |= put_user(k->c_cflag, &u->c_cflag);
> +	err |= put_user(k->c_lflag, &u->c_lflag);
> +	err |= put_user(k->c_line, &u->c_line);
> +	err |= copy_to_user(u->c_cc, k->c_cc, NCCS);
> +	if (!(k->c_lflag & ICANON)) {
> +		err |= put_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
> +		err |= put_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
> +	} else {
> +		err |= put_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
> +		err |= put_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
> +	}
> +	err |= put_user(k->c_ispeed, &u->c_ispeed);
> +	err |= put_user(k->c_ospeed, &u->c_ospeed);
> +	return err;
> +}

Can you make this use || instead of |= ?  That way if put_user() uses a
goto-out-of-asm it may be a lot more efficient, both in the normal case and
the error case.

David
