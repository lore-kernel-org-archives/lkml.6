Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D06C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2575121721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549582535;
	bh=moQ9/aV/7DnPJoK809gBzcy3AyTX73nsDatkzclvMC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Re/Itpo4aIMDJrehwxHKDn096wp61jWmPXVQKAFuH9fNE3LMm9aOWcDlnwWBHWL8N
	 AgOaLC8IrSYMF77JM3GD/jvmG1I8ARb7HP++I5CFtB0M53UNvqvZFzYtfkQuMsALsT
	 9yrqRn2VdcIfbJKBFo0WP/hcg8s4jJMgJ2wQmOnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBGXfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:35:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBGXfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:35:33 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0DB921721;
        Thu,  7 Feb 2019 23:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549582531;
        bh=moQ9/aV/7DnPJoK809gBzcy3AyTX73nsDatkzclvMC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vI20K8HWnrh37K7CAOYJwEOqjuqGoZ+M+Z0Ssd+i8kGN3X/fddj7U3kObHaswl50P
         ZguM7lIQOzeCnlwPUTVkNJK2gZH16qfqo39pC9JzAcODf4dFdq/0T/VuUuodYWVAJY
         USebt87ZJ7ZWOcwVtg1j88+VO4JGoNk+ej5pulIs=
Date:   Thu, 7 Feb 2019 15:35:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] KEYS: always initialize keyring_index_key::desc_len
Message-ID: <20190207233529.GB125156@gmail.com>
References: <000000000000a722550577796543@google.com>
 <20181103015854.7380-1-ebiggers@kernel.org>
 <20181128231940.GB131170@gmail.com>
 <20190110202744.GA149637@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110202744.GA149637@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:27:46PM -0800, Eric Biggers wrote:
> On Wed, Nov 28, 2018 at 03:19:41PM -0800, Eric Biggers wrote:
> > On Fri, Nov 02, 2018 at 06:58:54PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > syzbot hit the 'BUG_ON(index_key->desc_len == 0);' in __key_link_begin()
> > > called from construct_alloc_key() during sys_request_key(), because the
> > > length of the key description was never calculated.
> > > 
> > > The problem is that we rely on ->desc_len being initialized by
> > > search_process_keyrings(), specifically by search_nested_keyrings().
> > > But, if the process isn't subscribed to any keyrings that never happens.
> > > 
> > > Fix it by always initializing keyring_index_key::desc_len as soon as the
> > > description is set, like we already do in some places.
> > > 
> > > The following program reproduces the BUG_ON() when it's run as root and
> > > no session keyring has been installed.  If it doesn't work, try removing
> > > pam_keyinit.so from /etc/pam.d/login and rebooting.
> > > 
> > >     #include <stdlib.h>
> > >     #include <unistd.h>
> > >     #include <keyutils.h>
> > > 
> > >     int main(void)
> > >     {
> > >             int id = add_key("keyring", "syz", NULL, 0, KEY_SPEC_USER_KEYRING);
> > > 
> > >             keyctl_setperm(id, KEY_OTH_WRITE);
> > >             setreuid(5000, 5000);
> > >             request_key("user", "desc", "", id);
> > >     }
> > > 
> > > Reported-by: syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com
> > > Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> > > Cc: <stable@vger.kernel.org> # v3.13+
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > > 
> > > v2: In proc_keys_show(), assign index_key directly
> > > 
> > >  security/keys/keyring.c          | 4 +---
> > >  security/keys/proc.c             | 3 +--
> > >  security/keys/request_key.c      | 1 +
> > >  security/keys/request_key_auth.c | 2 +-
> > >  4 files changed, 4 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > > index 41bcf57e96f21..99a55145ddcd2 100644
> > > --- a/security/keys/keyring.c
> > > +++ b/security/keys/keyring.c
> > > @@ -661,9 +661,6 @@ static bool search_nested_keyrings(struct key *keyring,
> > >  	BUG_ON((ctx->flags & STATE_CHECKS) == 0 ||
> > >  	       (ctx->flags & STATE_CHECKS) == STATE_CHECKS);
> > >  
> > > -	if (ctx->index_key.description)
> > > -		ctx->index_key.desc_len = strlen(ctx->index_key.description);
> > > -
> > >  	/* Check to see if this top-level keyring is what we are looking for
> > >  	 * and whether it is valid or not.
> > >  	 */
> > > @@ -914,6 +911,7 @@ key_ref_t keyring_search(key_ref_t keyring,
> > >  	struct keyring_search_context ctx = {
> > >  		.index_key.type		= type,
> > >  		.index_key.description	= description,
> > > +		.index_key.desc_len	= strlen(description),
> > >  		.cred			= current_cred(),
> > >  		.match_data.cmp		= key_default_cmp,
> > >  		.match_data.raw_data	= description,
> > > diff --git a/security/keys/proc.c b/security/keys/proc.c
> > > index 5af2934965d80..d38be9db2cc07 100644
> > > --- a/security/keys/proc.c
> > > +++ b/security/keys/proc.c
> > > @@ -166,8 +166,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
> > >  	int rc;
> > >  
> > >  	struct keyring_search_context ctx = {
> > > -		.index_key.type		= key->type,
> > > -		.index_key.description	= key->description,
> > > +		.index_key		= key->index_key,
> > >  		.cred			= m->file->f_cred,
> > >  		.match_data.cmp		= lookup_user_key_possessed,
> > >  		.match_data.raw_data	= key,
> > > diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> > > index 114f7408feee6..7385536986497 100644
> > > --- a/security/keys/request_key.c
> > > +++ b/security/keys/request_key.c
> > > @@ -545,6 +545,7 @@ struct key *request_key_and_link(struct key_type *type,
> > >  	struct keyring_search_context ctx = {
> > >  		.index_key.type		= type,
> > >  		.index_key.description	= description,
> > > +		.index_key.desc_len	= strlen(description),
> > >  		.cred			= current_cred(),
> > >  		.match_data.cmp		= key_default_cmp,
> > >  		.match_data.raw_data	= description,
> > > diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
> > > index 424e1d90412ea..6797843154f03 100644
> > > --- a/security/keys/request_key_auth.c
> > > +++ b/security/keys/request_key_auth.c
> > > @@ -246,7 +246,7 @@ struct key *key_get_instantiation_authkey(key_serial_t target_id)
> > >  	struct key *authkey;
> > >  	key_ref_t authkey_ref;
> > >  
> > > -	sprintf(description, "%x", target_id);
> > > +	ctx.index_key.desc_len = sprintf(description, "%x", target_id);
> > >  
> > >  	authkey_ref = search_process_keyrings(&ctx);
> > >  
> > > -- 
> > > 2.19.1
> > > 
> > 
> > Ping.  David, are you planning to apply this?
> > 
> > - Eric
> > 
> > -- 
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20181128231940.GB131170%40gmail.com.
> > For more options, visit https://groups.google.com/d/optout.
> 
> Ping.
> 

Ping.  David, are you planning to apply this?

- Eric
