Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbeBEPTG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:19:06 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:34776 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeBEPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:18:49 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="67289177"
Subject: Re: [Xen-devel] [PATCH] [v2] xen: hypercall: fix out-of-bounds memcpy
To: Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
CC: <xen-devel@lists.xenproject.org>,
        David Laight <David.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <linux-kernel@vger.kernel.org>
References: <20180205150340.328921-1-arnd@arndb.de>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <67d8f0f1-0846-876d-d36a-c8a9f9366243@citrix.com>
Date: Mon, 5 Feb 2018 15:14:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205150340.328921-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/18 15:03, Arnd Bergmann wrote:

Snipping deleted code to make things clearer:

> +	if (cmd > ARRAY_SIZE(physdevop_len))
> +		return -ENOSYS;
>
> +	len = physdevop_len[cmd];
> +	memcpy(&op.u, arg, len);

You'll want an array_nospec() or whatever its called these days.  This
code is SP1-leaky.

Userspace controls cmd and can retrieve len by timing how many adjacent
cache lines were pulled in my memcpy().

~Andrew
