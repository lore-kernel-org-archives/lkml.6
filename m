Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80377C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F6D20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="HkRF5rmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F6D20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeLALe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:34:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45010 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeLALe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:34:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so3553605pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=lrzdrveZmioJmKVxJzCc0yi0EEyQXhi/EwHLRyZ+ALM=;
        b=HkRF5rmA8wnlcmAfbddvfYuYr3n89YHmuP6RVyTDUpV8QBcIUw3WKn8zi5dhTNFrgb
         oGLLekPOMar8OXKtKcKwMKM2cxFmm/RWpZzGK9WrDC8kEO9J+XWk5wVcBnIDLpWMESR/
         CDyRd0Pr3i3xdC/B9cwJk7inJOKGzOUhICFUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lrzdrveZmioJmKVxJzCc0yi0EEyQXhi/EwHLRyZ+ALM=;
        b=m0Bj58SZwK1yH2bc17zW6QVmp3QsDKY0jbwmnD1iOzNMi5D+RMNUS5Oh9R3H1gY1Z8
         T/wGuJ2foQiogw/7f3U9J4EY6HgvoL9ZJheKhJoNgUN/LOFsTqUjUyUwD3HJ/YdTrx/c
         AppH5x8yAI/jBSmW5v5UbuBM0NXE+fDUc5sqoh9+NO1Oj8HodZ/lzHblTEwwpmrFkbkf
         AXVT76z7lMbnvgOSQf+nsYbSNdLZ6dAbo7/w0Z6TWJfrYCHb3GZLAVqZItEMdYF07Tat
         BlK03K3HHAGIW5gzOkcU8C/JznUhcDAFch64Ji0C3L0Xwc8NHHIigjUP+RLJ0NWE7mGd
         4XvA==
X-Gm-Message-State: AA+aEWaV8nnaQr6bzrYhy7AvmvT76z43oVLY/qZbqYBcnBKsKFoe04sd
        vIBR9epnteAqrKUcHy5s1WqX1A==
X-Google-Smtp-Source: AFSGD/Xbb4TthXOLsHe+6FZGHHBiYcHVJqCP168EwwWwKEOm0SeZsHsD27uSr4JJsOaGkZUtJIEebw==
X-Received: by 2002:a17:902:47aa:: with SMTP id r39mr7573834pld.219.1543623831585;
        Fri, 30 Nov 2018 16:23:51 -0800 (PST)
Received: from localhost (114-198-118-47.dyn.iinet.net.au. [114.198.118.47])
        by smtp.gmail.com with ESMTPSA id y1-v6sm8233799pfb.81.2018.11.30.16.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 16:23:50 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc:     Shantanu Goel <sgoel01@yahoo.com>,
        Kiran Kumar Modukuri <kiran.modukuri@gmail.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] cachefiles: Fix page leak in cachefiles_read_backing_file while vmscan is active
In-Reply-To: <154359603369.18703.763590641473461495.stgit@warthog.procyon.org.uk>
References: <154359597927.18703.424445427183570230.stgit@warthog.procyon.org.uk> <154359603369.18703.763590641473461495.stgit@warthog.procyon.org.uk>
Date:   Sat, 01 Dec 2018 11:23:47 +1100
Message-ID: <87r2f26qng.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
>
> [Description]
>
> In a heavily loaded system where the system pagecache is nearing memory
> limits and fscache is enabled, pages can be leaked by fscache while trying
> read pages from cachefiles backend.  This can happen because two
> applications can be reading same page from a single mount, two threads can
> be trying to read the backing page at same time.  This results in one of
> the threads finding that a page for the backing file or netfs file is
> already in the radix tree.  During the error handling cachefiles does not
> clean up the reference on backing page, leading to page leak.
>
> [Fix]
> The fix is straightforward, to decrement the reference when error is
> encountered.
>
>   [dhowells: Note that I've removed the clearance and put of newpage as
>    they aren't attested in the commit message and don't appear to actually
>    achieve anything since a new page is only allocated is newpage!=NULL and
>    any residual new page is cleared before returning.]

Sorry I hadn't got back to you on this; I think we also discussed this
with the Ubuntu kernel team and concluded - as you did - that these
didn't fix any bugs but did make things seem more consistent.

Regards,
Daniel
>
> [Testing]
> I have tested the fix using following method for 12+ hrs.
>
> 1) mkdir -p /mnt/nfs ; mount -o vers=3,fsc <server_ip>:/export /mnt/nfs
> 2) create 10000 files of 2.8MB in a NFS mount.
> 3) start a thread to simulate heavy VM presssure
>    (while true ; do echo 3 > /proc/sys/vm/drop_caches ; sleep 1 ; done)&
> 4) start multiple parallel reader for data set at same time
>    find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
>    find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
>    find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
>    ..
>    ..
>    find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
>    find /mnt/nfs -type f | xargs -P 80 cat > /dev/null &
> 5) finally check using cat /proc/fs/fscache/stats | grep -i pages ;
>    free -h , cat /proc/meminfo and page-types -r -b lru
>    to ensure all pages are freed.
>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Shantanu Goel <sgoel01@yahoo.com>
> Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
> [dja: forward ported to current upstream]
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/cachefiles/rdwr.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
> index 40f7595aad10..db233588a69a 100644
> --- a/fs/cachefiles/rdwr.c
> +++ b/fs/cachefiles/rdwr.c
> @@ -535,7 +535,10 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
>  					    netpage->index, cachefiles_gfp);
>  		if (ret < 0) {
>  			if (ret == -EEXIST) {
> +				put_page(backpage);
> +				backpage = NULL;
>  				put_page(netpage);
> +				netpage = NULL;
>  				fscache_retrieval_complete(op, 1);
>  				continue;
>  			}
> @@ -608,7 +611,10 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
>  					    netpage->index, cachefiles_gfp);
>  		if (ret < 0) {
>  			if (ret == -EEXIST) {
> +				put_page(backpage);
> +				backpage = NULL;
>  				put_page(netpage);
> +				netpage = NULL;
>  				fscache_retrieval_complete(op, 1);
>  				continue;
>  			}
