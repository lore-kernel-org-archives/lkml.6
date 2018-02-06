Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1543687-1517934329-2-9344393755684797614
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517934328; b=kM0tpo1jL8dMNcbkLggNraiB909dfza2AOqa7FsGzNyZIdB
    4PESrG6ZsCc11sYDdG0ufd6Txzlh26nJxsMNDESDfRbYdUxYCeOzZZECSnSPl/ER
    AgeA3FzIGKIVxBCwPb6+976aT972BWZq/2SBiIJKn1KPGWlU60dVMxoZWEytWFoc
    nHbP+5wQpaNWmZdHj+bce+33SeSNZDJkUvaNknjfpZybdKRKuElL3vu/p3jkbulS
    Si8lUQB80WxVy+IA2Cnm1FEWoe8pIGM/LQRdRTGWWLdTtVVQMsgHdp/PXt4SqBi+
    8puKM6mH0i9eWKgFiUMsH+iMHYV+VW4f85KM6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517934328; bh=YraFJ2wBc3WwQNKDDLAJwTMdr/
    Od0IpRgs8uxZc9H6k=; b=O2A9Z8W2CKKmW6YnzFtkRbd1R4KpvF2Tpt7IEdOL61
    blcAGJyzVuiwRXyG/1TNbTyrDfVL65dRzS5UjKpTHSX+pQaIt7O9dZvCCdB5RSOR
    5q75+BPPauJN9Z643rdEgccPel7Xa2MtscA/H4k7q0lfOh7mv7EaqNAzwakBaZNf
    VoQDRG/8mfCsr/NeGyNQN4K4bNWAuVgSSU7vjpamUtsKz0JzEhY+1VjvWFiWsIWk
    qlsVuuBqftWGQVVkUNGPXtH9If/q8G5BHglNSPGjq2DhrXc5p4oQCJdvuNCBdnZj
    YApttSpjyfdpHJcC4dYwWs2RU7NfYGhGtTwtHvVwbqAg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeBFQZX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 11:25:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:37962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbeBFQZW (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Feb 2018 11:25:22 -0500
Date: Tue, 6 Feb 2018 17:25:18 +0100
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
        Joshua Miller <joshmiller@fb.com>, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] FUSE: fix congested state leak on aborted connections
Message-ID: <20180206162518.tdoszuggqxpkrqvn@quack2.suse.cz>
References: <20180202175328.GL1121507@devbig577.frc2.facebook.com>
 <20180202175414.GM1121507@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202175414.GM1121507@devbig577.frc2.facebook.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 02-02-18 09:54:14, Tejun Heo wrote:
> If a connection gets aborted while congested, FUSE can leave
> nr_wb_congested[] stuck until reboot causing wait_iff_congested() to
> wait spuriously which can lead to severe performance degradation.
> 
> The leak is caused by gating congestion state clearing with
> fc->connected test in request_end().  This was added way back in 2009
> by 26c3679101db ("fuse: destroy bdi on umount").  While the commit
> description doesn't explain why the test was added, it most likely was
> to avoid dereferencing bdi after it got destroyed.
> 
> Since then, bdi lifetime rules have changed many times and now we're
> always guaranteed to have access to the bdi while the superblock is
> alive (fc->sb).
> 
> Drop fc->connected conditional to avoid leaking congestion states.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Joshua Miller <joshmiller@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jan Kara <jack@suse.cz>
> Cc: stable@vger.kernel.org

Yeah, this should be fine AFAICT but my knowledge of FUSE is very cursory.
Anyway:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fuse/dev.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -381,8 +381,7 @@ static void request_end(struct fuse_conn
>  		if (!fc->blocked && waitqueue_active(&fc->blocked_waitq))
>  			wake_up(&fc->blocked_waitq);
>  
> -		if (fc->num_background == fc->congestion_threshold &&
> -		    fc->connected && fc->sb) {
> +		if (fc->num_background == fc->congestion_threshold && fc->sb) {
>  			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_SYNC);
>  			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_ASYNC);
>  		}
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
