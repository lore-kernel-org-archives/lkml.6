Return-Path: <kernel-hardening-return-13106-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+fdCH4uq7HKpvA3QP48i1ifywioSXHNiFye21i/qcvtWhYV1nI19+WM99j3lB2oZipuhEf
ARC-Seal: i=1; a=rsa-sha256; t=1524570691; cv=none;
        d=google.com; s=arc-20160816;
        b=a7EApTJTVpwEij2Tfba6huI/U1MfQ5mdO8GL+XCH/rFlEYywpmSVjAnz4QxpwaN4j2
         Dv3aAEBu1CDnc5Jz/O5jIFJqz6KGV1nsvNzWG0H2ftxaQgz3rOvrJUGPifkXDDMkhwV7
         hDuKbe0z8r7CmrMSMPIzMsURNil6NmczAjqpPc5cf08RmIDzz9lgNGVdRZfvJW46U6JR
         oRnJ9Ma97SO/MZhcxES2EHhdd3SaW47whrV5JzVh3YBP2W62JG7inI5fo3qa/LRChqPa
         8ZtJ8QjdDnYLg+tZ/4NLCSS6jkwQMyUsOp43J+0nEhoUdSEikasbxGGIVVGdG/Xfe35D
         VuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=OQxt61pkYvcYAj73KHUAVctB9+2XcsegsgjJwH5/Wr0=;
        b=sKQU1mUtwDfqETxN7PTPlauhos8BlZVauS9yGPBR/hP3yFuxJ68h1SxG5PnMCSD7eQ
         RZRx+/aMm+b8d2uk3nmu2bsTMAT7S2CZ1HYtfQA2KwKDWacrxbfQyWUOgZvOrcab04U8
         G539i37RKQRhzDc6YA4nPaOVwk9bYIKQmtBqQVlSkLgHiMAtut0UXMzYyZQpWM9PZ2q6
         yNGtRyjTNXsdS55q7TvmuB+X8YWvb/VesZn9g9wUNVReS/QhZuWDj4FSGZrmvPw0BmTQ
         gHXA0BZv98NrZIUyXVr4M3kTkVZr6128BtoFfzih56uMU52MsaR63VbeS+GfKkJyoeb7
         Oslg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=tGH/q/G3;
       spf=pass (google.com: domain of kernel-hardening-return-13106-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13106-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=tGH/q/G3;
       spf=pass (google.com: domain of kernel-hardening-return-13106-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13106-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 24 Apr 2018 04:50:50 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@gmail.com>
Cc: keescook@chromium.org, paul@paul-moore.com, sds@tycho.nsa.gov,
	mhocko@kernel.org, corbet@lwn.net, labbott@redhat.com,
	linux-cc=david@fromorbit.com, --cc=rppt@linux.vnet.ibm.com,
	--security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Igor Stoppa <igor.stoppa@huawei.com>,
	Carlos Chinea Perez <carlos.chinea.perez@huawei.com>,
	Remi Denis Courmont <remi.denis.courmont@huawei.com>
Subject: Re: [PATCH 7/9] Pmalloc Rare Write: modify selected pools
Message-ID: <20180424115050.GD26636@bombadil.infradead.org>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-8-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423125458.5338-8-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541768538376919?=
X-GMAIL-MSGID: =?utf-8?q?1598628237819426606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:54:56PM +0400, Igor Stoppa wrote:
> While the vanilla version of pmalloc provides support for permanently
> transitioning between writable and read-only of a memory pool, this
> patch seeks to support a separate class of data, which would still
> benefit from write protection, most of the time, but it still needs to
> be modifiable. Maybe very seldom, but still cannot be permanently marked
> as read-only.

This seems like a horrible idea that basically makes this feature useless.
I would say the right way to do this is to have:

struct modifiable_data {
	struct immutable_data *d;
	...
};

Then allocate a new pool, change d and destroy the old pool.
