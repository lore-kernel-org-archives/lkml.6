Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94662C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423FE20862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423FE20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeHBCAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:00:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeHBCAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:00:48 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C874910;
        Thu,  2 Aug 2018 00:12:26 +0000 (UTC)
Date:   Wed, 1 Aug 2018 17:12:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Hua Zhong <hzhong@arista.com>, Shuah Khan <shuah@kernel.org>,
        Stuart Ritchie <sritchie@arista.com>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm/selftest: Add MAP_POPULATE test
Message-Id: <20180801171224.562aa07efc6b1612d6d6b23f@linux-foundation.org>
In-Reply-To: <20180801233636.29354-1-dima@arista.com>
References: <20180801233636.29354-1-dima@arista.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Aug 2018 00:36:36 +0100 Dmitry Safonov <dima@arista.com> wrote:

> As many other projects, we use some shmalloc allocator.
> At some point we need to make a part of allocated pages back private to
> process. And it should be populated straight away.
> Check that (MAP_PRIVATE | MAP_POPULATE) actually copies the private page.
> 
> ...
>
> --- /dev/null
> +++ b/tools/testing/selftests/vm/map_populate.c
>
> ...
>
> +#define BUG_ON(condition, description)					\
> +	do {								\
> +		if (condition) {					\
> +			fprintf(stderr, "[FAIL]\t%s:%d\t%s:%s\n", __func__, \
> +				__LINE__, (description), strerror(errno)); \
> +			exit(1);					\
> +		}							\
> +	} while (0)

This is userspace.   Why not use assert()?

>
> ...
>
> +int main(int argc, char **argv)
> +{
> +	int sock[2], child, ret;
> +	FILE *ftmp;
> +	unsigned long *smap;
> +
> +	ftmp = tmpfile();

Seems odd to putz around with stdio when you just want the fd. 
mkstemp(), maybe?

> +	BUG_ON(ftmp == 0, "tmpfile()");
> +
> +	ret = ftruncate(fileno(ftmp), MMAP_SZ);
> +	BUG_ON(ret, "ftruncate()");
> +
> +	smap = mmap(0, MMAP_SZ, PROT_READ | PROT_WRITE,
> +			MAP_SHARED, fileno(ftmp), 0);
> +	BUG_ON(smap == MAP_FAILED, "mmap()");
> +
> +	*smap = 0xdeadbabe;
> +	/* Probably unnecessary, but let it be. */
> +	ret = msync(smap, MMAP_SZ, MS_SYNC);
> +	BUG_ON(ret, "msync()");
> +
> +	ret = socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sock);
> +	BUG_ON(ret, "socketpair()");
> +
> +	child = fork();
> +	BUG_ON(child == -1, "fork()");
> +
> +	if (child) {
> +		ret = close(sock[0]);
> +		BUG_ON(ret, "close()");
> +
> +		return parent_f(sock[1], smap, child);
> +	}
> +
> +	ret = close(sock[1]);
> +	BUG_ON(ret, "close()");
> +
> +	return child_f(sock[0], smap, fileno(ftmp));
> +}
>
> ...
>
