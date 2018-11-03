Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD832C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 01:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EB920833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 01:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Comt9Ktp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EB920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbeKCLHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 07:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKCLHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 07:07:13 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F3F2082D;
        Sat,  3 Nov 2018 01:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541210258;
        bh=X0nA09FmWnVLii34A2eLLeSNLMA76JGIkNwWAjFV3ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Comt9KtpiLppmBjPIXDam65qLCXuxzugWdKOJkARqAxQxKZVMbO/xTu+hUbH+cQ+M
         oom6zAAOPQuxph0Ok+ZbKdtie8/SESgbjYjrX2wui2PO8uJfgHY4JTldYQy/rtjxHR
         XSse//SczknV2c6nC0/P/fXzy+nJiMs3AMkATEEk=
Date:   Fri, 2 Nov 2018 18:57:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] KEYS: always initialize keyring_index_key::desc_len
Message-ID: <20181103015735.GA771@sol.localdomain>
References: <000000000000a722550577796543@google.com>
 <20181102231510.15911-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102231510.15911-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:15:10PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> syzbot hit the 'BUG_ON(index_key->desc_len == 0);' in __key_link_begin()
> called from construct_alloc_key() during sys_request_key(), because the
> length of the key description was never calculated.
> 
> The problem is that we rely on ->desc_len being initialized by
> search_process_keyrings(), specifically by search_nested_keyrings().
> But, if the process isn't subscribed to any keyrings that never happens.
> 
> Fix it by always initializing keyring_index_key::desc_len as soon as the
> description is set, like we already do in some places.
> 
> The following program reproduces the BUG_ON() when it's run as root and
> no session keyring has been installed.  If it doesn't work, try removing
> pam_keyinit.so from /etc/pam.d/login and rebooting.
> 
>     #include <stdlib.h>
>     #include <unistd.h>
>     #include <keyutils.h>
> 
>     int main(void)
>     {
>             int id = add_key("keyring", "syz", NULL, 0, KEY_SPEC_USER_KEYRING);
> 
>             keyctl_setperm(id, KEY_OTH_WRITE);
>             setreuid(5000, 5000);
>             request_key("user", "desc", "", id);
>     }
> 
> Reported-by: syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Cc: <stable@vger.kernel.org> # v3.13+
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  security/keys/keyring.c          | 4 +---
>  security/keys/proc.c             | 1 +
>  security/keys/request_key.c      | 1 +
>  security/keys/request_key_auth.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 41bcf57e96f2..99a55145ddcd 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -661,9 +661,6 @@ static bool search_nested_keyrings(struct key *keyring,
>  	BUG_ON((ctx->flags & STATE_CHECKS) == 0 ||
>  	       (ctx->flags & STATE_CHECKS) == STATE_CHECKS);
>  
> -	if (ctx->index_key.description)
> -		ctx->index_key.desc_len = strlen(ctx->index_key.description);
> -
>  	/* Check to see if this top-level keyring is what we are looking for
>  	 * and whether it is valid or not.
>  	 */
> @@ -914,6 +911,7 @@ key_ref_t keyring_search(key_ref_t keyring,
>  	struct keyring_search_context ctx = {
>  		.index_key.type		= type,
>  		.index_key.description	= description,
> +		.index_key.desc_len	= strlen(description),
>  		.cred			= current_cred(),
>  		.match_data.cmp		= key_default_cmp,
>  		.match_data.raw_data	= description,
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index 5af2934965d8..909f6c5270a1 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -168,6 +168,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
>  	struct keyring_search_context ctx = {
>  		.index_key.type		= key->type,
>  		.index_key.description	= key->description,
> +		.index_key.desc_len	= strlen(key->description),
>  		.cred			= m->file->f_cred,
>  		.match_data.cmp		= lookup_user_key_possessed,
>  		.match_data.raw_data	= key,

It's actually possible to just set '.index_key = key->index_key' here.
I'll send v2 with that instead.

- Eric
