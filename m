Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039BBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F6F206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfACJye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:54:34 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38494 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfACJye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:54:34 -0500
Received: by mail-ua1-f67.google.com with SMTP id p9so10756021uaa.5;
        Thu, 03 Jan 2019 01:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=577VQS6j+fTTVv7jnDHtcmjgEzFTlkuBpYmnldnAxuw=;
        b=j8/MuJ+ksT/MmkfWy9e84Q9IQe2PAUyoUR/Qatpxcahgd7RM3vl4UekgkkcNSVqVbJ
         Sjv3HIPGoBj8T5STD6zHYYfZMJf426c9xmwAQKSg3TiTN9LxzcVluxWkozyyT28+ZocC
         hbiwBprQqi/jx/aNX2vUJmbX6ak1DdTuemV/jtHxLxc36lEeqAosL9PR7c98fKMADhyR
         kLjjQ0S2hhlewAecrHzSdgTeUr5x+Kmd/x29n4LhxzM2NX9cIDzfvG1OEPBltcx8aa5p
         O+T5ktbuNK/maNGQc6445REk05TEC7QU7pKQnMnSgnKUsYXjEzgUf7zfra1mCrECRpDS
         Y7YA==
X-Gm-Message-State: AJcUukdZfWqqUTwplzVKUNM2QZ0vSM6I78u/YUFIG1pZh3dr/yCbOJQh
        stpZRAdI6rEGoIKmAm/v2j7ORuLbuT9LSrUzEEw=
X-Google-Smtp-Source: ALg8bN456ncdV7JtqPCWoSgqVRLHKhFLL0/sbX+FQOWWsou7LNwXjKV/ccwanfZFW/QeByL1i+CsO5bShXe6kHy16Oc=
X-Received: by 2002:ab0:216:: with SMTP id 22mr17415887uas.28.1546509271890;
 Thu, 03 Jan 2019 01:54:31 -0800 (PST)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-a3a53b7603798fd875e2afbba7e2b9ba6b19c7c7@kernel.org>
In-Reply-To: <git-mailbomb-linux-master-a3a53b7603798fd875e2afbba7e2b9ba6b19c7c7@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Jan 2019 10:54:20 +0100
Message-ID: <CAMuHMdUh3yjrs91976G_eB2DDtnsN4Vy3qj2LmtpTgZFdpyW7Q@mail.gmail.com>
Subject: cifs large stack allocations
To:     Paulo Alcantara <palcantara@suse.de>,
        Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paulo,

On Wed, Jan 2, 2019 at 10:24 PM Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
> Commit:     a3a53b7603798fd875e2afbba7e2b9ba6b19c7c7
> Parent:     23324407143dd923660378fd9b40b9a711972269
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/a3a53b7603798fd875e2afbba7e2b9ba6b19c7c7
> Author:     Paulo Alcantara <palcantara@suse.de>
> AuthorDate: Wed Nov 14 17:20:31 2018 -0200
> Committer:  Steve French <stfrench@microsoft.com>
> CommitDate: Fri Dec 28 10:13:11 2018 -0600
>
>     cifs: Add support for failover in smb2_reconnect()
>
>     After a successful failover in cifs_reconnect(), the smb2_reconnect()
>     function will make sure to reconnect every tcon to new target server.
>
>     For SMB2+.
>
>     Signed-off-by: Paulo Alcantara <palcantara@suse.de>
>     Signed-off-by: Aurelien Aptel <aaptel@suse.com>
>     Signed-off-by: Steve French <stfrench@microsoft.com>

> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c

> @@ -152,6 +155,77 @@ out:
>         return;
>  }
>
> +#ifdef CONFIG_CIFS_DFS_UPCALL
> +static int __smb2_reconnect(const struct nls_table *nlsc,
> +                           struct cifs_tcon *tcon)
> +{
> +       int rc;
> +       struct dfs_cache_tgt_list tl;
> +       struct dfs_cache_tgt_iterator *it = NULL;
> +       char tree[MAX_TREE_SIZE + 1];

warning: the frame size of 1316 bytes is larger than 1024 bytes
[-Wframe-larger-than=]

MAX_TREE_SIZE = 1284

On Wed, Jan 2, 2019 at 10:24 PM Linux Kernel Mailing List
<linux-kernel@vger.kernel.org> wrote:
>
> Commit:     08744015492fec5a30ab8e2779601ae2b1a5e431
> Parent:     a3a53b7603798fd875e2afbba7e2b9ba6b19c7c7
> Refname:    refs/heads/master
> Web:        https://git.kernel.org/torvalds/c/08744015492fec5a30ab8e2779601ae2b1a5e431
> Author:     Paulo Alcantara <palcantara@suse.de>
> AuthorDate: Wed Nov 14 17:24:29 2018 -0200
> Committer:  Steve French <stfrench@microsoft.com>
> CommitDate: Fri Dec 28 10:13:11 2018 -0600
>
>     cifs: Add support for failover in cifs_reconnect_tcon()
>
>     After a successful failover, the cifs_reconnect_tcon() function will
>     make sure to reconnect every tcon to new target server.
>
>     Same as previous commit but for SMB1 codepath.
>
>     Signed-off-by: Paulo Alcantara <palcantara@suse.de>
>     Reviewed-by: Aurelien Aptel <aaptel@suse.com>
>     Signed-off-by: Steve French <stfrench@microsoft.com>

> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c

> @@ -118,6 +121,77 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
>          */
>  }
>
> +#ifdef CONFIG_CIFS_DFS_UPCALL
> +static int __cifs_reconnect_tcon(const struct nls_table *nlsc,
> +                                struct cifs_tcon *tcon)
> +{
> +       int rc;
> +       struct dfs_cache_tgt_list tl;
> +       struct dfs_cache_tgt_iterator *it = NULL;
> +       char tree[MAX_TREE_SIZE + 1];

warning: the frame size of 1316 bytes is larger than 1024 bytes
[-Wframe-larger-than=]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
